; ModuleID = 'loopIf.m2r.ll'
source_filename = "loopIf.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local noundef i32 @_Z16provaAssignementi(i32 noundef %0) #0 {
  %2 = add nsw i32 5, 5
  %3 = add nsw i32 10, 20
  %4 = sdiv i32 %3, 10
  %5 = sitofp i32 %4 to float
  %6 = add nsw i32 10, 3
  br label %7

7:                                                ; preds = %15, %1
  %.0 = phi i32 [ 0, %1 ], [ %8, %15 ]
  %8 = add nsw i32 %.0, 1
  %9 = sub nsw i32 0, %0
  %10 = add nsw i32 10, %9
  %11 = add nsw i32 %3, %10
  %12 = icmp sgt i32 %0, 2
  br i1 %12, label %13, label %14

13:                                               ; preds = %7
  br label %14

14:                                               ; preds = %13, %7
  br label %15

15:                                               ; preds = %14
  %16 = icmp slt i32 %8, 100
  br i1 %16, label %7, label %17, !llvm.loop !6

17:                                               ; preds = %15
  %18 = trunc i8 1 to i1
  %19 = xor i1 %18, true
  %20 = zext i1 %19 to i8
  %21 = add nsw i32 5, %8
  %22 = add nsw i32 %21, %0
  ret i32 %22
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
