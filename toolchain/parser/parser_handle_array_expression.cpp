// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#include "toolchain/lexer/token_kind.h"
#include "toolchain/lexer/tokenized_buffer.h"
#include "toolchain/parser/parse_node_kind.h"
#include "toolchain/parser/parser_context.h"
#include "toolchain/parser/parser_state.h"

namespace Carbon::Parse {

auto HandleArrayExpression(Context& context) -> void {
  auto state = context.PopState();
  state.state = State::ArrayExpressionSemi;
  context.AddLeafNode(NodeKind::ArrayExpressionStart,
                      context.ConsumeChecked(TokenKind::OpenSquareBracket),
                      state.has_error);
  context.PushState(state);
  context.PushState(State::Expression);
}

auto HandleArrayExpressionSemi(Context& context) -> void {
  auto state = context.PopState();
  auto semi = context.ConsumeIf(TokenKind::Semi);
  if (!semi) {
    context.AddNode(NodeKind::ArrayExpressionSemi, *context.position(),
                    state.subtree_start, true);
    CARBON_DIAGNOSTIC(ExpectedArraySemi, Error, "Expected `;` in array type.");
    context.emitter().Emit(*context.position(), ExpectedArraySemi);
    state.has_error = true;
  } else {
    context.AddNode(NodeKind::ArrayExpressionSemi, *semi, state.subtree_start,
                    state.has_error);
  }
  state.state = State::ArrayExpressionFinish;
  context.PushState(state);
  if (!context.PositionIs(TokenKind::CloseSquareBracket)) {
    context.PushState(State::Expression);
  }
}

auto HandleArrayExpressionFinish(Context& context) -> void {
  auto state = context.PopState();
  context.ConsumeAndAddCloseSymbol(
      *(TokenizedBuffer::TokenIterator(state.token)), state,
      NodeKind::ArrayExpression);
}

}  // namespace Carbon::Parse
