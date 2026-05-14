; ModuleID = 'stressUnary.cpp'
source_filename = "stressUnary.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local noundef i32 @_Z16provaAssignementi(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca float, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i8, align 1
  %19 = alloca i8, align 1
  store i32 %0, ptr %2, align 4
  store i32 5, ptr %3, align 4
  %20 = load i32, ptr %3, align 4
  %21 = add nsw i32 %20, 5
  store i32 %21, ptr %4, align 4
  store i32 10, ptr %5, align 4
  store i32 20, ptr %6, align 4
  store i32 0, ptr %7, align 4
  store i32 3, ptr %8, align 4
  store i32 0, ptr %9, align 4
  br label %22

22:                                               ; preds = %59, %1
  %23 = load i32, ptr %9, align 4
  %24 = add nsw i32 %23, 1
  store i32 %24, ptr %9, align 4
  %25 = load i32, ptr %9, align 4
  store i32 %25, ptr %10, align 4
  %26 = load i32, ptr %2, align 4
  %27 = sub nsw i32 0, %26
  store i32 %27, ptr %11, align 4
  %28 = load i32, ptr %5, align 4
  %29 = load i32, ptr %6, align 4
  %30 = add nsw i32 %28, %29
  store i32 %30, ptr %12, align 4
  %31 = load i32, ptr %12, align 4
  %32 = load i32, ptr %5, align 4
  %33 = sdiv i32 %31, %32
  %34 = sitofp i32 %33 to float
  store float %34, ptr %13, align 4
  %35 = load i32, ptr %5, align 4
  %36 = load i32, ptr %10, align 4
  %37 = add nsw i32 %35, %36
  store i32 %37, ptr %14, align 4
  %38 = load i32, ptr %5, align 4
  %39 = load i32, ptr %11, align 4
  %40 = add nsw i32 %38, %39
  store i32 %40, ptr %15, align 4
  %41 = load i32, ptr %12, align 4
  %42 = load i32, ptr %14, align 4
  %43 = add nsw i32 %41, %42
  %44 = load i32, ptr %15, align 4
  %45 = add nsw i32 %43, %44
  store i32 %45, ptr %7, align 4
  %46 = load i32, ptr %2, align 4
  %47 = icmp sgt i32 %46, 2
  br i1 %47, label %48, label %58

48:                                               ; preds = %22
  %49 = load i32, ptr %2, align 4
  store i32 %49, ptr %16, align 4
  %50 = load i32, ptr %5, align 4
  %51 = load i32, ptr %8, align 4
  %52 = add nsw i32 %50, %51
  store i32 %52, ptr %17, align 4
  %53 = load i32, ptr %16, align 4
  %54 = add nsw i32 %53, 2
  store i32 %54, ptr %16, align 4
  %55 = load i32, ptr %16, align 4
  %56 = load i32, ptr %2, align 4
  %57 = add nsw i32 %56, %55
  store i32 %57, ptr %2, align 4
  br label %58

58:                                               ; preds = %48, %22
  br label %59

59:                                               ; preds = %58
  %60 = load i32, ptr %9, align 4
  %61 = icmp slt i32 %60, 100
  br i1 %61, label %22, label %62, !llvm.loop !6

62:                                               ; preds = %59
  store i8 1, ptr %18, align 1
  %63 = load i8, ptr %18, align 1
  %64 = trunc i8 %63 to i1
  %65 = xor i1 %64, true
  %66 = zext i1 %65 to i8
  store i8 %66, ptr %19, align 1
  %67 = load i32, ptr %3, align 4
  %68 = load i32, ptr %9, align 4
  %69 = add nsw i32 %67, %68
  %70 = load i32, ptr %2, align 4
  %71 = add nsw i32 %69, %70
  ret i32 %71
}

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local noundef i32 @_Z7icmTesti(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca [100 x i32], align 16
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  store i32 10, ptr %3, align 4
  store i32 20, ptr %4, align 4
  store i32 0, ptr %5, align 4
  store i32 3, ptr %6, align 4
  store i32 0, ptr %8, align 4
  br label %14

14:                                               ; preds = %37, %1
  %15 = load i32, ptr %8, align 4
  %16 = icmp slt i32 %15, 100
  br i1 %16, label %17, label %40

17:                                               ; preds = %14
  %18 = load i32, ptr %3, align 4
  %19 = load i32, ptr %4, align 4
  %20 = add nsw i32 %18, %19
  store i32 %20, ptr %9, align 4
  %21 = load i32, ptr %9, align 4
  %22 = mul nsw i32 %21, 2
  store i32 %22, ptr %10, align 4
  %23 = load i32, ptr %9, align 4
  %24 = load i32, ptr %8, align 4
  %25 = add nsw i32 %23, %24
  store i32 %25, ptr %11, align 4
  %26 = getelementptr inbounds [100 x i32], ptr %7, i64 0, i64 0
  %27 = load i32, ptr %26, align 16
  store i32 %27, ptr %12, align 4
  %28 = load i32, ptr %9, align 4
  %29 = load i32, ptr %10, align 4
  %30 = add nsw i32 %28, %29
  %31 = load i32, ptr %8, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds [100 x i32], ptr %7, i64 0, i64 %32
  store i32 %30, ptr %33, align 4
  %34 = load i32, ptr %10, align 4
  %35 = load i32, ptr %6, align 4
  %36 = add nsw i32 %34, %35
  store i32 %36, ptr %13, align 4
  br label %37

37:                                               ; preds = %17
  %38 = load i32, ptr %8, align 4
  %39 = add nsw i32 %38, 1
  store i32 %39, ptr %8, align 4
  br label %14, !llvm.loop !8

40:                                               ; preds = %14
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
!8 = distinct !{!8, !7}
