import QtQuick 2.1
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    DataSourceSection {}

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Indicator")

        SectionLayout {
           Label {
                text: qsTr("direction")
                tooltip: qsTr("incremental direction")
            }
            SecondColumnLayout {
                ComboBoxFix {
                    backendValue: backendValues.direction
                    implicitWidth: 180
                    scope: "Direction"
                    model: ["Up", "Right", "Down", "Left"]
                }
            }
            Label {
                text: qsTr("label style")
                tooltip: qsTr("set the decoration style")
            }
            SecondColumnLayout {
                ComboBoxFix {
                    backendValue: backendValues.labelStyle
                    implicitWidth: 180
                    scope: "LabelStyle"
                    model: ["Frame", "None", "Outline", "Limits", "Channel"]
                }
            }
        }
    }

    LimitsSection {}
    ColorSection {}
    DynamicAttributeSection {}
}
