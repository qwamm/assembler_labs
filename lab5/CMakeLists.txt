cmake_minimum_required(VERSION 3.2)
project(jpegedge C)

add_compile_options(-fopenmp)
add_link_options(-fopenmp)

# source files
set(JPEGEDGE_SOURCE_FILES
        jpegedge.c
        )

find_library (JPEG_LIB NAMES libjpeg jpeg)
find_library (PNG_LIB NAMES libpng png)
include_directories(/usr/include /usr/local/include /opt/local/include)

add_executable(jpegedge ${JPEGEDGE_SOURCE_FILES})
target_link_libraries(jpegedge ${JPEG_LIB} ${PNG_LIB} m)
install(TARGETS jpegedge DESTINATION bin)
