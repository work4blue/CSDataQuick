pragma Singleton
import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2

import CSDataQuick.Data 1.0

Dialog {
    id: root
    standardButtons: StandardButton.Ok
    modality: Qt.NonModal

    contentItem: ColumnLayout {
        anchors.fill: parent
        anchors.margins: 5
        Row {
            spacing: 5
            Layout.fillWidth: true
            Text {
                text: 'Select Engine'
            }
            ComboBox {
                id: engineCombo
                implicitWidth: 200
                model: DataEngineManager.engines
                textRole: 'description'
                property var engine:  DataEngineManager.engines[currentIndex]
            }
        }
        TableView {
            id: pvTable
            Layout.fillWidth: true
            Layout.fillHeight: true
            sortIndicatorVisible: true
            TableViewColumn {
                title: 'Source'
                role: 'source'
            }
            TableViewColumn {
                title: 'Connection'
                role: 'connected'
                width: 80
                delegate: Text {
                    text: styleData.value ? 'connected' : 'disconnected'
                    color: styleData.value ? 'green' : 'red'
                }
            }
            model: proxyModel

            SortFilterProxyModel {
                id: proxyModel
                source: root.visible ? engineCombo.engine.allData : null

                sortOrder: pvTable.sortIndicatorOrder
                sortCaseSensitivity: Qt.CaseInsensitive
                sortRole: pvTable.getColumn(pvTable.sortIndicatorColumn).role

                filterString: searchBox.text
                filterRole: 'source'
                filterSyntax: SortFilterProxyModel.RegExp
                filterCaseSensitivity: Qt.CaseInsensitive
            }
        }
        TextField {
            id: searchBox
            Layout.fillWidth: true
            Text {
                x: searchBox.focus ? 20 : (parent.width - implicitWidth) / 2
                anchors.verticalCenter: parent.verticalCenter
                text: "Look for a data source?"
                color: "gray"
                visible: searchBox.text == ''
                Behavior on x {
                    NumberAnimation {duration:200}
                }
            }
        }
    }
}

