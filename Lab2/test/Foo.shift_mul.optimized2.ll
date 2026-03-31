; ModuleID = 'Foo_mul.ll'
source_filename = "test.c"

declare void @print(i32)

define i32 @main(i32 %a, i32 %b) {
entry:
  %0 = add i32 %a, %b
  %1 = add i32 %a, %a
  %2 = mul i32 %1, 8
  %3 = shl i32 %1, 3
  call void @print(i32 %3)
  ret i32 0
}
