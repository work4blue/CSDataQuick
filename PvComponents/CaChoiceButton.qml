import QtQuick 2.1
import QtQuick.Controls 1.0

import PvComponents 1.0


Rectangle {
    property alias channel: pv.channel
    property int orientation: 0

    property var btnList: new Array()
    property var layout: null
    
    id: choiceButtons

    PvObject {
        id: pv
    }

    ExclusiveGroup { id: radioInputGroup }

    Connections {
        target: pv
        onValueChanged: {
            console.log(pv.value)
            btnList[pv.value].checked = true
        }
        onConnectionChanged: {
            var i
            if (!pv.connected)
                return
            // destroy any previous buttons/layout
            for(i=0; i<btnList.length; i++)
                btnList[i].destroy()
            btnList = []
            if (layout) {
                layout.destroy();
                layout = null
            }

            // create layout based on orientation
            var cmd = ''
            if (orientation == 0) {
                cmd = 'import QtQuick 2.1;
                                    Row {
                                        id: layout
                                    }'
            } else {
                cmd = 'import QtQuick 2.1;
                                    Column {
                                        id: layout
                                    }'
            }
            layout = Qt.createQmlObject(cmd, choiceButtons, 'layout')
            var w = 0, h = 0;
            for(i = 0; i < pv.nostr; i++) {
                var name = 'btn'+i
                var btn = Qt.createQmlObject('import QtQuick.Controls 1.0;
                                            Button {
                                                    checkable:true;
                                                    exclusiveGroup: radioInputGroup
                                                    onClicked: pv.setValue(%1)
                                            }'.arg(i), layout, name)
                btn.text = pv.strs[i]
                btnList.push(btn)
                if (orientation == 0) {
                    w += btn.width
                    h = Math.max(h, btn.height)
                }
                else {
                    h += btn.height
                    w = Math.max(w, btn.width)
                }
            }
            width = w
            height = h
        }
    }
}
