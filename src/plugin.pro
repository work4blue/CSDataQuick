TEMPLATE = lib
CONFIG += plugin
QT += quick
-
TARGET = pvcomponentsplugin
DESTDIR = $$PWD/../PvComponents

# EPICS related
INCLUDEPATH += $$(EPICS_BASE)/include/
LIBS += -L$$(EPICS_BASE)/lib/$$(EPICS_HOST_ARCH) -lca -lCom

win32 {
    INCLUDEPATH += $$(EPICS_BASE)/include/os/WIN32
    QMAKE_CXXFLAGS += -D_MINGW
}
linux {
    INCLUDEPATH += $$(EPICS_BASE)/include/os/Linux
    LIBS += -Wl,-rpath=$$(EPICS_BASE)/lib/$$(EPICS_HOST_ARCH)
}
macx {
    INCLUDEPATH += $$(EPICS_BASE)/include/os/Darwin
}

SOURCES += \
    $$PWD/pvobject.cpp \
    $$PWD/adimageprovider.cpp \
    $$PWD/plugin.cpp \
    $$PWD/utils.cpp \
    $$PWD/shapes.cpp \
    $$PWD/conversion.c

HEADERS += \
    $$PWD/pvobject.h \
    $$PWD/adimageprovider.h \
    $$PWD/plugin.h \
    $$PWD/utils.h \
    $$PWD/shapes.h
