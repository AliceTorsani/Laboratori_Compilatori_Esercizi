; ModuleID = 'Foo.c'
source_filename = "Foo.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @test_mul(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %9 = load i32, ptr %2, align 4
  %10 = mul nsw i32 %9, 8
  store i32 %10, ptr %3, align 4
  %11 = load i32, ptr %2, align 4
  %12 = mul nsw i32 %11, 16
  store i32 %12, ptr %4, align 4
  %13 = load i32, ptr %2, align 4
  %14 = mul nsw i32 %13, 15
  store i32 %14, ptr %5, align 4
  %15 = load i32, ptr %2, align 4
  %16 = mul nsw i32 %15, 9
  store i32 %16, ptr %6, align 4
  %17 = load i32, ptr %2, align 4
  %18 = mul nsw i32 8, %17
  store i32 %18, ptr %7, align 4
  %19 = load i32, ptr %2, align 4
  %20 = mul nsw i32 15, %19
  store i32 %20, ptr %8, align 4
  %21 = load i32, ptr %3, align 4
  %22 = load i32, ptr %4, align 4
  %23 = add nsw i32 %21, %22
  %24 = load i32, ptr %5, align 4
  %25 = add nsw i32 %23, %24
  %26 = load i32, ptr %6, align 4
  %27 = add nsw i32 %25, %26
  %28 = load i32, ptr %7, align 4
  %29 = add nsw i32 %27, %28
  %30 = load i32, ptr %8, align 4
  %31 = add nsw i32 %29, %30
  ret i32 %31
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @test_div_signed(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %7 = load i32, ptr %2, align 4
  %8 = sdiv i32 %7, 8
  store i32 %8, ptr %3, align 4
  %9 = load i32, ptr %2, align 4
  %10 = sdiv i32 %9, 16
  store i32 %10, ptr %4, align 4
  %11 = load i32, ptr %2, align 4
  %12 = sdiv i32 %11, 15
  store i32 %12, ptr %5, align 4
  %13 = load i32, ptr %2, align 4
  %14 = sdiv i32 %13, 9
  store i32 %14, ptr %6, align 4
  %15 = load i32, ptr %3, align 4
  %16 = load i32, ptr %4, align 4
  %17 = add nsw i32 %15, %16
  %18 = load i32, ptr %5, align 4
  %19 = add nsw i32 %17, %18
  %20 = load i32, ptr %6, align 4
  %21 = add nsw i32 %19, %20
  ret i32 %21
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @test_div_unsigned(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %7 = load i32, ptr %2, align 4
  %8 = udiv i32 %7, 8
  store i32 %8, ptr %3, align 4
  %9 = load i32, ptr %2, align 4
  %10 = udiv i32 %9, 16
  store i32 %10, ptr %4, align 4
  %11 = load i32, ptr %2, align 4
  %12 = udiv i32 %11, 15
  store i32 %12, ptr %5, align 4
  %13 = load i32, ptr %2, align 4
  %14 = udiv i32 %13, 9
  store i32 %14, ptr %6, align 4
  %15 = load i32, ptr %3, align 4
  %16 = load i32, ptr %4, align 4
  %17 = add i32 %15, %16
  %18 = load i32, ptr %5, align 4
  %19 = add i32 %17, %18
  %20 = load i32, ptr %6, align 4
  %21 = add i32 %19, %20
  ret i32 %21
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @test_mix(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %7 = load i32, ptr %2, align 4
  %8 = mul nsw i32 %7, 8
  %9 = sdiv i32 %8, 8
  store i32 %9, ptr %3, align 4
  %10 = load i32, ptr %2, align 4
  %11 = mul nsw i32 %10, 15
  %12 = sdiv i32 %11, 15
  store i32 %12, ptr %4, align 4
  %13 = load i32, ptr %2, align 4
  %14 = mul nsw i32 %13, 9
  %15 = sdiv i32 %14, 9
  store i32 %15, ptr %5, align 4
  %16 = load i32, ptr %2, align 4
  %17 = mul nsw i32 %16, 8
  %18 = sdiv i32 %17, 4
  store i32 %18, ptr %6, align 4
  %19 = load i32, ptr %3, align 4
  %20 = load i32, ptr %4, align 4
  %21 = add nsw i32 %19, %20
  %22 = load i32, ptr %5, align 4
  %23 = add nsw i32 %21, %22
  %24 = load i32, ptr %6, align 4
  %25 = add nsw i32 %23, %24
  ret i32 %25
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
