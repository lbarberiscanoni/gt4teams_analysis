import requests
from pprint import pprint
import pickle
import json
import numpy as np
import csv

def downloadData():

	r = requests.get("https://lorenzo.pagekite.me/games/pull")
	print(r.text)
	data = r.json()

	with open('allData.pickle', 'wb') as handle:
	    pickle.dump(data, handle)
	    print("success")

def hawkdove():
	with open('filename.pickle', 'rb') as handle:
	    b = pickle.load(handle)

	i = 0
	with open('hawkdove.csv', 'w') as f:
		writer = csv.writer(f)

		idList = [""]
		for key, value in b.items():
			ob = {}

			ob["humanID"] = value["surveyID"]

			if (ob["humanID"] not in idList) and (value["game_type"] != "bos"):

				idList.append(ob["humanID"])

				ob["opponent"] = value["model"] 

				if value["opponent"] == "Riley":
					ob["condition"] = "human"
				elif value["opponent"] == "AI": 
					ob["condition"] = "ai"


				ob["game"] = value["game_type"]

				gameState = json.loads(value["gameState"])

				ob["human_attack_freq_A"] = 0
				ob["AI_attack_freq_A"] = 0
				ob["human_peace_freq_A"] = 0
				ob["AI_peace_freq_A"] = 0

				ob["human_attack_freq_B"] = 0
				ob["AI_attack_freq_B"] = 0
				ob["human_peace_freq_B"] = 0
				ob["AI_peace_freq_B"] = 0

				ob["human_attack_freq_C"] = 0
				ob["AI_attack_freq_C"] = 0
				ob["human_peace_freq_C"] = 0
				ob["AI_peace_freq_C"] = 0

				ob["mutual_attack_A"] = 0
				ob["human_victory_A"] = 0
				ob["AI_victory_A"] = 0
				ob["mutual_peace_A"] = 0

				ob["mutual_attack_B"] = 0
				ob["human_victory_B"] = 0
				ob["AI_victory_B"] = 0
				ob["mutual_peace_B"] = 0

				ob["mutual_attack_C"] = 0
				ob["human_victory_C"] = 0
				ob["AI_victory_C"] = 0
				ob["mutual_peace_C"] = 0

				turns = ["A", "B", "C"]

				for turn, history in gameState.items():
					moves = history.values()
					for move in moves:
						move_human = move[0]
						if move_human == 0:
							ob["human_attack_freq_" + turns[int(turn)]] += 1
						else:
							ob["human_peace_freq_" + turns[int(turn)]] += 1

						move_AI = move[1]
						if move_human == 0:
							ob["AI_attack_freq_" + turns[int(turn)]] += 1
						else:
							ob["AI_peace_freq_" + turns[int(turn)]] += 1

						if move_human == 0:
							if move_AI == 0:
								ob["mutual_attack_" + turns[int(turn)]] += 1
							elif move_AI == 1:
								ob["human_victory_" + turns[int(turn)]] += 1
						elif move_human == 1:
							if move_AI == 0:
								ob["AI_victory_" + turns[int(turn)]] += 1
							elif move_AI == 1:
								ob["mutual_peace_" + turns[int(turn)]] += 1

				ob["human_attack_cum"] = ob["human_attack_freq_A"] + ob["human_attack_freq_B"] + ob["human_attack_freq_C"]
				ob["AI_attack_cum"] = ob["AI_attack_freq_A"] + ob["AI_attack_freq_B"] + ob["AI_attack_freq_C"]
				ob["human_peace_cum"] = ob["human_peace_freq_A"] + ob["human_peace_freq_B"] + 	ob["human_peace_freq_C"]
				ob["AI_peace_cum"] = ob["AI_peace_freq_A"] + ob["AI_peace_freq_B"] + ob["AI_peace_freq_C"]

				ob["human_attack_average"] = np.mean([ob["human_attack_freq_A"], ob["human_attack_freq_B"], ob["human_attack_freq_C"]])
				ob["AI_attack_average"] = np.mean([ob["AI_attack_freq_A"], ob["AI_attack_freq_B"], ob["AI_attack_freq_C"]])
				ob["human_peace_average"] = np.mean([ob["human_peace_freq_A"], ob["human_peace_freq_B"], ob["human_peace_freq_C"]])
				ob["AI_peace_average"] = np.mean([ob["AI_peace_freq_A"], ob["AI_peace_freq_B"], ob["AI_peace_freq_C"]])

				ob["mutual_attack_cum"] = ob["mutual_attack_A"] + ob["mutual_attack_B"] + ob["mutual_attack_C"]
				ob["human_victory_cum"] = ob["human_victory_A"] + ob["human_victory_B"] + ob["human_victory_C"]
				ob["AI_victory_cum"] = ob["AI_victory_A"] + ob["AI_victory_B"] + ob["AI_victory_C"]
				ob["mutual_peace_cum"] = ob["mutual_peace_A"] + ob["mutual_peace_B"] + ob["mutual_peace_C"]

				ob["mutual_attack_average"] = np.mean([ob["mutual_attack_A"], ob["mutual_attack_B"], ob["mutual_attack_C"]])
				ob["human_victory_average"] = np.mean([ob["human_victory_A"], ob["human_victory_B"], ob["human_victory_C"]])
				ob["AI_victory_average"] = np.mean([ob["AI_victory_A"], ob["AI_victory_B"], ob["AI_victory_C"]])
				ob["mutual_peace_average"] = np.mean([ob["mutual_peace_A"], ob["mutual_peace_B"], ob["mutual_peace_C"]])

				if i == 0:
					writer.writerow(ob.keys())
				writer.writerow(ob.values())
				i += 1


downloadData()