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

