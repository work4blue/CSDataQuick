.pragma library

.import PvComponents 1.0 as PvComponents

/*!
    \qmltype UtilsJS
    \inqmlmodule PvComponents
    \brief Javascript Utility Functions
*/


/*!
    \qmlmethod UtilsJS::getBestFontSize(widget_height, with_frame)
*/
function getBestFontSize(widget_height, with_frame) {
    var fsize_label = [[ 8,8], [ 9,9], [10,10], [13,11], [14,12], [15,13], [16,14], [20,16], [21,18], [26,22], [27, 28],[35,32]]
    var fsize_frame = [[14,8], [15,9], [16,10], [20,11], [21,12], [22,13], [23,14], [27,16], [32,18], [34,22]]

    var fsize = fsize_label
    if (with_frame)
        fsize = fsize_frame

    var font_size = fsize[fsize.length - 1][1]
    for(var i=1; i<fsize.length; i++) {
        if(widget_height < fsize[i][0]) {
            font_size = fsize[i - 1][1]
            break
        }
    }

    var font_family = "Dejavu Sans Mono"
    if (font_size > 20)
        font_family = "Helvetica"

    return {"family" : font_family, "size" : font_size}
}

/*!
    \qmlmethod UtilsJS::popupPvLimitsDialog(parent)
*/
function popupPvLimitsDialog(parent) {
    var cmd = 'import PvComponents 1.0; PvLimitsDialog {}'
    var dialog = Qt.createQmlObject(cmd, parent, 'dialog')

    dialog.channel = parent.channel

    dialog.limits.loprSrc     = parent.limits.loprSrc
    dialog.limits.loprChannel = parent.limits.loprChannel
    dialog.limits.loprDefault = parent.limits.loprDefault
    dialog.limits.loprUser    = parent.limits.loprUser

    dialog.limits.hoprSrc     = parent.limits.hoprSrc
    dialog.limits.hoprChannel = parent.limits.hoprChannel
    dialog.limits.hoprDefault = parent.limits.hoprDefault
    dialog.limits.hoprUser    = parent.limits.hoprUser

    dialog.limits.precSrc     = parent.limits.precSrc
    dialog.limits.precChannel = parent.limits.precChannel
    dialog.limits.precDefault = parent.limits.precDefault
    dialog.limits.precUser    = parent.limits.precUser

    dialog.accepted.connect(function() {
        // only user values can be modified
        // so copy them only
        parent.limits.loprSrc  = dialog.limits.loprSrc
        parent.limits.loprUser = dialog.limits.loprUser

        parent.limits.hoprSrc  = dialog.limits.hoprSrc
        parent.limits.hoprUser = dialog.limits.hoprUser

        parent.limits.precSrc  = dialog.limits.precSrc
        parent.limits.precUser = dialog.limits.precUser
    })
    dialog.open()
}

/*!
    \qmlmethod UtilsJS::popupPvLimitsDialog(parent)
*/
function popupPromptDialog(parent, title, hint, input) {
    var cmd = 'import PvComponents 1.0; PromptDialog {}'
    var dialog = Qt.createQmlObject(cmd, parent, 'dialog')
    dialog.title = title
    dialog.hint = hint
    dialog.input = input
    dialog.open()
    return dialog
}

/*!
    \qmlmethod UtilsJS::dumpPvInfo(pv)
*/
function dumpPvInfo(pv) {
    var date = new Date()
    var text
    text = '           PV Infomation\n\n'
    text += date + '\n\n'
    text += pv.channel + '\n'
    text += '======================================\n'
    if (!pv.connected) {
        text += 'diconnected'
        return text
    }

    text += 'TYPE: %1\n'.arg(pv.type)
    text += 'COUNT: %1\n'.arg(pv.count)
    text += 'ACCESS: '
    if (pv.readable)
        text += 'R'
    if (pv.writable)
        text += 'W'
    text += '\n'
    text += 'HOST: %1\n'.arg(pv.host)
    text += 'VALUE: %1\n'.arg(pv.value)
    text += 'STAMP: %1\n'.arg(pv.stamp)
    // PV type specific information
    text += '\n'
    if (pv.type == PvComponents.PvObject.Float || pv.type == PvComponents.PvObject.Double)
        text += 'PRECISION: %1\n'.arg(pv.prec)
    if (pv.lodisplim != pv.updisplim)
        text += 'HOPR: %1  LOPR %2\n'.arg(pv.updisplim).arg(pv.lodisplim)

    if (pv.nostr != 0)
        text += 'STATES: %1\n'.arg(pv.nostr)
    for(var i=0; i<pv.strs.length; i++) {
        text += 'STATE %1: %2\n'.arg(i).arg(pv.strs[i])
    }
    return text
}
