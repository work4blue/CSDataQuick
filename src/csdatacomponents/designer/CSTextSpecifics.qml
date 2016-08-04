import QtQuick 2.1
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Text")

        SectionLayout {
            Label {
                text: qsTr("text")
                tooltip: qsTr("text to display")
            }
            SecondColumnLayout {
                LineEdit {
                    backendValue: backendValues.text
                    showTranslateCheckBox: false
                    implicitWidth: 180
                }
            }
            Label {
                text: qsTr("alignment")
                tooltip: qsTr("text horizontal alignment")
            }
            SecondColumnLayout {
                ComboBox {
                    backendValue: backendValues.align
                    implicitWidth: 180
                    scope: "Text"
                    model: ["AlignLeft", "AlignRight", "AlignHCenter", "AlignJustify"]
                }
            }
        }
    }
    ColorSection {
    }
    DynamicAttributeSection {
    }
}