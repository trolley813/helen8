project(h8c)

find_package(BISON)
find_package(FLEX)

set(SOURCES src/h8_ast.c src/h8_main.c)

BISON_TARGET(h8_parser grammar/h8_parser.y ${CMAKE_CURRENT_BINARY_DIR}/h8_parser.tab.c)
FLEX_TARGET(h8_scanner grammar/h8_lexer.l  ${CMAKE_CURRENT_BINARY_DIR}/h8_lexer.tab.c)
ADD_FLEX_BISON_DEPENDENCY(h8_scanner h8_parser)

include_directories(${CMAKE_CURRENT_BINARY_DIR})
include_directories(include)
add_executable(h8c ${SOURCES} ${BISON_h8_parser_OUTPUTS} ${FLEX_h8_scanner_OUTPUTS})
