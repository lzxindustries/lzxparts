cmake_minimum_required(VERSION 3.3)
set(AHK_SCRIPTS_DIR ${CMAKE_CURRENT_SOURCE_DIR})

set(SCRIPT_FILES
    ${CMAKE_CURRENT_SOURCE_DIR}/export-pcb-6layers.exe
)


set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_COLOR_MAKEFILE   ON)


add_custom_target(ScriptExport ALL 
    DEPENDS ${SCRIPT_FILES}
)

add_custom_command(OUTPUT ${SCRIPT_FILES}  
    COMMAND Ahk2Exe.exe /in export-pcb-6layers.ahk /out export-pcb-6layers.exe
    WORKING_DIRECTORY ${AHK_SCRIPTS_DIR}
)

install(FILES ${SCRIPT_FILES} DESTINATION ${CMAKE_CURRENT_BINARY_DIR})

# set(LZX_CMAKE_SCRIPTS_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules)
# set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${LZX_CMAKE_SCRIPTS_DIR})

# include(LZXMakeVersion)

#Ahk2Exe.exe /in MyScript.ahk [/out MyScript.exe] [/icon MyIcon.ico] [/bin AutoHotkeySC.bin] [/mpress 0or1]


# project(${LZX_PROJECT_NAME} VERSION 0)
# include(CPack)

# install(FILES "pcb/MyPCB/MyPCB.dip" DESTINATION "build")

# set(CPACK_GENERATOR "ZIP")
# set(CPACK_PACKAGE_FILE_NAME ${LZX_PROJECT_NAME}-${LZX_HARDWARE_VERSION}-RS274X)
