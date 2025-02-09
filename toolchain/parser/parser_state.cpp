// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#include "toolchain/parser/parser_state.h"

namespace Carbon::Parse {

CARBON_DEFINE_ENUM_CLASS_NAMES(State) = {
#define CARBON_PARSE_STATE(Name) CARBON_ENUM_CLASS_NAME_STRING(Name)
#include "toolchain/parser/parser_state.def"
};

}  // namespace Carbon::Parse
