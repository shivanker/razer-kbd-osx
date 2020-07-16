import pyrazer
import time

from pyrazer import Key

kbd = pyrazer.RazerDevice()
kbd.wave()
time.sleep(0.5)
kbd.wave(False)
time.sleep(0.5)
kbd.custom()
time.sleep(0.5)
kbd.spectrum()

violet = 'ee82ee'
indigo = '4b0082'
blue = '0000ff'
green = '00ff00'
yellow = 'ffff00'
orange = 'ffa500'
red = 'ff0000'
grey = '101010'
white = 'ffffff'
cyan = '00ffff'
magenta = 'ff00ff'
gold = 'ffd700'
silver = 'c5ced4'
sage = '77815c'
pink = 'ffc0cb'
black = '000000'
lime = 'c7ea46'
emarald = '50c878'
neon = '39ff14'
ltgreen = '4cbb17'
bronze = '9c5221'
brown = '221108'

fire = [
  'fafa6e',
  'f9ec5f',
  'f8de50',
  'f6d042',
  'f4c235',
  'f2b328',
  'efa51d',
  'ec9612',
  'e98707',
  'e57802',
  'e16800',
  'dc5702',
  'd64506',
  'd1300b',
  'ca1010',
]

alphas = [
  Key.Q,
  Key.W,
  Key.E,
  Key.R,
  Key.T,
  Key.Y,
  Key.U,
  Key.I,
  Key.O,
  Key.P,
  Key.A,
  Key.S,
  Key.D,
  Key.F,
  Key.G,
  Key.H,
  Key.J,
  Key.K,
  Key.L,
  Key.Z,
  Key.X,
  Key.C,
  Key.V,
  Key.B,
  Key.N,
  Key.M,
]

nums = [
  Key.One,
  Key.Two,
  Key.Three,
  Key.Four,
  Key.Five,
  Key.Six,
  Key.Seven,
  Key.Eight,
  Key.Nine,
  Key.Zero,
]

ops = [
  Key.Backspace,
  Key.Tab,
  Key.BkSlash,
  Key.Caps,
  Key.Return,
  Key.LtShift,
  Key.RtShift,
  Key.LtCtrl,
  Key.Super,
  Key.Alt,
  Key.AltGR,
  Key.Fn,
  Key.Ctx,
  Key.RtCtrl,
]

sidepad = [
  Key.PrtSc,
  Key.ScrLk,
  Key.Pause,
  Key.Ins,
  Key.Home,
  Key.PgUp,
  Key.Del,
  Key.End,
  Key.PgDn,
]

numpad = [
  Key.NumLk,
  Key.NPDiv,
  Key.NPMul,
  Key.NPMinus,
  Key.NP7,
  Key.NP8,
  Key.NP9,
  Key.NPPlus,
  Key.NP4,
  Key.NP5,
  Key.NP6,
  Key.NP1,
  Key.NP2,
  Key.NP3,
  Key.NPRet,
  Key.NP0,
  Key.NPDot,
]

macros = [
  Key.M1,
  Key.M2,
  Key.M3,
  Key.M4,
  Key.M5,
]

fns = [
  Key.Esc,
  Key.F1,
  Key.F2,
  Key.F3,
  Key.F4,
  Key.F5,
  Key.F6,
  Key.F7,
  Key.F8,
  Key.F9,
  Key.F10,
  Key.F11,
  Key.F12,
]

symbols = [
  Key.Backtick,
  Key.Minus,
  Key.Equal,
  Key.LtBr,
  Key.RtBr,
  Key.SemiColon,
  Key.Quote,
  Key.Comma,
  Key.Period,
  Key.FwdSlash,
]

arrows = [
  Key.Up,
  Key.Left,
  Key.Down,
  Key.Right,
]

arrows_ext = arrows + [
  Key.W,
  Key.A,
  Key.S,
  Key.D,
]


print('Colorizing alphas...')
for key in alphas:
  kbd.custom_key(key, 'cc0600')

print('Colorizing nums..')
for idx in range(len(nums)):
  kbd.custom_key(nums[idx], fire[idx+3])

print('Colorizing functions..')
for idx in range(len(fns)):
  kbd.custom_key(fns[idx], fire[idx])

print('Colorizing sidepad.')
for key in sidepad:
  kbd.custom_key(key, fire[14])

print('Colorizing arrows.')
for key in arrows:
  kbd.custom_key(key, '0074cc')

print('Colorizing ops..')
for key in ops:
  kbd.custom_key(key, brown)

print('Colorizing symbols...')
for key in symbols:
  kbd.custom_key(key, 'c22d00')
