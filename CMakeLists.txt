cmake_minimum_required(VERSION 3.27)

# Configs
set(FRAMEWORK_NAME "FearthGdk")
set(FRAMEWORK_BUNDLE_ID "com.fearth.gdk")
set(DEVICE_FAMILY "1,2") # iPhone & iPad

# Project setup
project(${FRAMEWORK_NAME})

# Enable Objective-C++ if required by `.mm` files
enable_language(OBJC OBJCXX)

# Specify the iOS platform
set(CMAKE_SYSTEM_NAME "iOS")
set(CMAKE_OSX_SYSROOT "iphoneos")
set(CMAKE_IOS_DEPLOYMENT_TARGET "12.0")
set(CMAKE_OSX_ARCHITECTURES "arm64;x86_64")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fobjc-arc") # Turn on ARC

# Info.plist
set(MACOSX_BUNDLE_INFO_STRING ${FRAMEWORK_BUNDLE_ID})
set(MACOSX_BUNDLE_GUI_IDENTIFIER ${FRAMEWORK_BUNDLE_ID})
set(MACOSX_BUNDLE_BUNDLE_NAME ${FRAMEWORK_BUNDLE_ID})

# Code signing
# To see info on a machine:
# /usr/bin/env xcrun security find-identity -v -p codesigning
set(CMAKE_XCODE_ATTRIBUTE_DEVELOPMENT_TEAM "4Y75FRX67J")
set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer")
set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_STYLE "Manual")

# source files & private headers
file(GLOB_RECURSE FRAMEWORK_SOURCES
    "${CMAKE_CURRENT_LIST_DIR}/src/*.m"
    "${CMAKE_CURRENT_LIST_DIR}/src/*.mm"
    "${CMAKE_CURRENT_LIST_DIR}/src/*.h"
)

# public headers
file(GLOB_RECURSE FRAMEWORK_HEADERS
    "${CMAKE_CURRENT_LIST_DIR}/include/*.h"
)

# include dirs
list(APPEND FRAMEWORK_INCLUDE_DIRS
    ${CMAKE_CURRENT_LIST_DIR}/include
)

# all headers and source files
list(APPEND FRAMEWORK_ALL_SOURCES ${FRAMEWORK_SOURCES} ${FRAMEWORK_HEADERS})

# Group source file
source_group("source" FILES ${FRAMEWORK_SOURCES})
source_group("include" FILES ${FRAMEWORK_HEADERS})

# Create the framework target for the iOS framework
add_library(${FRAMEWORK_NAME} SHARED ${FRAMEWORK_ALL_SOURCES})

# Use target_sources to explicitly mark headers as PUBLIC
target_sources(${FRAMEWORK_NAME} PUBLIC ${FRAMEWORK_HEADERS})

# Specify that this target is a framework
set_target_properties(${FRAMEWORK_NAME} PROPERTIES
    FRAMEWORK TRUE
    FRAMEWORK_VERSION A
    MACOSX_FRAMEWORK_IDENTIFIER ${FRAMEWORK_BUNDLE_ID}
    PUBLIC_HEADER "${FRAMEWORK_HEADERS}"
    XCODE_ATTRIBUTE_ENABLE_BITCODE "NO"
    XCODE_ATTRIBUTE_TARGETED_DEVICE_FAMILY ${DEVICE_FAMILY}
    XCODE_ATTRIBUTE_SKIP_INSTALL "YES"
)

# Specify the include directories for the framework
target_include_directories(${FRAMEWORK_NAME} PUBLIC ${FRAMEWORK_INCLUDE_DIRS})

# Frameworks
target_link_libraries(${FRAMEWORK_NAME} "-framework UIKit")
target_link_libraries(${FRAMEWORK_NAME} "-framework SafariServices")
# target_link_libraries(${FRAMEWORK_NAME} "-framework SystemConfiguration") # used by jsonmodel
