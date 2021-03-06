import QtQuick 2.0
import QtQuick.Controls 1.0

import CSDataQuick.Components 1.0

GroupBox {
    property int textAlignment: textAlignmentGroup.current.textAlignmentOption

    title: "Text Alignement"

    Column {
        ExclusiveGroup { id: textAlignmentGroup }
        RadioButton {
            property int textAlignmentOption: Text.AlignLeft
            text: "Left"
            checked: true
            exclusiveGroup: textAlignmentGroup
        }
        RadioButton {
            property int textAlignmentOption: Text.AlignRight
            text: "Right"
            exclusiveGroup: textAlignmentGroup
        }
        RadioButton {
            property int textAlignmentOption: Text.AlignHCenter
            text: "Center"
            exclusiveGroup: textAlignmentGroup
        }
    }
}

