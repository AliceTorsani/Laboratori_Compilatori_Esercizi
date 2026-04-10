; ModuleID = 'Foo.O0.ll'
source_filename = "Foo.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @test_mul(i32 noundef %0) #0 {
  %2 = mul nsw i32 %0, 8
  %3 = mul nsw i32 %0, 16
  %4 = mul nsw i32 %0, 15
  %5 = mul nsw i32 %0, 9
  %6 = mul nsw i32 8, %0
  %7 = mul nsw i32 15, %0
  %8 = add nsw i32 %2, %3
  %9 = add nsw i32 %8, %4
  %10 = add nsw i32 %9, %5
  %11 = add nsw i32 %10, %6
  %12 = add nsw i32 %11, %7
  ret i32 %12
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @test_div_signed(i32 noundef %0) #0 {
  %2 = sdiv i32 %0, 8
  %3 = sdiv i32 %0, 16
  %4 = sdiv i32 %0, 15
  %5 = sdiv i32 %0, 9
  %6 = add nsw i32 %2, %3
  %7 = add nsw i32 %6, %4
  %8 = add nsw i32 %7, %5
  ret i32 %8
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @test_div_unsigned(i32 noundef %0) #0 {
  %2 = udiv i32 %0, 8
  %3 = udiv i32 %0, 16
  %4 = udiv i32 %0, 15
  %5 = udiv i32 %0, 9
  %6 = add i32 %2, %3
  %7 = add i32 %6, %4
  %8 = add i32 %7, %5
  ret i32 %8
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @test_mix(i32 noundef %0) #0 {
  %2 = mul nsw i32 %0, 8
  %3 = sdiv i32 %2, 8
  %4 = mul nsw i32 %0, 15
  %5 = sdiv i32 %4, 15
  %6 = mul nsw i32 %0, 9
  %7 = sdiv i32 %6, 9
  %8 = mul nsw i32 %0, 8
  %9 = sdiv i32 %8, 4
  %10 = add nsw i32 %3, %5
  %11 = add nsw i32 %10, %7
  %12 = add nsw i32 %11, %9
  ret i32 %12
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
