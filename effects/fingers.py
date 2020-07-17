import pyrazer
import time

from pyrazer import Key

kbd = pyrazer.RazerDevice()

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

arrows = [
  Key.Up,
  Key.Left,
  Key.Down,
  Key.Right,
]

section1 = [
  Key.Backtick,
  Key.One,
  Key.Tab,
  Key.Q,
  Key.Caps,
  Key.A,
  Key.LtShift,
  Key.Z,
  Key.LtCtrl,
  Key.Super
]

section2 = [
  Key.Two,
  Key.W,
  Key.S,
  Key.X,
]

section3 = [
  Key.Three,
  Key.E,
  Key.D,
  Key.C,
]

section4 = [
  Key.Four,
  Key.Five,
  Key.R,
  Key.T,
  Key.F,
  Key.G,
  Key.V,
  Key.B,
]

section5 = [
  Key.Six,
  Key.Seven,
  Key.Y,
  Key.U,
  Key.H,
  Key.J,
  Key.N,
  Key.M, 
]

section6 = [
  Key.Eight,
  Key.I,
  Key.K,
  Key.Comma
]

section7 = [
  Key.Nine,
  Key.O,
  Key.L,
  Key.Period
]

section8 = [
  Key.Zero,
  Key.Minus,
  Key.Equal,
  Key.Backspace,
  Key.P,
  Key.LtBr,
  Key.RtBr,
  Key.BkSlash,
  Key.SemiColon,
  Key.Quote,
  Key.Return,
  Key.FwdSlash,
  Key.RtShift,
  Key.Ctx,
  Key.RtCtrl
]

section0 = [
  Key.Alt,
  Key.AltGR
]


print('Colorizing functions..')
for idx in range(len(fns)):
  kbd.custom_key(fns[idx], fire[idx])

print('Colorizing sidepad.')
for key in sidepad:
  kbd.custom_key(key, fire[14])

print('Colorizing arrows.')
for key in arrows:
  kbd.custom_key(key, '0074cc')

print('Colorizing fingers..')
for key in section0:
  kbd.custom_key(key, violet)
for key in section1+section8:
  kbd.custom_key(key, 'ff0500')
for key in section2+section7:
  kbd.custom_key(key, green)
for key in section3+section6:
  kbd.custom_key(key, yellow)
for key in section4:
  kbd.custom_key(key, cyan)
for key in section5:
  kbd.custom_key(key, indigo)
