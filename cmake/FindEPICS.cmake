IF (NOT EPICS_BASE)
    SET (EPICS_ROOT $ENV{EPICS})
    IF (EPICS_ROOT)
        SET(EPICS_BASE "${EPICS_ROOT}/base")
    ELSE ()
        SET(EPICS_BASE $ENV{EPICS_BASE})
    ENDIF ()
ENDIF ()

IF (NOT EPICS_HOST_ARCH)
    SET (EPICS_HOST_ARCH $ENV{EPICS_HOST_ARCH})
ENDIF()

IF (NOT IS_DIRECTORY ${EPICS_BASE})
    MESSAGE(FATAL_ERROR "EPICS base could not be located. Please define EPICS_BASE and EPICS_HOST_ARCH")
ENDIF ()

IF (WIN32)
    SET(OSCLASS "WIN32")
ELSEIF (APPLE)
    SET(OSCLASS "Darwin")
ELSEIF (UNIX)
    SET(OSCLASS "Linux")
ENDIF()

SET (EPICS_INCLUDE_DIRS
    ${EPICS_BASE}/include
    ${EPICS_BASE}/include/os/${OSCLASS} 
)

SET( EPICS_LIBRARY_DIRS
    ${EPICS_BASE}/lib/${EPICS_HOST_ARCH}
)

FIND_LIBRARY (EPICS_CA_LIBRARY NAMES ca HINTS ${EPICS_LIBRARY_DIRS})
FIND_LIBRARY (EPICS_COM_LIBRARY NAMES Com HINTS ${EPICS_LIBRARY_DIRS})
SET(EPICS_LIBRARIES ${EPICS_CA_LIBRARY} ${EPICS_COM_LIBRARY})
