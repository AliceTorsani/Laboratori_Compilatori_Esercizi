; ModuleID = 'Test_adiacenza.m2r.ll'
source_filename = "Test_adiacenza.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @adjacent_plain(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  br label %4

4:                                                ; preds = %3, %11
  %.011 = phi i32 [ 0, %3 ], [ %12, %11 ]
  %5 = sext i32 %.011 to i64
  %6 = getelementptr inbounds i32, ptr %1, i64 %5
  %7 = load i32, ptr %6, align 4
  %8 = add nsw i32 %7, 1
  %9 = sext i32 %.011 to i64
  %10 = getelementptr inbounds i32, ptr %0, i64 %9
  store i32 %8, ptr %10, align 4
  br label %11

11:                                               ; preds = %4
  %12 = add nsw i32 %.011, 1
  %13 = icmp slt i32 %12, 128
  br i1 %13, label %4, label %14, !llvm.loop !6

14:                                               ; preds = %11
  br label %15

15:                                               ; preds = %14, %22
  %.02 = phi i32 [ 0, %14 ], [ %23, %22 ]
  %16 = sext i32 %.02 to i64
  %17 = getelementptr inbounds i32, ptr %0, i64 %16
  %18 = load i32, ptr %17, align 4
  %19 = mul nsw i32 %18, 2
  %20 = sext i32 %.02 to i64
  %21 = getelementptr inbounds i32, ptr %2, i64 %20
  store i32 %19, ptr %21, align 4
  br label %22

22:                                               ; preds = %15
  %23 = add nsw i32 %.02, 1
  %24 = icmp slt i32 %23, 128
  br i1 %24, label %15, label %25, !llvm.loop !8

25:                                               ; preds = %22
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @non_adjacent_statement(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  br label %4

4:                                                ; preds = %3, %10
  %.011 = phi i32 [ 0, %3 ], [ %11, %10 ]
  %5 = sext i32 %.011 to i64
  %6 = getelementptr inbounds i32, ptr %1, i64 %5
  %7 = load i32, ptr %6, align 4
  %8 = sext i32 %.011 to i64
  %9 = getelementptr inbounds i32, ptr %0, i64 %8
  store i32 %7, ptr %9, align 4
  br label %10

10:                                               ; preds = %4
  %11 = add nsw i32 %.011, 1
  %12 = icmp slt i32 %11, 128
  br i1 %12, label %4, label %13, !llvm.loop !9

13:                                               ; preds = %10
  br label %14

14:                                               ; preds = %13, %21
  %.02 = phi i32 [ 0, %13 ], [ %22, %21 ]
  %15 = sext i32 %.02 to i64
  %16 = getelementptr inbounds i32, ptr %0, i64 %15
  %17 = load i32, ptr %16, align 4
  %18 = add nsw i32 %17, 7
  %19 = sext i32 %.02 to i64
  %20 = getelementptr inbounds i32, ptr %2, i64 %19
  store i32 %18, ptr %20, align 4
  br label %21

21:                                               ; preds = %14
  %22 = add nsw i32 %.02, 1
  %23 = icmp slt i32 %22, 128
  br i1 %23, label %14, label %24, !llvm.loop !10

24:                                               ; preds = %21
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @dirty_preheader(ptr noundef %0, ptr noundef %1, ptr noundef %2, i32 noundef %3) #0 {
  %5 = icmp slt i32 0, %3
  br i1 %5, label %.lr.ph, label %15

.lr.ph:                                           ; preds = %4
  br label %6

6:                                                ; preds = %.lr.ph, %12
  %.011 = phi i32 [ 0, %.lr.ph ], [ %13, %12 ]
  %7 = sext i32 %.011 to i64
  %8 = getelementptr inbounds i32, ptr %1, i64 %7
  %9 = load i32, ptr %8, align 4
  %10 = sext i32 %.011 to i64
  %11 = getelementptr inbounds i32, ptr %0, i64 %10
  store i32 %9, ptr %11, align 4
  br label %12

12:                                               ; preds = %6
  %13 = add nsw i32 %.011, 1
  %14 = icmp slt i32 %13, %3
  br i1 %14, label %6, label %._crit_edge, !llvm.loop !11

._crit_edge:                                      ; preds = %12
  br label %15

15:                                               ; preds = %._crit_edge, %4
  %16 = mul nsw i32 %3, 2
  %17 = icmp slt i32 0, %3
  br i1 %17, label %.lr.ph4, label %28

.lr.ph4:                                          ; preds = %15
  br label %18

18:                                               ; preds = %.lr.ph4, %25
  %.02 = phi i32 [ 0, %.lr.ph4 ], [ %26, %25 ]
  %19 = sext i32 %.02 to i64
  %20 = getelementptr inbounds i32, ptr %0, i64 %19
  %21 = load i32, ptr %20, align 4
  %22 = add nsw i32 %21, %16
  %23 = sext i32 %.02 to i64
  %24 = getelementptr inbounds i32, ptr %2, i64 %23
  store i32 %22, ptr %24, align 4
  br label %25

25:                                               ; preds = %18
  %26 = add nsw i32 %.02, 1
  %27 = icmp slt i32 %26, %3
  br i1 %27, label %18, label %._crit_edge5, !llvm.loop !12

._crit_edge5:                                     ; preds = %25
  br label %28

28:                                               ; preds = %._crit_edge5, %15
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @guarded_same_guard(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = icmp sgt i32 %2, 0
  br i1 %4, label %5, label %29

5:                                                ; preds = %3
  br label %6

6:                                                ; preds = %5, %13
  %.011 = phi i32 [ 0, %5 ], [ %14, %13 ]
  %7 = sext i32 %.011 to i64
  %8 = getelementptr inbounds i32, ptr %1, i64 %7
  %9 = load i32, ptr %8, align 4
  %10 = add nsw i32 %9, 1
  %11 = sext i32 %.011 to i64
  %12 = getelementptr inbounds i32, ptr %0, i64 %11
  store i32 %10, ptr %12, align 4
  br label %13

13:                                               ; preds = %6
  %14 = add nsw i32 %.011, 1
  %15 = icmp slt i32 %14, %2
  br i1 %15, label %6, label %16, !llvm.loop !13

16:                                               ; preds = %13
  %17 = icmp slt i32 0, %2
  br i1 %17, label %.lr.ph, label %28

.lr.ph:                                           ; preds = %16
  br label %18

18:                                               ; preds = %.lr.ph, %25
  %.02 = phi i32 [ 0, %.lr.ph ], [ %26, %25 ]
  %19 = sext i32 %.02 to i64
  %20 = getelementptr inbounds i32, ptr %0, i64 %19
  %21 = load i32, ptr %20, align 4
  %22 = mul nsw i32 %21, 2
  %23 = sext i32 %.02 to i64
  %24 = getelementptr inbounds i32, ptr %1, i64 %23
  store i32 %22, ptr %24, align 4
  br label %25

25:                                               ; preds = %18
  %26 = add nsw i32 %.02, 1
  %27 = icmp slt i32 %26, %2
  br i1 %27, label %18, label %._crit_edge, !llvm.loop !14

._crit_edge:                                      ; preds = %25
  br label %28

28:                                               ; preds = %._crit_edge, %16
  br label %29

29:                                               ; preds = %28, %3
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @guarded_different_guards(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = icmp sgt i32 %2, 0
  br i1 %4, label %5, label %16

5:                                                ; preds = %3
  br label %6

6:                                                ; preds = %5, %12
  %.011 = phi i32 [ 0, %5 ], [ %13, %12 ]
  %7 = sext i32 %.011 to i64
  %8 = getelementptr inbounds i32, ptr %1, i64 %7
  %9 = load i32, ptr %8, align 4
  %10 = sext i32 %.011 to i64
  %11 = getelementptr inbounds i32, ptr %0, i64 %10
  store i32 %9, ptr %11, align 4
  br label %12

12:                                               ; preds = %6
  %13 = add nsw i32 %.011, 1
  %14 = icmp slt i32 %13, %2
  br i1 %14, label %6, label %15, !llvm.loop !15

15:                                               ; preds = %12
  br label %16

16:                                               ; preds = %15, %3
  %17 = icmp sgt i32 %2, 1
  br i1 %17, label %18, label %29

18:                                               ; preds = %16
  br label %19

19:                                               ; preds = %18, %25
  %.02 = phi i32 [ 0, %18 ], [ %26, %25 ]
  %20 = sext i32 %.02 to i64
  %21 = getelementptr inbounds i32, ptr %0, i64 %20
  %22 = load i32, ptr %21, align 4
  %23 = sext i32 %.02 to i64
  %24 = getelementptr inbounds i32, ptr %1, i64 %23
  store i32 %22, ptr %24, align 4
  br label %25

25:                                               ; preds = %19
  %26 = add nsw i32 %.02, 1
  %27 = icmp slt i32 %26, %2
  br i1 %27, label %19, label %28, !llvm.loop !16

28:                                               ; preds = %25
  br label %29

29:                                               ; preds = %28, %16
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @guarded_dirty_guard(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = mul nsw i32 %2, 4
  %5 = icmp sgt i32 %4, 0
  br i1 %5, label %6, label %29

6:                                                ; preds = %3
  %7 = icmp slt i32 0, %2
  br i1 %7, label %.lr.ph, label %17

.lr.ph:                                           ; preds = %6
  br label %8

8:                                                ; preds = %.lr.ph, %14
  %.011 = phi i32 [ 0, %.lr.ph ], [ %15, %14 ]
  %9 = sext i32 %.011 to i64
  %10 = getelementptr inbounds i32, ptr %1, i64 %9
  %11 = load i32, ptr %10, align 4
  %12 = sext i32 %.011 to i64
  %13 = getelementptr inbounds i32, ptr %0, i64 %12
  store i32 %11, ptr %13, align 4
  br label %14

14:                                               ; preds = %8
  %15 = add nsw i32 %.011, 1
  %16 = icmp slt i32 %15, %2
  br i1 %16, label %8, label %._crit_edge, !llvm.loop !17

._crit_edge:                                      ; preds = %14
  br label %17

17:                                               ; preds = %._crit_edge, %6
  %18 = icmp slt i32 0, %2
  br i1 %18, label %.lr.ph4, label %28

.lr.ph4:                                          ; preds = %17
  br label %19

19:                                               ; preds = %.lr.ph4, %25
  %.02 = phi i32 [ 0, %.lr.ph4 ], [ %26, %25 ]
  %20 = sext i32 %.02 to i64
  %21 = getelementptr inbounds i32, ptr %0, i64 %20
  %22 = load i32, ptr %21, align 4
  %23 = sext i32 %.02 to i64
  %24 = getelementptr inbounds i32, ptr %1, i64 %23
  store i32 %22, ptr %24, align 4
  br label %25

25:                                               ; preds = %19
  %26 = add nsw i32 %.02, 1
  %27 = icmp slt i32 %26, %2
  br i1 %27, label %19, label %._crit_edge5, !llvm.loop !18

._crit_edge5:                                     ; preds = %25
  br label %28

28:                                               ; preds = %._crit_edge5, %17
  br label %29

29:                                               ; preds = %28, %3
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @guarded_intermediate_block(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = icmp sgt i32 %2, 0
  br i1 %4, label %5, label %16

5:                                                ; preds = %3
  br label %6

6:                                                ; preds = %5, %12
  %.011 = phi i32 [ 0, %5 ], [ %13, %12 ]
  %7 = sext i32 %.011 to i64
  %8 = getelementptr inbounds i32, ptr %1, i64 %7
  %9 = load i32, ptr %8, align 4
  %10 = sext i32 %.011 to i64
  %11 = getelementptr inbounds i32, ptr %0, i64 %10
  store i32 %9, ptr %11, align 4
  br label %12

12:                                               ; preds = %6
  %13 = add nsw i32 %.011, 1
  %14 = icmp slt i32 %13, %2
  br i1 %14, label %6, label %15, !llvm.loop !19

15:                                               ; preds = %12
  br label %16

16:                                               ; preds = %15, %3
  %17 = icmp sgt i32 %2, 0
  br i1 %17, label %18, label %30

18:                                               ; preds = %16
  br label %19

19:                                               ; preds = %18, %26
  %.02 = phi i32 [ 0, %18 ], [ %27, %26 ]
  %20 = sext i32 %.02 to i64
  %21 = getelementptr inbounds i32, ptr %0, i64 %20
  %22 = load i32, ptr %21, align 4
  %23 = add nsw i32 %22, 42
  %24 = sext i32 %.02 to i64
  %25 = getelementptr inbounds i32, ptr %1, i64 %24
  store i32 %23, ptr %25, align 4
  br label %26

26:                                               ; preds = %19
  %27 = add nsw i32 %.02, 1
  %28 = icmp slt i32 %27, %2
  br i1 %28, label %19, label %29, !llvm.loop !20

29:                                               ; preds = %26
  br label %30

30:                                               ; preds = %29, %16
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @nested_siblings(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  br label %4

4:                                                ; preds = %3, %25
  %.024 = phi i32 [ 0, %3 ], [ %26, %25 ]
  br label %5

5:                                                ; preds = %4, %11
  %.011 = phi i32 [ 0, %4 ], [ %12, %11 ]
  %6 = sext i32 %.011 to i64
  %7 = getelementptr inbounds i32, ptr %1, i64 %6
  %8 = load i32, ptr %7, align 4
  %9 = sext i32 %.011 to i64
  %10 = getelementptr inbounds i32, ptr %0, i64 %9
  store i32 %8, ptr %10, align 4
  br label %11

11:                                               ; preds = %5
  %12 = add nsw i32 %.011, 1
  %13 = icmp slt i32 %12, 128
  br i1 %13, label %5, label %14, !llvm.loop !21

14:                                               ; preds = %11
  br label %15

15:                                               ; preds = %14, %21
  %.03 = phi i32 [ 0, %14 ], [ %22, %21 ]
  %16 = sext i32 %.03 to i64
  %17 = getelementptr inbounds i32, ptr %0, i64 %16
  %18 = load i32, ptr %17, align 4
  %19 = sext i32 %.03 to i64
  %20 = getelementptr inbounds i32, ptr %2, i64 %19
  store i32 %18, ptr %20, align 4
  br label %21

21:                                               ; preds = %15
  %22 = add nsw i32 %.03, 1
  %23 = icmp slt i32 %22, 128
  br i1 %23, label %15, label %24, !llvm.loop !22

24:                                               ; preds = %21
  br label %25

25:                                               ; preds = %24
  %26 = add nsw i32 %.024, 1
  %27 = icmp slt i32 %26, 10
  br i1 %27, label %4, label %28, !llvm.loop !23

28:                                               ; preds = %25
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @nested_non_siblings(ptr noundef %0, ptr noundef %1) #0 {
  br label %3

3:                                                ; preds = %2, %14
  %.022 = phi i32 [ 0, %2 ], [ %15, %14 ]
  br label %4

4:                                                ; preds = %3, %10
  %.011 = phi i32 [ 0, %3 ], [ %11, %10 ]
  %5 = sext i32 %.011 to i64
  %6 = getelementptr inbounds i32, ptr %1, i64 %5
  %7 = load i32, ptr %6, align 4
  %8 = sext i32 %.011 to i64
  %9 = getelementptr inbounds i32, ptr %0, i64 %8
  store i32 %7, ptr %9, align 4
  br label %10

10:                                               ; preds = %4
  %11 = add nsw i32 %.011, 1
  %12 = icmp slt i32 %11, 128
  br i1 %12, label %4, label %13, !llvm.loop !24

13:                                               ; preds = %10
  br label %14

14:                                               ; preds = %13
  %15 = add nsw i32 %.022, 1
  %16 = icmp slt i32 %15, 128
  br i1 %16, label %3, label %17, !llvm.loop !25

17:                                               ; preds = %14
  br label %18

18:                                               ; preds = %17, %24
  %.03 = phi i32 [ 0, %17 ], [ %25, %24 ]
  %19 = sext i32 %.03 to i64
  %20 = getelementptr inbounds i32, ptr %0, i64 %19
  %21 = load i32, ptr %20, align 4
  %22 = sext i32 %.03 to i64
  %23 = getelementptr inbounds i32, ptr %1, i64 %22
  store i32 %21, ptr %23, align 4
  br label %24

24:                                               ; preds = %18
  %25 = add nsw i32 %.03, 1
  %26 = icmp slt i32 %25, 128
  br i1 %26, label %18, label %27, !llvm.loop !26

27:                                               ; preds = %24
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @multiple_exit_loop(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = icmp slt i32 0, %2
  br i1 %4, label %.lr.ph, label %.loopexit

.lr.ph:                                           ; preds = %3
  br label %5

5:                                                ; preds = %.lr.ph, %14
  %.011 = phi i32 [ 0, %.lr.ph ], [ %15, %14 ]
  %6 = icmp eq i32 %.011, 10
  br i1 %6, label %7, label %8

7:                                                ; preds = %5
  br label %17

8:                                                ; preds = %5
  %9 = sext i32 %.011 to i64
  %10 = getelementptr inbounds i32, ptr %1, i64 %9
  %11 = load i32, ptr %10, align 4
  %12 = sext i32 %.011 to i64
  %13 = getelementptr inbounds i32, ptr %0, i64 %12
  store i32 %11, ptr %13, align 4
  br label %14

14:                                               ; preds = %8
  %15 = add nsw i32 %.011, 1
  %16 = icmp slt i32 %15, %2
  br i1 %16, label %5, label %..loopexit_crit_edge, !llvm.loop !27

..loopexit_crit_edge:                             ; preds = %14
  br label %.loopexit

.loopexit:                                        ; preds = %..loopexit_crit_edge, %3
  br label %17

17:                                               ; preds = %.loopexit, %7
  %18 = icmp slt i32 0, %2
  br i1 %18, label %.lr.ph3, label %28

.lr.ph3:                                          ; preds = %17
  br label %19

19:                                               ; preds = %.lr.ph3, %25
  %.02 = phi i32 [ 0, %.lr.ph3 ], [ %26, %25 ]
  %20 = sext i32 %.02 to i64
  %21 = getelementptr inbounds i32, ptr %0, i64 %20
  %22 = load i32, ptr %21, align 4
  %23 = sext i32 %.02 to i64
  %24 = getelementptr inbounds i32, ptr %1, i64 %23
  store i32 %22, ptr %24, align 4
  br label %25

25:                                               ; preds = %19
  %26 = add nsw i32 %.02, 1
  %27 = icmp slt i32 %26, %2
  br i1 %27, label %19, label %._crit_edge, !llvm.loop !28

._crit_edge:                                      ; preds = %25
  br label %28

28:                                               ; preds = %._crit_edge, %17
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @dependent_loops(ptr noundef %0, ptr noundef %1) #0 {
  br label %3

3:                                                ; preds = %2, %6
  %.011 = phi i32 [ 0, %2 ], [ %7, %6 ]
  %4 = sext i32 %.011 to i64
  %5 = getelementptr inbounds i32, ptr %0, i64 %4
  store i32 %.011, ptr %5, align 4
  br label %6

6:                                                ; preds = %3
  %7 = add nsw i32 %.011, 1
  %8 = icmp slt i32 %7, 128
  br i1 %8, label %3, label %9, !llvm.loop !29

9:                                                ; preds = %6
  br label %10

10:                                               ; preds = %9, %16
  %.02 = phi i32 [ 0, %9 ], [ %17, %16 ]
  %11 = sext i32 %.02 to i64
  %12 = getelementptr inbounds i32, ptr %0, i64 %11
  %13 = load i32, ptr %12, align 4
  %14 = sext i32 %.02 to i64
  %15 = getelementptr inbounds i32, ptr %1, i64 %14
  store i32 %13, ptr %15, align 4
  br label %16

16:                                               ; preds = %10
  %17 = add nsw i32 %.02, 1
  %18 = icmp slt i32 %17, 128
  br i1 %18, label %10, label %19, !llvm.loop !30

19:                                               ; preds = %16
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @perfectly_fusible(ptr noundef %0, ptr noundef %1, ptr noundef %2, i32 noundef %3) #0 {
  %5 = icmp sgt i32 %3, 0
  br i1 %5, label %6, label %30

6:                                                ; preds = %4
  br label %7

7:                                                ; preds = %6, %14
  %.011 = phi i32 [ 0, %6 ], [ %15, %14 ]
  %8 = sext i32 %.011 to i64
  %9 = getelementptr inbounds i32, ptr %1, i64 %8
  %10 = load i32, ptr %9, align 4
  %11 = add nsw i32 %10, 1
  %12 = sext i32 %.011 to i64
  %13 = getelementptr inbounds i32, ptr %0, i64 %12
  store i32 %11, ptr %13, align 4
  br label %14

14:                                               ; preds = %7
  %15 = add nsw i32 %.011, 1
  %16 = icmp slt i32 %15, %3
  br i1 %16, label %7, label %17, !llvm.loop !31

17:                                               ; preds = %14
  %18 = icmp slt i32 0, %3
  br i1 %18, label %.lr.ph, label %29

.lr.ph:                                           ; preds = %17
  br label %19

19:                                               ; preds = %.lr.ph, %26
  %.02 = phi i32 [ 0, %.lr.ph ], [ %27, %26 ]
  %20 = sext i32 %.02 to i64
  %21 = getelementptr inbounds i32, ptr %0, i64 %20
  %22 = load i32, ptr %21, align 4
  %23 = mul nsw i32 %22, 3
  %24 = sext i32 %.02 to i64
  %25 = getelementptr inbounds i32, ptr %2, i64 %24
  store i32 %23, ptr %25, align 4
  br label %26

26:                                               ; preds = %19
  %27 = add nsw i32 %.02, 1
  %28 = icmp slt i32 %27, %3
  br i1 %28, label %19, label %._crit_edge, !llvm.loop !32

._crit_edge:                                      ; preds = %26
  br label %29

29:                                               ; preds = %._crit_edge, %17
  br label %30

30:                                               ; preds = %29, %4
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
