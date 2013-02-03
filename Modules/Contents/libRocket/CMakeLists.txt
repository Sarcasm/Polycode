INCLUDE(PolycodeIncludes)

SET(polycodelibRocket_SRCS
    Source/PolyRocketSystem.cpp
)

SET(polycodelibRocket_HDRS
    Include/PolycodeRocket.h
    Include/PolyRocketSystem.h
)

INCLUDE_DIRECTORIES(
    ${libRocket_INCLUDE_DIRS}
    Include
)

SET(CMAKE_DEBUG_POSTFIX "_d")

#IF(POLYCODE_BUILD_SHARED)
#ADD_LIBRARY(PolycodelibRocket SHARED ${polycodelibRocket_SRCS} ${polycodelibRocket_HDRS})
#TARGET_LINK_LIBRARIES(PolycodelibRocket ${libRocket_LIBRARIES})
#IF(APPLE)
#    TARGET_LINK_LIBRARIES(PolycodelibRocket
#        Polycore
#        ${OPENGL_LIBRARIES}
#        ${OPENAL_LIBRARY}
#        ${PNG_LIBRARIES}
#        ${FREETYPE_LIBRARIES}
#        ${PHYSFS_LIBRARY}
#        ${VORBISFILE_LIBRARY}
#        "-framework Cocoa")
#ENDIF(APPLE)
#ENDIF(POLYCODE_BUILD_SHARED)

#IF(POLYCODE_BUILD_STATIC)
ADD_LIBRARY(PolycodelibRocket ${polycodelibRocket_SRCS} ${polycodelibRocket_HDRS})
TARGET_LINK_LIBRARIES(PolycodelibRocket
    ${libRocket_LIBRARIES})
#ENDIF(POLYCODE_BUILD_STATIC)

MESSAGE(STATUS "LIBS:  ${libRocket_LIBRARIES}")

IF(POLYCODE_INSTALL_FRAMEWORK)
    
    # install headers
    INSTALL(FILES ${polycodelibRocket_HDRS} DESTINATION Modules/include)

    # install libraries
#    IF(POLYCODE_BUILD_SHARED)
    INSTALL(TARGETS PolycodelibRocket EXPORT PolycodelibRocket-targets DESTINATION Modules/lib)
#    ENDIF(POLYCODE_BUILD_SHARED)
#    IF(POLYCODE_BUILD_STATIC)
#        INSTALL(TARGETS PolycodelibRocket_static DESTINATION ${POLYCODE_RELEASE_DIR}/Framework/Modules/lib)
#    ENDIF(POLYCODE_BUILD_STATIC)

    INSTALL(EXPORT PolycodelibRocket-targets DESTINATION
        Modules/lib/PolycodelibRocket)
    
ENDIF(POLYCODE_INSTALL_FRAMEWORK)
