from libcpp cimport bool
from libc.stdint cimport uintptr_t
from enum import Enum

cdef extern from "razerlib.c":
  uintptr_t rzr_init()
  void rzr_close(uintptr_t dev)
  void rzr_info(uintptr_t dev)
  void rzr_set_spectrum(uintptr_t dev)
  void rzr_set_wave(uintptr_t dev, bool left)
  void rzr_enable_custom(uintptr_t ptr)
  void rzr_set_key_custom(uintptr_t ptr, unsigned char row, unsigned char col, 
                          unsigned char r, unsigned char g, unsigned char b)


class Key(Enum):
    Esc = (0, 1)
    F1 = (0, 3)
    F2 = (0, 4)
    F3 = (0, 5)
    F4 = (0, 6)
    F5 = (0, 7)
    F6 = (0, 8)
    F7 = (0, 9)
    F8 = (0, 10)
    F9 = (0, 11)
    F10 = (0, 12)
    F11 = (0, 13)
    F12 = (0, 14)
    PrtSc = (0, 15)
    ScrLk = (0, 16)
    Pause = (0, 17)


class RazerDevice:
    def __init__(self):
        self.device = rzr_init()

    def __del__(self):
        self.close()

    def close(self):
        if not self.device:
            return
        rzr_close(self.device)
        self.device = 0

    def refresh(self):
        self.close()
        self.__init__()

    def info(self):
        if not self.device:
            return
        rzr_info(self.device)

    def spectrum(self):
        if not self.device:
            return
        rzr_set_spectrum(self.device)

    def wave(self, left=True):
        if not self.device:
            return
        rzr_set_wave(self.device, left)

    def enable_custom(self):
        rzr_enable_custom(self.device)

    def custom_key(self, key, color):
        if not self.device:
            return
        if not isinstance(key, Key):
            print('Invalid key code.')
            return
        if len(color) != 6:
            print('Invalid color.')
            return

        row = key.value[0]
        col = key.value[1]
        r = int(color[0:2], 16)
        g = int(color[2:4], 16)
        b = int(color[4:6], 16)
        rzr_set_key_custom(self.device, row, col, r, g, b)
        self.enable_custom()
