// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
fn A() -> (i32, i32) { return (1, 2); }

fn B() -> [i32; 2] { return (1, 2); }

fn Run() {
  var a: [i32; 2] = A();
  var b: i32 = A()[0];
  var c: i32 = a[b];
  var d: i32 = B()[1];
}

// CHECK:STDOUT: ; ModuleID = 'array_element_access.carbon'
// CHECK:STDOUT: source_filename = "array_element_access.carbon"
// CHECK:STDOUT:
// CHECK:STDOUT: define void @A(ptr sret({ i32, i32 }) %return) {
// CHECK:STDOUT:   %tuple = alloca { i32, i32 }, align 8
// CHECK:STDOUT:   %1 = getelementptr inbounds { i32, i32 }, ptr %tuple, i32 0, i32 0
// CHECK:STDOUT:   store i32 1, ptr %1, align 4
// CHECK:STDOUT:   %2 = getelementptr inbounds { i32, i32 }, ptr %tuple, i32 0, i32 1
// CHECK:STDOUT:   store i32 2, ptr %2, align 4
// CHECK:STDOUT:   call void @llvm.memcpy.p0.p0.i64(ptr align 4 %return, ptr align 4 %tuple, i64 8, i1 false)
// CHECK:STDOUT:   ret void
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: define void @B(ptr sret([2 x i32]) %return) {
// CHECK:STDOUT:   %tuple = alloca { i32, i32 }, align 8
// CHECK:STDOUT:   %1 = getelementptr inbounds { i32, i32 }, ptr %tuple, i32 0, i32 0
// CHECK:STDOUT:   store i32 1, ptr %1, align 4
// CHECK:STDOUT:   %2 = getelementptr inbounds { i32, i32 }, ptr %tuple, i32 0, i32 1
// CHECK:STDOUT:   store i32 2, ptr %2, align 4
// CHECK:STDOUT:   %array = alloca [2 x i32], align 4
// CHECK:STDOUT:   %array.element = getelementptr inbounds { i32, i32 }, ptr %tuple, i32 0, i32 0
// CHECK:STDOUT:   %3 = load i32, ptr %array.element, align 4
// CHECK:STDOUT:   %4 = getelementptr inbounds [2 x i32], ptr %array, i32 0, i32 0
// CHECK:STDOUT:   store i32 %3, ptr %4, align 4
// CHECK:STDOUT:   %array.element1 = getelementptr inbounds { i32, i32 }, ptr %tuple, i32 0, i32 1
// CHECK:STDOUT:   %5 = load i32, ptr %array.element1, align 4
// CHECK:STDOUT:   %6 = getelementptr inbounds [2 x i32], ptr %array, i32 0, i32 1
// CHECK:STDOUT:   store i32 %5, ptr %6, align 4
// CHECK:STDOUT:   call void @llvm.memcpy.p0.p0.i64(ptr align 4 %return, ptr align 4 %array, i64 8, i1 false)
// CHECK:STDOUT:   ret void
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: define void @Run() {
// CHECK:STDOUT:   %a = alloca [2 x i32], align 4
// CHECK:STDOUT:   %temp = alloca { i32, i32 }, align 8
// CHECK:STDOUT:   call void @A(ptr %temp)
// CHECK:STDOUT:   %array = alloca [2 x i32], align 4
// CHECK:STDOUT:   %array.element = getelementptr inbounds { i32, i32 }, ptr %temp, i32 0, i32 0
// CHECK:STDOUT:   %1 = load i32, ptr %array.element, align 4
// CHECK:STDOUT:   %2 = getelementptr inbounds [2 x i32], ptr %array, i32 0, i32 0
// CHECK:STDOUT:   store i32 %1, ptr %2, align 4
// CHECK:STDOUT:   %array.element1 = getelementptr inbounds { i32, i32 }, ptr %temp, i32 0, i32 1
// CHECK:STDOUT:   %3 = load i32, ptr %array.element1, align 4
// CHECK:STDOUT:   %4 = getelementptr inbounds [2 x i32], ptr %array, i32 0, i32 1
// CHECK:STDOUT:   store i32 %3, ptr %4, align 4
// CHECK:STDOUT:   call void @llvm.memcpy.p0.p0.i64(ptr align 4 %a, ptr align 4 %array, i64 8, i1 false)
// CHECK:STDOUT:   %b = alloca i32, align 4
// CHECK:STDOUT:   %temp2 = alloca { i32, i32 }, align 8
// CHECK:STDOUT:   call void @A(ptr %temp2)
// CHECK:STDOUT:   %tuple.index = getelementptr inbounds { i32, i32 }, ptr %temp2, i32 0, i32 0
// CHECK:STDOUT:   %5 = load i32, ptr %tuple.index, align 4
// CHECK:STDOUT:   store i32 %5, ptr %b, align 4
// CHECK:STDOUT:   %c = alloca i32, align 4
// CHECK:STDOUT:   %6 = load i32, ptr %b, align 4
// CHECK:STDOUT:   %array.index = getelementptr inbounds [2 x i32], ptr %a, i32 %6
// CHECK:STDOUT:   %7 = load i32, ptr %array.index, align 4
// CHECK:STDOUT:   store i32 %7, ptr %c, align 4
// CHECK:STDOUT:   %d = alloca i32, align 4
// CHECK:STDOUT:   %temp3 = alloca [2 x i32], align 4
// CHECK:STDOUT:   call void @B(ptr %temp3)
// CHECK:STDOUT:   %array.index4 = getelementptr inbounds [2 x i32], ptr %temp3, i32 0, i32 1
// CHECK:STDOUT:   %8 = load i32, ptr %array.index4, align 4
// CHECK:STDOUT:   store i32 %8, ptr %d, align 4
// CHECK:STDOUT:   ret void
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: ; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
// CHECK:STDOUT: declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #0
// CHECK:STDOUT:
// CHECK:STDOUT: ; uselistorder directives
// CHECK:STDOUT: uselistorder ptr @llvm.memcpy.p0.p0.i64, { 2, 1, 0 }
// CHECK:STDOUT:
// CHECK:STDOUT: attributes #0 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
