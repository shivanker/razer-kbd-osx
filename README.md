# razer-kbd-osx
Command-line application for MacOS to control lights on Razer keyboards. Supports various effects on the keyboard.
Also exposes a python API for devs to go crazy. See example.py for sample usage.

### Prerequisites

1. Xcode command-line tools (`$ xcode-select --install`)
2. Cython (`$ pip3 install cython`)

### Usage

1. Clone the repo
2. Build the project by typing `make`
3. Run the `razer-kbd-osx` program to get the effect you want.

### Currently supported effects

```
usage: razer-kbd-osx <command> [options]
Where <command> is one of:

   info                        # Display some keyboard information.

   static                      # All keys green (default)
   static {red|blue|white}     # All keys to a preset colour
   static <R G B>              # All keys to a custom colour

   breathe                     # Throb with random colours
   breathe <R G B>             # Throb with a custom single colour
   breathe <R G B> <R G B>     # Throb with two custom colours

   starlight                   # Twinkling green stars
   starlight <speed>           # Set twinkle speed: 1,2,3
   starlight <speed> <R G B>   # Custom twinkle speed and colour.

   reactive                    # Keys light green and fade when typed.
   reactive <speed> <R G B>    # Custom react speed and colour.

   spectrum                    # Keys cycle through colour spectrum.

   wave {left|right}           # Spectrum coloured wave.

   logo                        # Display the current logo state.
   logo {off|on}               # Turn the back logo off or on.

   fnkey {off|on}              # Use 'fn' key to access F1-F12 keys.

   brightness                  # Display the current brightness value.
   brightness <value>          # Sets the brightness to value: 0 - 255
   brightness {up|down}        # Increases or decreases the brightness

Note: <R G B> custom colours are specified with three numbers representing
RED, GREEN and BLUE. Each number ranges from 0 (0%) to 255 (100%).

   eg. razer-kbd-osx static 255 100 50
   eg. razer-kbd-osx breathe 255 0 0 0 0 255
   eg. razer-kbd-osx starlight 1 255 255 255

Note: <speed> values range from 1 to 3. 1 is fast, 3 is slow.
```


This project unless otherwise stated in the file is licensed under the GPLv2 license.

## Credits

Builds on work done by these projects:

* [openrazer](https://github.com/openrazer/openrazer)
* [osx-razer-blade](https://github.com/kprinssu/osx-razer-blade)
* [osx-razer-led](https://github.com/dylanparker/osx-razer-led)
* [razer-macos](https://github.com/1kc/razer-macos)
