; ModuleID = 'Test_adiacenza.ll'
source_filename = "Test_adiacenza.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @adjacent_plain(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  br label %4

4:                                                ; preds = %13, %3
  %.01 = phi i32 [ 0, %3 ], [ %14, %13 ]
  %5 = icmp slt i32 %.01, 128
  br i1 %5, label %6, label %15

6:                                                ; preds = %4
  %7 = sext i32 %.01 to i64
  %8 = getelementptr inbounds i32, ptr %1, i64 %7
  %9 = load i32, ptr %8, align 4
  %10 = add nsw i32 %9, 1
  %11 = sext i32 %.01 to i64
  %12 = getelementptr inbounds i32, ptr %0, i64 %11
  store i32 %10, ptr %12, align 4
  br label %13

13:                                               ; preds = %6
  %14 = add nsw i32 %.01, 1
  br label %4, !llvm.loop !6

15:                                               ; preds = %4
  br label %16

16:                                               ; preds = %25, %15
  %.0 = phi i32 [ 0, %15 ], [ %26, %25 ]
  %17 = icmp slt i32 %.0, 128
  br i1 %17, label %18, label %27

18:                                               ; preds = %16
  %19 = sext i32 %.0 to i64
  %20 = getelementptr inbounds i32, ptr %0, i64 %19
  %21 = load i32, ptr %20, align 4
  %22 = mul nsw i32 %21, 2
  %23 = sext i32 %.0 to i64
  %24 = getelementptr inbounds i32, ptr %2, i64 %23
  store i32 %22, ptr %24, align 4
  br label %25

25:                                               ; preds = %18
  %26 = add nsw i32 %.0, 1
  br label %16, !llvm.loop !8

27:                                               ; preds = %16
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @non_adjacent_statement(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  br label %4

4:                                                ; preds = %12, %3
  %.01 = phi i32 [ 0, %3 ], [ %13, %12 ]
  %5 = icmp slt i32 %.01, 128
  br i1 %5, label %6, label %14

6:                                                ; preds = %4
  %7 = sext i32 %.01 to i64
  %8 = getelementptr inbounds i32, ptr %1, i64 %7
  %9 = load i32, ptr %8, align 4
  %10 = sext i32 %.01 to i64
  %11 = getelementptr inbounds i32, ptr %0, i64 %10
  store i32 %9, ptr %11, align 4
  br label %12

12:                                               ; preds = %6
  %13 = add nsw i32 %.01, 1
  br label %4, !llvm.loop !9

14:                                               ; preds = %4
  br label %15

15:                                               ; preds = %24, %14
  %.0 = phi i32 [ 0, %14 ], [ %25, %24 ]
  %16 = icmp slt i32 %.0, 128
  br i1 %16, label %17, label %26

17:                                               ; preds = %15
  %18 = sext i32 %.0 to i64
  %19 = getelementptr inbounds i32, ptr %0, i64 %18
  %20 = load i32, ptr %19, align 4
  %21 = add nsw i32 %20, 7
  %22 = sext i32 %.0 to i64
  %23 = getelementptr inbounds i32, ptr %2, i64 %22
  store i32 %21, ptr %23, align 4
  br label %24

24:                                               ; preds = %17
  %25 = add nsw i32 %.0, 1
  br label %15, !llvm.loop !10

26:                                               ; preds = %15
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @dirty_preheader(ptr noundef %0, ptr noundef %1, ptr noundef %2, i32 noundef %3) #0 {
  br label %5

5:                                                ; preds = %13, %4
  %.01 = phi i32 [ 0, %4 ], [ %14, %13 ]
  %6 = icmp slt i32 %.01, %3
  br i1 %6, label %7, label %15

7:                                                ; preds = %5
  %8 = sext i32 %.01 to i64
  %9 = getelementptr inbounds i32, ptr %1, i64 %8
  %10 = load i32, ptr %9, align 4
  %11 = sext i32 %.01 to i64
  %12 = getelementptr inbounds i32, ptr %0, i64 %11
  store i32 %10, ptr %12, align 4
  br label %13

13:                                               ; preds = %7
  %14 = add nsw i32 %.01, 1
  br label %5, !llvm.loop !11

15:                                               ; preds = %5
  %16 = mul nsw i32 %3, 2
  br label %17

17:                                               ; preds = %26, %15
  %.0 = phi i32 [ 0, %15 ], [ %27, %26 ]
  %18 = icmp slt i32 %.0, %3
  br i1 %18, label %19, label %28

19:                                               ; preds = %17
  %20 = sext i32 %.0 to i64
  %21 = getelementptr inbounds i32, ptr %0, i64 %20
  %22 = load i32, ptr %21, align 4
  %23 = add nsw i32 %22, %16
  %24 = sext i32 %.0 to i64
  %25 = getelementptr inbounds i32, ptr %2, i64 %24
  store i32 %23, ptr %25, align 4
  br label %26

26:                                               ; preds = %19
  %27 = add nsw i32 %.0, 1
  br label %17, !llvm.loop !12

28:                                               ; preds = %17
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @guarded_same_guard(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = icmp sgt i32 %2, 0
  br i1 %4, label %5, label %30

5:                                                ; preds = %3
  br label %6

6:                                                ; preds = %15, %5
  %.01 = phi i32 [ 0, %5 ], [ %16, %15 ]
  %7 = icmp slt i32 %.01, %2
  br i1 %7, label %8, label %17

8:                                                ; preds = %6
  %9 = sext i32 %.01 to i64
  %10 = getelementptr inbounds i32, ptr %1, i64 %9
  %11 = load i32, ptr %10, align 4
  %12 = add nsw i32 %11, 1
  %13 = sext i32 %.01 to i64
  %14 = getelementptr inbounds i32, ptr %0, i64 %13
  store i32 %12, ptr %14, align 4
  br label %15

15:                                               ; preds = %8
  %16 = add nsw i32 %.01, 1
  br label %6, !llvm.loop !13

17:                                               ; preds = %6
  br label %18

18:                                               ; preds = %27, %17
  %.0 = phi i32 [ 0, %17 ], [ %28, %27 ]
  %19 = icmp slt i32 %.0, %2
  br i1 %19, label %20, label %29

20:                                               ; preds = %18
  %21 = sext i32 %.0 to i64
  %22 = getelementptr inbounds i32, ptr %0, i64 %21
  %23 = load i32, ptr %22, align 4
  %24 = mul nsw i32 %23, 2
  %25 = sext i32 %.0 to i64
  %26 = getelementptr inbounds i32, ptr %1, i64 %25
  store i32 %24, ptr %26, align 4
  br label %27

27:                                               ; preds = %20
  %28 = add nsw i32 %.0, 1
  br label %18, !llvm.loop !14

29:                                               ; preds = %18
  br label %30

30:                                               ; preds = %29, %3
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @guarded_different_guards(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = icmp sgt i32 %2, 0
  br i1 %4, label %5, label %17

5:                                                ; preds = %3
  br label %6

6:                                                ; preds = %14, %5
  %.01 = phi i32 [ 0, %5 ], [ %15, %14 ]
  %7 = icmp slt i32 %.01, %2
  br i1 %7, label %8, label %16

8:                                                ; preds = %6
  %9 = sext i32 %.01 to i64
  %10 = getelementptr inbounds i32, ptr %1, i64 %9
  %11 = load i32, ptr %10, align 4
  %12 = sext i32 %.01 to i64
  %13 = getelementptr inbounds i32, ptr %0, i64 %12
  store i32 %11, ptr %13, align 4
  br label %14

14:                                               ; preds = %8
  %15 = add nsw i32 %.01, 1
  br label %6, !llvm.loop !15

16:                                               ; preds = %6
  br label %17

17:                                               ; preds = %16, %3
  %18 = icmp sgt i32 %2, 1
  br i1 %18, label %19, label %31

19:                                               ; preds = %17
  br label %20

20:                                               ; preds = %28, %19
  %.0 = phi i32 [ 0, %19 ], [ %29, %28 ]
  %21 = icmp slt i32 %.0, %2
  br i1 %21, label %22, label %30

22:                                               ; preds = %20
  %23 = sext i32 %.0 to i64
  %24 = getelementptr inbounds i32, ptr %0, i64 %23
  %25 = load i32, ptr %24, align 4
  %26 = sext i32 %.0 to i64
  %27 = getelementptr inbounds i32, ptr %1, i64 %26
  store i32 %25, ptr %27, align 4
  br label %28

28:                                               ; preds = %22
  %29 = add nsw i32 %.0, 1
  br label %20, !llvm.loop !16

30:                                               ; preds = %20
  br label %31

31:                                               ; preds = %30, %17
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @guarded_dirty_guard(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = mul nsw i32 %2, 4
  %5 = icmp sgt i32 %4, 0
  br i1 %5, label %6, label %29

6:                                                ; preds = %3
  br label %7

7:                                                ; preds = %15, %6
  %.01 = phi i32 [ 0, %6 ], [ %16, %15 ]
  %8 = icmp slt i32 %.01, %2
  br i1 %8, label %9, label %17

9:                                                ; preds = %7
  %10 = sext i32 %.01 to i64
  %11 = getelementptr inbounds i32, ptr %1, i64 %10
  %12 = load i32, ptr %11, align 4
  %13 = sext i32 %.01 to i64
  %14 = getelementptr inbounds i32, ptr %0, i64 %13
  store i32 %12, ptr %14, align 4
  br label %15

15:                                               ; preds = %9
  %16 = add nsw i32 %.01, 1
  br label %7, !llvm.loop !17

17:                                               ; preds = %7
  br label %18

18:                                               ; preds = %26, %17
  %.0 = phi i32 [ 0, %17 ], [ %27, %26 ]
  %19 = icmp slt i32 %.0, %2
  br i1 %19, label %20, label %28

20:                                               ; preds = %18
  %21 = sext i32 %.0 to i64
  %22 = getelementptr inbounds i32, ptr %0, i64 %21
  %23 = load i32, ptr %22, align 4
  %24 = sext i32 %.0 to i64
  %25 = getelementptr inbounds i32, ptr %1, i64 %24
  store i32 %23, ptr %25, align 4
  br label %26

26:                                               ; preds = %20
  %27 = add nsw i32 %.0, 1
  br label %18, !llvm.loop !18

28:                                               ; preds = %18
  br label %29

29:                                               ; preds = %28, %3
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @guarded_intermediate_block(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = icmp sgt i32 %2, 0
  br i1 %4, label %5, label %17

5:                                                ; preds = %3
  br label %6

6:                                                ; preds = %14, %5
  %.01 = phi i32 [ 0, %5 ], [ %15, %14 ]
  %7 = icmp slt i32 %.01, %2
  br i1 %7, label %8, label %16

8:                                                ; preds = %6
  %9 = sext i32 %.01 to i64
  %10 = getelementptr inbounds i32, ptr %1, i64 %9
  %11 = load i32, ptr %10, align 4
  %12 = sext i32 %.01 to i64
  %13 = getelementptr inbounds i32, ptr %0, i64 %12
  store i32 %11, ptr %13, align 4
  br label %14

14:                                               ; preds = %8
  %15 = add nsw i32 %.01, 1
  br label %6, !llvm.loop !19

16:                                               ; preds = %6
  br label %17

17:                                               ; preds = %16, %3
  %18 = icmp sgt i32 %2, 0
  br i1 %18, label %19, label %32

19:                                               ; preds = %17
  br label %20

20:                                               ; preds = %29, %19
  %.0 = phi i32 [ 0, %19 ], [ %30, %29 ]
  %21 = icmp slt i32 %.0, %2
  br i1 %21, label %22, label %31

22:                                               ; preds = %20
  %23 = sext i32 %.0 to i64
  %24 = getelementptr inbounds i32, ptr %0, i64 %23
  %25 = load i32, ptr %24, align 4
  %26 = add nsw i32 %25, 42
  %27 = sext i32 %.0 to i64
  %28 = getelementptr inbounds i32, ptr %1, i64 %27
  store i32 %26, ptr %28, align 4
  br label %29

29:                                               ; preds = %22
  %30 = add nsw i32 %.0, 1
  br label %20, !llvm.loop !20

31:                                               ; preds = %20
  br label %32

32:                                               ; preds = %31, %17
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @nested_siblings(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  br label %4

4:                                                ; preds = %29, %3
  %.02 = phi i32 [ 0, %3 ], [ %30, %29 ]
  %5 = icmp slt i32 %.02, 10
  br i1 %5, label %6, label %31

6:                                                ; preds = %4
  br label %7

7:                                                ; preds = %15, %6
  %.01 = phi i32 [ 0, %6 ], [ %16, %15 ]
  %8 = icmp slt i32 %.01, 128
  br i1 %8, label %9, label %17

9:                                                ; preds = %7
  %10 = sext i32 %.01 to i64
  %11 = getelementptr inbounds i32, ptr %1, i64 %10
  %12 = load i32, ptr %11, align 4
  %13 = sext i32 %.01 to i64
  %14 = getelementptr inbounds i32, ptr %0, i64 %13
  store i32 %12, ptr %14, align 4
  br label %15

15:                                               ; preds = %9
  %16 = add nsw i32 %.01, 1
  br label %7, !llvm.loop !21

17:                                               ; preds = %7
  br label %18

18:                                               ; preds = %26, %17
  %.0 = phi i32 [ 0, %17 ], [ %27, %26 ]
  %19 = icmp slt i32 %.0, 128
  br i1 %19, label %20, label %28

20:                                               ; preds = %18
  %21 = sext i32 %.0 to i64
  %22 = getelementptr inbounds i32, ptr %0, i64 %21
  %23 = load i32, ptr %22, align 4
  %24 = sext i32 %.0 to i64
  %25 = getelementptr inbounds i32, ptr %2, i64 %24
  store i32 %23, ptr %25, align 4
  br label %26

26:                                               ; preds = %20
  %27 = add nsw i32 %.0, 1
  br label %18, !llvm.loop !22

28:                                               ; preds = %18
  br label %29

29:                                               ; preds = %28
  %30 = add nsw i32 %.02, 1
  br label %4, !llvm.loop !23

31:                                               ; preds = %4
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @nested_non_siblings(ptr noundef %0, ptr noundef %1) #0 {
  br label %3

3:                                                ; preds = %17, %2
  %.02 = phi i32 [ 0, %2 ], [ %18, %17 ]
  %4 = icmp slt i32 %.02, 128
  br i1 %4, label %5, label %19

5:                                                ; preds = %3
  br label %6

6:                                                ; preds = %14, %5
  %.01 = phi i32 [ 0, %5 ], [ %15, %14 ]
  %7 = icmp slt i32 %.01, 128
  br i1 %7, label %8, label %16

8:                                                ; preds = %6
  %9 = sext i32 %.01 to i64
  %10 = getelementptr inbounds i32, ptr %1, i64 %9
  %11 = load i32, ptr %10, align 4
  %12 = sext i32 %.01 to i64
  %13 = getelementptr inbounds i32, ptr %0, i64 %12
  store i32 %11, ptr %13, align 4
  br label %14

14:                                               ; preds = %8
  %15 = add nsw i32 %.01, 1
  br label %6, !llvm.loop !24

16:                                               ; preds = %6
  br label %17

17:                                               ; preds = %16
  %18 = add nsw i32 %.02, 1
  br label %3, !llvm.loop !25

19:                                               ; preds = %3
  br label %20

20:                                               ; preds = %28, %19
  %.0 = phi i32 [ 0, %19 ], [ %29, %28 ]
  %21 = icmp slt i32 %.0, 128
  br i1 %21, label %22, label %30

22:                                               ; preds = %20
  %23 = sext i32 %.0 to i64
  %24 = getelementptr inbounds i32, ptr %0, i64 %23
  %25 = load i32, ptr %24, align 4
  %26 = sext i32 %.0 to i64
  %27 = getelementptr inbounds i32, ptr %1, i64 %26
  store i32 %25, ptr %27, align 4
  br label %28

28:                                               ; preds = %22
  %29 = add nsw i32 %.0, 1
  br label %20, !llvm.loop !26

30:                                               ; preds = %20
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @multiple_exit_loop(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  br label %4

4:                                                ; preds = %15, %3
  %.01 = phi i32 [ 0, %3 ], [ %16, %15 ]
  %5 = icmp slt i32 %.01, %2
  br i1 %5, label %6, label %17

6:                                                ; preds = %4
  %7 = icmp eq i32 %.01, 10
  br i1 %7, label %8, label %9

8:                                                ; preds = %6
  br label %17

9:                                                ; preds = %6
  %10 = sext i32 %.01 to i64
  %11 = getelementptr inbounds i32, ptr %1, i64 %10
  %12 = load i32, ptr %11, align 4
  %13 = sext i32 %.01 to i64
  %14 = getelementptr inbounds i32, ptr %0, i64 %13
  store i32 %12, ptr %14, align 4
  br label %15

15:                                               ; preds = %9
  %16 = add nsw i32 %.01, 1
  br label %4, !llvm.loop !27

17:                                               ; preds = %8, %4
  br label %18

18:                                               ; preds = %26, %17
  %.0 = phi i32 [ 0, %17 ], [ %27, %26 ]
  %19 = icmp slt i32 %.0, %2
  br i1 %19, label %20, label %28

20:                                               ; preds = %18
  %21 = sext i32 %.0 to i64
  %22 = getelementptr inbounds i32, ptr %0, i64 %21
  %23 = load i32, ptr %22, align 4
  %24 = sext i32 %.0 to i64
  %25 = getelementptr inbounds i32, ptr %1, i64 %24
  store i32 %23, ptr %25, align 4
  br label %26

26:                                               ; preds = %20
  %27 = add nsw i32 %.0, 1
  br label %18, !llvm.loop !28

28:                                               ; preds = %18
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @dependent_loops(ptr noundef %0, ptr noundef %1) #0 {
  br label %3

3:                                                ; preds = %8, %2
  %.01 = phi i32 [ 0, %2 ], [ %9, %8 ]
  %4 = icmp slt i32 %.01, 128
  br i1 %4, label %5, label %10

5:                                                ; preds = %3
  %6 = sext i32 %.01 to i64
  %7 = getelementptr inbounds i32, ptr %0, i64 %6
  store i32 %.01, ptr %7, align 4
  br label %8

8:                                                ; preds = %5
  %9 = add nsw i32 %.01, 1
  br label %3, !llvm.loop !29

10:                                               ; preds = %3
  br label %11

11:                                               ; preds = %19, %10
  %.0 = phi i32 [ 0, %10 ], [ %20, %19 ]
  %12 = icmp slt i32 %.0, 128
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
  br label %11, !llvm.loop !30

21:                                               ; preds = %11
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @perfectly_fusible(ptr noundef %0, ptr noundef %1, ptr noundef %2, i32 noundef %3) #0 {
  %5 = icmp sgt i32 %3, 0
  br i1 %5, label %6, label %31

6:                                                ; preds = %4
  br label %7

7:                                                ; preds = %16, %6
  %.01 = phi i32 [ 0, %6 ], [ %17, %16 ]
  %8 = icmp slt i32 %.01, %3
  br i1 %8, label %9, label %18

9:                                                ; preds = %7
  %10 = sext i32 %.01 to i64
  %11 = getelementptr inbounds i32, ptr %1, i64 %10
  %12 = load i32, ptr %11, align 4
  %13 = add nsw i32 %12, 1
  %14 = sext i32 %.01 to i64
  %15 = getelementptr inbounds i32, ptr %0, i64 %14
  store i32 %13, ptr %15, align 4
  br label %16

16:                                               ; preds = %9
  %17 = add nsw i32 %.01, 1
  br label %7, !llvm.loop !31

18:                                               ; preds = %7
  br label %19

19:                                               ; preds = %28, %18
  %.0 = phi i32 [ 0, %18 ], [ %29, %28 ]
  %20 = icmp slt i32 %.0, %3
  br i1 %20, label %21, label %30

21:                                               ; preds = %19
  %22 = sext i32 %.0 to i64
  %23 = getelementptr inbounds i32, ptr %0, i64 %22
  %24 = load i32, ptr %23, align 4
  %25 = mul nsw i32 %24, 3
  %26 = sext i32 %.0 to i64
  %27 = getelementptr inbounds i32, ptr %2, i64 %26
  store i32 %25, ptr %27, align 4
  br label %28

28:                                               ; preds = %21
  %29 = add nsw i32 %.0, 1
  br label %19, !llvm.loop !32

30:                                               ; preds = %19
  br label %31

31:                                               ; preds = %30, %4
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca [128 x i32], align 16
  %2 = alloca [128 x i32], align 16
  %3 = alloca [128 x i32], align 16
  %4 = getelementptr inbounds [128 x i32], ptr %1, i64 0, i64 0
  %5 = getelementptr inbounds [128 x i32], ptr %2, i64 0, i64 0
  %6 = getelementptr inbounds [128 x i32], ptr %3, i64 0, i64 0
  call void @adjacent_plain(ptr noundef %4, ptr noundef %5, ptr noundef %6)
  %7 = getelementptr inbounds [128 x i32], ptr %1, i64 0, i64 0
  %8 = getelementptr inbounds [128 x i32], ptr %2, i64 0, i64 0
  %9 = getelementptr inbounds [128 x i32], ptr %3, i64 0, i64 0
  call void @non_adjacent_statement(ptr noundef %7, ptr noundef %8, ptr noundef %9)
  %10 = getelementptr inbounds [128 x i32], ptr %1, i64 0, i64 0
  %11 = getelementptr inbounds [128 x i32], ptr %2, i64 0, i64 0
  %12 = getelementptr inbounds [128 x i32], ptr %3, i64 0, i64 0
  call void @dirty_preheader(ptr noundef %10, ptr noundef %11, ptr noundef %12, i32 noundef 128)
  %13 = getelementptr inbounds [128 x i32], ptr %1, i64 0, i64 0
  %14 = getelementptr inbounds [128 x i32], ptr %2, i64 0, i64 0
  call void @guarded_same_guard(ptr noundef %13, ptr noundef %14, i32 noundef 128)
  %15 = getelementptr inbounds [128 x i32], ptr %1, i64 0, i64 0
  %16 = getelementptr inbounds [128 x i32], ptr %2, i64 0, i64 0
  call void @guarded_different_guards(ptr noundef %15, ptr noundef %16, i32 noundef 128)
  %17 = getelementptr inbounds [128 x i32], ptr %1, i64 0, i64 0
  %18 = getelementptr inbounds [128 x i32], ptr %2, i64 0, i64 0
  call void @guarded_dirty_guard(ptr noundef %17, ptr noundef %18, i32 noundef 128)
  %19 = getelementptr inbounds [128 x i32], ptr %1, i64 0, i64 0
  %20 = getelementptr inbounds [128 x i32], ptr %2, i64 0, i64 0
  call void @guarded_intermediate_block(ptr noundef %19, ptr noundef %20, i32 noundef 128)
  %21 = getelementptr inbounds [128 x i32], ptr %1, i64 0, i64 0
  %22 = getelementptr inbounds [128 x i32], ptr %2, i64 0, i64 0
  %23 = getelementptr inbounds [128 x i32], ptr %3, i64 0, i64 0
  call void @nested_siblings(ptr noundef %21, ptr noundef %22, ptr noundef %23)
  %24 = getelementptr inbounds [128 x i32], ptr %1, i64 0, i64 0
  %25 = getelementptr inbounds [128 x i32], ptr %2, i64 0, i64 0
  call void @nested_non_siblings(ptr noundef %24, ptr noundef %25)
  %26 = getelementptr inbounds [128 x i32], ptr %1, i64 0, i64 0
  %27 = getelementptr inbounds [128 x i32], ptr %2, i64 0, i64 0
  call void @multiple_exit_loop(ptr noundef %26, ptr noundef %27, i32 noundef 128)
  %28 = getelementptr inbounds [128 x i32], ptr %1, i64 0, i64 0
  %29 = getelementptr inbounds [128 x i32], ptr %2, i64 0, i64 0
  call void @dependent_loops(ptr noundef %28, ptr noundef %29)
  %30 = getelementptr inbounds [128 x i32], ptr %1, i64 0, i64 0
  %31 = getelementptr inbounds [128 x i32], ptr %2, i64 0, i64 0
  %32 = getelementptr inbounds [128 x i32], ptr %3, i64 0, i64 0
  call void @perfectly_fusible(ptr noundef %30, ptr noundef %31, ptr noundef %32, i32 noundef 128)
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
!25 = distinct !{!25, !7}
!26 = distinct !{!26, !7}
!27 = distinct !{!27, !7}
!28 = distinct !{!28, !7}
!29 = distinct !{!29, !7}
!30 = distinct !{!30, !7}
!31 = distinct !{!31, !7}
!32 = distinct !{!32, !7}
