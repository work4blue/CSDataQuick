import QtQuick 2.1
import QtQuick.Controls 1.0

import PvComponents 1.0

ApplicationWindow {
    id: app
    width: 900
    height: 400
    color: '#bbbbbb'

    menuBar: MenuBar {
        Menu {
            title: 'File'
            MenuItem {
                text: 'Exit'
                onTriggered: app.close()
            }
        }
        Menu {
            title: 'Help'
            MenuItem {
                text: 'About'
                onTriggered: console.log('A demo of qml pv components')
            }
        }
    }

    Column {
        anchors.fill: parent

        Text {text: 'Graphics'}
        Flow {
            x: 10
            spacing: 10

            CaText {
                width: 100
                height: 20
                text: 'Oh, A static label'
            }

            CaRect {
                width: 100
                height: 70
                foreground: 'blue'
                fill: FillStyle.Solid
            }

            CaOval {
                channel: 'bo'
                colorMode: ColorMode.Alarm
                width: 100
                height: 70
                fill: FillStyle.Solid
                lineWidth: 2
            }
            CaArc {
                PvObject {
                    id: pv
                    channel: 'catest'
                }

                width: 100
                height: 100
                begin: 90
                span: pv.value * 360
                fill: FillStyle.Solid
            }
            CaPolygon {
                width: 100
                height: 50
                lineWidth: 2
                foreground: 'pink'
                fill: FillStyle.Solid
                edge: EdgeStyle.Solid
                points: [Qt.point(50, 5), Qt.point(20, 40), Qt.point(80, 40)]
            }

            CaPolyline {
                width: 200
                height: 80
                channelC: ""
                lineWidth: 2
                foreground: 'black'
                background: 'black'
                edge: EdgeStyle.Solid
                points: [Qt.point(10,10), Qt.point(100, 30),
                    Qt.point(100, 70), Qt.point(50, 80)]
            }

            CaImage {
                width: 100
                height: 100
                source: 'LED.gif'
                channel: 'catest'
                imageCalc: 'A*10'
            }
        }
        Text {text: 'Control'}
        Row {
            x: 10
            spacing: 10
            width: parent.width

            CaSlider {
                width: 200
                height: 24
                channel: 'catest'
                minimumValue: 0.0
                maximumValue: 1.0
                stepSize: 0.01
            }

            CaMessageButton {
                width: 100
                height: 24
                text: 'Click Me!'
                channel: 'calc'
                foreground: 'yellow'
                onMessage: 0.1
                offMessage: 0.5
            }

            CaTextEntry {
                width:100
                height:24
                channel: 'catest'
                colorMode: ColorMode.Alarm
            }
            CaTextEntry {
                width: 200
                height: 20
                channel: 'calc.SCAN'
            }

            CaMenu {
                width: 100
                height: 20
                channel: 'calc.SCAN'
            }

            CaChoiceButton {
                width: 100
                height: 30
                orientation: 0
                channel: 'bo'
            }

            CaRelatedDisplay {
                width: 100
                height: 20
                label: 'More'
                model: ListModel {
                    ListElement {label: 'test'; fname: '../examples/widgets.qml'; args: ''; remove: false}
                }
            }

            CaShellCommand {
                width: 100
                height: 20
                label: 'list'
                model: ListModel {
                    ListElement {label: 'List Directory'; command: 'ls'; args: '-l'; }
                }
            }

        }
        Text {text: 'Monitor'}
        Flow {
            x: 10
            spacing: 10
            width: parent.width

            CaTextLabel {
                channel: 'calc'
                width: 100
                height: 20
            }

            CaTextLabel {
                channel: 'calc.SCAN'
                width: 150
                height: 20
            }

            CaByte {
                width: 320
                height: 10
                visibilityCalc: ""
                channel: 'calc'
            }
            CaBar {
                width: 100
                height: 20
                channel: 'catest'
                colorMode: ColorMode.Alarm
            }
            CaMeter {
                width: 80
                height: 60
                channel: 'catest'
            }
            CaStripChart {
                width: 500
                height: 300
                channel: 'catest'
            }
       }
    }
}
