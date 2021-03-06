import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.0

import CSDataQuick.Components 1.0

Rectangle {
    Column {
        anchors.fill: parent
        CSText {
            text: input.text
            width: 200
            height: textHeight.value
            foreground: fgColorPalette.color
            align: textAlignmentGroup.textAlignment
        }
        TextField {
            id: input
            width: 200
            text: 'enter text here'
        }
        Row {
            spacing: 10
            Text {
                text: 'foreground'
            }

            ColorPalette {
                id: fgColorPalette
                width: 100
                height: 20
                currentIndex: 14
            }
        }
        Row {
            Text {
                text: 'Text Height'
            }
            Slider {
                id: textHeight
                minimumValue: 8
                maximumValue: 50
            }
        }
        TextAlignmentGroup {
            id: textAlignmentGroup
        }
    }
}
