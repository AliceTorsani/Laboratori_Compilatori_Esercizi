; ModuleID = 'Test.m2r.ll'
source_filename = "Test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @test_fusion_success(ptr noundef %0, ptr noundef %1, ptr noundef %2, i32 noundef %3) #0 {
  %5 = icmp slt i32 0, %3
  br i1 %5, label %.lr.ph, label %16

.lr.ph:                                           ; preds = %4
  br label %6

6:                                                ; preds = %.lr.ph, %13
  %.011 = phi i32 [ 0, %.lr.ph ], [ %14, %13 ]
  %7 = sext i32 %.011 to i64
  %8 = getelementptr inbounds i32, ptr %1, i64 %7
  %9 = load i32, ptr %8, align 4
  %10 = mul nsw i32 %9, 2
  %11 = sext i32 %.011 to i64
  %12 = getelementptr inbounds i32, ptr %0, i64 %11
  store i32 %10, ptr %12, align 4
  br label %13

13:                                               ; preds = %6
  %14 = add nsw i32 %.011, 1
  %15 = icmp slt i32 %14, %3
  br i1 %15, label %6, label %._crit_edge, !llvm.loop !6

._crit_edge:                                      ; preds = %13
  br label %16

16:                                               ; preds = %._crit_edge, %4
  %17 = icmp slt i32 0, %3
  br i1 %17, label %.lr.ph4, label %28

.lr.ph4:                                          ; preds = %16
  br label %18

18:                                               ; preds = %.lr.ph4, %25
  %.02 = phi i32 [ 0, %.lr.ph4 ], [ %26, %25 ]
  %19 = sext i32 %.02 to i64
  %20 = getelementptr inbounds i32, ptr %0, i64 %19
  %21 = load i32, ptr %20, align 4
  %22 = add nsw i32 %21, 10
  %23 = sext i32 %.02 to i64
  %24 = getelementptr inbounds i32, ptr %2, i64 %23
  store i32 %22, ptr %24, align 4
  br label %25

25:                                               ; preds = %18
  %26 = add nsw i32 %.02, 1
  %27 = icmp slt i32 %26, %3
  br i1 %27, label %18, label %._crit_edge5, !llvm.loop !8

._crit_edge5:                                     ; preds = %25
  br label %28

28:                                               ; preds = %._crit_edge5, %16
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @test_fusion_fail_adjacency(ptr noundef %0, ptr noundef %1, ptr noundef %2, i32 noundef %3) #0 {
  %5 = icmp slt i32 0, %3
  br i1 %5, label %.lr.ph, label %16

.lr.ph:                                           ; preds = %4
  br label %6

6:                                                ; preds = %.lr.ph, %13
  %.011 = phi i32 [ 0, %.lr.ph ], [ %14, %13 ]
  %7 = sext i32 %.011 to i64
  %8 = getelementptr inbounds i32, ptr %1, i64 %7
  %9 = load i32, ptr %8, align 4
  %10 = mul nsw i32 %9, 2
  %11 = sext i32 %.011 to i64
  %12 = getelementptr inbounds i32, ptr %0, i64 %11
  store i32 %10, ptr %12, align 4
  br label %13

13:                                               ; preds = %6
  %14 = add nsw i32 %.011, 1
  %15 = icmp slt i32 %14, %3
  br i1 %15, label %6, label %._crit_edge, !llvm.loop !9

._crit_edge:                                      ; preds = %13
  br label %16

16:                                               ; preds = %._crit_edge, %4
  %17 = getelementptr inbounds i32, ptr %0, i64 0
  store i32 0, ptr %17, align 4
  %18 = icmp slt i32 0, %3
  br i1 %18, label %.lr.ph4, label %29

.lr.ph4:                                          ; preds = %16
  br label %19

19:                                               ; preds = %.lr.ph4, %26
  %.02 = phi i32 [ 0, %.lr.ph4 ], [ %27, %26 ]
  %20 = sext i32 %.02 to i64
  %21 = getelementptr inbounds i32, ptr %0, i64 %20
  %22 = load i32, ptr %21, align 4
  %23 = add nsw i32 %22, 10
  %24 = sext i32 %.02 to i64
  %25 = getelementptr inbounds i32, ptr %2, i64 %24
  store i32 %23, ptr %25, align 4
  br label %26

26:                                               ; preds = %19
  %27 = add nsw i32 %.02, 1
  %28 = icmp slt i32 %27, %3
  br i1 %28, label %19, label %._crit_edge5, !llvm.loop !10

._crit_edge5:                                     ; preds = %26
  br label %29

29:                                               ; preds = %._crit_edge5, %16
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = zext i32 50 to i64
  %2 = call ptr @llvm.stacksave.p0()
  %3 = alloca i32, i64 %1, align 16
  %4 = zext i32 50 to i64
  %5 = alloca i32, i64 %4, align 16
  %6 = zext i32 50 to i64
  %7 = alloca i32, i64 %6, align 16
  call void @test_fusion_success(ptr noundef %3, ptr noundef %5, ptr noundef %7, i32 noundef 50)
  call void @test_fusion_fail_adjacency(ptr noundef %3, ptr noundef %5, ptr noundef %7, i32 noundef 50)
  call void @llvm.stackrestore.p0(ptr %2)
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare ptr @llvm.stacksave.p0() #1

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.stackrestore.p0(ptr) #1

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn }

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
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
