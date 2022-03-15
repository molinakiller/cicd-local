import logging, coloredlogs
logger=logging.getLogger(__name__)
coloredlogs.install(level='DEBUG',logger=logger)
logger.debug("Hola keepcooders")


def add_one(number):
    return number+1

print(add_one(3))

#def add_two(number):
#    return number+2

