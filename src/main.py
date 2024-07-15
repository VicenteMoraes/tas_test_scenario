from tas import Tas
from logger import RuntimeLogger

if __name__ == '__main__':
    tas = Tas()
    tas.provide_health_support()
    logger = RuntimeLogger.tas_logger()
    logger.read_logs()
    logger.edit_prism_model('edge.mp')
    pass