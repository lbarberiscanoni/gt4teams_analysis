import requests
from pprint import pprint
import pickle
import json
import numpy as np
import csv



def pd():
	with open('pd.pickle', 'rb') as handle:
		b = pickle.load(handle)

	i = 0
	with open('pd.csv', 'w') as f:
		writer = csv.writer(f)

		idList = [""]
		for value in b:
			pprint(value)

			gameState = json.loads(value["gameState"])

			for roundNum in gameState:
				for turn in gameState[roundNum]:
					ob = {}
					outcome = gameState[roundNum][turn]
					print(outcome)

					ob["humanID"] = value["surveyID"]
					ob["opponent"] = value["model"] 
					ob["turn"] = turn

					if value["opponent"] == "Riley":
						ob["condition"] = "human"
					elif value["opponent"] == "AI": 
						ob["condition"] = "ai"

					if outcome == [0, 0]:
						ob["cooperation"] = 1
					elif outcome == [1, 0]:
						ob["cooperation"] = 2
					elif outcome == [0, 1]:
						ob["cooperation"] = 3
					elif outcome == [1, 1]:
						ob["cooperation"] = 4

					if i == 0:
						writer.writerow(ob.keys())
					writer.writerow(ob.values())
					i += 1

def bos():
	with open('bos.pickle', 'rb') as handle:
		b = pickle.load(handle)

	i = 0
	with open('bos.csv', 'w') as f:
		writer = csv.writer(f)

		idList = [""]
		for value in b:
			pprint(value)

			gameState = json.loads(value["gameState"])

			for roundNum in gameState:
				for turn in gameState[roundNum]:
					ob = {}
					outcome = gameState[roundNum][turn]
					print(outcome)

					ob["humanID"] = value["surveyID"]
					ob["opponent"] = value["model"] 
					ob["turn"] = turn

					if value["opponent"] == "Riley":
						ob["condition"] = "human"
					elif value["opponent"] == "AI": 
						ob["condition"] = "ai"

					if outcome == [0, 0]:
						ob["cooperation"] = 1
					elif outcome == [1, 0]:
						ob["cooperation"] = 2
					elif outcome == [0, 1]:
						ob["cooperation"] = 2
					elif outcome == [1, 1]:
						ob["cooperation"] = 1

					if i == 0:
						writer.writerow(ob.keys())
					writer.writerow(ob.values())
					i += 1

def hawkdove():
	with open('hawkdove.pickle', 'rb') as handle:
		b = pickle.load(handle)

	i = 0
	with open('hawkdove.csv', 'w') as f:
		writer = csv.writer(f)

		idList = [""]
		for value in b:
			pprint(value)

			gameState = json.loads(value["gameState"])

			for roundNum in gameState:
				for turn in gameState[roundNum]:
					ob = {}
					outcome = gameState[roundNum][turn]
					print(outcome)

					ob["humanID"] = value["surveyID"]
					ob["opponent"] = value["model"] 
					ob["turn"] = turn

					if value["opponent"] == "Riley":
						ob["condition"] = "human"
					elif value["opponent"] == "AI": 
						ob["condition"] = "ai"

					if outcome == [0, 0]:
						ob["cooperation"] = 1
					elif outcome == [1, 0]:
						ob["cooperation"] = 2
					elif outcome == [0, 1]:
						ob["cooperation"] = 3
					elif outcome == [1, 1]:
						ob["cooperation"] = 4

					if i == 0:
						writer.writerow(ob.keys())
					writer.writerow(ob.values())
					i += 1

hawkdove()