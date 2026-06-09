; ModuleID = 'Test_dipendenza_neg.m2r.ll'
source_filename = "Test_dipendenza_neg.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @no_dependence(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  br label %4

4:                                                ; preds = %9, %3
  %.01 = phi i32 [ 0, %3 ], [ %10, %9 ]
  %5 = icmp slt i32 %.01, 100
  br i1 %5, label %6, label %11

6:                                                ; preds = %4
  %7 = sext i32 %.01 to i64
  %8 = getelementptr inbounds i32, ptr %0, i64 %7
  store i32 %.01, ptr %8, align 4
  br label %9

9:                                                ; preds = %6
  %10 = add nsw i32 %.01, 1
  br label %4, !llvm.loop !6

11:                                               ; preds = %4
  br label %12

12:                                               ; preds = %20, %11
  %.0 = phi i32 [ 0, %11 ], [ %21, %20 ]
  %13 = icmp slt i32 %.0, 100
  br i1 %13, label %14, label %22

14:                                               ; preds = %12
  %15 = sext i32 %.0 to i64
  %16 = getelementptr inbounds i32, ptr %2, i64 %15
  %17 = load i32, ptr %16, align 4
  %18 = sext i32 %.0 to i64
  %19 = getelementptr inbounds i32, ptr %1, i64 %18
  store i32 %17, ptr %19, align 4
  br label %20

20:                                               ; preds = %14
  %21 = add nsw i32 %.0, 1
  br label %12, !llvm.loop !8

22:                                               ; preds = %12
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @distance_zero(ptr noundef %0, ptr noundef %1) #0 {
  br label %3

3:                                                ; preds = %8, %2
  %.01 = phi i32 [ 0, %2 ], [ %9, %8 ]
  %4 = icmp slt i32 %.01, 100
  br i1 %4, label %5, label %10

5:                                                ; preds = %3
  %6 = sext i32 %.01 to i64
  %7 = getelementptr inbounds i32, ptr %0, i64 %6
  store i32 %.01, ptr %7, align 4
  br label %8

8:                                                ; preds = %5
  %9 = add nsw i32 %.01, 1
  br label %3, !llvm.loop !9

10:                                               ; preds = %3
  br label %11

11:                                               ; preds = %19, %10
  %.0 = phi i32 [ 0, %10 ], [ %20, %19 ]
  %12 = icmp slt i32 %.0, 100
  br i1 %12, label %13, label %21

13:                                               ; preds = %11
  %14 = sext i32 %.0 to i64
  %15 = getelementptr inbounds i32, ptr %0, i64 %14
  %16 = load i32, ptr %15, align 4
  %17 = sext i32 %.0 to i64
  %18 = getelementptr inbounds i32, ptr %1, i64 %17
  store i32 %16, ptr %18, align 4
  br label %19

19:                                               ; preds = %13
  %20 = add nsw i32 %.0, 1
  br label %11, !llvm.loop !10

21:                                               ; preds = %11
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @positive_distance_1(ptr noundef %0, ptr noundef %1) #0 {
  br label %3

3:                                                ; preds = %8, %2
  %.01 = phi i32 [ 1, %2 ], [ %9, %8 ]
  %4 = icmp slt i32 %.01, 100
  br i1 %4, label %5, label %10

5:                                                ; preds = %3
  %6 = sext i32 %.01 to i64
  %7 = getelementptr inbounds i32, ptr %0, i64 %6
  store i32 %.01, ptr %7, align 4
  br label %8

8:                                                ; preds = %5
  %9 = add nsw i32 %.01, 1
  br label %3, !llvm.loop !11

10:                                               ; preds = %3
  br label %11

11:                                               ; preds = %20, %10
  %.0 = phi i32 [ 1, %10 ], [ %21, %20 ]
  %12 = icmp slt i32 %.0, 100
  br i1 %12, label %13, label %22

13:                                               ; preds = %11
  %14 = sub nsw i32 %.0, 1
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds i32, ptr %0, i64 %15
  %17 = load i32, ptr %16, align 4
  %18 = sext i32 %.0 to i64
  %19 = getelementptr inbounds i32, ptr %1, i64 %18
  store i32 %17, ptr %19, align 4
  br label %20

20:                                               ; preds = %13
  %21 = add nsw i32 %.0, 1
  br label %11, !llvm.loop !12

22:                                               ; preds = %11
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @positive_distance_3(ptr noundef %0, ptr noundef %1) #0 {
  br label %3

3:                                                ; preds = %8, %2
  %.01 = phi i32 [ 3, %2 ], [ %9, %8 ]
  %4 = icmp slt i32 %.01, 100
  br i1 %4, label %5, label %10

5:                                                ; preds = %3
  %6 = sext i32 %.01 to i64
  %7 = getelementptr inbounds i32, ptr %0, i64 %6
  store i32 %.01, ptr %7, align 4
  br label %8

8:                                                ; preds = %5
  %9 = add nsw i32 %.01, 1
  br label %3, !llvm.loop !13

10:                                               ; preds = %3
  br label %11

11:                                               ; preds = %20, %10
  %.0 = phi i32 [ 3, %10 ], [ %21, %20 ]
  %12 = icmp slt i32 %.0, 100
  br i1 %12, label %13, label %22

13:                                               ; preds = %11
  %14 = sub nsw i32 %.0, 3
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds i32, ptr %0, i64 %15
  %17 = load i32, ptr %16, align 4
  %18 = sext i32 %.0 to i64
  %19 = getelementptr inbounds i32, ptr %1, i64 %18
  store i32 %17, ptr %19, align 4
  br label %20

20:                                               ; preds = %13
  %21 = add nsw i32 %.0, 1
  br label %11, !llvm.loop !14

22:                                               ; preds = %11
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @negative_distance_minus1(ptr noundef %0, ptr noundef %1) #0 {
  br label %3

3:                                                ; preds = %8, %2
  %.01 = phi i32 [ 0, %2 ], [ %9, %8 ]
  %4 = icmp slt i32 %.01, 99
  br i1 %4, label %5, label %10

5:                                                ; preds = %3
  %6 = sext i32 %.01 to i64
  %7 = getelementptr inbounds i32, ptr %0, i64 %6
  store i32 %.01, ptr %7, align 4
  br label %8

8:                                                ; preds = %5
  %9 = add nsw i32 %.01, 1
  br label %3, !llvm.loop !15

10:                                               ; preds = %3
  br label %11

11:                                               ; preds = %20, %10
  %.0 = phi i32 [ 0, %10 ], [ %21, %20 ]
  %12 = icmp slt i32 %.0, 99
  br i1 %12, label %13, label %22

13:                                               ; preds = %11
  %14 = add nsw i32 %.0, 1
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds i32, ptr %0, i64 %15
  %17 = load i32, ptr %16, align 4
  %18 = sext i32 %.0 to i64
  %19 = getelementptr inbounds i32, ptr %1, i64 %18
  store i32 %17, ptr %19, align 4
  br label %20

20:                                               ; preds = %13
  %21 = add nsw i32 %.0, 1
  br label %11, !llvm.loop !16

22:                                               ; preds = %11
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @negative_distance_minus3(ptr noundef %0, ptr noundef %1) #0 {
  br label %3

3:                                                ; preds = %8, %2
  %.01 = phi i32 [ 0, %2 ], [ %9, %8 ]
  %4 = icmp slt i32 %.01, 97
  br i1 %4, label %5, label %10

5:                                                ; preds = %3
  %6 = sext i32 %.01 to i64
  %7 = getelementptr inbounds i32, ptr %0, i64 %6
  store i32 %.01, ptr %7, align 4
  br label %8

8:                                                ; preds = %5
  %9 = add nsw i32 %.01, 1
  br label %3, !llvm.loop !17

10:                                               ; preds = %3
  br label %11

11:                                               ; preds = %20, %10
  %.0 = phi i32 [ 0, %10 ], [ %21, %20 ]
  %12 = icmp slt i32 %.0, 97
  br i1 %12, label %13, label %22

13:                                               ; preds = %11
  %14 = add nsw i32 %.0, 3
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds i32, ptr %0, i64 %15
  %17 = load i32, ptr %16, align 4
  %18 = sext i32 %.0 to i64
  %19 = getelementptr inbounds i32, ptr %1, i64 %18
  store i32 %17, ptr %19, align 4
  br label %20

20:                                               ; preds = %13
  %21 = add nsw i32 %.0, 1
  br label %11, !llvm.loop !18

22:                                               ; preds = %11
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @user_example(ptr noundef %0, ptr noundef %1) #0 {
  br label %3

3:                                                ; preds = %9, %2
  %.01 = phi i32 [ 0, %2 ], [ %10, %9 ]
  %4 = icmp slt i32 %.01, 97
  br i1 %4, label %5, label %11

5:                                                ; preds = %3
  %6 = mul nsw i32 %.01, 2
  %7 = sext i32 %.01 to i64
  %8 = getelementptr inbounds i32, ptr %0, i64 %7
  store i32 %6, ptr %8, align 4
  br label %9

9:                                                ; preds = %5
  %10 = add nsw i32 %.01, 1
  br label %3, !llvm.loop !19

11:                                               ; preds = %3
  br label %12

12:                                               ; preds = %22, %11
  %.0 = phi i32 [ 0, %11 ], [ %23, %22 ]
  %13 = icmp slt i32 %.0, 97
  br i1 %13, label %14, label %24

14:                                               ; preds = %12
  %15 = add nsw i32 %.0, 3
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds i32, ptr %0, i64 %16
  %18 = load i32, ptr %17, align 4
  %19 = add nsw i32 %18, 1
  %20 = sext i32 %.0 to i64
  %21 = getelementptr inbounds i32, ptr %1, i64 %20
  store i32 %19, ptr %21, align 4
  br label %22

22:                                               ; preds = %14
  %23 = add nsw i32 %.0, 1
  br label %12, !llvm.loop !20

24:                                               ; preds = %12
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @output_dependence(ptr noundef %0) #0 {
  br label %2

2:                                                ; preds = %7, %1
  %.01 = phi i32 [ 0, %1 ], [ %8, %7 ]
  %3 = icmp slt i32 %.01, 100
  br i1 %3, label %4, label %9

4:                                                ; preds = %2
  %5 = sext i32 %.01 to i64
  %6 = getelementptr inbounds i32, ptr %0, i64 %5
  store i32 %.01, ptr %6, align 4
  br label %7

7:                                                ; preds = %4
  %8 = add nsw i32 %.01, 1
  br label %2, !llvm.loop !21

9:                                                ; preds = %2
  br label %10

10:                                               ; preds = %16, %9
  %.0 = phi i32 [ 0, %9 ], [ %17, %16 ]
  %11 = icmp slt i32 %.0, 100
  br i1 %11, label %12, label %18

12:                                               ; preds = %10
  %13 = mul nsw i32 2, %.0
  %14 = sext i32 %.0 to i64
  %15 = getelementptr inbounds i32, ptr %0, i64 %14
  store i32 %13, ptr %15, align 4
  br label %16

16:                                               ; preds = %12
  %17 = add nsw i32 %.0, 1
  br label %10, !llvm.loop !22

18:                                               ; preds = %10
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @anti_dependence(ptr noundef %0, ptr noundef %1) #0 {
  br label %3

3:                                                ; preds = %11, %2
  %.01 = phi i32 [ 0, %2 ], [ %12, %11 ]
  %4 = icmp slt i32 %.01, 100
  br i1 %4, label %5, label %13

5:                                                ; preds = %3
  %6 = sext i32 %.01 to i64
  %7 = getelementptr inbounds i32, ptr %0, i64 %6
  %8 = load i32, ptr %7, align 4
  %9 = sext i32 %.01 to i64
  %10 = getelementptr inbounds i32, ptr %1, i64 %9
  store i32 %8, ptr %10, align 4
  br label %11

11:                                               ; preds = %5
  %12 = add nsw i32 %.01, 1
  br label %3, !llvm.loop !23

13:                                               ; preds = %3
  br label %14

14:                                               ; preds = %19, %13
  %.0 = phi i32 [ 0, %13 ], [ %20, %19 ]
  %15 = icmp slt i32 %.0, 100
  br i1 %15, label %16, label %21

16:                                               ; preds = %14
  %17 = sext i32 %.0 to i64
  %18 = getelementptr inbounds i32, ptr %0, i64 %17
  store i32 %.0, ptr %18, align 4
  br label %19

19:                                               ; preds = %16
  %20 = add nsw i32 %.0, 1
  br label %14, !llvm.loop !24

21:                                               ; preds = %14
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca [100 x i32], align 16
  %2 = alloca [100 x i32], align 16
  %3 = alloca [100 x i32], align 16
  %4 = getelementptr inbounds [100 x i32], ptr %1, i64 0, i64 0
  %5 = getelementptr inbounds [100 x i32], ptr %2, i64 0, i64 0
  %6 = getelementptr inbounds [100 x i32], ptr %3, i64 0, i64 0
  call void @no_dependence(ptr noundef %4, ptr noundef %5, ptr noundef %6)
  %7 = getelementptr inbounds [100 x i32], ptr %1, i64 0, i64 0
  %8 = getelementptr inbounds [100 x i32], ptr %2, i64 0, i64 0
  call void @distance_zero(ptr noundef %7, ptr noundef %8)
  %9 = getelementptr inbounds [100 x i32], ptr %1, i64 0, i64 0
  %10 = getelementptr inbounds [100 x i32], ptr %2, i64 0, i64 0
  call void @positive_distance_1(ptr noundef %9, ptr noundef %10)
  %11 = getelementptr inbounds [100 x i32], ptr %1, i64 0, i64 0
  %12 = getelementptr inbounds [100 x i32], ptr %2, i64 0, i64 0
  call void @positive_distance_3(ptr noundef %11, ptr noundef %12)
  %13 = getelementptr inbounds [100 x i32], ptr %1, i64 0, i64 0
  %14 = getelementptr inbounds [100 x i32], ptr %2, i64 0, i64 0
  call void @negative_distance_minus1(ptr noundef %13, ptr noundef %14)
  %15 = getelementptr inbounds [100 x i32], ptr %1, i64 0, i64 0
  %16 = getelementptr inbounds [100 x i32], ptr %2, i64 0, i64 0
  call void @negative_distance_minus3(ptr noundef %15, ptr noundef %16)
  %17 = getelementptr inbounds [100 x i32], ptr %1, i64 0, i64 0
  %18 = getelementptr inbounds [100 x i32], ptr %2, i64 0, i64 0
  call void @user_example(ptr noundef %17, ptr noundef %18)
  %19 = getelementptr inbounds [100 x i32], ptr %1, i64 0, i64 0
  call void @output_dependence(ptr noundef %19)
  %20 = getelementptr inbounds [100 x i32], ptr %1, i64 0, i64 0
  %21 = getelementptr inbounds [100 x i32], ptr %2, i64 0, i64 0
  call void @anti_dependence(ptr noundef %20, ptr noundef %21)
  ret i32 0
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
!23 = distinct !{!23, !7}
!24 = distinct !{!24, !7}
