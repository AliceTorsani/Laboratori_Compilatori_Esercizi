; ModuleID = 'tripCounts.m2r.ll'
source_filename = "tripCounts.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local void @_Z6sameTCPiS_(ptr noundef %0, ptr noundef %1) #0 {
  br label %3

3:                                                ; preds = %10, %2
  %.01 = phi i32 [ 0, %2 ], [ %11, %10 ]
  %4 = icmp slt i32 %.01, 15
  br i1 %4, label %5, label %22

5:                                                ; preds = %3
  %6 = sext i32 %.01 to i64
  %7 = getelementptr inbounds i32, ptr %0, i64 %6
  %8 = load i32, ptr %7, align 4
  %9 = add nsw i32 %8, 1
  store i32 %9, ptr %7, align 4
  br label %15

10:                                               ; preds = %15
  %11 = add nsw i32 %.01, 1
  br label %3, !llvm.loop !6

12:                                               ; No predecessors!
  br label %13

13:                                               ; preds = %20, %12
  %.0 = phi i32 [ 0, %12 ], [ %21, %20 ]
  %14 = icmp slt i32 %.0, 15
  br i1 %14, label %20, label %22

15:                                               ; preds = %5
  %16 = sext i32 %.01 to i64
  %17 = getelementptr inbounds i32, ptr %1, i64 %16
  %18 = load i32, ptr %17, align 4
  %19 = sub nsw i32 %18, 1
  store i32 %19, ptr %17, align 4
  br label %10

20:                                               ; preds = %13
  %21 = add nsw i32 %.0, 1
  br label %13, !llvm.loop !8

22:                                               ; preds = %3, %13
  ret void
}

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local void @_Z10sameTC_refPiS_i(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  br label %4

4:                                                ; preds = %11, %3
  %.01 = phi i32 [ 0, %3 ], [ %12, %11 ]
  %5 = icmp slt i32 %.01, %2
  br i1 %5, label %6, label %23

6:                                                ; preds = %4
  %7 = sext i32 %.01 to i64
  %8 = getelementptr inbounds i32, ptr %0, i64 %7
  %9 = load i32, ptr %8, align 4
  %10 = add nsw i32 %9, 1
  store i32 %10, ptr %8, align 4
  br label %16

11:                                               ; preds = %16
  %12 = add nsw i32 %.01, 1
  br label %4, !llvm.loop !9

13:                                               ; No predecessors!
  br label %14

14:                                               ; preds = %21, %13
  %.0 = phi i32 [ 0, %13 ], [ %22, %21 ]
  %15 = icmp slt i32 %.0, %2
  br i1 %15, label %21, label %23

16:                                               ; preds = %6
  %17 = sext i32 %.01 to i64
  %18 = getelementptr inbounds i32, ptr %1, i64 %17
  %19 = load i32, ptr %18, align 4
  %20 = sub nsw i32 %19, 1
  store i32 %20, ptr %18, align 4
  br label %11

21:                                               ; preds = %14
  %22 = add nsw i32 %.0, 1
  br label %14, !llvm.loop !10

23:                                               ; preds = %4, %14
  ret void
}

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local void @_Z15sameTC_ref_diffPiS_i(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = sub nsw i32 %2, 5
  br label %5

5:                                                ; preds = %12, %3
  %.01 = phi i32 [ 0, %3 ], [ %13, %12 ]
  %6 = icmp slt i32 %.01, %2
  br i1 %6, label %7, label %14

7:                                                ; preds = %5
  %8 = sext i32 %.01 to i64
  %9 = getelementptr inbounds i32, ptr %0, i64 %8
  %10 = load i32, ptr %9, align 4
  %11 = add nsw i32 %10, 1
  store i32 %11, ptr %9, align 4
  br label %12

12:                                               ; preds = %7
  %13 = add nsw i32 %.01, 1
  br label %5, !llvm.loop !11

14:                                               ; preds = %5
  br label %15

15:                                               ; preds = %22, %14
  %.0 = phi i32 [ 0, %14 ], [ %23, %22 ]
  %16 = icmp slt i32 %.0, %4
  br i1 %16, label %17, label %24

17:                                               ; preds = %15
  %18 = sext i32 %.0 to i64
  %19 = getelementptr inbounds i32, ptr %1, i64 %18
  %20 = load i32, ptr %19, align 4
  %21 = sub nsw i32 %20, 1
  store i32 %21, ptr %19, align 4
  br label %22

22:                                               ; preds = %17
  %23 = add nsw i32 %.0, 1
  br label %15, !llvm.loop !12

24:                                               ; preds = %15
  ret void
}

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local void @_Z13sameTC_staticPiS_(ptr noundef %0, ptr noundef %1) #0 {
  br label %3

3:                                                ; preds = %10, %2
  %.01 = phi i32 [ 0, %2 ], [ %11, %10 ]
  %4 = icmp slt i32 %.01, 5
  br i1 %4, label %5, label %22

5:                                                ; preds = %3
  %6 = sext i32 %.01 to i64
  %7 = getelementptr inbounds i32, ptr %0, i64 %6
  %8 = load i32, ptr %7, align 4
  %9 = add nsw i32 %8, 1
  store i32 %9, ptr %7, align 4
  br label %15

10:                                               ; preds = %15
  %11 = add nsw i32 %.01, 1
  br label %3, !llvm.loop !13

12:                                               ; No predecessors!
  br label %13

13:                                               ; preds = %20, %12
  %.0 = phi i32 [ 0, %12 ], [ %21, %20 ]
  %14 = icmp slt i32 %.0, 5
  br i1 %14, label %20, label %22

15:                                               ; preds = %5
  %16 = sext i32 %.01 to i64
  %17 = getelementptr inbounds i32, ptr %1, i64 %16
  %18 = load i32, ptr %17, align 4
  %19 = sub nsw i32 %18, 1
  store i32 %19, ptr %17, align 4
  br label %10

20:                                               ; preds = %13
  %21 = add nsw i32 %.0, 1
  br label %13, !llvm.loop !14

22:                                               ; preds = %3, %13
  ret void
}

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local void @_Z18sameTC_static_diffPiS_(ptr noundef %0, ptr noundef %1) #0 {
  br label %3

3:                                                ; preds = %10, %2
  %.01 = phi i32 [ 0, %2 ], [ %11, %10 ]
  %4 = icmp slt i32 %.01, 5
  br i1 %4, label %5, label %12

5:                                                ; preds = %3
  %6 = sext i32 %.01 to i64
  %7 = getelementptr inbounds i32, ptr %0, i64 %6
  %8 = load i32, ptr %7, align 4
  %9 = add nsw i32 %8, 1
  store i32 %9, ptr %7, align 4
  br label %10

10:                                               ; preds = %5
  %11 = add nsw i32 %.01, 1
  br label %3, !llvm.loop !15

12:                                               ; preds = %3
  br label %13

13:                                               ; preds = %20, %12
  %.0 = phi i32 [ 0, %12 ], [ %21, %20 ]
  %14 = icmp slt i32 %.0, 1
  br i1 %14, label %15, label %22

15:                                               ; preds = %13
  %16 = sext i32 %.0 to i64
  %17 = getelementptr inbounds i32, ptr %1, i64 %16
  %18 = load i32, ptr %17, align 4
  %19 = sub nsw i32 %18, 1
  store i32 %19, ptr %17, align 4
  br label %20

20:                                               ; preds = %15
  %21 = add nsw i32 %.0, 1
  br label %13, !llvm.loop !16

22:                                               ; preds = %13
  ret void
}

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local void @_Z12sameTC_equalPiS_ii(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = icmp eq i32 %2, %3
  br i1 %5, label %6, label %27

6:                                                ; preds = %4
  br label %7

7:                                                ; preds = %14, %6
  %.01 = phi i32 [ 0, %6 ], [ %15, %14 ]
  %8 = icmp slt i32 %.01, %2
  br i1 %8, label %9, label %26

9:                                                ; preds = %7
  %10 = sext i32 %.01 to i64
  %11 = getelementptr inbounds i32, ptr %0, i64 %10
  %12 = load i32, ptr %11, align 4
  %13 = add nsw i32 %12, 1
  store i32 %13, ptr %11, align 4
  br label %19

14:                                               ; preds = %19
  %15 = add nsw i32 %.01, 1
  br label %7, !llvm.loop !17

16:                                               ; No predecessors!
  br label %17

17:                                               ; preds = %24, %16
  %.0 = phi i32 [ 0, %16 ], [ %25, %24 ]
  %18 = icmp slt i32 %.0, %2
  br i1 %18, label %24, label %26

19:                                               ; preds = %9
  %20 = sext i32 %.01 to i64
  %21 = getelementptr inbounds i32, ptr %1, i64 %20
  %22 = load i32, ptr %21, align 4
  %23 = sub nsw i32 %22, 1
  store i32 %23, ptr %21, align 4
  br label %14

24:                                               ; preds = %17
  %25 = add nsw i32 %.0, 1
  br label %17, !llvm.loop !18

26:                                               ; preds = %7, %17
  br label %27

27:                                               ; preds = %26, %4
  %28 = add nsw i32 %3, 2
  ret void
}

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local void @_Z15sameTC_modifiedPiS_ii(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  br label %5

5:                                                ; preds = %12, %4
  %.01 = phi i32 [ 0, %4 ], [ %13, %12 ]
  %6 = icmp slt i32 %.01, %3
  br i1 %6, label %7, label %24

7:                                                ; preds = %5
  %8 = sext i32 %.01 to i64
  %9 = getelementptr inbounds i32, ptr %0, i64 %8
  %10 = load i32, ptr %9, align 4
  %11 = add nsw i32 %10, 1
  store i32 %11, ptr %9, align 4
  br label %17

12:                                               ; preds = %17
  %13 = add nsw i32 %.01, 1
  br label %5, !llvm.loop !19

14:                                               ; No predecessors!
  br label %15

15:                                               ; preds = %22, %14
  %.0 = phi i32 [ 0, %14 ], [ %23, %22 ]
  %16 = icmp slt i32 %.0, %3
  br i1 %16, label %22, label %24

17:                                               ; preds = %7
  %18 = sext i32 %.01 to i64
  %19 = getelementptr inbounds i32, ptr %1, i64 %18
  %20 = load i32, ptr %19, align 4
  %21 = sub nsw i32 %20, 1
  store i32 %21, ptr %19, align 4
  br label %12

22:                                               ; preds = %15
  %23 = add nsw i32 %.0, 1
  br label %15, !llvm.loop !20

24:                                               ; preds = %5, %15
  ret void
}

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local void @_Z15sameTC_assignedPiS_ii(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  br label %5

5:                                                ; preds = %12, %4
  %.01 = phi i32 [ 0, %4 ], [ %13, %12 ]
  %6 = icmp slt i32 %.01, 15
  br i1 %6, label %7, label %14

7:                                                ; preds = %5
  %8 = sext i32 %.01 to i64
  %9 = getelementptr inbounds i32, ptr %0, i64 %8
  %10 = load i32, ptr %9, align 4
  %11 = add nsw i32 %10, 1
  store i32 %11, ptr %9, align 4
  br label %12

12:                                               ; preds = %7
  %13 = add nsw i32 %.01, 1
  br label %5, !llvm.loop !21

14:                                               ; preds = %5
  br label %15

15:                                               ; preds = %22, %14
  %.0 = phi i32 [ 0, %14 ], [ %23, %22 ]
  %16 = icmp slt i32 %.0, 20
  br i1 %16, label %17, label %24

17:                                               ; preds = %15
  %18 = sext i32 %.0 to i64
  %19 = getelementptr inbounds i32, ptr %1, i64 %18
  %20 = load i32, ptr %19, align 4
  %21 = sub nsw i32 %20, 1
  store i32 %21, ptr %19, align 4
  br label %22

22:                                               ; preds = %17
  %23 = add nsw i32 %.0, 1
  br label %15, !llvm.loop !22

24:                                               ; preds = %15
  ret void
}

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local void @_Z20sameTC_assignedEqualPiS_ii(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  br label %5

5:                                                ; preds = %12, %4
  %.01 = phi i32 [ 0, %4 ], [ %13, %12 ]
  %6 = icmp slt i32 %.01, 15
  br i1 %6, label %7, label %24

7:                                                ; preds = %5
  %8 = sext i32 %.01 to i64
  %9 = getelementptr inbounds i32, ptr %0, i64 %8
  %10 = load i32, ptr %9, align 4
  %11 = add nsw i32 %10, 1
  store i32 %11, ptr %9, align 4
  br label %17

12:                                               ; preds = %17
  %13 = add nsw i32 %.01, 1
  br label %5, !llvm.loop !23

14:                                               ; No predecessors!
  br label %15

15:                                               ; preds = %22, %14
  %.0 = phi i32 [ 0, %14 ], [ %23, %22 ]
  %16 = icmp slt i32 %.0, 15
  br i1 %16, label %22, label %24

17:                                               ; preds = %7
  %18 = sext i32 %.01 to i64
  %19 = getelementptr inbounds i32, ptr %1, i64 %18
  %20 = load i32, ptr %19, align 4
  %21 = sub nsw i32 %20, 1
  store i32 %21, ptr %19, align 4
  br label %12

22:                                               ; preds = %15
  %23 = add nsw i32 %.0, 1
  br label %15, !llvm.loop !24

24:                                               ; preds = %5, %15
  ret void
}

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local void @_Z24sameTC_differentWithEslePiS_ii(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = icmp eq i32 %2, %3
  br i1 %5, label %6, label %28

6:                                                ; preds = %4
  br label %7

7:                                                ; preds = %15, %6
  %.02 = phi i32 [ %2, %6 ], [ %14, %15 ]
  %.01 = phi i32 [ 0, %6 ], [ %16, %15 ]
  %8 = icmp slt i32 %.01, %2
  br i1 %8, label %9, label %17

9:                                                ; preds = %7
  %10 = sext i32 %.01 to i64
  %11 = getelementptr inbounds i32, ptr %0, i64 %10
  %12 = load i32, ptr %11, align 4
  %13 = add nsw i32 %12, 1
  store i32 %13, ptr %11, align 4
  %14 = add nsw i32 %.02, 1
  br label %15

15:                                               ; preds = %9
  %16 = add nsw i32 %.01, 1
  br label %7, !llvm.loop !25

17:                                               ; preds = %7
  br label %18

18:                                               ; preds = %25, %17
  %.0 = phi i32 [ 0, %17 ], [ %26, %25 ]
  %19 = icmp slt i32 %.0, %.02
  br i1 %19, label %20, label %27

20:                                               ; preds = %18
  %21 = sext i32 %.0 to i64
  %22 = getelementptr inbounds i32, ptr %1, i64 %21
  %23 = load i32, ptr %22, align 4
  %24 = sub nsw i32 %23, 1
  store i32 %24, ptr %22, align 4
  br label %25

25:                                               ; preds = %20
  %26 = add nsw i32 %.0, 1
  br label %18, !llvm.loop !26

27:                                               ; preds = %18
  br label %30

28:                                               ; preds = %4
  %29 = sub nsw i32 %3, 2
  br label %30

30:                                               ; preds = %28, %27
  %.1 = phi i32 [ %.02, %27 ], [ %29, %28 ]
  %31 = add nsw i32 %.1, 2
  ret void
}

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local void @_Z20sameTC_equalWithEslePiS_ii(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = icmp eq i32 %2, %3
  br i1 %5, label %6, label %27

6:                                                ; preds = %4
  br label %7

7:                                                ; preds = %14, %6
  %.01 = phi i32 [ 0, %6 ], [ %15, %14 ]
  %8 = icmp slt i32 %.01, %2
  br i1 %8, label %9, label %26

9:                                                ; preds = %7
  %10 = sext i32 %.01 to i64
  %11 = getelementptr inbounds i32, ptr %0, i64 %10
  %12 = load i32, ptr %11, align 4
  %13 = add nsw i32 %12, 1
  store i32 %13, ptr %11, align 4
  br label %19

14:                                               ; preds = %19
  %15 = add nsw i32 %.01, 1
  br label %7, !llvm.loop !27

16:                                               ; No predecessors!
  br label %17

17:                                               ; preds = %24, %16
  %.0 = phi i32 [ 0, %16 ], [ %25, %24 ]
  %18 = icmp slt i32 %.0, %2
  br i1 %18, label %24, label %26

19:                                               ; preds = %9
  %20 = sext i32 %.01 to i64
  %21 = getelementptr inbounds i32, ptr %1, i64 %20
  %22 = load i32, ptr %21, align 4
  %23 = sub nsw i32 %22, 1
  store i32 %23, ptr %21, align 4
  br label %14

24:                                               ; preds = %17
  %25 = add nsw i32 %.0, 1
  br label %17, !llvm.loop !28

26:                                               ; preds = %7, %17
  br label %29

27:                                               ; preds = %4
  %28 = sub nsw i32 %3, 2
  br label %29

29:                                               ; preds = %27, %26
  %.02 = phi i32 [ %3, %26 ], [ %28, %27 ]
  %30 = add nsw i32 %.02, 2
  ret void
}

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local void @_Z21sameTC_differentStartPiS_ii(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  br label %5

5:                                                ; preds = %12, %4
  %.01 = phi i32 [ 7, %4 ], [ %13, %12 ]
  %6 = icmp slt i32 %.01, 15
  br i1 %6, label %7, label %14

7:                                                ; preds = %5
  %8 = sext i32 %.01 to i64
  %9 = getelementptr inbounds i32, ptr %0, i64 %8
  %10 = load i32, ptr %9, align 4
  %11 = add nsw i32 %10, 1
  store i32 %11, ptr %9, align 4
  br label %12

12:                                               ; preds = %7
  %13 = add nsw i32 %.01, 1
  br label %5, !llvm.loop !29

14:                                               ; preds = %5
  br label %15

15:                                               ; preds = %22, %14
  %.0 = phi i32 [ 0, %14 ], [ %23, %22 ]
  %16 = icmp slt i32 %.0, 15
  br i1 %16, label %17, label %24

17:                                               ; preds = %15
  %18 = sext i32 %.0 to i64
  %19 = getelementptr inbounds i32, ptr %1, i64 %18
  %20 = load i32, ptr %19, align 4
  %21 = sub nsw i32 %20, 1
  store i32 %21, ptr %19, align 4
  br label %22

22:                                               ; preds = %17
  %23 = add nsw i32 %.0, 1
  br label %15, !llvm.loop !30

24:                                               ; preds = %15
  ret void
}

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local void @_Z22sameTC_differentUpdatePiS_ii(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  br label %5

5:                                                ; preds = %12, %4
  %.01 = phi i32 [ 0, %4 ], [ %13, %12 ]
  %6 = icmp slt i32 %.01, 15
  br i1 %6, label %7, label %14

7:                                                ; preds = %5
  %8 = sext i32 %.01 to i64
  %9 = getelementptr inbounds i32, ptr %0, i64 %8
  %10 = load i32, ptr %9, align 4
  %11 = add nsw i32 %10, 1
  store i32 %11, ptr %9, align 4
  br label %12

12:                                               ; preds = %7
  %13 = add nsw i32 %.01, 1
  br label %5, !llvm.loop !31

14:                                               ; preds = %5
  br label %15

15:                                               ; preds = %23, %14
  %.0 = phi i32 [ 0, %14 ], [ %24, %23 ]
  %16 = icmp slt i32 %.0, 15
  br i1 %16, label %17, label %25

17:                                               ; preds = %15
  %18 = add nsw i32 %.0, 1
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds i32, ptr %1, i64 %19
  %21 = load i32, ptr %20, align 4
  %22 = sub nsw i32 %21, 1
  store i32 %22, ptr %20, align 4
  br label %23

23:                                               ; preds = %17
  %24 = add nsw i32 %18, 1
  br label %15, !llvm.loop !32

25:                                               ; preds = %15
  ret void
}

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local void @_Z16sameTC_doWAndForPiS_ii(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  br label %5

5:                                                ; preds = %12, %4
  %.01 = phi i32 [ 0, %4 ], [ %13, %12 ]
  %6 = icmp slt i32 %.01, 15
  br i1 %6, label %7, label %14

7:                                                ; preds = %5
  %8 = sext i32 %.01 to i64
  %9 = getelementptr inbounds i32, ptr %0, i64 %8
  %10 = load i32, ptr %9, align 4
  %11 = add nsw i32 %10, 1
  store i32 %11, ptr %9, align 4
  br label %12

12:                                               ; preds = %7
  %13 = add nsw i32 %.01, 1
  br label %5, !llvm.loop !33

14:                                               ; preds = %5
  %15 = icmp sgt i32 15, 0
  br i1 %15, label %16, label %26

16:                                               ; preds = %14
  br label %17

17:                                               ; preds = %23, %16
  %.0 = phi i32 [ 0, %16 ], [ %22, %23 ]
  %18 = sext i32 %.0 to i64
  %19 = getelementptr inbounds i32, ptr %1, i64 %18
  %20 = load i32, ptr %19, align 4
  %21 = sub nsw i32 %20, 1
  store i32 %21, ptr %19, align 4
  %22 = add nsw i32 %.0, 1
  br label %23

23:                                               ; preds = %17
  %24 = icmp slt i32 %22, 15
  br i1 %24, label %17, label %25, !llvm.loop !34

25:                                               ; preds = %23
  br label %26

26:                                               ; preds = %25, %14
  ret void
}

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local void @_Z15sameTC_infinitePiS_ii(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  br label %5

5:                                                ; preds = %5, %4
  %6 = getelementptr inbounds i32, ptr %0, i64 0
  %7 = load i32, ptr %6, align 4
  %8 = add nsw i32 %7, 1
  store i32 %8, ptr %6, align 4
  br label %5, !llvm.loop !35
}

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local void @_Z21sameTC_equalWithConstPiS_(ptr noundef %0, ptr noundef %1) #0 {
  br label %3

3:                                                ; preds = %10, %2
  %.01 = phi i32 [ 0, %2 ], [ %11, %10 ]
  %4 = icmp slt i32 %.01, 15
  br i1 %4, label %5, label %22

5:                                                ; preds = %3
  %6 = sext i32 %.01 to i64
  %7 = getelementptr inbounds i32, ptr %0, i64 %6
  %8 = load i32, ptr %7, align 4
  %9 = add nsw i32 %8, 1
  store i32 %9, ptr %7, align 4
  br label %15

10:                                               ; preds = %15
  %11 = add nsw i32 %.01, 1
  br label %3, !llvm.loop !36

12:                                               ; No predecessors!
  br label %13

13:                                               ; preds = %20, %12
  %.0 = phi i32 [ 0, %12 ], [ %21, %20 ]
  %14 = icmp slt i32 %.0, 15
  br i1 %14, label %20, label %22

15:                                               ; preds = %5
  %16 = sext i32 %.01 to i64
  %17 = getelementptr inbounds i32, ptr %1, i64 %16
  %18 = load i32, ptr %17, align 4
  %19 = sub nsw i32 %18, 1
  store i32 %19, ptr %17, align 4
  br label %10

20:                                               ; preds = %13
  %21 = add nsw i32 %.0, 1
  br label %13, !llvm.loop !37

22:                                               ; preds = %3, %13
  ret void
}

; Function Attrs: mustprogress noinline norecurse nounwind uwtable
define dso_local noundef i32 @main() #1 {
  ret i32 0
}

attributes #0 = { mustprogress noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress noinline norecurse nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
!25 = distinct !{!25, !7}
!26 = distinct !{!26, !7}
!27 = distinct !{!27, !7}
!28 = distinct !{!28, !7}
!29 = distinct !{!29, !7}
!30 = distinct !{!30, !7}
!31 = distinct !{!31, !7}
!32 = distinct !{!32, !7}
!33 = distinct !{!33, !7}
!34 = distinct !{!34, !7}
!35 = distinct !{!35, !7}
!36 = distinct !{!36, !7}
!37 = distinct !{!37, !7}
