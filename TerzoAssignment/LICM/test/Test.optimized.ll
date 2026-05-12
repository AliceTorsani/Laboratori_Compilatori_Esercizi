; ModuleID = 'Test.m2r.ll'
source_filename = "Test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@global = dso_local global i32 5, align 4
@.str = private unnamed_addr constant [12 x i8] c"Result: %d\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @pure_function(i32 noundef %0) #0 {
  %2 = mul nsw i32 %0, 2
  ret i32 %2
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @impure_function(ptr noundef %0) #0 {
  %2 = load i32, ptr %0, align 4
  %3 = add nsw i32 %2, 1
  store i32 %3, ptr %0, align 4
  %4 = load i32, ptr %0, align 4
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [100 x i32], align 16
  store i32 0, ptr %1, align 4
  %3 = add nsw i32 10, 20
  %4 = mul nsw i32 %3, 2
  %5 = add nsw i32 %3, %4
  %6 = add nsw i32 %4, 3
  br label %7

7:                                                ; preds = %23, %0
  %.0 = phi i32 [ 0, %0 ], [ %24, %23 ]
  %8 = icmp slt i32 %.0, 100
  br i1 %8, label %9, label %25

9:                                                ; preds = %7
  %10 = add nsw i32 %3, %.0
  %11 = call i32 @pure_function(i32 noundef 10)
  %12 = call i32 @impure_function(ptr noundef %1)
  %13 = getelementptr inbounds [100 x i32], ptr %2, i64 0, i64 0
  %14 = load i32, ptr %13, align 16
  %15 = sext i32 %.0 to i64
  %16 = getelementptr inbounds [100 x i32], ptr %2, i64 0, i64 %15
  store i32 %5, ptr %16, align 4
  %17 = add nsw i32 %10, %12
  %18 = add nsw i32 %17, %6
  %19 = add nsw i32 %18, %11
  %20 = add nsw i32 %19, %14
  %21 = load i32, ptr %1, align 4
  %22 = add nsw i32 %21, %20
  store i32 %22, ptr %1, align 4
  br label %23

23:                                               ; preds = %9
  %24 = add nsw i32 %.0, 1
  br label %7, !llvm.loop !6

25:                                               ; preds = %7
  %26 = load i32, ptr %1, align 4
  %27 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %26)
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
