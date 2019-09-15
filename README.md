# osx-razer-blade
Command-line application to control lights on Razer Blade that are running a Hackintosh (macOS on a non-Apple device). Successfully tested so far on a Razer Blade Stealth (Late 2017). The driver should work with older and new Razer laptops as well. It supports various effects on the keyboard and the ability to turn the monitor Razer logo on and off.

This simple application builds on the porting work by @kprinssu and their https://github.com/kprinssu/osx-razer-blade project. The Razer driver was adapted from the Linux project, https://github.com/terrycain/razer-drivers/.

Only the Xcode command-line tools are needed to build and run this project. Install Xcode command-line tools by running:

    xcode-select --install

Usage:

1. Clone the repo
2. Build the project by typing `make`
3. Run the `osx-razer-led` program to get the effect you want.

Currently supported effects:

```
> ./razer-led

 Usage: razer-led <command>
 
 Where <command> is one of:
 
    red        - solid red  
    green      - solid green  
    blue       - solid blue
    white      - solid white
    breathe1   - throb keyboard with random colours
    breathe2   - throb keyboard with green colour
    breathe3   - throb keyboard with blue+red colours
    starlight  - keys randomly light up and fade
    reactive   - keys react to your typing
    spectrum   - cycle through a spectrum of colours
    wave_left  - wave of colours moving left
    wave_right - wave of colours moving right
    logo_on    - Turn the Razer logo on
    logo_off   - Turn the Razer logo off
```


This project unless otherwise stated in the file is licensed under the GPLv2 license.
