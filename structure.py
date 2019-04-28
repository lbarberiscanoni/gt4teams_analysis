import csv
from pprint import pprint

with open('survey.csv', mode='r') as infile:
	reader = csv.reader(infile)

	mydict = {}

	i = 0
	keys = []
	with open('survey_structured.csv', 'w') as f:
		writer = csv.writer(f)
		for row in reader:
			if i < 1:
				keys = row
			else:
				ob = {}
				for x in range(len(keys)):
					ob[str(keys[x])] = row[x]
				try:
					thingsToRemove = ['StartDate', 'EndDate', 'Status', 'IPAddress', 'Progress', 'Finished', 'RecordedDate', 'ResponseId', 'RecipientLastName', 'RecipientFirstName', 'RecipientEmail', 'ExternalReference', 'LocationLatitude', 'LocationLongitude', 'DistributionChannel', 'UserLanguage', "Q30 - Topics"]
					for thing in thingsToRemove:
						ob.pop(thing)
					
					ob["duration"] = ob.pop("Duration (in seconds)")
					ob["code"] = ob.pop("Q1")
					ob["MCA"] = ob.pop("Q36")
					ob["mental_demand"] = ob.pop("Q2")
					ob["physical_demand"] = ob.pop("Q3")
					ob["pace"] = ob.pop("Q4")
					ob["success"] = ob.pop("Q5")
					ob["MCB"] = ob.pop("Q35")
					ob["effort"] = ob.pop("Q6")
					ob["negative_feelings"] = ob.pop("Q7")
					ob["AI_optimism"] = ob.pop("Q9")
					ob["AI_experience"] = ob.pop("Q10")
					ob["tech_relationship"] = ob.pop("Q11")
					ob["MCC"] = ob.pop("Q37")
					ob["human_preference"] = ob.pop("Q13")
					ob["shared_understanding"] = ob.pop("Q16")
					ob["cooperative_intention"] = ob.pop("Q17")
					ob["cooperative_perception"] = ob.pop("Q18")
					ob["cooperative_mutual"] = ob.pop("Q19")
					ob["MCD"] = ob.pop("Q38")
					ob["effectiveness"] = ob.pop("Q20")
					ob["improvement"] = ob.pop("Q21")
					ob["satisfaction_self"] = ob.pop("Q22")
					ob["satisfaction_team"] = ob.pop("Q23")
					ob["rework"] = ob.pop("Q24")
					ob["leadership"] = ob.pop("Q25")
					ob["trust"] = ob.pop("Q26")
					ob["aggression_self"] = ob.pop("Q27")
					ob["aggression_team"] = ob.pop("Q28")
					ob["communication"] = ob.pop("Q29")
					ob["feedback"] = ob.pop("Q30")
					ob["age"] = ob.pop("Q31")
					ob["race"] = ob.pop("Q32")
					ob["gender"] = ob.pop("Q33")
					ob["MCE"] = ob.pop("Q39")
					ob["education"] = ob.pop("Q34")

					normalizedValues = {
						"Strongly disagree": -2,
						"Somewhat disagree": -1,
						"Neither agree nor disagree": 0,
						"Somewhat agree": 1,
						"Strongly agree": 2,
						"Very Low 1": -2, 
						"Below Average 2": -1,
						"Average 3": 0,
						"Above Average 4": 1,
						"Very High 5": 2,
						"Very Low \n1": -2,
						"Very Low  \n1": -2, 
						"Below Average \n2": -1,
						"Average \n3": 0,
						"Above Average \n4": 1,
						"Very High \n5": 2,
						"Very High  5": 2
					}

					for key in ob:
						if ob[key] in normalizedValues.keys():
							ob[key] = normalizedValues[ob[key]]

					if i < 3:
						print(ob.values())
					elif i == 3:
						writer.writerow(ob.keys())
					else:
						writer.writerow(ob.values())

				except Exception as e:
					print("error", e)
			i += 1