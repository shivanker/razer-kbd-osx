import pyrazer
import random
import time

from pyrazer import Key

kbd = pyrazer.RazerDevice()

fire = [
  '201613',
  '460900',
  '950e05',
  'e12e0f',
  'e95610',
  'ffa207',
  'ffec3c',
  'ff9210',
]

keys = []
for row in range(0, 6):
  keys.append([])
  for col in range(0, 18):
    keys[row].append(fire[0])

while True:
  time.sleep(0.005)
  row = random.randint(0, 5)
  col = random.randint(1, 17)
  color = fire[int(random.betavariate(row+2.5, 7.5-row) * len(fire))]
  keys[row][col] = color
  kbd.custom_key((row, col), color)

