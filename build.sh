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
elif [[ "$TARGET" == "wasm" ]]; then
    echo "Компиляция для wasm..."
    KOMPILER="emcc"
    LINKER="emar"
else
    echo "Неизвестная цель: $TARGET"
    exit 1
fi

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
