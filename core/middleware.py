from django.http import JsonResponse


class HealthCheckMiddleware:
    """
    Middleware que permite requisições de healthcheck sem validação de Host.
    Isso é necessário porque Railway's healthcheck probe pode enviar um Host header
    que não passa na validação do CommonMiddleware.
    """

    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        # Se for healthcheck, retorna direto sem passar pelos outros middlewares
        if request.path == "/health/":
            from django.views.decorators.csrf import csrf_exempt
            from core.urls import health_check
            return csrf_exempt(health_check)(request)

        return self.get_response(request)
