cmake_minimum_required (VERSION 2.6)

find_package(PkgConfig)

set(MY_PROJECT_NAME OpenSiv3D)
if (APPLE)
  project(${MY_PROJECT_NAME}.app CXX)
elseif (UNIX)
  project(${MY_PROJECT_NAME} CXX)
endif (APPLE)

enable_language(C)

# 基本構成 {{{
set(CMAKE_CXX_COMPILER "clang++")
#set(CMAKE_CXX_COMPILER "g++")

if (APPLE)
  set(CMAKE_CXX_FLAGS "-std=c++17 -Wall -Wextra -Wno-unknown-pragmas -fvisibility=hidden")
  set(CMAKE_CXX_FLAGS_DEBUG "-g3 -O0 -DDEBUG")
  set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-g3 -Og")
elseif (UNIX)
  set(CMAKE_CXX_FLAGS "-std=c++17 -Wall -Wextra -Wno-unknown-pragmas -fPIC -msse4.1 -D_GLFW_X11")
  set(CMAKE_CXX_FLAGS_DEBUG "-g3 -O0 -pg -DDEBUG")
  set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-g3 -Og -pg")
endif (APPLE)


set(CMAKE_CXX_FLAGS_RELEASE "-O2 -DNDEBUG -march=x86-64")
set(CMAKE_CXX_FLAGS_MINSIZEREL "-Os -DNDEBUG -march=x86-64")

#set(CMAKE_BUILD_TYPE Release)

if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
  add_compile_options ("-fcolor-diagnostics")
elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
  add_compile_options ("-fdiagnostics-color=always")
endif()

# }}}

# ビルド対象のソース
set(SOURCE_FILES
  ${PROJECT_SOURCE_DIR}/src/Main.cpp
  )

# includeするやつ
include_directories(
  /usr/include

  ${PROJECT_SOURCE_DIR}/include
  ${PROJECT_SOURCE_DIR}/include/ThirdParty
  )


# Mac {{{
if (APPLE)
  # Frameworkの検索
  find_library(AudioToolbox_LIBRARY AudioToolbox)
  find_library(Foundation_LIBRARY Foundation)
  find_library(OpenAL_LIBRARY OpenAL)
  find_library(OpenGL_LIBRARY OpenGL)

  link_directories(
    ${PROJECT_SOURCE_DIR}/lib/macOS
    ${PROJECT_SOURCE_DIR}/lib/macOS/boost
    ${PROJECT_SOURCE_DIR}/lib/macOS/angelscript
    ${PROJECT_SOURCE_DIR}/lib/macOS/freetype
    ${PROJECT_SOURCE_DIR}/lib/macOS/glew
    ${PROJECT_SOURCE_DIR}/lib/macOS/harfbuzz
    ${PROJECT_SOURCE_DIR}/lib/macOS/libjpeg-turbo
    ${PROJECT_SOURCE_DIR}/lib/macOS/libpng
    ${PROJECT_SOURCE_DIR}/lib/macOS/libwebp
    ${PROJECT_SOURCE_DIR}/lib/macOS/opencv
    ${PROJECT_SOURCE_DIR}/lib/macOS/zlib
    ${PROJECT_SOURCE_DIR}/lib/macOS/libvorbis
    ${PROJECT_SOURCE_DIR}/lib/macOS/libogg
    ${PROJECT_SOURCE_DIR}/lib/macOS/libgif
    )

  set(APP_PROJECT_NAME ${MY_PROJECT_NAME})
  set(EXECUTABLE_NAME ${MY_PROJECT_NAME})
  set(PRODUCT_BUNDLE_IDENTIFIER "com.example")
  set(MACOSX_DEPLOYMENT_TARGET "10.14")

  set_source_files_properties(
    ${PROJECT_SOURCE_DIR}/icon.icns
    PROPERTIES
    MACOSX_PACKAGE_LOCATION "Resources"
    )

  add_executable(${MY_PROJECT_NAME} MACOSX_BUNDLE ${SOURCE_FILES} ${PROJECT_SOURCE_DIR}/icon.icns)

  add_custom_command(TARGET ${MY_PROJECT_NAME} PRE_BUILD
    COMMAND cp -r ${PROJECT_SOURCE_DIR}/engine ${MY_PROJECT_NAME}.app/Contents/Resources
    )

  set_target_properties(${MY_PROJECT_NAME} PROPERTIES MACOSX_BUNDLE_INFO_PLIST ${PROJECT_SOURCE_DIR}/Info-CMake.plist)

  target_link_libraries(${MY_PROJECT_NAME}
    ${AudioToolbox_LIBRARY}
    ${OpenGL_LIBRARY}
    ${OpenAL_LIBRARY}
    ${Foundation_LIBRARY}
    -lopencv_imgcodecs
    -lopencv_photo
    -lopencv_videoio
    -lopencv_objdetect
    -lopencv_core
    -lopencv_imgproc
    -lGLEW
    -langelscript
    -lpthread
    -ldl
    -lfreetype
    -lharfbuzz
    -lpng
    -lvorbis
    -lvorbisenc
    -lvorbisfile
    -lturbojpeg
    -logg
    -lwebp
    -lboost_filesystem
    -lz
    -lgif
    -lutil

    -lSiv3D
    )
# }}}
# Linux {{{
elseif (UNIX)
  # OpenCVライブラリの検索
  pkg_check_modules(OPENCV4 REQUIRED opencv4)

  link_directories(
    ${PROJECT_SOURCE_DIR}/lib/Linux
    )

  add_executable(${MY_PROJECT_NAME} ${SOURCE_FILES})

  target_link_libraries(${MY_PROJECT_NAME}
    ${OPENCV4_LIBRARIES}
    -lOpenGL
    -lGLEW
    -lX11
    -langelscript
    -lpthread
    -ldl
    -ludev
    -lfreetype
    -lharfbuzz
    -lglib-2.0
    -lgobject-2.0
    -lgio-2.0
    -lpng
    -lturbojpeg
    -lgif
    -lwebp
    -lopenal
    -logg
    -lvorbis
    -lvorbisenc
    -lvorbisfile
    -lboost_filesystem

    -lSiv3D # ${PROJECT_SOURCE_DIR}/lib/Linux 内に存在する
    )

endif (APPLE)
# }}}
