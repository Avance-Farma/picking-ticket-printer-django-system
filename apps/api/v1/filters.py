from datetime import date

from django.db.models import QuerySet


def apply_volume_filters(queryset: QuerySet, params: dict) -> QuerySet:
    """
    Aplica filtros manuais para a QuerySet de pedidos de volumes.
    """
    if status := params.get("status"):
        queryset = queryset.filter(status=status)
    
    if order_number := params.get("order_number"):
        queryset = queryset.filter(order_number__icontains=order_number)
    
    if picking := params.get("picking"):
        queryset = queryset.filter(picking__icontains=picking)

    # Filtros de intervalo de datas (created_at)
    date_from = params.get("date_from")
    date_to = params.get("date_to")

    if date_from:
        try:
            queryset = queryset.filter(
                created_at__date__gte=date.fromisoformat(date_from)
            )
        except ValueError:
            pass
            
    if date_to:
        try:
            queryset = queryset.filter(
                created_at__date__lte=date.fromisoformat(date_to)
            )
        except ValueError:
            pass

    # Filtros booleanos
    has_volumes = params.get("has_volumes")
    if has_volumes is not None:
        if has_volumes.lower() in ["true", "1", "yes"]:
            queryset = queryset.filter(total_volumes__gt=0)
        elif has_volumes.lower() in ["false", "0", "no"]:
            queryset = queryset.filter(total_volumes=0)

    return queryset
