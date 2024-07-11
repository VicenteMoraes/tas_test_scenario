from random import random


class Tas:
    def __init__(self):
        self.p_is_automated = 0.9
        self.p_vital_params = 0.7
        self.p_drug_service = 0.5
        self.p_monitor_service = 0.1
        self.p_alarm_service = 0.5

    def send_alarm(self):
        if random() < self.p_alarm_service:
            print("Standard Alarm is triggered")
        else:
            print("Emergency Alarm is triggered")
        return True

    def provide_health_support(self):
        print("Started TAS Service")
        if random() < self.p_is_automated:
            return self.provide_automated_health_support()
        return self.provide_self_diagnosed_support()

    def provide_self_diagnosed_support(self):
        print("Providing Self Diagnosed Health Support")
        return self.send_alarm()

    def provide_automated_health_support(self):
        print("Providing Automated Health Support")
        return self.get_vital_params() and self.analyse_data() and self.enact_treatment()

    def get_vital_params(self):
        if random() < self.p_vital_params:
            print("Received full params")
        else:
            print("Received partial params")
        return True

    def analyse_data(self):
        print("Analysing data")
        return True

    def enact_treatment(self):
        print("Enacting Treatment")
        return self.administer_medicine() or self.send_alarm()

    def administer_medicine(self):
        print("Administer Medicine")
        return self.drug_service() and self.monitor_side_effects()

    def drug_service(self):
        print("System entered drug service")
        if random() < self.p_drug_service:
            print("System decided to change drug")
        else:
            print("System decided to change dosage")

        return True

    def monitor_side_effects(self):
        print("System monitoring side effects")
        if random() < self.p_monitor_service:
            print("System failed to reach monitor service")
            return False

        print("System monitored side effects")
        if random() < 0.3:
            print("Detected negative side effects")
            return False

        print("Detected no side effects")
        return True