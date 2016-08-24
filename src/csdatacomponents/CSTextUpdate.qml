import QtQuick 2.0
import QtQuick.Layouts 1.0

import CSDataQuick.Data 1.0
import CSDataQuick.Components 1.0
import "utils.js" as UtilsJS

/*!
    \qmltype CSTextUpdate
    \inqmlmodule CSDataQuick.Components
    \brief Display the value in given format.

    The value is format to string using \l format.

    The font used depends on the item height using function \l UtilsJS::getBestFontSize.
    If \l align is not Text.AlignLeft, it will attemp to find a font size so that the text can fit in item width.

    \qml
    Row {
        spacing: 5
        CSTextUpdate {
            width: 100
            height: 20
            source: 'catest.SCAN'
        }
        CSTextUpdate {
            width: 100
            height: 20
            source: 'catest'
        }
    }
    \endqml

    \image textupdate.png
*/

CSMonitor {
    id: root
    implicitWidth: 100
    implicitHeight: 20
    /*!
        \qmlproperty enumeration align
        Set the horizontal alignment of the text within the item width.
    */
    property alias align: label_control.horizontalAlignment
    /*!
        \qmlproperty enumeration format
        For all of the formats, the result depends on the number and the precision in limits.

        \list
        \li TextFormat.Decimal - Text with or without decimal point, e.g. 10.0 or 10.
        \li TextFormat.Exponential - Exponential notation, e.g. 1.00e+04.
        \li TextFormat.EngNotation - Engineering notation, e.g. 10.00e+03.
        \li TextFormat.Compact - Either in decimal or exponential form to be most compact.
        \li TextFormat.Truncated - Text is rounded to the largest integer, e.g 10000.
        \li TextFormat.Hexadecimal - The text is rounded to the nearest integer and shown in hexadecimal, e.g. 0x3e8.
        \li TextFormat.Octal - The text is rounded to the nearest integer and shown in octal, e.g. 01750.
        \li TextFormat.String - Same as decimal except that for large numbers or precision, it can be in exponential format.
        \endlist
    */
    property int format: TextFormat.Decimal
    /*! Display physical units if available */
    property bool unitsVisible: false
    /*! \internal */
    readonly property var font: UtilsJS.getBestFontSize(height)

    limits: Limits {
        precChannel: pv.precision
    }

    RowLayout {
        anchors.fill: parent
        Text {
            id: label_control
            //text: formatString(format, pv.value)
            color: colorMode == ColorMode.Alarm ? root.alarmColor : root.foreground
            clip: true
            font.pixelSize: root.font.size
            font.family: root.font.family
            Layout.fillWidth: true
        }
        Text {
            id: units
            font: label_control.font
            color: root.foreground
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            visible: unitsVisible && text != ''
            text: pv.units
        }
    }

    Connections {
        target: pv

        onStateStringsChanged: {
            label_control.text = formatString(format, pv.value)
        }

        onValueChanged: {
            label_control.text = formatString(format, pv.value)
            // MEDM Compat: automatic adjust font size only if it is not left aligned
            if (align == Text.AlignLeft)
                return
            while(label_control.font.pixelSize > 6 && label_control.paintedWidth > label_control.width) {
                label_control.font.pixelSize -= 1
            }
        }
    }

    Connections {
        target: limits

        onPrecChanged: {
            label_control.text = formatString(format, pv.value)
        }
    }

    onFormatChanged: {
        label_control.text = formatString(format, pv.value)
    }

    /*! \internal */
    function formatString () {
        return UtilsJS.formatString(pv.value,
                                    format,
                                    pv.fieldType,
                                    limits.prec,
                                    pv.stateStrings)
    }
}

