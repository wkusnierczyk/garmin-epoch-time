using Toybox.Application;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;

import Toybox.Lang;


class Epoch {

    private static const
        EPOCH_FONT = Application.loadResource(Rez.Fonts.Epoch),
        DATE_FONT = Application.loadResource(Rez.Fonts.Command);

    private static const
        EPOCH_COLOR = Graphics.COLOR_WHITE,
        DATE_COLOR = Graphics.COLOR_LT_GRAY,
        ROOT_COLOR = Graphics.COLOR_PURPLE,
        DIR_COLOR = Graphics.COLOR_DK_GREEN,
        BRANCH_COLOR = Graphics.COLOR_BLUE,
        PROMPT_COLOR = Graphics.COLOR_RED,
        ERROR_COLOR = Graphics.COLOR_DK_RED;

    private var
        _width as Number,
        _height as Number,
        _centerX as Number,
        _centerY as Number,
        _epochWidth as Number or Null,
        _epochHeight as Number or Null,
        _epochX as Number or Null,
        _epochY as Number or Null,
        _dateHeight as Number or Null;

    private var 
        _time = Time.now(),
        _dc as Graphics.Dc or Null;

    private var
        _initialized = false;


    function initialize() {

        var settings = System.getDeviceSettings();
        _width = settings.screenWidth;
        _height = settings.screenHeight;
        _centerX = _width / 2;
        _centerY = _height / 2;

    }


    function forTime(time as Time.Moment) as Epoch {
        _time = time;
        return self;
    }


    function draw(dc as Graphics.Dc) as Epoch {
        
        if (!_initialized) {
            _epochWidth = dc.getTextWidthInPixels("0000000000", EPOCH_FONT);
            _epochHeight = dc.getFontHeight(EPOCH_FONT);
            _epochX = _centerX - _epochWidth / 2;
            _epochY = _centerY - _epochHeight / 3;
            _dateHeight = dc.getFontHeight(DATE_FONT);
            _initialized = true;        
        }

        _dc = dc;
        _drawEpoch();
        _drawDate();
        return self;

    }


    private function _drawEpoch() {

        var justify = Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER;
        var time = _time.value().toString();
        _dc.setColor(EPOCH_COLOR, Graphics.COLOR_BLACK);
        _dc.drawText(_epochX, _epochY, EPOCH_FONT, time, justify);

    }
    

    private function _drawDate() {

        var justify = Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER;
        
        var x = _epochX;
        var y = _epochY + (0.6 * _epochHeight).toNumber();

        _dc.setColor(ROOT_COLOR, Graphics.COLOR_BLACK);
        _dc.drawText(x, y, DATE_FONT, "root", justify);

        x += _dc.getTextWidthInPixels("root", DATE_FONT);
        _dc.setColor(DATE_COLOR, Graphics.COLOR_BLACK);
        _dc.drawText(x, y, DATE_FONT, " in ", justify);

        x += _dc.getTextWidthInPixels(" in ", DATE_FONT);
        _dc.setColor(DIR_COLOR, Graphics.COLOR_BLACK);
        _dc.drawText(x, y, DATE_FONT, "~/dev", justify);

        x += _dc.getTextWidthInPixels("~/dev", DATE_FONT);
        _dc.setColor(DATE_COLOR, Graphics.COLOR_BLACK);
        _dc.drawText(x, y, DATE_FONT, " on ", justify);

        x += _dc.getTextWidthInPixels(" on ", DATE_FONT);
        _dc.setColor(BRANCH_COLOR, Graphics.COLOR_BLACK);
        _dc.drawText(x, y, DATE_FONT, "main", justify);

        x += _dc.getTextWidthInPixels("main", DATE_FONT);
        _dc.setColor(PROMPT_COLOR, Graphics.COLOR_BLACK);
        _dc.drawText(x, y, DATE_FONT, " $ ", justify);

        x += _dc.getTextWidthInPixels(" $ ", DATE_FONT);
        _dc.setColor(DATE_COLOR, Graphics.COLOR_BLACK);
        _dc.drawText(x, y, DATE_FONT, "date", justify);


        var info = Gregorian.info(_time, Time.FORMAT_MEDIUM);
        var text = Lang.format("$1$ $2$ $3$ $4$:$5$:$6$ $7$", [
            info.day_of_week,                // "Tue"
            info.month,                      // "Jan"
            info.day.format("%02d"),         // "13"
            info.hour.format("%02d"),        // "16"
            info.min.format("%02d"),         // "47"
            info.sec.format("%02d"),         // "27"
            info.year                        // "2026"
        ]);

        x = _epochX;
        y += _dateHeight;
        _dc.drawText(x, y, DATE_FONT, text, justify);

        var errorCutoff = 15;
        if (info.sec < errorCutoff) {
            y += (1.5 * _dateHeight).toNumber();
            _dc.setColor(ERROR_COLOR, Graphics.COLOR_BLACK);
            _dc.drawText(x, y, DATE_FONT, "[E47] Corrupt file system", justify);
            y += _dateHeight;
            var reboot = Lang.format("Rebooting in $1$ seconds...", [(errorCutoff - info.sec).format("%02d")]);
            _dc.drawText(x, y, DATE_FONT, reboot, justify);
        }
    }
    

}