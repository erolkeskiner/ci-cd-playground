import json
import logging.config

with open('logging-config.json') as conf_file:
    logging.config.dictConfig(json.load(conf_file))

