; ModuleID = 'prog.opt.o'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32"
target triple = "i386-redhat-linux-gnu"

%struct._Job = type { i32, i32, i32, i32, i32, i32, i32 }

@job = common global [20 x %struct._Job] zeroinitializer, align 4
@.str = private constant [8 x i8] c"in_data\00"
@.str1 = private constant [7 x i8] c"out_id\00"

define void @hardware1() noreturn nounwind {
; <label>:0
  store i32 0, i32* getelementptr inbounds ([20 x %struct._Job]* @job, i32 0, i32 0, i32 0), align 4
  store i32 0, i32* getelementptr inbounds ([20 x %struct._Job]* @job, i32 0, i32 1, i32 0), align 4
  br label %1

; <label>:1                                       ; preds = %1, %0
  %i.0 = phi i32 [ 0, %0 ], [ %2, %1 ]
  %scevgep7 = getelementptr [20 x %struct._Job]* @job, i32 0, i32 %i.0, i32 1
  %scevgep6 = getelementptr [20 x %struct._Job]* @job, i32 0, i32 %i.0, i32 2
  %scevgep5 = getelementptr [20 x %struct._Job]* @job, i32 0, i32 %i.0, i32 3
  %scevgep4 = getelementptr [20 x %struct._Job]* @job, i32 0, i32 %i.0, i32 4
  %scevgep3 = getelementptr [20 x %struct._Job]* @job, i32 0, i32 %i.0, i32 5
  %scevgep2 = getelementptr [20 x %struct._Job]* @job, i32 0, i32 %i.0, i32 6
  %scevgep = getelementptr [20 x %struct._Job]* @job, i32 0, i32 %i.0
  %scevgep1 = bitcast %struct._Job* %scevgep to i32*
  %tmp = add i32 %i.0, 1
  %2 = add i32 %i.0, 1
  %3 = tail call i32 @read_uint32(i8* getelementptr inbounds ([8 x i8]* @.str, i32 0, i32 0)) nounwind
  store i32 %3, i32* %scevgep7, align 4
  %4 = tail call i32 @read_uint32(i8* getelementptr inbounds ([8 x i8]* @.str, i32 0, i32 0)) nounwind
  store i32 %4, i32* %scevgep6, align 4
  %5 = tail call i32 @read_uint32(i8* getelementptr inbounds ([8 x i8]* @.str, i32 0, i32 0)) nounwind
  store i32 %5, i32* %scevgep5, align 4
  %6 = tail call i32 @read_uint32(i8* getelementptr inbounds ([8 x i8]* @.str, i32 0, i32 0)) nounwind
  store i32 %6, i32* %scevgep4, align 4
  %7 = tail call i32 @read_uint32(i8* getelementptr inbounds ([8 x i8]* @.str, i32 0, i32 0)) nounwind
  store i32 %7, i32* %scevgep3, align 4
  %8 = tail call i32 @read_uint32(i8* getelementptr inbounds ([8 x i8]* @.str, i32 0, i32 0)) nounwind
  store i32 %8, i32* %scevgep2, align 4
  store i32 1, i32* %scevgep1, align 4
  tail call void @write_uint32(i8* getelementptr inbounds ([7 x i8]* @.str1, i32 0, i32 0), i32 %tmp) nounwind
  br label %1
}

declare i32 @read_uint32(i8*)

declare void @write_uint32(i8*, i32)
