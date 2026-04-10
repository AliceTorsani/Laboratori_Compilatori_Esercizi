; ModuleID = 'Foo.ll'
source_filename = "Foo.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @test_mul(i32 noundef %0) #0 {
  %2 = shl i32 %0, 3
  %3 = shl i32 %0, 4
  %4 = shl i32 %0, 4
  %5 = sub i32 %4, %0
  %6 = shl i32 %0, 3
  %7 = add i32 %6, %0
  %8 = shl i32 %0, 3
  %9 = shl i32 %0, 4
  %10 = sub i32 %9, %0
  %11 = add nsw i32 %2, %3
  %12 = add nsw i32 %11, %5
  %13 = add nsw i32 %12, %7
  %14 = add nsw i32 %13, %8
  %15 = add nsw i32 %14, %10
  ret i32 %15
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @test_div_signed(i32 noundef %0) #0 {
  %2 = ashr i32 %0, 3
  %3 = ashr i32 %0, 4
  %4 = ashr i32 %0, 4
  %5 = ashr i32 %0, 4
  %6 = add i32 %4, %5
  %7 = ashr i32 %0, 3
  %8 = ashr i32 %0, 4
  %9 = sub i32 %7, %8
  %10 = add nsw i32 %2, %3
  %11 = add nsw i32 %10, %6
  %12 = add nsw i32 %11, %9
  ret i32 %12
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @test_div_unsigned(i32 noundef %0) #0 {
  %2 = lshr i32 %0, 3
  %3 = lshr i32 %0, 4
  %4 = lshr i32 %0, 4
  %5 = lshr i32 %0, 4
  %6 = add i32 %4, %5
  %7 = lshr i32 %0, 3
  %8 = lshr i32 %0, 4
  %9 = sub i32 %7, %8
  %10 = add i32 %2, %3
  %11 = add i32 %10, %6
  %12 = add i32 %11, %9
  ret i32 %12
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @test_mix(i32 noundef %0) #0 {
  %2 = shl i32 %0, 3
  %3 = ashr i32 %2, 3
  %4 = shl i32 %0, 4
  %5 = sub i32 %4, %0
  %6 = ashr i32 %5, 4
  %7 = ashr i32 %5, 4
  %8 = add i32 %6, %7
  %9 = shl i32 %0, 3
  %10 = add i32 %9, %0
  %11 = ashr i32 %10, 3
  %12 = ashr i32 %10, 4
  %13 = sub i32 %11, %12
  %14 = shl i32 %0, 3
  %15 = ashr i32 %14, 2
  %16 = add nsw i32 %3, %8
  %17 = add nsw i32 %16, %13
  %18 = add nsw i32 %17, %15
  ret i32 %18
}

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 19.1.7 (/home/runner/work/llvm-project/llvm-project/clang cd708029e0b2869e80abe31ddb175f7c35361f90)"}
