class ERPSyncError(Exception):
    """Exceção levantada quando há falha de comunicação ou sincronização com o ERP."""
    pass


class ERPValidationError(ERPSyncError):
    """
    Exceção levantada quando a resposta do ERP falha na validação.
    Indica que o ERP respondeu, mas com dados inválidos ou inconsistentes.
    """
    pass
