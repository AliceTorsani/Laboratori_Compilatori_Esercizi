; ModuleID = 'Test_adiacenza2.m2r.ll'
source_filename = "Test_adiacenza2.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @adjacent_plain(ptr noundef %0, ptr noundef %1, ptr noundef %2, i32 noundef %3) #0 {
  %5 = icmp slt i32 0, %3
  br i1 %5, label %.lr.ph, label %16

.lr.ph:                                           ; preds = %4
  br label %6

6:                                                ; preds = %.lr.ph, %13
  %.011 = phi i32 [ 0, %.lr.ph ], [ %14, %13 ]
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
  %22 = mul nsw i32 %21, 2
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
  br i1 %14, label %6, label %._crit_edge, !llvm.loop !9

._crit_edge:                                      ; preds = %12
  br label %15

15:                                               ; preds = %._crit_edge, %4
  %16 = mul nsw i32 %3, 2
  %17 = getelementptr inbounds i32, ptr %1, i64 0
  store i32 3, ptr %17, align 4
  %18 = icmp slt i32 0, %3
  br i1 %18, label %.lr.ph4, label %29

.lr.ph4:                                          ; preds = %15
  br label %19

19:                                               ; preds = %.lr.ph4, %26
  %.02 = phi i32 [ 0, %.lr.ph4 ], [ %27, %26 ]
  %20 = sext i32 %.02 to i64
  %21 = getelementptr inbounds i32, ptr %0, i64 %20
  %22 = load i32, ptr %21, align 4
  %23 = add nsw i32 %22, %16
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

29:                                               ; preds = %._crit_edge5, %15
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @guarded_same_guard(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = icmp slt i32 %2, 0
  br i1 %4, label %5, label %29

5:                                                ; preds = %3
  br i1 false, label %.lr.ph, label %16

.lr.ph:                                           ; preds = %5
  br label %6

6:                                                ; preds = %.lr.ph, %13
  %.011 = phi i32 [ 0, %.lr.ph ], [ %14, %13 ]
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
  br i1 %15, label %6, label %._crit_edge, !llvm.loop !11

._crit_edge:                                      ; preds = %13
  br label %16

16:                                               ; preds = %._crit_edge, %5
  %17 = icmp slt i32 0, %2
  br i1 %17, label %.lr.ph4, label %28

.lr.ph4:                                          ; preds = %16
  br label %18

18:                                               ; preds = %.lr.ph4, %25
  %.02 = phi i32 [ 0, %.lr.ph4 ], [ %26, %25 ]
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
  br i1 %27, label %18, label %._crit_edge5, !llvm.loop !12

._crit_edge5:                                     ; preds = %25
  br label %28

28:                                               ; preds = %._crit_edge5, %16
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
  br i1 %14, label %6, label %15, !llvm.loop !13

15:                                               ; preds = %12
  br label %16

16:                                               ; preds = %15, %3
  %17 = icmp slt i32 %2, 0
  br i1 %17, label %18, label %30

18:                                               ; preds = %16
  br i1 false, label %.lr.ph, label %29

.lr.ph:                                           ; preds = %18
  br label %19

19:                                               ; preds = %.lr.ph, %26
  %.02 = phi i32 [ 0, %.lr.ph ], [ %27, %26 ]
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
  br i1 %28, label %19, label %._crit_edge, !llvm.loop !14

._crit_edge:                                      ; preds = %26
  br label %29

29:                                               ; preds = %._crit_edge, %18
  br label %30

30:                                               ; preds = %29, %16
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @do_while_then_guarded(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  br label %4

4:                                                ; preds = %12, %3
  %.01 = phi i32 [ 0, %3 ], [ %11, %12 ]
  %5 = sext i32 %.01 to i64
  %6 = getelementptr inbounds i32, ptr %1, i64 %5
  %7 = load i32, ptr %6, align 4
  %8 = add nsw i32 %7, 1
  %9 = sext i32 %.01 to i64
  %10 = getelementptr inbounds i32, ptr %0, i64 %9
  store i32 %8, ptr %10, align 4
  %11 = add nsw i32 %.01, 1
  br label %12

12:                                               ; preds = %4
  %13 = icmp slt i32 %11, %2
  br i1 %13, label %4, label %14, !llvm.loop !15

14:                                               ; preds = %12
  %15 = icmp sgt i32 %2, 0
  br i1 %15, label %16, label %28

16:                                               ; preds = %14
  br label %17

17:                                               ; preds = %16, %24
  %.02 = phi i32 [ 0, %16 ], [ %25, %24 ]
  %18 = sext i32 %.02 to i64
  %19 = getelementptr inbounds i32, ptr %0, i64 %18
  %20 = load i32, ptr %19, align 4
  %21 = mul nsw i32 %20, 2
  %22 = sext i32 %.02 to i64
  %23 = getelementptr inbounds i32, ptr %1, i64 %22
  store i32 %21, ptr %23, align 4
  br label %24

24:                                               ; preds = %17
  %25 = add nsw i32 %.02, 1
  %26 = icmp slt i32 %25, %2
  br i1 %26, label %17, label %27, !llvm.loop !16

27:                                               ; preds = %24
  br label %28

28:                                               ; preds = %27, %14
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @do_while_then_do_while(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  br label %4

4:                                                ; preds = %11, %3
  %.01 = phi i32 [ 0, %3 ], [ %10, %11 ]
  %5 = sext i32 %.01 to i64
  %6 = getelementptr inbounds i32, ptr %1, i64 %5
  %7 = load i32, ptr %6, align 4
  %8 = sext i32 %.01 to i64
  %9 = getelementptr inbounds i32, ptr %0, i64 %8
  store i32 %7, ptr %9, align 4
  %10 = add nsw i32 %.01, 1
  br label %11

11:                                               ; preds = %4
  %12 = icmp slt i32 %10, %2
  br i1 %12, label %4, label %13, !llvm.loop !17

13:                                               ; preds = %11
  br label %14

14:                                               ; preds = %22, %13
  %.0 = phi i32 [ 0, %13 ], [ %21, %22 ]
  %15 = sext i32 %.0 to i64
  %16 = getelementptr inbounds i32, ptr %0, i64 %15
  %17 = load i32, ptr %16, align 4
  %18 = add nsw i32 %17, 10
  %19 = sext i32 %.0 to i64
  %20 = getelementptr inbounds i32, ptr %1, i64 %19
  store i32 %18, ptr %20, align 4
  %21 = add nsw i32 %.0, 1
  br label %22

22:                                               ; preds = %14
  %23 = icmp slt i32 %21, %2
  br i1 %23, label %14, label %24, !llvm.loop !18

24:                                               ; preds = %22
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @guarded_do_while_then_plain_do_while(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = icmp sgt i32 %2, 0
  br i1 %4, label %5, label %17

5:                                                ; preds = %3
  br label %6

6:                                                ; preds = %14, %5
  %.01 = phi i32 [ 0, %5 ], [ %13, %14 ]
  %7 = sext i32 %.01 to i64
  %8 = getelementptr inbounds i32, ptr %1, i64 %7
  %9 = load i32, ptr %8, align 4
  %10 = add nsw i32 %9, 1
  %11 = sext i32 %.01 to i64
  %12 = getelementptr inbounds i32, ptr %0, i64 %11
  store i32 %10, ptr %12, align 4
  %13 = add nsw i32 %.01, 1
  br label %14

14:                                               ; preds = %6
  %15 = icmp slt i32 %13, %2
  br i1 %15, label %6, label %16, !llvm.loop !19

16:                                               ; preds = %14
  br label %17

17:                                               ; preds = %16, %3
  br label %18

18:                                               ; preds = %26, %17
  %.0 = phi i32 [ 0, %17 ], [ %25, %26 ]
  %19 = sext i32 %.0 to i64
  %20 = getelementptr inbounds i32, ptr %0, i64 %19
  %21 = load i32, ptr %20, align 4
  %22 = mul nsw i32 %21, 3
  %23 = sext i32 %.0 to i64
  %24 = getelementptr inbounds i32, ptr %1, i64 %23
  store i32 %22, ptr %24, align 4
  %25 = add nsw i32 %.0, 1
  br label %26

26:                                               ; preds = %18
  %27 = icmp slt i32 %25, %2
  br i1 %27, label %18, label %28, !llvm.loop !20

28:                                               ; preds = %26
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @two_guarded_do_whiles_same_guard(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = icmp sgt i32 %2, 0
  br i1 %4, label %5, label %27

5:                                                ; preds = %3
  br label %6

6:                                                ; preds = %13, %5
  %.01 = phi i32 [ 0, %5 ], [ %12, %13 ]
  %7 = sext i32 %.01 to i64
  %8 = getelementptr inbounds i32, ptr %1, i64 %7
  %9 = load i32, ptr %8, align 4
  %10 = sext i32 %.01 to i64
  %11 = getelementptr inbounds i32, ptr %0, i64 %10
  store i32 %9, ptr %11, align 4
  %12 = add nsw i32 %.01, 1
  br label %13

13:                                               ; preds = %6
  %14 = icmp slt i32 %12, %2
  br i1 %14, label %6, label %15, !llvm.loop !21

15:                                               ; preds = %13
  br label %16

16:                                               ; preds = %24, %15
  %.0 = phi i32 [ 0, %15 ], [ %23, %24 ]
  %17 = sext i32 %.0 to i64
  %18 = getelementptr inbounds i32, ptr %0, i64 %17
  %19 = load i32, ptr %18, align 4
  %20 = add nsw i32 %19, 5
  %21 = sext i32 %.0 to i64
  %22 = getelementptr inbounds i32, ptr %1, i64 %21
  store i32 %20, ptr %22, align 4
  %23 = add nsw i32 %.0, 1
  br label %24

24:                                               ; preds = %16
  %25 = icmp slt i32 %23, %2
  br i1 %25, label %16, label %26, !llvm.loop !22

26:                                               ; preds = %24
  br label %27

27:                                               ; preds = %26, %3
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @two_guarded_do_whiles_different_guard(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = icmp sgt i32 %2, 0
  br i1 %4, label %5, label %16

5:                                                ; preds = %3
  br label %6

6:                                                ; preds = %13, %5
  %.01 = phi i32 [ 0, %5 ], [ %12, %13 ]
  %7 = sext i32 %.01 to i64
  %8 = getelementptr inbounds i32, ptr %1, i64 %7
  %9 = load i32, ptr %8, align 4
  %10 = sext i32 %.01 to i64
  %11 = getelementptr inbounds i32, ptr %0, i64 %10
  store i32 %9, ptr %11, align 4
  %12 = add nsw i32 %.01, 1
  br label %13

13:                                               ; preds = %6
  %14 = icmp slt i32 %12, %2
  br i1 %14, label %6, label %15, !llvm.loop !23

15:                                               ; preds = %13
  br label %16

16:                                               ; preds = %15, %3
  %17 = icmp sgt i32 %2, 1
  br i1 %17, label %18, label %29

18:                                               ; preds = %16
  br label %19

19:                                               ; preds = %26, %18
  %.0 = phi i32 [ 0, %18 ], [ %25, %26 ]
  %20 = sext i32 %.0 to i64
  %21 = getelementptr inbounds i32, ptr %0, i64 %20
  %22 = load i32, ptr %21, align 4
  %23 = sext i32 %.0 to i64
  %24 = getelementptr inbounds i32, ptr %1, i64 %23
  store i32 %22, ptr %24, align 4
  %25 = add nsw i32 %.0, 1
  br label %26

26:                                               ; preds = %19
  %27 = icmp slt i32 %25, %2
  br i1 %27, label %19, label %28, !llvm.loop !24

28:                                               ; preds = %26
  br label %29

29:                                               ; preds = %28, %16
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @two_guarded_do_whiles_same2_guard(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = icmp sgt i32 %2, 0
  br i1 %4, label %5, label %16

5:                                                ; preds = %3
  br label %6

6:                                                ; preds = %13, %5
  %.01 = phi i32 [ 0, %5 ], [ %12, %13 ]
  %7 = sext i32 %.01 to i64
  %8 = getelementptr inbounds i32, ptr %1, i64 %7
  %9 = load i32, ptr %8, align 4
  %10 = sext i32 %.01 to i64
  %11 = getelementptr inbounds i32, ptr %0, i64 %10
  store i32 %9, ptr %11, align 4
  %12 = add nsw i32 %.01, 1
  br label %13

13:                                               ; preds = %6
  %14 = icmp slt i32 %12, %2
  br i1 %14, label %6, label %15, !llvm.loop !25

15:                                               ; preds = %13
  br label %16

16:                                               ; preds = %15, %3
  %17 = icmp sgt i32 %2, 0
  br i1 %17, label %18, label %29

18:                                               ; preds = %16
  br label %19

19:                                               ; preds = %26, %18
  %.0 = phi i32 [ 0, %18 ], [ %25, %26 ]
  %20 = sext i32 %.0 to i64
  %21 = getelementptr inbounds i32, ptr %0, i64 %20
  %22 = load i32, ptr %21, align 4
  %23 = sext i32 %.0 to i64
  %24 = getelementptr inbounds i32, ptr %1, i64 %23
  store i32 %22, ptr %24, align 4
  %25 = add nsw i32 %.0, 1
  br label %26

26:                                               ; preds = %19
  %27 = icmp slt i32 %25, %2
  br i1 %27, label %19, label %28, !llvm.loop !26

28:                                               ; preds = %26
  br label %29

29:                                               ; preds = %28, %16
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
  call void @adjacent_plain(ptr noundef %4, ptr noundef %5, ptr noundef %6, i32 noundef 128)
  %7 = getelementptr inbounds [128 x i32], ptr %1, i64 0, i64 0
  %8 = getelementptr inbounds [128 x i32], ptr %2, i64 0, i64 0
  %9 = getelementptr inbounds [128 x i32], ptr %3, i64 0, i64 0
  call void @dirty_preheader(ptr noundef %7, ptr noundef %8, ptr noundef %9, i32 noundef 128)
  %10 = getelementptr inbounds [128 x i32], ptr %1, i64 0, i64 0
  %11 = getelementptr inbounds [128 x i32], ptr %2, i64 0, i64 0
  call void @guarded_same_guard(ptr noundef %10, ptr noundef %11, i32 noundef 128)
  %12 = getelementptr inbounds [128 x i32], ptr %1, i64 0, i64 0
  %13 = getelementptr inbounds [128 x i32], ptr %2, i64 0, i64 0
  call void @guarded_intermediate_block(ptr noundef %12, ptr noundef %13, i32 noundef 128)
  %14 = getelementptr inbounds [128 x i32], ptr %1, i64 0, i64 0
  %15 = getelementptr inbounds [128 x i32], ptr %2, i64 0, i64 0
  call void @do_while_then_guarded(ptr noundef %14, ptr noundef %15, i32 noundef 128)
  %16 = getelementptr inbounds [128 x i32], ptr %1, i64 0, i64 0
  %17 = getelementptr inbounds [128 x i32], ptr %2, i64 0, i64 0
  call void @do_while_then_do_while(ptr noundef %16, ptr noundef %17, i32 noundef 128)
  %18 = getelementptr inbounds [128 x i32], ptr %1, i64 0, i64 0
  %19 = getelementptr inbounds [128 x i32], ptr %2, i64 0, i64 0
  call void @guarded_do_while_then_plain_do_while(ptr noundef %18, ptr noundef %19, i32 noundef 128)
  %20 = getelementptr inbounds [128 x i32], ptr %1, i64 0, i64 0
  %21 = getelementptr inbounds [128 x i32], ptr %2, i64 0, i64 0
  call void @two_guarded_do_whiles_same_guard(ptr noundef %20, ptr noundef %21, i32 noundef 128)
  %22 = getelementptr inbounds [128 x i32], ptr %1, i64 0, i64 0
  %23 = getelementptr inbounds [128 x i32], ptr %2, i64 0, i64 0
  call void @two_guarded_do_whiles_different_guard(ptr noundef %22, ptr noundef %23, i32 noundef 128)
  %24 = getelementptr inbounds [128 x i32], ptr %1, i64 0, i64 0
  %25 = getelementptr inbounds [128 x i32], ptr %2, i64 0, i64 0
  call void @two_guarded_do_whiles_same2_guard(ptr noundef %24, ptr noundef %25, i32 noundef 128)
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
