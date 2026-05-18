; ModuleID = 'loopannidati.cpp'
source_filename = "loopannidati.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

module asm ".globl _ZSt21ios_base_library_initv"

; Function Attrs: mustprogress noinline norecurse nounwind uwtable
define dso_local noundef i32 @main() #0 {
  %1 = alloca i32, align 4
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
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 200, ptr %2, align 4
  store i32 1, ptr %3, align 4
  store i32 2, ptr %4, align 4
  store i32 0, ptr %5, align 4
  store i32 0, ptr %6, align 4
  br label %16

16:                                               ; preds = %51, %0
  %17 = load i32, ptr %6, align 4
  %18 = icmp slt i32 %17, 200
  br i1 %18, label %19, label %54

19:                                               ; preds = %16
  %20 = load i32, ptr %3, align 4
  %21 = load i32, ptr %4, align 4
  %22 = add nsw i32 %20, %21
  store i32 %22, ptr %7, align 4
  store i32 0, ptr %8, align 4
  br label %23

23:                                               ; preds = %47, %19
  %24 = load i32, ptr %6, align 4
  %25 = load i32, ptr %3, align 4
  %26 = add nsw i32 %24, %25
  store i32 %26, ptr %9, align 4
  %27 = load i32, ptr %3, align 4
  %28 = mul nsw i32 %27, 2
  store i32 %28, ptr %10, align 4
  store i32 0, ptr %11, align 4
  br label %29

29:                                               ; preds = %41, %23
  %30 = load i32, ptr %4, align 4
  %31 = load i32, ptr %8, align 4
  %32 = add nsw i32 %30, %31
  store i32 %32, ptr %12, align 4
  %33 = load i32, ptr %7, align 4
  %34 = load i32, ptr %11, align 4
  %35 = add nsw i32 %33, %34
  store i32 %35, ptr %13, align 4
  %36 = load i32, ptr %9, align 4
  %37 = load i32, ptr %12, align 4
  %38 = add nsw i32 %36, %37
  store i32 %38, ptr %14, align 4
  %39 = load i32, ptr %11, align 4
  %40 = add nsw i32 %39, 1
  store i32 %40, ptr %11, align 4
  br label %41

41:                                               ; preds = %29
  %42 = load i32, ptr %11, align 4
  %43 = icmp slt i32 %42, 200
  br i1 %43, label %29, label %44, !llvm.loop !6

44:                                               ; preds = %41
  %45 = load i32, ptr %8, align 4
  %46 = add nsw i32 %45, 1
  store i32 %46, ptr %8, align 4
  br label %47

47:                                               ; preds = %44
  %48 = load i32, ptr %8, align 4
  %49 = icmp slt i32 %48, 200
  br i1 %49, label %23, label %50, !llvm.loop !8

50:                                               ; preds = %47
  br label %51

51:                                               ; preds = %50
  %52 = load i32, ptr %6, align 4
  %53 = add nsw i32 %52, 1
  store i32 %53, ptr %6, align 4
  br label %16, !llvm.loop !9

54:                                               ; preds = %16
  %55 = load i32, ptr %5, align 4
  %56 = add nsw i32 %55, 1
  store i32 %56, ptr %15, align 4
  %57 = load i32, ptr %1, align 4
  ret i32 %57
}

attributes #0 = { mustprogress noinline norecurse nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
