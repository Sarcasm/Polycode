INCLUDE(ExternalProject)

SET(librocket_PREFIX ${PROJECT_BINARY_DIR}/librocket)

# Needs fpic to link in shared lib on Linux
#IF(CMAKE_COMPILER_IS_GNUCXX)
#    SET(librocket_CXX_ARGS -DCMAKE_CXX_FLAGS=-fPIC)
#ENDIF(CMAKE_COMPILER_IS_GNUCXX)

SET(librocket_CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
    -DCMAKE_OSX_ARCHITECTURES=${CMAKE_OSX_ARCHITECTURES}
    -DCMAKE_DEBUG_POSTFIX=_d 
    -DBUILD_SAMPLES=OFF
    -DBUILD_SHARED_LIBS=OFF
    ${librocket_CXX_ARGS}
)

IF(CMAKE_SYSTEM_NAME MATCHES "Linux")
  #libs can end up in lib64/ on Linux otherwise
  SET(librocket_CMAKE_ARGS ${librocket_CMAKE_ARGS}
      -DCMAKE_INSTALL_LIBDIR:PATH=<INSTALL_DIR>/lib)
ENDIF()

ExternalProject_Add(librocket
    PREFIX ${librocket_PREFIX}

    DOWNLOAD_DIR ${POLYCODE_DEPS_DOWNLOAD_DIR}

    GIT_REPOSITORY https://github.com/lloydw/libRocket.git
    GIT_TAG cc0312f0ecc7ae8166249d7c2e7ce2f5cb92684f

    # LibRocket's source isn't in the top level directory so add a dummy file to set cmake right
    PATCH_COMMAND ${CMAKE_COMMAND} -E echo ADD_SUBDIRECTORY(Build) > <SOURCE_DIR>/CMakeLists.txt
    
    INSTALL_DIR ${POLYCODE_DEPS_MODULES_PREFIX}
    CMAKE_ARGS ${librocket_CMAKE_ARGS}
)
