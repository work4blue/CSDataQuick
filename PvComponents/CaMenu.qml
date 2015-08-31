import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

import PvComponents 1.0

/*!
    \qmltype CaMenu
    \inqmlmodule PvComponents
    \brief Displays process variable's enumerate in drop-down menu

    The Menu is used for ENUM process variables and is a means for picking the ENUM choices via a menu.
    Note that if the colorMode is alarm, the foreground color, not the background color, is set to the alarm colors.
    The background color should be choosen to contrast with all the alarm colors.
*/

CaControl {
    id: combo

    ComboBox {
        id: combo_control
        property bool __first: true
        anchors.fill: parent

        style: ComboBoxStyle {
            label: Text {
                text: combo_control.currentText
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: colorMode == ColorMode.Alarm ? combo.alarmColor : combo.foreground
                font.pixelSize: combo.fontSize
                font.family: combo.fontFamily
            }
            background: Rectangle {
                anchors.fill: parent
                BorderImage {
                    anchors.fill: parent
                    source: control.pressed ? 'images/button_up.png' : 'images/button_up.png'
                    border {left: 3; right: 3; top: 3; bottom: 3;}
                    width: parent.width
                    height: parent.height

                    BorderImage {
                        anchors.fill: parent
                        source: 'images/focusframe.png'
                        anchors.leftMargin: -1
                        anchors.topMargin: -2
                        anchors.rightMargin: 0
                        anchors.bottomMargin: -1
                        border {left: 3; right: 3; top: 3; bottom: 3;}
                        visible: control.activeFocus
                    }
                    Image {
                        source: "images/arrow-down.png"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 8
                        opacity: control.enabled ? 0.7 : 0.5
                    }
                }
                color: combo.background
            }
        }

        onCurrentIndexChanged: {
            if (__first) __first = false
            else pv.setValue(currentIndex)
        }
    }
    Connections {
        target: pv
        onConnectionChanged: {
            if (pv.connected) {
                combo_control.model = pv.strs
            } else {
                combo_control.model = []
            }
        }
        onValueChanged: {
            combo_control.currentIndex = pv.value
        }
    }
}
