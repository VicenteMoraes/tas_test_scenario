class RuntimeLogger:
    def __init__(self, adaptability: dict, h: float, goals: list, goal_tags: dict):
        self.goals = goals
        self.goal_tags = goal_tags

        self.adaptability = adaptability
        self.h = h

    @classmethod
    def tas_logger(cls):
        h = 0.1
        initial_adaptability = 0.5
        goals = ["G4a", "G4b", "G5", "G9a", "G9b", "G10a", "G10b", "G12a", "G12b", "G8a", "G8b"]
        goal_tags = {"vital_params_full": "G4a", "vital_params_partial": "G4b", "analyse_data": "G5",
                     "drug_service_change_drug": "G9a", "drug_service_change_dose": "G9b",
                     "monitor_service": "G10a", "monitor_service_retry": "10b", "standard_alarm": ["G12a", "G8a"],
                     "emergency_alarm": ["G12b", "G8b"]}
        adaptability = {goal: initial_adaptability for goal in goals}
        return RuntimeLogger(adaptability, h, goals, goal_tags)

    def clip_adaptability(self, goal):
        if self.adaptability[goal] > 1:
            self.adaptability[goal] = 1
        if self.adaptability[goal] < 0:
            self.adaptability[goal] = 0

    def read_logs(self):
        with open("tas.log", "r") as rf:
            logs = rf.readlines()
            for line in logs:
                try:
                    splt = line.split(" - ")
                    tag = splt[1]
                    result = 0
                    match splt[2]:
                        case "SUCCESS":
                            result = 1
                        case "FAILURE":
                            result = -1
                        case _:
                            pass

                    goal = self.goal_tags[tag]
                    try:
                        self.adaptability[goal] += self.h*result
                        self.clip_adaptability(goal)
                    except TypeError:
                        for g in goal:
                            self.adaptability[g] += self.h*result
                            self.clip_adaptability(g)
                except KeyError:
                    pass

    def write_prism_model(self):
        # TODO
        pass