from libcpp cimport bool

cdef extern from "razerlib.c":
  void rzr_info()
  void rzr_set_spectrum()
  void rzr_set_wave(bool left)

def info():
  rzr_info()

def spectrum():
  rzr_set_spectrum()    

def wave(left):
  rzr_set_wave(left)
