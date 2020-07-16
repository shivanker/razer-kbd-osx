import pyrazer
import time

from pyrazer import Key

kbd = pyrazer.RazerDevice()
kbd.wave()
time.sleep(0.5)
kbd.wave(False)
time.sleep(0.5)
kbd.enable_custom()
time.sleep(0.5)
kbd.spectrum()
