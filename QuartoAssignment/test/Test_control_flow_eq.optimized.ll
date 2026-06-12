; ModuleID = 'Test_control_flow_eq.m2r.ll'
source_filename = "Test_control_flow_eq.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @cfe_positive_always(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  br label %4

4:                                                ; preds = %9, %3
  %.01 = phi i32 [ 0, %3 ], [ %10, %9 ]
  %5 = icmp slt i32 %.01, %2
  br i1 %5, label %6, label %22

6:                                                ; preds = %4
  %7 = sext i32 %.01 to i64
  %8 = getelementptr inbounds i32, ptr %0, i64 %7
  store i32 %.01, ptr %8, align 4
  br label %14

9:                                                ; preds = %14
  %10 = add nsw i32 %.01, 1
  br label %4, !llvm.loop !6

11:                                               ; No predecessors!
  br label %12

12:                                               ; preds = %20, %11
  %.0 = phi i32 [ 0, %11 ], [ %21, %20 ]
  %13 = icmp slt i32 %.0, %2
  br i1 %13, label %20, label %22

14:                                               ; preds = %6
  %15 = sext i32 %.01 to i64
  %16 = getelementptr inbounds i32, ptr %0, i64 %15
  %17 = load i32, ptr %16, align 4
  %18 = sext i32 %.01 to i64
  %19 = getelementptr inbounds i32, ptr %1, i64 %18
  store i32 %17, ptr %19, align 4
  br label %9

20:                                               ; preds = %12
  %21 = add nsw i32 %.0, 1
  br label %12, !llvm.loop !8

22:                                               ; preds = %4, %12
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @cfe_positive_same_guard(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = icmp sgt i32 %2, 0
  br i1 %4, label %5, label %25

5:                                                ; preds = %3
  br label %6

6:                                                ; preds = %11, %5
  %.01 = phi i32 [ 0, %5 ], [ %12, %11 ]
  %7 = icmp slt i32 %.01, %2
  br i1 %7, label %8, label %24

8:                                                ; preds = %6
  %9 = sext i32 %.01 to i64
  %10 = getelementptr inbounds i32, ptr %0, i64 %9
  store i32 %.01, ptr %10, align 4
  br label %16

11:                                               ; preds = %16
  %12 = add nsw i32 %.01, 1
  br label %6, !llvm.loop !9

13:                                               ; No predecessors!
  br label %14

14:                                               ; preds = %22, %13
  %.0 = phi i32 [ 0, %13 ], [ %23, %22 ]
  %15 = icmp slt i32 %.0, %2
  br i1 %15, label %22, label %24

16:                                               ; preds = %8
  %17 = sext i32 %.01 to i64
  %18 = getelementptr inbounds i32, ptr %0, i64 %17
  %19 = load i32, ptr %18, align 4
  %20 = sext i32 %.01 to i64
  %21 = getelementptr inbounds i32, ptr %1, i64 %20
  store i32 %19, ptr %21, align 4
  br label %11

22:                                               ; preds = %14
  %23 = add nsw i32 %.0, 1
  br label %14, !llvm.loop !10

24:                                               ; preds = %6, %14
  br label %25

25:                                               ; preds = %24, %3
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @cfe_positive_do_while(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = icmp sgt i32 %2, 0
  br i1 %4, label %5, label %23

5:                                                ; preds = %3
  br label %6

6:                                                ; preds = %10, %5
  %.01 = phi i32 [ 0, %5 ], [ %9, %10 ]
  %7 = sext i32 %.01 to i64
  %8 = getelementptr inbounds i32, ptr %0, i64 %7
  store i32 %.01, ptr %8, align 4
  %9 = add nsw i32 %.01, 1
  br label %10

10:                                               ; preds = %6
  %11 = icmp slt i32 %9, %2
  br i1 %11, label %6, label %12, !llvm.loop !11

12:                                               ; preds = %10
  br label %13

13:                                               ; preds = %20, %12
  %.0 = phi i32 [ 0, %12 ], [ %19, %20 ]
  %14 = sext i32 %.0 to i64
  %15 = getelementptr inbounds i32, ptr %0, i64 %14
  %16 = load i32, ptr %15, align 4
  %17 = sext i32 %.0 to i64
  %18 = getelementptr inbounds i32, ptr %1, i64 %17
  store i32 %16, ptr %18, align 4
  %19 = add nsw i32 %.0, 1
  br label %20

20:                                               ; preds = %13
  %21 = icmp slt i32 %19, %2
  br i1 %21, label %13, label %22, !llvm.loop !12

22:                                               ; preds = %20
  br label %23

23:                                               ; preds = %22, %3
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @cfe_negative_first_guarded(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = icmp sgt i32 %2, 0
  br i1 %4, label %5, label %14

5:                                                ; preds = %3
  br label %6

6:                                                ; preds = %11, %5
  %.01 = phi i32 [ 0, %5 ], [ %12, %11 ]
  %7 = icmp slt i32 %.01, %2
  br i1 %7, label %8, label %13

8:                                                ; preds = %6
  %9 = sext i32 %.01 to i64
  %10 = getelementptr inbounds i32, ptr %0, i64 %9
  store i32 %.01, ptr %10, align 4
  br label %11

11:                                               ; preds = %8
  %12 = add nsw i32 %.01, 1
  br label %6, !llvm.loop !13

13:                                               ; preds = %6
  br label %14

14:                                               ; preds = %13, %3
  br label %15

15:                                               ; preds = %23, %14
  %.0 = phi i32 [ 0, %14 ], [ %24, %23 ]
  %16 = icmp slt i32 %.0, %2
  br i1 %16, label %17, label %25

17:                                               ; preds = %15
  %18 = sext i32 %.0 to i64
  %19 = getelementptr inbounds i32, ptr %0, i64 %18
  %20 = load i32, ptr %19, align 4
  %21 = sext i32 %.0 to i64
  %22 = getelementptr inbounds i32, ptr %1, i64 %21
  store i32 %20, ptr %22, align 4
  br label %23

23:                                               ; preds = %17
  %24 = add nsw i32 %.0, 1
  br label %15, !llvm.loop !14

25:                                               ; preds = %15
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @cfe_negative_different_guards(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = icmp sgt i32 %2, 0
  br i1 %5, label %6, label %15

6:                                                ; preds = %4
  br label %7

7:                                                ; preds = %12, %6
  %.01 = phi i32 [ 0, %6 ], [ %13, %12 ]
  %8 = icmp slt i32 %.01, %2
  br i1 %8, label %9, label %14

9:                                                ; preds = %7
  %10 = sext i32 %.01 to i64
  %11 = getelementptr inbounds i32, ptr %0, i64 %10
  store i32 %.01, ptr %11, align 4
  br label %12

12:                                               ; preds = %9
  %13 = add nsw i32 %.01, 1
  br label %7, !llvm.loop !15

14:                                               ; preds = %7
  br label %15

15:                                               ; preds = %14, %4
  %16 = icmp sgt i32 %3, 0
  br i1 %16, label %17, label %26

17:                                               ; preds = %15
  br label %18

18:                                               ; preds = %23, %17
  %.0 = phi i32 [ 0, %17 ], [ %24, %23 ]
  %19 = icmp slt i32 %.0, %3
  br i1 %19, label %20, label %25

20:                                               ; preds = %18
  %21 = sext i32 %.0 to i64
  %22 = getelementptr inbounds i32, ptr %1, i64 %21
  store i32 %.0, ptr %22, align 4
  br label %23

23:                                               ; preds = %20
  %24 = add nsw i32 %.0, 1
  br label %18, !llvm.loop !16

25:                                               ; preds = %18
  br label %26

26:                                               ; preds = %25, %15
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @cfe_negative_intermediate_if(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  br label %4

4:                                                ; preds = %9, %3
  %.01 = phi i32 [ 0, %3 ], [ %10, %9 ]
  %5 = icmp slt i32 %.01, %2
  br i1 %5, label %6, label %11

6:                                                ; preds = %4
  %7 = sext i32 %.01 to i64
  %8 = getelementptr inbounds i32, ptr %0, i64 %7
  store i32 %.01, ptr %8, align 4
  br label %9

9:                                                ; preds = %6
  %10 = add nsw i32 %.01, 1
  br label %4, !llvm.loop !17

11:                                               ; preds = %4
  %12 = getelementptr inbounds i32, ptr %0, i64 0
  %13 = load i32, ptr %12, align 4
  %14 = icmp slt i32 %13, 0
  br i1 %14, label %15, label %16

15:                                               ; preds = %11
  br label %27

16:                                               ; preds = %11
  br label %17

17:                                               ; preds = %25, %16
  %.0 = phi i32 [ 0, %16 ], [ %26, %25 ]
  %18 = icmp slt i32 %.0, %2
  br i1 %18, label %19, label %27

19:                                               ; preds = %17
  %20 = sext i32 %.0 to i64
  %21 = getelementptr inbounds i32, ptr %0, i64 %20
  %22 = load i32, ptr %21, align 4
  %23 = sext i32 %.0 to i64
  %24 = getelementptr inbounds i32, ptr %1, i64 %23
  store i32 %22, ptr %24, align 4
  br label %25

25:                                               ; preds = %19
  %26 = add nsw i32 %.0, 1
  br label %17, !llvm.loop !18

27:                                               ; preds = %17, %15
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @cfe_negative_break(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  br label %4

4:                                                ; preds = %9, %3
  %.01 = phi i32 [ 0, %3 ], [ %10, %9 ]
  %5 = icmp slt i32 %.01, %2
  br i1 %5, label %6, label %11

6:                                                ; preds = %4
  %7 = sext i32 %.01 to i64
  %8 = getelementptr inbounds i32, ptr %0, i64 %7
  store i32 %.01, ptr %8, align 4
  br label %9

9:                                                ; preds = %6
  %10 = add nsw i32 %.01, 1
  br label %4, !llvm.loop !19

11:                                               ; preds = %4
  %12 = icmp eq i32 %2, 5
  br i1 %12, label %13, label %14

13:                                               ; preds = %11
  br label %25

14:                                               ; preds = %11
  br label %15

15:                                               ; preds = %23, %14
  %.0 = phi i32 [ 0, %14 ], [ %24, %23 ]
  %16 = icmp slt i32 %.0, %2
  br i1 %16, label %17, label %25

17:                                               ; preds = %15
  %18 = sext i32 %.0 to i64
  %19 = getelementptr inbounds i32, ptr %0, i64 %18
  %20 = load i32, ptr %19, align 4
  %21 = sext i32 %.0 to i64
  %22 = getelementptr inbounds i32, ptr %1, i64 %21
  store i32 %20, ptr %22, align 4
  br label %23

23:                                               ; preds = %17
  %24 = add nsw i32 %.0, 1
  br label %15, !llvm.loop !20

25:                                               ; preds = %15, %13
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @cfe_negative_if_else(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = icmp sgt i32 %2, 0
  br i1 %4, label %5, label %14

5:                                                ; preds = %3
  br label %6

6:                                                ; preds = %11, %5
  %.01 = phi i32 [ 0, %5 ], [ %12, %11 ]
  %7 = icmp slt i32 %.01, %2
  br i1 %7, label %8, label %13

8:                                                ; preds = %6
  %9 = sext i32 %.01 to i64
  %10 = getelementptr inbounds i32, ptr %0, i64 %9
  store i32 %.01, ptr %10, align 4
  br label %11

11:                                               ; preds = %8
  %12 = add nsw i32 %.01, 1
  br label %6, !llvm.loop !21

13:                                               ; preds = %6
  br label %23

14:                                               ; preds = %3
  br label %15

15:                                               ; preds = %20, %14
  %.0 = phi i32 [ 0, %14 ], [ %21, %20 ]
  %16 = icmp slt i32 %.0, 10
  br i1 %16, label %17, label %22

17:                                               ; preds = %15
  %18 = sext i32 %.0 to i64
  %19 = getelementptr inbounds i32, ptr %1, i64 %18
  store i32 %.0, ptr %19, align 4
  br label %20

20:                                               ; preds = %17
  %21 = add nsw i32 %.0, 1
  br label %15, !llvm.loop !22

22:                                               ; preds = %15
  br label %23

23:                                               ; preds = %22, %13
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = zext i32 20 to i64
  %2 = call ptr @llvm.stacksave.p0()
  %3 = alloca i32, i64 %1, align 16
  %4 = zext i32 20 to i64
  %5 = alloca i32, i64 %4, align 16
  call void @cfe_positive_always(ptr noundef %3, ptr noundef %5, i32 noundef 20)
  call void @cfe_positive_same_guard(ptr noundef %3, ptr noundef %5, i32 noundef 20)
  call void @cfe_positive_do_while(ptr noundef %3, ptr noundef %5, i32 noundef 20)
  call void @cfe_negative_first_guarded(ptr noundef %3, ptr noundef %5, i32 noundef 20)
  call void @cfe_negative_different_guards(ptr noundef %3, ptr noundef %5, i32 noundef 20, i32 noundef 10)
  call void @cfe_negative_intermediate_if(ptr noundef %3, ptr noundef %5, i32 noundef 20)
  call void @cfe_negative_break(ptr noundef %3, ptr noundef %5, i32 noundef 20)
  call void @cfe_negative_if_else(ptr noundef %3, ptr noundef %5, i32 noundef 20)
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
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
!13 = distinct !{!13, !7}
!14 = distinct !{!14, !7}
!15 = distinct !{!15, !7}
!16 = distinct !{!16, !7}
!17 = distinct !{!17, !7}
!18 = distinct !{!18, !7}
!19 = distinct !{!19, !7}
!20 = distinct !{!20, !7}
!21 = distinct !{!21, !7}
!22 = distinct !{!22, !7}
