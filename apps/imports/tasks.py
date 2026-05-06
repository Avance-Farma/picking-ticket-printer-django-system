import json
import logging
import os
import tempfile

from celery import chord, shared_task
from django.db import IntegrityError
from django.db.models import F

from apps.imports.models import ImportBatch
from apps.imports.services.db_importer import DatabaseImporter
from apps.imports.services.file_processors import ProcessingError
from apps.imports.services.processor_factory import ProcessorFactory

logger = logging.getLogger(__name__)


def process_single_file(path, filename, errors):
    try:
        processor = ProcessorFactory.get_processor(filename)
        order_data = processor.read(path)

        if not order_data.get("products"):
            errors.append(f"{filename}: No items found.")
        else:
            DatabaseImporter.save_complete_order(order_data)

    except ProcessingError as e:
        errors.append(f"{filename}: {str(e)}")
    except IntegrityError as e:
        logger.exception("IntegrityError processing %s", filename)
        errors.append(f"{filename}: Database integrity error ({e}).")
    except Exception as e:
        logger.exception("Unexpected error processing %s", filename)
        errors.append(f"{filename}: Unexpected failure: {str(e)}")
    finally:
        if os.path.exists(path):
            try:
                os.remove(path)
            except OSError:
                pass


@shared_task
def process_single_file_task(batch_id, file_content, filename):
    errors = []

    _, ext = os.path.splitext(filename)
    tmp_path = None
    try:
        with tempfile.NamedTemporaryFile(
            suffix=ext, delete=False, dir="/tmp"
        ) as tmp:
            tmp.write(file_content if isinstance(file_content, bytes) else bytes(file_content))
            tmp_path = tmp.name

        process_single_file(tmp_path, filename, errors)
    except Exception as e:
        logger.exception("Failed to write temp file for %s", filename)
        errors.append(f"{filename}: Unexpected failure: {str(e)}")
    finally:
        if tmp_path and os.path.exists(tmp_path):
            try:
                os.remove(tmp_path)
            except OSError:
                pass

    ImportBatch.objects.filter(id=batch_id).update(
        processed_files=F("processed_files") + 1
    )

    if errors:
        return errors[0]
    return None


@shared_task
def finalize_import_batch_task(results, batch_id):
    errors = [res for res in results if res is not None]

    batch = ImportBatch.objects.get(id=batch_id)
    batch.status = "completed" if not errors else "error"
    if errors:
        batch.errors = json.dumps(errors)
    batch.save(update_fields=["status", "errors"])


@shared_task
def process_import_batch_task(batch_id, file_payloads):
    if not file_payloads:
        finalize_import_batch_task([], batch_id)
        return

    tasks = [
        process_single_file_task.s(batch_id, file_content, filename)
        for file_content, filename in file_payloads
    ]
    callback = finalize_import_batch_task.s(batch_id)
    chord(tasks)(callback)
