#!/usr/bin/env bash

g++ -c rlwr.cpp                 \
    -fPIC -std=c++2a            \
    -I.                         \
    -I../sol2/single/include    \
    -L../lua                    \
    -I../lua                    \
    -I../raylib/raylib/include  \
    -L../raylib/raylib/         \
    -lm                         \
    -llua                       \
    -lraylib                    \

ar rcs librlwr.a rlwr.o

