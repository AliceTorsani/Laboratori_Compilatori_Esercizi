; ModuleID = 'Test.ll'
source_filename = "Test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [19 x i8] c"Loop semplice: %d\0A\00", align 1
@.str.1 = private unnamed_addr constant [28 x i8] c"Primo loop sequenziale: %d\0A\00", align 1
@.str.2 = private unnamed_addr constant [30 x i8] c"Secondo loop sequenziale: %d\0A\00", align 1
@.str.3 = private unnamed_addr constant [32 x i8] c"Loop annidato 2 livelli: %d %d\0A\00", align 1
@.str.4 = private unnamed_addr constant [35 x i8] c"Loop annidato 3 livelli: %d %d %d\0A\00", align 1
@.str.5 = private unnamed_addr constant [16 x i8] c"While loop: %d\0A\00", align 1
@.str.6 = private unnamed_addr constant [20 x i8] c"Loop con break: %d\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"Loop con continue: %d\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  br label %1

1:                                                ; preds = %5, %0
  %.01 = phi i32 [ 0, %0 ], [ %6, %5 ]
  %2 = icmp slt i32 %.01, 5
  br i1 %2, label %3, label %7

3:                                                ; preds = %1
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %.01)
  br label %5

5:                                                ; preds = %3
  %6 = add nsw i32 %.01, 1
  br label %1, !llvm.loop !6

7:                                                ; preds = %1
  br label %8

8:                                                ; preds = %12, %7
  %.1 = phi i32 [ 0, %7 ], [ %13, %12 ]
  %9 = icmp slt i32 %.1, 3
  br i1 %9, label %10, label %14

10:                                               ; preds = %8
  %11 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %.1)
  br label %12

12:                                               ; preds = %10
  %13 = add nsw i32 %.1, 1
  br label %8, !llvm.loop !8

14:                                               ; preds = %8
  br label %15

15:                                               ; preds = %19, %14
  %.02 = phi i32 [ 0, %14 ], [ %20, %19 ]
  %16 = icmp slt i32 %.02, 3
  br i1 %16, label %17, label %21

17:                                               ; preds = %15
  %18 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %.02)
  br label %19

19:                                               ; preds = %17
  %20 = add nsw i32 %.02, 1
  br label %15, !llvm.loop !9

21:                                               ; preds = %15
  br label %22

22:                                               ; preds = %32, %21
  %.2 = phi i32 [ 0, %21 ], [ %33, %32 ]
  %23 = icmp slt i32 %.2, 3
  br i1 %23, label %24, label %34

24:                                               ; preds = %22
  br label %25

25:                                               ; preds = %29, %24
  %.13 = phi i32 [ 0, %24 ], [ %30, %29 ]
  %26 = icmp slt i32 %.13, 2
  br i1 %26, label %27, label %31

27:                                               ; preds = %25
  %28 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef %.2, i32 noundef %.13)
  br label %29

29:                                               ; preds = %27
  %30 = add nsw i32 %.13, 1
  br label %25, !llvm.loop !10

31:                                               ; preds = %25
  br label %32

32:                                               ; preds = %31
  %33 = add nsw i32 %.2, 1
  br label %22, !llvm.loop !11

34:                                               ; preds = %22
  br label %35

35:                                               ; preds = %51, %34
  %.3 = phi i32 [ 0, %34 ], [ %52, %51 ]
  %36 = icmp slt i32 %.3, 2
  br i1 %36, label %37, label %53

37:                                               ; preds = %35
  br label %38

38:                                               ; preds = %48, %37
  %.24 = phi i32 [ 0, %37 ], [ %49, %48 ]
  %39 = icmp slt i32 %.24, 2
  br i1 %39, label %40, label %50

40:                                               ; preds = %38
  br label %41

41:                                               ; preds = %45, %40
  %.0 = phi i32 [ 0, %40 ], [ %46, %45 ]
  %42 = icmp slt i32 %.0, 2
  br i1 %42, label %43, label %47

43:                                               ; preds = %41
  %44 = call i32 (ptr, ...) @printf(ptr noundef @.str.4, i32 noundef %.3, i32 noundef %.24, i32 noundef %.0)
  br label %45

45:                                               ; preds = %43
  %46 = add nsw i32 %.0, 1
  br label %41, !llvm.loop !12

47:                                               ; preds = %41
  br label %48

48:                                               ; preds = %47
  %49 = add nsw i32 %.24, 1
  br label %38, !llvm.loop !13

50:                                               ; preds = %38
  br label %51

51:                                               ; preds = %50
  %52 = add nsw i32 %.3, 1
  br label %35, !llvm.loop !14

53:                                               ; preds = %35
  br label %54

54:                                               ; preds = %56, %53
  %.4 = phi i32 [ 0, %53 ], [ %58, %56 ]
  %55 = icmp slt i32 %.4, 3
  br i1 %55, label %56, label %59

56:                                               ; preds = %54
  %57 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, i32 noundef %.4)
  %58 = add nsw i32 %.4, 1
  br label %54, !llvm.loop !15

59:                                               ; preds = %54
  br label %60

60:                                               ; preds = %67, %59
  %.5 = phi i32 [ 0, %59 ], [ %68, %67 ]
  %61 = icmp slt i32 %.5, 10
  br i1 %61, label %62, label %69

62:                                               ; preds = %60
  %63 = icmp eq i32 %.5, 4
  br i1 %63, label %64, label %65

64:                                               ; preds = %62
  br label %69

65:                                               ; preds = %62
  %66 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, i32 noundef %.5)
  br label %67

67:                                               ; preds = %65
  %68 = add nsw i32 %.5, 1
  br label %60, !llvm.loop !16

69:                                               ; preds = %64, %60
  br label %70

70:                                               ; preds = %78, %69
  %.6 = phi i32 [ 0, %69 ], [ %79, %78 ]
  %71 = icmp slt i32 %.6, 5
  br i1 %71, label %72, label %80

72:                                               ; preds = %70
  %73 = srem i32 %.6, 2
  %74 = icmp eq i32 %73, 0
  br i1 %74, label %75, label %76

75:                                               ; preds = %72
  br label %78

76:                                               ; preds = %72
  %77 = call i32 (ptr, ...) @printf(ptr noundef @.str.7, i32 noundef %.6)
  br label %78

78:                                               ; preds = %76, %75
  %79 = add nsw i32 %.6, 1
  br label %70, !llvm.loop !17

80:                                               ; preds = %70
  ret i32 0
}

declare i32 @printf(ptr noundef, ...) #1

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
