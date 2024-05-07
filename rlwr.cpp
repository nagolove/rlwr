#pragma once
/*#include "rlwr.h"*/

#include "sol/sol.hpp"
#include <lua.h>
#include "include/raylib-lua-sol.hpp"

struct rlwr_t {
    sol::state lua;
} rlwr_t;

extern "C" {

struct rlwr_t *rlwr_new();
lua_State *rlwr_state(struct rlwr_t *rlwr);
void rlwr_free(struct rlwr_t *rlwr);
}

struct rlwr_t *rlwr_new() {
    struct rlwr_t *t = new struct rlwr_t();

    t->lua.open_libraries(
      sol::lib::base,
      sol::lib::package,
      sol::lib::string,
      sol::lib::math,
      sol::lib::table);

    raylib_lua_sol(t->lua);
    return t;
}

lua_State *rlwr_state(struct rlwr_t *rlwr) {
  assert(rlwr);
  return rlwr->lua.lua_state();
}

void rlwr_free(struct rlwr_t *rlwr) {
  assert(rlwr);
  delete rlwr;
}
