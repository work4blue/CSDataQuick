import QtQuick 2.0

import CSDataQuick.Components 1.0


/*!
    \qmltype CSGraphics
    \inqmlmodule CSDataQuick.Components
    \brief Basic type to all graphics shapes

    CSGraphics is the base type for all graphics types.
    It defines all the attributes that are common across graphics shapes.

*/
BaseItem {
    /*! This property indicates whether draw outline only or fill the shape. \sa FillStyle, */
    property int fillStyle: FillStyle.Solid
    /*! This property holds the outline style. \sa EdgeStyle, */
    property int edgeStyle: EdgeStyle.Solid
    /*! This property holds the outline width. */
    property int lineWidth: 0
    /*! This property indicates how foreground color changes. \sa ColorMode, */
    property int colorMode: ColorMode.Static
    /*! This property holds the color based on the severity of the associated CSData.

        It is one of the ColorMap.invalid_alarm, ColorMap.minor_alarm, ColorMap.major_alarm and ColorMap.no_alarm.
    */
    property color alarmColor: ColorMap.invalid_alarm

    background: ColorMap.graphics_background
    foreground: ColorMap.foreground
    dynamicAttribute: DynamicAttribute {id: da}
    visible: da.visibility

    Connections {
        target: da
        onStatusChanged: {
            if (colorMode == ColorMode.Static)
                return
            switch (da.d.pvA.alarm.severity) {
                case 0: // NO_ALARM
                alarmColor = ColorMap.no_alarm
                break;
                case 1: // MINOR_ALARM
                alarmColor = ColorMap.minor_alarm
                break;
                case 2: // MAJOR_ALARM
                alarmColor = ColorMap.major_alarm
                break;
                case 3: // INVALID_ALARM
                alarmColor = ColorMap.invalid_alarm
                break;
            }
        }
        onConnectedChanged: {
            if (colorMode == ColorMode.Static && da.visibilityMode == VisibilityMode.Static)
                return
            if (!da.connected)
                alarmColor = ColorMap.invalid_alarm
        }
    }
}
