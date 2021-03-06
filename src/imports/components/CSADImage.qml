import QtQuick 2.1

import CSDataQuick.Components 1.0

/*!
    \qmltype CSADImage
    \inqmlmodule CSDataQuick.Components
    \ingroup csdataquick.components.monitors
    \brief Display an image from areaDetector.

    \l {http://cars9.uchicago.edu/software/epics/areaDetector.html}{areaDetector} is a generic EPICS framework to integrate detectors.
    The detector data is internally represented as a
    \l { http://cars9.uchicago.edu/software/epics/areaDetectorDoc.html#NDArray }{NDArray} structure.
    The plugin \l {http://cars9.uchicago.edu/software/epics/NDPluginStdArrays.html}{ NDPluginStdArrays }
    makes it available as EPICS PVs.

    Because EPICS PV only supports 1-D waveform. To reconstruct the image.
    The following PVs are relavent:
    \table
    \header
        \li areaDetector PV
        \li Description
    \row
        \li $(P)$(R)ArraySize0_RBV
        \li First dimension of NDArray data
    \row
        \li $(P)$(R)ArraySize1_RBV
        \li Second dimension of NDArray data
    \row
        \li $(P)$(R)ArraySize2_RBV
        \li Third dimension of NDArray data
    \row
        \li $(P)$(R)DataType_RBV
        \li Data type of NDArray data
    \endtable

    \qml
        CSADImage {
            interval: 200
            source: '13SIM1:image1:'
        }
    \endqml

    \image ADImage.gif
*/

BaseItem {
    id: root
    /*!
        \qmlproperty string source
        This property holds the NDPluginStdArrays prefix. e.g. 13SIM1:image1:
    */
    property alias source: ad.source

    implicitWidth: img.implicitWidth
    implicitHeight: img.implicitHeight

    ImageItem {
        id: img
        anchors.fill: parent
    }

    ADImage {
        id: ad
        onImageChanged: img.setImage(image)
    }
}
