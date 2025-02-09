// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#include "toolchain/lexer/token_kind.h"
#include "toolchain/parser/parser_context.h"

namespace Carbon::Parse {

auto HandleIndexExpression(Context& context) -> void {
  auto state = context.PopState();
  state.state = State::IndexExpressionFinish;
  context.PushState(state);
  context.AddNode(NodeKind::IndexExpressionStart,
                  context.ConsumeChecked(TokenKind::OpenSquareBracket),
                  state.subtree_start, state.has_error);
  context.PushState(State::Expression);
}

auto HandleIndexExpressionFinish(Context& context) -> void {
  auto state = context.PopState();

  context.ConsumeAndAddCloseSymbol(state.token, state,
                                   NodeKind::IndexExpression);
}

}  // namespace Carbon::Parse
