cmake_minimum_required(VERSION 3.29)

project(
  ImageCraft
  VERSION 0.1
  LANGUAGES CXX)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.7)

qt_add_executable(appImageCraft main.cpp)

qt_add_qml_module(
  appImageCraft
  URI
  ImageCraft
  VERSION
  1.0
  QML_FILES
  SOURCES
  RESOURCES
  README.md
  QML_FILES
  Tags.qml
  RCenter.qml
  LCenter.qml
  ImageCraft.qml
  ICFooter.qml
  ICContent.qml
  RESOURCES
  modules/se/qt/toolBar/qmldir
  QML_FILES
  modules/se/qt/toolBar/Zoom_toolBar.qml
  modules/se/qt/toolBar/Word_toolBar.qml
  modules/se/qt/toolBar/Straw_toolBar.qml
  modules/se/qt/toolBar/Rectangle_toolBar.qml
  modules/se/qt/toolBar/MyToolBar.qml
  modules/se/qt/toolBar/MoveToolBar.qml
  modules/se/qt/toolBar/Move_toolBar.qml
  modules/se/qt/toolBar/Line_toolBar.qml
  modules/se/qt/toolBar/Lasso_toolBar.qml
  modules/se/qt/toolBar/Grip_toolBar.qml
  modules/se/qt/toolBar/Frame_toolBar.qml
  modules/se/qt/toolBar/Eraser_toolBar.qml
  modules/se/qt/toolBar/Cutout_toolBar.qml
  modules/se/qt/toolBar/Choice_toolBar.qml
  modules/se/qt/toolBar/Brush_toolBar.qml
  modules/se/qt/toolBar/Boxselect_toolBar.qml
  RESOURCES
  modules/se/qt/menu/qmldir
  QML_FILES
  modules/se/qt/menu/MyMenuItem.qml
  modules/se/qt/menu/MyMenu.qml
  modules/se/qt/menu/Menu_View.qml
  modules/se/qt/menu/Menu_Swatches.qml
  modules/se/qt/menu/Menu_Setting.qml
  modules/se/qt/menu/Menu_Layer.qml
  modules/se/qt/menu/Menu_Help.qml
  modules/se/qt/menu/Menu_Graphics.qml
  modules/se/qt/menu/Menu_Filter.qml
  modules/se/qt/menu/Menu_File.qml
  modules/se/qt/menu/Menu_Edit.qml
  SOURCES
  editor.h
  editor.cpp
  RESOURCES
  res.qrc
  SOURCES
  imageprovider.cpp
  imageprovider.h
  activectrl.h
  activectrl.cpp
  QML_FILES
  DialogBox.qml
  SOURCES
  activectrl.cpp
  activectrl.h
  QML_FILES
  EditorView.qml
  SOURCES
  toolctrl.cpp
  toolctrl.h
  SOURCES
  toolctrl.cpp
  toolctrl.h
  SOURCES
  QML_FILES
  Layer.qml
  QML_FILES
  SelectBox.qml)

target_compile_features(appImageCraft PRIVATE cxx_std_20)

set_target_properties(
  appImageCraft
  PROPERTIES AUTORCC TRUE
             MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
             MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
             MACOSX_BUNDLE_SHORT_VERSION_STRING
             ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
             MACOSX_BUNDLE TRUE
             WIN32_EXECUTABLE TRUE)

target_link_libraries(appImageCraft PRIVATE Qt6::Quick)

target_link_libraries(
  appImageCraft
  PRIVATE Qt6::Quick
          # /usr/lib \                  # OpenCV的lib路径
          opencv_core
          opencv_imgproc
          opencv_highgui
          opencv_imgcodecs
          opencv_xphoto)
# 其他需要的OpenCV模块库)

include(GNUInstallDirs)
install(
  TARGETS appImageCraft
  BUNDLE DESTINATION .
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
include_directories(/usr/include/opencv4)

# qt_add_executable(ImageCraft)  //Creates and finalizes an application target
# of a platform-specific type. This command performs the following tasks: 1.
# Create a CMake target of the appropriate type for the target platform. 2. Link
# the target to the Qt::Core library. 3. Handle finalization of the CMake
# target.

# qt_standard_project_setup()     #set(CMAKE_AUTOUIC ON)  set(CMAKE_AUTOMOC ON)

# @if %{HasTranslation} find_package(Qt6 REQUIRED COMPONENTS Core Quick
# LinguistTools) @else find_package(Qt6 REQUIRED COMPONENTS Core Quick) @endif

# target_sources(appImageCraft PRIVATE main.cpp qml.qrc @if %{HasTranslation}
# %{TsFileName} @endif
#
# PUBLIC
#
# )

# qt_import_qml_plugins(ImageCraft)

# cmake_minimum_required(VERSION 3.16)
#
# project(ImageCraft VERSION 0.1 LANGUAGES CXX)
#
# @if !true set(CMAKE_AUTOMOC ON) @endif set(CMAKE_CXX_STANDARD_REQUIRED ON)
#
# find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)
#
# @if true @if true qt_standard_project_setup(REQUIRES 6.5) @else
# qt_standard_project_setup() @endif @endif
#
# qt_add_executable(appImageCraft main.cpp )
#
# qt_add_qml_module(appImageCraft URI ImageCraft VERSION 1.0 QML_FILES Main.qml
# )
#
# # Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1. #
# If you are developing for iOS or macOS you should consider setting an #
# explicit, fixed bundle identifier manually though.
# set_target_properties(appImageCraft PROPERTIES # MACOSX_BUNDLE_GUI_IDENTIFIER
# com.example.appImageCraft MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
# MACOSX_BUNDLE_SHORT_VERSION_STRING
# ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR} MACOSX_BUNDLE TRUE
# WIN32_EXECUTABLE TRUE )
#
# target_link_libraries(appImageCraft PRIVATE Qt6::Quick )
#
# include(GNUInstallDirs) install(TARGETS appImageCraft BUNDLE DESTINATION .
# LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR} RUNTIME DESTINATION
# ${CMAKE_INSTALL_BINDIR} )
