# Garmin Epoch Time

A minimalist, elegant, nerdy, typography-focused Garmin Connect IQ watch face that displays the Unix time (seconds elpased since 00:00:00 UTC on 1 January 1970, _the Unix epoch_).

![Epoch Time](resources/graphics/EpochTimeHero-small.png)

Available from [Garmin Connect IQ Developer portal](https://apps.garmin.com/apps/{blank:app-id}) or through the Connect IQ mobile app.

> **Note**  
> Epoch Time is part of a [collection of unconventional Garmin watch faces](https://github.com/wkusnierczyk/garmin-watch-faces). It has been developed for fun, as a proof of concept, and as a learning experience.
> It is shared _as is_ as an open source project, with no commitment to long term maintenance and further feature development.
>
> Please use [issues](https://github.com/wkusnierczyk/garmin-epoch-time/issues) to provide bug reports or feature requests.  
> Please use [discussions](https://github.com/wkusnierczyk/garmin-epoch-time/discussions) for any other comments.
>
> All feedback is wholeheartedly welcome.

## Contents

* [Epoch time](#epoch-time)
* [Features](#features)
* [Fonts](#fonts)
* [Build, test, deploy](#build-test-deploy)

## Epoch time

_"Unix time is a date and time representation widely used in computing. It measures time by the number of non-leap seconds that have elapsed since 00:00:00 UTC on 1 January 1970, the Unix epoch. For example, at midnight on 1 January 2010, Unix time was 1262304000._

_Unix time originated as the system time of Unix operating systems. It has come to be widely used in other computer operating systems, file systems, programming languages, and databases. In modern computing, values are sometimes stored with higher granularity, such as microseconds or nanoseconds."_

-- [Wikipedia](https://en.wikipedia.org/wiki/Unix_time)

## Features

The Epoch Time watch face supports the following features:

|Screenshot|Description|
|-|:-|
|![](resources/graphics/EpochTime.png)|**Unix Time**<br/> Seconds since Epoch displayed in the center of the screen.|
||**Current date and time**<br/> Current date and local time displayed under the Unix time.|

## Fonts

The Epoch Time watch face uses custom fonts:

* [SUSEMono Regular](https://fonts.google.com/specimen/SUSE+Mono?query=suse+mono) for both Unix time and current date and time.

> The development of Garmin watch faces motivated the implementation of two useful tools:
> * A TTF to FNT+PNG converter ([`ttf2bmp`](https://github.com/wkusnierczyk/ttf2bmp)).  
> Garmin watches use non-scalable fixed-size bitmap fonts, and cannot handle variable size True Type fonts directly.
> * An font scaler automation tool ([`garmin-font-scaler`](https://github.com/wkusnierczyk/garmin-font-scaler)).  
> Garmin watches come in a variety of shapes and resolutions, and bitmap fonts need to be scaled for each device proportionally to its resolution.

The font development proceeded as follows:

* The fonts were downloaded from [Google Fonts](https://fonts.google.com/) as True Type  (`.ttf`) fonts.
* The fonts were converted to bitmaps as `.fnt` and `.png` pairs using the open source command-line [`ttf2bmp`](https://github.com/wkusnierczyk/ttf2bmp) converter.
* The font sizes were established to match the Garmin Fenix 7X Solar watch 280x280 pixel screen resolution.
* The fonts were then scaled proportionally to match other screen sizes available on Garmin watches using the [`garmin-font-scaler`](https://github.com/wkusnierczyk/garmin-font-scaler) tool.


The table below lists all font sizes provided for the supported screen resolutions.

| Resolution |    Shape     | Element |       Font       | Size |
| ---------: | :----------- | :------ | :--------------- | ---: |
|  148 x 205 | rectangle    | Command | SUSEMono light   |    6 |
|  148 x 205 | rectangle    | Epoch   | SUSEMono regular |   20 |
|  176 x 176 | semi-octagon | Command | SUSEMono light   |    7 |
|  176 x 176 | semi-octagon | Epoch   | SUSEMono regular |   23 |
|  215 x 180 | semi-round   | Command | SUSEMono light   |    8 |
|  215 x 180 | semi-round   | Epoch   | SUSEMono regular |   24 |
|  218 x 218 | round        | Command | SUSEMono light   |    9 |
|  218 x 218 | round        | Epoch   | SUSEMono regular |   29 |
|  240 x 240 | round        | Command | SUSEMono light   |   10 |
|  240 x 240 | rectangle    | Command | SUSEMono light   |   10 |
|  240 x 240 | round        | Epoch   | SUSEMono regular |   32 |
|  240 x 240 | rectangle    | Epoch   | SUSEMono regular |   32 |
|  260 x 260 | round        | Command | SUSEMono light   |   11 |
|  260 x 260 | round        | Epoch   | SUSEMono regular |   34 |
|  280 x 280 | round        | Command | SUSEMono light   |   12 |
|  280 x 280 | round        | Epoch   | SUSEMono regular |   37 |
|  320 x 360 | rectangle    | Command | SUSEMono light   |   13 |
|  320 x 360 | rectangle    | Epoch   | SUSEMono regular |   42 |
|  360 x 360 | round        | Command | SUSEMono light   |   15 |
|  360 x 360 | round        | Epoch   | SUSEMono regular |   48 |
|  390 x 390 | round        | Command | SUSEMono light   |   16 |
|  390 x 390 | round        | Epoch   | SUSEMono regular |   52 |
|  416 x 416 | round        | Command | SUSEMono light   |   17 |
|  416 x 416 | round        | Epoch   | SUSEMono regular |   55 |
|  454 x 454 | round        | Command | SUSEMono light   |   19 |
|  454 x 454 | round        | Epoch   | SUSEMono regular |   60 |

## Build, test, deploy

To modify and build the sources, you need to have installed:

* [Visual Studio Code](https://code.visualstudio.com/) with [Monkey C extension](https://developer.garmin.com/connect-iq/reference-guides/visual-studio-code-extension/).
* [Garmin Connect IQ SDK](https://developer.garmin.com/connect-iq/sdk/).

Consult [Monkey C Visual Studio Code Extension](https://developer.garmin.com/connect-iq/reference-guides/visual-studio-code-extension/) for how to execute commands such as `build` and `test` to the Monkey C runtime.

You can use the included `Makefile` to conveniently trigger some of the actions from the command line.

```bash
# build binaries from sources
make build

# run unit tests -- note: requires the simulator to be running
make test

# run the simulation
make run

# clean up the project directory
make clean
```

To sideload your application to your Garmin watch, see [developer.garmin.com/connect-iq/connect-iq-basics/your-first-app](https://developer.garmin.com/connect-iq/connect-iq-basics/your-first-app/).
