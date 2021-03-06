import QtQuick 2.0

import CSDataQuick.Components 1.0

/*!
    \qmltype CSImage
    \inqmlmodule CSDataQuick.Components
    \ingroup csdataquick.components.graphics
    \brief Show a static or dynamic image.

    The image can be any any image format supported by Qt, loaded from any URL scheme supported by Qt.
    The image is scaled to fit item size.

    If the image file has multiple frames, the designer can choose to animate the images or to display a specified frame.
    The default is to animate if there is more than one frame.  To display a specific frame, enter an expression for
    the \l imageCalc that returns a frame number.

    \qml
            CSImage {
                source: 'LED.gif'
                dynamicAttribute.channel: 'catest'
                imageCalc: 'A*10'
            }
    \endqml

*/

CSGraphics {
    id: root
    /*!
      \qmlproperty url source

       This property holds the URL that refers to the source image.
    */
    property alias source: animation.source

    /*!
        For multiple-frame images, the frame to display is defined by this expression.

        The syntax for the \l imageCalc expression is the same as that for the \l DynamicAttribute.
        The only difference is that the expression should return a frame number, not True or False.
        The Image will be black if the expression is invalid.

        Frame numbers start with 0. The value will be rounded to the nearest integer.
        Frame numbers that are too high will use the last frame, and frame numbers that are too small will use the first frame.
    */
    property string imageCalc: ''

    /*!
        \internal

        This is the number of frames in the image.

        The ADLViewer uses this property to decide this item's stacking order.
        If the number of frame is less than 1, and \l dynamicAttribute has no valid channel,
        this item will be given lower stacking order.
    */
    property int frameCount: 1

    implicitWidth: animation.implicitWidth
    implicitHeight: animation.implicitHeight

    onImageCalcChanged: dynamicAttribute.altCalc = imageCalc

    Connections {
        target: dynamicAttribute
        onAltCalcResultChanged: {
            if (imageCalc !== '') {
                var frame = dynamicAttribute.altCalcResult;
                animation.visible = !isNaN(frame)
                animation.currentFrame = Math.max(0, Math.min(frame, animation.frameCount))
            }
        }
    }

    AnimatedImage {
        id: animation;
        anchors.fill: parent
        fillMode: Image.Stretch
        // play animation unless calculation is used
        playing: imageCalc == ''
        onStatusChanged: root.frameCount = frameCount
    }
}
