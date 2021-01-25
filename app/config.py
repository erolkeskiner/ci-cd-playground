class Config(object):
    DEBUG = False
    TESTING = False
    HEALTHZ = {
        "live": "app.routes.base_routes.liveness",
        "ready": "app.routes.base_routes.readiness",
    }


class ProductionConfig(Config):
    DEBUG = False


class DevelopmentConfig(Config):
    DEBUG = True


class TestingConfig(Config):
    TESTING = True
