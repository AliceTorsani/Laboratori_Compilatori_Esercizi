; ModuleID = 'Test_control_flow_eq.c'
source_filename = "Test_control_flow_eq.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @cfe_positive_always(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store i32 %2, ptr %6, align 4
  store i32 0, ptr %7, align 4
  br label %9

9:                                                ; preds = %19, %3
  %10 = load i32, ptr %7, align 4
  %11 = load i32, ptr %6, align 4
  %12 = icmp slt i32 %10, %11
  br i1 %12, label %13, label %22

13:                                               ; preds = %9
  %14 = load i32, ptr %7, align 4
  %15 = load ptr, ptr %4, align 8
  %16 = load i32, ptr %7, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds i32, ptr %15, i64 %17
  store i32 %14, ptr %18, align 4
  br label %19

19:                                               ; preds = %13
  %20 = load i32, ptr %7, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %7, align 4
  br label %9, !llvm.loop !6

22:                                               ; preds = %9
  store i32 0, ptr %8, align 4
  br label %23

23:                                               ; preds = %37, %22
  %24 = load i32, ptr %8, align 4
  %25 = load i32, ptr %6, align 4
  %26 = icmp slt i32 %24, %25
  br i1 %26, label %27, label %40

27:                                               ; preds = %23
  %28 = load ptr, ptr %4, align 8
  %29 = load i32, ptr %8, align 4
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds i32, ptr %28, i64 %30
  %32 = load i32, ptr %31, align 4
  %33 = load ptr, ptr %5, align 8
  %34 = load i32, ptr %8, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds i32, ptr %33, i64 %35
  store i32 %32, ptr %36, align 4
  br label %37

37:                                               ; preds = %27
  %38 = load i32, ptr %8, align 4
  %39 = add nsw i32 %38, 1
  store i32 %39, ptr %8, align 4
  br label %23, !llvm.loop !8

40:                                               ; preds = %23
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @cfe_positive_same_guard(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store i32 %2, ptr %6, align 4
  %9 = load i32, ptr %6, align 4
  %10 = icmp sgt i32 %9, 0
  br i1 %10, label %11, label %44

11:                                               ; preds = %3
  store i32 0, ptr %7, align 4
  br label %12

12:                                               ; preds = %22, %11
  %13 = load i32, ptr %7, align 4
  %14 = load i32, ptr %6, align 4
  %15 = icmp slt i32 %13, %14
  br i1 %15, label %16, label %25

16:                                               ; preds = %12
  %17 = load i32, ptr %7, align 4
  %18 = load ptr, ptr %4, align 8
  %19 = load i32, ptr %7, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds i32, ptr %18, i64 %20
  store i32 %17, ptr %21, align 4
  br label %22

22:                                               ; preds = %16
  %23 = load i32, ptr %7, align 4
  %24 = add nsw i32 %23, 1
  store i32 %24, ptr %7, align 4
  br label %12, !llvm.loop !9

25:                                               ; preds = %12
  store i32 0, ptr %8, align 4
  br label %26

26:                                               ; preds = %40, %25
  %27 = load i32, ptr %8, align 4
  %28 = load i32, ptr %6, align 4
  %29 = icmp slt i32 %27, %28
  br i1 %29, label %30, label %43

30:                                               ; preds = %26
  %31 = load ptr, ptr %4, align 8
  %32 = load i32, ptr %8, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds i32, ptr %31, i64 %33
  %35 = load i32, ptr %34, align 4
  %36 = load ptr, ptr %5, align 8
  %37 = load i32, ptr %8, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds i32, ptr %36, i64 %38
  store i32 %35, ptr %39, align 4
  br label %40

40:                                               ; preds = %30
  %41 = load i32, ptr %8, align 4
  %42 = add nsw i32 %41, 1
  store i32 %42, ptr %8, align 4
  br label %26, !llvm.loop !10

43:                                               ; preds = %26
  br label %44

44:                                               ; preds = %43, %3
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @cfe_positive_do_while(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store i32 %2, ptr %6, align 4
  %9 = load i32, ptr %6, align 4
  %10 = icmp sgt i32 %9, 0
  br i1 %10, label %11, label %42

11:                                               ; preds = %3
  store i32 0, ptr %7, align 4
  br label %12

12:                                               ; preds = %20, %11
  %13 = load i32, ptr %7, align 4
  %14 = load ptr, ptr %4, align 8
  %15 = load i32, ptr %7, align 4
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds i32, ptr %14, i64 %16
  store i32 %13, ptr %17, align 4
  %18 = load i32, ptr %7, align 4
  %19 = add nsw i32 %18, 1
  store i32 %19, ptr %7, align 4
  br label %20

20:                                               ; preds = %12
  %21 = load i32, ptr %7, align 4
  %22 = load i32, ptr %6, align 4
  %23 = icmp slt i32 %21, %22
  br i1 %23, label %12, label %24, !llvm.loop !11

24:                                               ; preds = %20
  store i32 0, ptr %8, align 4
  br label %25

25:                                               ; preds = %37, %24
  %26 = load ptr, ptr %4, align 8
  %27 = load i32, ptr %8, align 4
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds i32, ptr %26, i64 %28
  %30 = load i32, ptr %29, align 4
  %31 = load ptr, ptr %5, align 8
  %32 = load i32, ptr %8, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds i32, ptr %31, i64 %33
  store i32 %30, ptr %34, align 4
  %35 = load i32, ptr %8, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, ptr %8, align 4
  br label %37

37:                                               ; preds = %25
  %38 = load i32, ptr %8, align 4
  %39 = load i32, ptr %6, align 4
  %40 = icmp slt i32 %38, %39
  br i1 %40, label %25, label %41, !llvm.loop !12

41:                                               ; preds = %37
  br label %42

42:                                               ; preds = %41, %3
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @cfe_negative_first_guarded(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store i32 %2, ptr %6, align 4
  %9 = load i32, ptr %6, align 4
  %10 = icmp sgt i32 %9, 0
  br i1 %10, label %11, label %26

11:                                               ; preds = %3
  store i32 0, ptr %7, align 4
  br label %12

12:                                               ; preds = %22, %11
  %13 = load i32, ptr %7, align 4
  %14 = load i32, ptr %6, align 4
  %15 = icmp slt i32 %13, %14
  br i1 %15, label %16, label %25

16:                                               ; preds = %12
  %17 = load i32, ptr %7, align 4
  %18 = load ptr, ptr %4, align 8
  %19 = load i32, ptr %7, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds i32, ptr %18, i64 %20
  store i32 %17, ptr %21, align 4
  br label %22

22:                                               ; preds = %16
  %23 = load i32, ptr %7, align 4
  %24 = add nsw i32 %23, 1
  store i32 %24, ptr %7, align 4
  br label %12, !llvm.loop !13

25:                                               ; preds = %12
  br label %26

26:                                               ; preds = %25, %3
  store i32 0, ptr %8, align 4
  br label %27

27:                                               ; preds = %41, %26
  %28 = load i32, ptr %8, align 4
  %29 = load i32, ptr %6, align 4
  %30 = icmp slt i32 %28, %29
  br i1 %30, label %31, label %44

31:                                               ; preds = %27
  %32 = load ptr, ptr %4, align 8
  %33 = load i32, ptr %8, align 4
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds i32, ptr %32, i64 %34
  %36 = load i32, ptr %35, align 4
  %37 = load ptr, ptr %5, align 8
  %38 = load i32, ptr %8, align 4
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds i32, ptr %37, i64 %39
  store i32 %36, ptr %40, align 4
  br label %41

41:                                               ; preds = %31
  %42 = load i32, ptr %8, align 4
  %43 = add nsw i32 %42, 1
  store i32 %43, ptr %8, align 4
  br label %27, !llvm.loop !14

44:                                               ; preds = %27
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @cfe_negative_different_guards(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store ptr %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  %11 = load i32, ptr %7, align 4
  %12 = icmp sgt i32 %11, 0
  br i1 %12, label %13, label %28

13:                                               ; preds = %4
  store i32 0, ptr %9, align 4
  br label %14

14:                                               ; preds = %24, %13
  %15 = load i32, ptr %9, align 4
  %16 = load i32, ptr %7, align 4
  %17 = icmp slt i32 %15, %16
  br i1 %17, label %18, label %27

18:                                               ; preds = %14
  %19 = load i32, ptr %9, align 4
  %20 = load ptr, ptr %5, align 8
  %21 = load i32, ptr %9, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds i32, ptr %20, i64 %22
  store i32 %19, ptr %23, align 4
  br label %24

24:                                               ; preds = %18
  %25 = load i32, ptr %9, align 4
  %26 = add nsw i32 %25, 1
  store i32 %26, ptr %9, align 4
  br label %14, !llvm.loop !15

27:                                               ; preds = %14
  br label %28

28:                                               ; preds = %27, %4
  %29 = load i32, ptr %8, align 4
  %30 = icmp sgt i32 %29, 0
  br i1 %30, label %31, label %46

31:                                               ; preds = %28
  store i32 0, ptr %10, align 4
  br label %32

32:                                               ; preds = %42, %31
  %33 = load i32, ptr %10, align 4
  %34 = load i32, ptr %8, align 4
  %35 = icmp slt i32 %33, %34
  br i1 %35, label %36, label %45

36:                                               ; preds = %32
  %37 = load i32, ptr %10, align 4
  %38 = load ptr, ptr %6, align 8
  %39 = load i32, ptr %10, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds i32, ptr %38, i64 %40
  store i32 %37, ptr %41, align 4
  br label %42

42:                                               ; preds = %36
  %43 = load i32, ptr %10, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, ptr %10, align 4
  br label %32, !llvm.loop !16

45:                                               ; preds = %32
  br label %46

46:                                               ; preds = %45, %28
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @cfe_negative_intermediate_if(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store i32 %2, ptr %6, align 4
  store i32 0, ptr %7, align 4
  br label %9

9:                                                ; preds = %19, %3
  %10 = load i32, ptr %7, align 4
  %11 = load i32, ptr %6, align 4
  %12 = icmp slt i32 %10, %11
  br i1 %12, label %13, label %22

13:                                               ; preds = %9
  %14 = load i32, ptr %7, align 4
  %15 = load ptr, ptr %4, align 8
  %16 = load i32, ptr %7, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds i32, ptr %15, i64 %17
  store i32 %14, ptr %18, align 4
  br label %19

19:                                               ; preds = %13
  %20 = load i32, ptr %7, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %7, align 4
  br label %9, !llvm.loop !17

22:                                               ; preds = %9
  %23 = load ptr, ptr %4, align 8
  %24 = getelementptr inbounds i32, ptr %23, i64 0
  %25 = load i32, ptr %24, align 4
  %26 = icmp slt i32 %25, 0
  br i1 %26, label %27, label %28

27:                                               ; preds = %22
  br label %46

28:                                               ; preds = %22
  store i32 0, ptr %8, align 4
  br label %29

29:                                               ; preds = %43, %28
  %30 = load i32, ptr %8, align 4
  %31 = load i32, ptr %6, align 4
  %32 = icmp slt i32 %30, %31
  br i1 %32, label %33, label %46

33:                                               ; preds = %29
  %34 = load ptr, ptr %4, align 8
  %35 = load i32, ptr %8, align 4
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds i32, ptr %34, i64 %36
  %38 = load i32, ptr %37, align 4
  %39 = load ptr, ptr %5, align 8
  %40 = load i32, ptr %8, align 4
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds i32, ptr %39, i64 %41
  store i32 %38, ptr %42, align 4
  br label %43

43:                                               ; preds = %33
  %44 = load i32, ptr %8, align 4
  %45 = add nsw i32 %44, 1
  store i32 %45, ptr %8, align 4
  br label %29, !llvm.loop !18

46:                                               ; preds = %27, %29
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @cfe_negative_break(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store i32 %2, ptr %6, align 4
  store i32 0, ptr %7, align 4
  br label %9

9:                                                ; preds = %19, %3
  %10 = load i32, ptr %7, align 4
  %11 = load i32, ptr %6, align 4
  %12 = icmp slt i32 %10, %11
  br i1 %12, label %13, label %22

13:                                               ; preds = %9
  %14 = load i32, ptr %7, align 4
  %15 = load ptr, ptr %4, align 8
  %16 = load i32, ptr %7, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds i32, ptr %15, i64 %17
  store i32 %14, ptr %18, align 4
  br label %19

19:                                               ; preds = %13
  %20 = load i32, ptr %7, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %7, align 4
  br label %9, !llvm.loop !19

22:                                               ; preds = %9
  %23 = load i32, ptr %6, align 4
  %24 = icmp eq i32 %23, 5
  br i1 %24, label %25, label %26

25:                                               ; preds = %22
  br label %44

26:                                               ; preds = %22
  store i32 0, ptr %8, align 4
  br label %27

27:                                               ; preds = %41, %26
  %28 = load i32, ptr %8, align 4
  %29 = load i32, ptr %6, align 4
  %30 = icmp slt i32 %28, %29
  br i1 %30, label %31, label %44

31:                                               ; preds = %27
  %32 = load ptr, ptr %4, align 8
  %33 = load i32, ptr %8, align 4
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds i32, ptr %32, i64 %34
  %36 = load i32, ptr %35, align 4
  %37 = load ptr, ptr %5, align 8
  %38 = load i32, ptr %8, align 4
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds i32, ptr %37, i64 %39
  store i32 %36, ptr %40, align 4
  br label %41

41:                                               ; preds = %31
  %42 = load i32, ptr %8, align 4
  %43 = add nsw i32 %42, 1
  store i32 %43, ptr %8, align 4
  br label %27, !llvm.loop !20

44:                                               ; preds = %25, %27
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @cfe_negative_if_else(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store i32 %2, ptr %6, align 4
  %9 = load i32, ptr %6, align 4
  %10 = icmp sgt i32 %9, 0
  br i1 %10, label %11, label %26

11:                                               ; preds = %3
  store i32 0, ptr %7, align 4
  br label %12

12:                                               ; preds = %22, %11
  %13 = load i32, ptr %7, align 4
  %14 = load i32, ptr %6, align 4
  %15 = icmp slt i32 %13, %14
  br i1 %15, label %16, label %25

16:                                               ; preds = %12
  %17 = load i32, ptr %7, align 4
  %18 = load ptr, ptr %4, align 8
  %19 = load i32, ptr %7, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds i32, ptr %18, i64 %20
  store i32 %17, ptr %21, align 4
  br label %22

22:                                               ; preds = %16
  %23 = load i32, ptr %7, align 4
  %24 = add nsw i32 %23, 1
  store i32 %24, ptr %7, align 4
  br label %12, !llvm.loop !21

25:                                               ; preds = %12
  br label %40

26:                                               ; preds = %3
  store i32 0, ptr %8, align 4
  br label %27

27:                                               ; preds = %36, %26
  %28 = load i32, ptr %8, align 4
  %29 = icmp slt i32 %28, 10
  br i1 %29, label %30, label %39

30:                                               ; preds = %27
  %31 = load i32, ptr %8, align 4
  %32 = load ptr, ptr %5, align 8
  %33 = load i32, ptr %8, align 4
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds i32, ptr %32, i64 %34
  store i32 %31, ptr %35, align 4
  br label %36

36:                                               ; preds = %30
  %37 = load i32, ptr %8, align 4
  %38 = add nsw i32 %37, 1
  store i32 %38, ptr %8, align 4
  br label %27, !llvm.loop !22

39:                                               ; preds = %27
  br label %40

40:                                               ; preds = %39, %25
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  store i32 0, ptr %1, align 4
  store i32 20, ptr %2, align 4
  store i32 10, ptr %3, align 4
  %7 = load i32, ptr %2, align 4
  %8 = zext i32 %7 to i64
  %9 = call ptr @llvm.stacksave.p0()
  store ptr %9, ptr %4, align 8
  %10 = alloca i32, i64 %8, align 16
  store i64 %8, ptr %5, align 8
  %11 = load i32, ptr %2, align 4
  %12 = zext i32 %11 to i64
  %13 = alloca i32, i64 %12, align 16
  store i64 %12, ptr %6, align 8
  %14 = load i32, ptr %2, align 4
  call void @cfe_positive_always(ptr noundef %10, ptr noundef %13, i32 noundef %14)
  %15 = load i32, ptr %2, align 4
  call void @cfe_positive_same_guard(ptr noundef %10, ptr noundef %13, i32 noundef %15)
  %16 = load i32, ptr %2, align 4
  call void @cfe_positive_do_while(ptr noundef %10, ptr noundef %13, i32 noundef %16)
  %17 = load i32, ptr %2, align 4
  call void @cfe_negative_first_guarded(ptr noundef %10, ptr noundef %13, i32 noundef %17)
  %18 = load i32, ptr %2, align 4
  %19 = load i32, ptr %3, align 4
  call void @cfe_negative_different_guards(ptr noundef %10, ptr noundef %13, i32 noundef %18, i32 noundef %19)
  %20 = load i32, ptr %2, align 4
  call void @cfe_negative_intermediate_if(ptr noundef %10, ptr noundef %13, i32 noundef %20)
  %21 = load i32, ptr %2, align 4
  call void @cfe_negative_break(ptr noundef %10, ptr noundef %13, i32 noundef %21)
  %22 = load i32, ptr %2, align 4
  call void @cfe_negative_if_else(ptr noundef %10, ptr noundef %13, i32 noundef %22)
  store i32 0, ptr %1, align 4
  %23 = load ptr, ptr %4, align 8
  call void @llvm.stackrestore.p0(ptr %23)
  %24 = load i32, ptr %1, align 4
  ret i32 %24
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
