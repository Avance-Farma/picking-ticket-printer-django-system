from django.urls import path
from . import views

urlpatterns = [
    path("", views.index_view, name="index"),
    path("confirmar-volume/", views.confirmar_volume_view, name="confirmar_volume"),
    path("expedir/", views.expedir_pickings_view, name="expedir_pickings"),
    path("process/", views.process_volumes_view, name="process_volumes"),
    path("upload/", views.upload_excel_view, name="upload_excel"),
    path("upload/progress/", views.check_import_progress, name="check_import_progress"),
    path("qz/certificate/", views.qz_certificate, name="qz_certificate"),
    path("qz/sign/", views.qz_sign, name="qz_sign"),
]
