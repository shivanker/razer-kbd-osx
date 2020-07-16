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
    Logo = (0, 20)
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
    M1 = (1, 0)
    Backtick = (1, 1)
    One = (1, 2)
    Two = (1, 3)
    Three = (1, 4)
    Four = (1, 5)
    Five = (1, 6)
    Six = (1, 7)
    Seven = (1, 8)
    Eight = (1, 9)
    Nine = (1, 10)
    Zero = (1, 11)
    Minus = (1, 12)
    Equal = (1, 13)
    Backspace = (1, 14)
    Ins = (1, 15)
    Home = (1, 16)
    PgUp = (1, 17)
    NumLk = (1, 18)
    NPDiv = (1, 19)
    NPMul = (1, 20)
    NPMinus = (1, 21)
    M2 = (2, 0)
    Tab = (2, 1)
    Q = (2, 2)
    W = (2, 3)
    E = (2, 4)
    R = (2, 5)
    T = (2, 6)
    Y = (2, 7)
    U = (2, 8)
    I = (2, 9)
    O = (2, 10)
    P = (2, 11)
    LtBr = (2, 12)
    RtBr = (2, 13)
    BkSlash = (2, 14)
    Del = (2, 15)
    End = (2, 16)
    PgDn = (2, 17)
    NP7 = (2, 18)
    NP8 = (2, 19)
    NP9 = (2, 20)
    NPPlus = (2, 21)
    M3 = (3, 0)
    Caps = (3, 1)
    A = (3, 2)
    S = (3, 3)
    D = (3, 4)
    F = (3, 5)
    G = (3, 6)
    H = (3, 7)
    J = (3, 8)
    K = (3, 9)
    L = (3, 10)
    SemiColon = (3, 11)
    Quote = (3, 12)
    Return = (3, 14)
    NP4 = (3, 18)
    NP5 = (3, 19)
    NP6 = (3, 20)
    M4 = (4, 0)
    LtShift = (4, 1)
    Z = (4, 3)
    X = (4, 4)
    C = (4, 5)
    V = (4, 6)
    B = (4, 7)
    N = (4, 8)
    M = (4, 9)
    Comma = (4, 10)
    Period = (4, 11)
    FwdSlash = (4, 12)
    RtShift = (4, 14)
    Up = (4, 16)
    NP1 = (4, 18)
    NP2 = (4, 19)
    NP3 = (4, 20)
    NPRet = (4, 21)
    M5 = (5, 0)
    LtCtrl = (5, 1)
    Super = (5, 2)
    Alt = (5, 3)
    AltGR = (5, 11)
    Fn = (5, 12)
    Ctx = (5, 13)
    RtCtrl = (5, 14)
    Left = (5, 15)
    Down = (5, 16)
    Right = (5, 17)
    NP0 = (5, 19)
    NPDot = (5, 20)


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
