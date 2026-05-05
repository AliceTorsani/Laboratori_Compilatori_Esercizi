; ModuleID = 'Test.ll'
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
  br label %3

3:                                                ; preds = %23, %0
  %.0 = phi i32 [ 0, %0 ], [ %24, %23 ]
  %4 = icmp slt i32 %.0, 100
  br i1 %4, label %5, label %25

5:                                                ; preds = %3
  %6 = add nsw i32 10, 20
  %7 = mul nsw i32 %6, 2
  %8 = add nsw i32 %6, %.0
  %9 = call i32 @pure_function(i32 noundef 10)
  %10 = call i32 @impure_function(ptr noundef %1)
  %11 = getelementptr inbounds [100 x i32], ptr %2, i64 0, i64 0
  %12 = load i32, ptr %11, align 16
  %13 = add nsw i32 %6, %7
  %14 = sext i32 %.0 to i64
  %15 = getelementptr inbounds [100 x i32], ptr %2, i64 0, i64 %14
  store i32 %13, ptr %15, align 4
  %16 = add nsw i32 %7, 3
  %17 = add nsw i32 %8, %10
  %18 = add nsw i32 %17, %16
  %19 = add nsw i32 %18, %9
  %20 = add nsw i32 %19, %12
  %21 = load i32, ptr %1, align 4
  %22 = add nsw i32 %21, %20
  store i32 %22, ptr %1, align 4
  br label %23

23:                                               ; preds = %5
  %24 = add nsw i32 %.0, 1
  br label %3, !llvm.loop !6

25:                                               ; preds = %3
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
