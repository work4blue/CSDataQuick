import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

import PvComponents 1.0
import "utils.js" as UtilsJS

/*!
    \qmltype CaTextEntry
    \inqmlmodule PvComponents
    \brief Display an editable text

    The Text Entry provides a means of displaying the value of a process variable in an entry box,
    where it can be edited and changed. The value is not sent until Return is pressed with the focus in the entry box.
    If the focus leaves the entry box before Return is pressed, the value of the process variable is not changed
    and the current value is restored into the entry box.  The resulting value of the process variable is shown
    when and only when the cursor leaves the entry box.
    The value after leaving the entry box can be used to verify that the input was accepted.

    If the native format of the process variable associated with the Text Entry is DBR_STRING or DBR_CHAR,
    then the string entered in the Text Entry will be sent to the process variable.

    If the native type is DBR_ENUM, then it will first try to match the entered string to
    one of the state strings of the process variable.  If that fails, it will try to
    interpret the string as a number representing one of the state strings and send that number to the process variable.

    For the native types for which a number is meaningful, the behavior of the Text Entry will depend on the format of the Text Entry.
    If the Text Entry has a format of octal, then numbers may be input with or without a leading 0 and will be interpreted as octal.
    That is, entering either 010 or 10 results in 8 decimal.  Entering 8 is an error.
    The numbers will be displayed with a leading 0 when they are updated.
    Similarly, if the Text Entry is formatted to hexadecimal,
    then numbers may be input with or without a leading 0x or 0X and will be interpreted as hexadecimal.
    In this case, 0x10, 010 or 10 will result in 16 decimal.
    In all other formats, input values will be interpreted as decimal unless they begin with 0x or 0X,
    in which case they are interpreted as hexadecimal.
    Input numbers with a leading 0 in these formats will not be interpreted as octal because of the chance for error or confusion.
    If you want to input octal, you must format the Text Entry to octal.

    \qml
    Column {
        CaTextEntry {
            width: 80
            height: 25
            channel: 'bo'
        }
        CaTextEntry {
            width: 200
            height: 25
            channel: 'waves'
        }
        CaTextEntry {
            width: 80
            height: 25
            channel: 'catest'
            format: TextFormat.Decimal
        }
        CaTextEntry {
            width: 80
            height: 25
            channel: 'catest'
            format: TextFormat.Hexadecimal
        }
        CaTextEntry {
            width: 80
            height: 25
            channel: 'catest'
            format: TextFormat.Octal
        }
    }
    \endqml

    \image textentry.png
*/

CaControl {
    id: root
    /*!
        \qmlproperty enumeration align
        Sets the horizontal alignment of the text within the item width.

        The font used depends on the item height using function \l UtilsJS::getBestFontSize.
    */
    property alias align: textField.horizontalAlignment
    /*!
        \qmlproperty TextFormat format
    */
    property int format: TextFormat.Decimal

    /*! The low high operation range and precision */
    property Limits limits: Limits {id: limits}

    Rectangle {
        anchors.fill: parent
        BorderImage {
            source: 'images/button_down.png'
            anchors.leftMargin: 3
            border {left: 3; right: 3; top: 3; bottom: 3;}
            horizontalTileMode: BorderImage.Stretch
            verticalTileMode: BorderImage.Stretch
            width: parent.width
            height: parent.height
        }
        color: root.background
    }

    TextInput {
        id: textField
        font.pixelSize: root.fontSize
        font.family: root.fontFamily
        color: colorMode == ColorMode.Alarm ? root.alarmColor : root.foreground
        verticalAlignment: TextInput.AlignBottom
        activeFocusOnPress: true
        readOnly: !pv.writable
        clip: true
        selectByMouse: true
        anchors.topMargin: 4
        anchors.bottomMargin: 2
        anchors.leftMargin: 2
        anchors.rightMargin: 2
        anchors.fill: parent
        onAccepted: {
            if (!pv.writable)
                return
            var value;
            switch (pv.type) {
            case PvObject.String:
                pv.value = text
                break
            case PvObject.Enum:
                var found = false
                for(var i=0; i<pv.strs.length; i++) {
                    if (text == pv.strs[i]) {
                        found = true
                        break
                    }
                }
                if (found)
                    pv.value = text
                else {
                    value = Utils.parse(format, text)
                    if (!isNaN(value))
                        pv.value = value
                }
                break
            case PvObject.Integer:
            case PvObject.Long:
                value = Utils.parse(format, text)
                if (!isNaN(value))
                    pv.value = value
                break
            case PvObject.Char:
                pv.value = text
                break
            default:
                value = Utils.parse(format, text)
                if (!isNaN(value))
                    pv.value = value
            }
        }
    }

    MouseArea {
        anchors.fill: textField
        acceptedButtons: Qt.NoButton
        hoverEnabled: true
        onEntered: textField.focus = true
        onExited: {
            textField.focus = false
            textField.text = formatString(format, pv.value)
        }
    }

    Connections {
        target: pv
        onConnectionChanged: {
            if (pv.connected) {
                limits.precChannel = pv.prec
            }
        }
        onValueChanged: {
            textField.text = formatString(format, pv.value)
            if (!textField.activeFocus)
                textField.cursorPosition = 0
        }
    }

    onFormatChanged: {
        textField.text = formatString(format, pv.value)
    }

    onHeightChanged: {
        var font = UtilsJS.getBestFontSize(height, true)
        fontSize = font.size
        fontFamily = font.family
    }

    /*!
        \internal
        Format the value based on PV type.
    */
    function formatString(format, value) {
        if (pv.type == PvObject.Enum)
            return pv.strs[value]
        if (pv.type == PvObject.String)
            return value
        if (pv.type == PvObject.Char && value instanceof Array)
            return arrayToString(value)
        var result = Utils.convert(format, value, limits.prec)
        return result
    }

    /*!
      \internal
      Format char array to string.
    */
    function arrayToString(array) {
        var s = ''
        for(var i = 0; i < array.length; i++) {
            var v = array[i]
            if (v == 0)
                break
            s += String.fromCharCode(v)
        }
        return s
    }
}
