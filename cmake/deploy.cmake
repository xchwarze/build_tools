function(get_envs)
    message(STATUS CMAKE_SYSTEM_PROCESSOR: ${CMAKE_SYSTEM_PROCESSOR})
    if ("${CMAKE_SYSTEM_PROCESSOR}" STREQUAL "x86_64")
        set(X_PROJECT_ARCH "amd64" PARENT_SCOPE)
    endif()
    message(STATUS ${X_PROJECT_ARCH})
    set(X_PROJECT_OSNAME "Ubuntu" PARENT_SCOPE)
endfunction()

function(deploy_init)
    get_envs()

    #set(CPACK_SOURCE_GENERATOR "ZIP")
    set(CPACK_INCLUDE_TOPLEVEL_DIRECTORY OFF)
    set(CPACK_OUTPUT_FILE_PREFIX packages)
    set(CPACK_RESOURCE_FILE_LICENSE "${PROJECT_SOURCE_DIR}/../LICENSE")
    set(CPACK_RESOURCE_FILE_README "${PROJECT_SOURCE_DIR}/../README.md")

    file (STRINGS "${PROJECT_SOURCE_DIR}/../release_version.txt" CPACK_PACKAGE_VERSION)

    message(STATUS ${CPACK_SYSTEM_NAME})

    if(MSVC)
        if(${MSVC_VERSION} EQUAL 1800)
            set(CPACK_SYSTEM_NAME winxp)
        endif()
    endif()

    set(CPACK_DEBIAN_PACKAGE_NAME "${CPACK_PACKAGE_NAME}_${CPACK_PACKAGE_VERSION}_${X_PROJECT_OSNAME}_${X_PROJECT_ARCH}")

    include(CPack)
    message(STATUS ${CPACK_SYSTEM_NAME})
    message(STATUS ${CPACK_PACKAGE_FILE_NAME})
    message(STATUS qt_version_${QT_VERSION_MAJOR})
    message(STATUS "CPACK_DEBIAN_PACKAGE_NAME: ${CPACK_DEBIAN_PACKAGE_NAME}")
endfunction()

function(deploy_msvc)
    message(STATUS ${MSVC_TOOLSET_VERSION})
    if(MSVC)
        if(${MSVC_TOOLSET_VERSION} GREATER_EQUAL 142)
            set(VC_REDIST_DIR $ENV{VCToolsRedistDir}$ENV{Platform}/Microsoft.VC${MSVC_TOOLSET_VERSION}.CRT)
            string(REPLACE "\\" "/" VC_REDIST_DIR ${VC_REDIST_DIR})
            message(STATUS ${VC_REDIST_DIR})

            install (FILES "${VC_REDIST_DIR}/msvcp140.dll" DESTINATION "./" OPTIONAL)
            install (FILES "${VC_REDIST_DIR}/msvcp140_1.dll" DESTINATION "./" OPTIONAL)
            #install (FILES "${VC_REDIST_DIR}/msvcp140_2.dll" DESTINATION "./" OPTIONAL)
            install (FILES "${VC_REDIST_DIR}/vcruntime140.dll" DESTINATION "./"  OPTIONAL)
            install (FILES "${VC_REDIST_DIR}/vcruntime140_1.dll" DESTINATION "./" OPTIONAL)
        endif()
    endif()
endfunction()

function(deploy_qt)
    message(STATUS qt_version_${QT_VERSION_MAJOR})
    if (WIN32)
        string(REPLACE "\\" "/" CMAKE_PREFIX_PATH ${CMAKE_PREFIX_PATH})
        # Qt5
        if (NOT "${Qt5Core_VERSION}" STREQUAL "")
            install (FILES "${CMAKE_PREFIX_PATH}/bin/Qt5Core.dll" DESTINATION "./" OPTIONAL)
        endif()
        if (NOT "${Qt5Gui_VERSION}" STREQUAL "")
            install (FILES "${CMAKE_PREFIX_PATH}/bin/Qt5Gui.dll" DESTINATION "./" OPTIONAL)
            install (FILES "${CMAKE_PREFIX_PATH}/plugins/platforms/qwindows.dll" DESTINATION platforms OPTIONAL)
            install (FILES "${CMAKE_PREFIX_PATH}/plugins/imageformats/qjpeg.dll" DESTINATION imageformats OPTIONAL)
            install (FILES "${CMAKE_PREFIX_PATH}/plugins/imageformats/qtiff.dll" DESTINATION imageformats OPTIONAL)
            install (FILES "${CMAKE_PREFIX_PATH}/plugins/imageformats/qico.dll" DESTINATION imageformats OPTIONAL)
            install (FILES "${CMAKE_PREFIX_PATH}/plugins/imageformats/qgif.dll" DESTINATION imageformats OPTIONAL)
        endif()
        if (NOT "${Qt5Widgets_VERSION}" STREQUAL "")
            install (FILES "${CMAKE_PREFIX_PATH}/bin/Qt5Widgets.dll" DESTINATION "./" OPTIONAL)
        endif()
        if (NOT "${Qt5OpenGL_VERSION}" STREQUAL "")
            install (FILES "${CMAKE_PREFIX_PATH}/bin/Qt5OpenGL.dll" DESTINATION "./" OPTIONAL)
        endif()
        if (NOT "${Qt5Svg_VERSION}" STREQUAL "")
            install (FILES "${CMAKE_PREFIX_PATH}/bin/Qt5Svg.dll" DESTINATION "./" OPTIONAL)
        endif()
        if (NOT "${Qt5Sql_VERSION}" STREQUAL "")
            install (FILES "${CMAKE_PREFIX_PATH}/bin/Qt5Sql.dll" DESTINATION "./" OPTIONAL)
            install (FILES "${CMAKE_PREFIX_PATH}/plugins/sqldrivers/qsqlite.dll" DESTINATION sqldrivers OPTIONAL)
        endif()
        if (NOT "${Qt5Network_VERSION}" STREQUAL "")
            install (FILES "${CMAKE_PREFIX_PATH}/bin/Qt5Network.dll" DESTINATION "./" OPTIONAL)
        endif()
        if (NOT "${Qt5Script_VERSION}" STREQUAL "")
            install (FILES "${CMAKE_PREFIX_PATH}/bin/Qt5Script.dll" DESTINATION "./" OPTIONAL)
        endif()
        if (NOT "${Qt5ScriptTools_VERSION}" STREQUAL "")
            install (FILES "${CMAKE_PREFIX_PATH}/bin/Qt5ScriptTools.dll" DESTINATION "./" OPTIONAL)
        endif()
        #Qt6
        if (NOT "${Qt6Core_VERSION}" STREQUAL "")
            install (FILES "${CMAKE_PREFIX_PATH}/bin/Qt6Core.dll" DESTINATION "./" OPTIONAL)
        endif()
        if (NOT "${Qt6Gui_VERSION}" STREQUAL "")
            install (FILES "${CMAKE_PREFIX_PATH}/bin/Qt6Gui.dll" DESTINATION "./" OPTIONAL)
            install (FILES "${CMAKE_PREFIX_PATH}/plugins/platforms/qwindows.dll" DESTINATION platforms OPTIONAL)
            install (FILES "${CMAKE_PREFIX_PATH}/plugins/imageformats/qjpeg.dll" DESTINATION imageformats OPTIONAL)
            install (FILES "${CMAKE_PREFIX_PATH}/plugins/imageformats/qsvg.dll" DESTINATION imageformats OPTIONAL)
            install (FILES "${CMAKE_PREFIX_PATH}/plugins/imageformats/qico.dll" DESTINATION imageformats OPTIONAL)
            install (FILES "${CMAKE_PREFIX_PATH}/plugins/imageformats/qgif.dll" DESTINATION imageformats OPTIONAL)
        endif()
        if (NOT "${Qt6Widgets_VERSION}" STREQUAL "")
            install (FILES "${CMAKE_PREFIX_PATH}/bin/Qt6Widgets.dll" DESTINATION "./" OPTIONAL)
        endif()
        if (NOT "${Qt6OpenGL_VERSION}" STREQUAL "")
            install (FILES "${CMAKE_PREFIX_PATH}/bin/Qt6OpenGL.dll" DESTINATION "./" OPTIONAL)
        endif()
        if (NOT "${Qt6Svg_VERSION}" STREQUAL "")
            install (FILES "${CMAKE_PREFIX_PATH}/bin/Qt6Svg.dll" DESTINATION "./" OPTIONAL)
        endif()
        if (NOT "${Qt6Sql_VERSION}" STREQUAL "")
            install (FILES "${CMAKE_PREFIX_PATH}/bin/Qt6Sql.dll" DESTINATION "./")
            install (FILES "${CMAKE_PREFIX_PATH}/plugins/sqldrivers/qsqlite.dll" DESTINATION sqldrivers OPTIONAL)
        endif()
        if (NOT "${Qt6Network_VERSION}" STREQUAL "")
            install (FILES "${CMAKE_PREFIX_PATH}/bin/Qt6Network.dll" DESTINATION "./" OPTIONAL)
        endif()
        if (NOT "${Qt6Qml_VERSION}" STREQUAL "")
            install (FILES "${CMAKE_PREFIX_PATH}/bin/Qt6Qml.dll" DESTINATION "./" OPTIONAL)
        endif()
    endif()
endfunction()
