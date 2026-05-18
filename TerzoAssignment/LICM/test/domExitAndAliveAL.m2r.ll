; ModuleID = 'domExitAndAliveAL.ll'
source_filename = "domExitAndAliveAL.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local noundef i32 @_Z22dominatesExitesAliveALv() #0 {
  br label %1

1:                                                ; preds = %6, %0
  %2 = add nsw i32 3, 4
  %3 = mul nsw i32 3, 7
  %4 = add nsw i32 %3, 4
  %5 = add nsw i32 %4, 2
  br label %6

6:                                                ; preds = %1
  %7 = icmp slt i32 0, 100
  br i1 %7, label %1, label %8, !llvm.loop !6

8:                                                ; preds = %6
  %9 = add nsw i32 %4, %5
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
