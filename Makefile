PROJ_DIR=${PWD}
SRC_DIR=${PROJ_DIR}/src
INC_DIR=${PROJ_DIR}/include
BIN_DIR=${PROJ_DIR}/bin
BUILD_DIR=${PROJ_DIR}/build

OBJS= ${BUILD_DIR}/foo.o ${BUILD_DIR}/goo.o ${BUILD_DIR}/myapp.o

CFLAGS= -g -Wall
SRCS := ${shell find ${SRC_DIR} -name "*.c"}

.SUFFIXES: .o .c

all: dep ${BIN_DIR}/myapp

${BIN_DIR}/myapp: ${OBJS}
	gcc ${CFLAGS} -o ${BIN_DIR}/myapp ${OBJS}

${BUILD_DIR}/%.o: ${SRC_DIR}/%.c
	gcc ${CFLAGS} -c $< -I${INC_DIR} -o $@

dep: .depend

.depend: ${SRCS}
	rm -f ./.depend
	gcc ${CFLAGS} -I${INC_DIR} -M $^ > ./.depend

include ./.depend

clean:
	rm -f ${BUILD_DIR}/*.o
	rm -f ${BIN_DIR}/*
	rm -f ./.depend
