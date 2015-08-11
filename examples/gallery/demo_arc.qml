import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.0

import PvComponents 1.0

Rectangle {
    ColumnLayout {
        anchors.fill: parent
        CaArc {
            id: arc
            width: 200
            height: 200
            begin: beginSlider.value
            span: spanSlider.value
            fill: fillStyleGroup.fillStyle
        }
        RowLayout {
            Text {
                text: 'Begin'
            }
            Slider {
                id: beginSlider
                width: 200
                minimumValue: 0
                maximumValue: 360
            }
        }
        RowLayout {
            Text {
                text: 'Span'
            }
            Slider {
                id: spanSlider
                width: 200
                minimumValue: 0
                maximumValue: 360
                value: 60
            }
        }
        FillStyleGroup {
            id: fillStyleGroup
        }
    }
}
