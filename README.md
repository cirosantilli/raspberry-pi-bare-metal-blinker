# Raspberry Pi Bare Metal Blinker

Create a bare metal hello world blinker image that blinks the OK LED. Tested on Ubuntu 16.04 host, Raspberry Pi 2. Usage:

1.  Insert SD card on host

1.  Make the image:

        ./make.sh /dev/mmblck0 p1

    Where:

    - `/dev/mmblck0` is the device of the SD card
    - `p1` is the first partition of the device (`/dev/mmblck0p1`)

1.  Inset SD card on PI

1.  Turn power off and on

![demo.gif](demo.gif)

There are many comprehensive bare metal resources out there, but it was hard to get the first example working.

Making the first hello world easy is the only goal of this tutorial.

Adapted from: <https://github.com/dwelch67/raspberrypi>
