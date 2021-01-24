# from flask_healthz import HealthError


# liveness and readiness functions may be developed in the future.
# Ex: testing any interaction with different component such as database
def liveness():
    return True


def readiness():
    return True
