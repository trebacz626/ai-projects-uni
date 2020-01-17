from GameRunner import Game
from orders_generation import *
import matplotlib.pyplot as plt
import json

   
def conduct_test(test,visualise,should_stow=True,stowing_mean=5.0):
  print("Starting test: "+test[0])
  STEPS=[]
  for i in range(ITERATIONS):
    print("Iteration: "+str(i+1)+"/"+str(ITERATIONS))
    game = Game(test[1](),visualise,stowing_mean)
    STEPS.append(game.play(should_stow))
  plt.hist(STEPS,density=True)
  plt.title('Mean: '+str(sum(STEPS)/len(STEPS)))
  plt.savefig(test[0]+".png")
  plt.clf()
  return STEPS

ITERATIONS=100
VISUALISE=False

tests = [   
["RANDOM",random_order],
["BACK TO FRONT",back_to_front],
["FRONT TO BACK",front_to_back],
["BACK TO FRONT GROUP 4",back_to_front_4],
["FRONT TO BACK GROUP 4",front_to_back_4],
["WINDOW MIDDLE ISLE",window_middle_isle],
["STEFFEN PERFECT",steffen_perfect],
["STEFFEN MODIFIED",steffen_modified]]

basicTestHistogramData =[]

for test in tests:
  basicTestHistogramData.append(conduct_test(test,VISUALISE))


with open('distribution_chart_data.txt', 'w') as outfile:
    json.dump(basicTestHistogramData, outfile)


no_stowing_tests = [["RANDOM NO STOWING",random_order],
["BACK TO FRONT 4 GROUPS NO STOWING",back_to_front_4]]

for test in no_stowing_tests:
  data = conduct_test(test,VISUALISE,False)
  with open(test[0]+'.txt', 'w') as outfile:
    json.dump(data, outfile)

no_shuffling_tests = [["RANDOM NO SHUFFLE",random_without_shuffle],
["BACK TO FRONT 4 GROUPS NO SHUFFLE",back_to_front_4_without_shuffle]]

for mean in range(1,5):
    random_n_s = no_shuffling_tests[0].copy()
    random_n_s[0]=random_n_s[0]+" "+str(mean)
    data1=conduct_test(random_n_s,VISUALISE,True,mean)
    with open(random_n_s[0]+'.txt', 'w') as outfile:
        json.dump(data1, outfile)
    btf4_n_s = no_shuffling_tests[1].copy()
    btf4_n_s[0]=btf4_n_s[0]+" "+str(mean)
    data2=conduct_test(btf4_n_s,VISUALISE,True,mean)
    with open(btf4_n_s[0]+'.txt', 'w') as outfile:
        json.dump(data2, outfile)
