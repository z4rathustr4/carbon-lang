// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#include "toolchain/semantics/semantics_context.h"

namespace Carbon::Check {

auto HandleInterfaceDeclaration(Context& context, Parse::Node parse_node)
    -> bool {
  return context.TODO(parse_node, "HandleInterfaceDeclaration");
}

auto HandleInterfaceDefinition(Context& context, Parse::Node parse_node)
    -> bool {
  return context.TODO(parse_node, "HandleInterfaceDefinition");
}

auto HandleInterfaceDefinitionStart(Context& context, Parse::Node parse_node)
    -> bool {
  return context.TODO(parse_node, "HandleInterfaceDefinitionStart");
}

auto HandleInterfaceIntroducer(Context& context, Parse::Node parse_node)
    -> bool {
  return context.TODO(parse_node, "HandleInterfaceIntroducer");
}

}  // namespace Carbon::Check
