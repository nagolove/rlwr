#!/usr/bin/env bash

# Значение по умолчанию
TARGET="linux"

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
    KOMPILER="em++"
    LINKER="emar"

    $KOMPILER -c rlwr.cpp \
        -I.                            \
        -I../sol2/single/include       \
        -I../lua                       \
        -I../raylib/raylib/include     \
        ../raylib/raylib/libraylib.a   \
        ../lua/liblua.a                \
        -o rlwr.o                      \

    $LINKER rcs librlwr.a rlwr.o

else
    echo "Неизвестная цель: $TARGET"
    exit 1
fi

