#!/usr/bin/env bash

# TODO: Поменять версию Луа. Использовать 3rdparty библиотеки.
g++ -c rlwr.cpp -fPIC -std=c++2a -I. -Isol -I/usr/include/lua5.3 -lm -llua5.3 -lraylib -Iraylib/raylib/include -Lraylib/raylib/
