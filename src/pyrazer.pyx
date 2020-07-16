from libcpp cimport bool
from libc.stdint cimport uintptr_t

cdef extern from "razerlib.c":
  uintptr_t rzr_init()
  void rzr_close(uintptr_t dev)
  void rzr_info(uintptr_t dev)
  void rzr_set_spectrum(uintptr_t dev)
  void rzr_set_wave(uintptr_t dev, bool left)

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

  def wave(self, left = True):
    if not self.device:
      return
    rzr_set_wave(self.device, left)
