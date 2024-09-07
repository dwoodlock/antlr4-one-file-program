# minimum required CMAKE version
CMAKE_MINIMUM_REQUIRED(VERSION 3.7 FATAL_ERROR)

project(antlr-cpp-test)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/antlr/cmake)

set(CMAKE_CXX_STANDARD 17)

# required if linking to static library
add_definitions(-DANTLR4CPP_STATIC)

# using /MD flag for antlr4_runtime (for Visual C++ compilers only)
set(ANTLR4_WITH_STATIC_CRT OFF)

# Specify the version of the antlr4 library needed for this project.
# By default the latest version of antlr4 will be used.  You can specify a
# specific, stable version by setting a repository tag value or a link
# to a zip file containing the libary source.
set(ANTLR4_TAG 4.13.2)

# add external build for antlrcpp
include(ExternalAntlr4Cpp)
# add antlr4cpp artifacts to project environment
include_directories(${ANTLR4_INCLUDE_DIRS})

# set variable pointing to the antlr tool that supports C++
# this is not required if the jar file can be found under PATH environment
set(ANTLR_EXECUTABLE "${CMAKE_CURRENT_SOURCE_DIR}/antlr/jar/antlr-4.13.2-complete.jar")
# add macros to generate ANTLR Cpp code from grammar
find_package(ANTLR REQUIRED)

# Call macro to add lexer and grammar to your build dependencies.
# antlr_target(SampleGrammarLexer ExprLexer.g4 LEXER
#              PACKAGE antlrcpptest)
# antlr_target(SampleGrammarParser ExprParser.g4 PARSER
#              PACKAGE antlrcpptest
#              DEPENDS_ANTLR SampleGrammarLexer
#              COMPILE_FLAGS -lib ${ANTLR_SampleGrammarLexer_OUTPUT_DIR} VISITOR LISTENER)
antlr_target(SampleGrammar Expr.g4
             PACKAGE antlrcpptest
             COMPILE_FLAGS -lib ${ANTLR_SampleGrammar_OUTPUT_DIR} VISITOR LISTENER)


# include generated files in project environment
include_directories(${ANTLR_SampleGrammar_OUTPUT_DIR})

# add generated grammar to demo binary target
add_executable(antlr-cpp-test main.cpp
               ${ANTLR_SampleGrammar_CXX_OUTPUTS})
target_link_libraries(antlr-cpp-test antlr4_static)