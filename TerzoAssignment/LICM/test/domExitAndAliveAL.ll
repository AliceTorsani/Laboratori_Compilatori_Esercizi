; ModuleID = 'domExitAndAliveAL.cpp'
source_filename = "domExitAndAliveAL.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local noundef i32 @_Z22dominatesExitesAliveALv() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 3, ptr %1, align 4
  store i32 4, ptr %2, align 4
  store i32 0, ptr %3, align 4
  store i32 0, ptr %4, align 4
  store i32 0, ptr %5, align 4
  br label %8

8:                                                ; preds = %18, %0
  %9 = load i32, ptr %1, align 4
  %10 = load i32, ptr %2, align 4
  %11 = add nsw i32 %9, %10
  store i32 %11, ptr %6, align 4
  %12 = load i32, ptr %1, align 4
  %13 = mul nsw i32 %12, 7
  %14 = load i32, ptr %2, align 4
  %15 = add nsw i32 %13, %14
  store i32 %15, ptr %3, align 4
  %16 = load i32, ptr %3, align 4
  %17 = add nsw i32 %16, 2
  store i32 %17, ptr %4, align 4
  br label %18

18:                                               ; preds = %8
  %19 = load i32, ptr %5, align 4
  %20 = icmp slt i32 %19, 100
  br i1 %20, label %8, label %21, !llvm.loop !6

21:                                               ; preds = %18
  %22 = load i32, ptr %3, align 4
  %23 = load i32, ptr %4, align 4
  %24 = add nsw i32 %22, %23
  store i32 %24, ptr %7, align 4
  ret i32 0
}

attributes #0 = { mustprogress noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
