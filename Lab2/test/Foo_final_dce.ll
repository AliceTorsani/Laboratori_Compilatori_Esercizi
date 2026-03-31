; ModuleID = 'Foo.shift_mul.optimized2.ll'
source_filename = "test.c"

declare void @print(i32)

define i32 @main(i32 %a, i32 %b) {
entry:
  %0 = add i32 %a, %a
  %1 = shl i32 %0, 3
  call void @print(i32 %1)
  ret i32 0
}
