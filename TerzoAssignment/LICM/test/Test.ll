; ModuleID = 'Test.c'
source_filename = "Test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@global = dso_local global i32 5, align 4
@.str = private unnamed_addr constant [12 x i8] c"Result: %d\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @pure_function(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = mul nsw i32 %3, 2
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @impure_function(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = load i32, ptr %3, align 4
  %5 = add nsw i32 %4, 1
  store i32 %5, ptr %3, align 4
  %6 = load ptr, ptr %2, align 8
  %7 = load i32, ptr %6, align 4
  ret i32 %7
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca [100 x i32], align 16
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 10, ptr %2, align 4
  store i32 20, ptr %3, align 4
  store i32 0, ptr %4, align 4
  store i32 3, ptr %5, align 4
  store i32 0, ptr %7, align 4
  br label %15

15:                                               ; preds = %52, %0
  %16 = load i32, ptr %7, align 4
  %17 = icmp slt i32 %16, 100
  br i1 %17, label %18, label %55

18:                                               ; preds = %15
  %19 = load i32, ptr %2, align 4
  %20 = load i32, ptr %3, align 4
  %21 = add nsw i32 %19, %20
  store i32 %21, ptr %8, align 4
  %22 = load i32, ptr %8, align 4
  %23 = mul nsw i32 %22, 2
  store i32 %23, ptr %9, align 4
  %24 = load i32, ptr %8, align 4
  %25 = load i32, ptr %7, align 4
  %26 = add nsw i32 %24, %25
  store i32 %26, ptr %10, align 4
  %27 = load i32, ptr %2, align 4
  %28 = call i32 @pure_function(i32 noundef %27)
  store i32 %28, ptr %11, align 4
  %29 = call i32 @impure_function(ptr noundef %4)
  store i32 %29, ptr %12, align 4
  %30 = getelementptr inbounds [100 x i32], ptr %6, i64 0, i64 0
  %31 = load i32, ptr %30, align 16
  store i32 %31, ptr %13, align 4
  %32 = load i32, ptr %8, align 4
  %33 = load i32, ptr %9, align 4
  %34 = add nsw i32 %32, %33
  %35 = load i32, ptr %7, align 4
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds [100 x i32], ptr %6, i64 0, i64 %36
  store i32 %34, ptr %37, align 4
  %38 = load i32, ptr %9, align 4
  %39 = load i32, ptr %5, align 4
  %40 = add nsw i32 %38, %39
  store i32 %40, ptr %14, align 4
  %41 = load i32, ptr %10, align 4
  %42 = load i32, ptr %12, align 4
  %43 = add nsw i32 %41, %42
  %44 = load i32, ptr %14, align 4
  %45 = add nsw i32 %43, %44
  %46 = load i32, ptr %11, align 4
  %47 = add nsw i32 %45, %46
  %48 = load i32, ptr %13, align 4
  %49 = add nsw i32 %47, %48
  %50 = load i32, ptr %4, align 4
  %51 = add nsw i32 %50, %49
  store i32 %51, ptr %4, align 4
  br label %52

52:                                               ; preds = %18
  %53 = load i32, ptr %7, align 4
  %54 = add nsw i32 %53, 1
  store i32 %54, ptr %7, align 4
  br label %15, !llvm.loop !6

55:                                               ; preds = %15
  %56 = load i32, ptr %4, align 4
  %57 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %56)
  ret i32 0
}

declare i32 @printf(ptr noundef, ...) #1

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 19.1.7 (/home/runner/work/llvm-project/llvm-project/clang cd708029e0b2869e80abe31ddb175f7c35361f90)"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
