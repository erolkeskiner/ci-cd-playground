class Config(object):
    DEBUG = False
    TESTING = False
    HEALTHZ = {
        "live": "app.liveness",
        "ready": "app.readiness",
    }


class ProductionConfig(Config):
    pass


class DevelopmentConfig(Config):
    DEBUG = True


class TestingConfig(Config):
    TESTING = True
