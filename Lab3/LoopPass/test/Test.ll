; ModuleID = 'Test.c'
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
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %2, align 4
  br label %5

5:                                                ; preds = %11, %0
  %6 = load i32, ptr %2, align 4
  %7 = icmp slt i32 %6, 5
  br i1 %7, label %8, label %14

8:                                                ; preds = %5
  %9 = load i32, ptr %2, align 4
  %10 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %9)
  br label %11

11:                                               ; preds = %8
  %12 = load i32, ptr %2, align 4
  %13 = add nsw i32 %12, 1
  store i32 %13, ptr %2, align 4
  br label %5, !llvm.loop !6

14:                                               ; preds = %5
  store i32 0, ptr %2, align 4
  br label %15

15:                                               ; preds = %21, %14
  %16 = load i32, ptr %2, align 4
  %17 = icmp slt i32 %16, 3
  br i1 %17, label %18, label %24

18:                                               ; preds = %15
  %19 = load i32, ptr %2, align 4
  %20 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %19)
  br label %21

21:                                               ; preds = %18
  %22 = load i32, ptr %2, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, ptr %2, align 4
  br label %15, !llvm.loop !8

24:                                               ; preds = %15
  store i32 0, ptr %3, align 4
  br label %25

25:                                               ; preds = %31, %24
  %26 = load i32, ptr %3, align 4
  %27 = icmp slt i32 %26, 3
  br i1 %27, label %28, label %34

28:                                               ; preds = %25
  %29 = load i32, ptr %3, align 4
  %30 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %29)
  br label %31

31:                                               ; preds = %28
  %32 = load i32, ptr %3, align 4
  %33 = add nsw i32 %32, 1
  store i32 %33, ptr %3, align 4
  br label %25, !llvm.loop !9

34:                                               ; preds = %25
  store i32 0, ptr %2, align 4
  br label %35

35:                                               ; preds = %50, %34
  %36 = load i32, ptr %2, align 4
  %37 = icmp slt i32 %36, 3
  br i1 %37, label %38, label %53

38:                                               ; preds = %35
  store i32 0, ptr %3, align 4
  br label %39

39:                                               ; preds = %46, %38
  %40 = load i32, ptr %3, align 4
  %41 = icmp slt i32 %40, 2
  br i1 %41, label %42, label %49

42:                                               ; preds = %39
  %43 = load i32, ptr %2, align 4
  %44 = load i32, ptr %3, align 4
  %45 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef %43, i32 noundef %44)
  br label %46

46:                                               ; preds = %42
  %47 = load i32, ptr %3, align 4
  %48 = add nsw i32 %47, 1
  store i32 %48, ptr %3, align 4
  br label %39, !llvm.loop !10

49:                                               ; preds = %39
  br label %50

50:                                               ; preds = %49
  %51 = load i32, ptr %2, align 4
  %52 = add nsw i32 %51, 1
  store i32 %52, ptr %2, align 4
  br label %35, !llvm.loop !11

53:                                               ; preds = %35
  store i32 0, ptr %2, align 4
  br label %54

54:                                               ; preds = %78, %53
  %55 = load i32, ptr %2, align 4
  %56 = icmp slt i32 %55, 2
  br i1 %56, label %57, label %81

57:                                               ; preds = %54
  store i32 0, ptr %3, align 4
  br label %58

58:                                               ; preds = %74, %57
  %59 = load i32, ptr %3, align 4
  %60 = icmp slt i32 %59, 2
  br i1 %60, label %61, label %77

61:                                               ; preds = %58
  store i32 0, ptr %4, align 4
  br label %62

62:                                               ; preds = %70, %61
  %63 = load i32, ptr %4, align 4
  %64 = icmp slt i32 %63, 2
  br i1 %64, label %65, label %73

65:                                               ; preds = %62
  %66 = load i32, ptr %2, align 4
  %67 = load i32, ptr %3, align 4
  %68 = load i32, ptr %4, align 4
  %69 = call i32 (ptr, ...) @printf(ptr noundef @.str.4, i32 noundef %66, i32 noundef %67, i32 noundef %68)
  br label %70

70:                                               ; preds = %65
  %71 = load i32, ptr %4, align 4
  %72 = add nsw i32 %71, 1
  store i32 %72, ptr %4, align 4
  br label %62, !llvm.loop !12

73:                                               ; preds = %62
  br label %74

74:                                               ; preds = %73
  %75 = load i32, ptr %3, align 4
  %76 = add nsw i32 %75, 1
  store i32 %76, ptr %3, align 4
  br label %58, !llvm.loop !13

77:                                               ; preds = %58
  br label %78

78:                                               ; preds = %77
  %79 = load i32, ptr %2, align 4
  %80 = add nsw i32 %79, 1
  store i32 %80, ptr %2, align 4
  br label %54, !llvm.loop !14

81:                                               ; preds = %54
  store i32 0, ptr %2, align 4
  br label %82

82:                                               ; preds = %85, %81
  %83 = load i32, ptr %2, align 4
  %84 = icmp slt i32 %83, 3
  br i1 %84, label %85, label %90

85:                                               ; preds = %82
  %86 = load i32, ptr %2, align 4
  %87 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, i32 noundef %86)
  %88 = load i32, ptr %2, align 4
  %89 = add nsw i32 %88, 1
  store i32 %89, ptr %2, align 4
  br label %82, !llvm.loop !15

90:                                               ; preds = %82
  store i32 0, ptr %2, align 4
  br label %91

91:                                               ; preds = %101, %90
  %92 = load i32, ptr %2, align 4
  %93 = icmp slt i32 %92, 10
  br i1 %93, label %94, label %104

94:                                               ; preds = %91
  %95 = load i32, ptr %2, align 4
  %96 = icmp eq i32 %95, 4
  br i1 %96, label %97, label %98

97:                                               ; preds = %94
  br label %104

98:                                               ; preds = %94
  %99 = load i32, ptr %2, align 4
  %100 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, i32 noundef %99)
  br label %101

101:                                              ; preds = %98
  %102 = load i32, ptr %2, align 4
  %103 = add nsw i32 %102, 1
  store i32 %103, ptr %2, align 4
  br label %91, !llvm.loop !16

104:                                              ; preds = %97, %91
  store i32 0, ptr %2, align 4
  br label %105

105:                                              ; preds = %116, %104
  %106 = load i32, ptr %2, align 4
  %107 = icmp slt i32 %106, 5
  br i1 %107, label %108, label %119

108:                                              ; preds = %105
  %109 = load i32, ptr %2, align 4
  %110 = srem i32 %109, 2
  %111 = icmp eq i32 %110, 0
  br i1 %111, label %112, label %113

112:                                              ; preds = %108
  br label %116

113:                                              ; preds = %108
  %114 = load i32, ptr %2, align 4
  %115 = call i32 (ptr, ...) @printf(ptr noundef @.str.7, i32 noundef %114)
  br label %116

116:                                              ; preds = %113, %112
  %117 = load i32, ptr %2, align 4
  %118 = add nsw i32 %117, 1
  store i32 %118, ptr %2, align 4
  br label %105, !llvm.loop !17

119:                                              ; preds = %105
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
