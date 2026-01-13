using Toybox.Application.Properties;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

import Toybox.Lang;


class View extends WatchUi.WatchFace {

    private var _epoch = new Epoch();

    function initialize() {
        WatchFace.initialize();
    }

    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    function onUpdate(dc) {

        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());

        var time = Time.now();

        _epoch
            .forTime(time)
            .draw(dc);

    }

}