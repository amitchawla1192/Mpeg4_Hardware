#include <stdio.h>
#include <stdlib.h>
typedef struct x264_t x264_t;
#define BIT_DEPTH 8
#define X264_BFRAME_MAX 16
#define X264_REF_MAX 16
#define X264_THREAD_MAX 128
#define X264_LOOKAHEAD_THREAD_MAX 16
#define X264_PCM_COST (FRAME_SIZE(256*BIT_DEPTH)+16)
#define X264_LOOKAHEAD_MAX 250
#define QP_BD_OFFSET (6*(BIT_DEPTH-8))
#define QP_MAX_SPEC (51+QP_BD_OFFSET)
#define QP_MAX (QP_MAX_SPEC+18)
#define QP_MAX_MAX (51+2*6+18)

#define DECLARE_ALIGNED( var, n ) var __attribute__((aligned(n)))
#define ALIGNED_32( var ) DECLARE_ALIGNED( var, 32 )
#define ALIGNED_16( var ) DECLARE_ALIGNED( var, 16 )
#define ALIGNED_8( var )  DECLARE_ALIGNED( var, 8 )
#define ALIGNED_4( var )  DECLARE_ALIGNED( var, 4 )
#define ALIGNED_N ALIGNED_16



//typedef __gnuc_va_list va_list;
typedef uint8_t  pixel;
struct x264_weight_t;


typedef int  (*x264_pixel_cmp_t) ( pixel *, intptr_t, pixel *, intptr_t );
typedef void (*x264_pixel_cmp_x3_t) ( pixel *, pixel *, pixel *, pixel *, intptr_t, int[3] );
typedef void (*x264_pixel_cmp_x4_t) ( pixel *, pixel *, pixel *, pixel *, pixel *, intptr_t, int[4] );

typedef void (* weight_fn_t)( pixel *, intptr_t, pixel *,intptr_t, const struct x264_weight_t *, int );
typedef struct x264_weight_t
{
    /* aligning the first member is a gcc hack to force the struct to be
     * 16 byte aligned, as well as force sizeof(struct) to be a multiple of 16 */
    int16_t cachea[8];
    int16_t cacheb[8];
    int32_t i_denom;
    int32_t i_scale;
    int32_t i_offset;
    weight_fn_t *weightfn;
} x264_weight_t;

typedef struct
{
    double cpb_initial_arrival_time;
    double cpb_final_arrival_time;
    double cpb_removal_time;

    double dpb_output_time;
} x264_hrd_t;

typedef struct
{
    void *handle;
    void *(*func)( void* arg );
    void *arg;
    void **p_ret;
    void *ret;
} x264_pthread_t;
typedef struct
{
    int payload_size;
    int payload_type;
    uint8_t *payload;
} x264_sei_payload_t;

typedef struct
{
    int num_payloads;
    x264_sei_payload_t *payloads;
    /* In: optional callback to free each payload AND x264_sei_payload_t when used. */
    void (*sei_free)( void* );
} x264_sei_t;

typedef struct
{
    int     i_csp;       /* Colorspace */
    int     i_plane;     /* Number of image planes */
    int     i_stride[4]; /* Strides for each plane */
    uint8_t *plane[4];   /* Pointers to each plane */
} x264_image_t;
/* threads */
#if HAVE_BEOSTHREAD
#include <kernel/OS.h>
#define x264_pthread_t               thread_id
static inline int x264_pthread_create( x264_pthread_t *t, void *a, void *(*f)(void *), void *d )
{
     *t = spawn_thread( f, "", 10, d );
     if( *t < B_NO_ERROR )
         return -1;
     resume_thread( *t );
     return 0;
}
#define x264_pthread_join(t,s)       { long tmp; \
                                       wait_for_thread(t,(s)?(long*)(s):&tmp); }
#elif HAVE_POSIXTHREAD
#include <pthread.h>
#define x264_pthread_t               pthread_t
#define x264_pthread_create          pthread_create
#define x264_pthread_join            pthread_join
#define x264_pthread_mutex_t         pthread_mutex_t
#define x264_pthread_mutex_init      pthread_mutex_init
#define x264_pthread_mutex_destroy   pthread_mutex_destroy
#define x264_pthread_mutex_lock      pthread_mutex_lock
#define x264_pthread_mutex_unlock    pthread_mutex_unlock
#define x264_pthread_cond_t          pthread_cond_t
#define x264_pthread_cond_init       pthread_cond_init
#define x264_pthread_cond_destroy    pthread_cond_destroy
#define x264_pthread_cond_broadcast  pthread_cond_broadcast
#define x264_pthread_cond_wait       pthread_cond_wait
#define x264_pthread_attr_t          pthread_attr_t
#define x264_pthread_attr_init       pthread_attr_init
#define x264_pthread_attr_destroy    pthread_attr_destroy
#define x264_pthread_num_processors_np pthread_num_processors_np
#define X264_PTHREAD_MUTEX_INITIALIZER PTHREAD_MUTEX_INITIALIZER

#elif HAVE_WIN32THREAD
#include "win32thread.h"

#else
#define x264_pthread_t               int
#define x264_pthread_create(t,u,f,d) 0
#define x264_pthread_join(t,s)
#endif //HAVE_*THREAD

#if !HAVE_POSIXTHREAD && !HAVE_WIN32THREAD
#define x264_pthread_mutex_t         int
#define x264_pthread_mutex_init(m,f) 0
#define x264_pthread_mutex_destroy(m)
#define x264_pthread_mutex_lock(m)
#define x264_pthread_mutex_unlock(m)
#define x264_pthread_cond_t          int
#define x264_pthread_cond_init(c,f)  0
#define x264_pthread_cond_destroy(c)
#define x264_pthread_cond_broadcast(c)
#define x264_pthread_cond_wait(c,m)
#define x264_pthread_attr_t          int
#define x264_pthread_attr_init(a)    0
#define x264_pthread_attr_destroy(a)
#define X264_PTHREAD_MUTEX_INITIALIZER 0
#endif






typedef struct
{
    int i_start, i_end; /* range of frame numbers */
    int b_force_qp; /* whether to use qp vs bitrate factor */
    int i_qp;
    float f_bitrate_factor;
    struct x264_param_t *param;
} x264_zone_t;
typedef struct

{
    int i_ref_idc;  /* nal_priority_e */
    int i_type;     /* nal_unit_type_e */
    int b_long_startcode;
    int i_first_mb; /* If this NAL is a slice, the index of the first MB in the slice. */
    int i_last_mb;  /* If this NAL is a slice, the index of the last MB in the slice. */

    /* Size of payload (including any padding) in bytes. */
    int     i_payload;
    /* If param->b_annexb is set, Annex-B bytestream with startcode.
 *      * Otherwise, startcode is replaced with a 4-byte size.
 *           * This size is the size used in mp4/similar muxing; it is equal to i_payload-4 */
    uint8_t *p_payload;

    /* Size of padding in bytes. */
    int i_padding;
} x264_nal_t;

typedef struct x264_param_t
{
    /* CPU flags */
    unsigned int cpu;
    int         i_threads;           /* encode multiple frames in parallel */
    int         i_lookahead_threads; /* multiple threads for lookahead analysis */
    int         b_sliced_threads;  /* Whether to use slice-based threading. */
    int         b_deterministic; /* whether to allow non-deterministic optimizations when threaded */
    int         b_cpu_independent; /* force canonical behavior rather than cpu-dependent optimal algorithms */
    int         i_sync_lookahead; /* threaded lookahead buffer */

    /* Video Properties */
    int         i_width;
    int         i_height;
    int         i_csp;         /* CSP of encoded bitstream */
    int         i_level_idc;
    int         i_frame_total; /* number of frames to encode if known, else 0 */

    /* NAL HRD
     * Uses Buffering and Picture Timing SEIs to signal HRD
     * The HRD in H.264 was not designed with VFR in mind.
     * It is therefore not recommendeded to use NAL HRD with VFR.
     * Furthermore, reconfiguring the VBV (via x264_encoder_reconfig)
     * will currently generate invalid HRD. */
    int         i_nal_hrd;

    struct
    {
        /* they will be reduced to be 0 < x <= 65535 and prime */
        int         i_sar_height;
        int         i_sar_width;

        int         i_overscan;    /* 0=undef, 1=no overscan, 2=overscan */

        /* see h264 annex E for the values of the following */
        int         i_vidformat;
        int         b_fullrange;
        int         i_colorprim;
        int         i_transfer;
        int         i_colmatrix;
        int         i_chroma_loc;    /* both top & bottom */
    } vui;

    /* Bitstream parameters */
    int         i_frame_reference;  /* Maximum number of reference frames */
    int         i_dpb_size;         /* Force a DPB size larger than that implied by B-frames and reference frames.
                                     * Useful in combination with interactive error resilience. */
    int         i_keyint_max;       /* Force an IDR keyframe at this interval */
    int         i_keyint_min;       /* Scenecuts closer together than this are coded as I, not IDR. */
    int         i_scenecut_threshold; /* how aggressively to insert extra I frames */
    int         b_intra_refresh;    /* Whether or not to use periodic intra refresh instead of IDR frames. */

    int         i_bframe;   /* how many b-frame between 2 references pictures */
    int         i_bframe_adaptive;
    int         i_bframe_bias;
    int         i_bframe_pyramid;   /* Keep some B-frames as references: 0=off, 1=strict hierarchical, 2=normal */
    int         b_open_gop;
    int         b_bluray_compat;
    int         i_avcintra_class;

    int         b_deblocking_filter;
    int         i_deblocking_filter_alphac0;    /* [-6, 6] -6 light filter, 6 strong */
    int         i_deblocking_filter_beta;       /* [-6, 6]  idem */

    int         b_cabac;
    int         i_cabac_init_idc;

    int         b_interlaced;
    int         b_constrained_intra;

    int         i_cqm_preset;
    char        *psz_cqm_file;      /* filename (in UTF-8) of CQM file, JM format */
    uint8_t     cqm_4iy[16];        /* used only if i_cqm_preset == X264_CQM_CUSTOM */
    uint8_t     cqm_4py[16];
    uint8_t     cqm_4ic[16];
    uint8_t     cqm_4pc[16];
    uint8_t     cqm_8iy[64];
    uint8_t     cqm_8py[64];
    uint8_t     cqm_8ic[64];
    uint8_t     cqm_8pc[64];

    /* Log */
    void        (*pf_log)( void *, int i_level, const char *psz, va_list );
    void        *p_log_private;
    int         i_log_level;
    int         b_full_recon;   /* fully reconstruct frames, even when not necessary for encoding.  Implied by psz_dump_yuv */
    char        *psz_dump_yuv;  /* filename (in UTF-8) for reconstructed frames */

    /* Encoder analyser parameters */
    struct
    {
        unsigned int intra;     /* intra partitions */
        unsigned int inter;     /* inter partitions */

        int          b_transform_8x8;
        int          i_weighted_pred; /* weighting for P-frames */
        int          b_weighted_bipred; /* implicit weighting for B-frames */
        int          i_direct_mv_pred; /* spatial vs temporal mv prediction */
        int          i_chroma_qp_offset;

        int          i_me_method; /* motion estimation algorithm to use (X264_ME_*) */
        int          i_me_range; /* integer pixel motion estimation search range (from predicted mv) */
        int          i_mv_range; /* maximum length of a mv (in pixels). -1 = auto, based on level */
        int          i_mv_range_thread; /* minimum space between threads. -1 = auto, based on number of threads. */
        int          i_subpel_refine; /* subpixel motion estimation quality */
        int          b_chroma_me; /* chroma ME for subpel and mode decision in P-frames */
        int          b_mixed_references; /* allow each mb partition to have its own reference number */
        int          i_trellis;  /* trellis RD quantization */
        int          b_fast_pskip; /* early SKIP detection on P-frames */
        int          b_dct_decimate; /* transform coefficient thresholding on P-frames */
        int          i_noise_reduction; /* adaptive pseudo-deadzone */
        float        f_psy_rd; /* Psy RD strength */
        float        f_psy_trellis; /* Psy trellis strength */
        int          b_psy; /* Toggle all psy optimizations */

        int          b_mb_info;            /* Use input mb_info data in x264_picture_t */
        int          b_mb_info_update; /* Update the values in mb_info according to the results of encoding. */

        /* the deadzone size that will be used in luma quantization */
        int          i_luma_deadzone[2]; /* {inter, intra} */

        int          b_psnr;    /* compute and print PSNR stats */
        int          b_ssim;    /* compute and print SSIM stats */
    } analyse;

    /* Rate control parameters */
    struct
    {
        int         i_rc_method;    /* X264_RC_* */

        int         i_qp_constant;  /* 0 to (51 + 6*(x264_bit_depth-8)). 0=lossless */
        int         i_qp_min;       /* min allowed QP value */
        int         i_qp_max;       /* max allowed QP value */
        int         i_qp_step;      /* max QP step between frames */

        int         i_bitrate;
        float       f_rf_constant;  /* 1pass VBR, nominal QP */
        float       f_rf_constant_max;  /* In CRF mode, maximum CRF as caused by VBV */
        float       f_rate_tolerance;
        int         i_vbv_max_bitrate;
        int         i_vbv_buffer_size;
        float       f_vbv_buffer_init; /* <=1: fraction of buffer_size. >1: kbit */
        float       f_ip_factor;
        float       f_pb_factor;

        /* VBV filler: force CBR VBV and use filler bytes to ensure hard-CBR.
         * Implied by NAL-HRD CBR. */
        int         b_filler;

        int         i_aq_mode;      /* psy adaptive QP. (X264_AQ_*) */
        float       f_aq_strength;
        int         b_mb_tree;      /* Macroblock-tree ratecontrol. */
        int         i_lookahead;

        /* 2pass */
        int         b_stat_write;   /* Enable stat writing in psz_stat_out */
        char        *psz_stat_out;  /* output filename (in UTF-8) of the 2pass stats file */
        int         b_stat_read;    /* Read stat from psz_stat_in and use it */
        char        *psz_stat_in;   /* input filename (in UTF-8) of the 2pass stats file */

        /* 2pass params (same as ffmpeg ones) */
        float       f_qcompress;    /* 0.0 => cbr, 1.0 => constant qp */
        float       f_qblur;        /* temporally blur quants */
        float       f_complexity_blur; /* temporally blur complexity */
        x264_zone_t *zones;         /* ratecontrol overrides */
        int         i_zones;        /* number of zone_t's */
        char        *psz_zones;     /* alternate method of specifying zones */
    } rc;

    /* Cropping Rectangle parameters: added to those implicitly defined by
       non-mod16 video resolutions. */
    struct
    {
        unsigned int i_left;
        unsigned int i_top;
        unsigned int i_right;
        unsigned int i_bottom;
    } crop_rect;

    /* frame packing arrangement flag */
    int i_frame_packing;

    /* Muxing parameters */
    int b_aud;                  /* generate access unit delimiters */
    int b_repeat_headers;       /* put SPS/PPS before each keyframe */
    int b_annexb;               /* if set, place start codes (4 bytes) before NAL units,
                                 * otherwise place size (4 bytes) before NAL units. */
    int i_sps_id;               /* SPS and PPS id number */
    int b_vfr_input;            /* VFR input.  If 1, use timebase and timestamps for ratecontrol purposes.
                                 * If 0, use fps only. */
    int b_pulldown;             /* use explicity set timebase for CFR */
    uint32_t i_fps_num;
    uint32_t i_fps_den;
    uint32_t i_timebase_num;    /* Timebase numerator */
    uint32_t i_timebase_den;    /* Timebase denominator */

    int b_tff;

    /* Pulldown:
     * The correct pic_struct must be passed with each input frame.
     * The input timebase should be the timebase corresponding to the output framerate. This should be constant.
     * e.g. for 3:2 pulldown timebase should be 1001/30000
     * The PTS passed with each frame must be the PTS of the frame after pulldown is applied.
     * Frame doubling and tripling require b_vfr_input set to zero (see H.264 Table D-1)
     *
     * Pulldown changes are not clearly defined in H.264. Therefore, it is the calling app's responsibility to manage this.
     */

    int b_pic_struct;

    /* Fake Interlaced.
     *
     * Used only when b_interlaced=0. Setting this flag makes it possible to flag the stream as PAFF interlaced yet
     * encode all frames progessively. It is useful for encoding 25p and 30p Blu-Ray streams.
     */

    int b_fake_interlaced;

    /* Don't optimize header parameters based on video content, e.g. ensure that splitting an input video, compressing
     * each part, and stitching them back together will result in identical SPS/PPS. This is necessary for stitching
     * with container formats that don't allow multiple SPS/PPS. */
    int b_stitchable;

    int b_opencl;            /* use OpenCL when available */
    int i_opencl_device;     /* specify count of GPU devices to skip, for CLI users */
    void *opencl_device_id;  /* pass explicit cl_device_id as void*, for API users */
    char *psz_clbin_file;    /* filename (in UTF-8) of the compiled OpenCL kernel cache file */

    /* Slicing parameters */
    int i_slice_max_size;    /* Max size per slice in bytes; includes estimated NAL overhead. */
    int i_slice_max_mbs;     /* Max number of MBs per slice; overrides i_slice_count. */
    int i_slice_min_mbs;     /* Min number of MBs per slice */
    int i_slice_count;       /* Number of slices per frame: forces rectangular slices. */
    int i_slice_count_max;   /* Absolute cap on slices per frame; stops applying slice-max-size
                              * and slice-max-mbs if this is reached. */

    /* Optional callback for freeing this x264_param_t when it is done being used.
     * Only used when the x264_param_t sits in memory for an indefinite period of time,
     * i.e. when an x264_param_t is passed to x264_t in an x264_picture_t or in zones.
     * Not used when x264_encoder_reconfig is called directly. */
    void (*param_free)( void* );

    /* Optional low-level callback for low-latency encoding.  Called for each output NAL unit
     * immediately after the NAL unit is finished encoding.  This allows the calling application
     * to begin processing video data (e.g. by sending packets over a network) before the frame
     * is done encoding.
     *
     * This callback MUST do the following in order to work correctly:
     * 1) Have available an output buffer of at least size nal->i_payload*3/2 + 5 + 64.
     * 2) Call x264_nal_encode( h, dst, nal ), where dst is the output buffer.
     * After these steps, the content of nal is valid and can be used in the same way as if
     * the NAL unit were output by x264_encoder_encode.
     *
     * This does not need to be synchronous with the encoding process: the data pointed to
     * by nal (both before and after x264_nal_encode) will remain valid until the next
     * x264_encoder_encode call.  The callback must be re-entrant.
     *
     * This callback does not work with frame-based threads; threads must be disabled
     * or sliced-threads enabled.  This callback also does not work as one would expect
     * with HRD -- since the buffering period SEI cannot be calculated until the frame
     * is finished encoding, it will not be sent via this callback.
     *
     * Note also that the NALs are not necessarily returned in order when sliced threads is
     * enabled.  Accordingly, the variable i_first_mb and i_last_mb are available in
     * x264_nal_t to help the calling application reorder the slices if necessary.
     *
     * When this callback is enabled, x264_encoder_encode does not return valid NALs;
     * the calling application is expected to acquire all output NALs through the callback.
     *
     * It is generally sensible to combine this callback with a use of slice-max-mbs or
     * slice-max-size.
     *
     * The opaque pointer is the opaque pointer from the input frame associated with this
     * NAL unit. This helps distinguish between nalu_process calls from different sources,
     * e.g. if doing multiple encodes in one process.
     */
    void (*nalu_process) ( x264_t *h, x264_nal_t *nal, void *opaque );
} x264_param_t;


typedef struct x264_frame
{
    /* */
    uint8_t *base;       /* Base pointer for all malloced data in this frame. */
    int     i_poc;
    int     i_delta_poc[2];
    int     i_type;
    int     i_qpplus1;
    int64_t i_pts;
    int64_t i_dts;
    int64_t i_reordered_pts;
    int64_t i_duration;  /* in SPS time_scale units (i.e 2 * timebase units) used for vfr */
    float   f_duration;  /* in seconds */
    int64_t i_cpb_duration;
    int64_t i_cpb_delay; /* in SPS time_scale units (i.e 2 * timebase units) */
    int64_t i_dpb_output_delay;
    x264_param_t *param;

    int     i_frame;     /* Presentation frame number */
    int     i_coded;     /* Coded frame number */
    int64_t i_field_cnt; /* Presentation field count */
    int     i_frame_num; /* 7.4.3 frame_num */
    int     b_kept_as_ref;
    int     i_pic_struct;
    int     b_keyframe;
    uint8_t b_fdec;
    uint8_t b_last_minigop_bframe; /* this frame is the last b in a sequence of bframes */
    uint8_t i_bframes;   /* number of bframes following this nonb in coded order */
    float   f_qp_avg_rc; /* QPs as decided by ratecontrol */
    float   f_qp_avg_aq; /* QPs as decided by AQ in addition to ratecontrol */
    float   f_crf_avg;   /* Average effective CRF for this frame */
    int     i_poc_l0ref0; /* poc of first refframe in L0, used to check if direct temporal is possible */

    /* YUV buffer */
    int     i_csp; /* Internal csp */
    int     i_plane;
    int     i_stride[3];
    int     i_width[3];
    int     i_lines[3];
    int     i_stride_lowres;
    int     i_width_lowres;
    int     i_lines_lowres;
    pixel *plane[3];
    pixel *plane_fld[3];
    pixel *filtered[3][4]; /* plane[0], H, V, HV */
    pixel *filtered_fld[3][4];
    pixel *lowres[4]; /* half-size copy of input frame: Orig, H, V, HV */
    uint16_t *integral;

    /* for unrestricted mv we allocate more data than needed
     * allocated data are stored in buffer */
    pixel *buffer[4];
    pixel *buffer_fld[4];
    pixel *buffer_lowres[4];

    x264_weight_t weight[X264_REF_MAX][3]; /* [ref_index][plane] */
    pixel *weighted[X264_REF_MAX]; /* plane[0] weighted of the reference frames */
    int b_duplicate;
    struct x264_frame *orig;

    /* motion data */
    int8_t  *mb_type;
    uint8_t *mb_partition;
    int16_t (*mv[2])[2];
    int16_t (*mv16x16)[2];
    int16_t (*lowres_mvs[2][X264_BFRAME_MAX+1])[2];
    uint8_t *field;
    uint8_t *effective_qp;

    /* Stored as (lists_used << LOWRES_COST_SHIFT) + (cost).
     * Doesn't need special addressing for intra cost because
     * lists_used is guaranteed to be zero in that cast. */
    uint16_t (*lowres_costs[X264_BFRAME_MAX+2][X264_BFRAME_MAX+2]);
    #define LOWRES_COST_MASK ((1<<14)-1)
    #define LOWRES_COST_SHIFT 14

    int     *lowres_mv_costs[2][X264_BFRAME_MAX+1];
    int8_t  *ref[2];
    int     i_ref[2];
    int     ref_poc[2][X264_REF_MAX];
    int16_t inv_ref_poc[2]; // inverse values of ref0 poc to avoid divisions in temporal MV prediction

    /* for adaptive B-frame decision.
     * contains the SATD cost of the lowres frame encoded in various modes
     * FIXME: how big an array do we need? */
    int     i_cost_est[X264_BFRAME_MAX+2][X264_BFRAME_MAX+2];
    int     i_cost_est_aq[X264_BFRAME_MAX+2][X264_BFRAME_MAX+2];
    int     i_satd; // the i_cost_est of the selected frametype
    int     i_intra_mbs[X264_BFRAME_MAX+2];
    int     *i_row_satds[X264_BFRAME_MAX+2][X264_BFRAME_MAX+2];
    int     *i_row_satd;
    int     *i_row_bits;
    float   *f_row_qp;
    float   *f_row_qscale;
    float   *f_qp_offset;
    float   *f_qp_offset_aq;
    int     b_intra_calculated;
    uint16_t *i_intra_cost;
    uint16_t *i_propagate_cost;
    uint16_t *i_inv_qscale_factor;
    int     b_scenecut; /* Set to zero if the frame cannot possibly be part of a real scenecut. */
    float   f_weighted_cost_delta[X264_BFRAME_MAX+2];
    uint32_t i_pixel_sum[3];
    uint64_t i_pixel_ssd[3];

    /* hrd */
    x264_hrd_t hrd_timing;

    /* vbv */
    uint8_t i_planned_type[X264_LOOKAHEAD_MAX+1];
    int i_planned_satd[X264_LOOKAHEAD_MAX+1];
    double f_planned_cpb_duration[X264_LOOKAHEAD_MAX+1];
    int64_t i_coded_fields_lookahead;
    int64_t i_cpb_delay_lookahead;

    /* threading */
    int     i_lines_completed; /* in pixels */
    int     i_lines_weighted; /* FIXME: this only supports weighting of one reference frame */
    int     i_reference_count; /* number of threads using this frame (not necessarily the number of pointers) */
    x264_pthread_mutex_t mutex;
    x264_pthread_cond_t  cv;
    int     i_slice_count; /* Atomically written to/read from with slice threads */

    /* periodic intra refresh */
    float   f_pir_position;
    int     i_pir_start_col;
    int     i_pir_end_col;
    int     i_frames_since_pir;

    /* interactive encoder control */
    int     b_corrupt;

    /* user sei */
    x264_sei_t extra_sei;

    /* user data */
    void *opaque;

    /* user frame properties */
    uint8_t *mb_info;
    void (*mb_info_free)( void* );

#if HAVE_OPENCL
    x264_frame_opencl_t opencl;
#endif
} x264_frame_t;

typedef struct
{
   x264_frame_t **list;
   int i_max_size;
   int i_size;
   x264_pthread_mutex_t     mutex;
   x264_pthread_cond_t      cv_fill;  /* event signaling that the list became fuller */
   x264_pthread_cond_t      cv_empty; /* event signaling that the list became emptier */
} x264_sync_frame_list_t;




typedef struct x264_threadpool_t
{
    int            exit;
    int            threads;
    x264_pthread_t *thread_handle;
    void           (*init_func)(void *);
    void           *init_arg;

    /* requires a synchronized list structure and associated methods,
       so use what is already implemented for frames */
    x264_sync_frame_list_t uninit; /* list of jobs that are awaiting use */
    x264_sync_frame_list_t run;    /* list of jobs that are queued for processing by the pool */
    x264_sync_frame_list_t done;   /* list of jobs that have finished processing */
} x264_threadpool_t;





typedef struct bs_s
{
    uint8_t *p_start;
    uint8_t *p;
    uint8_t *p_end;

    uintptr_t cur_bits;
    int     i_left;    /* i_count number of available bits */
    int     i_bits_encoded; /* RD only */
} bs_t;

typedef uint16_t udctcoef ;

typedef struct
{
    int i_id;

    int i_profile_idc;
    int i_level_idc;

    int b_constraint_set0;
    int b_constraint_set1;
    int b_constraint_set2;
    int b_constraint_set3;

    int i_log2_max_frame_num;

    int i_poc_type;
    /* poc 0 */
    int i_log2_max_poc_lsb;

    int i_num_ref_frames;
    int b_gaps_in_frame_num_value_allowed;
    int i_mb_width;
    int i_mb_height;
    int b_frame_mbs_only;
    int b_mb_adaptive_frame_field;
    int b_direct8x8_inference;

    int b_crop;
    struct
    {
        int i_left;
        int i_right;
        int i_top;
        int i_bottom;
    } crop;

    int b_vui;
    struct
    {
        int b_aspect_ratio_info_present;
        int i_sar_width;
        int i_sar_height;

        int b_overscan_info_present;
        int b_overscan_info;

        int b_signal_type_present;
        int i_vidformat;
        int b_fullrange;
        int b_color_description_present;
        int i_colorprim;
        int i_transfer;
        int i_colmatrix;

        int b_chroma_loc_info_present;
        int i_chroma_loc_top;
        int i_chroma_loc_bottom;

        int b_timing_info_present;
        uint32_t i_num_units_in_tick;
        uint32_t i_time_scale;
        int b_fixed_frame_rate;

        int b_nal_hrd_parameters_present;
        int b_vcl_hrd_parameters_present;

        struct
        {
            int i_cpb_cnt;
            int i_bit_rate_scale;
            int i_cpb_size_scale;
            int i_bit_rate_value;
            int i_cpb_size_value;
            int i_bit_rate_unscaled;
            int i_cpb_size_unscaled;
            int b_cbr_hrd;

            int i_initial_cpb_removal_delay_length;
            int i_cpb_removal_delay_length;
            int i_dpb_output_delay_length;
            int i_time_offset_length;
        } hrd;

        int b_pic_struct_present;
        int b_bitstream_restriction;
        int b_motion_vectors_over_pic_boundaries;
        int i_max_bytes_per_pic_denom;
        int i_max_bits_per_mb_denom;
        int i_log2_max_mv_length_horizontal;
        int i_log2_max_mv_length_vertical;
        int i_num_reorder_frames;
        int i_max_dec_frame_buffering;

        /* FIXME to complete */
    } vui;

    int b_qpprime_y_zero_transform_bypass;
    int i_chroma_format_idc;

} x264_sps_t;


typedef struct
{
    int i_id;
    int i_sps_id;

    int b_cabac;

    int b_pic_order;
    int i_num_slice_groups;

    int i_num_ref_idx_l0_default_active;
    int i_num_ref_idx_l1_default_active;

    int b_weighted_pred;
    int b_weighted_bipred;

    int i_pic_init_qp;
    int i_pic_init_qs;

    int i_chroma_qp_index_offset;

    int b_deblocking_filter_control;
    int b_constrained_intra_pred;
    int b_redundant_pic_cnt;

    int b_transform_8x8_mode;

    int i_cqm_preset;
    const uint8_t *scaling_list[8]; /* could be 12, but we don't allow separate Cb/Cr lists */

} x264_pps_t;

typedef struct
{
    /* state */
    int i_low;
    int i_range;

    /* bit stream */
    int i_queue; //stored with an offset of -8 for faster asm
    int i_bytes_outstanding;

    uint8_t *p_start;
    uint8_t *p;
    uint8_t *p_end;

    /* aligned for memcpy_aligned starting here */
   ALIGNED_16( int f8_bits_encoded ); // only if using x264_cabac_size_decision()

    /* context */
    uint8_t state[1024];

    /* for 16-byte alignment */
    uint8_t padding[12];
} x264_cabac_t;


typedef int16_t  dctcoef;

typedef struct x264_left_table_t
{
    uint8_t intra[4];
    uint8_t nnz[4];
    uint8_t nnz_chroma[4];
    uint8_t mv[4];
    uint8_t ref[4];
} x264_left_table_t;



typedef void (*x264_predict_t)( pixel *src );
typedef void (*x264_predict8x8_t)( pixel *src, pixel edge[36] );
typedef void (*x264_predict_8x8_filter_t) ( pixel *src, pixel edge[36], int i_neighbor, int i_filters );
typedef struct
{
    x264_pixel_cmp_t  sad[8];
    x264_pixel_cmp_t  ssd[8];
    x264_pixel_cmp_t satd[8];
    x264_pixel_cmp_t ssim[7];
    x264_pixel_cmp_t sa8d[4];
    x264_pixel_cmp_t mbcmp[8]; /* either satd or sad for subpel refine and mode decision */
    x264_pixel_cmp_t mbcmp_unaligned[8]; /* unaligned mbcmp for subpel */
    x264_pixel_cmp_t fpelcmp[8]; /* either satd or sad for fullpel motion search */
    x264_pixel_cmp_x3_t fpelcmp_x3[7];
    x264_pixel_cmp_x4_t fpelcmp_x4[7];
    x264_pixel_cmp_t sad_aligned[8]; /* Aligned SAD for mbcmp */
    int (*vsad)( pixel *, intptr_t, int );
    int (*asd8)( pixel *pix1, intptr_t stride1, pixel *pix2, intptr_t stride2, int height );
    uint64_t (*sa8d_satd[1])( pixel *pix1, intptr_t stride1, pixel *pix2, intptr_t stride2 );

    uint64_t (*var[4])( pixel *pix, intptr_t stride );
    int (*var2[4])( pixel *pix1, intptr_t stride1,
                    pixel *pix2, intptr_t stride2, int *ssd );
    uint64_t (*hadamard_ac[4])( pixel *pix, intptr_t stride );

    void (*ssd_nv12_core)( pixel *pixuv1, intptr_t stride1,
                           pixel *pixuv2, intptr_t stride2, int width, int height,
                           uint64_t *ssd_u, uint64_t *ssd_v );
    void (*ssim_4x4x2_core)( const pixel *pix1, intptr_t stride1,
                             const pixel *pix2, intptr_t stride2, int sums[2][4] );
    float (*ssim_end4)( int sum0[5][4], int sum1[5][4], int width );

    /* multiple parallel calls to cmp. */
    x264_pixel_cmp_x3_t sad_x3[7];
    x264_pixel_cmp_x4_t sad_x4[7];
    x264_pixel_cmp_x3_t satd_x3[7];
    x264_pixel_cmp_x4_t satd_x4[7];

    /* abs-diff-sum for successive elimination.
     * may round width up to a multiple of 16. */
    int (*ads[7])( int enc_dc[4], uint16_t *sums, int delta,
                   uint16_t *cost_mvx, int16_t *mvs, int width, int thresh );

    /* calculate satd or sad of V, H, and DC modes. */
    void (*intra_mbcmp_x3_16x16)( pixel *fenc, pixel *fdec, int res[3] );
    void (*intra_satd_x3_16x16) ( pixel *fenc, pixel *fdec, int res[3] );
    void (*intra_sad_x3_16x16)  ( pixel *fenc, pixel *fdec, int res[3] );
    void (*intra_mbcmp_x3_4x4)  ( pixel *fenc, pixel *fdec, int res[3] );
    void (*intra_satd_x3_4x4)   ( pixel *fenc, pixel *fdec, int res[3] );
    void (*intra_sad_x3_4x4)    ( pixel *fenc, pixel *fdec, int res[3] );
    void (*intra_mbcmp_x3_chroma)( pixel *fenc, pixel *fdec, int res[3] );
    void (*intra_satd_x3_chroma) ( pixel *fenc, pixel *fdec, int res[3] );
    void (*intra_sad_x3_chroma)  ( pixel *fenc, pixel *fdec, int res[3] );
    void (*intra_mbcmp_x3_8x16c) ( pixel *fenc, pixel *fdec, int res[3] );
    void (*intra_satd_x3_8x16c)  ( pixel *fenc, pixel *fdec, int res[3] );
    void (*intra_sad_x3_8x16c)   ( pixel *fenc, pixel *fdec, int res[3] );
    void (*intra_mbcmp_x3_8x8c)  ( pixel *fenc, pixel *fdec, int res[3] );
    void (*intra_satd_x3_8x8c)   ( pixel *fenc, pixel *fdec, int res[3] );
    void (*intra_sad_x3_8x8c)    ( pixel *fenc, pixel *fdec, int res[3] );
    void (*intra_mbcmp_x3_8x8)  ( pixel *fenc, pixel edge[36], int res[3] );
    void (*intra_sa8d_x3_8x8)   ( pixel *fenc, pixel edge[36], int res[3] );
    void (*intra_sad_x3_8x8)    ( pixel *fenc, pixel edge[36], int res[3] );
    /* find minimum satd or sad of all modes, and set fdec.
     * may be NULL, in which case just use pred+satd instead. */
    int (*intra_mbcmp_x9_4x4)( pixel *fenc, pixel *fdec, uint16_t *bitcosts );
    int (*intra_satd_x9_4x4) ( pixel *fenc, pixel *fdec, uint16_t *bitcosts );
    int (*intra_sad_x9_4x4)  ( pixel *fenc, pixel *fdec, uint16_t *bitcosts );
    int (*intra_mbcmp_x9_8x8)( pixel *fenc, pixel *fdec, pixel edge[36], uint16_t *bitcosts, uint16_t *satds );
    int (*intra_sa8d_x9_8x8) ( pixel *fenc, pixel *fdec, pixel edge[36], uint16_t *bitcosts, uint16_t *satds );
    int (*intra_sad_x9_8x8)  ( pixel *fenc, pixel *fdec, pixel edge[36], uint16_t *bitcosts, uint16_t *satds );
} x264_pixel_function_t;

/* Do the MC
 * XXX: Only width = 4, 8 or 16 are valid
 * width == 4 -> height == 4 or 8
 * width == 8 -> height == 4 or 8 or 16
 * width == 16-> height == 8 or 16
 * */

typedef struct
{
    void (*mc_luma)( pixel *dst, intptr_t i_dst, pixel **src, intptr_t i_src,
                     int mvx, int mvy, int i_width, int i_height, const x264_weight_t *weight );

    /* may round up the dimensions if they're not a power of 2 */
    pixel* (*get_ref)( pixel *dst, intptr_t *i_dst, pixel **src, intptr_t i_src,
                       int mvx, int mvy, int i_width, int i_height, const x264_weight_t *weight );

    /* mc_chroma may write up to 2 bytes of garbage to the right of dst,
     * so it must be run from left to right. */
    void (*mc_chroma)( pixel *dstu, pixel *dstv, intptr_t i_dst, pixel *src, intptr_t i_src,
                       int mvx, int mvy, int i_width, int i_height );

    void (*avg[12])( pixel *dst,  intptr_t dst_stride, pixel *src1, intptr_t src1_stride,
                     pixel *src2, intptr_t src2_stride, int i_weight );

    /* only 16x16, 8x8, and 4x4 defined */
    void (*copy[7])( pixel *dst, intptr_t dst_stride, pixel *src, intptr_t src_stride, int i_height );
    void (*copy_16x16_unaligned)( pixel *dst, intptr_t dst_stride, pixel *src, intptr_t src_stride, int i_height );

    void (*store_interleave_chroma)( pixel *dst, intptr_t i_dst, pixel *srcu, pixel *srcv, int height );
    void (*load_deinterleave_chroma_fenc)( pixel *dst, pixel *src, intptr_t i_src, int height );
    void (*load_deinterleave_chroma_fdec)( pixel *dst, pixel *src, intptr_t i_src, int height );

    void (*plane_copy)( pixel *dst, intptr_t i_dst, pixel *src, intptr_t i_src, int w, int h );
    void (*plane_copy_interleave)( pixel *dst,  intptr_t i_dst, pixel *srcu, intptr_t i_srcu,
                                   pixel *srcv, intptr_t i_srcv, int w, int h );
    /* may write up to 15 pixels off the end of each plane */
    void (*plane_copy_deinterleave)( pixel *dstu, intptr_t i_dstu, pixel *dstv, intptr_t i_dstv,
                                     pixel *src,  intptr_t i_src, int w, int h );
    void (*plane_copy_deinterleave_rgb)( pixel *dsta, intptr_t i_dsta, pixel *dstb, intptr_t i_dstb,
                                         pixel *dstc, intptr_t i_dstc, pixel *src,  intptr_t i_src, int pw, int w, int h );
    void (*plane_copy_deinterleave_v210)( pixel *dsty, intptr_t i_dsty,
                                          pixel *dstc, intptr_t i_dstc,
                                          uint32_t *src, intptr_t i_src, int w, int h );
    void (*hpel_filter)( pixel *dsth, pixel *dstv, pixel *dstc, pixel *src,
                         intptr_t i_stride, int i_width, int i_height, int16_t *buf );

    /* prefetch the next few macroblocks of fenc or fdec */
    void (*prefetch_fenc)    ( pixel *pix_y, intptr_t stride_y, pixel *pix_uv, intptr_t stride_uv, int mb_x );
    void (*prefetch_fenc_420)( pixel *pix_y, intptr_t stride_y, pixel *pix_uv, intptr_t stride_uv, int mb_x );
    void (*prefetch_fenc_422)( pixel *pix_y, intptr_t stride_y, pixel *pix_uv, intptr_t stride_uv, int mb_x );
    /* prefetch the next few macroblocks of a hpel reference frame */
    void (*prefetch_ref)( pixel *pix, intptr_t stride, int parity );

    void *(*memcpy_aligned)( void *dst, const void *src, size_t n );
    void (*memzero_aligned)( void *dst, size_t n );

    /* successive elimination prefilter */
    void (*integral_init4h)( uint16_t *sum, pixel *pix, intptr_t stride );
    void (*integral_init8h)( uint16_t *sum, pixel *pix, intptr_t stride );
    void (*integral_init4v)( uint16_t *sum8, uint16_t *sum4, intptr_t stride );
    void (*integral_init8v)( uint16_t *sum8, intptr_t stride );

    void (*frame_init_lowres_core)( pixel *src0, pixel *dst0, pixel *dsth, pixel *dstv, pixel *dstc,
                                    intptr_t src_stride, intptr_t dst_stride, int width, int height );
    weight_fn_t *weight;
    weight_fn_t *offsetadd;
    weight_fn_t *offsetsub;
    void (*weight_cache)( x264_t *, x264_weight_t * );

    void (*mbtree_propagate_cost)( int16_t *dst, uint16_t *propagate_in, uint16_t *intra_costs,
                                   uint16_t *inter_costs, uint16_t *inv_qscales, float *fps_factor, int len );

    void (*mbtree_propagate_list)( x264_t *h, uint16_t *ref_costs, int16_t (*mvs)[2],
                                   int16_t *propagate_amount, uint16_t *lowres_costs,
                                   int bipred_weight, int mb_y, int len, int list );
} x264_mc_functions_t;


typedef struct
{
    // pix1  stride = FENC_STRIDE
    // pix2  stride = FDEC_STRIDE
    // p_dst stride = FDEC_STRIDE
    void (*sub4x4_dct)   ( dctcoef dct[16], pixel *pix1, pixel *pix2 );
    void (*add4x4_idct)  ( pixel *p_dst, dctcoef dct[16] );

    void (*sub8x8_dct)   ( dctcoef dct[4][16], pixel *pix1, pixel *pix2 );
    void (*sub8x8_dct_dc)( dctcoef dct[4], pixel *pix1, pixel *pix2 );
    void (*add8x8_idct)  ( pixel *p_dst, dctcoef dct[4][16] );
    void (*add8x8_idct_dc) ( pixel *p_dst, dctcoef dct[4] );

    void (*sub8x16_dct_dc)( dctcoef dct[8], pixel *pix1, pixel *pix2 );

    void (*sub16x16_dct) ( dctcoef dct[16][16], pixel *pix1, pixel *pix2 );
    void (*add16x16_idct)( pixel *p_dst, dctcoef dct[16][16] );
    void (*add16x16_idct_dc) ( pixel *p_dst, dctcoef dct[16] );

    void (*sub8x8_dct8)  ( dctcoef dct[64], pixel *pix1, pixel *pix2 );
    void (*add8x8_idct8) ( pixel *p_dst, dctcoef dct[64] );

    void (*sub16x16_dct8) ( dctcoef dct[4][64], pixel *pix1, pixel *pix2 );
    void (*add16x16_idct8)( pixel *p_dst, dctcoef dct[4][64] );

    void (*dct4x4dc) ( dctcoef d[16] );
    void (*idct4x4dc)( dctcoef d[16] );

    void (*dct2x4dc)( dctcoef dct[8], dctcoef dct4x4[8][16] );

} x264_dct_function_t;

typedef struct
{
    void (*scan_8x8)( dctcoef level[64], dctcoef dct[64] );
    void (*scan_4x4)( dctcoef level[16], dctcoef dct[16] );
    int  (*sub_8x8)  ( dctcoef level[64], const pixel *p_src, pixel *p_dst );
    int  (*sub_4x4)  ( dctcoef level[16], const pixel *p_src, pixel *p_dst );
    int  (*sub_4x4ac)( dctcoef level[16], const pixel *p_src, pixel *p_dst, dctcoef *dc );
    void (*interleave_8x8_cavlc)( dctcoef *dst, dctcoef *src, uint8_t *nnz );

} x264_zigzag_function_t;

typedef struct
{
    int32_t last;
    int32_t mask;
    ALIGNED_16( dctcoef level[18] );
} x264_run_level_t;
typedef struct
{
    int (*quant_8x8)  ( dctcoef dct[64], udctcoef mf[64], udctcoef bias[64] );
    int (*quant_4x4)  ( dctcoef dct[16], udctcoef mf[16], udctcoef bias[16] );
    int (*quant_4x4x4)( dctcoef dct[4][16], udctcoef mf[16], udctcoef bias[16] );
    int (*quant_4x4_dc)( dctcoef dct[16], int mf, int bias );
    int (*quant_2x2_dc)( dctcoef dct[4], int mf, int bias );

    void (*dequant_8x8)( dctcoef dct[64], int dequant_mf[6][64], int i_qp );
    void (*dequant_4x4)( dctcoef dct[16], int dequant_mf[6][16], int i_qp );
    void (*dequant_4x4_dc)( dctcoef dct[16], int dequant_mf[6][16], int i_qp );

    void (*idct_dequant_2x4_dc)( dctcoef dct[8], dctcoef dct4x4[8][16], int dequant_mf[6][16], int i_qp );
    void (*idct_dequant_2x4_dconly)( dctcoef dct[8], int dequant_mf[6][16], int i_qp );

    int (*optimize_chroma_2x2_dc)( dctcoef dct[4], int dequant_mf );
    int (*optimize_chroma_2x4_dc)( dctcoef dct[8], int dequant_mf );

    void (*denoise_dct)( dctcoef *dct, uint32_t *sum, udctcoef *offset, int size );

    int (*decimate_score15)( dctcoef *dct );
    int (*decimate_score16)( dctcoef *dct );
    int (*decimate_score64)( dctcoef *dct );
    int (*coeff_last[14])( dctcoef *dct );
    int (*coeff_last4)( dctcoef *dct );
    int (*coeff_last8)( dctcoef *dct );
    int (*coeff_level_run[13])( dctcoef *dct, x264_run_level_t *runlevel );
    int (*coeff_level_run4)( dctcoef *dct, x264_run_level_t *runlevel );
    int (*coeff_level_run8)( dctcoef *dct, x264_run_level_t *runlevel );

#define TRELLIS_PARAMS const int *unquant_mf, const uint8_t *zigzag, int lambda2,\
                       int last_nnz, dctcoef *coefs, dctcoef *quant_coefs, dctcoef *dct,\
                       uint8_t *cabac_state_sig, uint8_t *cabac_state_last,\
                       uint64_t level_state0, uint16_t level_state1
    int (*trellis_cabac_4x4)( TRELLIS_PARAMS, int b_ac );
    int (*trellis_cabac_8x8)( TRELLIS_PARAMS, int b_interlaced );
    int (*trellis_cabac_4x4_psy)( TRELLIS_PARAMS, int b_ac, dctcoef *fenc_dct, int psy_trellis );
    int (*trellis_cabac_8x8_psy)( TRELLIS_PARAMS, int b_interlaced, dctcoef *fenc_dct, int psy_trellis );
    int (*trellis_cabac_dc)( TRELLIS_PARAMS, int num_coefs );
    int (*trellis_cabac_chroma_422_dc)( TRELLIS_PARAMS );
} x264_quant_function_t;

#define X264_SCAN8_LUMA_SIZE (5*8)
#define X264_SCAN8_SIZE (X264_SCAN8_LUMA_SIZE*3)
#define X264_SCAN8_0 (4+1*8)

typedef void (*x264_deblock_inter_t)( pixel *pix, intptr_t stride, int alpha, int beta, int8_t *tc0 );
typedef void (*x264_deblock_intra_t)( pixel *pix, intptr_t stride, int alpha, int beta );
typedef struct
{
    x264_deblock_inter_t deblock_luma[2];
    x264_deblock_inter_t deblock_chroma[2];
    x264_deblock_inter_t deblock_h_chroma_420;
    x264_deblock_inter_t deblock_h_chroma_422;
    x264_deblock_intra_t deblock_luma_intra[2];
    x264_deblock_intra_t deblock_chroma_intra[2];
    x264_deblock_intra_t deblock_h_chroma_420_intra;
    x264_deblock_intra_t deblock_h_chroma_422_intra;
    x264_deblock_inter_t deblock_luma_mbaff;
    x264_deblock_inter_t deblock_chroma_mbaff;
    x264_deblock_inter_t deblock_chroma_420_mbaff;
    x264_deblock_inter_t deblock_chroma_422_mbaff;
    x264_deblock_intra_t deblock_luma_intra_mbaff;
    x264_deblock_intra_t deblock_chroma_intra_mbaff;
    x264_deblock_intra_t deblock_chroma_420_intra_mbaff;
    x264_deblock_intra_t deblock_chroma_422_intra_mbaff;
    void (*deblock_strength) ( uint8_t nnz[X264_SCAN8_SIZE], int8_t ref[2][X264_SCAN8_LUMA_SIZE],
                               int16_t mv[2][X264_SCAN8_LUMA_SIZE][2], uint8_t bs[2][8][4], int mvy_limit,
                               int bframe );
} x264_deblock_function_t;


typedef struct
{
    uint8_t *(*nal_escape) ( uint8_t *dst, uint8_t *src, uint8_t *end );
    void (*cabac_block_residual_internal)( dctcoef *l, int b_interlaced,
                                           intptr_t ctx_block_cat, x264_cabac_t *cb );
    void (*cabac_block_residual_rd_internal)( dctcoef *l, int b_interlaced,
                                              intptr_t ctx_block_cat, x264_cabac_t *cb );
    void (*cabac_block_residual_8x8_rd_internal)( dctcoef *l, int b_interlaced,
                                                  intptr_t ctx_block_cat, x264_cabac_t *cb );
} x264_bitstream_function_t;


typedef struct x264_lookahead_t
{
    volatile uint8_t              b_exit_thread;
    uint8_t                       b_thread_active;
    uint8_t                       b_analyse_keyframe;
    int                           i_last_keyframe;
    int                           i_slicetype_length;
    x264_frame_t                  *last_nonb;
    x264_pthread_t                thread_handle;
    x264_sync_frame_list_t        ifbuf;
    x264_sync_frame_list_t        next;
    x264_sync_frame_list_t        ofbuf;
} x264_lookahead_t;

typedef struct
{
    x264_sps_t *sps;
    x264_pps_t *pps;

    int i_type;
    int i_first_mb;
    int i_last_mb;

    int i_pps_id;

    int i_frame_num;

    int b_mbaff;
    int b_field_pic;
    int b_bottom_field;

    int i_idr_pic_id;   /* -1 if nal_type != 5 */

    int i_poc;
    int i_delta_poc_bottom;

    int i_delta_poc[2];
    int i_redundant_pic_cnt;

    int b_direct_spatial_mv_pred;

    int b_num_ref_idx_override;
    int i_num_ref_idx_l0_active;
    int i_num_ref_idx_l1_active;

    int b_ref_pic_list_reordering[2];
    struct
    {
        int idc;
        int arg;
    } ref_pic_list_order[2][X264_REF_MAX];

    /* P-frame weighting */
    int b_weighted_pred;
    x264_weight_t weight[X264_REF_MAX*2][3];

    int i_mmco_remove_from_end;
    int i_mmco_command_count;
    struct /* struct for future expansion */
    {
        int i_difference_of_pic_nums;
        int i_poc;
    } mmco[X264_REF_MAX];

    int i_cabac_init_idc;

    int i_qp;
    int i_qp_delta;
    int b_sp_for_swidth;
    int i_qs_delta;

    /* deblocking filter */
    int i_disable_deblocking_filter_idc;
    int i_alpha_c0_offset;
    int i_beta_offset;

} x264_slice_header_t;


//typedef struct x264_ratecontrol_t   x264_ratecontrol_t;

typedef struct
{
    int pict_type;
    int frame_type;
    int kept_as_ref;
    double qscale;
    int mv_bits;
    int tex_bits;
    int misc_bits;
    uint64_t expected_bits; /*total expected bits up to the current frame (current one excluded)*/
    double expected_vbv;
    double new_qscale;
    int new_qp;
    int i_count;
    int p_count;
    int s_count;
    float blurred_complexity;
    char direct_mode;
    int16_t weight[3][2];
    int16_t i_weight_denom[2];
    int refcount[16];
    int refs;
    int64_t i_duration;
    int64_t i_cpb_duration;
} ratecontrol_entry_t;

typedef struct
{
    float coeff_min;
    float coeff;
    float count;
    float decay;
    float offset;
} predictor_t;

typedef struct x264_ratecontrol_t
{
    /* constants */
    int b_abr;
    int b_2pass;
    int b_vbv;
    int b_vbv_min_rate;
    double fps;
    double bitrate;
    double rate_tolerance;
    double qcompress;
    int nmb;                    /* number of macroblocks in a frame */
    int qp_constant[3];

    /* current frame */
    ratecontrol_entry_t *rce;
    int qp;                     /* qp for current frame */
    float qpm;                  /* qp for current macroblock: precise float for AQ */
    float qpa_rc;               /* average of macroblocks' qp before aq */
    float qpa_rc_prev;
    int   qpa_aq;               /* average of macroblocks' qp after aq */
    int   qpa_aq_prev;
    float qp_novbv;             /* QP for the current frame if 1-pass VBV was disabled. */

    /* VBV stuff */
    double buffer_size;
    int64_t buffer_fill_final;
    double buffer_fill;         /* planned buffer, if all in-progress frames hit their bit budget */
    double buffer_rate;         /* # of bits added to buffer_fill after each frame */
    double vbv_max_rate;        /* # of bits added to buffer_fill per second */
    predictor_t *pred;          /* predict frame size from satd */
    int single_frame_vbv;
    float rate_factor_max_increment; /* Don't allow RF above (CRF + this value). */

    /* ABR stuff */
    int    last_satd;
    double last_rceq;
    double cplxr_sum;           /* sum of bits*qscale/rceq */
    double expected_bits_sum;   /* sum of qscale2bits after rceq, ratefactor, and overflow, only includes finished frames */
    int64_t filler_bits_sum;    /* sum in bits of finished frames' filler data */
    double wanted_bits_window;  /* target bitrate * window */
    double cbr_decay;
    double short_term_cplxsum;
    double short_term_cplxcount;
    double rate_factor_constant;
    double ip_offset;
    double pb_offset;

    /* 2pass stuff */
    FILE *p_stat_file_out;
    char *psz_stat_file_tmpname;
    FILE *p_mbtree_stat_file_out;
    char *psz_mbtree_stat_file_tmpname;
    char *psz_mbtree_stat_file_name;
    FILE *p_mbtree_stat_file_in;

    int num_entries;            /* number of ratecontrol_entry_ts */
    ratecontrol_entry_t *entry; /* FIXME: copy needed data and free this once init is done */
    double last_qscale;
    double last_qscale_for[3];  /* last qscale for a specific pict type, used for max_diff & ipb factor stuff */
    int last_non_b_pict_type;
    double accum_p_qp;          /* for determining I-frame quant */
    double accum_p_norm;
    double last_accum_p_norm;
    double lmin[3];             /* min qscale by frame type */
    double lmax[3];
    double lstep;               /* max change (multiply) in qscale per frame */
    struct
    {
        uint16_t *qp_buffer[2]; /* Global buffers for converting MB-tree quantizer data. */
        int qpbuf_pos;          /* In order to handle pyramid reordering, QP buffer acts as a stack.
                                 * This value is the current position (0 or 1). */
        int src_mb_count;

        /* For rescaling */
        int rescale_enabled;
        float *scale_buffer[2]; /* Intermediate buffers */
        int filtersize[2];      /* filter size (H/V) */
        float *coeffs[2];
        int *pos[2];
        int srcdim[2];          /* Source dimensions (W/H) */
    } mbtree;

    /* MBRC stuff */
    float frame_size_estimated; /* Access to this variable must be atomic: double is
                                 * not atomic on all arches we care about */
    double frame_size_maximum;  /* Maximum frame size due to MinCR */
    double frame_size_planned;
    double slice_size_planned;
    predictor_t (*row_pred)[2];
    predictor_t row_preds[3][2];
    predictor_t *pred_b_from_p; /* predict B-frame size from P-frame satd */
    int bframes;                /* # consecutive B-frames before this P-frame */
    int bframe_bits;            /* total cost of those frames */

    int i_zones;
    x264_zone_t *zones;
    x264_zone_t *prev_zone;

    /* hrd stuff */
    int initial_cpb_removal_delay;
    int initial_cpb_removal_delay_offset;
    double nrt_first_access_unit; /* nominal removal time */
    double previous_cpb_final_arrival_time;
    uint64_t hrd_multiply_denom;
} x264_ratecontrol_t;


/* Current frame stats */
typedef struct
{
    /* MV bits (MV+Ref+Block Type) */
    int i_mv_bits;
    /* Texture bits (DCT coefs) */
    int i_tex_bits;
    /* ? */
    int i_misc_bits;
    /* MB type counts */
    int i_mb_count[19];
    int i_mb_count_i;
    int i_mb_count_p;
    int i_mb_count_skip;
    int i_mb_count_8x8dct[2];
    int i_mb_count_ref[2][X264_REF_MAX*2];
    int i_mb_partition[17];
    int i_mb_cbp[6];
    int i_mb_pred_mode[4][13];
    int i_mb_field[3];
    /* Adaptive direct mv pred */
    int i_direct_score[2];
    /* Metrics */
    int64_t i_ssd[3];
    double f_ssim;
    int i_ssim_cnt;
} x264_frame_stat_t;

struct x264_t
{
    /* encoder parameters */
    x264_param_t    param;

    x264_t          *thread[X264_THREAD_MAX+1];
    x264_t          *lookahead_thread[X264_LOOKAHEAD_THREAD_MAX];
    int             b_thread_active;
    int             i_thread_phase; /* which thread to use for the next frame */
    int             i_thread_idx;   /* which thread this is */
    int             i_threadslice_start; /* first row in this thread slice */
    int             i_threadslice_end; /* row after the end of this thread slice */
    int             i_threadslice_pass; /* which pass of encoding we are on */
    x264_threadpool_t *threadpool;
    x264_threadpool_t *lookaheadpool;
    x264_pthread_mutex_t mutex;
    x264_pthread_cond_t cv;

    /* bitstream output */
    struct
    {
        int         i_nal;
        int         i_nals_allocated;
        x264_nal_t  *nal;
        int         i_bitstream;    /* size of p_bitstream */
        uint8_t     *p_bitstream;   /* will hold data for all nal */
        bs_t        bs;
    } out;

    uint8_t *nal_buffer;
    int      nal_buffer_size;

    x264_t          *reconfig_h;
    int             reconfig;

    /**** thread synchronization starts here ****/

    /* frame number/poc */
    int             i_frame;
    int             i_frame_num;

    int             i_thread_frames; /* Number of different frames being encoded by threads;
                                      * 1 when sliced-threads is on. */
    int             i_nal_type;
    int             i_nal_ref_idc;

    int64_t         i_disp_fields;  /* Number of displayed fields (both coded and implied via pic_struct) */
    int             i_disp_fields_last_frame;
    int64_t         i_prev_duration; /* Duration of previous frame */
    int64_t         i_coded_fields; /* Number of coded fields (both coded and implied via pic_struct) */
    int64_t         i_cpb_delay;    /* Equal to number of fields preceding this field
                                     * since last buffering_period SEI */
    int64_t         i_coded_fields_lookahead; /* Use separate counters for lookahead */
    int64_t         i_cpb_delay_lookahead;

    int64_t         i_cpb_delay_pir_offset;
    int64_t         i_cpb_delay_pir_offset_next;

    int             b_queued_intra_refresh;
    int64_t         i_last_idr_pts;

    int             i_idr_pic_id;

    /* quantization matrix for decoding, [cqm][qp%6][coef] */
    int             (*dequant4_mf[4])[16];   /* [4][6][16] */
    int             (*dequant8_mf[4])[64];   /* [4][6][64] */
    /* quantization matrix for trellis, [cqm][qp][coef] */
    int             (*unquant4_mf[4])[16];   /* [4][QP_MAX_SPEC+1][16] */
    int             (*unquant8_mf[4])[64];   /* [4][QP_MAX_SPEC+1][64] */
    /* quantization matrix for deadzone */
    udctcoef        (*quant4_mf[4])[16];     /* [4][QP_MAX_SPEC+1][16] */
    udctcoef        (*quant8_mf[4])[64];     /* [4][QP_MAX_SPEC+1][64] */
    udctcoef        (*quant4_bias[4])[16];   /* [4][QP_MAX_SPEC+1][16] */
    udctcoef        (*quant8_bias[4])[64];   /* [4][QP_MAX_SPEC+1][64] */
    udctcoef        (*quant4_bias0[4])[16];  /* [4][QP_MAX_SPEC+1][16] */
    udctcoef        (*quant8_bias0[4])[64];  /* [4][QP_MAX_SPEC+1][64] */
    udctcoef        (*nr_offset_emergency)[4][64];

    /* mv/ref cost arrays. */
    uint16_t *cost_mv[QP_MAX+1];
    uint16_t *cost_mv_fpel[QP_MAX+1][4];

    const uint8_t   *chroma_qp_table; /* includes both the nonlinear luma->chroma mapping and chroma_qp_offset */

    /* Slice header */
    x264_slice_header_t sh;

    /* SPS / PPS */
    x264_sps_t      sps[1];
    x264_pps_t      pps[1];

    /* Slice header backup, for SEI_DEC_REF_PIC_MARKING */
    int b_sh_backup;
    x264_slice_header_t sh_backup;

    /* cabac context */
    x264_cabac_t    cabac;

    struct
    {
        /* Frames to be encoded (whose types have been decided) */
        x264_frame_t **current;
        /* Unused frames: 0 = fenc, 1 = fdec */
        x264_frame_t **unused[2];

        /* Unused blank frames (for duplicates) */
        x264_frame_t **blank_unused;

        /* frames used for reference + sentinels */
        x264_frame_t *reference[X264_REF_MAX+2];

        int i_last_keyframe;       /* Frame number of the last keyframe */
        int i_last_idr;            /* Frame number of the last IDR (not RP)*/
        int i_poc_last_open_gop;   /* Poc of the I frame of the last open-gop. The value
                                    * is only assigned during the period between that
                                    * I frame and the next P or I frame, else -1 */

        int i_input;    /* Number of input frames already accepted */

        int i_max_dpb;  /* Number of frames allocated in the decoded picture buffer */
        int i_max_ref0;
        int i_max_ref1;
        int i_delay;    /* Number of frames buffered for B reordering */
        int     i_bframe_delay;
        int64_t i_bframe_delay_time;
        int64_t i_first_pts;
        int64_t i_prev_reordered_pts[2];
        int64_t i_largest_pts;
        int64_t i_second_largest_pts;
        int b_have_lowres;  /* Whether 1/2 resolution luma planes are being used */
        int b_have_sub8x8_esa;
    } frames;

    /* current frame being encoded */
    x264_frame_t    *fenc;

    /* frame being reconstructed */
    x264_frame_t    *fdec;

    /* references lists */
    int             i_ref[2];
    x264_frame_t    *fref[2][X264_REF_MAX+3];
    x264_frame_t    *fref_nearest[2];
    int             b_ref_reorder[2];

    /* hrd */
    int initial_cpb_removal_delay;
    int initial_cpb_removal_delay_offset;
    int64_t i_reordered_pts_delay;

    /* Current MB DCT coeffs */
    struct
    {
        ALIGNED_N( dctcoef luma16x16_dc[3][16] );
        ALIGNED_16( dctcoef chroma_dc[2][8] );
        // FIXME share memory?
        ALIGNED_N( dctcoef luma8x8[12][64] );
        ALIGNED_N( dctcoef luma4x4[16*3][16] );
    } dct;

    /* MB table and cache for current frame/mb */
    struct
    {
        int     i_mb_width;
        int     i_mb_height;
        int     i_mb_count;                 /* number of mbs in a frame */

        /* Chroma subsampling */
        int     chroma_h_shift;
        int     chroma_v_shift;

        /* Strides */
        int     i_mb_stride;
        int     i_b8_stride;
        int     i_b4_stride;
        int     left_b8[2];
        int     left_b4[2];

        /* Current index */
        int     i_mb_x;
        int     i_mb_y;
        int     i_mb_xy;
        int     i_b8_xy;
        int     i_b4_xy;

        /* Search parameters */
        int     i_me_method;
        int     i_subpel_refine;
        int     b_chroma_me;
        int     b_trellis;
        int     b_noise_reduction;
        int     b_dct_decimate;
        int     i_psy_rd; /* Psy RD strength--fixed point value*/
        int     i_psy_trellis; /* Psy trellis strength--fixed point value*/

        int     b_interlaced;
        int     b_adaptive_mbaff; /* MBAFF+subme 0 requires non-adaptive MBAFF i.e. all field mbs */

        /* Allowed qpel MV range to stay within the picture + emulated edge pixels */
        int     mv_min[2];
        int     mv_max[2];
        int     mv_miny_row[3]; /* 0 == top progressive, 1 == bot progressive, 2 == interlaced */
        int     mv_maxy_row[3];
        /* Subpel MV range for motion search.
         * same mv_min/max but includes levels' i_mv_range. */
        int     mv_min_spel[2];
        int     mv_max_spel[2];
        int     mv_miny_spel_row[3];
        int     mv_maxy_spel_row[3];
        /* Fullpel MV range for motion search */
        ALIGNED_8( int16_t mv_limit_fpel[2][2] ); /* min_x, min_y, max_x, max_y */
        int     mv_miny_fpel_row[3];
        int     mv_maxy_fpel_row[3];

        /* neighboring MBs */
        unsigned int i_neighbour;
        unsigned int i_neighbour8[4];       /* neighbours of each 8x8 or 4x4 block that are available */
        unsigned int i_neighbour4[16];      /* at the time the block is coded */
        unsigned int i_neighbour_intra;     /* for constrained intra pred */
        unsigned int i_neighbour_frame;     /* ignoring slice boundaries */
        int     i_mb_type_top;
        int     i_mb_type_left[2];
        int     i_mb_type_topleft;
        int     i_mb_type_topright;
        int     i_mb_prev_xy;
        int     i_mb_left_xy[2];
        int     i_mb_top_xy;
        int     i_mb_topleft_xy;
        int     i_mb_topright_xy;
        int     i_mb_top_y;
        int     i_mb_topleft_y;
        int     i_mb_topright_y;
        const x264_left_table_t *left_index_table;
        int     i_mb_top_mbpair_xy;
        int     topleft_partition;
        int     b_allow_skip;
        int     field_decoding_flag;

        /**** thread synchronization ends here ****/
        /* subsequent variables are either thread-local or constant,
         * and won't be copied from one thread to another */

        /* mb table */
        uint8_t *base;                      /* base pointer for all malloced data in this mb */
        int8_t  *type;                      /* mb type */
        uint8_t *partition;                 /* mb partition */
        int8_t  *qp;                        /* mb qp */
        int16_t *cbp;                       /* mb cbp: 0x0?: luma, 0x?0: chroma, 0x100: luma dc, 0x0200 and 0x0400: chroma dc  (all set for PCM)*/
        int8_t  (*intra4x4_pred_mode)[8];   /* intra4x4 pred mode. for non I4x4 set to I_PRED_4x4_DC(2) */
                                            /* actually has only 7 entries; set to 8 for write-combining optimizations */
        uint8_t (*non_zero_count)[16*3];    /* nzc. for I_PCM set to 16 */
        int8_t  *chroma_pred_mode;          /* chroma_pred_mode. cabac only. for non intra I_PRED_CHROMA_DC(0) */
        int16_t (*mv[2])[2];                /* mb mv. set to 0 for intra mb */
        uint8_t (*mvd[2])[8][2];            /* absolute value of mb mv difference with predict, clipped to [0,33]. set to 0 if intra. cabac only */
        int8_t   *ref[2];                   /* mb ref. set to -1 if non used (intra or Lx only) */
        int16_t (*mvr[2][X264_REF_MAX*2])[2];/* 16x16 mv for each possible ref */
        int8_t  *skipbp;                    /* block pattern for SKIP or DIRECT (sub)mbs. B-frames + cabac only */
        int8_t  *mb_transform_size;         /* transform_size_8x8_flag of each mb */
        uint16_t *slice_table;              /* sh->first_mb of the slice that the indexed mb is part of
                                             * NOTE: this will fail on resolutions above 2^16 MBs... */
        uint8_t *field;

         /* buffer for weighted versions of the reference frames */
        pixel *p_weight_buf[X264_REF_MAX];

        /* current value */
        int     i_type;
        int     i_partition;
        ALIGNED_4( uint8_t i_sub_partition[4] );
        int     b_transform_8x8;

        int     i_cbp_luma;
        int     i_cbp_chroma;

        int     i_intra16x16_pred_mode;
        int     i_chroma_pred_mode;

        /* skip flags for i4x4 and i8x8
         * 0 = encode as normal.
         * 1 (non-RD only) = the DCT is still in h->dct, restore fdec and skip reconstruction.
         * 2 (RD only) = the DCT has since been overwritten by RD; restore that too. */
        int i_skip_intra;
        /* skip flag for motion compensation */
        /* if we've already done MC, we don't need to do it again */
        int b_skip_mc;
        /* set to true if we are re-encoding a macroblock. */
        int b_reencode_mb;
        int ip_offset; /* Used by PIR to offset the quantizer of intra-refresh blocks. */
        int b_deblock_rdo;
        int b_overflow; /* If CAVLC had a level code overflow during bitstream writing. */

        struct
        {
            /* space for p_fenc and p_fdec */
#define FENC_STRIDE 16
#define FDEC_STRIDE 32
            ALIGNED_16( pixel fenc_buf[48*FENC_STRIDE] );
            ALIGNED_N( pixel fdec_buf[52*FDEC_STRIDE] );

            /* i4x4 and i8x8 backup data, for skipping the encode stage when possible */
            ALIGNED_16( pixel i4x4_fdec_buf[16*16] );
            ALIGNED_16( pixel i8x8_fdec_buf[16*16] );
            ALIGNED_16( dctcoef i8x8_dct_buf[3][64] );
            ALIGNED_16( dctcoef i4x4_dct_buf[15][16] );
            uint32_t i4x4_nnz_buf[4];
            uint32_t i8x8_nnz_buf[4];
            int i4x4_cbp;
            int i8x8_cbp;

            /* Psy trellis DCT data */
            ALIGNED_16( dctcoef fenc_dct8[4][64] );
            ALIGNED_16( dctcoef fenc_dct4[16][16] );

            /* Psy RD SATD/SA8D scores cache */
            ALIGNED_N( uint64_t fenc_hadamard_cache[9] );
            ALIGNED_N( uint32_t fenc_satd_cache[32] );

            /* pointer over mb of the frame to be compressed */
            pixel *p_fenc[3]; /* y,u,v */
            /* pointer to the actual source frame, not a block copy */
            pixel *p_fenc_plane[3];

            /* pointer over mb of the frame to be reconstructed  */
            pixel *p_fdec[3];

            /* pointer over mb of the references */
            int i_fref[2];
            /* [12]: yN, yH, yV, yHV, (NV12 ? uv : I444 ? (uN, uH, uV, uHV, vN, ...)) */
            pixel *p_fref[2][X264_REF_MAX*2][12];
            pixel *p_fref_w[X264_REF_MAX*2];  /* weighted fullpel luma */
            uint16_t *p_integral[2][X264_REF_MAX];

            /* fref stride */
            int     i_stride[3];
        } pic;

        /* cache */
        struct
        {
            /* real intra4x4_pred_mode if I_4X4 or I_8X8, I_PRED_4x4_DC if mb available, -1 if not */
            ALIGNED_8( int8_t intra4x4_pred_mode[X264_SCAN8_LUMA_SIZE] );

            /* i_non_zero_count if available else 0x80 */
            ALIGNED_16( uint8_t non_zero_count[X264_SCAN8_SIZE] );

            /* -1 if unused, -2 if unavailable */
            ALIGNED_4( int8_t ref[2][X264_SCAN8_LUMA_SIZE] );

            /* 0 if not available */
            ALIGNED_16( int16_t mv[2][X264_SCAN8_LUMA_SIZE][2] );
            ALIGNED_8( uint8_t mvd[2][X264_SCAN8_LUMA_SIZE][2] );

            /* 1 if SKIP or DIRECT. set only for B-frames + CABAC */
            ALIGNED_4( int8_t skip[X264_SCAN8_LUMA_SIZE] );

            ALIGNED_4( int16_t direct_mv[2][4][2] );
            ALIGNED_4( int8_t  direct_ref[2][4] );
            int     direct_partition;
            ALIGNED_4( int16_t pskip_mv[2] );

            /* number of neighbors (top and left) that used 8x8 dct */
            int     i_neighbour_transform_size;
            int     i_neighbour_skip;

            /* neighbor CBPs */
            int     i_cbp_top;
            int     i_cbp_left;

            /* extra data required for mbaff in mv prediction */
            int16_t topright_mv[2][3][2];
            int8_t  topright_ref[2][3];

            /* current mb deblock strength */
            uint8_t (*deblock_strength)[8][4];
        } cache;

        /* */
        int     i_qp;       /* current qp */
        int     i_chroma_qp;
        int     i_last_qp;  /* last qp */
        int     i_last_dqp; /* last delta qp */
        int     b_variable_qp; /* whether qp is allowed to vary per macroblock */
        int     b_lossless;
        int     b_direct_auto_read; /* take stats for --direct auto from the 2pass log */
        int     b_direct_auto_write; /* analyse direct modes, to use and/or save */

        /* lambda values */
        int     i_trellis_lambda2[2][2]; /* [luma,chroma][inter,intra] */
        int     i_psy_rd_lambda;
        int     i_chroma_lambda2_offset;

        /* B_direct and weighted prediction */
        int16_t dist_scale_factor_buf[2][2][X264_REF_MAX*2][4];
        int16_t (*dist_scale_factor)[4];
        int8_t bipred_weight_buf[2][2][X264_REF_MAX*2][4];
        int8_t (*bipred_weight)[4];
        /* maps fref1[0]'s ref indices into the current list0 */
#define map_col_to_list0(col) h->mb.map_col_to_list0[(col)+2]
        int8_t  map_col_to_list0[X264_REF_MAX+2];
        int ref_blind_dupe; /* The index of the blind reference frame duplicate. */
        int8_t deblock_ref_table[X264_REF_MAX*2+2];
#define deblock_ref_table(x) h->mb.deblock_ref_table[(x)+2]
    } mb;

    /* rate control encoding only */
    x264_ratecontrol_t *rc;

    /* stats */
    struct
    {
        /* Current frame stats */
        x264_frame_stat_t frame;

        /* Cumulated stats */

        /* per slice info */
        int     i_frame_count[3];
        int64_t i_frame_size[3];
        double  f_frame_qp[3];
        int     i_consecutive_bframes[X264_BFRAME_MAX+1];
        /* */
        double  f_ssd_global[3];
        double  f_psnr_average[3];
        double  f_psnr_mean_y[3];
        double  f_psnr_mean_u[3];
        double  f_psnr_mean_v[3];
        double  f_ssim_mean_y[3];
        double  f_frame_duration[3];
        /* */
        int64_t i_mb_count[3][19];
        int64_t i_mb_partition[2][17];
        int64_t i_mb_count_8x8dct[2];
        int64_t i_mb_count_ref[2][2][X264_REF_MAX*2];
        int64_t i_mb_cbp[6];
        int64_t i_mb_pred_mode[4][13];
        int64_t i_mb_field[3];
        /* */
        int     i_direct_score[2];
        int     i_direct_frames[2];
        /* num p-frames weighted */
        int     i_wpred[2];

    } stat;

    /* 0 = luma 4x4, 1 = luma 8x8, 2 = chroma 4x4, 3 = chroma 8x8 */
    udctcoef (*nr_offset)[64];
    uint32_t (*nr_residual_sum)[64];
    uint32_t *nr_count;

    ALIGNED_N( udctcoef nr_offset_denoise[4][64] );
    ALIGNED_N( uint32_t nr_residual_sum_buf[2][4][64] );
    uint32_t nr_count_buf[2][4];

    uint8_t luma2chroma_pixel[7]; /* Subsampled pixel size */

    /* Buffers that are allocated per-thread even in sliced threads. */
    void *scratch_buffer; /* for any temporary storage that doesn't want repeated malloc */
    void *scratch_buffer2; /* if the first one's already in use */
    pixel *intra_border_backup[5][3]; /* bottom pixels of the previous mb row, used for intra prediction after the framebuffer has been deblocked */
    /* Deblock strength values are stored for each 4x4 partition. In MBAFF
     * there are four extra values that need to be stored, located in [4][i]. */
    uint8_t (*deblock_strength[2])[2][8][4];

    /* CPU functions dependents */
    x264_predict_t      predict_16x16[4+3];
    x264_predict8x8_t   predict_8x8[9+3];
    x264_predict_t      predict_4x4[9+3];
    x264_predict_t      predict_chroma[4+3];
    x264_predict_t      predict_8x8c[4+3];
    x264_predict_t      predict_8x16c[4+3];
    x264_predict_8x8_filter_t predict_8x8_filter;

    x264_pixel_function_t pixf;
    x264_mc_functions_t   mc;
    x264_dct_function_t   dctf;
    x264_zigzag_function_t zigzagf;
    x264_zigzag_function_t zigzagf_interlaced;
    x264_zigzag_function_t zigzagf_progressive;
    x264_quant_function_t quantf;
    x264_deblock_function_t loopf;
    x264_bitstream_function_t bsf;

    x264_lookahead_t *lookahead;

#if HAVE_OPENCL
    x264_opencl_t opencl;
#endif
};



