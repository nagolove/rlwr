#!/usr/bin/env bash

# TODO: Поменять версию Луа. Использовать 3rdparty библиотеки.
g++ -c rlwr.cpp                 \
    -fPIC -std=c++2a            \
    -I.                         \
    -Isol                       \
    -I../lua                    \
    -lm                         \
    -llua                       \
    -lraylib                    \
    -I../raylib/raylib/include  \
    -L../raylib/raylib/         \

ar rcs librlwr.a rlwr.o

