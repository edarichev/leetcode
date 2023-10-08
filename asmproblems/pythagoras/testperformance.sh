#! /bin/bash
make

./buildc.sh

echo Assembler version...
time ./pythagoras

echo C version...
time ./pythc
