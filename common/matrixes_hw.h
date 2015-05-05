/* This file is added by Amit Kumar Chawla 
 * to keep all the matrix which are initialized
 * at S/W side and are required to be transferred
 * H/W side in x264_sw_sync_open.
 * */

uint8_t x264_cabac_contexts_hw[4][QP_MAX_SPEC+1][1024]; // Common/cabac.c
uint16_t x264_cost_i4x4_mode_hw[(QP_MAX+2)*32];  // encoder/analyse.c
uint16_t x264_cost_ref_hw[QP_MAX+1][3][33];// encoder/analyse.c
uint8_t x264_cabac_transition_unary_hw[15][128];// encoder/rdo.c
uint16_t x264_cabac_size_unary_hw[15][128];// encoder/rdo.c
uint8_t cabac_transition_5ones_hw[128];// encoder/rdo.c
uint16_t cabac_size_5ones_hw[128];// encoder/rdo.c