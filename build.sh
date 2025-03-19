#!/usr/bin/env bash

# Значение по умолчанию
TARGET=""

# Обработка аргументов командной строки
for arg in "$@"; do
    case $arg in
        target=*) TARGET="${arg#*=}" ;;
    esac
done

echo "Сборка для $TARGET..."

KOMPILER="unknown_command"
LINKER="unknown_command"

# Проверяем значение TARGET
if [[ "$TARGET" == "linux" ]]; then
    echo "Компиляция для Linux..."
    KOMPILER="g++"
    LINKER="ar"


    $KOMPILER -c rlwr.cpp \
        -I.                            \
        -I../sol2/single/include       \
        -L../lua                       \
        -I../lua                       \
        -I../raylib/raylib/include     \
        -L../raylib/raylib/            \
        -lm                            \
        -llua                          \
        -lraylib                       \
        -o rlwr.o                      \

    $LINKER rcs librlwr.a rlwr.o

elif [[ "$TARGET" == "wasm" ]]; then
    echo "Компиляция для wasm..."
    KOMPILER="emcc"
    LINKER="emar"

    #cmd="$KOMPILER -c rlwr.cpp ../raylib/src/libraylib.a ../lua/liblua.a -I../lua -I../raylib/src -I../sol2/single/include -o rlwr.o "

    cmd="$KOMPILER -c rlwr.cpp -I../lua -I../raylib/src -I../sol2/single/include -o rlwr.o "
    #-DLUA_VERSION_NUM=505

    echo "cmd '$cmd'"
    $cmd

    $LINKER rcs librlwr.a rlwr.o

else
    echo "Неизвестная цель: $TARGET"
    exit 1
fi

