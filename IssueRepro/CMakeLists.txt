set(PROJECT_NAME IssueRepro)

################################################################################
# Source groups
################################################################################
set(Header_Files
    "framework.h"
        "pch.h"
        )
source_group("Header Files" FILES ${Header_Files})

set(Source_Files
        "dllmain.cpp"
        "pch.cpp"
)
source_group("Source Files" FILES ${Source_Files})

set(Source_Files__Test_Code
        "Testing.cpp"
)
source_group("Source Files\\Test Code" FILES ${Source_Files__Test_Code})

set(ALL_FILES
    ${Header_Files}
    ${Source_Files}
    ${Source_Files__Test_Code}
)

################################################################################
# DDL Target
################################################################################
add_library(${PROJECT_NAME} SHARED ${ALL_FILES})

target_precompile_headers(${PROJECT_NAME} PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/pch.h")

use_props(${PROJECT_NAME} "${CMAKE_CONFIGURATION_TYPES}" "${DEFAULT_CXX_PROPS}")
set(ROOT_NAMESPACE DevAnalyticsPlugin)

set_target_properties(${PROJECT_NAME} PROPERTIES VS_GLOBAL_KEYWORD "Win32Proj")
set_target_properties(${PROJECT_NAME} PROPERTIES INTERPROCEDURAL_OPTIMIZATION_RELEASE "TRUE")

get_property(MSVC_RUNTIME_LIBRARY_DEFAULT TARGET ${PROJECT_NAME} PROPERTY MSVC_RUNTIME_LIBRARY)
set_target_properties(${PROJECT_NAME} PROPERTIES MSVC_RUNTIME_LIBRARY "MultiThreadedDLL")
# set_target_properties(${PROJECT_NAME}Test PROPERTIES MSVC_RUNTIME_LIBRARY ${MSVC_RUNTIME_LIBRARY_DEFAULT})

target_compile_definitions(${PROJECT_NAME} PRIVATE "WIN32;NDEBUG;_WINDOWS;_USRDLL;_MBCS")

if(MSVC)
    target_compile_options(${PROJECT_NAME} PRIVATE "/Oi;/GF;/Gy;/W3;${DEFAULT_CXX_DEBUG_INFORMATION_FORMAT};${DEFAULT_CXX_EXCEPTION_HANDLING}")
    target_link_options(${PROJECT_NAME} PRIVATE "/DEBUG;/SUBSYSTEM:CONSOLE;/OPT:REF;/INCREMENTAL:NO")
endif()

set(ADDITIONAL_LIBRARY_DEPENDENCIES "odbc32;odbccp32;libmariadb")
target_link_libraries(${PROJECT_NAME} PUBLIC "${ADDITIONAL_LIBRARY_DEPENDENCIES}")


################################################################################
# Testing Executable Target
################################################################################
add_executable(${PROJECT_NAME}Test ${ALL_FILES})

target_precompile_headers(${PROJECT_NAME}Test PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/pch.h")

use_props(${PROJECT_NAME}Test "${CMAKE_CONFIGURATION_TYPES}" "${DEFAULT_CXX_PROPS}")

set_target_properties(${PROJECT_NAME}Test PROPERTIES VS_GLOBAL_KEYWORD "Win32Proj")
set_target_properties(${PROJECT_NAME}Test PROPERTIES INTERPROCEDURAL_OPTIMIZATION_RELEASE "TRUE")

#get_property(MSVC_RUNTIME_LIBRARY_DEFAULT TARGET ${PROJECT_NAME}Test PROPERTY MSVC_RUNTIME_LIBRARY)
# set_target_properties(${PROJECT_NAME}Test PROPERTIES MSVC_RUNTIME_LIBRARY ${MSVC_RUNTIME_LIBRARY_DEFAULT})

target_compile_definitions(${PROJECT_NAME}Test PRIVATE "WIN32")

if(MSVC)
    target_compile_options(${PROJECT_NAME}Test PRIVATE "${DEFAULT_CXX_DEBUG_INFORMATION_FORMAT};${DEFAULT_CXX_EXCEPTION_HANDLING}")
    target_link_options(${PROJECT_NAME}Test PRIVATE "/DEBUG:FULL")
endif()

target_link_libraries(${PROJECT_NAME}Test PUBLIC "${ADDITIONAL_LIBRARY_DEPENDENCIES}")

