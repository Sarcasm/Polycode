# Locate libRocket libraries.
#
# This module defines:
# - libRocket_FOUND (TRUE if the library is found, FALSE otherwise)
# - libRocket_INCLUDE_DIRS (to use in include_directories(<...>) statements)
# - libRocket_LIBRARIES (to use in target_link_libraries(<...>) statements)
# - libRocket_<COMPONENT>_LIBRARY (to the path of the library)
#   Known components are: Core, Controls and Debugger.

# load all components by default
IF(NOT libRocket_FIND_COMPONENTS)
  SET(libRocket_FIND_COMPONENTS Core Controls Debugger)
ENDIF()

FIND_PATH(libRocket_INCLUDE_DIR Rocket/Core.h
          HINTS ${libRocket_ROOT}/Include)

SET(libRocket_FOUND TRUE) # will be set to false if one of the required modules is not found

FOREACH(COMPONENT ${libRocket_FIND_COMPONENTS})
  STRING(TOUPPER ${COMPONENT} UPPERCOMPONENT)

  FIND_LIBRARY(libRocket_${UPPERCOMPONENT}_RELEASE_LIBRARY
    NAMES Rocket${COMPONENT}
    PATHS ${libRocket_ROOT}
    PATH_SUFFIXES Build bin)

  FIND_LIBRARY(libRocket_${UPPERCOMPONENT}_DEBUG_LIBRARY
    NAMES Rocket${COMPONENT}_d
    PATHS ${libRocket_ROOT}
    PATH_SUFFIXES Build bin)

  IF(libRocket_${UPPERCOMPONENT}_RELEASE_LIBRARY)
    IF(libRocket_${UPPERCOMPONENT}_DEBUG_LIBRARY)
      SET(libRocket_LIBRARIES
        ${libRocket_LIBRARIES}
        optimized ${libRocket_${UPPERCOMPONENT}_RELEASE_LIBRARY}
        debug  ${libRocket_${UPPERCOMPONENT}_DEBUG_LIBRARY})
    ELSE()
      # library found - add to the global list of libraries
      SET(libRocket_LIBRARIES
        ${libRocket_LIBRARIES}
        ${libRocket_${UPPERCOMPONENT}_RELEASE_LIBRARY})
    ENDIF()

    MARK_AS_ADVANCED(libRocket_${UPPERCOMPONENT}_RELEASE_LIBRARY
                     libRocket_${UPPERCOMPONENT}_DEBUG_LIBRARY)
  ELSE()
    # library not found
    SET(libRocket_${UPPERCOMPONENT}_RELEASE_LIBRARY "")

    IF(libRocket_FIND_REQUIRED_${COMPONENT})
      # not found...and required, this is an error
      SET(libRocket_FOUND FALSE)

      # save missing components
      SET(libRocket_FIND_MISSING ${libRocket_FIND_MISSING} ${COMPONENT})
    ELSE()
      # optionnal not found - save the missing component
      SET(libRocket_FIND_OPT_MISSING ${libRocket_FIND_OPT_MISSING} ${COMPONENT})
    ENDIF()
  ENDIF()
ENDFOREACH()

IF(NOT libRocket_FIND_QUIETLY AND libRocket_FIND_OPT_MISSING)
  MESSAGE(STATUS "libRocket Optionnal component(s): ${libRocket_FIND_OPT_MISSING} - not found")
ENDIF()

IF(libRocket_FOUND)
  MESSAGE(STATUS "Found libRocket: ${libRocket_INCLUDE_DIR}")
  SET(libRocket_INCLUDE_DIRS ${libRocket_INCLUDE_DIR})
ELSE()
  IF(libRocket_FIND_REQUIRED)
    # fatal error
    MESSAGE(FATAL_ERROR "Missing component(s): ${libRocket_FIND_MISSING}")
  ELSEIF(NOT libRocket_FIND_QUIETLY)
    # error but continue
    MESSAGE("Missing components: ${libRocket_FIND_MISSING}")
  ENDIF()
ENDIF()
