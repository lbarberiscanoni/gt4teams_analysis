import csv
from pprint import pprint

survey_data = {}
i = 0
keys = []
with open('survey_structured.csv', 'r') as infile:
	survey = csv.reader(infile)
	for row in survey:
		ob = {}
		if i < 1:
			keys = row
		else:
			for x in range(len(keys)):
				ob[str(keys[x])] = row[x]
			survey_data[ob["code"]] = ob
		i += 1
		
hd_data = {}
i = 0
keys = []
with open('hawkdove.csv', 'r') as f:
	hawkdove = csv.reader(f)

	with open('hfml.csv', 'w') as af:
		writer = csv.writer(af)

		for row in hawkdove:
			ob = {}
			if i < 1:
				keys = row
			else:
				for x in range(len(keys)):
					ob[str(keys[x])] = row[x]
				if ob["humanID"] in survey_data.keys():
					ob.update(survey_data[ob["humanID"]])

			if i == 1:
				writer.writerow(ob.keys())
			else:
				writer.writerow(ob.values())

			i += 1