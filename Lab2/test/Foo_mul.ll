; ModuleID = 'test.ll'
source_filename = "test.c"

declare void @print(i32)

define i32 @main(i32 %a, i32 %b) {
entry:
  ; %1 = add %2, %3
  %1 = add i32 %a, %b

  ; %4 = mul %1, 8
  %4 = mul i32 %1, 8

  ; print %4
  call void @print(i32 %4)

  ret i32 0
}