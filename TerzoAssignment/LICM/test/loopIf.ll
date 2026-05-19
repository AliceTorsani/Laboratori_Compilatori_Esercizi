; ModuleID = 'loopIf.cpp'
source_filename = "loopIf.cpp"
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
  %12 = alloca float, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i8, align 1
  %16 = alloca i8, align 1
  store i32 %0, ptr %2, align 4
  store i32 5, ptr %3, align 4
  %17 = load i32, ptr %3, align 4
  %18 = add nsw i32 %17, 5
  store i32 %18, ptr %4, align 4
  store i32 10, ptr %5, align 4
  store i32 20, ptr %6, align 4
  store i32 0, ptr %7, align 4
  store i32 3, ptr %8, align 4
  store i32 0, ptr %9, align 4
  br label %19

19:                                               ; preds = %44, %1
  %20 = load i32, ptr %9, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %9, align 4
  %22 = load i32, ptr %2, align 4
  %23 = sub nsw i32 0, %22
  store i32 %23, ptr %10, align 4
  %24 = load i32, ptr %5, align 4
  %25 = load i32, ptr %6, align 4
  %26 = add nsw i32 %24, %25
  store i32 %26, ptr %11, align 4
  %27 = load i32, ptr %11, align 4
  %28 = load i32, ptr %5, align 4
  %29 = sdiv i32 %27, %28
  %30 = sitofp i32 %29 to float
  store float %30, ptr %12, align 4
  %31 = load i32, ptr %5, align 4
  %32 = load i32, ptr %10, align 4
  %33 = add nsw i32 %31, %32
  store i32 %33, ptr %13, align 4
  %34 = load i32, ptr %11, align 4
  %35 = load i32, ptr %13, align 4
  %36 = add nsw i32 %34, %35
  store i32 %36, ptr %7, align 4
  %37 = load i32, ptr %2, align 4
  %38 = icmp sgt i32 %37, 2
  br i1 %38, label %39, label %43

39:                                               ; preds = %19
  %40 = load i32, ptr %5, align 4
  %41 = load i32, ptr %8, align 4
  %42 = add nsw i32 %40, %41
  store i32 %42, ptr %14, align 4
  br label %43

43:                                               ; preds = %39, %19
  br label %44

44:                                               ; preds = %43
  %45 = load i32, ptr %9, align 4
  %46 = icmp slt i32 %45, 100
  br i1 %46, label %19, label %47, !llvm.loop !6

47:                                               ; preds = %44
  store i8 1, ptr %15, align 1
  %48 = load i8, ptr %15, align 1
  %49 = trunc i8 %48 to i1
  %50 = xor i1 %49, true
  %51 = zext i1 %50 to i8
  store i8 %51, ptr %16, align 1
  %52 = load i32, ptr %3, align 4
  %53 = load i32, ptr %9, align 4
  %54 = add nsw i32 %52, %53
  %55 = load i32, ptr %2, align 4
  %56 = add nsw i32 %54, %55
  ret i32 %56
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
