// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#include "toolchain/lowering/lower_to_llvm.h"

#include "toolchain/lowering/lowering_context.h"

namespace Carbon::Lower {

auto LowerToLLVM(llvm::LLVMContext& llvm_context, llvm::StringRef module_name,
                 const SemIR::File& semantics_ir,
                 llvm::raw_ostream* vlog_stream)
    -> std::unique_ptr<llvm::Module> {
  FileContext context(llvm_context, module_name, semantics_ir, vlog_stream);
  return context.Run();
}

}  // namespace Carbon::Lower
