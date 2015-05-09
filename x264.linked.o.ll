; ModuleID = 'x264.linked.o'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32"
target triple = "i386-redhat-linux-gnu"

@x264_dct8_weight_tab = constant [64 x i32] [i32 256, i32 241, i32 324, i32 241, i32 256, i32 241, i32 324, i32 241, i32 241, i32 227, i32 305, i32 227, i32 241, i32 227, i32 305, i32 227, i32 324, i32 305, i32 410, i32 305, i32 324, i32 305, i32 410, i32 305, i32 241, i32 227, i32 305, i32 227, i32 241, i32 227, i32 305, i32 227, i32 256, i32 241, i32 324, i32 241, i32 256, i32 241, i32 324, i32 241, i32 241, i32 227, i32 305, i32 227, i32 241, i32 227, i32 305, i32 227, i32 324, i32 305, i32 410, i32 305, i32 324, i32 305, i32 410, i32 305, i32 241, i32 227, i32 305, i32 227, i32 241, i32 227, i32 305, i32 227], align 4
@x264_dct4_weight_tab = constant [16 x i32] [i32 453, i32 286, i32 453, i32 286, i32 286, i32 181, i32 286, i32 181, i32 453, i32 286, i32 453, i32 286, i32 286, i32 181, i32 286, i32 181], align 4
@x264_dct4_weight2_tab = constant [16 x i32] [i32 800, i32 320, i32 800, i32 320, i32 320, i32 128, i32 320, i32 128, i32 800, i32 320, i32 800, i32 320, i32 320, i32 128, i32 320, i32 128], align 4
@x264_dct8_weight2_tab = constant [64 x i32] [i32 256, i32 227, i32 410, i32 227, i32 256, i32 227, i32 410, i32 227, i32 227, i32 201, i32 363, i32 201, i32 227, i32 201, i32 363, i32 201, i32 410, i32 363, i32 656, i32 363, i32 410, i32 363, i32 656, i32 363, i32 227, i32 201, i32 363, i32 201, i32 227, i32 201, i32 363, i32 201, i32 256, i32 227, i32 410, i32 227, i32 256, i32 227, i32 410, i32 227, i32 227, i32 201, i32 363, i32 201, i32 227, i32 201, i32 363, i32 201, i32 410, i32 363, i32 656, i32 363, i32 410, i32 363, i32 656, i32 363, i32 227, i32 201, i32 363, i32 201, i32 227, i32 201, i32 363, i32 201], align 4
@.str = private constant [12 x i8] c"dct_in_data\00"

define void @dct4x4dc(i16* nocapture %d) nounwind {
bb.nph9:
  %tmp = alloca [16 x i16], align 2
  br label %0

; <label>:0                                       ; preds = %0, %bb.nph9
  %i.08 = phi i32 [ 0, %bb.nph9 ], [ %21, %0 ]
  %tmp22 = shl i32 %i.08, 2
  %scevgep23 = getelementptr i16* %d, i32 %tmp22
  %tmp2437 = or i32 %tmp22, 1
  %scevgep25 = getelementptr i16* %d, i32 %tmp2437
  %tmp2638 = or i32 %tmp22, 2
  %scevgep27 = getelementptr i16* %d, i32 %tmp2638
  %tmp2839 = or i32 %tmp22, 3
  %scevgep29 = getelementptr i16* %d, i32 %tmp2839
  %scevgep30 = getelementptr [16 x i16]* %tmp, i32 0, i32 %i.08
  %tmp31 = add i32 %i.08, 4
  %scevgep32 = getelementptr [16 x i16]* %tmp, i32 0, i32 %tmp31
  %tmp33 = add i32 %i.08, 8
  %scevgep34 = getelementptr [16 x i16]* %tmp, i32 0, i32 %tmp33
  %tmp35 = add i32 %i.08, 12
  %scevgep36 = getelementptr [16 x i16]* %tmp, i32 0, i32 %tmp35
  %1 = load i16* %scevgep23, align 2
  %2 = sext i16 %1 to i32
  %3 = load i16* %scevgep25, align 2
  %4 = sext i16 %3 to i32
  %5 = add nsw i32 %4, %2
  %6 = sub nsw i32 %2, %4
  %7 = load i16* %scevgep27, align 2
  %8 = sext i16 %7 to i32
  %9 = load i16* %scevgep29, align 2
  %10 = sext i16 %9 to i32
  %11 = add nsw i32 %10, %8
  %12 = sub nsw i32 %8, %10
  %13 = add nsw i32 %11, %5
  %14 = trunc i32 %13 to i16
  store i16 %14, i16* %scevgep30, align 2
  %15 = sub nsw i32 %5, %11
  %16 = trunc i32 %15 to i16
  store i16 %16, i16* %scevgep32, align 2
  %17 = sub nsw i32 %6, %12
  %18 = trunc i32 %17 to i16
  store i16 %18, i16* %scevgep34, align 2
  %19 = add nsw i32 %12, %6
  %20 = trunc i32 %19 to i16
  store i16 %20, i16* %scevgep36, align 2
  %21 = add nsw i32 %i.08, 1
  %exitcond21 = icmp eq i32 %21, 4
  br i1 %exitcond21, label %bb.nph, label %0

bb.nph:                                           ; preds = %bb.nph, %0
  %i1.07 = phi i32 [ %48, %bb.nph ], [ 0, %0 ]
  %tmp10 = shl i32 %i1.07, 2
  %scevgep = getelementptr [16 x i16]* %tmp, i32 0, i32 %tmp10
  %tmp1140 = or i32 %tmp10, 1
  %scevgep12 = getelementptr [16 x i16]* %tmp, i32 0, i32 %tmp1140
  %tmp1341 = or i32 %tmp10, 2
  %scevgep14 = getelementptr [16 x i16]* %tmp, i32 0, i32 %tmp1341
  %tmp1542 = or i32 %tmp10, 3
  %scevgep16 = getelementptr [16 x i16]* %tmp, i32 0, i32 %tmp1542
  %scevgep17 = getelementptr i16* %d, i32 %tmp10
  %scevgep18 = getelementptr i16* %d, i32 %tmp1140
  %scevgep19 = getelementptr i16* %d, i32 %tmp1341
  %scevgep20 = getelementptr i16* %d, i32 %tmp1542
  %22 = load i16* %scevgep, align 2
  %23 = sext i16 %22 to i32
  %24 = load i16* %scevgep12, align 2
  %25 = sext i16 %24 to i32
  %26 = add nsw i32 %25, %23
  %27 = sub nsw i32 %23, %25
  %28 = load i16* %scevgep14, align 2
  %29 = sext i16 %28 to i32
  %30 = load i16* %scevgep16, align 2
  %31 = sext i16 %30 to i32
  %32 = add nsw i32 %31, %29
  %33 = sub nsw i32 %29, %31
  %34 = add nsw i32 %26, 1
  %35 = add nsw i32 %34, %32
  %36 = lshr i32 %35, 1
  %37 = trunc i32 %36 to i16
  store i16 %37, i16* %scevgep17, align 2
  %38 = sub i32 %34, %32
  %39 = lshr i32 %38, 1
  %40 = trunc i32 %39 to i16
  store i16 %40, i16* %scevgep18, align 2
  %41 = add i32 %27, 1
  %42 = sub i32 %41, %33
  %43 = lshr i32 %42, 1
  %44 = trunc i32 %43 to i16
  store i16 %44, i16* %scevgep19, align 2
  %45 = add nsw i32 %41, %33
  %46 = lshr i32 %45, 1
  %47 = trunc i32 %46 to i16
  store i16 %47, i16* %scevgep20, align 2
  %48 = add nsw i32 %i1.07, 1
  %exitcond = icmp eq i32 %48, 4
  br i1 %exitcond, label %._crit_edge, label %bb.nph

._crit_edge:                                      ; preds = %bb.nph
  ret void
}

define void @idct4x4dc(i16* nocapture %d) nounwind {
bb.nph8:
  %tmp = alloca [16 x i16], align 2
  br label %0

; <label>:0                                       ; preds = %0, %bb.nph8
  %i.07 = phi i32 [ 0, %bb.nph8 ], [ %21, %0 ]
  %tmp20 = shl i32 %i.07, 2
  %scevgep21 = getelementptr i16* %d, i32 %tmp20
  %tmp2235 = or i32 %tmp20, 1
  %scevgep23 = getelementptr i16* %d, i32 %tmp2235
  %tmp2436 = or i32 %tmp20, 2
  %scevgep25 = getelementptr i16* %d, i32 %tmp2436
  %tmp2637 = or i32 %tmp20, 3
  %scevgep27 = getelementptr i16* %d, i32 %tmp2637
  %scevgep28 = getelementptr [16 x i16]* %tmp, i32 0, i32 %i.07
  %tmp29 = add i32 %i.07, 4
  %scevgep30 = getelementptr [16 x i16]* %tmp, i32 0, i32 %tmp29
  %tmp31 = add i32 %i.07, 8
  %scevgep32 = getelementptr [16 x i16]* %tmp, i32 0, i32 %tmp31
  %tmp33 = add i32 %i.07, 12
  %scevgep34 = getelementptr [16 x i16]* %tmp, i32 0, i32 %tmp33
  %1 = load i16* %scevgep21, align 2
  %2 = sext i16 %1 to i32
  %3 = load i16* %scevgep23, align 2
  %4 = sext i16 %3 to i32
  %5 = add nsw i32 %4, %2
  %6 = sub nsw i32 %2, %4
  %7 = load i16* %scevgep25, align 2
  %8 = sext i16 %7 to i32
  %9 = load i16* %scevgep27, align 2
  %10 = sext i16 %9 to i32
  %11 = add nsw i32 %10, %8
  %12 = sub nsw i32 %8, %10
  %13 = add nsw i32 %11, %5
  %14 = trunc i32 %13 to i16
  store i16 %14, i16* %scevgep28, align 2
  %15 = sub nsw i32 %5, %11
  %16 = trunc i32 %15 to i16
  store i16 %16, i16* %scevgep30, align 2
  %17 = sub nsw i32 %6, %12
  %18 = trunc i32 %17 to i16
  store i16 %18, i16* %scevgep32, align 2
  %19 = add nsw i32 %12, %6
  %20 = trunc i32 %19 to i16
  store i16 %20, i16* %scevgep34, align 2
  %21 = add nsw i32 %i.07, 1
  %exitcond = icmp eq i32 %21, 4
  br i1 %exitcond, label %22, label %0

; <label>:22                                      ; preds = %0
  %scevgep = getelementptr [16 x i16]* %tmp, i32 0, i32 0
  %scevgep11 = getelementptr [16 x i16]* %tmp, i32 0, i32 1
  %scevgep13 = getelementptr [16 x i16]* %tmp, i32 0, i32 2
  %scevgep15 = getelementptr [16 x i16]* %tmp, i32 0, i32 3
  %scevgep17 = getelementptr i16* %d, i32 1
  %scevgep18 = getelementptr i16* %d, i32 2
  %scevgep19 = getelementptr i16* %d, i32 3
  %23 = load i16* %scevgep, align 2
  %24 = sext i16 %23 to i32
  %25 = load i16* %scevgep11, align 2
  %26 = sext i16 %25 to i32
  %27 = add nsw i32 %26, %24
  %28 = sub nsw i32 %24, %26
  %29 = load i16* %scevgep13, align 2
  %30 = sext i16 %29 to i32
  %31 = load i16* %scevgep15, align 2
  %32 = sext i16 %31 to i32
  %33 = add nsw i32 %32, %30
  %34 = sub nsw i32 %30, %32
  %35 = add nsw i32 %33, %27
  %36 = trunc i32 %35 to i16
  store i16 %36, i16* %d, align 2
  %37 = sub nsw i32 %27, %33
  %38 = trunc i32 %37 to i16
  store i16 %38, i16* %scevgep17, align 2
  %39 = sub nsw i32 %28, %34
  %40 = trunc i32 %39 to i16
  store i16 %40, i16* %scevgep18, align 2
  %41 = add nsw i32 %34, %28
  %42 = trunc i32 %41 to i16
  store i16 %42, i16* %scevgep19, align 2
  %scevgep.1 = getelementptr [16 x i16]* %tmp, i32 0, i32 4
  %scevgep11.1 = getelementptr [16 x i16]* %tmp, i32 0, i32 5
  %scevgep13.1 = getelementptr [16 x i16]* %tmp, i32 0, i32 6
  %scevgep15.1 = getelementptr [16 x i16]* %tmp, i32 0, i32 7
  %scevgep16.1 = getelementptr i16* %d, i32 4
  %scevgep17.1 = getelementptr i16* %d, i32 5
  %scevgep18.1 = getelementptr i16* %d, i32 6
  %scevgep19.1 = getelementptr i16* %d, i32 7
  %43 = load i16* %scevgep.1, align 2
  %44 = sext i16 %43 to i32
  %45 = load i16* %scevgep11.1, align 2
  %46 = sext i16 %45 to i32
  %47 = add nsw i32 %46, %44
  %48 = sub nsw i32 %44, %46
  %49 = load i16* %scevgep13.1, align 2
  %50 = sext i16 %49 to i32
  %51 = load i16* %scevgep15.1, align 2
  %52 = sext i16 %51 to i32
  %53 = add nsw i32 %52, %50
  %54 = sub nsw i32 %50, %52
  %55 = add nsw i32 %53, %47
  %56 = trunc i32 %55 to i16
  store i16 %56, i16* %scevgep16.1, align 2
  %57 = sub nsw i32 %47, %53
  %58 = trunc i32 %57 to i16
  store i16 %58, i16* %scevgep17.1, align 2
  %59 = sub nsw i32 %48, %54
  %60 = trunc i32 %59 to i16
  store i16 %60, i16* %scevgep18.1, align 2
  %61 = add nsw i32 %54, %48
  %62 = trunc i32 %61 to i16
  store i16 %62, i16* %scevgep19.1, align 2
  %scevgep.2 = getelementptr [16 x i16]* %tmp, i32 0, i32 8
  %scevgep11.2 = getelementptr [16 x i16]* %tmp, i32 0, i32 9
  %scevgep13.2 = getelementptr [16 x i16]* %tmp, i32 0, i32 10
  %scevgep15.2 = getelementptr [16 x i16]* %tmp, i32 0, i32 11
  %scevgep16.2 = getelementptr i16* %d, i32 8
  %scevgep17.2 = getelementptr i16* %d, i32 9
  %scevgep18.2 = getelementptr i16* %d, i32 10
  %scevgep19.2 = getelementptr i16* %d, i32 11
  %63 = load i16* %scevgep.2, align 2
  %64 = sext i16 %63 to i32
  %65 = load i16* %scevgep11.2, align 2
  %66 = sext i16 %65 to i32
  %67 = add nsw i32 %66, %64
  %68 = sub nsw i32 %64, %66
  %69 = load i16* %scevgep13.2, align 2
  %70 = sext i16 %69 to i32
  %71 = load i16* %scevgep15.2, align 2
  %72 = sext i16 %71 to i32
  %73 = add nsw i32 %72, %70
  %74 = sub nsw i32 %70, %72
  %75 = add nsw i32 %73, %67
  %76 = trunc i32 %75 to i16
  store i16 %76, i16* %scevgep16.2, align 2
  %77 = sub nsw i32 %67, %73
  %78 = trunc i32 %77 to i16
  store i16 %78, i16* %scevgep17.2, align 2
  %79 = sub nsw i32 %68, %74
  %80 = trunc i32 %79 to i16
  store i16 %80, i16* %scevgep18.2, align 2
  %81 = add nsw i32 %74, %68
  %82 = trunc i32 %81 to i16
  store i16 %82, i16* %scevgep19.2, align 2
  %scevgep.3 = getelementptr [16 x i16]* %tmp, i32 0, i32 12
  %scevgep11.3 = getelementptr [16 x i16]* %tmp, i32 0, i32 13
  %scevgep13.3 = getelementptr [16 x i16]* %tmp, i32 0, i32 14
  %scevgep15.3 = getelementptr [16 x i16]* %tmp, i32 0, i32 15
  %scevgep16.3 = getelementptr i16* %d, i32 12
  %scevgep17.3 = getelementptr i16* %d, i32 13
  %scevgep18.3 = getelementptr i16* %d, i32 14
  %scevgep19.3 = getelementptr i16* %d, i32 15
  %83 = load i16* %scevgep.3, align 2
  %84 = sext i16 %83 to i32
  %85 = load i16* %scevgep11.3, align 2
  %86 = sext i16 %85 to i32
  %87 = add nsw i32 %86, %84
  %88 = sub nsw i32 %84, %86
  %89 = load i16* %scevgep13.3, align 2
  %90 = sext i16 %89 to i32
  %91 = load i16* %scevgep15.3, align 2
  %92 = sext i16 %91 to i32
  %93 = add nsw i32 %92, %90
  %94 = sub nsw i32 %90, %92
  %95 = add nsw i32 %93, %87
  %96 = trunc i32 %95 to i16
  store i16 %96, i16* %scevgep16.3, align 2
  %97 = sub nsw i32 %87, %93
  %98 = trunc i32 %97 to i16
  store i16 %98, i16* %scevgep17.3, align 2
  %99 = sub nsw i32 %88, %94
  %100 = trunc i32 %99 to i16
  store i16 %100, i16* %scevgep18.3, align 2
  %101 = add nsw i32 %94, %88
  %102 = trunc i32 %101 to i16
  store i16 %102, i16* %scevgep19.3, align 2
  ret void
}

define void @dct2x4dc(i16* nocapture %dct, [16 x i16]* nocapture %dct4x4) nounwind {
  %1 = getelementptr inbounds [16 x i16]* %dct4x4, i32 0, i32 0
  %2 = load i16* %1, align 2
  %3 = sext i16 %2 to i32
  %4 = getelementptr inbounds [16 x i16]* %dct4x4, i32 1, i32 0
  %5 = load i16* %4, align 2
  %6 = sext i16 %5 to i32
  %7 = add nsw i32 %6, %3
  %8 = getelementptr inbounds [16 x i16]* %dct4x4, i32 2, i32 0
  %9 = load i16* %8, align 2
  %10 = sext i16 %9 to i32
  %11 = getelementptr inbounds [16 x i16]* %dct4x4, i32 3, i32 0
  %12 = load i16* %11, align 2
  %13 = sext i16 %12 to i32
  %14 = add nsw i32 %13, %10
  %15 = getelementptr inbounds [16 x i16]* %dct4x4, i32 4, i32 0
  %16 = load i16* %15, align 2
  %17 = sext i16 %16 to i32
  %18 = getelementptr inbounds [16 x i16]* %dct4x4, i32 5, i32 0
  %19 = load i16* %18, align 2
  %20 = sext i16 %19 to i32
  %21 = add nsw i32 %20, %17
  %22 = getelementptr inbounds [16 x i16]* %dct4x4, i32 6, i32 0
  %23 = load i16* %22, align 2
  %24 = sext i16 %23 to i32
  %25 = getelementptr inbounds [16 x i16]* %dct4x4, i32 7, i32 0
  %26 = load i16* %25, align 2
  %27 = sext i16 %26 to i32
  %28 = add nsw i32 %27, %24
  %29 = sub nsw i32 %3, %6
  %30 = sub nsw i32 %10, %13
  %31 = sub nsw i32 %17, %20
  %32 = sub nsw i32 %24, %27
  %33 = add nsw i32 %14, %7
  %34 = add nsw i32 %28, %21
  %35 = add nsw i32 %30, %29
  %36 = add nsw i32 %32, %31
  %37 = sub nsw i32 %7, %14
  %38 = sub nsw i32 %21, %28
  %39 = sub nsw i32 %29, %30
  %40 = sub nsw i32 %31, %32
  %41 = add nsw i32 %34, %33
  %42 = trunc i32 %41 to i16
  store i16 %42, i16* %dct, align 2
  %43 = add nsw i32 %36, %35
  %44 = trunc i32 %43 to i16
  %45 = getelementptr inbounds i16* %dct, i32 1
  store i16 %44, i16* %45, align 2
  %46 = sub nsw i32 %33, %34
  %47 = trunc i32 %46 to i16
  %48 = getelementptr inbounds i16* %dct, i32 2
  store i16 %47, i16* %48, align 2
  %49 = sub nsw i32 %35, %36
  %50 = trunc i32 %49 to i16
  %51 = getelementptr inbounds i16* %dct, i32 3
  store i16 %50, i16* %51, align 2
  %52 = sub nsw i32 %37, %38
  %53 = trunc i32 %52 to i16
  %54 = getelementptr inbounds i16* %dct, i32 4
  store i16 %53, i16* %54, align 2
  %55 = sub nsw i32 %39, %40
  %56 = trunc i32 %55 to i16
  %57 = getelementptr inbounds i16* %dct, i32 5
  store i16 %56, i16* %57, align 2
  %58 = add nsw i32 %38, %37
  %59 = trunc i32 %58 to i16
  %60 = getelementptr inbounds i16* %dct, i32 6
  store i16 %59, i16* %60, align 2
  %61 = add nsw i32 %40, %39
  %62 = trunc i32 %61 to i16
  %63 = getelementptr inbounds i16* %dct, i32 7
  store i16 %62, i16* %63, align 2
  store i16 0, i16* %1, align 2
  store i16 0, i16* %4, align 2
  store i16 0, i16* %8, align 2
  store i16 0, i16* %11, align 2
  store i16 0, i16* %15, align 2
  store i16 0, i16* %18, align 2
  store i16 0, i16* %22, align 2
  store i16 0, i16* %25, align 2
  ret void
}

define void @sub4x4_dct(i16* nocapture %dct, i8* nocapture %pix1, i8* nocapture %pix2) nounwind {
; <label>:0
  %d = alloca [16 x i16], align 2
  %tmp = alloca [16 x i16], align 2
  br label %bb.nph.us.i

bb.nph.us.i:                                      ; preds = %bb.nph.us.i, %0
  %y.05.us.i = phi i32 [ %21, %bb.nph.us.i ], [ 0, %0 ]
  %tmp46 = shl i32 %y.05.us.i, 4
  %tmp54 = shl i32 %y.05.us.i, 5
  %tmp62 = shl i32 %y.05.us.i, 2
  %tmp6778 = or i32 %tmp62, 1
  %tmp6577 = or i32 %tmp62, 2
  %tmp6376 = or i32 %tmp62, 3
  %tmp5975 = or i32 %tmp54, 1
  %tmp5774 = or i32 %tmp54, 2
  %tmp5573 = or i32 %tmp54, 3
  %tmp5172 = or i32 %tmp46, 1
  %tmp4971 = or i32 %tmp46, 2
  %tmp4770 = or i32 %tmp46, 3
  %scevgep.i = getelementptr [16 x i16]* %d, i32 0, i32 %tmp62
  %scevgep.i.1 = getelementptr [16 x i16]* %d, i32 0, i32 %tmp6778
  %scevgep.i.2 = getelementptr [16 x i16]* %d, i32 0, i32 %tmp6577
  %scevgep.i.3 = getelementptr [16 x i16]* %d, i32 0, i32 %tmp6376
  %scevgep11.i = getelementptr i8* %pix2, i32 %tmp54
  %scevgep11.i.1 = getelementptr i8* %pix2, i32 %tmp5975
  %scevgep11.i.2 = getelementptr i8* %pix2, i32 %tmp5774
  %scevgep11.i.3 = getelementptr i8* %pix2, i32 %tmp5573
  %scevgep14.i = getelementptr i8* %pix1, i32 %tmp46
  %scevgep14.i.1 = getelementptr i8* %pix1, i32 %tmp5172
  %scevgep14.i.2 = getelementptr i8* %pix1, i32 %tmp4971
  %scevgep14.i.3 = getelementptr i8* %pix1, i32 %tmp4770
  %1 = load i8* %scevgep14.i, align 1
  %2 = zext i8 %1 to i16
  %3 = load i8* %scevgep11.i, align 1
  %4 = zext i8 %3 to i16
  %5 = sub i16 %2, %4
  store i16 %5, i16* %scevgep.i, align 2
  %6 = load i8* %scevgep14.i.1, align 1
  %7 = zext i8 %6 to i16
  %8 = load i8* %scevgep11.i.1, align 1
  %9 = zext i8 %8 to i16
  %10 = sub i16 %7, %9
  store i16 %10, i16* %scevgep.i.1, align 2
  %11 = load i8* %scevgep14.i.2, align 1
  %12 = zext i8 %11 to i16
  %13 = load i8* %scevgep11.i.2, align 1
  %14 = zext i8 %13 to i16
  %15 = sub i16 %12, %14
  store i16 %15, i16* %scevgep.i.2, align 2
  %16 = load i8* %scevgep14.i.3, align 1
  %17 = zext i8 %16 to i16
  %18 = load i8* %scevgep11.i.3, align 1
  %19 = zext i8 %18 to i16
  %20 = sub i16 %17, %19
  store i16 %20, i16* %scevgep.i.3, align 2
  %21 = add nsw i32 %y.05.us.i, 1
  %exitcond45 = icmp eq i32 %21, 4
  br i1 %exitcond45, label %pixel_sub_wxh.exit, label %bb.nph.us.i

pixel_sub_wxh.exit:                               ; preds = %pixel_sub_wxh.exit, %bb.nph.us.i
  %i.07 = phi i32 [ %44, %pixel_sub_wxh.exit ], [ 0, %bb.nph.us.i ]
  %tmp20 = shl i32 %i.07, 2
  %scevgep21 = getelementptr [16 x i16]* %d, i32 0, i32 %tmp20
  %tmp2279 = or i32 %tmp20, 3
  %scevgep23 = getelementptr [16 x i16]* %d, i32 0, i32 %tmp2279
  %tmp2480 = or i32 %tmp20, 1
  %scevgep25 = getelementptr [16 x i16]* %d, i32 0, i32 %tmp2480
  %tmp2681 = or i32 %tmp20, 2
  %scevgep27 = getelementptr [16 x i16]* %d, i32 0, i32 %tmp2681
  %scevgep28 = getelementptr [16 x i16]* %tmp, i32 0, i32 %i.07
  %tmp29 = add i32 %i.07, 4
  %scevgep30 = getelementptr [16 x i16]* %tmp, i32 0, i32 %tmp29
  %tmp31 = add i32 %i.07, 8
  %scevgep32 = getelementptr [16 x i16]* %tmp, i32 0, i32 %tmp31
  %tmp33 = add i32 %i.07, 12
  %scevgep34 = getelementptr [16 x i16]* %tmp, i32 0, i32 %tmp33
  %22 = load i16* %scevgep21, align 2
  %23 = sext i16 %22 to i32
  %24 = load i16* %scevgep23, align 2
  %25 = sext i16 %24 to i32
  %26 = add nsw i32 %25, %23
  %27 = load i16* %scevgep25, align 2
  %28 = sext i16 %27 to i32
  %29 = load i16* %scevgep27, align 2
  %30 = sext i16 %29 to i32
  %31 = add nsw i32 %30, %28
  %32 = sub nsw i32 %23, %25
  %33 = sub nsw i32 %28, %30
  %34 = add nsw i32 %31, %26
  %35 = trunc i32 %34 to i16
  store i16 %35, i16* %scevgep28, align 2
  %36 = shl i32 %32, 1
  %37 = add nsw i32 %33, %36
  %38 = trunc i32 %37 to i16
  store i16 %38, i16* %scevgep30, align 2
  %39 = sub nsw i32 %26, %31
  %40 = trunc i32 %39 to i16
  store i16 %40, i16* %scevgep32, align 2
  %41 = shl i32 %33, 1
  %42 = sub nsw i32 %32, %41
  %43 = trunc i32 %42 to i16
  store i16 %43, i16* %scevgep34, align 2
  %44 = add nsw i32 %i.07, 1
  %exitcond = icmp eq i32 %44, 4
  br i1 %exitcond, label %45, label %pixel_sub_wxh.exit

; <label>:45                                      ; preds = %pixel_sub_wxh.exit
  %scevgep = getelementptr [16 x i16]* %tmp, i32 0, i32 0
  %scevgep11 = getelementptr [16 x i16]* %tmp, i32 0, i32 3
  %scevgep13 = getelementptr [16 x i16]* %tmp, i32 0, i32 1
  %scevgep15 = getelementptr [16 x i16]* %tmp, i32 0, i32 2
  %scevgep17 = getelementptr i16* %dct, i32 1
  %scevgep18 = getelementptr i16* %dct, i32 2
  %scevgep19 = getelementptr i16* %dct, i32 3
  %46 = load i16* %scevgep, align 2
  %47 = sext i16 %46 to i32
  %48 = load i16* %scevgep11, align 2
  %49 = sext i16 %48 to i32
  %50 = add nsw i32 %49, %47
  %51 = load i16* %scevgep13, align 2
  %52 = sext i16 %51 to i32
  %53 = load i16* %scevgep15, align 2
  %54 = sext i16 %53 to i32
  %55 = add nsw i32 %54, %52
  %56 = sub nsw i32 %47, %49
  %57 = sub nsw i32 %52, %54
  %58 = add nsw i32 %55, %50
  %59 = trunc i32 %58 to i16
  store i16 %59, i16* %dct, align 2
  %60 = shl i32 %56, 1
  %61 = add nsw i32 %57, %60
  %62 = trunc i32 %61 to i16
  store i16 %62, i16* %scevgep17, align 2
  %63 = sub nsw i32 %50, %55
  %64 = trunc i32 %63 to i16
  store i16 %64, i16* %scevgep18, align 2
  %65 = shl i32 %57, 1
  %66 = sub nsw i32 %56, %65
  %67 = trunc i32 %66 to i16
  store i16 %67, i16* %scevgep19, align 2
  %scevgep.1 = getelementptr [16 x i16]* %tmp, i32 0, i32 4
  %scevgep11.1 = getelementptr [16 x i16]* %tmp, i32 0, i32 7
  %scevgep13.1 = getelementptr [16 x i16]* %tmp, i32 0, i32 5
  %scevgep15.1 = getelementptr [16 x i16]* %tmp, i32 0, i32 6
  %scevgep16.1 = getelementptr i16* %dct, i32 4
  %scevgep17.1 = getelementptr i16* %dct, i32 5
  %scevgep18.1 = getelementptr i16* %dct, i32 6
  %scevgep19.1 = getelementptr i16* %dct, i32 7
  %68 = load i16* %scevgep.1, align 2
  %69 = sext i16 %68 to i32
  %70 = load i16* %scevgep11.1, align 2
  %71 = sext i16 %70 to i32
  %72 = add nsw i32 %71, %69
  %73 = load i16* %scevgep13.1, align 2
  %74 = sext i16 %73 to i32
  %75 = load i16* %scevgep15.1, align 2
  %76 = sext i16 %75 to i32
  %77 = add nsw i32 %76, %74
  %78 = sub nsw i32 %69, %71
  %79 = sub nsw i32 %74, %76
  %80 = add nsw i32 %77, %72
  %81 = trunc i32 %80 to i16
  store i16 %81, i16* %scevgep16.1, align 2
  %82 = shl i32 %78, 1
  %83 = add nsw i32 %79, %82
  %84 = trunc i32 %83 to i16
  store i16 %84, i16* %scevgep17.1, align 2
  %85 = sub nsw i32 %72, %77
  %86 = trunc i32 %85 to i16
  store i16 %86, i16* %scevgep18.1, align 2
  %87 = shl i32 %79, 1
  %88 = sub nsw i32 %78, %87
  %89 = trunc i32 %88 to i16
  store i16 %89, i16* %scevgep19.1, align 2
  %scevgep.2 = getelementptr [16 x i16]* %tmp, i32 0, i32 8
  %scevgep11.2 = getelementptr [16 x i16]* %tmp, i32 0, i32 11
  %scevgep13.2 = getelementptr [16 x i16]* %tmp, i32 0, i32 9
  %scevgep15.2 = getelementptr [16 x i16]* %tmp, i32 0, i32 10
  %scevgep16.2 = getelementptr i16* %dct, i32 8
  %scevgep17.2 = getelementptr i16* %dct, i32 9
  %scevgep18.2 = getelementptr i16* %dct, i32 10
  %scevgep19.2 = getelementptr i16* %dct, i32 11
  %90 = load i16* %scevgep.2, align 2
  %91 = sext i16 %90 to i32
  %92 = load i16* %scevgep11.2, align 2
  %93 = sext i16 %92 to i32
  %94 = add nsw i32 %93, %91
  %95 = load i16* %scevgep13.2, align 2
  %96 = sext i16 %95 to i32
  %97 = load i16* %scevgep15.2, align 2
  %98 = sext i16 %97 to i32
  %99 = add nsw i32 %98, %96
  %100 = sub nsw i32 %91, %93
  %101 = sub nsw i32 %96, %98
  %102 = add nsw i32 %99, %94
  %103 = trunc i32 %102 to i16
  store i16 %103, i16* %scevgep16.2, align 2
  %104 = shl i32 %100, 1
  %105 = add nsw i32 %101, %104
  %106 = trunc i32 %105 to i16
  store i16 %106, i16* %scevgep17.2, align 2
  %107 = sub nsw i32 %94, %99
  %108 = trunc i32 %107 to i16
  store i16 %108, i16* %scevgep18.2, align 2
  %109 = shl i32 %101, 1
  %110 = sub nsw i32 %100, %109
  %111 = trunc i32 %110 to i16
  store i16 %111, i16* %scevgep19.2, align 2
  %scevgep.3 = getelementptr [16 x i16]* %tmp, i32 0, i32 12
  %scevgep11.3 = getelementptr [16 x i16]* %tmp, i32 0, i32 15
  %scevgep13.3 = getelementptr [16 x i16]* %tmp, i32 0, i32 13
  %scevgep15.3 = getelementptr [16 x i16]* %tmp, i32 0, i32 14
  %scevgep16.3 = getelementptr i16* %dct, i32 12
  %scevgep17.3 = getelementptr i16* %dct, i32 13
  %scevgep18.3 = getelementptr i16* %dct, i32 14
  %scevgep19.3 = getelementptr i16* %dct, i32 15
  %112 = load i16* %scevgep.3, align 2
  %113 = sext i16 %112 to i32
  %114 = load i16* %scevgep11.3, align 2
  %115 = sext i16 %114 to i32
  %116 = add nsw i32 %115, %113
  %117 = load i16* %scevgep13.3, align 2
  %118 = sext i16 %117 to i32
  %119 = load i16* %scevgep15.3, align 2
  %120 = sext i16 %119 to i32
  %121 = add nsw i32 %120, %118
  %122 = sub nsw i32 %113, %115
  %123 = sub nsw i32 %118, %120
  %124 = add nsw i32 %121, %116
  %125 = trunc i32 %124 to i16
  store i16 %125, i16* %scevgep16.3, align 2
  %126 = shl i32 %122, 1
  %127 = add nsw i32 %123, %126
  %128 = trunc i32 %127 to i16
  store i16 %128, i16* %scevgep17.3, align 2
  %129 = sub nsw i32 %116, %121
  %130 = trunc i32 %129 to i16
  store i16 %130, i16* %scevgep18.3, align 2
  %131 = shl i32 %123, 1
  %132 = sub nsw i32 %122, %131
  %133 = trunc i32 %132 to i16
  store i16 %133, i16* %scevgep19.3, align 2
  ret void
}

define void @sub8x8_dct([16 x i16]* nocapture %dct, i8* nocapture %pix1, i8* nocapture %pix2) nounwind {
  %1 = getelementptr inbounds [16 x i16]* %dct, i32 0, i32 0
  tail call void @sub4x4_dct(i16* %1, i8* %pix1, i8* %pix2)
  %2 = getelementptr inbounds [16 x i16]* %dct, i32 1, i32 0
  %3 = getelementptr inbounds i8* %pix1, i32 4
  %4 = getelementptr inbounds i8* %pix2, i32 4
  tail call void @sub4x4_dct(i16* %2, i8* %3, i8* %4)
  %5 = getelementptr inbounds [16 x i16]* %dct, i32 2, i32 0
  %6 = getelementptr inbounds i8* %pix1, i32 64
  %7 = getelementptr inbounds i8* %pix2, i32 128
  tail call void @sub4x4_dct(i16* %5, i8* %6, i8* %7)
  %8 = getelementptr inbounds [16 x i16]* %dct, i32 3, i32 0
  %9 = getelementptr inbounds i8* %pix1, i32 68
  %10 = getelementptr inbounds i8* %pix2, i32 132
  tail call void @sub4x4_dct(i16* %8, i8* %9, i8* %10)
  ret void
}

define void @sub16x16_dct([16 x i16]* nocapture %dct, i8* nocapture %pix1, i8* nocapture %pix2) nounwind {
  %1 = getelementptr inbounds [16 x i16]* %dct, i32 0, i32 0
  tail call void @sub4x4_dct(i16* %1, i8* %pix1, i8* %pix2) nounwind
  %2 = getelementptr inbounds [16 x i16]* %dct, i32 1, i32 0
  %3 = getelementptr inbounds i8* %pix1, i32 4
  %4 = getelementptr inbounds i8* %pix2, i32 4
  tail call void @sub4x4_dct(i16* %2, i8* %3, i8* %4) nounwind
  %5 = getelementptr inbounds [16 x i16]* %dct, i32 2, i32 0
  %6 = getelementptr inbounds i8* %pix1, i32 64
  %7 = getelementptr inbounds i8* %pix2, i32 128
  tail call void @sub4x4_dct(i16* %5, i8* %6, i8* %7) nounwind
  %8 = getelementptr inbounds [16 x i16]* %dct, i32 3, i32 0
  %9 = getelementptr inbounds i8* %pix1, i32 68
  %10 = getelementptr inbounds i8* %pix2, i32 132
  tail call void @sub4x4_dct(i16* %8, i8* %9, i8* %10) nounwind
  %11 = getelementptr inbounds i8* %pix1, i32 8
  %12 = getelementptr inbounds i8* %pix2, i32 8
  %13 = getelementptr inbounds [16 x i16]* %dct, i32 4, i32 0
  tail call void @sub4x4_dct(i16* %13, i8* %11, i8* %12) nounwind
  %14 = getelementptr inbounds [16 x i16]* %dct, i32 5, i32 0
  %15 = getelementptr inbounds i8* %pix1, i32 12
  %16 = getelementptr inbounds i8* %pix2, i32 12
  tail call void @sub4x4_dct(i16* %14, i8* %15, i8* %16) nounwind
  %17 = getelementptr inbounds [16 x i16]* %dct, i32 6, i32 0
  %18 = getelementptr inbounds i8* %pix1, i32 72
  %19 = getelementptr inbounds i8* %pix2, i32 136
  tail call void @sub4x4_dct(i16* %17, i8* %18, i8* %19) nounwind
  %20 = getelementptr inbounds [16 x i16]* %dct, i32 7, i32 0
  %21 = getelementptr inbounds i8* %pix1, i32 76
  %22 = getelementptr inbounds i8* %pix2, i32 140
  tail call void @sub4x4_dct(i16* %20, i8* %21, i8* %22) nounwind
  %23 = getelementptr inbounds i8* %pix1, i32 128
  %24 = getelementptr inbounds i8* %pix2, i32 256
  %25 = getelementptr inbounds [16 x i16]* %dct, i32 8, i32 0
  tail call void @sub4x4_dct(i16* %25, i8* %23, i8* %24) nounwind
  %26 = getelementptr inbounds [16 x i16]* %dct, i32 9, i32 0
  %27 = getelementptr inbounds i8* %pix1, i32 132
  %28 = getelementptr inbounds i8* %pix2, i32 260
  tail call void @sub4x4_dct(i16* %26, i8* %27, i8* %28) nounwind
  %29 = getelementptr inbounds [16 x i16]* %dct, i32 10, i32 0
  %30 = getelementptr inbounds i8* %pix1, i32 192
  %31 = getelementptr inbounds i8* %pix2, i32 384
  tail call void @sub4x4_dct(i16* %29, i8* %30, i8* %31) nounwind
  %32 = getelementptr inbounds [16 x i16]* %dct, i32 11, i32 0
  %33 = getelementptr inbounds i8* %pix1, i32 196
  %34 = getelementptr inbounds i8* %pix2, i32 388
  tail call void @sub4x4_dct(i16* %32, i8* %33, i8* %34) nounwind
  %35 = getelementptr inbounds i8* %pix1, i32 136
  %36 = getelementptr inbounds i8* %pix2, i32 264
  %37 = getelementptr inbounds [16 x i16]* %dct, i32 12, i32 0
  tail call void @sub4x4_dct(i16* %37, i8* %35, i8* %36) nounwind
  %38 = getelementptr inbounds [16 x i16]* %dct, i32 13, i32 0
  %39 = getelementptr inbounds i8* %pix1, i32 140
  %40 = getelementptr inbounds i8* %pix2, i32 268
  tail call void @sub4x4_dct(i16* %38, i8* %39, i8* %40) nounwind
  %41 = getelementptr inbounds [16 x i16]* %dct, i32 14, i32 0
  %42 = getelementptr inbounds i8* %pix1, i32 200
  %43 = getelementptr inbounds i8* %pix2, i32 392
  tail call void @sub4x4_dct(i16* %41, i8* %42, i8* %43) nounwind
  %44 = getelementptr inbounds [16 x i16]* %dct, i32 15, i32 0
  %45 = getelementptr inbounds i8* %pix1, i32 204
  %46 = getelementptr inbounds i8* %pix2, i32 396
  tail call void @sub4x4_dct(i16* %44, i8* %45, i8* %46) nounwind
  ret void
}

define i32 @sub4x4_dct_dc(i8* nocapture %pix1, i8* nocapture %pix2) nounwind readonly {
  %scevgep = getelementptr i8* %pix1, i32 1
  %scevgep11 = getelementptr i8* %pix1, i32 2
  %1 = load i8* %pix1, align 1
  %2 = load i8* %scevgep, align 1
  %scevgep13 = getelementptr i8* %pix1, i32 3
  %3 = zext i8 %1 to i32
  %4 = zext i8 %2 to i32
  %5 = load i8* %scevgep11, align 1
  %6 = zext i8 %5 to i32
  %7 = load i8* %scevgep13, align 1
  %8 = add nsw i32 %3, %4
  %scevgep17 = getelementptr i8* %pix2, i32 1
  %9 = zext i8 %7 to i32
  %10 = load i8* %pix2, align 1
  %11 = add nsw i32 %8, %6
  %scevgep19 = getelementptr i8* %pix2, i32 2
  %12 = zext i8 %10 to i32
  %13 = load i8* %scevgep17, align 1
  %14 = add i32 %11, %9
  %scevgep21 = getelementptr i8* %pix2, i32 3
  %15 = zext i8 %13 to i32
  %16 = load i8* %scevgep19, align 1
  %17 = sub i32 %14, %12
  %.08.1 = getelementptr i8* %pix1, i32 16
  %18 = zext i8 %16 to i32
  %19 = load i8* %scevgep21, align 1
  %20 = sub i32 %17, %15
  %21 = load i8* %.08.1, align 1
  %scevgep.1 = getelementptr i8* %pix1, i32 17
  %22 = zext i8 %19 to i32
  %23 = sub i32 %20, %18
  %24 = load i8* %scevgep.1, align 1
  %25 = zext i8 %21 to i32
  %scevgep11.1 = getelementptr i8* %pix1, i32 18
  %26 = sub i32 %23, %22
  %27 = add nsw i32 %25, %26
  %28 = load i8* %scevgep11.1, align 1
  %29 = zext i8 %24 to i32
  %scevgep13.1 = getelementptr i8* %pix1, i32 19
  %30 = add nsw i32 %27, %29
  %31 = load i8* %scevgep13.1, align 1
  %32 = zext i8 %28 to i32
  %.017.1 = getelementptr i8* %pix2, i32 32
  %33 = add nsw i32 %30, %32
  %34 = load i8* %.017.1, align 1
  %35 = zext i8 %31 to i32
  %scevgep17.1 = getelementptr i8* %pix2, i32 33
  %36 = add i32 %33, %35
  %37 = load i8* %scevgep17.1, align 1
  %38 = zext i8 %34 to i32
  %scevgep19.1 = getelementptr i8* %pix2, i32 34
  %39 = sub i32 %36, %38
  %40 = load i8* %scevgep19.1, align 1
  %41 = zext i8 %37 to i32
  %scevgep21.1 = getelementptr i8* %pix2, i32 35
  %42 = sub i32 %39, %41
  %43 = load i8* %scevgep21.1, align 1
  %44 = zext i8 %40 to i32
  %.08.2 = getelementptr i8* %pix1, i32 32
  %45 = sub i32 %42, %44
  %46 = zext i8 %43 to i32
  %scevgep.2 = getelementptr i8* %pix1, i32 33
  %47 = load i8* %.08.2, align 1
  %48 = sub i32 %45, %46
  %scevgep11.2 = getelementptr i8* %pix1, i32 34
  %49 = zext i8 %47 to i32
  %50 = load i8* %scevgep.2, align 1
  %scevgep13.2 = getelementptr i8* %pix1, i32 35
  %51 = zext i8 %50 to i32
  %52 = load i8* %scevgep11.2, align 1
  %53 = add nsw i32 %49, %48
  %.017.2 = getelementptr i8* %pix2, i32 64
  %54 = zext i8 %52 to i32
  %55 = load i8* %scevgep13.2, align 1
  %56 = add nsw i32 %53, %51
  %scevgep17.2 = getelementptr i8* %pix2, i32 65
  %57 = zext i8 %55 to i32
  %58 = load i8* %.017.2, align 1
  %59 = add nsw i32 %56, %54
  %scevgep19.2 = getelementptr i8* %pix2, i32 66
  %60 = zext i8 %58 to i32
  %61 = load i8* %scevgep17.2, align 1
  %62 = add i32 %59, %57
  %scevgep21.2 = getelementptr i8* %pix2, i32 67
  %63 = zext i8 %61 to i32
  %64 = load i8* %scevgep19.2, align 1
  %65 = sub i32 %62, %60
  %.08.3 = getelementptr i8* %pix1, i32 48
  %66 = zext i8 %64 to i32
  %67 = load i8* %scevgep21.2, align 1
  %68 = sub i32 %65, %63
  %69 = load i8* %.08.3, align 1
  %scevgep.3 = getelementptr i8* %pix1, i32 49
  %70 = zext i8 %67 to i32
  %71 = sub i32 %68, %66
  %72 = load i8* %scevgep.3, align 1
  %73 = zext i8 %69 to i32
  %scevgep11.3 = getelementptr i8* %pix1, i32 50
  %74 = sub i32 %71, %70
  %75 = add nsw i32 %73, %74
  %76 = load i8* %scevgep11.3, align 1
  %77 = zext i8 %72 to i32
  %scevgep13.3 = getelementptr i8* %pix1, i32 51
  %78 = add nsw i32 %75, %77
  %79 = load i8* %scevgep13.3, align 1
  %80 = zext i8 %76 to i32
  %.017.3 = getelementptr i8* %pix2, i32 96
  %81 = add nsw i32 %78, %80
  %82 = load i8* %.017.3, align 1
  %83 = zext i8 %79 to i32
  %scevgep17.3 = getelementptr i8* %pix2, i32 97
  %84 = add i32 %81, %83
  %85 = load i8* %scevgep17.3, align 1
  %86 = zext i8 %82 to i32
  %scevgep19.3 = getelementptr i8* %pix2, i32 98
  %87 = sub i32 %84, %86
  %88 = load i8* %scevgep19.3, align 1
  %89 = zext i8 %85 to i32
  %scevgep21.3 = getelementptr i8* %pix2, i32 99
  %90 = sub i32 %87, %89
  %91 = load i8* %scevgep21.3, align 1
  %92 = zext i8 %88 to i32
  %93 = sub i32 %90, %92
  %94 = zext i8 %91 to i32
  %95 = sub i32 %93, %94
  ret i32 %95
}

define void @sub8x8_dct_dc(i16* nocapture %dct, i8* nocapture %pix1, i8* nocapture %pix2) nounwind {
  %1 = tail call i32 @sub4x4_dct_dc(i8* %pix1, i8* %pix2)
  %2 = trunc i32 %1 to i16
  store i16 %2, i16* %dct, align 2
  %3 = getelementptr inbounds i8* %pix1, i32 4
  %4 = getelementptr inbounds i8* %pix2, i32 4
  %5 = tail call i32 @sub4x4_dct_dc(i8* %3, i8* %4)
  %6 = trunc i32 %5 to i16
  %7 = getelementptr inbounds i16* %dct, i32 1
  store i16 %6, i16* %7, align 2
  %8 = getelementptr inbounds i8* %pix1, i32 64
  %9 = getelementptr inbounds i8* %pix2, i32 128
  %10 = tail call i32 @sub4x4_dct_dc(i8* %8, i8* %9)
  %11 = trunc i32 %10 to i16
  %12 = getelementptr inbounds i16* %dct, i32 2
  store i16 %11, i16* %12, align 2
  %13 = getelementptr inbounds i8* %pix1, i32 68
  %14 = getelementptr inbounds i8* %pix2, i32 132
  %15 = tail call i32 @sub4x4_dct_dc(i8* %13, i8* %14)
  %16 = getelementptr inbounds i16* %dct, i32 3
  %17 = sext i16 %2 to i32
  %18 = sext i16 %6 to i32
  %19 = add nsw i32 %18, %17
  %20 = sext i16 %11 to i32
  %sext = shl i32 %15, 16
  %21 = ashr i32 %sext, 16
  %22 = add nsw i32 %21, %20
  %23 = sub nsw i32 %17, %18
  %24 = sub nsw i32 %20, %21
  %25 = add nsw i32 %22, %19
  %26 = trunc i32 %25 to i16
  store i16 %26, i16* %dct, align 2
  %27 = sub nsw i32 %19, %22
  %28 = trunc i32 %27 to i16
  store i16 %28, i16* %7, align 2
  %29 = add nsw i32 %24, %23
  %30 = trunc i32 %29 to i16
  store i16 %30, i16* %12, align 2
  %31 = sub nsw i32 %23, %24
  %32 = trunc i32 %31 to i16
  store i16 %32, i16* %16, align 2
  ret void
}

define void @sub8x16_dct_dc(i16* nocapture %dct, i8* nocapture %pix1, i8* nocapture %pix2) nounwind {
  %1 = tail call i32 @sub4x4_dct_dc(i8* %pix1, i8* %pix2)
  %2 = getelementptr inbounds i8* %pix1, i32 4
  %3 = getelementptr inbounds i8* %pix2, i32 4
  %4 = tail call i32 @sub4x4_dct_dc(i8* %2, i8* %3)
  %5 = getelementptr inbounds i8* %pix1, i32 64
  %6 = getelementptr inbounds i8* %pix2, i32 128
  %7 = tail call i32 @sub4x4_dct_dc(i8* %5, i8* %6)
  %8 = getelementptr inbounds i8* %pix1, i32 68
  %9 = getelementptr inbounds i8* %pix2, i32 132
  %10 = tail call i32 @sub4x4_dct_dc(i8* %8, i8* %9)
  %11 = getelementptr inbounds i8* %pix1, i32 128
  %12 = getelementptr inbounds i8* %pix2, i32 256
  %13 = tail call i32 @sub4x4_dct_dc(i8* %11, i8* %12)
  %14 = getelementptr inbounds i8* %pix1, i32 132
  %15 = getelementptr inbounds i8* %pix2, i32 260
  %16 = tail call i32 @sub4x4_dct_dc(i8* %14, i8* %15)
  %17 = getelementptr inbounds i8* %pix1, i32 192
  %18 = getelementptr inbounds i8* %pix2, i32 384
  %19 = tail call i32 @sub4x4_dct_dc(i8* %17, i8* %18)
  %20 = getelementptr inbounds i8* %pix1, i32 196
  %21 = getelementptr inbounds i8* %pix2, i32 388
  %22 = tail call i32 @sub4x4_dct_dc(i8* %20, i8* %21)
  %23 = add nsw i32 %4, %1
  %24 = add nsw i32 %10, %7
  %25 = add nsw i32 %16, %13
  %26 = add nsw i32 %22, %19
  %27 = sub nsw i32 %1, %4
  %28 = sub nsw i32 %7, %10
  %29 = sub nsw i32 %13, %16
  %30 = sub nsw i32 %19, %22
  %31 = add nsw i32 %24, %23
  %32 = add nsw i32 %26, %25
  %33 = add nsw i32 %28, %27
  %34 = add nsw i32 %30, %29
  %35 = sub nsw i32 %23, %24
  %36 = sub nsw i32 %25, %26
  %37 = sub nsw i32 %27, %28
  %38 = sub nsw i32 %29, %30
  %39 = add nsw i32 %32, %31
  %40 = trunc i32 %39 to i16
  store i16 %40, i16* %dct, align 2
  %41 = add nsw i32 %34, %33
  %42 = trunc i32 %41 to i16
  %43 = getelementptr inbounds i16* %dct, i32 1
  store i16 %42, i16* %43, align 2
  %44 = sub nsw i32 %31, %32
  %45 = trunc i32 %44 to i16
  %46 = getelementptr inbounds i16* %dct, i32 2
  store i16 %45, i16* %46, align 2
  %47 = sub nsw i32 %33, %34
  %48 = trunc i32 %47 to i16
  %49 = getelementptr inbounds i16* %dct, i32 3
  store i16 %48, i16* %49, align 2
  %50 = sub nsw i32 %35, %36
  %51 = trunc i32 %50 to i16
  %52 = getelementptr inbounds i16* %dct, i32 4
  store i16 %51, i16* %52, align 2
  %53 = sub nsw i32 %37, %38
  %54 = trunc i32 %53 to i16
  %55 = getelementptr inbounds i16* %dct, i32 5
  store i16 %54, i16* %55, align 2
  %56 = add nsw i32 %36, %35
  %57 = trunc i32 %56 to i16
  %58 = getelementptr inbounds i16* %dct, i32 6
  store i16 %57, i16* %58, align 2
  %59 = add nsw i32 %38, %37
  %60 = trunc i32 %59 to i16
  %61 = getelementptr inbounds i16* %dct, i32 7
  store i16 %60, i16* %61, align 2
  ret void
}

define void @add4x4_idct(i8* nocapture %p_dst, i16* nocapture %dct) nounwind {
bb.nph17:
  %d = alloca [16 x i16], align 2
  %tmp = alloca [16 x i16], align 2
  br label %0

; <label>:0                                       ; preds = %0, %bb.nph17
  %i.016 = phi i32 [ 0, %bb.nph17 ], [ %23, %0 ]
  %scevgep52 = getelementptr i16* %dct, i32 %i.016
  %tmp53 = shl i32 %i.016, 2
  %scevgep54 = getelementptr [16 x i16]* %tmp, i32 0, i32 %tmp53
  %tmp5567 = or i32 %tmp53, 1
  %scevgep56 = getelementptr [16 x i16]* %tmp, i32 0, i32 %tmp5567
  %tmp5768 = or i32 %tmp53, 2
  %scevgep58 = getelementptr [16 x i16]* %tmp, i32 0, i32 %tmp5768
  %tmp5969 = or i32 %tmp53, 3
  %scevgep60 = getelementptr [16 x i16]* %tmp, i32 0, i32 %tmp5969
  %tmp61 = add i32 %i.016, 8
  %scevgep62 = getelementptr i16* %dct, i32 %tmp61
  %tmp63 = add i32 %i.016, 4
  %scevgep64 = getelementptr i16* %dct, i32 %tmp63
  %tmp65 = add i32 %i.016, 12
  %scevgep66 = getelementptr i16* %dct, i32 %tmp65
  %1 = load i16* %scevgep52, align 2
  %2 = sext i16 %1 to i32
  %3 = load i16* %scevgep62, align 2
  %4 = sext i16 %3 to i32
  %5 = add nsw i32 %4, %2
  %6 = sub nsw i32 %2, %4
  %7 = load i16* %scevgep64, align 2
  %8 = sext i16 %7 to i32
  %9 = load i16* %scevgep66, align 2
  %10 = sext i16 %9 to i32
  %11 = ashr i32 %10, 1
  %12 = add nsw i32 %11, %8
  %13 = ashr i32 %8, 1
  %14 = sub nsw i32 %13, %10
  %15 = add nsw i32 %12, %5
  %16 = trunc i32 %15 to i16
  store i16 %16, i16* %scevgep54, align 2
  %17 = add nsw i32 %14, %6
  %18 = trunc i32 %17 to i16
  store i16 %18, i16* %scevgep56, align 2
  %19 = sub nsw i32 %6, %14
  %20 = trunc i32 %19 to i16
  store i16 %20, i16* %scevgep58, align 2
  %21 = sub nsw i32 %5, %12
  %22 = trunc i32 %21 to i16
  store i16 %22, i16* %scevgep60, align 2
  %23 = add nsw i32 %i.016, 1
  %exitcond51 = icmp eq i32 %23, 4
  br i1 %exitcond51, label %bb.nph15, label %0

bb.nph15:                                         ; preds = %bb.nph15, %0
  %i1.014 = phi i32 [ %52, %bb.nph15 ], [ 0, %0 ]
  %scevgep40 = getelementptr [16 x i16]* %tmp, i32 0, i32 %i1.014
  %scevgep41 = getelementptr [16 x i16]* %d, i32 0, i32 %i1.014
  %tmp42 = add i32 %i1.014, 8
  %scevgep43 = getelementptr [16 x i16]* %tmp, i32 0, i32 %tmp42
  %tmp44 = add i32 %i1.014, 4
  %scevgep45 = getelementptr [16 x i16]* %tmp, i32 0, i32 %tmp44
  %tmp46 = add i32 %i1.014, 12
  %scevgep47 = getelementptr [16 x i16]* %tmp, i32 0, i32 %tmp46
  %scevgep48 = getelementptr [16 x i16]* %d, i32 0, i32 %tmp44
  %scevgep49 = getelementptr [16 x i16]* %d, i32 0, i32 %tmp42
  %scevgep50 = getelementptr [16 x i16]* %d, i32 0, i32 %tmp46
  %24 = load i16* %scevgep40, align 2
  %25 = sext i16 %24 to i32
  %26 = load i16* %scevgep43, align 2
  %27 = sext i16 %26 to i32
  %28 = add nsw i32 %27, %25
  %29 = sub nsw i32 %25, %27
  %30 = load i16* %scevgep45, align 2
  %31 = sext i16 %30 to i32
  %32 = load i16* %scevgep47, align 2
  %33 = sext i16 %32 to i32
  %34 = ashr i32 %33, 1
  %35 = add nsw i32 %34, %31
  %36 = ashr i32 %31, 1
  %37 = sub nsw i32 %36, %33
  %38 = add nsw i32 %28, 32
  %39 = add nsw i32 %38, %35
  %40 = lshr i32 %39, 6
  %41 = trunc i32 %40 to i16
  store i16 %41, i16* %scevgep41, align 2
  %42 = add nsw i32 %29, 32
  %43 = add nsw i32 %42, %37
  %44 = lshr i32 %43, 6
  %45 = trunc i32 %44 to i16
  store i16 %45, i16* %scevgep48, align 2
  %46 = sub i32 %42, %37
  %47 = lshr i32 %46, 6
  %48 = trunc i32 %47 to i16
  store i16 %48, i16* %scevgep49, align 2
  %49 = sub i32 %38, %35
  %50 = lshr i32 %49, 6
  %51 = trunc i32 %50 to i16
  store i16 %51, i16* %scevgep50, align 2
  %52 = add nsw i32 %i1.014, 1
  %exitcond39 = icmp eq i32 %52, 4
  br i1 %exitcond39, label %bb.nph, label %bb.nph15

bb.nph:                                           ; preds = %71, %bb.nph15
  %y.09 = phi i32 [ %74, %71 ], [ 0, %bb.nph15 ]
  %tmp23 = shl i32 %y.09, 2
  %tmp2470 = or i32 %tmp23, 3
  %scevgep22.3 = getelementptr [16 x i16]* %d, i32 0, i32 %tmp2470
  %tmp2671 = or i32 %tmp23, 2
  %scevgep22.2 = getelementptr [16 x i16]* %d, i32 0, i32 %tmp2671
  %tmp2872 = or i32 %tmp23, 1
  %scevgep22.1 = getelementptr [16 x i16]* %d, i32 0, i32 %tmp2872
  %tmp31 = shl i32 %y.09, 5
  %tmp3273 = or i32 %tmp31, 3
  %scevgep.3 = getelementptr i8* %p_dst, i32 %tmp3273
  %tmp3474 = or i32 %tmp31, 2
  %scevgep.2 = getelementptr i8* %p_dst, i32 %tmp3474
  %tmp3675 = or i32 %tmp31, 1
  %scevgep.1 = getelementptr i8* %p_dst, i32 %tmp3675
  %scevgep = getelementptr i8* %p_dst, i32 %tmp31
  %scevgep22 = getelementptr [16 x i16]* %d, i32 0, i32 %tmp23
  %53 = load i8* %scevgep, align 1
  %54 = zext i8 %53 to i32
  %55 = load i16* %scevgep22, align 2
  %56 = sext i16 %55 to i32
  %57 = add nsw i32 %56, %54
  %58 = icmp ugt i32 %57, 255
  br i1 %58, label %59, label %x264_clip_pixel.exit

; <label>:59                                      ; preds = %bb.nph
  %60 = sub nsw i32 0, %57
  %61 = ashr i32 %60, 31
  %62 = and i32 %61, 255
  br label %x264_clip_pixel.exit

x264_clip_pixel.exit:                             ; preds = %59, %bb.nph
  %63 = phi i32 [ %62, %59 ], [ %57, %bb.nph ]
  %64 = trunc i32 %63 to i8
  store i8 %64, i8* %scevgep, align 1
  %65 = load i8* %scevgep.1, align 1
  %66 = zext i8 %65 to i32
  %67 = load i16* %scevgep22.1, align 2
  %68 = sext i16 %67 to i32
  %69 = add nsw i32 %68, %66
  %70 = icmp ugt i32 %69, 255
  br i1 %70, label %83, label %x264_clip_pixel.exit.1

; <label>:71                                      ; preds = %99, %x264_clip_pixel.exit.2
  %72 = phi i32 [ %102, %99 ], [ %93, %x264_clip_pixel.exit.2 ]
  %73 = trunc i32 %72 to i8
  store i8 %73, i8* %scevgep.3, align 1
  %74 = add nsw i32 %y.09, 1
  %exitcond = icmp eq i32 %74, 4
  br i1 %exitcond, label %._crit_edge12, label %bb.nph

._crit_edge12:                                    ; preds = %71
  ret void

x264_clip_pixel.exit.1:                           ; preds = %83, %x264_clip_pixel.exit
  %75 = phi i32 [ %86, %83 ], [ %69, %x264_clip_pixel.exit ]
  %76 = trunc i32 %75 to i8
  store i8 %76, i8* %scevgep.1, align 1
  %77 = load i8* %scevgep.2, align 1
  %78 = zext i8 %77 to i32
  %79 = load i16* %scevgep22.2, align 2
  %80 = sext i16 %79 to i32
  %81 = add nsw i32 %80, %78
  %82 = icmp ugt i32 %81, 255
  br i1 %82, label %95, label %x264_clip_pixel.exit.2

; <label>:83                                      ; preds = %x264_clip_pixel.exit
  %84 = sub nsw i32 0, %69
  %85 = ashr i32 %84, 31
  %86 = and i32 %85, 255
  br label %x264_clip_pixel.exit.1

x264_clip_pixel.exit.2:                           ; preds = %95, %x264_clip_pixel.exit.1
  %87 = phi i32 [ %98, %95 ], [ %81, %x264_clip_pixel.exit.1 ]
  %88 = trunc i32 %87 to i8
  store i8 %88, i8* %scevgep.2, align 1
  %89 = load i8* %scevgep.3, align 1
  %90 = zext i8 %89 to i32
  %91 = load i16* %scevgep22.3, align 2
  %92 = sext i16 %91 to i32
  %93 = add nsw i32 %92, %90
  %94 = icmp ugt i32 %93, 255
  br i1 %94, label %99, label %71

; <label>:95                                      ; preds = %x264_clip_pixel.exit.1
  %96 = sub nsw i32 0, %81
  %97 = ashr i32 %96, 31
  %98 = and i32 %97, 255
  br label %x264_clip_pixel.exit.2

; <label>:99                                      ; preds = %x264_clip_pixel.exit.2
  %100 = sub nsw i32 0, %93
  %101 = ashr i32 %100, 31
  %102 = and i32 %101, 255
  br label %71
}

define void @add8x8_idct(i8* nocapture %p_dst, [16 x i16]* nocapture %dct) nounwind {
  %1 = getelementptr inbounds [16 x i16]* %dct, i32 0, i32 0
  tail call void @add4x4_idct(i8* %p_dst, i16* %1)
  %2 = getelementptr inbounds i8* %p_dst, i32 4
  %3 = getelementptr inbounds [16 x i16]* %dct, i32 1, i32 0
  tail call void @add4x4_idct(i8* %2, i16* %3)
  %4 = getelementptr inbounds i8* %p_dst, i32 128
  %5 = getelementptr inbounds [16 x i16]* %dct, i32 2, i32 0
  tail call void @add4x4_idct(i8* %4, i16* %5)
  %6 = getelementptr inbounds i8* %p_dst, i32 132
  %7 = getelementptr inbounds [16 x i16]* %dct, i32 3, i32 0
  tail call void @add4x4_idct(i8* %6, i16* %7)
  ret void
}

define void @add16x16_idct(i8* nocapture %p_dst, [16 x i16]* nocapture %dct) nounwind {
  %1 = getelementptr inbounds [16 x i16]* %dct, i32 0, i32 0
  tail call void @add4x4_idct(i8* %p_dst, i16* %1) nounwind
  %2 = getelementptr inbounds i8* %p_dst, i32 4
  %3 = getelementptr inbounds [16 x i16]* %dct, i32 1, i32 0
  tail call void @add4x4_idct(i8* %2, i16* %3) nounwind
  %4 = getelementptr inbounds i8* %p_dst, i32 128
  %5 = getelementptr inbounds [16 x i16]* %dct, i32 2, i32 0
  tail call void @add4x4_idct(i8* %4, i16* %5) nounwind
  %6 = getelementptr inbounds i8* %p_dst, i32 132
  %7 = getelementptr inbounds [16 x i16]* %dct, i32 3, i32 0
  tail call void @add4x4_idct(i8* %6, i16* %7) nounwind
  %8 = getelementptr inbounds i8* %p_dst, i32 8
  %9 = getelementptr inbounds [16 x i16]* %dct, i32 4, i32 0
  tail call void @add4x4_idct(i8* %8, i16* %9) nounwind
  %10 = getelementptr inbounds i8* %p_dst, i32 12
  %11 = getelementptr inbounds [16 x i16]* %dct, i32 5, i32 0
  tail call void @add4x4_idct(i8* %10, i16* %11) nounwind
  %12 = getelementptr inbounds i8* %p_dst, i32 136
  %13 = getelementptr inbounds [16 x i16]* %dct, i32 6, i32 0
  tail call void @add4x4_idct(i8* %12, i16* %13) nounwind
  %14 = getelementptr inbounds i8* %p_dst, i32 140
  %15 = getelementptr inbounds [16 x i16]* %dct, i32 7, i32 0
  tail call void @add4x4_idct(i8* %14, i16* %15) nounwind
  %16 = getelementptr inbounds i8* %p_dst, i32 256
  %17 = getelementptr inbounds [16 x i16]* %dct, i32 8, i32 0
  tail call void @add4x4_idct(i8* %16, i16* %17) nounwind
  %18 = getelementptr inbounds i8* %p_dst, i32 260
  %19 = getelementptr inbounds [16 x i16]* %dct, i32 9, i32 0
  tail call void @add4x4_idct(i8* %18, i16* %19) nounwind
  %20 = getelementptr inbounds i8* %p_dst, i32 384
  %21 = getelementptr inbounds [16 x i16]* %dct, i32 10, i32 0
  tail call void @add4x4_idct(i8* %20, i16* %21) nounwind
  %22 = getelementptr inbounds i8* %p_dst, i32 388
  %23 = getelementptr inbounds [16 x i16]* %dct, i32 11, i32 0
  tail call void @add4x4_idct(i8* %22, i16* %23) nounwind
  %24 = getelementptr inbounds i8* %p_dst, i32 264
  %25 = getelementptr inbounds [16 x i16]* %dct, i32 12, i32 0
  tail call void @add4x4_idct(i8* %24, i16* %25) nounwind
  %26 = getelementptr inbounds i8* %p_dst, i32 268
  %27 = getelementptr inbounds [16 x i16]* %dct, i32 13, i32 0
  tail call void @add4x4_idct(i8* %26, i16* %27) nounwind
  %28 = getelementptr inbounds i8* %p_dst, i32 392
  %29 = getelementptr inbounds [16 x i16]* %dct, i32 14, i32 0
  tail call void @add4x4_idct(i8* %28, i16* %29) nounwind
  %30 = getelementptr inbounds i8* %p_dst, i32 396
  %31 = getelementptr inbounds [16 x i16]* %dct, i32 15, i32 0
  tail call void @add4x4_idct(i8* %30, i16* %31) nounwind
  ret void
}

define void @sub8x8_dct8(i16* nocapture %dct, i8* nocapture %pix1, i8* nocapture %pix2) nounwind {
; <label>:0
  %tmp = alloca [64 x i16], align 2
  br label %bb.nph.us.i

bb.nph.us.i:                                      ; preds = %bb.nph.us.i, %0
  %y.05.us.i = phi i32 [ %41, %bb.nph.us.i ], [ 0, %0 ]
  %tmp90 = shl i32 %y.05.us.i, 4
  %tmp106 = shl i32 %y.05.us.i, 5
  %tmp122 = shl i32 %y.05.us.i, 3
  %tmp135158 = or i32 %tmp122, 1
  %tmp133157 = or i32 %tmp122, 2
  %tmp131156 = or i32 %tmp122, 3
  %tmp129155 = or i32 %tmp122, 4
  %tmp127154 = or i32 %tmp122, 5
  %tmp125153 = or i32 %tmp122, 6
  %tmp123152 = or i32 %tmp122, 7
  %tmp119151 = or i32 %tmp106, 1
  %tmp117150 = or i32 %tmp106, 2
  %tmp115149 = or i32 %tmp106, 3
  %tmp113148 = or i32 %tmp106, 4
  %tmp111147 = or i32 %tmp106, 5
  %tmp109146 = or i32 %tmp106, 6
  %tmp107145 = or i32 %tmp106, 7
  %tmp103144 = or i32 %tmp90, 1
  %tmp101143 = or i32 %tmp90, 2
  %tmp99142 = or i32 %tmp90, 3
  %tmp97141 = or i32 %tmp90, 4
  %tmp95140 = or i32 %tmp90, 5
  %tmp93139 = or i32 %tmp90, 6
  %tmp91138 = or i32 %tmp90, 7
  %scevgep.i = getelementptr [64 x i16]* %tmp, i32 0, i32 %tmp122
  %scevgep.i.1 = getelementptr [64 x i16]* %tmp, i32 0, i32 %tmp135158
  %scevgep.i.2 = getelementptr [64 x i16]* %tmp, i32 0, i32 %tmp133157
  %scevgep.i.3 = getelementptr [64 x i16]* %tmp, i32 0, i32 %tmp131156
  %scevgep.i.4 = getelementptr [64 x i16]* %tmp, i32 0, i32 %tmp129155
  %scevgep.i.5 = getelementptr [64 x i16]* %tmp, i32 0, i32 %tmp127154
  %scevgep.i.6 = getelementptr [64 x i16]* %tmp, i32 0, i32 %tmp125153
  %scevgep.i.7 = getelementptr [64 x i16]* %tmp, i32 0, i32 %tmp123152
  %scevgep11.i = getelementptr i8* %pix2, i32 %tmp106
  %scevgep11.i.1 = getelementptr i8* %pix2, i32 %tmp119151
  %scevgep11.i.2 = getelementptr i8* %pix2, i32 %tmp117150
  %scevgep11.i.3 = getelementptr i8* %pix2, i32 %tmp115149
  %scevgep11.i.4 = getelementptr i8* %pix2, i32 %tmp113148
  %scevgep11.i.5 = getelementptr i8* %pix2, i32 %tmp111147
  %scevgep11.i.6 = getelementptr i8* %pix2, i32 %tmp109146
  %scevgep11.i.7 = getelementptr i8* %pix2, i32 %tmp107145
  %scevgep14.i = getelementptr i8* %pix1, i32 %tmp90
  %scevgep14.i.1 = getelementptr i8* %pix1, i32 %tmp103144
  %scevgep14.i.2 = getelementptr i8* %pix1, i32 %tmp101143
  %scevgep14.i.3 = getelementptr i8* %pix1, i32 %tmp99142
  %scevgep14.i.4 = getelementptr i8* %pix1, i32 %tmp97141
  %scevgep14.i.5 = getelementptr i8* %pix1, i32 %tmp95140
  %scevgep14.i.6 = getelementptr i8* %pix1, i32 %tmp93139
  %scevgep14.i.7 = getelementptr i8* %pix1, i32 %tmp91138
  %1 = load i8* %scevgep14.i, align 1
  %2 = zext i8 %1 to i16
  %3 = load i8* %scevgep11.i, align 1
  %4 = zext i8 %3 to i16
  %5 = sub i16 %2, %4
  store i16 %5, i16* %scevgep.i, align 2
  %6 = load i8* %scevgep14.i.1, align 1
  %7 = zext i8 %6 to i16
  %8 = load i8* %scevgep11.i.1, align 1
  %9 = zext i8 %8 to i16
  %10 = sub i16 %7, %9
  store i16 %10, i16* %scevgep.i.1, align 2
  %11 = load i8* %scevgep14.i.2, align 1
  %12 = zext i8 %11 to i16
  %13 = load i8* %scevgep11.i.2, align 1
  %14 = zext i8 %13 to i16
  %15 = sub i16 %12, %14
  store i16 %15, i16* %scevgep.i.2, align 2
  %16 = load i8* %scevgep14.i.3, align 1
  %17 = zext i8 %16 to i16
  %18 = load i8* %scevgep11.i.3, align 1
  %19 = zext i8 %18 to i16
  %20 = sub i16 %17, %19
  store i16 %20, i16* %scevgep.i.3, align 2
  %21 = load i8* %scevgep14.i.4, align 1
  %22 = zext i8 %21 to i16
  %23 = load i8* %scevgep11.i.4, align 1
  %24 = zext i8 %23 to i16
  %25 = sub i16 %22, %24
  store i16 %25, i16* %scevgep.i.4, align 2
  %26 = load i8* %scevgep14.i.5, align 1
  %27 = zext i8 %26 to i16
  %28 = load i8* %scevgep11.i.5, align 1
  %29 = zext i8 %28 to i16
  %30 = sub i16 %27, %29
  store i16 %30, i16* %scevgep.i.5, align 2
  %31 = load i8* %scevgep14.i.6, align 1
  %32 = zext i8 %31 to i16
  %33 = load i8* %scevgep11.i.6, align 1
  %34 = zext i8 %33 to i16
  %35 = sub i16 %32, %34
  store i16 %35, i16* %scevgep.i.6, align 2
  %36 = load i8* %scevgep14.i.7, align 1
  %37 = zext i8 %36 to i16
  %38 = load i8* %scevgep11.i.7, align 1
  %39 = zext i8 %38 to i16
  %40 = sub i16 %37, %39
  store i16 %40, i16* %scevgep.i.7, align 2
  %41 = add nsw i32 %y.05.us.i, 1
  %exitcond89 = icmp eq i32 %41, 8
  br i1 %exitcond89, label %pixel_sub_wxh.exit, label %bb.nph.us.i

pixel_sub_wxh.exit:                               ; preds = %pixel_sub_wxh.exit, %bb.nph.us.i
  %i.030 = phi i32 [ %106, %pixel_sub_wxh.exit ], [ 0, %bb.nph.us.i ]
  %scevgep64 = getelementptr [64 x i16]* %tmp, i32 0, i32 %i.030
  %tmp65 = add i32 %i.030, 56
  %scevgep66 = getelementptr [64 x i16]* %tmp, i32 0, i32 %tmp65
  %tmp67 = add i32 %i.030, 8
  %scevgep68 = getelementptr [64 x i16]* %tmp, i32 0, i32 %tmp67
  %tmp69 = add i32 %i.030, 48
  %scevgep70 = getelementptr [64 x i16]* %tmp, i32 0, i32 %tmp69
  %tmp71 = add i32 %i.030, 16
  %scevgep72 = getelementptr [64 x i16]* %tmp, i32 0, i32 %tmp71
  %tmp73 = add i32 %i.030, 40
  %scevgep74 = getelementptr [64 x i16]* %tmp, i32 0, i32 %tmp73
  %tmp75 = add i32 %i.030, 24
  %scevgep76 = getelementptr [64 x i16]* %tmp, i32 0, i32 %tmp75
  %tmp77 = add i32 %i.030, 32
  %scevgep78 = getelementptr [64 x i16]* %tmp, i32 0, i32 %tmp77
  %42 = load i16* %scevgep64, align 2
  %43 = sext i16 %42 to i32
  %44 = load i16* %scevgep66, align 2
  %45 = sext i16 %44 to i32
  %46 = add nsw i32 %45, %43
  %47 = load i16* %scevgep68, align 2
  %48 = sext i16 %47 to i32
  %49 = load i16* %scevgep70, align 2
  %50 = sext i16 %49 to i32
  %51 = add nsw i32 %50, %48
  %52 = load i16* %scevgep72, align 2
  %53 = sext i16 %52 to i32
  %54 = load i16* %scevgep74, align 2
  %55 = sext i16 %54 to i32
  %56 = add nsw i32 %55, %53
  %57 = load i16* %scevgep76, align 2
  %58 = sext i16 %57 to i32
  %59 = load i16* %scevgep78, align 2
  %60 = sext i16 %59 to i32
  %61 = add nsw i32 %60, %58
  %62 = add nsw i32 %61, %46
  %63 = add nsw i32 %56, %51
  %64 = sub nsw i32 %46, %61
  %65 = sub nsw i32 %51, %56
  %66 = sub nsw i32 %43, %45
  %67 = sub nsw i32 %48, %50
  %68 = sub nsw i32 %53, %55
  %69 = sub nsw i32 %58, %60
  %70 = ashr i32 %66, 1
  %71 = add nsw i32 %70, %66
  %72 = add nsw i32 %71, %67
  %73 = add nsw i32 %72, %68
  %74 = sub nsw i32 %66, %69
  %75 = ashr i32 %68, 1
  %sum = add i32 %75, %68
  %76 = sub i32 %74, %sum
  %77 = ashr i32 %67, 1
  %78 = sub i32 %66, %67
  %.neg22 = sub i32 %78, %77
  %79 = add i32 %.neg22, %69
  %80 = sub nsw i32 %67, %68
  %81 = ashr i32 %69, 1
  %82 = add nsw i32 %69, %80
  %83 = add nsw i32 %82, %81
  %84 = add nsw i32 %62, %63
  %85 = trunc i32 %84 to i16
  store i16 %85, i16* %scevgep64, align 2
  %86 = lshr i32 %83, 2
  %87 = add nsw i32 %86, %73
  %88 = trunc i32 %87 to i16
  store i16 %88, i16* %scevgep68, align 2
  %89 = lshr i32 %65, 1
  %90 = add nsw i32 %64, %89
  %91 = trunc i32 %90 to i16
  store i16 %91, i16* %scevgep72, align 2
  %92 = lshr i32 %79, 2
  %93 = add nsw i32 %76, %92
  %94 = trunc i32 %93 to i16
  store i16 %94, i16* %scevgep76, align 2
  %95 = sub nsw i32 %62, %63
  %96 = trunc i32 %95 to i16
  store i16 %96, i16* %scevgep78, align 2
  %97 = lshr i32 %76, 2
  %98 = sub nsw i32 %79, %97
  %99 = trunc i32 %98 to i16
  store i16 %99, i16* %scevgep74, align 2
  %100 = lshr i32 %64, 1
  %101 = sub nsw i32 %100, %65
  %102 = trunc i32 %101 to i16
  store i16 %102, i16* %scevgep70, align 2
  %103 = lshr i32 %73, 2
  %104 = sub nsw i32 %103, %83
  %105 = trunc i32 %104 to i16
  store i16 %105, i16* %scevgep66, align 2
  %106 = add nsw i32 %i.030, 1
  %exitcond63 = icmp eq i32 %106, 8
  br i1 %exitcond63, label %bb.nph, label %pixel_sub_wxh.exit

bb.nph:                                           ; preds = %bb.nph, %pixel_sub_wxh.exit
  %i1.029 = phi i32 [ %171, %bb.nph ], [ 0, %pixel_sub_wxh.exit ]
  %tmp33 = shl i32 %i1.029, 3
  %scevgep = getelementptr [64 x i16]* %tmp, i32 0, i32 %tmp33
  %tmp34159 = or i32 %tmp33, 7
  %scevgep35 = getelementptr [64 x i16]* %tmp, i32 0, i32 %tmp34159
  %tmp36160 = or i32 %tmp33, 1
  %scevgep37 = getelementptr [64 x i16]* %tmp, i32 0, i32 %tmp36160
  %tmp38161 = or i32 %tmp33, 6
  %scevgep39 = getelementptr [64 x i16]* %tmp, i32 0, i32 %tmp38161
  %tmp40162 = or i32 %tmp33, 2
  %scevgep41 = getelementptr [64 x i16]* %tmp, i32 0, i32 %tmp40162
  %tmp42163 = or i32 %tmp33, 5
  %scevgep43 = getelementptr [64 x i16]* %tmp, i32 0, i32 %tmp42163
  %tmp44164 = or i32 %tmp33, 3
  %scevgep45 = getelementptr [64 x i16]* %tmp, i32 0, i32 %tmp44164
  %tmp46165 = or i32 %tmp33, 4
  %scevgep47 = getelementptr [64 x i16]* %tmp, i32 0, i32 %tmp46165
  %scevgep48 = getelementptr i16* %dct, i32 %i1.029
  %tmp49 = add i32 %i1.029, 8
  %scevgep50 = getelementptr i16* %dct, i32 %tmp49
  %tmp51 = add i32 %i1.029, 16
  %scevgep52 = getelementptr i16* %dct, i32 %tmp51
  %tmp53 = add i32 %i1.029, 24
  %scevgep54 = getelementptr i16* %dct, i32 %tmp53
  %tmp55 = add i32 %i1.029, 32
  %scevgep56 = getelementptr i16* %dct, i32 %tmp55
  %tmp57 = add i32 %i1.029, 40
  %scevgep58 = getelementptr i16* %dct, i32 %tmp57
  %tmp59 = add i32 %i1.029, 48
  %scevgep60 = getelementptr i16* %dct, i32 %tmp59
  %tmp61 = add i32 %i1.029, 56
  %scevgep62 = getelementptr i16* %dct, i32 %tmp61
  %107 = load i16* %scevgep, align 2
  %108 = sext i16 %107 to i32
  %109 = load i16* %scevgep35, align 2
  %110 = sext i16 %109 to i32
  %111 = add nsw i32 %110, %108
  %112 = load i16* %scevgep37, align 2
  %113 = sext i16 %112 to i32
  %114 = load i16* %scevgep39, align 2
  %115 = sext i16 %114 to i32
  %116 = add nsw i32 %115, %113
  %117 = load i16* %scevgep41, align 2
  %118 = sext i16 %117 to i32
  %119 = load i16* %scevgep43, align 2
  %120 = sext i16 %119 to i32
  %121 = add nsw i32 %120, %118
  %122 = load i16* %scevgep45, align 2
  %123 = sext i16 %122 to i32
  %124 = load i16* %scevgep47, align 2
  %125 = sext i16 %124 to i32
  %126 = add nsw i32 %125, %123
  %127 = add nsw i32 %126, %111
  %128 = add nsw i32 %121, %116
  %129 = sub nsw i32 %111, %126
  %130 = sub nsw i32 %116, %121
  %131 = sub nsw i32 %108, %110
  %132 = sub nsw i32 %113, %115
  %133 = sub nsw i32 %118, %120
  %134 = sub nsw i32 %123, %125
  %135 = ashr i32 %131, 1
  %136 = add nsw i32 %135, %131
  %137 = add nsw i32 %136, %132
  %138 = add nsw i32 %137, %133
  %139 = sub nsw i32 %131, %134
  %140 = ashr i32 %133, 1
  %sum32 = add i32 %140, %133
  %141 = sub i32 %139, %sum32
  %142 = ashr i32 %132, 1
  %143 = sub i32 %131, %132
  %.neg28 = sub i32 %143, %142
  %144 = add i32 %.neg28, %134
  %145 = sub nsw i32 %132, %133
  %146 = ashr i32 %134, 1
  %147 = add nsw i32 %134, %145
  %148 = add nsw i32 %147, %146
  %149 = add nsw i32 %127, %128
  %150 = trunc i32 %149 to i16
  store i16 %150, i16* %scevgep48, align 2
  %151 = lshr i32 %148, 2
  %152 = add nsw i32 %151, %138
  %153 = trunc i32 %152 to i16
  store i16 %153, i16* %scevgep50, align 2
  %154 = lshr i32 %130, 1
  %155 = add nsw i32 %129, %154
  %156 = trunc i32 %155 to i16
  store i16 %156, i16* %scevgep52, align 2
  %157 = lshr i32 %144, 2
  %158 = add nsw i32 %141, %157
  %159 = trunc i32 %158 to i16
  store i16 %159, i16* %scevgep54, align 2
  %160 = sub nsw i32 %127, %128
  %161 = trunc i32 %160 to i16
  store i16 %161, i16* %scevgep56, align 2
  %162 = lshr i32 %141, 2
  %163 = sub nsw i32 %144, %162
  %164 = trunc i32 %163 to i16
  store i16 %164, i16* %scevgep58, align 2
  %165 = lshr i32 %129, 1
  %166 = sub nsw i32 %165, %130
  %167 = trunc i32 %166 to i16
  store i16 %167, i16* %scevgep60, align 2
  %168 = lshr i32 %138, 2
  %169 = sub nsw i32 %168, %148
  %170 = trunc i32 %169 to i16
  store i16 %170, i16* %scevgep62, align 2
  %171 = add nsw i32 %i1.029, 1
  %exitcond = icmp eq i32 %171, 8
  br i1 %exitcond, label %._crit_edge, label %bb.nph

._crit_edge:                                      ; preds = %bb.nph
  ret void
}

define void @sub16x16_dct8([64 x i16]* nocapture %dct, i8* nocapture %pix1, i8* nocapture %pix2) nounwind {
  %1 = getelementptr inbounds [64 x i16]* %dct, i32 0, i32 0
  tail call void @sub8x8_dct8(i16* %1, i8* %pix1, i8* %pix2)
  %2 = getelementptr inbounds [64 x i16]* %dct, i32 1, i32 0
  %3 = getelementptr inbounds i8* %pix1, i32 8
  %4 = getelementptr inbounds i8* %pix2, i32 8
  tail call void @sub8x8_dct8(i16* %2, i8* %3, i8* %4)
  %5 = getelementptr inbounds [64 x i16]* %dct, i32 2, i32 0
  %6 = getelementptr inbounds i8* %pix1, i32 128
  %7 = getelementptr inbounds i8* %pix2, i32 256
  tail call void @sub8x8_dct8(i16* %5, i8* %6, i8* %7)
  %8 = getelementptr inbounds [64 x i16]* %dct, i32 3, i32 0
  %9 = getelementptr inbounds i8* %pix1, i32 136
  %10 = getelementptr inbounds i8* %pix2, i32 264
  tail call void @sub8x8_dct8(i16* %8, i8* %9, i8* %10)
  ret void
}

define void @add8x8_idct8(i8* nocapture %dst, i16* nocapture %dct) nounwind {
bb.nph38:
  %0 = load i16* %dct, align 2
  %1 = add i16 %0, 32
  store i16 %1, i16* %dct, align 2
  br label %2

; <label>:2                                       ; preds = %._crit_edge91, %bb.nph38
  %3 = phi i16 [ %1, %bb.nph38 ], [ %.pre, %._crit_edge91 ]
  %i.037 = phi i32 [ 0, %bb.nph38 ], [ %69, %._crit_edge91 ]
  %scevgep69 = getelementptr i16* %dct, i32 %i.037
  %tmp70 = add i32 %i.037, 32
  %scevgep71 = getelementptr i16* %dct, i32 %tmp70
  %tmp72 = add i32 %i.037, 16
  %scevgep73 = getelementptr i16* %dct, i32 %tmp72
  %tmp74 = add i32 %i.037, 48
  %scevgep75 = getelementptr i16* %dct, i32 %tmp74
  %tmp76 = add i32 %i.037, 24
  %scevgep77 = getelementptr i16* %dct, i32 %tmp76
  %tmp78 = add i32 %i.037, 40
  %scevgep79 = getelementptr i16* %dct, i32 %tmp78
  %tmp80 = add i32 %i.037, 56
  %scevgep81 = getelementptr i16* %dct, i32 %tmp80
  %tmp82 = add i32 %i.037, 8
  %scevgep83 = getelementptr i16* %dct, i32 %tmp82
  %4 = sext i16 %3 to i32
  %5 = load i16* %scevgep71, align 2
  %6 = sext i16 %5 to i32
  %7 = add nsw i32 %6, %4
  %8 = sub nsw i32 %4, %6
  %9 = load i16* %scevgep73, align 2
  %10 = sext i16 %9 to i32
  %11 = ashr i32 %10, 1
  %12 = load i16* %scevgep75, align 2
  %13 = sext i16 %12 to i32
  %14 = sub nsw i32 %11, %13
  %15 = ashr i32 %13, 1
  %16 = add nsw i32 %15, %10
  %17 = add nsw i32 %16, %7
  %18 = add nsw i32 %14, %8
  %19 = sub nsw i32 %8, %14
  %20 = sub nsw i32 %7, %16
  %21 = load i16* %scevgep77, align 2
  %22 = sext i16 %21 to i32
  %23 = load i16* %scevgep79, align 2
  %24 = sext i16 %23 to i32
  %25 = load i16* %scevgep81, align 2
  %26 = sext i16 %25 to i32
  %27 = ashr i32 %26, 1
  %28 = sub i32 %24, %22
  %29 = sub i32 %28, %26
  %30 = sub i32 %29, %27
  %31 = load i16* %scevgep83, align 2
  %32 = sext i16 %31 to i32
  %33 = ashr i32 %22, 1
  %34 = add nsw i32 %26, %32
  %35 = sub i32 %34, %22
  %36 = sub i32 %35, %33
  %37 = ashr i32 %24, 1
  %38 = sub i32 %26, %32
  %39 = add nsw i32 %38, %24
  %40 = add nsw i32 %39, %37
  %41 = ashr i32 %32, 1
  %42 = add nsw i32 %24, %22
  %43 = add nsw i32 %42, %32
  %44 = add nsw i32 %43, %41
  %45 = ashr i32 %44, 2
  %46 = add nsw i32 %45, %30
  %47 = ashr i32 %40, 2
  %48 = add nsw i32 %47, %36
  %49 = ashr i32 %36, 2
  %50 = sub nsw i32 %49, %40
  %51 = ashr i32 %30, 2
  %52 = sub nsw i32 %44, %51
  %53 = add nsw i32 %52, %17
  %54 = trunc i32 %53 to i16
  store i16 %54, i16* %scevgep69, align 2
  %55 = add nsw i32 %50, %18
  %56 = trunc i32 %55 to i16
  store i16 %56, i16* %scevgep83, align 2
  %57 = add nsw i32 %48, %19
  %58 = trunc i32 %57 to i16
  store i16 %58, i16* %scevgep73, align 2
  %59 = add nsw i32 %46, %20
  %60 = trunc i32 %59 to i16
  store i16 %60, i16* %scevgep77, align 2
  %61 = sub nsw i32 %20, %46
  %62 = trunc i32 %61 to i16
  store i16 %62, i16* %scevgep71, align 2
  %63 = sub nsw i32 %19, %48
  %64 = trunc i32 %63 to i16
  store i16 %64, i16* %scevgep79, align 2
  %65 = sub nsw i32 %18, %50
  %66 = trunc i32 %65 to i16
  store i16 %66, i16* %scevgep75, align 2
  %67 = sub nsw i32 %17, %52
  %68 = trunc i32 %67 to i16
  store i16 %68, i16* %scevgep81, align 2
  %69 = add nsw i32 %i.037, 1
  %exitcond68 = icmp eq i32 %69, 8
  br i1 %exitcond68, label %bb.nph, label %._crit_edge91

._crit_edge91:                                    ; preds = %2
  %scevgep69.phi.trans.insert = getelementptr i16* %dct, i32 %69
  %.pre = load i16* %scevgep69.phi.trans.insert, align 2
  br label %2

bb.nph:                                           ; preds = %x264_clip_pixel.exit18, %2
  %i1.036 = phi i32 [ %216, %x264_clip_pixel.exit18 ], [ 0, %2 ]
  %tmp = shl i32 %i1.036, 3
  %scevgep = getelementptr i16* %dct, i32 %tmp
  %tmp3984 = or i32 %tmp, 4
  %scevgep40 = getelementptr i16* %dct, i32 %tmp3984
  %tmp4185 = or i32 %tmp, 2
  %scevgep42 = getelementptr i16* %dct, i32 %tmp4185
  %tmp4386 = or i32 %tmp, 6
  %scevgep44 = getelementptr i16* %dct, i32 %tmp4386
  %tmp4587 = or i32 %tmp, 3
  %scevgep46 = getelementptr i16* %dct, i32 %tmp4587
  %tmp4788 = or i32 %tmp, 5
  %scevgep48 = getelementptr i16* %dct, i32 %tmp4788
  %tmp4989 = or i32 %tmp, 7
  %scevgep50 = getelementptr i16* %dct, i32 %tmp4989
  %tmp5190 = or i32 %tmp, 1
  %scevgep52 = getelementptr i16* %dct, i32 %tmp5190
  %scevgep53 = getelementptr i8* %dst, i32 %i1.036
  %tmp54 = add i32 %i1.036, 32
  %scevgep55 = getelementptr i8* %dst, i32 %tmp54
  %tmp56 = add i32 %i1.036, 64
  %scevgep57 = getelementptr i8* %dst, i32 %tmp56
  %tmp58 = add i32 %i1.036, 96
  %scevgep59 = getelementptr i8* %dst, i32 %tmp58
  %tmp60 = add i32 %i1.036, 128
  %scevgep61 = getelementptr i8* %dst, i32 %tmp60
  %tmp62 = add i32 %i1.036, 160
  %scevgep63 = getelementptr i8* %dst, i32 %tmp62
  %tmp64 = add i32 %i1.036, 192
  %scevgep65 = getelementptr i8* %dst, i32 %tmp64
  %tmp66 = add i32 %i1.036, 224
  %scevgep67 = getelementptr i8* %dst, i32 %tmp66
  %70 = load i16* %scevgep, align 2
  %71 = sext i16 %70 to i32
  %72 = load i16* %scevgep40, align 2
  %73 = sext i16 %72 to i32
  %74 = add nsw i32 %73, %71
  %75 = sub nsw i32 %71, %73
  %76 = load i16* %scevgep42, align 2
  %77 = sext i16 %76 to i32
  %78 = ashr i32 %77, 1
  %79 = load i16* %scevgep44, align 2
  %80 = sext i16 %79 to i32
  %81 = sub nsw i32 %78, %80
  %82 = ashr i32 %80, 1
  %83 = add nsw i32 %82, %77
  %84 = add nsw i32 %83, %74
  %85 = add nsw i32 %81, %75
  %86 = sub nsw i32 %75, %81
  %87 = sub nsw i32 %74, %83
  %88 = load i16* %scevgep46, align 2
  %89 = sext i16 %88 to i32
  %90 = load i16* %scevgep48, align 2
  %91 = sext i16 %90 to i32
  %92 = load i16* %scevgep50, align 2
  %93 = sext i16 %92 to i32
  %94 = ashr i32 %93, 1
  %95 = sub i32 %91, %89
  %96 = sub i32 %95, %93
  %97 = sub i32 %96, %94
  %98 = load i16* %scevgep52, align 2
  %99 = sext i16 %98 to i32
  %100 = ashr i32 %89, 1
  %101 = add nsw i32 %93, %99
  %102 = sub i32 %101, %89
  %103 = sub i32 %102, %100
  %104 = ashr i32 %91, 1
  %105 = sub i32 %93, %99
  %106 = add nsw i32 %105, %91
  %107 = add nsw i32 %106, %104
  %108 = ashr i32 %99, 1
  %109 = add nsw i32 %91, %89
  %110 = add nsw i32 %109, %99
  %111 = add nsw i32 %110, %108
  %112 = ashr i32 %111, 2
  %113 = add nsw i32 %112, %97
  %114 = ashr i32 %107, 2
  %115 = add nsw i32 %114, %103
  %116 = ashr i32 %103, 2
  %117 = sub nsw i32 %116, %107
  %118 = ashr i32 %97, 2
  %119 = sub nsw i32 %111, %118
  %120 = load i8* %scevgep53, align 1
  %121 = zext i8 %120 to i32
  %122 = add nsw i32 %119, %84
  %123 = ashr i32 %122, 6
  %124 = add nsw i32 %123, %121
  %125 = icmp ugt i32 %124, 255
  br i1 %125, label %126, label %x264_clip_pixel.exit

; <label>:126                                     ; preds = %bb.nph
  %127 = sub nsw i32 0, %124
  %128 = ashr i32 %127, 31
  %129 = and i32 %128, 255
  br label %x264_clip_pixel.exit

x264_clip_pixel.exit:                             ; preds = %126, %bb.nph
  %130 = phi i32 [ %129, %126 ], [ %124, %bb.nph ]
  %131 = trunc i32 %130 to i8
  store i8 %131, i8* %scevgep53, align 1
  %132 = load i8* %scevgep55, align 1
  %133 = zext i8 %132 to i32
  %134 = add nsw i32 %117, %85
  %135 = ashr i32 %134, 6
  %136 = add nsw i32 %133, %135
  %137 = icmp ugt i32 %136, 255
  br i1 %137, label %138, label %x264_clip_pixel.exit24

; <label>:138                                     ; preds = %x264_clip_pixel.exit
  %139 = sub nsw i32 0, %136
  %140 = ashr i32 %139, 31
  %141 = and i32 %140, 255
  br label %x264_clip_pixel.exit24

x264_clip_pixel.exit24:                           ; preds = %138, %x264_clip_pixel.exit
  %142 = phi i32 [ %141, %138 ], [ %136, %x264_clip_pixel.exit ]
  %143 = trunc i32 %142 to i8
  store i8 %143, i8* %scevgep55, align 1
  %144 = load i8* %scevgep57, align 1
  %145 = zext i8 %144 to i32
  %146 = add nsw i32 %115, %86
  %147 = ashr i32 %146, 6
  %148 = add nsw i32 %145, %147
  %149 = icmp ugt i32 %148, 255
  br i1 %149, label %150, label %x264_clip_pixel.exit23

; <label>:150                                     ; preds = %x264_clip_pixel.exit24
  %151 = sub nsw i32 0, %148
  %152 = ashr i32 %151, 31
  %153 = and i32 %152, 255
  br label %x264_clip_pixel.exit23

x264_clip_pixel.exit23:                           ; preds = %150, %x264_clip_pixel.exit24
  %154 = phi i32 [ %153, %150 ], [ %148, %x264_clip_pixel.exit24 ]
  %155 = trunc i32 %154 to i8
  store i8 %155, i8* %scevgep57, align 1
  %156 = load i8* %scevgep59, align 1
  %157 = zext i8 %156 to i32
  %158 = add nsw i32 %113, %87
  %159 = ashr i32 %158, 6
  %160 = add nsw i32 %157, %159
  %161 = icmp ugt i32 %160, 255
  br i1 %161, label %162, label %x264_clip_pixel.exit22

; <label>:162                                     ; preds = %x264_clip_pixel.exit23
  %163 = sub nsw i32 0, %160
  %164 = ashr i32 %163, 31
  %165 = and i32 %164, 255
  br label %x264_clip_pixel.exit22

x264_clip_pixel.exit22:                           ; preds = %162, %x264_clip_pixel.exit23
  %166 = phi i32 [ %165, %162 ], [ %160, %x264_clip_pixel.exit23 ]
  %167 = trunc i32 %166 to i8
  store i8 %167, i8* %scevgep59, align 1
  %168 = load i8* %scevgep61, align 1
  %169 = zext i8 %168 to i32
  %170 = sub nsw i32 %87, %113
  %171 = ashr i32 %170, 6
  %172 = add nsw i32 %169, %171
  %173 = icmp ugt i32 %172, 255
  br i1 %173, label %174, label %x264_clip_pixel.exit21

; <label>:174                                     ; preds = %x264_clip_pixel.exit22
  %175 = sub nsw i32 0, %172
  %176 = ashr i32 %175, 31
  %177 = and i32 %176, 255
  br label %x264_clip_pixel.exit21

x264_clip_pixel.exit21:                           ; preds = %174, %x264_clip_pixel.exit22
  %178 = phi i32 [ %177, %174 ], [ %172, %x264_clip_pixel.exit22 ]
  %179 = trunc i32 %178 to i8
  store i8 %179, i8* %scevgep61, align 1
  %180 = load i8* %scevgep63, align 1
  %181 = zext i8 %180 to i32
  %182 = sub nsw i32 %86, %115
  %183 = ashr i32 %182, 6
  %184 = add nsw i32 %181, %183
  %185 = icmp ugt i32 %184, 255
  br i1 %185, label %186, label %x264_clip_pixel.exit20

; <label>:186                                     ; preds = %x264_clip_pixel.exit21
  %187 = sub nsw i32 0, %184
  %188 = ashr i32 %187, 31
  %189 = and i32 %188, 255
  br label %x264_clip_pixel.exit20

x264_clip_pixel.exit20:                           ; preds = %186, %x264_clip_pixel.exit21
  %190 = phi i32 [ %189, %186 ], [ %184, %x264_clip_pixel.exit21 ]
  %191 = trunc i32 %190 to i8
  store i8 %191, i8* %scevgep63, align 1
  %192 = load i8* %scevgep65, align 1
  %193 = zext i8 %192 to i32
  %194 = sub nsw i32 %85, %117
  %195 = ashr i32 %194, 6
  %196 = add nsw i32 %193, %195
  %197 = icmp ugt i32 %196, 255
  br i1 %197, label %198, label %x264_clip_pixel.exit19

; <label>:198                                     ; preds = %x264_clip_pixel.exit20
  %199 = sub nsw i32 0, %196
  %200 = ashr i32 %199, 31
  %201 = and i32 %200, 255
  br label %x264_clip_pixel.exit19

x264_clip_pixel.exit19:                           ; preds = %198, %x264_clip_pixel.exit20
  %202 = phi i32 [ %201, %198 ], [ %196, %x264_clip_pixel.exit20 ]
  %203 = trunc i32 %202 to i8
  store i8 %203, i8* %scevgep65, align 1
  %204 = load i8* %scevgep67, align 1
  %205 = zext i8 %204 to i32
  %206 = sub nsw i32 %84, %119
  %207 = ashr i32 %206, 6
  %208 = add nsw i32 %205, %207
  %209 = icmp ugt i32 %208, 255
  br i1 %209, label %210, label %x264_clip_pixel.exit18

; <label>:210                                     ; preds = %x264_clip_pixel.exit19
  %211 = sub nsw i32 0, %208
  %212 = ashr i32 %211, 31
  %213 = and i32 %212, 255
  br label %x264_clip_pixel.exit18

x264_clip_pixel.exit18:                           ; preds = %210, %x264_clip_pixel.exit19
  %214 = phi i32 [ %213, %210 ], [ %208, %x264_clip_pixel.exit19 ]
  %215 = trunc i32 %214 to i8
  store i8 %215, i8* %scevgep67, align 1
  %216 = add nsw i32 %i1.036, 1
  %exitcond = icmp eq i32 %216, 8
  br i1 %exitcond, label %._crit_edge, label %bb.nph

._crit_edge:                                      ; preds = %x264_clip_pixel.exit18
  ret void
}

define void @add16x16_idct8(i8* nocapture %dst, [64 x i16]* nocapture %dct) nounwind {
  %1 = getelementptr inbounds [64 x i16]* %dct, i32 0, i32 0
  tail call void @add8x8_idct8(i8* %dst, i16* %1)
  %2 = getelementptr inbounds i8* %dst, i32 8
  %3 = getelementptr inbounds [64 x i16]* %dct, i32 1, i32 0
  tail call void @add8x8_idct8(i8* %2, i16* %3)
  %4 = getelementptr inbounds i8* %dst, i32 256
  %5 = getelementptr inbounds [64 x i16]* %dct, i32 2, i32 0
  tail call void @add8x8_idct8(i8* %4, i16* %5)
  %6 = getelementptr inbounds i8* %dst, i32 264
  %7 = getelementptr inbounds [64 x i16]* %dct, i32 3, i32 0
  tail call void @add8x8_idct8(i8* %6, i16* %7)
  ret void
}

define void @add8x8_idct_dc(i8* nocapture %p_dst, i16* nocapture %dct) nounwind {
; <label>:0
  %1 = load i16* %dct, align 2
  %2 = sext i16 %1 to i32
  %3 = shl i32 %2, 10
  %4 = add i32 %3, 32768
  %5 = ashr i32 %4, 16
  br label %6

; <label>:6                                       ; preds = %x264_clip_pixel.exit1.i, %0
  %i.04.i = phi i32 [ 0, %0 ], [ %47, %x264_clip_pixel.exit1.i ]
  %tmp74 = shl i32 %i.04.i, 5
  %tmp7578 = or i32 %tmp74, 3
  %scevgep10.i = getelementptr i8* %p_dst, i32 %tmp7578
  %tmp7679 = or i32 %tmp74, 2
  %scevgep8.i = getelementptr i8* %p_dst, i32 %tmp7679
  %tmp7780 = or i32 %tmp74, 1
  %scevgep.i = getelementptr i8* %p_dst, i32 %tmp7780
  %.05.i = getelementptr i8* %p_dst, i32 %tmp74
  %7 = load i8* %.05.i, align 1
  %8 = zext i8 %7 to i32
  %9 = add nsw i32 %8, %5
  %10 = icmp ugt i32 %9, 255
  br i1 %10, label %11, label %x264_clip_pixel.exit.i

; <label>:11                                      ; preds = %6
  %12 = sub nsw i32 0, %9
  %13 = ashr i32 %12, 31
  %14 = and i32 %13, 255
  br label %x264_clip_pixel.exit.i

x264_clip_pixel.exit.i:                           ; preds = %11, %6
  %15 = phi i32 [ %14, %11 ], [ %9, %6 ]
  %16 = trunc i32 %15 to i8
  store i8 %16, i8* %.05.i, align 1
  %17 = load i8* %scevgep.i, align 1
  %18 = zext i8 %17 to i32
  %19 = add nsw i32 %18, %5
  %20 = icmp ugt i32 %19, 255
  br i1 %20, label %21, label %x264_clip_pixel.exit3.i

; <label>:21                                      ; preds = %x264_clip_pixel.exit.i
  %22 = sub nsw i32 0, %19
  %23 = ashr i32 %22, 31
  %24 = and i32 %23, 255
  br label %x264_clip_pixel.exit3.i

x264_clip_pixel.exit3.i:                          ; preds = %21, %x264_clip_pixel.exit.i
  %25 = phi i32 [ %24, %21 ], [ %19, %x264_clip_pixel.exit.i ]
  %26 = trunc i32 %25 to i8
  store i8 %26, i8* %scevgep.i, align 1
  %27 = load i8* %scevgep8.i, align 1
  %28 = zext i8 %27 to i32
  %29 = add nsw i32 %28, %5
  %30 = icmp ugt i32 %29, 255
  br i1 %30, label %31, label %x264_clip_pixel.exit2.i

; <label>:31                                      ; preds = %x264_clip_pixel.exit3.i
  %32 = sub nsw i32 0, %29
  %33 = ashr i32 %32, 31
  %34 = and i32 %33, 255
  br label %x264_clip_pixel.exit2.i

x264_clip_pixel.exit2.i:                          ; preds = %31, %x264_clip_pixel.exit3.i
  %35 = phi i32 [ %34, %31 ], [ %29, %x264_clip_pixel.exit3.i ]
  %36 = trunc i32 %35 to i8
  store i8 %36, i8* %scevgep8.i, align 1
  %37 = load i8* %scevgep10.i, align 1
  %38 = zext i8 %37 to i32
  %39 = add nsw i32 %38, %5
  %40 = icmp ugt i32 %39, 255
  br i1 %40, label %41, label %x264_clip_pixel.exit1.i

; <label>:41                                      ; preds = %x264_clip_pixel.exit2.i
  %42 = sub nsw i32 0, %39
  %43 = ashr i32 %42, 31
  %44 = and i32 %43, 255
  br label %x264_clip_pixel.exit1.i

x264_clip_pixel.exit1.i:                          ; preds = %41, %x264_clip_pixel.exit2.i
  %45 = phi i32 [ %44, %41 ], [ %39, %x264_clip_pixel.exit2.i ]
  %46 = trunc i32 %45 to i8
  store i8 %46, i8* %scevgep10.i, align 1
  %47 = add nsw i32 %i.04.i, 1
  %exitcond73 = icmp eq i32 %47, 4
  br i1 %exitcond73, label %add4x4_idct_dc.exit, label %6

add4x4_idct_dc.exit:                              ; preds = %x264_clip_pixel.exit1.i
  %48 = getelementptr inbounds i16* %dct, i32 1
  %49 = load i16* %48, align 2
  %50 = sext i16 %49 to i32
  %51 = shl i32 %50, 10
  %52 = add i32 %51, 32768
  %53 = ashr i32 %52, 16
  br label %54

; <label>:54                                      ; preds = %x264_clip_pixel.exit1.i44, %add4x4_idct_dc.exit
  %i.04.i31 = phi i32 [ 0, %add4x4_idct_dc.exit ], [ %95, %x264_clip_pixel.exit1.i44 ]
  %tmp68 = shl i32 %i.04.i31, 5
  %tmp6981 = or i32 %tmp68, 4
  %.05.i39 = getelementptr i8* %p_dst, i32 %tmp6981
  %tmp7082 = or i32 %tmp68, 7
  %scevgep10.i38 = getelementptr i8* %p_dst, i32 %tmp7082
  %tmp7183 = or i32 %tmp68, 6
  %scevgep8.i36 = getelementptr i8* %p_dst, i32 %tmp7183
  %tmp7284 = or i32 %tmp68, 5
  %scevgep.i34 = getelementptr i8* %p_dst, i32 %tmp7284
  %55 = load i8* %.05.i39, align 1
  %56 = zext i8 %55 to i32
  %57 = add nsw i32 %56, %53
  %58 = icmp ugt i32 %57, 255
  br i1 %58, label %59, label %x264_clip_pixel.exit.i40

; <label>:59                                      ; preds = %54
  %60 = sub nsw i32 0, %57
  %61 = ashr i32 %60, 31
  %62 = and i32 %61, 255
  br label %x264_clip_pixel.exit.i40

x264_clip_pixel.exit.i40:                         ; preds = %59, %54
  %63 = phi i32 [ %62, %59 ], [ %57, %54 ]
  %64 = trunc i32 %63 to i8
  store i8 %64, i8* %.05.i39, align 1
  %65 = load i8* %scevgep.i34, align 1
  %66 = zext i8 %65 to i32
  %67 = add nsw i32 %66, %53
  %68 = icmp ugt i32 %67, 255
  br i1 %68, label %69, label %x264_clip_pixel.exit3.i41

; <label>:69                                      ; preds = %x264_clip_pixel.exit.i40
  %70 = sub nsw i32 0, %67
  %71 = ashr i32 %70, 31
  %72 = and i32 %71, 255
  br label %x264_clip_pixel.exit3.i41

x264_clip_pixel.exit3.i41:                        ; preds = %69, %x264_clip_pixel.exit.i40
  %73 = phi i32 [ %72, %69 ], [ %67, %x264_clip_pixel.exit.i40 ]
  %74 = trunc i32 %73 to i8
  store i8 %74, i8* %scevgep.i34, align 1
  %75 = load i8* %scevgep8.i36, align 1
  %76 = zext i8 %75 to i32
  %77 = add nsw i32 %76, %53
  %78 = icmp ugt i32 %77, 255
  br i1 %78, label %79, label %x264_clip_pixel.exit2.i42

; <label>:79                                      ; preds = %x264_clip_pixel.exit3.i41
  %80 = sub nsw i32 0, %77
  %81 = ashr i32 %80, 31
  %82 = and i32 %81, 255
  br label %x264_clip_pixel.exit2.i42

x264_clip_pixel.exit2.i42:                        ; preds = %79, %x264_clip_pixel.exit3.i41
  %83 = phi i32 [ %82, %79 ], [ %77, %x264_clip_pixel.exit3.i41 ]
  %84 = trunc i32 %83 to i8
  store i8 %84, i8* %scevgep8.i36, align 1
  %85 = load i8* %scevgep10.i38, align 1
  %86 = zext i8 %85 to i32
  %87 = add nsw i32 %86, %53
  %88 = icmp ugt i32 %87, 255
  br i1 %88, label %89, label %x264_clip_pixel.exit1.i44

; <label>:89                                      ; preds = %x264_clip_pixel.exit2.i42
  %90 = sub nsw i32 0, %87
  %91 = ashr i32 %90, 31
  %92 = and i32 %91, 255
  br label %x264_clip_pixel.exit1.i44

x264_clip_pixel.exit1.i44:                        ; preds = %89, %x264_clip_pixel.exit2.i42
  %93 = phi i32 [ %92, %89 ], [ %87, %x264_clip_pixel.exit2.i42 ]
  %94 = trunc i32 %93 to i8
  store i8 %94, i8* %scevgep10.i38, align 1
  %95 = add nsw i32 %i.04.i31, 1
  %exitcond67 = icmp eq i32 %95, 4
  br i1 %exitcond67, label %add4x4_idct_dc.exit45, label %54

add4x4_idct_dc.exit45:                            ; preds = %x264_clip_pixel.exit1.i44
  %96 = getelementptr inbounds i16* %dct, i32 2
  %97 = load i16* %96, align 2
  %98 = sext i16 %97 to i32
  %99 = shl i32 %98, 10
  %100 = add i32 %99, 32768
  %101 = ashr i32 %100, 16
  br label %102

; <label>:102                                     ; preds = %x264_clip_pixel.exit1.i29, %add4x4_idct_dc.exit45
  %i.04.i16 = phi i32 [ 0, %add4x4_idct_dc.exit45 ], [ %143, %x264_clip_pixel.exit1.i29 ]
  %tmp62 = shl i32 %i.04.i16, 5
  %tmp63 = add i32 %tmp62, 128
  %.05.i24 = getelementptr i8* %p_dst, i32 %tmp63
  %tmp64 = add i32 %tmp62, 131
  %scevgep10.i23 = getelementptr i8* %p_dst, i32 %tmp64
  %tmp65 = add i32 %tmp62, 130
  %scevgep8.i21 = getelementptr i8* %p_dst, i32 %tmp65
  %tmp66 = add i32 %tmp62, 129
  %scevgep.i19 = getelementptr i8* %p_dst, i32 %tmp66
  %103 = load i8* %.05.i24, align 1
  %104 = zext i8 %103 to i32
  %105 = add nsw i32 %104, %101
  %106 = icmp ugt i32 %105, 255
  br i1 %106, label %107, label %x264_clip_pixel.exit.i25

; <label>:107                                     ; preds = %102
  %108 = sub nsw i32 0, %105
  %109 = ashr i32 %108, 31
  %110 = and i32 %109, 255
  br label %x264_clip_pixel.exit.i25

x264_clip_pixel.exit.i25:                         ; preds = %107, %102
  %111 = phi i32 [ %110, %107 ], [ %105, %102 ]
  %112 = trunc i32 %111 to i8
  store i8 %112, i8* %.05.i24, align 1
  %113 = load i8* %scevgep.i19, align 1
  %114 = zext i8 %113 to i32
  %115 = add nsw i32 %114, %101
  %116 = icmp ugt i32 %115, 255
  br i1 %116, label %117, label %x264_clip_pixel.exit3.i26

; <label>:117                                     ; preds = %x264_clip_pixel.exit.i25
  %118 = sub nsw i32 0, %115
  %119 = ashr i32 %118, 31
  %120 = and i32 %119, 255
  br label %x264_clip_pixel.exit3.i26

x264_clip_pixel.exit3.i26:                        ; preds = %117, %x264_clip_pixel.exit.i25
  %121 = phi i32 [ %120, %117 ], [ %115, %x264_clip_pixel.exit.i25 ]
  %122 = trunc i32 %121 to i8
  store i8 %122, i8* %scevgep.i19, align 1
  %123 = load i8* %scevgep8.i21, align 1
  %124 = zext i8 %123 to i32
  %125 = add nsw i32 %124, %101
  %126 = icmp ugt i32 %125, 255
  br i1 %126, label %127, label %x264_clip_pixel.exit2.i27

; <label>:127                                     ; preds = %x264_clip_pixel.exit3.i26
  %128 = sub nsw i32 0, %125
  %129 = ashr i32 %128, 31
  %130 = and i32 %129, 255
  br label %x264_clip_pixel.exit2.i27

x264_clip_pixel.exit2.i27:                        ; preds = %127, %x264_clip_pixel.exit3.i26
  %131 = phi i32 [ %130, %127 ], [ %125, %x264_clip_pixel.exit3.i26 ]
  %132 = trunc i32 %131 to i8
  store i8 %132, i8* %scevgep8.i21, align 1
  %133 = load i8* %scevgep10.i23, align 1
  %134 = zext i8 %133 to i32
  %135 = add nsw i32 %134, %101
  %136 = icmp ugt i32 %135, 255
  br i1 %136, label %137, label %x264_clip_pixel.exit1.i29

; <label>:137                                     ; preds = %x264_clip_pixel.exit2.i27
  %138 = sub nsw i32 0, %135
  %139 = ashr i32 %138, 31
  %140 = and i32 %139, 255
  br label %x264_clip_pixel.exit1.i29

x264_clip_pixel.exit1.i29:                        ; preds = %137, %x264_clip_pixel.exit2.i27
  %141 = phi i32 [ %140, %137 ], [ %135, %x264_clip_pixel.exit2.i27 ]
  %142 = trunc i32 %141 to i8
  store i8 %142, i8* %scevgep10.i23, align 1
  %143 = add nsw i32 %i.04.i16, 1
  %exitcond61 = icmp eq i32 %143, 4
  br i1 %exitcond61, label %add4x4_idct_dc.exit30, label %102

add4x4_idct_dc.exit30:                            ; preds = %x264_clip_pixel.exit1.i29
  %144 = getelementptr inbounds i16* %dct, i32 3
  %145 = load i16* %144, align 2
  %146 = sext i16 %145 to i32
  %147 = shl i32 %146, 10
  %148 = add i32 %147, 32768
  %149 = ashr i32 %148, 16
  br label %150

; <label>:150                                     ; preds = %x264_clip_pixel.exit1.i14, %add4x4_idct_dc.exit30
  %i.04.i1 = phi i32 [ 0, %add4x4_idct_dc.exit30 ], [ %191, %x264_clip_pixel.exit1.i14 ]
  %tmp = shl i32 %i.04.i1, 5
  %tmp57 = add i32 %tmp, 132
  %.05.i9 = getelementptr i8* %p_dst, i32 %tmp57
  %tmp58 = add i32 %tmp, 135
  %scevgep10.i8 = getelementptr i8* %p_dst, i32 %tmp58
  %tmp59 = add i32 %tmp, 134
  %scevgep8.i6 = getelementptr i8* %p_dst, i32 %tmp59
  %tmp60 = add i32 %tmp, 133
  %scevgep.i4 = getelementptr i8* %p_dst, i32 %tmp60
  %151 = load i8* %.05.i9, align 1
  %152 = zext i8 %151 to i32
  %153 = add nsw i32 %152, %149
  %154 = icmp ugt i32 %153, 255
  br i1 %154, label %155, label %x264_clip_pixel.exit.i10

; <label>:155                                     ; preds = %150
  %156 = sub nsw i32 0, %153
  %157 = ashr i32 %156, 31
  %158 = and i32 %157, 255
  br label %x264_clip_pixel.exit.i10

x264_clip_pixel.exit.i10:                         ; preds = %155, %150
  %159 = phi i32 [ %158, %155 ], [ %153, %150 ]
  %160 = trunc i32 %159 to i8
  store i8 %160, i8* %.05.i9, align 1
  %161 = load i8* %scevgep.i4, align 1
  %162 = zext i8 %161 to i32
  %163 = add nsw i32 %162, %149
  %164 = icmp ugt i32 %163, 255
  br i1 %164, label %165, label %x264_clip_pixel.exit3.i11

; <label>:165                                     ; preds = %x264_clip_pixel.exit.i10
  %166 = sub nsw i32 0, %163
  %167 = ashr i32 %166, 31
  %168 = and i32 %167, 255
  br label %x264_clip_pixel.exit3.i11

x264_clip_pixel.exit3.i11:                        ; preds = %165, %x264_clip_pixel.exit.i10
  %169 = phi i32 [ %168, %165 ], [ %163, %x264_clip_pixel.exit.i10 ]
  %170 = trunc i32 %169 to i8
  store i8 %170, i8* %scevgep.i4, align 1
  %171 = load i8* %scevgep8.i6, align 1
  %172 = zext i8 %171 to i32
  %173 = add nsw i32 %172, %149
  %174 = icmp ugt i32 %173, 255
  br i1 %174, label %175, label %x264_clip_pixel.exit2.i12

; <label>:175                                     ; preds = %x264_clip_pixel.exit3.i11
  %176 = sub nsw i32 0, %173
  %177 = ashr i32 %176, 31
  %178 = and i32 %177, 255
  br label %x264_clip_pixel.exit2.i12

x264_clip_pixel.exit2.i12:                        ; preds = %175, %x264_clip_pixel.exit3.i11
  %179 = phi i32 [ %178, %175 ], [ %173, %x264_clip_pixel.exit3.i11 ]
  %180 = trunc i32 %179 to i8
  store i8 %180, i8* %scevgep8.i6, align 1
  %181 = load i8* %scevgep10.i8, align 1
  %182 = zext i8 %181 to i32
  %183 = add nsw i32 %182, %149
  %184 = icmp ugt i32 %183, 255
  br i1 %184, label %185, label %x264_clip_pixel.exit1.i14

; <label>:185                                     ; preds = %x264_clip_pixel.exit2.i12
  %186 = sub nsw i32 0, %183
  %187 = ashr i32 %186, 31
  %188 = and i32 %187, 255
  br label %x264_clip_pixel.exit1.i14

x264_clip_pixel.exit1.i14:                        ; preds = %185, %x264_clip_pixel.exit2.i12
  %189 = phi i32 [ %188, %185 ], [ %183, %x264_clip_pixel.exit2.i12 ]
  %190 = trunc i32 %189 to i8
  store i8 %190, i8* %scevgep10.i8, align 1
  %191 = add nsw i32 %i.04.i1, 1
  %exitcond = icmp eq i32 %191, 4
  br i1 %exitcond, label %add4x4_idct_dc.exit15, label %150

add4x4_idct_dc.exit15:                            ; preds = %x264_clip_pixel.exit1.i14
  ret void
}

define void @add16x16_idct_dc(i8* nocapture %p_dst, i16* nocapture %dct) nounwind {
bb.nph:
  br label %0

; <label>:0                                       ; preds = %add4x4_idct_dc.exit16, %bb.nph
  %i.059 = phi i32 [ 0, %bb.nph ], [ %189, %add4x4_idct_dc.exit16 ]
  %tmp104 = shl i32 %i.059, 2
  %tmp105163 = or i32 %tmp104, 1
  %scevgep = getelementptr i16* %dct, i32 %tmp105163
  %tmp106164 = or i32 %tmp104, 2
  %scevgep107 = getelementptr i16* %dct, i32 %tmp106164
  %tmp108165 = or i32 %tmp104, 3
  %scevgep109 = getelementptr i16* %dct, i32 %tmp108165
  %.0160 = getelementptr i16* %dct, i32 %tmp104
  %tmp112 = shl i32 %i.059, 7
  %tmp113166 = or i32 %tmp112, 13
  %tmp116167 = or i32 %tmp112, 14
  %tmp119168 = or i32 %tmp112, 15
  %tmp122169 = or i32 %tmp112, 12
  %tmp126170 = or i32 %tmp112, 9
  %tmp129171 = or i32 %tmp112, 10
  %tmp132172 = or i32 %tmp112, 11
  %tmp135173 = or i32 %tmp112, 8
  %tmp139174 = or i32 %tmp112, 5
  %tmp142175 = or i32 %tmp112, 6
  %tmp145176 = or i32 %tmp112, 7
  %tmp148177 = or i32 %tmp112, 4
  %tmp154178 = or i32 %tmp112, 1
  %tmp157179 = or i32 %tmp112, 2
  %tmp160180 = or i32 %tmp112, 3
  %1 = load i16* %.0160, align 2
  %2 = sext i16 %1 to i32
  %3 = shl i32 %2, 10
  %4 = add i32 %3, 32768
  %5 = ashr i32 %4, 16
  br label %6

; <label>:6                                       ; preds = %x264_clip_pixel.exit1.i, %0
  %i.04.i = phi i32 [ 0, %0 ], [ %47, %x264_clip_pixel.exit1.i ]
  %tmp151 = shl i32 %i.04.i, 5
  %tmp152 = add i32 %tmp112, %tmp151
  %.05.i = getelementptr i8* %p_dst, i32 %tmp152
  %tmp155 = add i32 %tmp154178, %tmp151
  %scevgep.i = getelementptr i8* %p_dst, i32 %tmp155
  %tmp158 = add i32 %tmp157179, %tmp151
  %scevgep8.i = getelementptr i8* %p_dst, i32 %tmp158
  %tmp161 = add i32 %tmp160180, %tmp151
  %scevgep10.i = getelementptr i8* %p_dst, i32 %tmp161
  %7 = load i8* %.05.i, align 1
  %8 = zext i8 %7 to i32
  %9 = add nsw i32 %8, %5
  %10 = icmp ugt i32 %9, 255
  br i1 %10, label %11, label %x264_clip_pixel.exit.i

; <label>:11                                      ; preds = %6
  %12 = sub nsw i32 0, %9
  %13 = ashr i32 %12, 31
  %14 = and i32 %13, 255
  br label %x264_clip_pixel.exit.i

x264_clip_pixel.exit.i:                           ; preds = %11, %6
  %15 = phi i32 [ %14, %11 ], [ %9, %6 ]
  %16 = trunc i32 %15 to i8
  store i8 %16, i8* %.05.i, align 1
  %17 = load i8* %scevgep.i, align 1
  %18 = zext i8 %17 to i32
  %19 = add nsw i32 %18, %5
  %20 = icmp ugt i32 %19, 255
  br i1 %20, label %21, label %x264_clip_pixel.exit3.i

; <label>:21                                      ; preds = %x264_clip_pixel.exit.i
  %22 = sub nsw i32 0, %19
  %23 = ashr i32 %22, 31
  %24 = and i32 %23, 255
  br label %x264_clip_pixel.exit3.i

x264_clip_pixel.exit3.i:                          ; preds = %21, %x264_clip_pixel.exit.i
  %25 = phi i32 [ %24, %21 ], [ %19, %x264_clip_pixel.exit.i ]
  %26 = trunc i32 %25 to i8
  store i8 %26, i8* %scevgep.i, align 1
  %27 = load i8* %scevgep8.i, align 1
  %28 = zext i8 %27 to i32
  %29 = add nsw i32 %28, %5
  %30 = icmp ugt i32 %29, 255
  br i1 %30, label %31, label %x264_clip_pixel.exit2.i

; <label>:31                                      ; preds = %x264_clip_pixel.exit3.i
  %32 = sub nsw i32 0, %29
  %33 = ashr i32 %32, 31
  %34 = and i32 %33, 255
  br label %x264_clip_pixel.exit2.i

x264_clip_pixel.exit2.i:                          ; preds = %31, %x264_clip_pixel.exit3.i
  %35 = phi i32 [ %34, %31 ], [ %29, %x264_clip_pixel.exit3.i ]
  %36 = trunc i32 %35 to i8
  store i8 %36, i8* %scevgep8.i, align 1
  %37 = load i8* %scevgep10.i, align 1
  %38 = zext i8 %37 to i32
  %39 = add nsw i32 %38, %5
  %40 = icmp ugt i32 %39, 255
  br i1 %40, label %41, label %x264_clip_pixel.exit1.i

; <label>:41                                      ; preds = %x264_clip_pixel.exit2.i
  %42 = sub nsw i32 0, %39
  %43 = ashr i32 %42, 31
  %44 = and i32 %43, 255
  br label %x264_clip_pixel.exit1.i

x264_clip_pixel.exit1.i:                          ; preds = %41, %x264_clip_pixel.exit2.i
  %45 = phi i32 [ %44, %41 ], [ %39, %x264_clip_pixel.exit2.i ]
  %46 = trunc i32 %45 to i8
  store i8 %46, i8* %scevgep10.i, align 1
  %47 = add nsw i32 %i.04.i, 1
  %exitcond = icmp eq i32 %47, 4
  br i1 %exitcond, label %add4x4_idct_dc.exit, label %6

add4x4_idct_dc.exit:                              ; preds = %x264_clip_pixel.exit1.i
  %48 = load i16* %scevgep, align 2
  %49 = sext i16 %48 to i32
  %50 = shl i32 %49, 10
  %51 = add i32 %50, 32768
  %52 = ashr i32 %51, 16
  br label %53

; <label>:53                                      ; preds = %x264_clip_pixel.exit1.i45, %add4x4_idct_dc.exit
  %i.04.i32 = phi i32 [ 0, %add4x4_idct_dc.exit ], [ %94, %x264_clip_pixel.exit1.i45 ]
  %tmp138 = shl i32 %i.04.i32, 5
  %tmp140 = add i32 %tmp139174, %tmp138
  %scevgep.i35 = getelementptr i8* %p_dst, i32 %tmp140
  %tmp143 = add i32 %tmp142175, %tmp138
  %scevgep8.i37 = getelementptr i8* %p_dst, i32 %tmp143
  %tmp146 = add i32 %tmp145176, %tmp138
  %scevgep10.i39 = getelementptr i8* %p_dst, i32 %tmp146
  %tmp149 = add i32 %tmp148177, %tmp138
  %.05.i40 = getelementptr i8* %p_dst, i32 %tmp149
  %54 = load i8* %.05.i40, align 1
  %55 = zext i8 %54 to i32
  %56 = add nsw i32 %55, %52
  %57 = icmp ugt i32 %56, 255
  br i1 %57, label %58, label %x264_clip_pixel.exit.i41

; <label>:58                                      ; preds = %53
  %59 = sub nsw i32 0, %56
  %60 = ashr i32 %59, 31
  %61 = and i32 %60, 255
  br label %x264_clip_pixel.exit.i41

x264_clip_pixel.exit.i41:                         ; preds = %58, %53
  %62 = phi i32 [ %61, %58 ], [ %56, %53 ]
  %63 = trunc i32 %62 to i8
  store i8 %63, i8* %.05.i40, align 1
  %64 = load i8* %scevgep.i35, align 1
  %65 = zext i8 %64 to i32
  %66 = add nsw i32 %65, %52
  %67 = icmp ugt i32 %66, 255
  br i1 %67, label %68, label %x264_clip_pixel.exit3.i42

; <label>:68                                      ; preds = %x264_clip_pixel.exit.i41
  %69 = sub nsw i32 0, %66
  %70 = ashr i32 %69, 31
  %71 = and i32 %70, 255
  br label %x264_clip_pixel.exit3.i42

x264_clip_pixel.exit3.i42:                        ; preds = %68, %x264_clip_pixel.exit.i41
  %72 = phi i32 [ %71, %68 ], [ %66, %x264_clip_pixel.exit.i41 ]
  %73 = trunc i32 %72 to i8
  store i8 %73, i8* %scevgep.i35, align 1
  %74 = load i8* %scevgep8.i37, align 1
  %75 = zext i8 %74 to i32
  %76 = add nsw i32 %75, %52
  %77 = icmp ugt i32 %76, 255
  br i1 %77, label %78, label %x264_clip_pixel.exit2.i43

; <label>:78                                      ; preds = %x264_clip_pixel.exit3.i42
  %79 = sub nsw i32 0, %76
  %80 = ashr i32 %79, 31
  %81 = and i32 %80, 255
  br label %x264_clip_pixel.exit2.i43

x264_clip_pixel.exit2.i43:                        ; preds = %78, %x264_clip_pixel.exit3.i42
  %82 = phi i32 [ %81, %78 ], [ %76, %x264_clip_pixel.exit3.i42 ]
  %83 = trunc i32 %82 to i8
  store i8 %83, i8* %scevgep8.i37, align 1
  %84 = load i8* %scevgep10.i39, align 1
  %85 = zext i8 %84 to i32
  %86 = add nsw i32 %85, %52
  %87 = icmp ugt i32 %86, 255
  br i1 %87, label %88, label %x264_clip_pixel.exit1.i45

; <label>:88                                      ; preds = %x264_clip_pixel.exit2.i43
  %89 = sub nsw i32 0, %86
  %90 = ashr i32 %89, 31
  %91 = and i32 %90, 255
  br label %x264_clip_pixel.exit1.i45

x264_clip_pixel.exit1.i45:                        ; preds = %88, %x264_clip_pixel.exit2.i43
  %92 = phi i32 [ %91, %88 ], [ %86, %x264_clip_pixel.exit2.i43 ]
  %93 = trunc i32 %92 to i8
  store i8 %93, i8* %scevgep10.i39, align 1
  %94 = add nsw i32 %i.04.i32, 1
  %exitcond70 = icmp eq i32 %94, 4
  br i1 %exitcond70, label %add4x4_idct_dc.exit46, label %53

add4x4_idct_dc.exit46:                            ; preds = %x264_clip_pixel.exit1.i45
  %95 = load i16* %scevgep107, align 2
  %96 = sext i16 %95 to i32
  %97 = shl i32 %96, 10
  %98 = add i32 %97, 32768
  %99 = ashr i32 %98, 16
  br label %100

; <label>:100                                     ; preds = %x264_clip_pixel.exit1.i30, %add4x4_idct_dc.exit46
  %i.04.i17 = phi i32 [ 0, %add4x4_idct_dc.exit46 ], [ %141, %x264_clip_pixel.exit1.i30 ]
  %tmp125 = shl i32 %i.04.i17, 5
  %tmp127 = add i32 %tmp126170, %tmp125
  %scevgep.i20 = getelementptr i8* %p_dst, i32 %tmp127
  %tmp130 = add i32 %tmp129171, %tmp125
  %scevgep8.i22 = getelementptr i8* %p_dst, i32 %tmp130
  %tmp133 = add i32 %tmp132172, %tmp125
  %scevgep10.i24 = getelementptr i8* %p_dst, i32 %tmp133
  %tmp136 = add i32 %tmp135173, %tmp125
  %.05.i25 = getelementptr i8* %p_dst, i32 %tmp136
  %101 = load i8* %.05.i25, align 1
  %102 = zext i8 %101 to i32
  %103 = add nsw i32 %102, %99
  %104 = icmp ugt i32 %103, 255
  br i1 %104, label %105, label %x264_clip_pixel.exit.i26

; <label>:105                                     ; preds = %100
  %106 = sub nsw i32 0, %103
  %107 = ashr i32 %106, 31
  %108 = and i32 %107, 255
  br label %x264_clip_pixel.exit.i26

x264_clip_pixel.exit.i26:                         ; preds = %105, %100
  %109 = phi i32 [ %108, %105 ], [ %103, %100 ]
  %110 = trunc i32 %109 to i8
  store i8 %110, i8* %.05.i25, align 1
  %111 = load i8* %scevgep.i20, align 1
  %112 = zext i8 %111 to i32
  %113 = add nsw i32 %112, %99
  %114 = icmp ugt i32 %113, 255
  br i1 %114, label %115, label %x264_clip_pixel.exit3.i27

; <label>:115                                     ; preds = %x264_clip_pixel.exit.i26
  %116 = sub nsw i32 0, %113
  %117 = ashr i32 %116, 31
  %118 = and i32 %117, 255
  br label %x264_clip_pixel.exit3.i27

x264_clip_pixel.exit3.i27:                        ; preds = %115, %x264_clip_pixel.exit.i26
  %119 = phi i32 [ %118, %115 ], [ %113, %x264_clip_pixel.exit.i26 ]
  %120 = trunc i32 %119 to i8
  store i8 %120, i8* %scevgep.i20, align 1
  %121 = load i8* %scevgep8.i22, align 1
  %122 = zext i8 %121 to i32
  %123 = add nsw i32 %122, %99
  %124 = icmp ugt i32 %123, 255
  br i1 %124, label %125, label %x264_clip_pixel.exit2.i28

; <label>:125                                     ; preds = %x264_clip_pixel.exit3.i27
  %126 = sub nsw i32 0, %123
  %127 = ashr i32 %126, 31
  %128 = and i32 %127, 255
  br label %x264_clip_pixel.exit2.i28

x264_clip_pixel.exit2.i28:                        ; preds = %125, %x264_clip_pixel.exit3.i27
  %129 = phi i32 [ %128, %125 ], [ %123, %x264_clip_pixel.exit3.i27 ]
  %130 = trunc i32 %129 to i8
  store i8 %130, i8* %scevgep8.i22, align 1
  %131 = load i8* %scevgep10.i24, align 1
  %132 = zext i8 %131 to i32
  %133 = add nsw i32 %132, %99
  %134 = icmp ugt i32 %133, 255
  br i1 %134, label %135, label %x264_clip_pixel.exit1.i30

; <label>:135                                     ; preds = %x264_clip_pixel.exit2.i28
  %136 = sub nsw i32 0, %133
  %137 = ashr i32 %136, 31
  %138 = and i32 %137, 255
  br label %x264_clip_pixel.exit1.i30

x264_clip_pixel.exit1.i30:                        ; preds = %135, %x264_clip_pixel.exit2.i28
  %139 = phi i32 [ %138, %135 ], [ %133, %x264_clip_pixel.exit2.i28 ]
  %140 = trunc i32 %139 to i8
  store i8 %140, i8* %scevgep10.i24, align 1
  %141 = add nsw i32 %i.04.i17, 1
  %exitcond81 = icmp eq i32 %141, 4
  br i1 %exitcond81, label %add4x4_idct_dc.exit31, label %100

add4x4_idct_dc.exit31:                            ; preds = %x264_clip_pixel.exit1.i30
  %142 = load i16* %scevgep109, align 2
  %143 = sext i16 %142 to i32
  %144 = shl i32 %143, 10
  %145 = add i32 %144, 32768
  %146 = ashr i32 %145, 16
  br label %147

; <label>:147                                     ; preds = %x264_clip_pixel.exit1.i15, %add4x4_idct_dc.exit31
  %i.04.i2 = phi i32 [ 0, %add4x4_idct_dc.exit31 ], [ %188, %x264_clip_pixel.exit1.i15 ]
  %tmp111 = shl i32 %i.04.i2, 5
  %tmp114 = add i32 %tmp113166, %tmp111
  %scevgep.i5 = getelementptr i8* %p_dst, i32 %tmp114
  %tmp117 = add i32 %tmp116167, %tmp111
  %scevgep8.i7 = getelementptr i8* %p_dst, i32 %tmp117
  %tmp120 = add i32 %tmp119168, %tmp111
  %scevgep10.i9 = getelementptr i8* %p_dst, i32 %tmp120
  %tmp123 = add i32 %tmp122169, %tmp111
  %.05.i10 = getelementptr i8* %p_dst, i32 %tmp123
  %148 = load i8* %.05.i10, align 1
  %149 = zext i8 %148 to i32
  %150 = add nsw i32 %149, %146
  %151 = icmp ugt i32 %150, 255
  br i1 %151, label %152, label %x264_clip_pixel.exit.i11

; <label>:152                                     ; preds = %147
  %153 = sub nsw i32 0, %150
  %154 = ashr i32 %153, 31
  %155 = and i32 %154, 255
  br label %x264_clip_pixel.exit.i11

x264_clip_pixel.exit.i11:                         ; preds = %152, %147
  %156 = phi i32 [ %155, %152 ], [ %150, %147 ]
  %157 = trunc i32 %156 to i8
  store i8 %157, i8* %.05.i10, align 1
  %158 = load i8* %scevgep.i5, align 1
  %159 = zext i8 %158 to i32
  %160 = add nsw i32 %159, %146
  %161 = icmp ugt i32 %160, 255
  br i1 %161, label %162, label %x264_clip_pixel.exit3.i12

; <label>:162                                     ; preds = %x264_clip_pixel.exit.i11
  %163 = sub nsw i32 0, %160
  %164 = ashr i32 %163, 31
  %165 = and i32 %164, 255
  br label %x264_clip_pixel.exit3.i12

x264_clip_pixel.exit3.i12:                        ; preds = %162, %x264_clip_pixel.exit.i11
  %166 = phi i32 [ %165, %162 ], [ %160, %x264_clip_pixel.exit.i11 ]
  %167 = trunc i32 %166 to i8
  store i8 %167, i8* %scevgep.i5, align 1
  %168 = load i8* %scevgep8.i7, align 1
  %169 = zext i8 %168 to i32
  %170 = add nsw i32 %169, %146
  %171 = icmp ugt i32 %170, 255
  br i1 %171, label %172, label %x264_clip_pixel.exit2.i13

; <label>:172                                     ; preds = %x264_clip_pixel.exit3.i12
  %173 = sub nsw i32 0, %170
  %174 = ashr i32 %173, 31
  %175 = and i32 %174, 255
  br label %x264_clip_pixel.exit2.i13

x264_clip_pixel.exit2.i13:                        ; preds = %172, %x264_clip_pixel.exit3.i12
  %176 = phi i32 [ %175, %172 ], [ %170, %x264_clip_pixel.exit3.i12 ]
  %177 = trunc i32 %176 to i8
  store i8 %177, i8* %scevgep8.i7, align 1
  %178 = load i8* %scevgep10.i9, align 1
  %179 = zext i8 %178 to i32
  %180 = add nsw i32 %179, %146
  %181 = icmp ugt i32 %180, 255
  br i1 %181, label %182, label %x264_clip_pixel.exit1.i15

; <label>:182                                     ; preds = %x264_clip_pixel.exit2.i13
  %183 = sub nsw i32 0, %180
  %184 = ashr i32 %183, 31
  %185 = and i32 %184, 255
  br label %x264_clip_pixel.exit1.i15

x264_clip_pixel.exit1.i15:                        ; preds = %182, %x264_clip_pixel.exit2.i13
  %186 = phi i32 [ %185, %182 ], [ %180, %x264_clip_pixel.exit2.i13 ]
  %187 = trunc i32 %186 to i8
  store i8 %187, i8* %scevgep10.i9, align 1
  %188 = add nsw i32 %i.04.i2, 1
  %exitcond92 = icmp eq i32 %188, 4
  br i1 %exitcond92, label %add4x4_idct_dc.exit16, label %147

add4x4_idct_dc.exit16:                            ; preds = %x264_clip_pixel.exit1.i15
  %189 = add nsw i32 %i.059, 1
  %exitcond103 = icmp eq i32 %189, 4
  br i1 %exitcond103, label %._crit_edge, label %0

._crit_edge:                                      ; preds = %add4x4_idct_dc.exit16
  ret void
}

define void @zigzag_scan_8x8_frame(i16* %level, i16* %dct) nounwind {
  %1 = load i16* %dct, align 2
  store i16 %1, i16* %level, align 2
  %2 = getelementptr inbounds i16* %dct, i32 8
  %3 = load i16* %2, align 2
  %4 = getelementptr inbounds i16* %level, i32 1
  store i16 %3, i16* %4, align 2
  %5 = getelementptr inbounds i16* %dct, i32 1
  %6 = load i16* %5, align 2
  %7 = getelementptr inbounds i16* %level, i32 2
  store i16 %6, i16* %7, align 2
  %8 = getelementptr inbounds i16* %dct, i32 2
  %9 = load i16* %8, align 2
  %10 = getelementptr inbounds i16* %level, i32 3
  store i16 %9, i16* %10, align 2
  %11 = getelementptr inbounds i16* %dct, i32 9
  %12 = load i16* %11, align 2
  %13 = getelementptr inbounds i16* %level, i32 4
  store i16 %12, i16* %13, align 2
  %14 = getelementptr inbounds i16* %dct, i32 16
  %15 = load i16* %14, align 2
  %16 = getelementptr inbounds i16* %level, i32 5
  store i16 %15, i16* %16, align 2
  %17 = getelementptr inbounds i16* %dct, i32 24
  %18 = load i16* %17, align 2
  %19 = getelementptr inbounds i16* %level, i32 6
  store i16 %18, i16* %19, align 2
  %20 = getelementptr inbounds i16* %dct, i32 17
  %21 = load i16* %20, align 2
  %22 = getelementptr inbounds i16* %level, i32 7
  store i16 %21, i16* %22, align 2
  %23 = getelementptr inbounds i16* %dct, i32 10
  %24 = load i16* %23, align 2
  %25 = getelementptr inbounds i16* %level, i32 8
  store i16 %24, i16* %25, align 2
  %26 = getelementptr inbounds i16* %dct, i32 3
  %27 = load i16* %26, align 2
  %28 = getelementptr inbounds i16* %level, i32 9
  store i16 %27, i16* %28, align 2
  %29 = getelementptr inbounds i16* %dct, i32 4
  %30 = load i16* %29, align 2
  %31 = getelementptr inbounds i16* %level, i32 10
  store i16 %30, i16* %31, align 2
  %32 = getelementptr inbounds i16* %dct, i32 11
  %33 = load i16* %32, align 2
  %34 = getelementptr inbounds i16* %level, i32 11
  store i16 %33, i16* %34, align 2
  %35 = getelementptr inbounds i16* %dct, i32 18
  %36 = load i16* %35, align 2
  %37 = getelementptr inbounds i16* %level, i32 12
  store i16 %36, i16* %37, align 2
  %38 = getelementptr inbounds i16* %dct, i32 25
  %39 = load i16* %38, align 2
  %40 = getelementptr inbounds i16* %level, i32 13
  store i16 %39, i16* %40, align 2
  %41 = getelementptr inbounds i16* %dct, i32 32
  %42 = load i16* %41, align 2
  %43 = getelementptr inbounds i16* %level, i32 14
  store i16 %42, i16* %43, align 2
  %44 = getelementptr inbounds i16* %dct, i32 40
  %45 = load i16* %44, align 2
  %46 = getelementptr inbounds i16* %level, i32 15
  store i16 %45, i16* %46, align 2
  %47 = getelementptr inbounds i16* %dct, i32 33
  %48 = load i16* %47, align 2
  %49 = getelementptr inbounds i16* %level, i32 16
  store i16 %48, i16* %49, align 2
  %50 = getelementptr inbounds i16* %dct, i32 26
  %51 = load i16* %50, align 2
  %52 = getelementptr inbounds i16* %level, i32 17
  store i16 %51, i16* %52, align 2
  %53 = getelementptr inbounds i16* %dct, i32 19
  %54 = load i16* %53, align 2
  %55 = getelementptr inbounds i16* %level, i32 18
  store i16 %54, i16* %55, align 2
  %56 = getelementptr inbounds i16* %dct, i32 12
  %57 = load i16* %56, align 2
  %58 = getelementptr inbounds i16* %level, i32 19
  store i16 %57, i16* %58, align 2
  %59 = getelementptr inbounds i16* %dct, i32 5
  %60 = load i16* %59, align 2
  %61 = getelementptr inbounds i16* %level, i32 20
  store i16 %60, i16* %61, align 2
  %62 = getelementptr inbounds i16* %dct, i32 6
  %63 = load i16* %62, align 2
  %64 = getelementptr inbounds i16* %level, i32 21
  store i16 %63, i16* %64, align 2
  %65 = getelementptr inbounds i16* %dct, i32 13
  %66 = load i16* %65, align 2
  %67 = getelementptr inbounds i16* %level, i32 22
  store i16 %66, i16* %67, align 2
  %68 = getelementptr inbounds i16* %dct, i32 20
  %69 = load i16* %68, align 2
  %70 = getelementptr inbounds i16* %level, i32 23
  store i16 %69, i16* %70, align 2
  %71 = getelementptr inbounds i16* %dct, i32 27
  %72 = load i16* %71, align 2
  %73 = getelementptr inbounds i16* %level, i32 24
  store i16 %72, i16* %73, align 2
  %74 = getelementptr inbounds i16* %dct, i32 34
  %75 = load i16* %74, align 2
  %76 = getelementptr inbounds i16* %level, i32 25
  store i16 %75, i16* %76, align 2
  %77 = getelementptr inbounds i16* %dct, i32 41
  %78 = load i16* %77, align 2
  %79 = getelementptr inbounds i16* %level, i32 26
  store i16 %78, i16* %79, align 2
  %80 = getelementptr inbounds i16* %dct, i32 48
  %81 = load i16* %80, align 2
  %82 = getelementptr inbounds i16* %level, i32 27
  store i16 %81, i16* %82, align 2
  %83 = getelementptr inbounds i16* %dct, i32 56
  %84 = load i16* %83, align 2
  %85 = getelementptr inbounds i16* %level, i32 28
  store i16 %84, i16* %85, align 2
  %86 = getelementptr inbounds i16* %dct, i32 49
  %87 = load i16* %86, align 2
  %88 = getelementptr inbounds i16* %level, i32 29
  store i16 %87, i16* %88, align 2
  %89 = getelementptr inbounds i16* %dct, i32 42
  %90 = load i16* %89, align 2
  %91 = getelementptr inbounds i16* %level, i32 30
  store i16 %90, i16* %91, align 2
  %92 = getelementptr inbounds i16* %dct, i32 35
  %93 = load i16* %92, align 2
  %94 = getelementptr inbounds i16* %level, i32 31
  store i16 %93, i16* %94, align 2
  %95 = getelementptr inbounds i16* %dct, i32 28
  %96 = load i16* %95, align 2
  %97 = getelementptr inbounds i16* %level, i32 32
  store i16 %96, i16* %97, align 2
  %98 = getelementptr inbounds i16* %dct, i32 21
  %99 = load i16* %98, align 2
  %100 = getelementptr inbounds i16* %level, i32 33
  store i16 %99, i16* %100, align 2
  %101 = getelementptr inbounds i16* %dct, i32 14
  %102 = load i16* %101, align 2
  %103 = getelementptr inbounds i16* %level, i32 34
  store i16 %102, i16* %103, align 2
  %104 = getelementptr inbounds i16* %dct, i32 7
  %105 = load i16* %104, align 2
  %106 = getelementptr inbounds i16* %level, i32 35
  store i16 %105, i16* %106, align 2
  %107 = getelementptr inbounds i16* %dct, i32 15
  %108 = load i16* %107, align 2
  %109 = getelementptr inbounds i16* %level, i32 36
  store i16 %108, i16* %109, align 2
  %110 = getelementptr inbounds i16* %dct, i32 22
  %111 = load i16* %110, align 2
  %112 = getelementptr inbounds i16* %level, i32 37
  store i16 %111, i16* %112, align 2
  %113 = getelementptr inbounds i16* %dct, i32 29
  %114 = load i16* %113, align 2
  %115 = getelementptr inbounds i16* %level, i32 38
  store i16 %114, i16* %115, align 2
  %116 = getelementptr inbounds i16* %dct, i32 36
  %117 = load i16* %116, align 2
  %118 = getelementptr inbounds i16* %level, i32 39
  store i16 %117, i16* %118, align 2
  %119 = getelementptr inbounds i16* %dct, i32 43
  %120 = load i16* %119, align 2
  %121 = getelementptr inbounds i16* %level, i32 40
  store i16 %120, i16* %121, align 2
  %122 = getelementptr inbounds i16* %dct, i32 50
  %123 = load i16* %122, align 2
  %124 = getelementptr inbounds i16* %level, i32 41
  store i16 %123, i16* %124, align 2
  %125 = getelementptr inbounds i16* %dct, i32 57
  %126 = load i16* %125, align 2
  %127 = getelementptr inbounds i16* %level, i32 42
  store i16 %126, i16* %127, align 2
  %128 = getelementptr inbounds i16* %dct, i32 58
  %129 = load i16* %128, align 2
  %130 = getelementptr inbounds i16* %level, i32 43
  store i16 %129, i16* %130, align 2
  %131 = getelementptr inbounds i16* %dct, i32 51
  %132 = load i16* %131, align 2
  %133 = getelementptr inbounds i16* %level, i32 44
  store i16 %132, i16* %133, align 2
  %134 = getelementptr inbounds i16* %dct, i32 44
  %135 = load i16* %134, align 2
  %136 = getelementptr inbounds i16* %level, i32 45
  store i16 %135, i16* %136, align 2
  %137 = getelementptr inbounds i16* %dct, i32 37
  %138 = load i16* %137, align 2
  %139 = getelementptr inbounds i16* %level, i32 46
  store i16 %138, i16* %139, align 2
  %140 = getelementptr inbounds i16* %dct, i32 30
  %141 = load i16* %140, align 2
  %142 = getelementptr inbounds i16* %level, i32 47
  store i16 %141, i16* %142, align 2
  %143 = getelementptr inbounds i16* %dct, i32 23
  %144 = load i16* %143, align 2
  %145 = getelementptr inbounds i16* %level, i32 48
  store i16 %144, i16* %145, align 2
  %146 = getelementptr inbounds i16* %dct, i32 31
  %147 = load i16* %146, align 2
  %148 = getelementptr inbounds i16* %level, i32 49
  store i16 %147, i16* %148, align 2
  %149 = getelementptr inbounds i16* %dct, i32 38
  %150 = load i16* %149, align 2
  %151 = getelementptr inbounds i16* %level, i32 50
  store i16 %150, i16* %151, align 2
  %152 = getelementptr inbounds i16* %dct, i32 45
  %153 = load i16* %152, align 2
  %154 = getelementptr inbounds i16* %level, i32 51
  store i16 %153, i16* %154, align 2
  %155 = getelementptr inbounds i16* %dct, i32 52
  %156 = load i16* %155, align 2
  %157 = getelementptr inbounds i16* %level, i32 52
  store i16 %156, i16* %157, align 2
  %158 = getelementptr inbounds i16* %dct, i32 59
  %159 = load i16* %158, align 2
  %160 = getelementptr inbounds i16* %level, i32 53
  store i16 %159, i16* %160, align 2
  %161 = getelementptr inbounds i16* %dct, i32 60
  %162 = load i16* %161, align 2
  %163 = getelementptr inbounds i16* %level, i32 54
  store i16 %162, i16* %163, align 2
  %164 = getelementptr inbounds i16* %dct, i32 53
  %165 = load i16* %164, align 2
  %166 = getelementptr inbounds i16* %level, i32 55
  store i16 %165, i16* %166, align 2
  %167 = getelementptr inbounds i16* %dct, i32 46
  %168 = load i16* %167, align 2
  %169 = getelementptr inbounds i16* %level, i32 56
  store i16 %168, i16* %169, align 2
  %170 = getelementptr inbounds i16* %dct, i32 39
  %171 = load i16* %170, align 2
  %172 = getelementptr inbounds i16* %level, i32 57
  store i16 %171, i16* %172, align 2
  %173 = getelementptr inbounds i16* %dct, i32 47
  %174 = load i16* %173, align 2
  %175 = getelementptr inbounds i16* %level, i32 58
  store i16 %174, i16* %175, align 2
  %176 = getelementptr inbounds i16* %dct, i32 54
  %177 = load i16* %176, align 2
  %178 = getelementptr inbounds i16* %level, i32 59
  store i16 %177, i16* %178, align 2
  %179 = getelementptr inbounds i16* %dct, i32 61
  %180 = load i16* %179, align 2
  %181 = getelementptr inbounds i16* %level, i32 60
  store i16 %180, i16* %181, align 2
  %182 = getelementptr inbounds i16* %dct, i32 62
  %183 = load i16* %182, align 2
  %184 = getelementptr inbounds i16* %level, i32 61
  store i16 %183, i16* %184, align 2
  %185 = getelementptr inbounds i16* %dct, i32 55
  %186 = load i16* %185, align 2
  %187 = getelementptr inbounds i16* %level, i32 62
  store i16 %186, i16* %187, align 2
  %188 = getelementptr inbounds i16* %dct, i32 63
  %189 = load i16* %188, align 2
  %190 = getelementptr inbounds i16* %level, i32 63
  store i16 %189, i16* %190, align 2
  ret void
}

define void @zigzag_scan_8x8_field(i16* %level, i16* %dct) nounwind {
  %1 = load i16* %dct, align 2
  store i16 %1, i16* %level, align 2
  %2 = getelementptr inbounds i16* %dct, i32 1
  %3 = load i16* %2, align 2
  %4 = getelementptr inbounds i16* %level, i32 1
  store i16 %3, i16* %4, align 2
  %5 = getelementptr inbounds i16* %dct, i32 2
  %6 = load i16* %5, align 2
  %7 = getelementptr inbounds i16* %level, i32 2
  store i16 %6, i16* %7, align 2
  %8 = getelementptr inbounds i16* %dct, i32 8
  %9 = load i16* %8, align 2
  %10 = getelementptr inbounds i16* %level, i32 3
  store i16 %9, i16* %10, align 2
  %11 = getelementptr inbounds i16* %dct, i32 9
  %12 = load i16* %11, align 2
  %13 = getelementptr inbounds i16* %level, i32 4
  store i16 %12, i16* %13, align 2
  %14 = getelementptr inbounds i16* %dct, i32 3
  %15 = load i16* %14, align 2
  %16 = getelementptr inbounds i16* %level, i32 5
  store i16 %15, i16* %16, align 2
  %17 = getelementptr inbounds i16* %dct, i32 4
  %18 = load i16* %17, align 2
  %19 = getelementptr inbounds i16* %level, i32 6
  store i16 %18, i16* %19, align 2
  %20 = getelementptr inbounds i16* %dct, i32 10
  %21 = load i16* %20, align 2
  %22 = getelementptr inbounds i16* %level, i32 7
  store i16 %21, i16* %22, align 2
  %23 = getelementptr inbounds i16* %dct, i32 16
  %24 = load i16* %23, align 2
  %25 = getelementptr inbounds i16* %level, i32 8
  store i16 %24, i16* %25, align 2
  %26 = getelementptr inbounds i16* %dct, i32 11
  %27 = load i16* %26, align 2
  %28 = getelementptr inbounds i16* %level, i32 9
  store i16 %27, i16* %28, align 2
  %29 = getelementptr inbounds i16* %dct, i32 5
  %30 = load i16* %29, align 2
  %31 = getelementptr inbounds i16* %level, i32 10
  store i16 %30, i16* %31, align 2
  %32 = getelementptr inbounds i16* %dct, i32 6
  %33 = load i16* %32, align 2
  %34 = getelementptr inbounds i16* %level, i32 11
  store i16 %33, i16* %34, align 2
  %35 = getelementptr inbounds i16* %dct, i32 7
  %36 = load i16* %35, align 2
  %37 = getelementptr inbounds i16* %level, i32 12
  store i16 %36, i16* %37, align 2
  %38 = getelementptr inbounds i16* %dct, i32 12
  %39 = load i16* %38, align 2
  %40 = getelementptr inbounds i16* %level, i32 13
  store i16 %39, i16* %40, align 2
  %41 = getelementptr inbounds i16* %dct, i32 17
  %42 = load i16* %41, align 2
  %43 = getelementptr inbounds i16* %level, i32 14
  store i16 %42, i16* %43, align 2
  %44 = getelementptr inbounds i16* %dct, i32 24
  %45 = load i16* %44, align 2
  %46 = getelementptr inbounds i16* %level, i32 15
  store i16 %45, i16* %46, align 2
  %47 = getelementptr inbounds i16* %dct, i32 18
  %48 = load i16* %47, align 2
  %49 = getelementptr inbounds i16* %level, i32 16
  store i16 %48, i16* %49, align 2
  %50 = getelementptr inbounds i16* %dct, i32 13
  %51 = load i16* %50, align 2
  %52 = getelementptr inbounds i16* %level, i32 17
  store i16 %51, i16* %52, align 2
  %53 = getelementptr inbounds i16* %dct, i32 14
  %54 = load i16* %53, align 2
  %55 = getelementptr inbounds i16* %level, i32 18
  store i16 %54, i16* %55, align 2
  %56 = getelementptr inbounds i16* %dct, i32 15
  %57 = load i16* %56, align 2
  %58 = getelementptr inbounds i16* %level, i32 19
  store i16 %57, i16* %58, align 2
  %59 = getelementptr inbounds i16* %dct, i32 19
  %60 = load i16* %59, align 2
  %61 = getelementptr inbounds i16* %level, i32 20
  store i16 %60, i16* %61, align 2
  %62 = getelementptr inbounds i16* %dct, i32 25
  %63 = load i16* %62, align 2
  %64 = getelementptr inbounds i16* %level, i32 21
  store i16 %63, i16* %64, align 2
  %65 = getelementptr inbounds i16* %dct, i32 32
  %66 = load i16* %65, align 2
  %67 = getelementptr inbounds i16* %level, i32 22
  store i16 %66, i16* %67, align 2
  %68 = getelementptr inbounds i16* %dct, i32 26
  %69 = load i16* %68, align 2
  %70 = getelementptr inbounds i16* %level, i32 23
  store i16 %69, i16* %70, align 2
  %71 = getelementptr inbounds i16* %dct, i32 20
  %72 = load i16* %71, align 2
  %73 = getelementptr inbounds i16* %level, i32 24
  store i16 %72, i16* %73, align 2
  %74 = getelementptr inbounds i16* %dct, i32 21
  %75 = load i16* %74, align 2
  %76 = getelementptr inbounds i16* %level, i32 25
  store i16 %75, i16* %76, align 2
  %77 = getelementptr inbounds i16* %dct, i32 22
  %78 = load i16* %77, align 2
  %79 = getelementptr inbounds i16* %level, i32 26
  store i16 %78, i16* %79, align 2
  %80 = getelementptr inbounds i16* %dct, i32 23
  %81 = load i16* %80, align 2
  %82 = getelementptr inbounds i16* %level, i32 27
  store i16 %81, i16* %82, align 2
  %83 = getelementptr inbounds i16* %dct, i32 27
  %84 = load i16* %83, align 2
  %85 = getelementptr inbounds i16* %level, i32 28
  store i16 %84, i16* %85, align 2
  %86 = getelementptr inbounds i16* %dct, i32 33
  %87 = load i16* %86, align 2
  %88 = getelementptr inbounds i16* %level, i32 29
  store i16 %87, i16* %88, align 2
  %89 = getelementptr inbounds i16* %dct, i32 40
  %90 = load i16* %89, align 2
  %91 = getelementptr inbounds i16* %level, i32 30
  store i16 %90, i16* %91, align 2
  %92 = getelementptr inbounds i16* %dct, i32 34
  %93 = load i16* %92, align 2
  %94 = getelementptr inbounds i16* %level, i32 31
  store i16 %93, i16* %94, align 2
  %95 = getelementptr inbounds i16* %dct, i32 28
  %96 = load i16* %95, align 2
  %97 = getelementptr inbounds i16* %level, i32 32
  store i16 %96, i16* %97, align 2
  %98 = getelementptr inbounds i16* %dct, i32 29
  %99 = load i16* %98, align 2
  %100 = getelementptr inbounds i16* %level, i32 33
  store i16 %99, i16* %100, align 2
  %101 = getelementptr inbounds i16* %dct, i32 30
  %102 = load i16* %101, align 2
  %103 = getelementptr inbounds i16* %level, i32 34
  store i16 %102, i16* %103, align 2
  %104 = getelementptr inbounds i16* %dct, i32 31
  %105 = load i16* %104, align 2
  %106 = getelementptr inbounds i16* %level, i32 35
  store i16 %105, i16* %106, align 2
  %107 = getelementptr inbounds i16* %dct, i32 35
  %108 = load i16* %107, align 2
  %109 = getelementptr inbounds i16* %level, i32 36
  store i16 %108, i16* %109, align 2
  %110 = getelementptr inbounds i16* %dct, i32 41
  %111 = load i16* %110, align 2
  %112 = getelementptr inbounds i16* %level, i32 37
  store i16 %111, i16* %112, align 2
  %113 = getelementptr inbounds i16* %dct, i32 48
  %114 = load i16* %113, align 2
  %115 = getelementptr inbounds i16* %level, i32 38
  store i16 %114, i16* %115, align 2
  %116 = getelementptr inbounds i16* %dct, i32 42
  %117 = load i16* %116, align 2
  %118 = getelementptr inbounds i16* %level, i32 39
  store i16 %117, i16* %118, align 2
  %119 = getelementptr inbounds i16* %dct, i32 36
  %120 = load i16* %119, align 2
  %121 = getelementptr inbounds i16* %level, i32 40
  store i16 %120, i16* %121, align 2
  %122 = getelementptr inbounds i16* %dct, i32 37
  %123 = load i16* %122, align 2
  %124 = getelementptr inbounds i16* %level, i32 41
  store i16 %123, i16* %124, align 2
  %125 = getelementptr inbounds i16* %dct, i32 38
  %126 = load i16* %125, align 2
  %127 = getelementptr inbounds i16* %level, i32 42
  store i16 %126, i16* %127, align 2
  %128 = getelementptr inbounds i16* %dct, i32 39
  %129 = load i16* %128, align 2
  %130 = getelementptr inbounds i16* %level, i32 43
  store i16 %129, i16* %130, align 2
  %131 = getelementptr inbounds i16* %dct, i32 43
  %132 = load i16* %131, align 2
  %133 = getelementptr inbounds i16* %level, i32 44
  store i16 %132, i16* %133, align 2
  %134 = getelementptr inbounds i16* %dct, i32 49
  %135 = load i16* %134, align 2
  %136 = getelementptr inbounds i16* %level, i32 45
  store i16 %135, i16* %136, align 2
  %137 = getelementptr inbounds i16* %dct, i32 50
  %138 = load i16* %137, align 2
  %139 = getelementptr inbounds i16* %level, i32 46
  store i16 %138, i16* %139, align 2
  %140 = getelementptr inbounds i16* %dct, i32 44
  %141 = load i16* %140, align 2
  %142 = getelementptr inbounds i16* %level, i32 47
  store i16 %141, i16* %142, align 2
  %143 = getelementptr inbounds i16* %dct, i32 45
  %144 = load i16* %143, align 2
  %145 = getelementptr inbounds i16* %level, i32 48
  store i16 %144, i16* %145, align 2
  %146 = getelementptr inbounds i16* %dct, i32 46
  %147 = load i16* %146, align 2
  %148 = getelementptr inbounds i16* %level, i32 49
  store i16 %147, i16* %148, align 2
  %149 = getelementptr inbounds i16* %dct, i32 47
  %150 = load i16* %149, align 2
  %151 = getelementptr inbounds i16* %level, i32 50
  store i16 %150, i16* %151, align 2
  %152 = getelementptr inbounds i16* %dct, i32 51
  %153 = load i16* %152, align 2
  %154 = getelementptr inbounds i16* %level, i32 51
  store i16 %153, i16* %154, align 2
  %155 = getelementptr inbounds i16* %dct, i32 56
  %156 = load i16* %155, align 2
  %157 = getelementptr inbounds i16* %level, i32 52
  store i16 %156, i16* %157, align 2
  %158 = getelementptr inbounds i16* %dct, i32 57
  %159 = load i16* %158, align 2
  %160 = getelementptr inbounds i16* %level, i32 53
  store i16 %159, i16* %160, align 2
  %161 = getelementptr inbounds i16* %dct, i32 52
  %162 = load i16* %161, align 2
  %163 = getelementptr inbounds i16* %level, i32 54
  store i16 %162, i16* %163, align 2
  %164 = getelementptr inbounds i16* %dct, i32 53
  %165 = load i16* %164, align 2
  %166 = getelementptr inbounds i16* %level, i32 55
  store i16 %165, i16* %166, align 2
  %167 = getelementptr inbounds i16* %dct, i32 54
  %168 = load i16* %167, align 2
  %169 = getelementptr inbounds i16* %level, i32 56
  store i16 %168, i16* %169, align 2
  %170 = getelementptr inbounds i16* %dct, i32 55
  %171 = load i16* %170, align 2
  %172 = getelementptr inbounds i16* %level, i32 57
  store i16 %171, i16* %172, align 2
  %173 = getelementptr inbounds i16* %dct, i32 58
  %174 = load i16* %173, align 2
  %175 = getelementptr inbounds i16* %level, i32 58
  store i16 %174, i16* %175, align 2
  %176 = getelementptr inbounds i16* %dct, i32 59
  %177 = load i16* %176, align 2
  %178 = getelementptr inbounds i16* %level, i32 59
  store i16 %177, i16* %178, align 2
  %179 = getelementptr inbounds i16* %dct, i32 60
  %180 = load i16* %179, align 2
  %181 = getelementptr inbounds i16* %level, i32 60
  store i16 %180, i16* %181, align 2
  %182 = getelementptr inbounds i16* %dct, i32 61
  %183 = load i16* %182, align 2
  %184 = getelementptr inbounds i16* %level, i32 61
  store i16 %183, i16* %184, align 2
  %185 = getelementptr inbounds i16* %dct, i32 62
  %186 = load i16* %185, align 2
  %187 = getelementptr inbounds i16* %level, i32 62
  store i16 %186, i16* %187, align 2
  %188 = getelementptr inbounds i16* %dct, i32 63
  %189 = load i16* %188, align 2
  %190 = getelementptr inbounds i16* %level, i32 63
  store i16 %189, i16* %190, align 2
  ret void
}

define void @zigzag_scan_4x4_frame(i16* nocapture %level, i16* nocapture %dct) nounwind {
  %1 = load i16* %dct, align 2
  store i16 %1, i16* %level, align 2
  %2 = getelementptr inbounds i16* %dct, i32 4
  %3 = load i16* %2, align 2
  %4 = getelementptr inbounds i16* %level, i32 1
  store i16 %3, i16* %4, align 2
  %5 = getelementptr inbounds i16* %dct, i32 1
  %6 = load i16* %5, align 2
  %7 = getelementptr inbounds i16* %level, i32 2
  store i16 %6, i16* %7, align 2
  %8 = getelementptr inbounds i16* %dct, i32 2
  %9 = load i16* %8, align 2
  %10 = getelementptr inbounds i16* %level, i32 3
  store i16 %9, i16* %10, align 2
  %11 = getelementptr inbounds i16* %dct, i32 5
  %12 = load i16* %11, align 2
  %13 = getelementptr inbounds i16* %level, i32 4
  store i16 %12, i16* %13, align 2
  %14 = getelementptr inbounds i16* %dct, i32 8
  %15 = load i16* %14, align 2
  %16 = getelementptr inbounds i16* %level, i32 5
  store i16 %15, i16* %16, align 2
  %17 = getelementptr inbounds i16* %dct, i32 12
  %18 = load i16* %17, align 2
  %19 = getelementptr inbounds i16* %level, i32 6
  store i16 %18, i16* %19, align 2
  %20 = getelementptr inbounds i16* %dct, i32 9
  %21 = load i16* %20, align 2
  %22 = getelementptr inbounds i16* %level, i32 7
  store i16 %21, i16* %22, align 2
  %23 = getelementptr inbounds i16* %dct, i32 6
  %24 = load i16* %23, align 2
  %25 = getelementptr inbounds i16* %level, i32 8
  store i16 %24, i16* %25, align 2
  %26 = getelementptr inbounds i16* %dct, i32 3
  %27 = load i16* %26, align 2
  %28 = getelementptr inbounds i16* %level, i32 9
  store i16 %27, i16* %28, align 2
  %29 = getelementptr inbounds i16* %dct, i32 7
  %30 = load i16* %29, align 2
  %31 = getelementptr inbounds i16* %level, i32 10
  store i16 %30, i16* %31, align 2
  %32 = getelementptr inbounds i16* %dct, i32 10
  %33 = load i16* %32, align 2
  %34 = getelementptr inbounds i16* %level, i32 11
  store i16 %33, i16* %34, align 2
  %35 = getelementptr inbounds i16* %dct, i32 13
  %36 = load i16* %35, align 2
  %37 = getelementptr inbounds i16* %level, i32 12
  store i16 %36, i16* %37, align 2
  %38 = getelementptr inbounds i16* %dct, i32 14
  %39 = load i16* %38, align 2
  %40 = getelementptr inbounds i16* %level, i32 13
  store i16 %39, i16* %40, align 2
  %41 = getelementptr inbounds i16* %dct, i32 11
  %42 = load i16* %41, align 2
  %43 = getelementptr inbounds i16* %level, i32 14
  store i16 %42, i16* %43, align 2
  %44 = getelementptr inbounds i16* %dct, i32 15
  %45 = load i16* %44, align 2
  %46 = getelementptr inbounds i16* %level, i32 15
  store i16 %45, i16* %46, align 2
  ret void
}

define void @zigzag_scan_4x4_field(i16* nocapture %level, i16* nocapture %dct) nounwind {
  %1 = bitcast i16* %dct to i32*
  %2 = bitcast i16* %level to i32*
  %tmp = load i32* %1, align 1
  store i32 %tmp, i32* %2, align 1
  %3 = getelementptr inbounds i16* %dct, i32 4
  %4 = load i16* %3, align 2
  %5 = getelementptr inbounds i16* %level, i32 2
  store i16 %4, i16* %5, align 2
  %6 = getelementptr inbounds i16* %dct, i32 2
  %7 = load i16* %6, align 2
  %8 = getelementptr inbounds i16* %level, i32 3
  store i16 %7, i16* %8, align 2
  %9 = getelementptr inbounds i16* %dct, i32 3
  %10 = load i16* %9, align 2
  %11 = getelementptr inbounds i16* %level, i32 4
  store i16 %10, i16* %11, align 2
  %12 = getelementptr inbounds i16* %dct, i32 5
  %13 = load i16* %12, align 2
  %14 = getelementptr inbounds i16* %level, i32 5
  store i16 %13, i16* %14, align 2
  %15 = getelementptr inbounds i16* %level, i32 6
  %16 = bitcast i16* %15 to i8*
  %17 = getelementptr inbounds i16* %dct, i32 6
  %18 = bitcast i16* %17 to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i32(i8* %16, i8* %18, i32 20, i32 1, i1 false)
  ret void
}

declare void @llvm.memcpy.p0i8.p0i8.i32(i8* nocapture, i8* nocapture, i32, i32, i1) nounwind

define i32 @zigzag_sub_4x4_frame(i16* nocapture %level, i8* nocapture %p_src, i8* nocapture %p_dst) nounwind {
  %1 = load i8* %p_src, align 1
  %2 = zext i8 %1 to i16
  %3 = load i8* %p_dst, align 1
  %4 = zext i8 %3 to i16
  %5 = sub i16 %2, %4
  store i16 %5, i16* %level, align 2
  %6 = getelementptr inbounds i8* %p_src, i32 1
  %7 = load i8* %6, align 1
  %8 = zext i8 %7 to i16
  %9 = getelementptr inbounds i8* %p_dst, i32 1
  %10 = load i8* %9, align 1
  %11 = zext i8 %10 to i16
  %12 = sub i16 %8, %11
  %13 = getelementptr inbounds i16* %level, i32 1
  store i16 %12, i16* %13, align 2
  %14 = getelementptr inbounds i8* %p_src, i32 16
  %15 = load i8* %14, align 1
  %16 = zext i8 %15 to i16
  %17 = getelementptr inbounds i8* %p_dst, i32 32
  %18 = load i8* %17, align 1
  %19 = zext i8 %18 to i16
  %20 = sub i16 %16, %19
  %21 = getelementptr inbounds i16* %level, i32 2
  store i16 %20, i16* %21, align 2
  %22 = getelementptr inbounds i8* %p_src, i32 32
  %23 = load i8* %22, align 1
  %24 = zext i8 %23 to i16
  %25 = getelementptr inbounds i8* %p_dst, i32 64
  %26 = load i8* %25, align 1
  %27 = zext i8 %26 to i16
  %28 = sub i16 %24, %27
  %29 = getelementptr inbounds i16* %level, i32 3
  store i16 %28, i16* %29, align 2
  %30 = getelementptr inbounds i8* %p_src, i32 17
  %31 = load i8* %30, align 1
  %32 = zext i8 %31 to i16
  %33 = getelementptr inbounds i8* %p_dst, i32 33
  %34 = load i8* %33, align 1
  %35 = zext i8 %34 to i16
  %36 = sub i16 %32, %35
  %37 = getelementptr inbounds i16* %level, i32 4
  store i16 %36, i16* %37, align 2
  %38 = getelementptr inbounds i8* %p_src, i32 2
  %39 = load i8* %38, align 1
  %40 = zext i8 %39 to i16
  %41 = getelementptr inbounds i8* %p_dst, i32 2
  %42 = load i8* %41, align 1
  %43 = zext i8 %42 to i16
  %44 = sub i16 %40, %43
  %45 = getelementptr inbounds i16* %level, i32 5
  store i16 %44, i16* %45, align 2
  %46 = getelementptr inbounds i8* %p_src, i32 3
  %47 = load i8* %46, align 1
  %48 = zext i8 %47 to i16
  %49 = getelementptr inbounds i8* %p_dst, i32 3
  %50 = load i8* %49, align 1
  %51 = zext i8 %50 to i16
  %52 = sub i16 %48, %51
  %53 = getelementptr inbounds i16* %level, i32 6
  store i16 %52, i16* %53, align 2
  %54 = getelementptr inbounds i8* %p_src, i32 18
  %55 = load i8* %54, align 1
  %56 = zext i8 %55 to i16
  %57 = getelementptr inbounds i8* %p_dst, i32 34
  %58 = load i8* %57, align 1
  %59 = zext i8 %58 to i16
  %60 = sub i16 %56, %59
  %61 = getelementptr inbounds i16* %level, i32 7
  store i16 %60, i16* %61, align 2
  %62 = getelementptr inbounds i8* %p_src, i32 33
  %63 = load i8* %62, align 1
  %64 = zext i8 %63 to i16
  %65 = getelementptr inbounds i8* %p_dst, i32 65
  %66 = load i8* %65, align 1
  %67 = zext i8 %66 to i16
  %68 = sub i16 %64, %67
  %69 = getelementptr inbounds i16* %level, i32 8
  store i16 %68, i16* %69, align 2
  %70 = getelementptr inbounds i8* %p_src, i32 48
  %71 = load i8* %70, align 1
  %72 = zext i8 %71 to i16
  %73 = getelementptr inbounds i8* %p_dst, i32 96
  %74 = load i8* %73, align 1
  %75 = zext i8 %74 to i16
  %76 = sub i16 %72, %75
  %77 = getelementptr inbounds i16* %level, i32 9
  store i16 %76, i16* %77, align 2
  %78 = getelementptr inbounds i8* %p_src, i32 49
  %79 = load i8* %78, align 1
  %80 = zext i8 %79 to i16
  %81 = getelementptr inbounds i8* %p_dst, i32 97
  %82 = load i8* %81, align 1
  %83 = zext i8 %82 to i16
  %84 = sub i16 %80, %83
  %85 = getelementptr inbounds i16* %level, i32 10
  store i16 %84, i16* %85, align 2
  %86 = getelementptr inbounds i8* %p_src, i32 34
  %87 = load i8* %86, align 1
  %88 = zext i8 %87 to i16
  %89 = getelementptr inbounds i8* %p_dst, i32 66
  %90 = load i8* %89, align 1
  %91 = zext i8 %90 to i16
  %92 = sub i16 %88, %91
  %93 = getelementptr inbounds i16* %level, i32 11
  store i16 %92, i16* %93, align 2
  %94 = getelementptr inbounds i8* %p_src, i32 19
  %95 = load i8* %94, align 1
  %96 = zext i8 %95 to i16
  %97 = getelementptr inbounds i8* %p_dst, i32 35
  %98 = load i8* %97, align 1
  %99 = zext i8 %98 to i16
  %100 = sub i16 %96, %99
  %101 = getelementptr inbounds i16* %level, i32 12
  store i16 %100, i16* %101, align 2
  %102 = getelementptr inbounds i8* %p_src, i32 35
  %103 = load i8* %102, align 1
  %104 = zext i8 %103 to i16
  %105 = getelementptr inbounds i8* %p_dst, i32 67
  %106 = load i8* %105, align 1
  %107 = zext i8 %106 to i16
  %108 = sub i16 %104, %107
  %109 = getelementptr inbounds i16* %level, i32 13
  store i16 %108, i16* %109, align 2
  %110 = getelementptr inbounds i8* %p_src, i32 50
  %111 = load i8* %110, align 1
  %112 = zext i8 %111 to i16
  %113 = getelementptr inbounds i8* %p_dst, i32 98
  %114 = load i8* %113, align 1
  %115 = zext i8 %114 to i16
  %116 = sub i16 %112, %115
  %117 = getelementptr inbounds i16* %level, i32 14
  store i16 %116, i16* %117, align 2
  %118 = getelementptr inbounds i8* %p_src, i32 51
  %119 = load i8* %118, align 1
  %120 = zext i8 %119 to i16
  %121 = getelementptr inbounds i8* %p_dst, i32 99
  %122 = load i8* %121, align 1
  %123 = zext i8 %122 to i16
  %124 = sub i16 %120, %123
  %125 = getelementptr inbounds i16* %level, i32 15
  store i16 %124, i16* %125, align 2
  %126 = or i16 %12, %5
  %127 = or i16 %126, %20
  %128 = or i16 %127, %28
  %129 = or i16 %128, %36
  %130 = or i16 %129, %44
  %131 = or i16 %130, %52
  %132 = or i16 %131, %60
  %133 = or i16 %132, %68
  %134 = or i16 %133, %76
  %135 = or i16 %134, %84
  %136 = or i16 %135, %92
  %137 = or i16 %136, %100
  %138 = or i16 %137, %108
  %139 = or i16 %138, %116
  %140 = or i16 %139, %124
  %141 = bitcast i8* %p_src to i32*
  %142 = load i32* %141, align 4
  %143 = bitcast i8* %p_dst to i32*
  store i32 %142, i32* %143, align 4
  %144 = bitcast i8* %14 to i32*
  %145 = load i32* %144, align 4
  %146 = bitcast i8* %17 to i32*
  store i32 %145, i32* %146, align 4
  %147 = bitcast i8* %22 to i32*
  %148 = load i32* %147, align 4
  %149 = bitcast i8* %25 to i32*
  store i32 %148, i32* %149, align 4
  %150 = bitcast i8* %70 to i32*
  %151 = load i32* %150, align 4
  %152 = bitcast i8* %73 to i32*
  store i32 %151, i32* %152, align 4
  %153 = icmp ne i16 %140, 0
  %154 = zext i1 %153 to i32
  ret i32 %154
}

define i32 @zigzag_sub_4x4_field(i16* nocapture %level, i8* nocapture %p_src, i8* nocapture %p_dst) nounwind {
  %1 = load i8* %p_src, align 1
  %2 = zext i8 %1 to i16
  %3 = load i8* %p_dst, align 1
  %4 = zext i8 %3 to i16
  %5 = sub i16 %2, %4
  store i16 %5, i16* %level, align 2
  %6 = getelementptr inbounds i8* %p_src, i32 16
  %7 = load i8* %6, align 1
  %8 = zext i8 %7 to i16
  %9 = getelementptr inbounds i8* %p_dst, i32 32
  %10 = load i8* %9, align 1
  %11 = zext i8 %10 to i16
  %12 = sub i16 %8, %11
  %13 = getelementptr inbounds i16* %level, i32 1
  store i16 %12, i16* %13, align 2
  %14 = getelementptr inbounds i8* %p_src, i32 1
  %15 = load i8* %14, align 1
  %16 = zext i8 %15 to i16
  %17 = getelementptr inbounds i8* %p_dst, i32 1
  %18 = load i8* %17, align 1
  %19 = zext i8 %18 to i16
  %20 = sub i16 %16, %19
  %21 = getelementptr inbounds i16* %level, i32 2
  store i16 %20, i16* %21, align 2
  %22 = getelementptr inbounds i8* %p_src, i32 32
  %23 = load i8* %22, align 1
  %24 = zext i8 %23 to i16
  %25 = getelementptr inbounds i8* %p_dst, i32 64
  %26 = load i8* %25, align 1
  %27 = zext i8 %26 to i16
  %28 = sub i16 %24, %27
  %29 = getelementptr inbounds i16* %level, i32 3
  store i16 %28, i16* %29, align 2
  %30 = getelementptr inbounds i8* %p_src, i32 48
  %31 = load i8* %30, align 1
  %32 = zext i8 %31 to i16
  %33 = getelementptr inbounds i8* %p_dst, i32 96
  %34 = load i8* %33, align 1
  %35 = zext i8 %34 to i16
  %36 = sub i16 %32, %35
  %37 = getelementptr inbounds i16* %level, i32 4
  store i16 %36, i16* %37, align 2
  %38 = getelementptr inbounds i8* %p_src, i32 17
  %39 = load i8* %38, align 1
  %40 = zext i8 %39 to i16
  %41 = getelementptr inbounds i8* %p_dst, i32 33
  %42 = load i8* %41, align 1
  %43 = zext i8 %42 to i16
  %44 = sub i16 %40, %43
  %45 = getelementptr inbounds i16* %level, i32 5
  store i16 %44, i16* %45, align 2
  %46 = getelementptr inbounds i8* %p_src, i32 33
  %47 = load i8* %46, align 1
  %48 = zext i8 %47 to i16
  %49 = getelementptr inbounds i8* %p_dst, i32 65
  %50 = load i8* %49, align 1
  %51 = zext i8 %50 to i16
  %52 = sub i16 %48, %51
  %53 = getelementptr inbounds i16* %level, i32 6
  store i16 %52, i16* %53, align 2
  %54 = getelementptr inbounds i8* %p_src, i32 49
  %55 = load i8* %54, align 1
  %56 = zext i8 %55 to i16
  %57 = getelementptr inbounds i8* %p_dst, i32 97
  %58 = load i8* %57, align 1
  %59 = zext i8 %58 to i16
  %60 = sub i16 %56, %59
  %61 = getelementptr inbounds i16* %level, i32 7
  store i16 %60, i16* %61, align 2
  %62 = getelementptr inbounds i8* %p_src, i32 2
  %63 = load i8* %62, align 1
  %64 = zext i8 %63 to i16
  %65 = getelementptr inbounds i8* %p_dst, i32 2
  %66 = load i8* %65, align 1
  %67 = zext i8 %66 to i16
  %68 = sub i16 %64, %67
  %69 = getelementptr inbounds i16* %level, i32 8
  store i16 %68, i16* %69, align 2
  %70 = getelementptr inbounds i8* %p_src, i32 18
  %71 = load i8* %70, align 1
  %72 = zext i8 %71 to i16
  %73 = getelementptr inbounds i8* %p_dst, i32 34
  %74 = load i8* %73, align 1
  %75 = zext i8 %74 to i16
  %76 = sub i16 %72, %75
  %77 = getelementptr inbounds i16* %level, i32 9
  store i16 %76, i16* %77, align 2
  %78 = getelementptr inbounds i8* %p_src, i32 34
  %79 = load i8* %78, align 1
  %80 = zext i8 %79 to i16
  %81 = getelementptr inbounds i8* %p_dst, i32 66
  %82 = load i8* %81, align 1
  %83 = zext i8 %82 to i16
  %84 = sub i16 %80, %83
  %85 = getelementptr inbounds i16* %level, i32 10
  store i16 %84, i16* %85, align 2
  %86 = getelementptr inbounds i8* %p_src, i32 50
  %87 = load i8* %86, align 1
  %88 = zext i8 %87 to i16
  %89 = getelementptr inbounds i8* %p_dst, i32 98
  %90 = load i8* %89, align 1
  %91 = zext i8 %90 to i16
  %92 = sub i16 %88, %91
  %93 = getelementptr inbounds i16* %level, i32 11
  store i16 %92, i16* %93, align 2
  %94 = getelementptr inbounds i8* %p_src, i32 3
  %95 = load i8* %94, align 1
  %96 = zext i8 %95 to i16
  %97 = getelementptr inbounds i8* %p_dst, i32 3
  %98 = load i8* %97, align 1
  %99 = zext i8 %98 to i16
  %100 = sub i16 %96, %99
  %101 = getelementptr inbounds i16* %level, i32 12
  store i16 %100, i16* %101, align 2
  %102 = getelementptr inbounds i8* %p_src, i32 19
  %103 = load i8* %102, align 1
  %104 = zext i8 %103 to i16
  %105 = getelementptr inbounds i8* %p_dst, i32 35
  %106 = load i8* %105, align 1
  %107 = zext i8 %106 to i16
  %108 = sub i16 %104, %107
  %109 = getelementptr inbounds i16* %level, i32 13
  store i16 %108, i16* %109, align 2
  %110 = getelementptr inbounds i8* %p_src, i32 35
  %111 = load i8* %110, align 1
  %112 = zext i8 %111 to i16
  %113 = getelementptr inbounds i8* %p_dst, i32 67
  %114 = load i8* %113, align 1
  %115 = zext i8 %114 to i16
  %116 = sub i16 %112, %115
  %117 = getelementptr inbounds i16* %level, i32 14
  store i16 %116, i16* %117, align 2
  %118 = getelementptr inbounds i8* %p_src, i32 51
  %119 = load i8* %118, align 1
  %120 = zext i8 %119 to i16
  %121 = getelementptr inbounds i8* %p_dst, i32 99
  %122 = load i8* %121, align 1
  %123 = zext i8 %122 to i16
  %124 = sub i16 %120, %123
  %125 = getelementptr inbounds i16* %level, i32 15
  store i16 %124, i16* %125, align 2
  %126 = or i16 %12, %5
  %127 = or i16 %126, %20
  %128 = or i16 %127, %28
  %129 = or i16 %128, %36
  %130 = or i16 %129, %44
  %131 = or i16 %130, %52
  %132 = or i16 %131, %60
  %133 = or i16 %132, %68
  %134 = or i16 %133, %76
  %135 = or i16 %134, %84
  %136 = or i16 %135, %92
  %137 = or i16 %136, %100
  %138 = or i16 %137, %108
  %139 = or i16 %138, %116
  %140 = or i16 %139, %124
  %141 = bitcast i8* %p_src to i32*
  %142 = load i32* %141, align 4
  %143 = bitcast i8* %p_dst to i32*
  store i32 %142, i32* %143, align 4
  %144 = bitcast i8* %6 to i32*
  %145 = load i32* %144, align 4
  %146 = bitcast i8* %9 to i32*
  store i32 %145, i32* %146, align 4
  %147 = bitcast i8* %22 to i32*
  %148 = load i32* %147, align 4
  %149 = bitcast i8* %25 to i32*
  store i32 %148, i32* %149, align 4
  %150 = bitcast i8* %30 to i32*
  %151 = load i32* %150, align 4
  %152 = bitcast i8* %33 to i32*
  store i32 %151, i32* %152, align 4
  %153 = icmp ne i16 %140, 0
  %154 = zext i1 %153 to i32
  ret i32 %154
}

define i32 @zigzag_sub_4x4ac_frame(i16* nocapture %level, i8* nocapture %p_src, i8* nocapture %p_dst, i16* nocapture %dc) nounwind {
  %1 = load i8* %p_src, align 1
  %2 = zext i8 %1 to i16
  %3 = load i8* %p_dst, align 1
  %4 = zext i8 %3 to i16
  %5 = sub i16 %2, %4
  store i16 %5, i16* %dc, align 2
  store i16 0, i16* %level, align 2
  %6 = getelementptr inbounds i8* %p_src, i32 1
  %7 = load i8* %6, align 1
  %8 = zext i8 %7 to i16
  %9 = getelementptr inbounds i8* %p_dst, i32 1
  %10 = load i8* %9, align 1
  %11 = zext i8 %10 to i16
  %12 = sub i16 %8, %11
  %13 = getelementptr inbounds i16* %level, i32 1
  store i16 %12, i16* %13, align 2
  %14 = getelementptr inbounds i8* %p_src, i32 16
  %15 = load i8* %14, align 1
  %16 = zext i8 %15 to i16
  %17 = getelementptr inbounds i8* %p_dst, i32 32
  %18 = load i8* %17, align 1
  %19 = zext i8 %18 to i16
  %20 = sub i16 %16, %19
  %21 = getelementptr inbounds i16* %level, i32 2
  store i16 %20, i16* %21, align 2
  %22 = getelementptr inbounds i8* %p_src, i32 32
  %23 = load i8* %22, align 1
  %24 = zext i8 %23 to i16
  %25 = getelementptr inbounds i8* %p_dst, i32 64
  %26 = load i8* %25, align 1
  %27 = zext i8 %26 to i16
  %28 = sub i16 %24, %27
  %29 = getelementptr inbounds i16* %level, i32 3
  store i16 %28, i16* %29, align 2
  %30 = getelementptr inbounds i8* %p_src, i32 17
  %31 = load i8* %30, align 1
  %32 = zext i8 %31 to i16
  %33 = getelementptr inbounds i8* %p_dst, i32 33
  %34 = load i8* %33, align 1
  %35 = zext i8 %34 to i16
  %36 = sub i16 %32, %35
  %37 = getelementptr inbounds i16* %level, i32 4
  store i16 %36, i16* %37, align 2
  %38 = getelementptr inbounds i8* %p_src, i32 2
  %39 = load i8* %38, align 1
  %40 = zext i8 %39 to i16
  %41 = getelementptr inbounds i8* %p_dst, i32 2
  %42 = load i8* %41, align 1
  %43 = zext i8 %42 to i16
  %44 = sub i16 %40, %43
  %45 = getelementptr inbounds i16* %level, i32 5
  store i16 %44, i16* %45, align 2
  %46 = getelementptr inbounds i8* %p_src, i32 3
  %47 = load i8* %46, align 1
  %48 = zext i8 %47 to i16
  %49 = getelementptr inbounds i8* %p_dst, i32 3
  %50 = load i8* %49, align 1
  %51 = zext i8 %50 to i16
  %52 = sub i16 %48, %51
  %53 = getelementptr inbounds i16* %level, i32 6
  store i16 %52, i16* %53, align 2
  %54 = getelementptr inbounds i8* %p_src, i32 18
  %55 = load i8* %54, align 1
  %56 = zext i8 %55 to i16
  %57 = getelementptr inbounds i8* %p_dst, i32 34
  %58 = load i8* %57, align 1
  %59 = zext i8 %58 to i16
  %60 = sub i16 %56, %59
  %61 = getelementptr inbounds i16* %level, i32 7
  store i16 %60, i16* %61, align 2
  %62 = getelementptr inbounds i8* %p_src, i32 33
  %63 = load i8* %62, align 1
  %64 = zext i8 %63 to i16
  %65 = getelementptr inbounds i8* %p_dst, i32 65
  %66 = load i8* %65, align 1
  %67 = zext i8 %66 to i16
  %68 = sub i16 %64, %67
  %69 = getelementptr inbounds i16* %level, i32 8
  store i16 %68, i16* %69, align 2
  %70 = getelementptr inbounds i8* %p_src, i32 48
  %71 = load i8* %70, align 1
  %72 = zext i8 %71 to i16
  %73 = getelementptr inbounds i8* %p_dst, i32 96
  %74 = load i8* %73, align 1
  %75 = zext i8 %74 to i16
  %76 = sub i16 %72, %75
  %77 = getelementptr inbounds i16* %level, i32 9
  store i16 %76, i16* %77, align 2
  %78 = getelementptr inbounds i8* %p_src, i32 49
  %79 = load i8* %78, align 1
  %80 = zext i8 %79 to i16
  %81 = getelementptr inbounds i8* %p_dst, i32 97
  %82 = load i8* %81, align 1
  %83 = zext i8 %82 to i16
  %84 = sub i16 %80, %83
  %85 = getelementptr inbounds i16* %level, i32 10
  store i16 %84, i16* %85, align 2
  %86 = getelementptr inbounds i8* %p_src, i32 34
  %87 = load i8* %86, align 1
  %88 = zext i8 %87 to i16
  %89 = getelementptr inbounds i8* %p_dst, i32 66
  %90 = load i8* %89, align 1
  %91 = zext i8 %90 to i16
  %92 = sub i16 %88, %91
  %93 = getelementptr inbounds i16* %level, i32 11
  store i16 %92, i16* %93, align 2
  %94 = getelementptr inbounds i8* %p_src, i32 19
  %95 = load i8* %94, align 1
  %96 = zext i8 %95 to i16
  %97 = getelementptr inbounds i8* %p_dst, i32 35
  %98 = load i8* %97, align 1
  %99 = zext i8 %98 to i16
  %100 = sub i16 %96, %99
  %101 = getelementptr inbounds i16* %level, i32 12
  store i16 %100, i16* %101, align 2
  %102 = getelementptr inbounds i8* %p_src, i32 35
  %103 = load i8* %102, align 1
  %104 = zext i8 %103 to i16
  %105 = getelementptr inbounds i8* %p_dst, i32 67
  %106 = load i8* %105, align 1
  %107 = zext i8 %106 to i16
  %108 = sub i16 %104, %107
  %109 = getelementptr inbounds i16* %level, i32 13
  store i16 %108, i16* %109, align 2
  %110 = getelementptr inbounds i8* %p_src, i32 50
  %111 = load i8* %110, align 1
  %112 = zext i8 %111 to i16
  %113 = getelementptr inbounds i8* %p_dst, i32 98
  %114 = load i8* %113, align 1
  %115 = zext i8 %114 to i16
  %116 = sub i16 %112, %115
  %117 = getelementptr inbounds i16* %level, i32 14
  store i16 %116, i16* %117, align 2
  %118 = getelementptr inbounds i8* %p_src, i32 51
  %119 = load i8* %118, align 1
  %120 = zext i8 %119 to i16
  %121 = getelementptr inbounds i8* %p_dst, i32 99
  %122 = load i8* %121, align 1
  %123 = zext i8 %122 to i16
  %124 = sub i16 %120, %123
  %125 = getelementptr inbounds i16* %level, i32 15
  store i16 %124, i16* %125, align 2
  %126 = or i16 %20, %12
  %127 = or i16 %126, %28
  %128 = or i16 %127, %36
  %129 = or i16 %128, %44
  %130 = or i16 %129, %52
  %131 = or i16 %130, %60
  %132 = or i16 %131, %68
  %133 = or i16 %132, %76
  %134 = or i16 %133, %84
  %135 = or i16 %134, %92
  %136 = or i16 %135, %100
  %137 = or i16 %136, %108
  %138 = or i16 %137, %116
  %139 = or i16 %138, %124
  %140 = bitcast i8* %p_src to i32*
  %141 = load i32* %140, align 4
  %142 = bitcast i8* %p_dst to i32*
  store i32 %141, i32* %142, align 4
  %143 = bitcast i8* %14 to i32*
  %144 = load i32* %143, align 4
  %145 = bitcast i8* %17 to i32*
  store i32 %144, i32* %145, align 4
  %146 = bitcast i8* %22 to i32*
  %147 = load i32* %146, align 4
  %148 = bitcast i8* %25 to i32*
  store i32 %147, i32* %148, align 4
  %149 = bitcast i8* %70 to i32*
  %150 = load i32* %149, align 4
  %151 = bitcast i8* %73 to i32*
  store i32 %150, i32* %151, align 4
  %152 = icmp ne i16 %139, 0
  %153 = zext i1 %152 to i32
  ret i32 %153
}

define i32 @zigzag_sub_4x4ac_field(i16* nocapture %level, i8* nocapture %p_src, i8* nocapture %p_dst, i16* nocapture %dc) nounwind {
  %1 = load i8* %p_src, align 1
  %2 = zext i8 %1 to i16
  %3 = load i8* %p_dst, align 1
  %4 = zext i8 %3 to i16
  %5 = sub i16 %2, %4
  store i16 %5, i16* %dc, align 2
  store i16 0, i16* %level, align 2
  %6 = getelementptr inbounds i8* %p_src, i32 16
  %7 = load i8* %6, align 1
  %8 = zext i8 %7 to i16
  %9 = getelementptr inbounds i8* %p_dst, i32 32
  %10 = load i8* %9, align 1
  %11 = zext i8 %10 to i16
  %12 = sub i16 %8, %11
  %13 = getelementptr inbounds i16* %level, i32 1
  store i16 %12, i16* %13, align 2
  %14 = getelementptr inbounds i8* %p_src, i32 1
  %15 = load i8* %14, align 1
  %16 = zext i8 %15 to i16
  %17 = getelementptr inbounds i8* %p_dst, i32 1
  %18 = load i8* %17, align 1
  %19 = zext i8 %18 to i16
  %20 = sub i16 %16, %19
  %21 = getelementptr inbounds i16* %level, i32 2
  store i16 %20, i16* %21, align 2
  %22 = getelementptr inbounds i8* %p_src, i32 32
  %23 = load i8* %22, align 1
  %24 = zext i8 %23 to i16
  %25 = getelementptr inbounds i8* %p_dst, i32 64
  %26 = load i8* %25, align 1
  %27 = zext i8 %26 to i16
  %28 = sub i16 %24, %27
  %29 = getelementptr inbounds i16* %level, i32 3
  store i16 %28, i16* %29, align 2
  %30 = getelementptr inbounds i8* %p_src, i32 48
  %31 = load i8* %30, align 1
  %32 = zext i8 %31 to i16
  %33 = getelementptr inbounds i8* %p_dst, i32 96
  %34 = load i8* %33, align 1
  %35 = zext i8 %34 to i16
  %36 = sub i16 %32, %35
  %37 = getelementptr inbounds i16* %level, i32 4
  store i16 %36, i16* %37, align 2
  %38 = getelementptr inbounds i8* %p_src, i32 17
  %39 = load i8* %38, align 1
  %40 = zext i8 %39 to i16
  %41 = getelementptr inbounds i8* %p_dst, i32 33
  %42 = load i8* %41, align 1
  %43 = zext i8 %42 to i16
  %44 = sub i16 %40, %43
  %45 = getelementptr inbounds i16* %level, i32 5
  store i16 %44, i16* %45, align 2
  %46 = getelementptr inbounds i8* %p_src, i32 33
  %47 = load i8* %46, align 1
  %48 = zext i8 %47 to i16
  %49 = getelementptr inbounds i8* %p_dst, i32 65
  %50 = load i8* %49, align 1
  %51 = zext i8 %50 to i16
  %52 = sub i16 %48, %51
  %53 = getelementptr inbounds i16* %level, i32 6
  store i16 %52, i16* %53, align 2
  %54 = getelementptr inbounds i8* %p_src, i32 49
  %55 = load i8* %54, align 1
  %56 = zext i8 %55 to i16
  %57 = getelementptr inbounds i8* %p_dst, i32 97
  %58 = load i8* %57, align 1
  %59 = zext i8 %58 to i16
  %60 = sub i16 %56, %59
  %61 = getelementptr inbounds i16* %level, i32 7
  store i16 %60, i16* %61, align 2
  %62 = getelementptr inbounds i8* %p_src, i32 2
  %63 = load i8* %62, align 1
  %64 = zext i8 %63 to i16
  %65 = getelementptr inbounds i8* %p_dst, i32 2
  %66 = load i8* %65, align 1
  %67 = zext i8 %66 to i16
  %68 = sub i16 %64, %67
  %69 = getelementptr inbounds i16* %level, i32 8
  store i16 %68, i16* %69, align 2
  %70 = getelementptr inbounds i8* %p_src, i32 18
  %71 = load i8* %70, align 1
  %72 = zext i8 %71 to i16
  %73 = getelementptr inbounds i8* %p_dst, i32 34
  %74 = load i8* %73, align 1
  %75 = zext i8 %74 to i16
  %76 = sub i16 %72, %75
  %77 = getelementptr inbounds i16* %level, i32 9
  store i16 %76, i16* %77, align 2
  %78 = getelementptr inbounds i8* %p_src, i32 34
  %79 = load i8* %78, align 1
  %80 = zext i8 %79 to i16
  %81 = getelementptr inbounds i8* %p_dst, i32 66
  %82 = load i8* %81, align 1
  %83 = zext i8 %82 to i16
  %84 = sub i16 %80, %83
  %85 = getelementptr inbounds i16* %level, i32 10
  store i16 %84, i16* %85, align 2
  %86 = getelementptr inbounds i8* %p_src, i32 50
  %87 = load i8* %86, align 1
  %88 = zext i8 %87 to i16
  %89 = getelementptr inbounds i8* %p_dst, i32 98
  %90 = load i8* %89, align 1
  %91 = zext i8 %90 to i16
  %92 = sub i16 %88, %91
  %93 = getelementptr inbounds i16* %level, i32 11
  store i16 %92, i16* %93, align 2
  %94 = getelementptr inbounds i8* %p_src, i32 3
  %95 = load i8* %94, align 1
  %96 = zext i8 %95 to i16
  %97 = getelementptr inbounds i8* %p_dst, i32 3
  %98 = load i8* %97, align 1
  %99 = zext i8 %98 to i16
  %100 = sub i16 %96, %99
  %101 = getelementptr inbounds i16* %level, i32 12
  store i16 %100, i16* %101, align 2
  %102 = getelementptr inbounds i8* %p_src, i32 19
  %103 = load i8* %102, align 1
  %104 = zext i8 %103 to i16
  %105 = getelementptr inbounds i8* %p_dst, i32 35
  %106 = load i8* %105, align 1
  %107 = zext i8 %106 to i16
  %108 = sub i16 %104, %107
  %109 = getelementptr inbounds i16* %level, i32 13
  store i16 %108, i16* %109, align 2
  %110 = getelementptr inbounds i8* %p_src, i32 35
  %111 = load i8* %110, align 1
  %112 = zext i8 %111 to i16
  %113 = getelementptr inbounds i8* %p_dst, i32 67
  %114 = load i8* %113, align 1
  %115 = zext i8 %114 to i16
  %116 = sub i16 %112, %115
  %117 = getelementptr inbounds i16* %level, i32 14
  store i16 %116, i16* %117, align 2
  %118 = getelementptr inbounds i8* %p_src, i32 51
  %119 = load i8* %118, align 1
  %120 = zext i8 %119 to i16
  %121 = getelementptr inbounds i8* %p_dst, i32 99
  %122 = load i8* %121, align 1
  %123 = zext i8 %122 to i16
  %124 = sub i16 %120, %123
  %125 = getelementptr inbounds i16* %level, i32 15
  store i16 %124, i16* %125, align 2
  %126 = or i16 %20, %12
  %127 = or i16 %126, %28
  %128 = or i16 %127, %36
  %129 = or i16 %128, %44
  %130 = or i16 %129, %52
  %131 = or i16 %130, %60
  %132 = or i16 %131, %68
  %133 = or i16 %132, %76
  %134 = or i16 %133, %84
  %135 = or i16 %134, %92
  %136 = or i16 %135, %100
  %137 = or i16 %136, %108
  %138 = or i16 %137, %116
  %139 = or i16 %138, %124
  %140 = bitcast i8* %p_src to i32*
  %141 = load i32* %140, align 4
  %142 = bitcast i8* %p_dst to i32*
  store i32 %141, i32* %142, align 4
  %143 = bitcast i8* %6 to i32*
  %144 = load i32* %143, align 4
  %145 = bitcast i8* %9 to i32*
  store i32 %144, i32* %145, align 4
  %146 = bitcast i8* %22 to i32*
  %147 = load i32* %146, align 4
  %148 = bitcast i8* %25 to i32*
  store i32 %147, i32* %148, align 4
  %149 = bitcast i8* %30 to i32*
  %150 = load i32* %149, align 4
  %151 = bitcast i8* %33 to i32*
  store i32 %150, i32* %151, align 4
  %152 = icmp ne i16 %139, 0
  %153 = zext i1 %152 to i32
  ret i32 %153
}

define i32 @zigzag_sub_8x8_frame(i16* %level, i8* %p_src, i8* %p_dst) nounwind {
  %1 = load i8* %p_src, align 1
  %2 = zext i8 %1 to i16
  %3 = load i8* %p_dst, align 1
  %4 = zext i8 %3 to i16
  %5 = sub i16 %2, %4
  store i16 %5, i16* %level, align 2
  %6 = getelementptr inbounds i8* %p_src, i32 1
  %7 = load i8* %6, align 1
  %8 = zext i8 %7 to i16
  %9 = getelementptr inbounds i8* %p_dst, i32 1
  %10 = load i8* %9, align 1
  %11 = zext i8 %10 to i16
  %12 = sub i16 %8, %11
  %13 = getelementptr inbounds i16* %level, i32 1
  store i16 %12, i16* %13, align 2
  %14 = getelementptr inbounds i8* %p_src, i32 16
  %15 = load i8* %14, align 1
  %16 = zext i8 %15 to i16
  %17 = getelementptr inbounds i8* %p_dst, i32 32
  %18 = load i8* %17, align 1
  %19 = zext i8 %18 to i16
  %20 = sub i16 %16, %19
  %21 = getelementptr inbounds i16* %level, i32 2
  store i16 %20, i16* %21, align 2
  %22 = getelementptr inbounds i8* %p_src, i32 32
  %23 = load i8* %22, align 1
  %24 = zext i8 %23 to i16
  %25 = getelementptr inbounds i8* %p_dst, i32 64
  %26 = load i8* %25, align 1
  %27 = zext i8 %26 to i16
  %28 = sub i16 %24, %27
  %29 = getelementptr inbounds i16* %level, i32 3
  store i16 %28, i16* %29, align 2
  %30 = getelementptr inbounds i8* %p_src, i32 17
  %31 = load i8* %30, align 1
  %32 = zext i8 %31 to i16
  %33 = getelementptr inbounds i8* %p_dst, i32 33
  %34 = load i8* %33, align 1
  %35 = zext i8 %34 to i16
  %36 = sub i16 %32, %35
  %37 = getelementptr inbounds i16* %level, i32 4
  store i16 %36, i16* %37, align 2
  %38 = getelementptr inbounds i8* %p_src, i32 2
  %39 = load i8* %38, align 1
  %40 = zext i8 %39 to i16
  %41 = getelementptr inbounds i8* %p_dst, i32 2
  %42 = load i8* %41, align 1
  %43 = zext i8 %42 to i16
  %44 = sub i16 %40, %43
  %45 = getelementptr inbounds i16* %level, i32 5
  store i16 %44, i16* %45, align 2
  %46 = getelementptr inbounds i8* %p_src, i32 3
  %47 = load i8* %46, align 1
  %48 = zext i8 %47 to i16
  %49 = getelementptr inbounds i8* %p_dst, i32 3
  %50 = load i8* %49, align 1
  %51 = zext i8 %50 to i16
  %52 = sub i16 %48, %51
  %53 = getelementptr inbounds i16* %level, i32 6
  store i16 %52, i16* %53, align 2
  %54 = getelementptr inbounds i8* %p_src, i32 18
  %55 = load i8* %54, align 1
  %56 = zext i8 %55 to i16
  %57 = getelementptr inbounds i8* %p_dst, i32 34
  %58 = load i8* %57, align 1
  %59 = zext i8 %58 to i16
  %60 = sub i16 %56, %59
  %61 = getelementptr inbounds i16* %level, i32 7
  store i16 %60, i16* %61, align 2
  %62 = getelementptr inbounds i8* %p_src, i32 33
  %63 = load i8* %62, align 1
  %64 = zext i8 %63 to i16
  %65 = getelementptr inbounds i8* %p_dst, i32 65
  %66 = load i8* %65, align 1
  %67 = zext i8 %66 to i16
  %68 = sub i16 %64, %67
  %69 = getelementptr inbounds i16* %level, i32 8
  store i16 %68, i16* %69, align 2
  %70 = getelementptr inbounds i8* %p_src, i32 48
  %71 = load i8* %70, align 1
  %72 = zext i8 %71 to i16
  %73 = getelementptr inbounds i8* %p_dst, i32 96
  %74 = load i8* %73, align 1
  %75 = zext i8 %74 to i16
  %76 = sub i16 %72, %75
  %77 = getelementptr inbounds i16* %level, i32 9
  store i16 %76, i16* %77, align 2
  %78 = getelementptr inbounds i8* %p_src, i32 64
  %79 = load i8* %78, align 1
  %80 = zext i8 %79 to i16
  %81 = getelementptr inbounds i8* %p_dst, i32 128
  %82 = load i8* %81, align 1
  %83 = zext i8 %82 to i16
  %84 = sub i16 %80, %83
  %85 = getelementptr inbounds i16* %level, i32 10
  store i16 %84, i16* %85, align 2
  %86 = getelementptr inbounds i8* %p_src, i32 49
  %87 = load i8* %86, align 1
  %88 = zext i8 %87 to i16
  %89 = getelementptr inbounds i8* %p_dst, i32 97
  %90 = load i8* %89, align 1
  %91 = zext i8 %90 to i16
  %92 = sub i16 %88, %91
  %93 = getelementptr inbounds i16* %level, i32 11
  store i16 %92, i16* %93, align 2
  %94 = getelementptr inbounds i8* %p_src, i32 34
  %95 = load i8* %94, align 1
  %96 = zext i8 %95 to i16
  %97 = getelementptr inbounds i8* %p_dst, i32 66
  %98 = load i8* %97, align 1
  %99 = zext i8 %98 to i16
  %100 = sub i16 %96, %99
  %101 = getelementptr inbounds i16* %level, i32 12
  store i16 %100, i16* %101, align 2
  %102 = getelementptr inbounds i8* %p_src, i32 19
  %103 = load i8* %102, align 1
  %104 = zext i8 %103 to i16
  %105 = getelementptr inbounds i8* %p_dst, i32 35
  %106 = load i8* %105, align 1
  %107 = zext i8 %106 to i16
  %108 = sub i16 %104, %107
  %109 = getelementptr inbounds i16* %level, i32 13
  store i16 %108, i16* %109, align 2
  %110 = getelementptr inbounds i8* %p_src, i32 4
  %111 = load i8* %110, align 1
  %112 = zext i8 %111 to i16
  %113 = getelementptr inbounds i8* %p_dst, i32 4
  %114 = load i8* %113, align 1
  %115 = zext i8 %114 to i16
  %116 = sub i16 %112, %115
  %117 = getelementptr inbounds i16* %level, i32 14
  store i16 %116, i16* %117, align 2
  %118 = getelementptr inbounds i8* %p_src, i32 5
  %119 = load i8* %118, align 1
  %120 = zext i8 %119 to i16
  %121 = getelementptr inbounds i8* %p_dst, i32 5
  %122 = load i8* %121, align 1
  %123 = zext i8 %122 to i16
  %124 = sub i16 %120, %123
  %125 = getelementptr inbounds i16* %level, i32 15
  store i16 %124, i16* %125, align 2
  %126 = getelementptr inbounds i8* %p_src, i32 20
  %127 = load i8* %126, align 1
  %128 = zext i8 %127 to i16
  %129 = getelementptr inbounds i8* %p_dst, i32 36
  %130 = load i8* %129, align 1
  %131 = zext i8 %130 to i16
  %132 = sub i16 %128, %131
  %133 = getelementptr inbounds i16* %level, i32 16
  store i16 %132, i16* %133, align 2
  %134 = getelementptr inbounds i8* %p_src, i32 35
  %135 = load i8* %134, align 1
  %136 = zext i8 %135 to i16
  %137 = getelementptr inbounds i8* %p_dst, i32 67
  %138 = load i8* %137, align 1
  %139 = zext i8 %138 to i16
  %140 = sub i16 %136, %139
  %141 = getelementptr inbounds i16* %level, i32 17
  store i16 %140, i16* %141, align 2
  %142 = getelementptr inbounds i8* %p_src, i32 50
  %143 = load i8* %142, align 1
  %144 = zext i8 %143 to i16
  %145 = getelementptr inbounds i8* %p_dst, i32 98
  %146 = load i8* %145, align 1
  %147 = zext i8 %146 to i16
  %148 = sub i16 %144, %147
  %149 = getelementptr inbounds i16* %level, i32 18
  store i16 %148, i16* %149, align 2
  %150 = getelementptr inbounds i8* %p_src, i32 65
  %151 = load i8* %150, align 1
  %152 = zext i8 %151 to i16
  %153 = getelementptr inbounds i8* %p_dst, i32 129
  %154 = load i8* %153, align 1
  %155 = zext i8 %154 to i16
  %156 = sub i16 %152, %155
  %157 = getelementptr inbounds i16* %level, i32 19
  store i16 %156, i16* %157, align 2
  %158 = getelementptr inbounds i8* %p_src, i32 80
  %159 = load i8* %158, align 1
  %160 = zext i8 %159 to i16
  %161 = getelementptr inbounds i8* %p_dst, i32 160
  %162 = load i8* %161, align 1
  %163 = zext i8 %162 to i16
  %164 = sub i16 %160, %163
  %165 = getelementptr inbounds i16* %level, i32 20
  store i16 %164, i16* %165, align 2
  %166 = getelementptr inbounds i8* %p_src, i32 96
  %167 = load i8* %166, align 1
  %168 = zext i8 %167 to i16
  %169 = getelementptr inbounds i8* %p_dst, i32 192
  %170 = load i8* %169, align 1
  %171 = zext i8 %170 to i16
  %172 = sub i16 %168, %171
  %173 = getelementptr inbounds i16* %level, i32 21
  store i16 %172, i16* %173, align 2
  %174 = getelementptr inbounds i8* %p_src, i32 81
  %175 = load i8* %174, align 1
  %176 = zext i8 %175 to i16
  %177 = getelementptr inbounds i8* %p_dst, i32 161
  %178 = load i8* %177, align 1
  %179 = zext i8 %178 to i16
  %180 = sub i16 %176, %179
  %181 = getelementptr inbounds i16* %level, i32 22
  store i16 %180, i16* %181, align 2
  %182 = getelementptr inbounds i8* %p_src, i32 66
  %183 = load i8* %182, align 1
  %184 = zext i8 %183 to i16
  %185 = getelementptr inbounds i8* %p_dst, i32 130
  %186 = load i8* %185, align 1
  %187 = zext i8 %186 to i16
  %188 = sub i16 %184, %187
  %189 = getelementptr inbounds i16* %level, i32 23
  store i16 %188, i16* %189, align 2
  %190 = getelementptr inbounds i8* %p_src, i32 51
  %191 = load i8* %190, align 1
  %192 = zext i8 %191 to i16
  %193 = getelementptr inbounds i8* %p_dst, i32 99
  %194 = load i8* %193, align 1
  %195 = zext i8 %194 to i16
  %196 = sub i16 %192, %195
  %197 = getelementptr inbounds i16* %level, i32 24
  store i16 %196, i16* %197, align 2
  %198 = getelementptr inbounds i8* %p_src, i32 36
  %199 = load i8* %198, align 1
  %200 = zext i8 %199 to i16
  %201 = getelementptr inbounds i8* %p_dst, i32 68
  %202 = load i8* %201, align 1
  %203 = zext i8 %202 to i16
  %204 = sub i16 %200, %203
  %205 = getelementptr inbounds i16* %level, i32 25
  store i16 %204, i16* %205, align 2
  %206 = getelementptr inbounds i8* %p_src, i32 21
  %207 = load i8* %206, align 1
  %208 = zext i8 %207 to i16
  %209 = getelementptr inbounds i8* %p_dst, i32 37
  %210 = load i8* %209, align 1
  %211 = zext i8 %210 to i16
  %212 = sub i16 %208, %211
  %213 = getelementptr inbounds i16* %level, i32 26
  store i16 %212, i16* %213, align 2
  %214 = getelementptr inbounds i8* %p_src, i32 6
  %215 = load i8* %214, align 1
  %216 = zext i8 %215 to i16
  %217 = getelementptr inbounds i8* %p_dst, i32 6
  %218 = load i8* %217, align 1
  %219 = zext i8 %218 to i16
  %220 = sub i16 %216, %219
  %221 = getelementptr inbounds i16* %level, i32 27
  store i16 %220, i16* %221, align 2
  %222 = getelementptr inbounds i8* %p_src, i32 7
  %223 = load i8* %222, align 1
  %224 = zext i8 %223 to i16
  %225 = getelementptr inbounds i8* %p_dst, i32 7
  %226 = load i8* %225, align 1
  %227 = zext i8 %226 to i16
  %228 = sub i16 %224, %227
  %229 = getelementptr inbounds i16* %level, i32 28
  store i16 %228, i16* %229, align 2
  %230 = getelementptr inbounds i8* %p_src, i32 22
  %231 = load i8* %230, align 1
  %232 = zext i8 %231 to i16
  %233 = getelementptr inbounds i8* %p_dst, i32 38
  %234 = load i8* %233, align 1
  %235 = zext i8 %234 to i16
  %236 = sub i16 %232, %235
  %237 = getelementptr inbounds i16* %level, i32 29
  store i16 %236, i16* %237, align 2
  %238 = getelementptr inbounds i8* %p_src, i32 37
  %239 = load i8* %238, align 1
  %240 = zext i8 %239 to i16
  %241 = getelementptr inbounds i8* %p_dst, i32 69
  %242 = load i8* %241, align 1
  %243 = zext i8 %242 to i16
  %244 = sub i16 %240, %243
  %245 = getelementptr inbounds i16* %level, i32 30
  store i16 %244, i16* %245, align 2
  %246 = getelementptr inbounds i8* %p_src, i32 52
  %247 = load i8* %246, align 1
  %248 = zext i8 %247 to i16
  %249 = getelementptr inbounds i8* %p_dst, i32 100
  %250 = load i8* %249, align 1
  %251 = zext i8 %250 to i16
  %252 = sub i16 %248, %251
  %253 = getelementptr inbounds i16* %level, i32 31
  store i16 %252, i16* %253, align 2
  %254 = getelementptr inbounds i8* %p_src, i32 67
  %255 = load i8* %254, align 1
  %256 = zext i8 %255 to i16
  %257 = getelementptr inbounds i8* %p_dst, i32 131
  %258 = load i8* %257, align 1
  %259 = zext i8 %258 to i16
  %260 = sub i16 %256, %259
  %261 = getelementptr inbounds i16* %level, i32 32
  store i16 %260, i16* %261, align 2
  %262 = getelementptr inbounds i8* %p_src, i32 82
  %263 = load i8* %262, align 1
  %264 = zext i8 %263 to i16
  %265 = getelementptr inbounds i8* %p_dst, i32 162
  %266 = load i8* %265, align 1
  %267 = zext i8 %266 to i16
  %268 = sub i16 %264, %267
  %269 = getelementptr inbounds i16* %level, i32 33
  store i16 %268, i16* %269, align 2
  %270 = getelementptr inbounds i8* %p_src, i32 97
  %271 = load i8* %270, align 1
  %272 = zext i8 %271 to i16
  %273 = getelementptr inbounds i8* %p_dst, i32 193
  %274 = load i8* %273, align 1
  %275 = zext i8 %274 to i16
  %276 = sub i16 %272, %275
  %277 = getelementptr inbounds i16* %level, i32 34
  store i16 %276, i16* %277, align 2
  %278 = getelementptr inbounds i8* %p_src, i32 112
  %279 = load i8* %278, align 1
  %280 = zext i8 %279 to i16
  %281 = getelementptr inbounds i8* %p_dst, i32 224
  %282 = load i8* %281, align 1
  %283 = zext i8 %282 to i16
  %284 = sub i16 %280, %283
  %285 = getelementptr inbounds i16* %level, i32 35
  store i16 %284, i16* %285, align 2
  %286 = getelementptr inbounds i8* %p_src, i32 113
  %287 = load i8* %286, align 1
  %288 = zext i8 %287 to i16
  %289 = getelementptr inbounds i8* %p_dst, i32 225
  %290 = load i8* %289, align 1
  %291 = zext i8 %290 to i16
  %292 = sub i16 %288, %291
  %293 = getelementptr inbounds i16* %level, i32 36
  store i16 %292, i16* %293, align 2
  %294 = getelementptr inbounds i8* %p_src, i32 98
  %295 = load i8* %294, align 1
  %296 = zext i8 %295 to i16
  %297 = getelementptr inbounds i8* %p_dst, i32 194
  %298 = load i8* %297, align 1
  %299 = zext i8 %298 to i16
  %300 = sub i16 %296, %299
  %301 = getelementptr inbounds i16* %level, i32 37
  store i16 %300, i16* %301, align 2
  %302 = getelementptr inbounds i8* %p_src, i32 83
  %303 = load i8* %302, align 1
  %304 = zext i8 %303 to i16
  %305 = getelementptr inbounds i8* %p_dst, i32 163
  %306 = load i8* %305, align 1
  %307 = zext i8 %306 to i16
  %308 = sub i16 %304, %307
  %309 = getelementptr inbounds i16* %level, i32 38
  store i16 %308, i16* %309, align 2
  %310 = getelementptr inbounds i8* %p_src, i32 68
  %311 = load i8* %310, align 1
  %312 = zext i8 %311 to i16
  %313 = getelementptr inbounds i8* %p_dst, i32 132
  %314 = load i8* %313, align 1
  %315 = zext i8 %314 to i16
  %316 = sub i16 %312, %315
  %317 = getelementptr inbounds i16* %level, i32 39
  store i16 %316, i16* %317, align 2
  %318 = getelementptr inbounds i8* %p_src, i32 53
  %319 = load i8* %318, align 1
  %320 = zext i8 %319 to i16
  %321 = getelementptr inbounds i8* %p_dst, i32 101
  %322 = load i8* %321, align 1
  %323 = zext i8 %322 to i16
  %324 = sub i16 %320, %323
  %325 = getelementptr inbounds i16* %level, i32 40
  store i16 %324, i16* %325, align 2
  %326 = getelementptr inbounds i8* %p_src, i32 38
  %327 = load i8* %326, align 1
  %328 = zext i8 %327 to i16
  %329 = getelementptr inbounds i8* %p_dst, i32 70
  %330 = load i8* %329, align 1
  %331 = zext i8 %330 to i16
  %332 = sub i16 %328, %331
  %333 = getelementptr inbounds i16* %level, i32 41
  store i16 %332, i16* %333, align 2
  %334 = getelementptr inbounds i8* %p_src, i32 23
  %335 = load i8* %334, align 1
  %336 = zext i8 %335 to i16
  %337 = getelementptr inbounds i8* %p_dst, i32 39
  %338 = load i8* %337, align 1
  %339 = zext i8 %338 to i16
  %340 = sub i16 %336, %339
  %341 = getelementptr inbounds i16* %level, i32 42
  store i16 %340, i16* %341, align 2
  %342 = getelementptr inbounds i8* %p_src, i32 39
  %343 = load i8* %342, align 1
  %344 = zext i8 %343 to i16
  %345 = getelementptr inbounds i8* %p_dst, i32 71
  %346 = load i8* %345, align 1
  %347 = zext i8 %346 to i16
  %348 = sub i16 %344, %347
  %349 = getelementptr inbounds i16* %level, i32 43
  store i16 %348, i16* %349, align 2
  %350 = getelementptr inbounds i8* %p_src, i32 54
  %351 = load i8* %350, align 1
  %352 = zext i8 %351 to i16
  %353 = getelementptr inbounds i8* %p_dst, i32 102
  %354 = load i8* %353, align 1
  %355 = zext i8 %354 to i16
  %356 = sub i16 %352, %355
  %357 = getelementptr inbounds i16* %level, i32 44
  store i16 %356, i16* %357, align 2
  %358 = getelementptr inbounds i8* %p_src, i32 69
  %359 = load i8* %358, align 1
  %360 = zext i8 %359 to i16
  %361 = getelementptr inbounds i8* %p_dst, i32 133
  %362 = load i8* %361, align 1
  %363 = zext i8 %362 to i16
  %364 = sub i16 %360, %363
  %365 = getelementptr inbounds i16* %level, i32 45
  store i16 %364, i16* %365, align 2
  %366 = getelementptr inbounds i8* %p_src, i32 84
  %367 = load i8* %366, align 1
  %368 = zext i8 %367 to i16
  %369 = getelementptr inbounds i8* %p_dst, i32 164
  %370 = load i8* %369, align 1
  %371 = zext i8 %370 to i16
  %372 = sub i16 %368, %371
  %373 = getelementptr inbounds i16* %level, i32 46
  store i16 %372, i16* %373, align 2
  %374 = getelementptr inbounds i8* %p_src, i32 99
  %375 = load i8* %374, align 1
  %376 = zext i8 %375 to i16
  %377 = getelementptr inbounds i8* %p_dst, i32 195
  %378 = load i8* %377, align 1
  %379 = zext i8 %378 to i16
  %380 = sub i16 %376, %379
  %381 = getelementptr inbounds i16* %level, i32 47
  store i16 %380, i16* %381, align 2
  %382 = getelementptr inbounds i8* %p_src, i32 114
  %383 = load i8* %382, align 1
  %384 = zext i8 %383 to i16
  %385 = getelementptr inbounds i8* %p_dst, i32 226
  %386 = load i8* %385, align 1
  %387 = zext i8 %386 to i16
  %388 = sub i16 %384, %387
  %389 = getelementptr inbounds i16* %level, i32 48
  store i16 %388, i16* %389, align 2
  %390 = getelementptr inbounds i8* %p_src, i32 115
  %391 = load i8* %390, align 1
  %392 = zext i8 %391 to i16
  %393 = getelementptr inbounds i8* %p_dst, i32 227
  %394 = load i8* %393, align 1
  %395 = zext i8 %394 to i16
  %396 = sub i16 %392, %395
  %397 = getelementptr inbounds i16* %level, i32 49
  store i16 %396, i16* %397, align 2
  %398 = getelementptr inbounds i8* %p_src, i32 100
  %399 = load i8* %398, align 1
  %400 = zext i8 %399 to i16
  %401 = getelementptr inbounds i8* %p_dst, i32 196
  %402 = load i8* %401, align 1
  %403 = zext i8 %402 to i16
  %404 = sub i16 %400, %403
  %405 = getelementptr inbounds i16* %level, i32 50
  store i16 %404, i16* %405, align 2
  %406 = getelementptr inbounds i8* %p_src, i32 85
  %407 = load i8* %406, align 1
  %408 = zext i8 %407 to i16
  %409 = getelementptr inbounds i8* %p_dst, i32 165
  %410 = load i8* %409, align 1
  %411 = zext i8 %410 to i16
  %412 = sub i16 %408, %411
  %413 = getelementptr inbounds i16* %level, i32 51
  store i16 %412, i16* %413, align 2
  %414 = getelementptr inbounds i8* %p_src, i32 70
  %415 = load i8* %414, align 1
  %416 = zext i8 %415 to i16
  %417 = getelementptr inbounds i8* %p_dst, i32 134
  %418 = load i8* %417, align 1
  %419 = zext i8 %418 to i16
  %420 = sub i16 %416, %419
  %421 = getelementptr inbounds i16* %level, i32 52
  store i16 %420, i16* %421, align 2
  %422 = getelementptr inbounds i8* %p_src, i32 55
  %423 = load i8* %422, align 1
  %424 = zext i8 %423 to i16
  %425 = getelementptr inbounds i8* %p_dst, i32 103
  %426 = load i8* %425, align 1
  %427 = zext i8 %426 to i16
  %428 = sub i16 %424, %427
  %429 = getelementptr inbounds i16* %level, i32 53
  store i16 %428, i16* %429, align 2
  %430 = getelementptr inbounds i8* %p_src, i32 71
  %431 = load i8* %430, align 1
  %432 = zext i8 %431 to i16
  %433 = getelementptr inbounds i8* %p_dst, i32 135
  %434 = load i8* %433, align 1
  %435 = zext i8 %434 to i16
  %436 = sub i16 %432, %435
  %437 = getelementptr inbounds i16* %level, i32 54
  store i16 %436, i16* %437, align 2
  %438 = getelementptr inbounds i8* %p_src, i32 86
  %439 = load i8* %438, align 1
  %440 = zext i8 %439 to i16
  %441 = getelementptr inbounds i8* %p_dst, i32 166
  %442 = load i8* %441, align 1
  %443 = zext i8 %442 to i16
  %444 = sub i16 %440, %443
  %445 = getelementptr inbounds i16* %level, i32 55
  store i16 %444, i16* %445, align 2
  %446 = getelementptr inbounds i8* %p_src, i32 101
  %447 = load i8* %446, align 1
  %448 = zext i8 %447 to i16
  %449 = getelementptr inbounds i8* %p_dst, i32 197
  %450 = load i8* %449, align 1
  %451 = zext i8 %450 to i16
  %452 = sub i16 %448, %451
  %453 = getelementptr inbounds i16* %level, i32 56
  store i16 %452, i16* %453, align 2
  %454 = getelementptr inbounds i8* %p_src, i32 116
  %455 = load i8* %454, align 1
  %456 = zext i8 %455 to i16
  %457 = getelementptr inbounds i8* %p_dst, i32 228
  %458 = load i8* %457, align 1
  %459 = zext i8 %458 to i16
  %460 = sub i16 %456, %459
  %461 = getelementptr inbounds i16* %level, i32 57
  store i16 %460, i16* %461, align 2
  %462 = getelementptr inbounds i8* %p_src, i32 117
  %463 = load i8* %462, align 1
  %464 = zext i8 %463 to i16
  %465 = getelementptr inbounds i8* %p_dst, i32 229
  %466 = load i8* %465, align 1
  %467 = zext i8 %466 to i16
  %468 = sub i16 %464, %467
  %469 = getelementptr inbounds i16* %level, i32 58
  store i16 %468, i16* %469, align 2
  %470 = getelementptr inbounds i8* %p_src, i32 102
  %471 = load i8* %470, align 1
  %472 = zext i8 %471 to i16
  %473 = getelementptr inbounds i8* %p_dst, i32 198
  %474 = load i8* %473, align 1
  %475 = zext i8 %474 to i16
  %476 = sub i16 %472, %475
  %477 = getelementptr inbounds i16* %level, i32 59
  store i16 %476, i16* %477, align 2
  %478 = getelementptr inbounds i8* %p_src, i32 87
  %479 = load i8* %478, align 1
  %480 = zext i8 %479 to i16
  %481 = getelementptr inbounds i8* %p_dst, i32 167
  %482 = load i8* %481, align 1
  %483 = zext i8 %482 to i16
  %484 = sub i16 %480, %483
  %485 = getelementptr inbounds i16* %level, i32 60
  store i16 %484, i16* %485, align 2
  %486 = getelementptr inbounds i8* %p_src, i32 103
  %487 = load i8* %486, align 1
  %488 = zext i8 %487 to i16
  %489 = getelementptr inbounds i8* %p_dst, i32 199
  %490 = load i8* %489, align 1
  %491 = zext i8 %490 to i16
  %492 = sub i16 %488, %491
  %493 = getelementptr inbounds i16* %level, i32 61
  store i16 %492, i16* %493, align 2
  %494 = getelementptr inbounds i8* %p_src, i32 118
  %495 = load i8* %494, align 1
  %496 = zext i8 %495 to i16
  %497 = getelementptr inbounds i8* %p_dst, i32 230
  %498 = load i8* %497, align 1
  %499 = zext i8 %498 to i16
  %500 = sub i16 %496, %499
  %501 = getelementptr inbounds i16* %level, i32 62
  store i16 %500, i16* %501, align 2
  %502 = getelementptr inbounds i8* %p_src, i32 119
  %503 = load i8* %502, align 1
  %504 = zext i8 %503 to i16
  %505 = getelementptr inbounds i8* %p_dst, i32 231
  %506 = load i8* %505, align 1
  %507 = zext i8 %506 to i16
  %508 = sub i16 %504, %507
  %509 = getelementptr inbounds i16* %level, i32 63
  store i16 %508, i16* %509, align 2
  %510 = or i16 %12, %5
  %511 = or i16 %510, %20
  %512 = or i16 %511, %28
  %513 = or i16 %512, %36
  %514 = or i16 %513, %44
  %515 = or i16 %514, %52
  %516 = or i16 %515, %60
  %517 = or i16 %516, %68
  %518 = or i16 %517, %76
  %519 = or i16 %518, %84
  %520 = or i16 %519, %92
  %521 = or i16 %520, %100
  %522 = or i16 %521, %108
  %523 = or i16 %522, %116
  %524 = or i16 %523, %124
  %525 = or i16 %524, %132
  %526 = or i16 %525, %140
  %527 = or i16 %526, %148
  %528 = or i16 %527, %156
  %529 = or i16 %528, %164
  %530 = or i16 %529, %172
  %531 = or i16 %530, %180
  %532 = or i16 %531, %188
  %533 = or i16 %532, %196
  %534 = or i16 %533, %204
  %535 = or i16 %534, %212
  %536 = or i16 %535, %220
  %537 = or i16 %536, %228
  %538 = or i16 %537, %236
  %539 = or i16 %538, %244
  %540 = or i16 %539, %252
  %541 = or i16 %540, %260
  %542 = or i16 %541, %268
  %543 = or i16 %542, %276
  %544 = or i16 %543, %284
  %545 = or i16 %544, %292
  %546 = or i16 %545, %300
  %547 = or i16 %546, %308
  %548 = or i16 %547, %316
  %549 = or i16 %548, %324
  %550 = or i16 %549, %332
  %551 = or i16 %550, %340
  %552 = or i16 %551, %348
  %553 = or i16 %552, %356
  %554 = or i16 %553, %364
  %555 = or i16 %554, %372
  %556 = or i16 %555, %380
  %557 = or i16 %556, %388
  %558 = or i16 %557, %396
  %559 = or i16 %558, %404
  %560 = or i16 %559, %412
  %561 = or i16 %560, %420
  %562 = or i16 %561, %428
  %563 = or i16 %562, %436
  %564 = or i16 %563, %444
  %565 = or i16 %564, %452
  %566 = or i16 %565, %460
  %567 = or i16 %566, %468
  %568 = or i16 %567, %476
  %569 = or i16 %568, %484
  %570 = or i16 %569, %492
  %571 = or i16 %570, %500
  %572 = or i16 %571, %508
  %573 = bitcast i8* %p_src to i32*
  %574 = load i32* %573, align 4
  %575 = bitcast i8* %p_dst to i32*
  store i32 %574, i32* %575, align 4
  %576 = bitcast i8* %110 to i32*
  %577 = load i32* %576, align 4
  %578 = bitcast i8* %113 to i32*
  store i32 %577, i32* %578, align 4
  %579 = bitcast i8* %14 to i32*
  %580 = load i32* %579, align 4
  %581 = bitcast i8* %17 to i32*
  store i32 %580, i32* %581, align 4
  %582 = bitcast i8* %126 to i32*
  %583 = load i32* %582, align 4
  %584 = bitcast i8* %129 to i32*
  store i32 %583, i32* %584, align 4
  %585 = bitcast i8* %22 to i32*
  %586 = load i32* %585, align 4
  %587 = bitcast i8* %25 to i32*
  store i32 %586, i32* %587, align 4
  %588 = bitcast i8* %198 to i32*
  %589 = load i32* %588, align 4
  %590 = bitcast i8* %201 to i32*
  store i32 %589, i32* %590, align 4
  %591 = bitcast i8* %70 to i32*
  %592 = load i32* %591, align 4
  %593 = bitcast i8* %73 to i32*
  store i32 %592, i32* %593, align 4
  %594 = bitcast i8* %246 to i32*
  %595 = load i32* %594, align 4
  %596 = bitcast i8* %249 to i32*
  store i32 %595, i32* %596, align 4
  %597 = bitcast i8* %78 to i32*
  %598 = load i32* %597, align 4
  %599 = bitcast i8* %81 to i32*
  store i32 %598, i32* %599, align 4
  %600 = bitcast i8* %310 to i32*
  %601 = load i32* %600, align 4
  %602 = bitcast i8* %313 to i32*
  store i32 %601, i32* %602, align 4
  %603 = bitcast i8* %158 to i32*
  %604 = load i32* %603, align 4
  %605 = bitcast i8* %161 to i32*
  store i32 %604, i32* %605, align 4
  %606 = bitcast i8* %366 to i32*
  %607 = load i32* %606, align 4
  %608 = bitcast i8* %369 to i32*
  store i32 %607, i32* %608, align 4
  %609 = bitcast i8* %166 to i32*
  %610 = load i32* %609, align 4
  %611 = bitcast i8* %169 to i32*
  store i32 %610, i32* %611, align 4
  %612 = bitcast i8* %398 to i32*
  %613 = load i32* %612, align 4
  %614 = bitcast i8* %401 to i32*
  store i32 %613, i32* %614, align 4
  %615 = bitcast i8* %278 to i32*
  %616 = load i32* %615, align 4
  %617 = bitcast i8* %281 to i32*
  store i32 %616, i32* %617, align 4
  %618 = bitcast i8* %454 to i32*
  %619 = load i32* %618, align 4
  %620 = bitcast i8* %457 to i32*
  store i32 %619, i32* %620, align 4
  %621 = icmp ne i16 %572, 0
  %622 = zext i1 %621 to i32
  ret i32 %622
}

define i32 @zigzag_sub_8x8_field(i16* %level, i8* %p_src, i8* %p_dst) nounwind {
  %1 = load i8* %p_src, align 1
  %2 = zext i8 %1 to i16
  %3 = load i8* %p_dst, align 1
  %4 = zext i8 %3 to i16
  %5 = sub i16 %2, %4
  store i16 %5, i16* %level, align 2
  %6 = getelementptr inbounds i8* %p_src, i32 16
  %7 = load i8* %6, align 1
  %8 = zext i8 %7 to i16
  %9 = getelementptr inbounds i8* %p_dst, i32 32
  %10 = load i8* %9, align 1
  %11 = zext i8 %10 to i16
  %12 = sub i16 %8, %11
  %13 = getelementptr inbounds i16* %level, i32 1
  store i16 %12, i16* %13, align 2
  %14 = getelementptr inbounds i8* %p_src, i32 32
  %15 = load i8* %14, align 1
  %16 = zext i8 %15 to i16
  %17 = getelementptr inbounds i8* %p_dst, i32 64
  %18 = load i8* %17, align 1
  %19 = zext i8 %18 to i16
  %20 = sub i16 %16, %19
  %21 = getelementptr inbounds i16* %level, i32 2
  store i16 %20, i16* %21, align 2
  %22 = getelementptr inbounds i8* %p_src, i32 1
  %23 = load i8* %22, align 1
  %24 = zext i8 %23 to i16
  %25 = getelementptr inbounds i8* %p_dst, i32 1
  %26 = load i8* %25, align 1
  %27 = zext i8 %26 to i16
  %28 = sub i16 %24, %27
  %29 = getelementptr inbounds i16* %level, i32 3
  store i16 %28, i16* %29, align 2
  %30 = getelementptr inbounds i8* %p_src, i32 17
  %31 = load i8* %30, align 1
  %32 = zext i8 %31 to i16
  %33 = getelementptr inbounds i8* %p_dst, i32 33
  %34 = load i8* %33, align 1
  %35 = zext i8 %34 to i16
  %36 = sub i16 %32, %35
  %37 = getelementptr inbounds i16* %level, i32 4
  store i16 %36, i16* %37, align 2
  %38 = getelementptr inbounds i8* %p_src, i32 48
  %39 = load i8* %38, align 1
  %40 = zext i8 %39 to i16
  %41 = getelementptr inbounds i8* %p_dst, i32 96
  %42 = load i8* %41, align 1
  %43 = zext i8 %42 to i16
  %44 = sub i16 %40, %43
  %45 = getelementptr inbounds i16* %level, i32 5
  store i16 %44, i16* %45, align 2
  %46 = getelementptr inbounds i8* %p_src, i32 64
  %47 = load i8* %46, align 1
  %48 = zext i8 %47 to i16
  %49 = getelementptr inbounds i8* %p_dst, i32 128
  %50 = load i8* %49, align 1
  %51 = zext i8 %50 to i16
  %52 = sub i16 %48, %51
  %53 = getelementptr inbounds i16* %level, i32 6
  store i16 %52, i16* %53, align 2
  %54 = getelementptr inbounds i8* %p_src, i32 33
  %55 = load i8* %54, align 1
  %56 = zext i8 %55 to i16
  %57 = getelementptr inbounds i8* %p_dst, i32 65
  %58 = load i8* %57, align 1
  %59 = zext i8 %58 to i16
  %60 = sub i16 %56, %59
  %61 = getelementptr inbounds i16* %level, i32 7
  store i16 %60, i16* %61, align 2
  %62 = getelementptr inbounds i8* %p_src, i32 2
  %63 = load i8* %62, align 1
  %64 = zext i8 %63 to i16
  %65 = getelementptr inbounds i8* %p_dst, i32 2
  %66 = load i8* %65, align 1
  %67 = zext i8 %66 to i16
  %68 = sub i16 %64, %67
  %69 = getelementptr inbounds i16* %level, i32 8
  store i16 %68, i16* %69, align 2
  %70 = getelementptr inbounds i8* %p_src, i32 49
  %71 = load i8* %70, align 1
  %72 = zext i8 %71 to i16
  %73 = getelementptr inbounds i8* %p_dst, i32 97
  %74 = load i8* %73, align 1
  %75 = zext i8 %74 to i16
  %76 = sub i16 %72, %75
  %77 = getelementptr inbounds i16* %level, i32 9
  store i16 %76, i16* %77, align 2
  %78 = getelementptr inbounds i8* %p_src, i32 80
  %79 = load i8* %78, align 1
  %80 = zext i8 %79 to i16
  %81 = getelementptr inbounds i8* %p_dst, i32 160
  %82 = load i8* %81, align 1
  %83 = zext i8 %82 to i16
  %84 = sub i16 %80, %83
  %85 = getelementptr inbounds i16* %level, i32 10
  store i16 %84, i16* %85, align 2
  %86 = getelementptr inbounds i8* %p_src, i32 96
  %87 = load i8* %86, align 1
  %88 = zext i8 %87 to i16
  %89 = getelementptr inbounds i8* %p_dst, i32 192
  %90 = load i8* %89, align 1
  %91 = zext i8 %90 to i16
  %92 = sub i16 %88, %91
  %93 = getelementptr inbounds i16* %level, i32 11
  store i16 %92, i16* %93, align 2
  %94 = getelementptr inbounds i8* %p_src, i32 112
  %95 = load i8* %94, align 1
  %96 = zext i8 %95 to i16
  %97 = getelementptr inbounds i8* %p_dst, i32 224
  %98 = load i8* %97, align 1
  %99 = zext i8 %98 to i16
  %100 = sub i16 %96, %99
  %101 = getelementptr inbounds i16* %level, i32 12
  store i16 %100, i16* %101, align 2
  %102 = getelementptr inbounds i8* %p_src, i32 65
  %103 = load i8* %102, align 1
  %104 = zext i8 %103 to i16
  %105 = getelementptr inbounds i8* %p_dst, i32 129
  %106 = load i8* %105, align 1
  %107 = zext i8 %106 to i16
  %108 = sub i16 %104, %107
  %109 = getelementptr inbounds i16* %level, i32 13
  store i16 %108, i16* %109, align 2
  %110 = getelementptr inbounds i8* %p_src, i32 18
  %111 = load i8* %110, align 1
  %112 = zext i8 %111 to i16
  %113 = getelementptr inbounds i8* %p_dst, i32 34
  %114 = load i8* %113, align 1
  %115 = zext i8 %114 to i16
  %116 = sub i16 %112, %115
  %117 = getelementptr inbounds i16* %level, i32 14
  store i16 %116, i16* %117, align 2
  %118 = getelementptr inbounds i8* %p_src, i32 3
  %119 = load i8* %118, align 1
  %120 = zext i8 %119 to i16
  %121 = getelementptr inbounds i8* %p_dst, i32 3
  %122 = load i8* %121, align 1
  %123 = zext i8 %122 to i16
  %124 = sub i16 %120, %123
  %125 = getelementptr inbounds i16* %level, i32 15
  store i16 %124, i16* %125, align 2
  %126 = getelementptr inbounds i8* %p_src, i32 34
  %127 = load i8* %126, align 1
  %128 = zext i8 %127 to i16
  %129 = getelementptr inbounds i8* %p_dst, i32 66
  %130 = load i8* %129, align 1
  %131 = zext i8 %130 to i16
  %132 = sub i16 %128, %131
  %133 = getelementptr inbounds i16* %level, i32 16
  store i16 %132, i16* %133, align 2
  %134 = getelementptr inbounds i8* %p_src, i32 81
  %135 = load i8* %134, align 1
  %136 = zext i8 %135 to i16
  %137 = getelementptr inbounds i8* %p_dst, i32 161
  %138 = load i8* %137, align 1
  %139 = zext i8 %138 to i16
  %140 = sub i16 %136, %139
  %141 = getelementptr inbounds i16* %level, i32 17
  store i16 %140, i16* %141, align 2
  %142 = getelementptr inbounds i8* %p_src, i32 97
  %143 = load i8* %142, align 1
  %144 = zext i8 %143 to i16
  %145 = getelementptr inbounds i8* %p_dst, i32 193
  %146 = load i8* %145, align 1
  %147 = zext i8 %146 to i16
  %148 = sub i16 %144, %147
  %149 = getelementptr inbounds i16* %level, i32 18
  store i16 %148, i16* %149, align 2
  %150 = getelementptr inbounds i8* %p_src, i32 113
  %151 = load i8* %150, align 1
  %152 = zext i8 %151 to i16
  %153 = getelementptr inbounds i8* %p_dst, i32 225
  %154 = load i8* %153, align 1
  %155 = zext i8 %154 to i16
  %156 = sub i16 %152, %155
  %157 = getelementptr inbounds i16* %level, i32 19
  store i16 %156, i16* %157, align 2
  %158 = getelementptr inbounds i8* %p_src, i32 50
  %159 = load i8* %158, align 1
  %160 = zext i8 %159 to i16
  %161 = getelementptr inbounds i8* %p_dst, i32 98
  %162 = load i8* %161, align 1
  %163 = zext i8 %162 to i16
  %164 = sub i16 %160, %163
  %165 = getelementptr inbounds i16* %level, i32 20
  store i16 %164, i16* %165, align 2
  %166 = getelementptr inbounds i8* %p_src, i32 19
  %167 = load i8* %166, align 1
  %168 = zext i8 %167 to i16
  %169 = getelementptr inbounds i8* %p_dst, i32 35
  %170 = load i8* %169, align 1
  %171 = zext i8 %170 to i16
  %172 = sub i16 %168, %171
  %173 = getelementptr inbounds i16* %level, i32 21
  store i16 %172, i16* %173, align 2
  %174 = getelementptr inbounds i8* %p_src, i32 4
  %175 = load i8* %174, align 1
  %176 = zext i8 %175 to i16
  %177 = getelementptr inbounds i8* %p_dst, i32 4
  %178 = load i8* %177, align 1
  %179 = zext i8 %178 to i16
  %180 = sub i16 %176, %179
  %181 = getelementptr inbounds i16* %level, i32 22
  store i16 %180, i16* %181, align 2
  %182 = getelementptr inbounds i8* %p_src, i32 35
  %183 = load i8* %182, align 1
  %184 = zext i8 %183 to i16
  %185 = getelementptr inbounds i8* %p_dst, i32 67
  %186 = load i8* %185, align 1
  %187 = zext i8 %186 to i16
  %188 = sub i16 %184, %187
  %189 = getelementptr inbounds i16* %level, i32 23
  store i16 %188, i16* %189, align 2
  %190 = getelementptr inbounds i8* %p_src, i32 66
  %191 = load i8* %190, align 1
  %192 = zext i8 %191 to i16
  %193 = getelementptr inbounds i8* %p_dst, i32 130
  %194 = load i8* %193, align 1
  %195 = zext i8 %194 to i16
  %196 = sub i16 %192, %195
  %197 = getelementptr inbounds i16* %level, i32 24
  store i16 %196, i16* %197, align 2
  %198 = getelementptr inbounds i8* %p_src, i32 82
  %199 = load i8* %198, align 1
  %200 = zext i8 %199 to i16
  %201 = getelementptr inbounds i8* %p_dst, i32 162
  %202 = load i8* %201, align 1
  %203 = zext i8 %202 to i16
  %204 = sub i16 %200, %203
  %205 = getelementptr inbounds i16* %level, i32 25
  store i16 %204, i16* %205, align 2
  %206 = getelementptr inbounds i8* %p_src, i32 98
  %207 = load i8* %206, align 1
  %208 = zext i8 %207 to i16
  %209 = getelementptr inbounds i8* %p_dst, i32 194
  %210 = load i8* %209, align 1
  %211 = zext i8 %210 to i16
  %212 = sub i16 %208, %211
  %213 = getelementptr inbounds i16* %level, i32 26
  store i16 %212, i16* %213, align 2
  %214 = getelementptr inbounds i8* %p_src, i32 114
  %215 = load i8* %214, align 1
  %216 = zext i8 %215 to i16
  %217 = getelementptr inbounds i8* %p_dst, i32 226
  %218 = load i8* %217, align 1
  %219 = zext i8 %218 to i16
  %220 = sub i16 %216, %219
  %221 = getelementptr inbounds i16* %level, i32 27
  store i16 %220, i16* %221, align 2
  %222 = getelementptr inbounds i8* %p_src, i32 51
  %223 = load i8* %222, align 1
  %224 = zext i8 %223 to i16
  %225 = getelementptr inbounds i8* %p_dst, i32 99
  %226 = load i8* %225, align 1
  %227 = zext i8 %226 to i16
  %228 = sub i16 %224, %227
  %229 = getelementptr inbounds i16* %level, i32 28
  store i16 %228, i16* %229, align 2
  %230 = getelementptr inbounds i8* %p_src, i32 20
  %231 = load i8* %230, align 1
  %232 = zext i8 %231 to i16
  %233 = getelementptr inbounds i8* %p_dst, i32 36
  %234 = load i8* %233, align 1
  %235 = zext i8 %234 to i16
  %236 = sub i16 %232, %235
  %237 = getelementptr inbounds i16* %level, i32 29
  store i16 %236, i16* %237, align 2
  %238 = getelementptr inbounds i8* %p_src, i32 5
  %239 = load i8* %238, align 1
  %240 = zext i8 %239 to i16
  %241 = getelementptr inbounds i8* %p_dst, i32 5
  %242 = load i8* %241, align 1
  %243 = zext i8 %242 to i16
  %244 = sub i16 %240, %243
  %245 = getelementptr inbounds i16* %level, i32 30
  store i16 %244, i16* %245, align 2
  %246 = getelementptr inbounds i8* %p_src, i32 36
  %247 = load i8* %246, align 1
  %248 = zext i8 %247 to i16
  %249 = getelementptr inbounds i8* %p_dst, i32 68
  %250 = load i8* %249, align 1
  %251 = zext i8 %250 to i16
  %252 = sub i16 %248, %251
  %253 = getelementptr inbounds i16* %level, i32 31
  store i16 %252, i16* %253, align 2
  %254 = getelementptr inbounds i8* %p_src, i32 67
  %255 = load i8* %254, align 1
  %256 = zext i8 %255 to i16
  %257 = getelementptr inbounds i8* %p_dst, i32 131
  %258 = load i8* %257, align 1
  %259 = zext i8 %258 to i16
  %260 = sub i16 %256, %259
  %261 = getelementptr inbounds i16* %level, i32 32
  store i16 %260, i16* %261, align 2
  %262 = getelementptr inbounds i8* %p_src, i32 83
  %263 = load i8* %262, align 1
  %264 = zext i8 %263 to i16
  %265 = getelementptr inbounds i8* %p_dst, i32 163
  %266 = load i8* %265, align 1
  %267 = zext i8 %266 to i16
  %268 = sub i16 %264, %267
  %269 = getelementptr inbounds i16* %level, i32 33
  store i16 %268, i16* %269, align 2
  %270 = getelementptr inbounds i8* %p_src, i32 99
  %271 = load i8* %270, align 1
  %272 = zext i8 %271 to i16
  %273 = getelementptr inbounds i8* %p_dst, i32 195
  %274 = load i8* %273, align 1
  %275 = zext i8 %274 to i16
  %276 = sub i16 %272, %275
  %277 = getelementptr inbounds i16* %level, i32 34
  store i16 %276, i16* %277, align 2
  %278 = getelementptr inbounds i8* %p_src, i32 115
  %279 = load i8* %278, align 1
  %280 = zext i8 %279 to i16
  %281 = getelementptr inbounds i8* %p_dst, i32 227
  %282 = load i8* %281, align 1
  %283 = zext i8 %282 to i16
  %284 = sub i16 %280, %283
  %285 = getelementptr inbounds i16* %level, i32 35
  store i16 %284, i16* %285, align 2
  %286 = getelementptr inbounds i8* %p_src, i32 52
  %287 = load i8* %286, align 1
  %288 = zext i8 %287 to i16
  %289 = getelementptr inbounds i8* %p_dst, i32 100
  %290 = load i8* %289, align 1
  %291 = zext i8 %290 to i16
  %292 = sub i16 %288, %291
  %293 = getelementptr inbounds i16* %level, i32 36
  store i16 %292, i16* %293, align 2
  %294 = getelementptr inbounds i8* %p_src, i32 21
  %295 = load i8* %294, align 1
  %296 = zext i8 %295 to i16
  %297 = getelementptr inbounds i8* %p_dst, i32 37
  %298 = load i8* %297, align 1
  %299 = zext i8 %298 to i16
  %300 = sub i16 %296, %299
  %301 = getelementptr inbounds i16* %level, i32 37
  store i16 %300, i16* %301, align 2
  %302 = getelementptr inbounds i8* %p_src, i32 6
  %303 = load i8* %302, align 1
  %304 = zext i8 %303 to i16
  %305 = getelementptr inbounds i8* %p_dst, i32 6
  %306 = load i8* %305, align 1
  %307 = zext i8 %306 to i16
  %308 = sub i16 %304, %307
  %309 = getelementptr inbounds i16* %level, i32 38
  store i16 %308, i16* %309, align 2
  %310 = getelementptr inbounds i8* %p_src, i32 37
  %311 = load i8* %310, align 1
  %312 = zext i8 %311 to i16
  %313 = getelementptr inbounds i8* %p_dst, i32 69
  %314 = load i8* %313, align 1
  %315 = zext i8 %314 to i16
  %316 = sub i16 %312, %315
  %317 = getelementptr inbounds i16* %level, i32 39
  store i16 %316, i16* %317, align 2
  %318 = getelementptr inbounds i8* %p_src, i32 68
  %319 = load i8* %318, align 1
  %320 = zext i8 %319 to i16
  %321 = getelementptr inbounds i8* %p_dst, i32 132
  %322 = load i8* %321, align 1
  %323 = zext i8 %322 to i16
  %324 = sub i16 %320, %323
  %325 = getelementptr inbounds i16* %level, i32 40
  store i16 %324, i16* %325, align 2
  %326 = getelementptr inbounds i8* %p_src, i32 84
  %327 = load i8* %326, align 1
  %328 = zext i8 %327 to i16
  %329 = getelementptr inbounds i8* %p_dst, i32 164
  %330 = load i8* %329, align 1
  %331 = zext i8 %330 to i16
  %332 = sub i16 %328, %331
  %333 = getelementptr inbounds i16* %level, i32 41
  store i16 %332, i16* %333, align 2
  %334 = getelementptr inbounds i8* %p_src, i32 100
  %335 = load i8* %334, align 1
  %336 = zext i8 %335 to i16
  %337 = getelementptr inbounds i8* %p_dst, i32 196
  %338 = load i8* %337, align 1
  %339 = zext i8 %338 to i16
  %340 = sub i16 %336, %339
  %341 = getelementptr inbounds i16* %level, i32 42
  store i16 %340, i16* %341, align 2
  %342 = getelementptr inbounds i8* %p_src, i32 116
  %343 = load i8* %342, align 1
  %344 = zext i8 %343 to i16
  %345 = getelementptr inbounds i8* %p_dst, i32 228
  %346 = load i8* %345, align 1
  %347 = zext i8 %346 to i16
  %348 = sub i16 %344, %347
  %349 = getelementptr inbounds i16* %level, i32 43
  store i16 %348, i16* %349, align 2
  %350 = getelementptr inbounds i8* %p_src, i32 53
  %351 = load i8* %350, align 1
  %352 = zext i8 %351 to i16
  %353 = getelementptr inbounds i8* %p_dst, i32 101
  %354 = load i8* %353, align 1
  %355 = zext i8 %354 to i16
  %356 = sub i16 %352, %355
  %357 = getelementptr inbounds i16* %level, i32 44
  store i16 %356, i16* %357, align 2
  %358 = getelementptr inbounds i8* %p_src, i32 22
  %359 = load i8* %358, align 1
  %360 = zext i8 %359 to i16
  %361 = getelementptr inbounds i8* %p_dst, i32 38
  %362 = load i8* %361, align 1
  %363 = zext i8 %362 to i16
  %364 = sub i16 %360, %363
  %365 = getelementptr inbounds i16* %level, i32 45
  store i16 %364, i16* %365, align 2
  %366 = getelementptr inbounds i8* %p_src, i32 38
  %367 = load i8* %366, align 1
  %368 = zext i8 %367 to i16
  %369 = getelementptr inbounds i8* %p_dst, i32 70
  %370 = load i8* %369, align 1
  %371 = zext i8 %370 to i16
  %372 = sub i16 %368, %371
  %373 = getelementptr inbounds i16* %level, i32 46
  store i16 %372, i16* %373, align 2
  %374 = getelementptr inbounds i8* %p_src, i32 69
  %375 = load i8* %374, align 1
  %376 = zext i8 %375 to i16
  %377 = getelementptr inbounds i8* %p_dst, i32 133
  %378 = load i8* %377, align 1
  %379 = zext i8 %378 to i16
  %380 = sub i16 %376, %379
  %381 = getelementptr inbounds i16* %level, i32 47
  store i16 %380, i16* %381, align 2
  %382 = getelementptr inbounds i8* %p_src, i32 85
  %383 = load i8* %382, align 1
  %384 = zext i8 %383 to i16
  %385 = getelementptr inbounds i8* %p_dst, i32 165
  %386 = load i8* %385, align 1
  %387 = zext i8 %386 to i16
  %388 = sub i16 %384, %387
  %389 = getelementptr inbounds i16* %level, i32 48
  store i16 %388, i16* %389, align 2
  %390 = getelementptr inbounds i8* %p_src, i32 101
  %391 = load i8* %390, align 1
  %392 = zext i8 %391 to i16
  %393 = getelementptr inbounds i8* %p_dst, i32 197
  %394 = load i8* %393, align 1
  %395 = zext i8 %394 to i16
  %396 = sub i16 %392, %395
  %397 = getelementptr inbounds i16* %level, i32 49
  store i16 %396, i16* %397, align 2
  %398 = getelementptr inbounds i8* %p_src, i32 117
  %399 = load i8* %398, align 1
  %400 = zext i8 %399 to i16
  %401 = getelementptr inbounds i8* %p_dst, i32 229
  %402 = load i8* %401, align 1
  %403 = zext i8 %402 to i16
  %404 = sub i16 %400, %403
  %405 = getelementptr inbounds i16* %level, i32 50
  store i16 %404, i16* %405, align 2
  %406 = getelementptr inbounds i8* %p_src, i32 54
  %407 = load i8* %406, align 1
  %408 = zext i8 %407 to i16
  %409 = getelementptr inbounds i8* %p_dst, i32 102
  %410 = load i8* %409, align 1
  %411 = zext i8 %410 to i16
  %412 = sub i16 %408, %411
  %413 = getelementptr inbounds i16* %level, i32 51
  store i16 %412, i16* %413, align 2
  %414 = getelementptr inbounds i8* %p_src, i32 7
  %415 = load i8* %414, align 1
  %416 = zext i8 %415 to i16
  %417 = getelementptr inbounds i8* %p_dst, i32 7
  %418 = load i8* %417, align 1
  %419 = zext i8 %418 to i16
  %420 = sub i16 %416, %419
  %421 = getelementptr inbounds i16* %level, i32 52
  store i16 %420, i16* %421, align 2
  %422 = getelementptr inbounds i8* %p_src, i32 23
  %423 = load i8* %422, align 1
  %424 = zext i8 %423 to i16
  %425 = getelementptr inbounds i8* %p_dst, i32 39
  %426 = load i8* %425, align 1
  %427 = zext i8 %426 to i16
  %428 = sub i16 %424, %427
  %429 = getelementptr inbounds i16* %level, i32 53
  store i16 %428, i16* %429, align 2
  %430 = getelementptr inbounds i8* %p_src, i32 70
  %431 = load i8* %430, align 1
  %432 = zext i8 %431 to i16
  %433 = getelementptr inbounds i8* %p_dst, i32 134
  %434 = load i8* %433, align 1
  %435 = zext i8 %434 to i16
  %436 = sub i16 %432, %435
  %437 = getelementptr inbounds i16* %level, i32 54
  store i16 %436, i16* %437, align 2
  %438 = getelementptr inbounds i8* %p_src, i32 86
  %439 = load i8* %438, align 1
  %440 = zext i8 %439 to i16
  %441 = getelementptr inbounds i8* %p_dst, i32 166
  %442 = load i8* %441, align 1
  %443 = zext i8 %442 to i16
  %444 = sub i16 %440, %443
  %445 = getelementptr inbounds i16* %level, i32 55
  store i16 %444, i16* %445, align 2
  %446 = getelementptr inbounds i8* %p_src, i32 102
  %447 = load i8* %446, align 1
  %448 = zext i8 %447 to i16
  %449 = getelementptr inbounds i8* %p_dst, i32 198
  %450 = load i8* %449, align 1
  %451 = zext i8 %450 to i16
  %452 = sub i16 %448, %451
  %453 = getelementptr inbounds i16* %level, i32 56
  store i16 %452, i16* %453, align 2
  %454 = getelementptr inbounds i8* %p_src, i32 118
  %455 = load i8* %454, align 1
  %456 = zext i8 %455 to i16
  %457 = getelementptr inbounds i8* %p_dst, i32 230
  %458 = load i8* %457, align 1
  %459 = zext i8 %458 to i16
  %460 = sub i16 %456, %459
  %461 = getelementptr inbounds i16* %level, i32 57
  store i16 %460, i16* %461, align 2
  %462 = getelementptr inbounds i8* %p_src, i32 39
  %463 = load i8* %462, align 1
  %464 = zext i8 %463 to i16
  %465 = getelementptr inbounds i8* %p_dst, i32 71
  %466 = load i8* %465, align 1
  %467 = zext i8 %466 to i16
  %468 = sub i16 %464, %467
  %469 = getelementptr inbounds i16* %level, i32 58
  store i16 %468, i16* %469, align 2
  %470 = getelementptr inbounds i8* %p_src, i32 55
  %471 = load i8* %470, align 1
  %472 = zext i8 %471 to i16
  %473 = getelementptr inbounds i8* %p_dst, i32 103
  %474 = load i8* %473, align 1
  %475 = zext i8 %474 to i16
  %476 = sub i16 %472, %475
  %477 = getelementptr inbounds i16* %level, i32 59
  store i16 %476, i16* %477, align 2
  %478 = getelementptr inbounds i8* %p_src, i32 71
  %479 = load i8* %478, align 1
  %480 = zext i8 %479 to i16
  %481 = getelementptr inbounds i8* %p_dst, i32 135
  %482 = load i8* %481, align 1
  %483 = zext i8 %482 to i16
  %484 = sub i16 %480, %483
  %485 = getelementptr inbounds i16* %level, i32 60
  store i16 %484, i16* %485, align 2
  %486 = getelementptr inbounds i8* %p_src, i32 87
  %487 = load i8* %486, align 1
  %488 = zext i8 %487 to i16
  %489 = getelementptr inbounds i8* %p_dst, i32 167
  %490 = load i8* %489, align 1
  %491 = zext i8 %490 to i16
  %492 = sub i16 %488, %491
  %493 = getelementptr inbounds i16* %level, i32 61
  store i16 %492, i16* %493, align 2
  %494 = getelementptr inbounds i8* %p_src, i32 103
  %495 = load i8* %494, align 1
  %496 = zext i8 %495 to i16
  %497 = getelementptr inbounds i8* %p_dst, i32 199
  %498 = load i8* %497, align 1
  %499 = zext i8 %498 to i16
  %500 = sub i16 %496, %499
  %501 = getelementptr inbounds i16* %level, i32 62
  store i16 %500, i16* %501, align 2
  %502 = getelementptr inbounds i8* %p_src, i32 119
  %503 = load i8* %502, align 1
  %504 = zext i8 %503 to i16
  %505 = getelementptr inbounds i8* %p_dst, i32 231
  %506 = load i8* %505, align 1
  %507 = zext i8 %506 to i16
  %508 = sub i16 %504, %507
  %509 = getelementptr inbounds i16* %level, i32 63
  store i16 %508, i16* %509, align 2
  %510 = or i16 %12, %5
  %511 = or i16 %510, %20
  %512 = or i16 %511, %28
  %513 = or i16 %512, %36
  %514 = or i16 %513, %44
  %515 = or i16 %514, %52
  %516 = or i16 %515, %60
  %517 = or i16 %516, %68
  %518 = or i16 %517, %76
  %519 = or i16 %518, %84
  %520 = or i16 %519, %92
  %521 = or i16 %520, %100
  %522 = or i16 %521, %108
  %523 = or i16 %522, %116
  %524 = or i16 %523, %124
  %525 = or i16 %524, %132
  %526 = or i16 %525, %140
  %527 = or i16 %526, %148
  %528 = or i16 %527, %156
  %529 = or i16 %528, %164
  %530 = or i16 %529, %172
  %531 = or i16 %530, %180
  %532 = or i16 %531, %188
  %533 = or i16 %532, %196
  %534 = or i16 %533, %204
  %535 = or i16 %534, %212
  %536 = or i16 %535, %220
  %537 = or i16 %536, %228
  %538 = or i16 %537, %236
  %539 = or i16 %538, %244
  %540 = or i16 %539, %252
  %541 = or i16 %540, %260
  %542 = or i16 %541, %268
  %543 = or i16 %542, %276
  %544 = or i16 %543, %284
  %545 = or i16 %544, %292
  %546 = or i16 %545, %300
  %547 = or i16 %546, %308
  %548 = or i16 %547, %316
  %549 = or i16 %548, %324
  %550 = or i16 %549, %332
  %551 = or i16 %550, %340
  %552 = or i16 %551, %348
  %553 = or i16 %552, %356
  %554 = or i16 %553, %364
  %555 = or i16 %554, %372
  %556 = or i16 %555, %380
  %557 = or i16 %556, %388
  %558 = or i16 %557, %396
  %559 = or i16 %558, %404
  %560 = or i16 %559, %412
  %561 = or i16 %560, %420
  %562 = or i16 %561, %428
  %563 = or i16 %562, %436
  %564 = or i16 %563, %444
  %565 = or i16 %564, %452
  %566 = or i16 %565, %460
  %567 = or i16 %566, %468
  %568 = or i16 %567, %476
  %569 = or i16 %568, %484
  %570 = or i16 %569, %492
  %571 = or i16 %570, %500
  %572 = or i16 %571, %508
  %573 = bitcast i8* %p_src to i32*
  %574 = load i32* %573, align 4
  %575 = bitcast i8* %p_dst to i32*
  store i32 %574, i32* %575, align 4
  %576 = bitcast i8* %174 to i32*
  %577 = load i32* %576, align 4
  %578 = bitcast i8* %177 to i32*
  store i32 %577, i32* %578, align 4
  %579 = bitcast i8* %6 to i32*
  %580 = load i32* %579, align 4
  %581 = bitcast i8* %9 to i32*
  store i32 %580, i32* %581, align 4
  %582 = bitcast i8* %230 to i32*
  %583 = load i32* %582, align 4
  %584 = bitcast i8* %233 to i32*
  store i32 %583, i32* %584, align 4
  %585 = bitcast i8* %14 to i32*
  %586 = load i32* %585, align 4
  %587 = bitcast i8* %17 to i32*
  store i32 %586, i32* %587, align 4
  %588 = bitcast i8* %246 to i32*
  %589 = load i32* %588, align 4
  %590 = bitcast i8* %249 to i32*
  store i32 %589, i32* %590, align 4
  %591 = bitcast i8* %38 to i32*
  %592 = load i32* %591, align 4
  %593 = bitcast i8* %41 to i32*
  store i32 %592, i32* %593, align 4
  %594 = bitcast i8* %286 to i32*
  %595 = load i32* %594, align 4
  %596 = bitcast i8* %289 to i32*
  store i32 %595, i32* %596, align 4
  %597 = bitcast i8* %46 to i32*
  %598 = load i32* %597, align 4
  %599 = bitcast i8* %49 to i32*
  store i32 %598, i32* %599, align 4
  %600 = bitcast i8* %318 to i32*
  %601 = load i32* %600, align 4
  %602 = bitcast i8* %321 to i32*
  store i32 %601, i32* %602, align 4
  %603 = bitcast i8* %78 to i32*
  %604 = load i32* %603, align 4
  %605 = bitcast i8* %81 to i32*
  store i32 %604, i32* %605, align 4
  %606 = bitcast i8* %326 to i32*
  %607 = load i32* %606, align 4
  %608 = bitcast i8* %329 to i32*
  store i32 %607, i32* %608, align 4
  %609 = bitcast i8* %86 to i32*
  %610 = load i32* %609, align 4
  %611 = bitcast i8* %89 to i32*
  store i32 %610, i32* %611, align 4
  %612 = bitcast i8* %334 to i32*
  %613 = load i32* %612, align 4
  %614 = bitcast i8* %337 to i32*
  store i32 %613, i32* %614, align 4
  %615 = bitcast i8* %94 to i32*
  %616 = load i32* %615, align 4
  %617 = bitcast i8* %97 to i32*
  store i32 %616, i32* %617, align 4
  %618 = bitcast i8* %342 to i32*
  %619 = load i32* %618, align 4
  %620 = bitcast i8* %345 to i32*
  store i32 %619, i32* %620, align 4
  %621 = icmp ne i16 %572, 0
  %622 = zext i1 %621 to i32
  ret i32 %622
}

define void @zigzag_interleave_8x8_cavlc(i16* nocapture %dst, i16* nocapture %src, i8* nocapture %nnz) nounwind {
bb.nph:
  br label %0

; <label>:0                                       ; preds = %0, %bb.nph
  %j.02 = phi i32 [ 0, %bb.nph ], [ %4, %0 ]
  %nz.01 = phi i32 [ 0, %bb.nph ], [ %3, %0 ]
  %scevgep9 = getelementptr i16* %dst, i32 %j.02
  %tmp14 = shl i32 %j.02, 2
  %scevgep = getelementptr i16* %src, i32 %tmp14
  %1 = load i16* %scevgep, align 2
  %2 = sext i16 %1 to i32
  %3 = or i32 %2, %nz.01
  store i16 %1, i16* %scevgep9, align 2
  %4 = add nsw i32 %j.02, 1
  %exitcond = icmp eq i32 %4, 16
  br i1 %exitcond, label %bb.nph.1, label %0

; <label>:5                                       ; preds = %21
  %phitmp.3 = icmp ne i32 %24, 0
  %6 = zext i1 %phitmp.3 to i8
  %7 = getelementptr inbounds i8* %nnz, i32 9
  store i8 %6, i8* %7, align 1
  ret void

; <label>:8                                       ; preds = %bb.nph.1, %8
  %j.02.1 = phi i32 [ 0, %bb.nph.1 ], [ %12, %8 ]
  %nz.01.1 = phi i32 [ 0, %bb.nph.1 ], [ %11, %8 ]
  %tmp12.1 = add i32 %j.02.1, 16
  %scevgep9.1 = getelementptr i16* %dst, i32 %tmp12.1
  %tmp14.1 = shl i32 %j.02.1, 2
  %tmp15.118 = or i32 %tmp14.1, 1
  %scevgep.1 = getelementptr i16* %src, i32 %tmp15.118
  %9 = load i16* %scevgep.1, align 2
  %10 = sext i16 %9 to i32
  %11 = or i32 %10, %nz.01.1
  store i16 %9, i16* %scevgep9.1, align 2
  %12 = add nsw i32 %j.02.1, 1
  %exitcond.1 = icmp eq i32 %12, 16
  br i1 %exitcond.1, label %bb.nph.2, label %8

bb.nph.1:                                         ; preds = %0
  %phitmp = icmp ne i32 %3, 0
  %13 = zext i1 %phitmp to i8
  store i8 %13, i8* %nnz, align 1
  br label %8

; <label>:14                                      ; preds = %bb.nph.2, %14
  %j.02.2 = phi i32 [ 0, %bb.nph.2 ], [ %18, %14 ]
  %nz.01.2 = phi i32 [ 0, %bb.nph.2 ], [ %17, %14 ]
  %tmp12.2 = add i32 %j.02.2, 32
  %scevgep9.2 = getelementptr i16* %dst, i32 %tmp12.2
  %tmp14.2 = shl i32 %j.02.2, 2
  %tmp15.219 = or i32 %tmp14.2, 2
  %scevgep.2 = getelementptr i16* %src, i32 %tmp15.219
  %15 = load i16* %scevgep.2, align 2
  %16 = sext i16 %15 to i32
  %17 = or i32 %16, %nz.01.2
  store i16 %15, i16* %scevgep9.2, align 2
  %18 = add nsw i32 %j.02.2, 1
  %exitcond.2 = icmp eq i32 %18, 16
  br i1 %exitcond.2, label %bb.nph.3, label %14

bb.nph.2:                                         ; preds = %8
  %phitmp.1 = icmp ne i32 %11, 0
  %19 = zext i1 %phitmp.1 to i8
  %20 = getelementptr inbounds i8* %nnz, i32 1
  store i8 %19, i8* %20, align 1
  br label %14

; <label>:21                                      ; preds = %bb.nph.3, %21
  %j.02.3 = phi i32 [ 0, %bb.nph.3 ], [ %25, %21 ]
  %nz.01.3 = phi i32 [ 0, %bb.nph.3 ], [ %24, %21 ]
  %tmp12.3 = add i32 %j.02.3, 48
  %scevgep9.3 = getelementptr i16* %dst, i32 %tmp12.3
  %tmp14.3 = shl i32 %j.02.3, 2
  %tmp15.320 = or i32 %tmp14.3, 3
  %scevgep.3 = getelementptr i16* %src, i32 %tmp15.320
  %22 = load i16* %scevgep.3, align 2
  %23 = sext i16 %22 to i32
  %24 = or i32 %23, %nz.01.3
  store i16 %22, i16* %scevgep9.3, align 2
  %25 = add nsw i32 %j.02.3, 1
  %exitcond.3 = icmp eq i32 %25, 16
  br i1 %exitcond.3, label %5, label %21

bb.nph.3:                                         ; preds = %14
  %phitmp.2 = icmp ne i32 %17, 0
  %26 = zext i1 %phitmp.2 to i8
  %27 = getelementptr inbounds i8* %nnz, i32 8
  store i8 %26, i8* %27, align 1
  br label %21
}

define void @dct_engine() noreturn nounwind {
  %dct = alloca [16 x i16], align 2
  %pix1 = alloca [16 x [16 x i8]], align 1
  br label %1

; <label>:1                                       ; preds = %1, %0
  %2 = call i32 @read_uint32(i8* getelementptr inbounds ([12 x i8]* @.str, i32 0, i32 0)) nounwind
  %3 = call i32 @read_uint32(i8* getelementptr inbounds ([12 x i8]* @.str, i32 0, i32 0)) nounwind
  %cond = icmp eq i32 %2, 3
  %4 = icmp eq i32 %3, 56
  %or.cond = and i1 %cond, %4
  br i1 %or.cond, label %bb.nph, label %1

bb.nph:                                           ; preds = %bb.nph, %1
  %i.05 = phi i32 [ %6, %bb.nph ], [ 0, %1 ]
  %tmp = shl i32 %i.05, 1
  %scevgep7 = getelementptr [16 x i16]* %dct, i32 0, i32 %tmp
  %scevgep78 = bitcast i16* %scevgep7 to i32*
  %5 = call i32 @read_uint32(i8* getelementptr inbounds ([12 x i8]* @.str, i32 0, i32 0)) nounwind
  store i32 %5, i32* %scevgep78, align 4
  %6 = add nsw i32 %i.05, 1
  %exitcond = icmp eq i32 %6, 16
  br i1 %exitcond, label %.preheader, label %bb.nph

.preheader:                                       ; preds = %.preheader, %bb.nph
  %i1.0 = phi i32 [ %8, %.preheader ], [ 0, %bb.nph ]
  %scevgep = getelementptr [16 x [16 x i8]]* %pix1, i32 0, i32 0, i32 %i1.0
  %scevgep6 = bitcast i8* %scevgep to i32*
  %7 = call i32 @read_uint32(i8* getelementptr inbounds ([12 x i8]* @.str, i32 0, i32 0)) nounwind
  store i32 %7, i32* %scevgep6, align 4
  %8 = add nsw i32 %i1.0, 1
  br label %.preheader
}

declare i32 @read_uint32(i8*)
