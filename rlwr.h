#pragma once

#include "lua.h"

typedef struct rlwr_t rlwr_t;

struct rlwr_t *rlwr_new();
lua_State *rlwr_state(rlwr_t *rlwr);
void rlwr_free(rlwr_t *);
