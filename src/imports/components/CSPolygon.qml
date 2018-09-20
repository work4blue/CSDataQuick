import QtQuick 2.0

import CSDataQuick.Components 1.0

/*!
    \qmltype CSPolygon
    \inqmlmodule CSDataQuick.Components
    \ingroup csdataquick.components.graphics
    \brief Display a polygon shape

    Draws the polygon defined by the \l points array. The first point is implicitly connected to the last point.

    \qml
    Row {
        spacing: 5
        CSPolygon {
            width: 100
            height: 100
            points: [
                Qt.point(10.0, 80.0), Qt.point(20.0, 10.0),
                Qt.point(80.0, 30.0),Qt.point(90.0, 70.0)
            ]
        }
        CSPolygon {
            width: 100
            height:100
            points: [
                Qt.point(10.0, 80.0),Qt.point(20.0, 10.0),
                Qt.point(80.0, 30.0),Qt.point(90.0, 70.0)
            ]
            fill: FillStyle.Outline
            edge: EdgeStyle.Dash
        }
    }
    \endqml

    \image polygon.png
*/

CSGraphics {
    id: root

    /*!
        \qmlproperty list<point> points

        This property holds the trace of the polygon as a list of points.
    */
    property alias points: polygon.points

    implicitWidth: polygon.implicitWidth
    implicitHeight: polygon.implicitHeight

    Polygon {
        id: polygon
        anchors.fill: parent
        foreground: (colorMode == ColorMode.Alarm
                     || (dynamicAttribute.visibilityMode != VisibilityMode.Static
                         && !dynamicAttribute.connected)) && !Utils.inPuppet
                    ? root.alarmColor : root.foreground
        lineWidth: root.lineWidth
        fillStyle: root.fillStyle
        edgeStyle: root.edgeStyle
    }
}
