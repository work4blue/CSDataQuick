set(CMAKE_AUTORCC ON)

set(SOURCES
    plugin.cpp
    shapes.cpp
    qcustomplot.cpp
    plotitem.cpp
    baseitem.cpp
    windowmanager.cpp
    attribute.cpp
    adimage.cpp
    csimageitem.cpp
    mjpeg.cpp
    textformatter.cpp
    imageprovider.cpp
)

set(HEADERS
    plugin.h
    shapes.h
    qcustomplot.h
    plotitem.h
    baseitem.h
    windowmanager.h
    attribute.h
    adimage.h
    csimageitem.h
    mjpeg.h
    textformatter.h
    imageprovider.h
)

if (CMAKE_VERSION VERSION_LESS 3.0)
    qt5_add_resources(RESOURCES
        components.qrc
    )
else ()
    set(RESOURCES
        components.qrc
    )
endif()

set(QML_JS_FILES
    qmldir
    plugins.qmltypes
    BaseWindow.qml
    CS2DSscan.qml
    CSADImage.qml
    CSArc.qml
    CSBar.qml
    CSByte.qml
    CSCartesianPlot.qml
    CSChoiceButton.qml
    CSComposite.qml
    CSControl.qml
    CSGraphics.qml
    CSImage.qml
    CSIndicator.qml
    CSMenu.qml
    CSMessageButton.qml
    CSMeter.qml
    CSMJPEGVideo.qml
    CSMonitor.qml
    CSOval.qml
    CSPolygon.qml
    CSPolyline.qml
    CSRect.qml
    CSRelatedDisplay.qml
    CSShellCommand.qml
    CSSlider.qml
    CSSpinBox.qml
    CSStripChart.qml
    CSTextArea.qml
    CSTextEntry.qml
    CSTextEntryArray.qml
    CSTextUpdate.qml
    CSText.qml
    CSToggleButton.qml
    CSWheelSwitch.qml
    utils.js
    ColorMap.qml
    DisplayListDialog.qml
    DataInfoDialog.qml
    DataLimitsDialog.qml
    DataTableDialog.qml
    PromptDialog.qml
    Private/qmldir
    Private/ContextMenu.qml
    Private/GroupBoxStyle.qml
    Private/Indicator.qml
    Private/Meter.qml
    Private/Palette.qml
    Private/TextSingleton.qml
    Private/SliderControl.qml
    Private/StyledAxis.qml
    Private/StyledBar.qml
    Private/StyledButton.qml
    Private/StyledCheckBox.qml
    Private/StyledFrame.qml
    Private/StyledTextEntry.qml
    Private/WheelDigit.qml
    Private/WheelSwitch.qml
    Private/images/arrow-down.png
    Private/images/arrow-down-focus.png
    Private/images/arrow-up.png
    Private/images/arrow-up-focus.png
    Private/images/button_down.png
    Private/images/button_up.png
    Private/images/focusframe.png
    Private/images/groove_horz.png
    Private/images/groove_vert.png
    Private/images/groupbox.png
    designer/qmldir
    designer/AligmentHorizontalButtonsFix.qml
    designer/BaseWindowSpecifics.qml
    designer/CS2DSscanSpecifics.qml
    designer/CSADImageSpecifics.qml
    designer/CSArcSpecifics.qml
    designer/CSBarSpecifics.qml
    designer/CSByteSpecifics.qml
    designer/CSCartesianPlotSpecifics.qml
    designer/CSCompositeSpecifics.qml
    designer/CSChoiceButtonSpecifics.qml
    designer/CSImageSpecifics.qml
    designer/CSIndicatorSpecifics.qml
    designer/CSMenuSpecifics.qml
    designer/CSMessageButtonSpecifics.qml
    designer/CSMeterSpecifics.qml
    designer/CSMJPEGVideoSpecifics.qml
    designer/CSOvalSpecifics.qml
    designer/CSPolygonSpecifics.qml
    designer/CSPolylineSpecifics.qml
    designer/CSRectSpecifics.qml
    designer/CSRelatedDisplaySpecifics.qml
    designer/CSShellCommandSpecifics.qml
    designer/CSSliderSpecifics.qml
    designer/CSSpinBoxSpecifics.qml
    designer/CSStripChartSpecifics.qml
    designer/CSTextSpecifics.qml
    designer/CSTextAreaSpecifics.qml
    designer/CSTextEntrySpecifics.qml
    designer/CSTextEntryArraySpecifics.qml
    designer/CSTextUpdateSpecifics.qml
    designer/CSToggleButtonSpecifics.qml
    designer/CSWheelSwitchSpecifics.qml
    designer/CartesianPlotEditor.qml
    designer/ColorSection.qml
    designer/ColorPalette.qml
    designer/ComboBoxFix.qml
    designer/CommandEditor.qml
    designer/DataSourceSection.qml
    designer/DisplayEditor.qml
    designer/DynamicAttributeSection.qml
    designer/FieldEditor.qml
    designer/GraphicsSection.qml
    designer/IconButton.qml
    designer/LimitsSection.qml
    designer/PolylineEditor.qml
    designer/StripChartEditor.qml
    designer/TextFormatSection.qml
    designer/TextFontSection.qml
    designer/images/2dsscan.png
    designer/images/areaDetector.png
    designer/images/arc.png
    designer/images/bar.png
    designer/images/byte.png
    designer/images/cartesianPlot.png
    designer/images/choiceButton.png
    designer/images/composite.png
    designer/images/image.png
    designer/images/indicator.png
    designer/images/menu.png
    designer/images/messageButton.png
    designer/images/meter.png
    designer/images/mjpegvideo.png
    designer/images/oval.png
    designer/images/polygon.png
    designer/images/polyline.png
    designer/images/rectangle.png
    designer/images/relatedDisplay.png
    designer/images/shellCommand.png
    designer/images/slider.png
    designer/images/spinbox.png
    designer/images/stripChart.png
    designer/images/text.png
    designer/images/textArea.png
    designer/images/textEntry.png
    designer/images/textEntryArray.png
    designer/images/textUpdate.png
    designer/images/toggleButton.png
    designer/images/wheelSwitch.png
    designer/images/window.png
    designer/images/add.png
    designer/images/apply.png
    designer/images/arrow_down.png
    designer/images/arrow_up.png
    designer/images/delete.png
    designer/images/cursor-arrow.png
    designer/images/cursor-cross.png
    designer/csdatacomponents.metainfo
)

add_library(csdatacomponentsplugin MODULE
    ${SOURCES}
    ${HEADERS}
    ${RESOURCES}
    ${QML_JS_FILES}
)

target_compile_definitions(csdatacomponentsplugin PRIVATE
    $<$<CXX_COMPILER_ID:MSVC>:_CRT_SECURE_NO_WARNINGS>
    $<$<CONFIG:Debug>:QT_QML_DEBUG>
)

set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -DQT_QML_DEBUG ")

target_link_libraries(csdatacomponentsplugin
    PRIVATE
    Qt5::Core Qt5::Gui Qt5::Widgets Qt5::Quick Qt5::Concurrent Qt5::PrintSupport EPICS::Com parser csdata csutils
)
set_target_properties(csdatacomponentsplugin PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/qml/CSDataQuick/Components)

if(APPLE)
set_target_properties(csdatacomponentsplugin PROPERTIES
    INSTALL_RPATH "@loader_path/../../../lib"
)
endif()

foreach(FILE ${QML_JS_FILES})
    set(DST_QML_JS_FILES ${DST_QML_JS_FILES} ${CMAKE_BINARY_DIR}/qml/CSDataQuick/Components/${FILE})
endforeach()

add_custom_target(CopyQMLFiles ALL
    DEPENDS ${DST_QML_JS_FILES})

foreach(FILE ${QML_JS_FILES})
    # make subdirectory if not existing
    get_filename_component(DIR ${FILE} DIRECTORY)

    if (NOT IS_DIRECTORY ${CMAKE_BINARY_DIR}/qml/CSDataQuick/Components/${DIR})
        file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/qml/CSDataQuick/Components/${DIR})
    endif()
    # copy qml files prebuild
    add_custom_command(
        OUTPUT ${CMAKE_BINARY_DIR}/qml/CSDataQuick/Components/${FILE}
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${FILE} ${CMAKE_BINARY_DIR}/qml/CSDataQuick/Components/${DIR}
        DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/${FILE}
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    )
endforeach()

add_dependencies(csdatacomponentsplugin CopyQMLFiles)

install(TARGETS csdatacomponentsplugin DESTINATION ${KDE_INSTALL_QMLDIR}/CSDataQuick/Components)
foreach (file ${QML_JS_FILES})
    get_filename_component(dir ${file} DIRECTORY)
    install(FILES ${file} DESTINATION ${KDE_INSTALL_QMLDIR}/CSDataQuick/Components/${dir})
endforeach()
