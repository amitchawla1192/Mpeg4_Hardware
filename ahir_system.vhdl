-- VHDL produced by vc2vhdl from virtual circuit (vc) description 
library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.memory_subsystem_package.all;
use ahir.types.all;
use ahir.subprograms.all;
use ahir.components.all;
use ahir.basecomponents.all;
use ahir.operatorpackage.all;
use ahir.utilities.all;
use ahir.functionLibraryComponents.all;
library work;
use work.ahir_system_global_package.all;
entity dct_engine is -- 
  generic (tag_length : integer); 
  port ( -- 
    clk : in std_logic;
    reset : in std_logic;
    start_req : in std_logic;
    start_ack : out std_logic;
    fin_req : in std_logic;
    fin_ack   : out std_logic;
    dct_in_data_pipe_read_req : out  std_logic_vector(0 downto 0);
    dct_in_data_pipe_read_ack : in   std_logic_vector(0 downto 0);
    dct_in_data_pipe_read_data : in   std_logic_vector(31 downto 0);
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
  );
  -- 
end entity dct_engine;
architecture Default of dct_engine is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal in_buffer_data_in, in_buffer_data_out: std_logic_vector((tag_length + 0)-1 downto 0);
  signal in_buffer_write_req: std_logic;
  signal in_buffer_write_ack: std_logic;
  signal in_buffer_unload_req_symbol: Boolean;
  signal in_buffer_unload_ack_symbol: Boolean;
  signal out_buffer_data_in, out_buffer_data_out: std_logic_vector((tag_length + 0)-1 downto 0);
  signal out_buffer_read_req: std_logic;
  signal out_buffer_read_ack: std_logic;
  signal out_buffer_write_req_symbol: Boolean;
  signal out_buffer_write_ack_symbol: Boolean;
  signal default_zero_sig: std_logic;
  signal tag_ub_out, tag_ilock_out: std_logic_vector(tag_length-1 downto 0);
  signal tag_push_req, tag_push_ack, tag_pop_req, tag_pop_ack: std_logic;
  signal tag_unload_req_symbol, tag_unload_ack_symbol, tag_write_req_symbol, tag_write_ack_symbol: Boolean;
  signal tag_ilock_write_req_symbol, tag_ilock_write_ack_symbol, tag_ilock_read_req_symbol, tag_ilock_read_ack_symbol: Boolean;
  signal start_req_sig, fin_req_sig, start_ack_sig, fin_ack_sig: std_logic; 
  signal input_sample_reenable_symbol: Boolean;
  -- input port buffer signals
  -- output port buffer signals
  signal dct_engine_CP_0_start: Boolean;
  signal dct_engine_CP_0_symbol: Boolean;
  -- links between control-path and data-path
  signal RPIPE_dct_in_data_25_inst_ack_1 : boolean;
  signal RPIPE_dct_in_data_28_inst_req_0 : boolean;
  signal RPIPE_dct_in_data_28_inst_ack_0 : boolean;
  signal RPIPE_dct_in_data_28_inst_req_1 : boolean;
  signal RPIPE_dct_in_data_28_inst_ack_1 : boolean;
  signal RPIPE_dct_in_data_25_inst_req_0 : boolean;
  signal RPIPE_dct_in_data_25_inst_ack_0 : boolean;
  signal RPIPE_dct_in_data_25_inst_req_1 : boolean;
  signal MUL_u32_u32_69_inst_req_0 : boolean;
  signal EQ_u32_u1_34_inst_req_0 : boolean;
  signal EQ_u32_u1_34_inst_ack_0 : boolean;
  signal EQ_u32_u1_34_inst_req_1 : boolean;
  signal EQ_u32_u1_34_inst_ack_1 : boolean;
  signal EQ_u32_u1_41_inst_req_0 : boolean;
  signal EQ_u32_u1_41_inst_ack_0 : boolean;
  signal EQ_u32_u1_41_inst_req_1 : boolean;
  signal EQ_u32_u1_41_inst_ack_1 : boolean;
  signal AND_u1_u1_46_inst_req_0 : boolean;
  signal AND_u1_u1_46_inst_ack_0 : boolean;
  signal AND_u1_u1_46_inst_req_1 : boolean;
  signal AND_u1_u1_46_inst_ack_1 : boolean;
  signal if_stmt_48_branch_req_0 : boolean;
  signal if_stmt_48_branch_ack_1 : boolean;
  signal if_stmt_48_branch_ack_0 : boolean;
  signal MUL_u32_u32_69_inst_ack_0 : boolean;
  signal MUL_u32_u32_69_inst_req_1 : boolean;
  signal MUL_u32_u32_69_inst_ack_1 : boolean;
  signal array_obj_ref_75_index_1_resize_req_0 : boolean;
  signal array_obj_ref_75_index_1_resize_ack_0 : boolean;
  signal array_obj_ref_75_index_1_rename_req_0 : boolean;
  signal array_obj_ref_75_index_1_rename_ack_0 : boolean;
  signal array_obj_ref_75_index_offset_req_0 : boolean;
  signal array_obj_ref_75_index_offset_ack_0 : boolean;
  signal array_obj_ref_75_index_offset_req_1 : boolean;
  signal array_obj_ref_75_index_offset_ack_1 : boolean;
  signal array_obj_ref_75_root_address_inst_req_0 : boolean;
  signal array_obj_ref_75_root_address_inst_ack_0 : boolean;
  signal array_obj_ref_75_final_reg_req_0 : boolean;
  signal array_obj_ref_75_final_reg_ack_0 : boolean;
  signal array_obj_ref_75_final_reg_req_1 : boolean;
  signal array_obj_ref_75_final_reg_ack_1 : boolean;
  signal type_cast_80_inst_req_0 : boolean;
  signal type_cast_80_inst_ack_0 : boolean;
  signal type_cast_80_inst_req_1 : boolean;
  signal type_cast_80_inst_ack_1 : boolean;
  signal RPIPE_dct_in_data_83_inst_req_0 : boolean;
  signal RPIPE_dct_in_data_83_inst_ack_0 : boolean;
  signal RPIPE_dct_in_data_83_inst_req_1 : boolean;
  signal RPIPE_dct_in_data_83_inst_ack_1 : boolean;
  signal ptr_deref_86_base_resize_req_0 : boolean;
  signal ptr_deref_86_base_resize_ack_0 : boolean;
  signal ptr_deref_86_root_address_inst_req_0 : boolean;
  signal ptr_deref_86_root_address_inst_ack_0 : boolean;
  signal ptr_deref_86_addr_0_req_0 : boolean;
  signal ptr_deref_86_addr_0_ack_0 : boolean;
  signal ptr_deref_86_addr_0_req_1 : boolean;
  signal ptr_deref_86_addr_0_ack_1 : boolean;
  signal ptr_deref_86_addr_1_req_0 : boolean;
  signal ptr_deref_86_addr_1_ack_0 : boolean;
  signal ptr_deref_86_addr_1_req_1 : boolean;
  signal ptr_deref_86_addr_1_ack_1 : boolean;
  signal ptr_deref_86_gather_scatter_req_0 : boolean;
  signal ptr_deref_86_gather_scatter_ack_0 : boolean;
  signal ptr_deref_86_store_0_req_0 : boolean;
  signal ptr_deref_86_store_0_ack_0 : boolean;
  signal ptr_deref_86_store_1_req_0 : boolean;
  signal ptr_deref_86_store_1_ack_0 : boolean;
  signal ptr_deref_86_store_0_req_1 : boolean;
  signal ptr_deref_86_store_0_ack_1 : boolean;
  signal ptr_deref_86_store_1_req_1 : boolean;
  signal ptr_deref_86_store_1_ack_1 : boolean;
  signal phi_stmt_110_req_1 : boolean;
  signal phi_stmt_110_ack_0 : boolean;
  signal ADD_u32_u32_93_inst_req_0 : boolean;
  signal ADD_u32_u32_93_inst_ack_0 : boolean;
  signal ADD_u32_u32_93_inst_req_1 : boolean;
  signal ADD_u32_u32_93_inst_ack_1 : boolean;
  signal EQ_u32_u1_99_inst_req_0 : boolean;
  signal EQ_u32_u1_99_inst_ack_0 : boolean;
  signal EQ_u32_u1_99_inst_req_1 : boolean;
  signal EQ_u32_u1_99_inst_ack_1 : boolean;
  signal if_stmt_101_branch_req_0 : boolean;
  signal if_stmt_101_branch_ack_1 : boolean;
  signal if_stmt_101_branch_ack_0 : boolean;
  signal array_obj_ref_124_index_2_resize_req_0 : boolean;
  signal array_obj_ref_124_index_2_resize_ack_0 : boolean;
  signal array_obj_ref_124_index_2_rename_req_0 : boolean;
  signal array_obj_ref_124_index_2_rename_ack_0 : boolean;
  signal array_obj_ref_124_index_offset_req_0 : boolean;
  signal array_obj_ref_124_index_offset_ack_0 : boolean;
  signal array_obj_ref_124_index_offset_req_1 : boolean;
  signal array_obj_ref_124_index_offset_ack_1 : boolean;
  signal array_obj_ref_124_root_address_inst_req_0 : boolean;
  signal array_obj_ref_124_root_address_inst_ack_0 : boolean;
  signal array_obj_ref_124_final_reg_req_0 : boolean;
  signal array_obj_ref_124_final_reg_ack_0 : boolean;
  signal array_obj_ref_124_final_reg_req_1 : boolean;
  signal array_obj_ref_124_final_reg_ack_1 : boolean;
  signal type_cast_128_inst_req_0 : boolean;
  signal type_cast_128_inst_ack_0 : boolean;
  signal type_cast_128_inst_req_1 : boolean;
  signal type_cast_128_inst_ack_1 : boolean;
  signal RPIPE_dct_in_data_131_inst_req_0 : boolean;
  signal RPIPE_dct_in_data_131_inst_ack_0 : boolean;
  signal RPIPE_dct_in_data_131_inst_req_1 : boolean;
  signal RPIPE_dct_in_data_131_inst_ack_1 : boolean;
  signal ptr_deref_134_base_resize_req_0 : boolean;
  signal ptr_deref_134_base_resize_ack_0 : boolean;
  signal ptr_deref_134_root_address_inst_req_0 : boolean;
  signal ptr_deref_134_root_address_inst_ack_0 : boolean;
  signal ptr_deref_134_addr_0_req_0 : boolean;
  signal ptr_deref_134_addr_0_ack_0 : boolean;
  signal ptr_deref_134_addr_0_req_1 : boolean;
  signal ptr_deref_134_addr_0_ack_1 : boolean;
  signal ptr_deref_134_addr_1_req_0 : boolean;
  signal ptr_deref_134_addr_1_ack_0 : boolean;
  signal ptr_deref_134_addr_1_req_1 : boolean;
  signal ptr_deref_134_addr_1_ack_1 : boolean;
  signal ptr_deref_134_addr_2_req_0 : boolean;
  signal ptr_deref_134_addr_2_ack_0 : boolean;
  signal ptr_deref_134_addr_2_req_1 : boolean;
  signal ptr_deref_134_addr_2_ack_1 : boolean;
  signal ptr_deref_134_addr_3_req_0 : boolean;
  signal ptr_deref_134_addr_3_ack_0 : boolean;
  signal ptr_deref_134_addr_3_req_1 : boolean;
  signal ptr_deref_134_addr_3_ack_1 : boolean;
  signal ptr_deref_134_gather_scatter_req_0 : boolean;
  signal ptr_deref_134_gather_scatter_ack_0 : boolean;
  signal ptr_deref_134_store_0_req_0 : boolean;
  signal ptr_deref_134_store_0_ack_0 : boolean;
  signal ptr_deref_134_store_1_req_0 : boolean;
  signal ptr_deref_134_store_1_ack_0 : boolean;
  signal ptr_deref_134_store_2_req_0 : boolean;
  signal ptr_deref_134_store_2_ack_0 : boolean;
  signal ptr_deref_134_store_3_req_0 : boolean;
  signal ptr_deref_134_store_3_ack_0 : boolean;
  signal ptr_deref_134_store_0_req_1 : boolean;
  signal ptr_deref_134_store_0_ack_1 : boolean;
  signal ptr_deref_134_store_1_req_1 : boolean;
  signal ptr_deref_134_store_1_ack_1 : boolean;
  signal ptr_deref_134_store_2_req_1 : boolean;
  signal ptr_deref_134_store_2_ack_1 : boolean;
  signal ptr_deref_134_store_3_req_1 : boolean;
  signal ptr_deref_134_store_3_ack_1 : boolean;
  signal ADD_u32_u32_141_inst_req_0 : boolean;
  signal ADD_u32_u32_141_inst_ack_0 : boolean;
  signal ADD_u32_u32_141_inst_req_1 : boolean;
  signal ADD_u32_u32_141_inst_ack_1 : boolean;
  signal type_cast_60_inst_req_0 : boolean;
  signal type_cast_60_inst_ack_0 : boolean;
  signal type_cast_60_inst_req_1 : boolean;
  signal type_cast_60_inst_ack_1 : boolean;
  signal phi_stmt_57_req_0 : boolean;
  signal phi_stmt_57_req_1 : boolean;
  signal phi_stmt_57_ack_0 : boolean;
  signal type_cast_113_inst_req_0 : boolean;
  signal type_cast_113_inst_ack_0 : boolean;
  signal type_cast_113_inst_req_1 : boolean;
  signal type_cast_113_inst_ack_1 : boolean;
  signal phi_stmt_110_req_0 : boolean;
  signal memory_space_0_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_0_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_0_sr_addr : std_logic_vector(4 downto 0);
  signal memory_space_0_sr_data : std_logic_vector(15 downto 0);
  signal memory_space_0_sr_tag : std_logic_vector(1 downto 0);
  signal memory_space_0_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_0_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_0_sc_tag :  std_logic_vector(1 downto 0);
  signal memory_space_1_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_1_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_1_sr_addr : std_logic_vector(8 downto 0);
  signal memory_space_1_sr_data : std_logic_vector(7 downto 0);
  signal memory_space_1_sr_tag : std_logic_vector(2 downto 0);
  signal memory_space_1_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_1_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_1_sc_tag :  std_logic_vector(2 downto 0);
  -- 
begin --  
  -- input handling ------------------------------------------------
  in_buffer: UnloadBuffer -- 
    generic map(name => "dct_engine_input_buffer", -- 
      buffer_size => 1,
      data_width => tag_length + 0) -- 
    port map(write_req => in_buffer_write_req, -- 
      write_ack => in_buffer_write_ack, 
      write_data => in_buffer_data_in,
      unload_req => in_buffer_unload_req_symbol, 
      unload_ack => in_buffer_unload_ack_symbol, 
      read_data => in_buffer_data_out,
      clk => clk, reset => reset); -- 
  in_buffer_data_in(tag_length-1 downto 0) <= tag_in;
  tag_ub_out <= in_buffer_data_out(tag_length-1 downto 0);
  in_buffer_write_req <= start_req;
  start_ack <= in_buffer_write_ack;
  in_buffer_unload_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 1,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 32) := "in_buffer_unload_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= in_buffer_unload_ack_symbol & input_sample_reenable_symbol;
    gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => in_buffer_unload_req_symbol, clk => clk, reset => reset); --
  end block;
  -- join of all unload_ack_symbols.. used to trigger CP.
  dct_engine_CP_0_start <= in_buffer_unload_ack_symbol;
  -- output handling  -------------------------------------------------------
  out_buffer: ReceiveBuffer -- 
    generic map(name => "dct_engine_out_buffer", -- 
      buffer_size => 1,
      data_width => tag_length + 0, 
      kill_counter_range => 1) -- 
    port map(write_req => out_buffer_write_req_symbol, -- 
      write_ack => out_buffer_write_ack_symbol, 
      write_data => out_buffer_data_in,
      read_req => out_buffer_read_req, 
      read_ack => out_buffer_read_ack, 
      read_data => out_buffer_data_out,
      kill => default_zero_sig,
      clk => clk, reset => reset); -- 
  out_buffer_data_in(tag_length-1 downto 0) <= tag_ilock_out;
  tag_out <= out_buffer_data_out(tag_length-1 downto 0);
  out_buffer_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 0);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 1,2 => 0);
    constant joinName: string(1 to 32) := "out_buffer_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= dct_engine_CP_0_symbol & out_buffer_write_ack_symbol & tag_ilock_read_ack_symbol;
    gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => out_buffer_write_req_symbol, clk => clk, reset => reset); --
  end block;
  -- write-to output-buffer produces  reenable input sampling
  input_sample_reenable_symbol <= out_buffer_write_ack_symbol;
  -- fin-req/ack level protocol..
  out_buffer_read_req <= fin_req;
  fin_ack <= out_buffer_read_ack;
  ----- tag-queue --------------------------------------------------
  -- interlock buffer for TAG.. to provide required buffering.
  tagIlock: InterlockBuffer -- 
    generic map(name => "tag-interlock-buffer", -- 
      buffer_size => 1,
      in_data_width => tag_length,
      out_data_width => tag_length) -- 
    port map(write_req => tag_ilock_write_req_symbol, -- 
      write_ack => tag_ilock_write_ack_symbol, 
      write_data => tag_ub_out,
      read_req => tag_ilock_read_req_symbol, 
      read_ack => tag_ilock_read_ack_symbol, 
      read_data => tag_ilock_out, 
      clk => clk, reset => reset); -- 
  -- tag ilock-buffer control logic. 
  tag_ilock_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 31) := "tag_ilock_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= dct_engine_CP_0_start & tag_ilock_write_ack_symbol;
    gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_write_req_symbol, clk => clk, reset => reset); --
  end block;
  tag_ilock_read_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 1);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
    constant joinName: string(1 to 30) := "tag_ilock_read_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= dct_engine_CP_0_start & tag_ilock_read_ack_symbol & out_buffer_write_ack_symbol;
    gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_read_req_symbol, clk => clk, reset => reset); --
  end block;
  -- the control path --------------------------------------------------
  always_true_symbol <= true; 
  default_zero_sig <= '0';
  dct_engine_CP_0: Block -- control-path 
    signal dct_engine_CP_0_elements: BooleanArray(200 downto 0);
    -- 
  begin -- 
    dct_engine_CP_0_elements(0) <= dct_engine_CP_0_start;
    dct_engine_CP_0_symbol <= dct_engine_CP_0_elements(1);
    -- CP-element group 0 transition  place  bypass 
    -- predecessors 
    -- successors 177 
    -- members (10) 
      -- 	$entry
      -- 	branch_block_stmt_6/$entry
      -- 	branch_block_stmt_6/branch_block_stmt_6__entry__
      -- 	branch_block_stmt_6/assign_stmt_17_to_assign_stmt_21__entry__
      -- 	branch_block_stmt_6/assign_stmt_17_to_assign_stmt_21__exit__
      -- 	branch_block_stmt_6/bb_0_bb_1
      -- 	branch_block_stmt_6/assign_stmt_17_to_assign_stmt_21/$entry
      -- 	branch_block_stmt_6/assign_stmt_17_to_assign_stmt_21/$exit
      -- 	branch_block_stmt_6/bb_0_bb_1_PhiReq/$entry
      -- 	branch_block_stmt_6/bb_0_bb_1_PhiReq/$exit
      -- 
    -- CP-element group 1 transition  place  bypass 
    -- predecessors 
    -- successors 
    -- members (3) 
      -- 	$exit
      -- 	branch_block_stmt_6/$exit
      -- 	branch_block_stmt_6/branch_block_stmt_6__exit__
      -- 
    dct_engine_CP_0_elements(1) <= false; 
    -- CP-element group 2 merge  fork  transition  place  bypass 
    -- predecessors 35 31 
    -- successors 184 185 
    -- members (7) 
      -- 	branch_block_stmt_6/merge_stmt_54__exit__
      -- 	branch_block_stmt_6/bbx_xnphx_xpreheader_bbx_xnph
      -- 	branch_block_stmt_6/bbx_xnphx_xpreheader_bbx_xnph_PhiReq/$entry
      -- 	branch_block_stmt_6/bbx_xnphx_xpreheader_bbx_xnph_PhiReq/phi_stmt_57/$entry
      -- 	branch_block_stmt_6/bbx_xnphx_xpreheader_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/$entry
      -- 	branch_block_stmt_6/bbx_xnphx_xpreheader_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/type_cast_60/$entry
      -- 	branch_block_stmt_6/bbx_xnphx_xpreheader_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/type_cast_60/SplitProtocol/$entry
      -- 
    dct_engine_CP_0_elements(2) <= OrReduce(dct_engine_CP_0_elements(35) & dct_engine_CP_0_elements(31));
    -- CP-element group 3 place  bypass 
    -- predecessors 55 
    -- successors 56 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81__exit__
      -- 	branch_block_stmt_6/assign_stmt_84__entry__
      -- 
    dct_engine_CP_0_elements(3) <= dct_engine_CP_0_elements(55);
    -- CP-element group 4 branch  place  bypass 
    -- predecessors 98 
    -- successors 100 99 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100__exit__
      -- 	branch_block_stmt_6/if_stmt_101__entry__
      -- 
    dct_engine_CP_0_elements(4) <= dct_engine_CP_0_elements(98);
    -- CP-element group 5 merge  fork  transition  place  bypass 
    -- predecessors 103 99 
    -- successors 195 196 
    -- members (7) 
      -- 	branch_block_stmt_6/merge_stmt_107__exit__
      -- 	branch_block_stmt_6/xx_xpreheaderx_xpreheader_xx_xpreheader
      -- 	branch_block_stmt_6/xx_xpreheaderx_xpreheader_xx_xpreheader_PhiReq/$entry
      -- 	branch_block_stmt_6/xx_xpreheaderx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/$entry
      -- 	branch_block_stmt_6/xx_xpreheaderx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/$entry
      -- 	branch_block_stmt_6/xx_xpreheaderx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/type_cast_113/$entry
      -- 	branch_block_stmt_6/xx_xpreheaderx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/type_cast_113/SplitProtocol/$entry
      -- 
    dct_engine_CP_0_elements(5) <= OrReduce(dct_engine_CP_0_elements(103) & dct_engine_CP_0_elements(99));
    -- CP-element group 6 place  bypass 
    -- predecessors 120 
    -- successors 121 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129__exit__
      -- 	branch_block_stmt_6/assign_stmt_132__entry__
      -- 
    dct_engine_CP_0_elements(6) <= dct_engine_CP_0_elements(120);
    -- CP-element group 7 fork  transition  place  bypass 
    -- predecessors 176 
    -- successors 190 192 
    -- members (7) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142__exit__
      -- 	branch_block_stmt_6/xx_xpreheader_xx_xpreheader
      -- 	branch_block_stmt_6/xx_xpreheader_xx_xpreheader_PhiReq/$entry
      -- 	branch_block_stmt_6/xx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/$entry
      -- 	branch_block_stmt_6/xx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/$entry
      -- 	branch_block_stmt_6/xx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/type_cast_113/$entry
      -- 	branch_block_stmt_6/xx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/type_cast_113/SplitProtocol/$entry
      -- 
    dct_engine_CP_0_elements(7) <= dct_engine_CP_0_elements(176);
    -- CP-element group 8 fork  transition  bypass 
    -- predecessors 178 
    -- successors 10 9 
    -- members (1) 
      -- 	branch_block_stmt_6/assign_stmt_26/$entry
      -- 
    dct_engine_CP_0_elements(8) <= dct_engine_CP_0_elements(178);
    -- CP-element group 9 transition  output  bypass 
    -- predecessors 8 
    -- successors 11 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_26/RPIPE_dct_in_data_25_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_26/RPIPE_dct_in_data_25_Sample/$entry
      -- 	branch_block_stmt_6/assign_stmt_26/RPIPE_dct_in_data_25_Sample/rr
      -- 
    dct_engine_CP_0_elements(9) <= dct_engine_CP_0_elements(8);
    rr_56_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(9), ack => RPIPE_dct_in_data_25_inst_req_0); -- 
    -- CP-element group 10 transition  output  bypass 
    -- predecessors 8 
    -- successors 12 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_26/RPIPE_dct_in_data_25_update_start_
      -- 	branch_block_stmt_6/assign_stmt_26/RPIPE_dct_in_data_25_Update/$entry
      -- 	branch_block_stmt_6/assign_stmt_26/RPIPE_dct_in_data_25_Update/cr
      -- 
    dct_engine_CP_0_elements(10) <= dct_engine_CP_0_elements(8);
    cr_61_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(10), ack => RPIPE_dct_in_data_25_inst_req_1); -- 
    -- CP-element group 11 transition  input  bypass 
    -- predecessors 9 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_26/RPIPE_dct_in_data_25_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_26/RPIPE_dct_in_data_25_Sample/$exit
      -- 	branch_block_stmt_6/assign_stmt_26/RPIPE_dct_in_data_25_Sample/ra
      -- 
    ra_57_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_dct_in_data_25_inst_ack_0, ack => dct_engine_CP_0_elements(11)); -- 
    -- CP-element group 12 transition  place  input  bypass 
    -- predecessors 10 
    -- successors 13 
    -- members (6) 
      -- 	branch_block_stmt_6/assign_stmt_26/$exit
      -- 	branch_block_stmt_6/assign_stmt_26__exit__
      -- 	branch_block_stmt_6/assign_stmt_29__entry__
      -- 	branch_block_stmt_6/assign_stmt_26/RPIPE_dct_in_data_25_Update/ca
      -- 	branch_block_stmt_6/assign_stmt_26/RPIPE_dct_in_data_25_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_26/RPIPE_dct_in_data_25_Update/$exit
      -- 
    ca_62_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_dct_in_data_25_inst_ack_1, ack => dct_engine_CP_0_elements(12)); -- 
    -- CP-element group 13 fork  transition  bypass 
    -- predecessors 12 
    -- successors 15 14 
    -- members (1) 
      -- 	branch_block_stmt_6/assign_stmt_29/$entry
      -- 
    dct_engine_CP_0_elements(13) <= dct_engine_CP_0_elements(12);
    -- CP-element group 14 transition  output  bypass 
    -- predecessors 13 
    -- successors 16 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_29/RPIPE_dct_in_data_28_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_29/RPIPE_dct_in_data_28_Sample/$entry
      -- 	branch_block_stmt_6/assign_stmt_29/RPIPE_dct_in_data_28_Sample/rr
      -- 
    dct_engine_CP_0_elements(14) <= dct_engine_CP_0_elements(13);
    rr_73_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(14), ack => RPIPE_dct_in_data_28_inst_req_0); -- 
    -- CP-element group 15 transition  output  bypass 
    -- predecessors 13 
    -- successors 17 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_29/RPIPE_dct_in_data_28_update_start_
      -- 	branch_block_stmt_6/assign_stmt_29/RPIPE_dct_in_data_28_Update/$entry
      -- 	branch_block_stmt_6/assign_stmt_29/RPIPE_dct_in_data_28_Update/cr
      -- 
    dct_engine_CP_0_elements(15) <= dct_engine_CP_0_elements(13);
    cr_78_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(15), ack => RPIPE_dct_in_data_28_inst_req_1); -- 
    -- CP-element group 16 transition  input  bypass 
    -- predecessors 14 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_29/RPIPE_dct_in_data_28_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_29/RPIPE_dct_in_data_28_Sample/$exit
      -- 	branch_block_stmt_6/assign_stmt_29/RPIPE_dct_in_data_28_Sample/ra
      -- 
    ra_74_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_dct_in_data_28_inst_ack_0, ack => dct_engine_CP_0_elements(16)); -- 
    -- CP-element group 17 transition  place  input  bypass 
    -- predecessors 15 
    -- successors 18 
    -- members (6) 
      -- 	branch_block_stmt_6/assign_stmt_29__exit__
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47__entry__
      -- 	branch_block_stmt_6/assign_stmt_29/$exit
      -- 	branch_block_stmt_6/assign_stmt_29/RPIPE_dct_in_data_28_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_29/RPIPE_dct_in_data_28_Update/$exit
      -- 	branch_block_stmt_6/assign_stmt_29/RPIPE_dct_in_data_28_Update/ca
      -- 
    ca_79_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_dct_in_data_28_inst_ack_1, ack => dct_engine_CP_0_elements(17)); -- 
    -- CP-element group 18 fork  transition  bypass 
    -- predecessors 17 
    -- successors 28 24 20 23 19 
    -- members (1) 
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/$entry
      -- 
    dct_engine_CP_0_elements(18) <= dct_engine_CP_0_elements(17);
    -- CP-element group 19 transition  output  bypass 
    -- predecessors 18 
    -- successors 22 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/EQ_u32_u1_34_update_start_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/EQ_u32_u1_34_Update/$entry
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/EQ_u32_u1_34_Update/cr
      -- 
    dct_engine_CP_0_elements(19) <= dct_engine_CP_0_elements(18);
    cr_99_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(19), ack => EQ_u32_u1_34_inst_req_1); -- 
    -- CP-element group 20 transition  output  bypass 
    -- predecessors 18 
    -- successors 21 
    -- members (7) 
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/EQ_u32_u1_34_Sample/$entry
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/EQ_u32_u1_34_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/R_iNsTr_2_31_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/R_iNsTr_2_31_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/R_iNsTr_2_31_update_start_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/R_iNsTr_2_31_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/EQ_u32_u1_34_Sample/rr
      -- 
    dct_engine_CP_0_elements(20) <= dct_engine_CP_0_elements(18);
    rr_94_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(20), ack => EQ_u32_u1_34_inst_req_0); -- 
    -- CP-element group 21 transition  input  bypass 
    -- predecessors 20 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/EQ_u32_u1_34_Sample/$exit
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/EQ_u32_u1_34_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/EQ_u32_u1_34_Sample/ra
      -- 
    ra_95_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => EQ_u32_u1_34_inst_ack_0, ack => dct_engine_CP_0_elements(21)); -- 
    -- CP-element group 22 transition  input  bypass 
    -- predecessors 19 
    -- successors 27 
    -- members (7) 
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/EQ_u32_u1_34_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/EQ_u32_u1_34_Update/$exit
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/EQ_u32_u1_34_Update/ca
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/R_cond_44_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/R_cond_44_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/R_cond_44_update_start_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/R_cond_44_update_completed_
      -- 
    ca_100_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => EQ_u32_u1_34_inst_ack_1, ack => dct_engine_CP_0_elements(22)); -- 
    -- CP-element group 23 transition  output  bypass 
    -- predecessors 18 
    -- successors 26 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/EQ_u32_u1_41_update_start_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/EQ_u32_u1_41_Update/$entry
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/EQ_u32_u1_41_Update/cr
      -- 
    dct_engine_CP_0_elements(23) <= dct_engine_CP_0_elements(18);
    cr_117_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(23), ack => EQ_u32_u1_41_inst_req_1); -- 
    -- CP-element group 24 transition  output  bypass 
    -- predecessors 18 
    -- successors 25 
    -- members (7) 
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/EQ_u32_u1_41_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/R_iNsTr_4_38_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/R_iNsTr_4_38_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/R_iNsTr_4_38_update_start_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/R_iNsTr_4_38_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/EQ_u32_u1_41_Sample/$entry
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/EQ_u32_u1_41_Sample/rr
      -- 
    dct_engine_CP_0_elements(24) <= dct_engine_CP_0_elements(18);
    rr_112_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(24), ack => EQ_u32_u1_41_inst_req_0); -- 
    -- CP-element group 25 transition  input  bypass 
    -- predecessors 24 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/EQ_u32_u1_41_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/EQ_u32_u1_41_Sample/$exit
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/EQ_u32_u1_41_Sample/ra
      -- 
    ra_113_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => EQ_u32_u1_41_inst_ack_0, ack => dct_engine_CP_0_elements(25)); -- 
    -- CP-element group 26 transition  input  bypass 
    -- predecessors 23 
    -- successors 27 
    -- members (7) 
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/EQ_u32_u1_41_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/EQ_u32_u1_41_Update/$exit
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/EQ_u32_u1_41_Update/ca
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/R_iNsTr_5_45_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/R_iNsTr_5_45_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/R_iNsTr_5_45_update_start_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/R_iNsTr_5_45_update_completed_
      -- 
    ca_118_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => EQ_u32_u1_41_inst_ack_1, ack => dct_engine_CP_0_elements(26)); -- 
    -- CP-element group 27 join  transition  output  bypass 
    -- predecessors 26 22 
    -- successors 29 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/AND_u1_u1_46_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/AND_u1_u1_46_Sample/$entry
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/AND_u1_u1_46_Sample/rr
      -- 
    cp_element_group_27: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 19) := "cp_element_group_27"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= dct_engine_CP_0_elements(26) & dct_engine_CP_0_elements(22);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => dct_engine_CP_0_elements(27), clk => clk, reset => reset); --
    end block;
    rr_134_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(27), ack => AND_u1_u1_46_inst_req_0); -- 
    -- CP-element group 28 transition  output  bypass 
    -- predecessors 18 
    -- successors 30 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/AND_u1_u1_46_update_start_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/AND_u1_u1_46_Update/$entry
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/AND_u1_u1_46_Update/cr
      -- 
    dct_engine_CP_0_elements(28) <= dct_engine_CP_0_elements(18);
    cr_139_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(28), ack => AND_u1_u1_46_inst_req_1); -- 
    -- CP-element group 29 transition  input  bypass 
    -- predecessors 27 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/AND_u1_u1_46_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/AND_u1_u1_46_Sample/$exit
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/AND_u1_u1_46_Sample/ra
      -- 
    ra_135_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => AND_u1_u1_46_inst_ack_0, ack => dct_engine_CP_0_elements(29)); -- 
    -- CP-element group 30 branch  transition  place  input  bypass 
    -- predecessors 28 
    -- successors 32 31 
    -- members (6) 
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47__exit__
      -- 	branch_block_stmt_6/if_stmt_48__entry__
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/$exit
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/AND_u1_u1_46_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/AND_u1_u1_46_Update/$exit
      -- 	branch_block_stmt_6/assign_stmt_36_to_assign_stmt_47/AND_u1_u1_46_Update/ca
      -- 
    ca_140_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => AND_u1_u1_46_inst_ack_1, ack => dct_engine_CP_0_elements(30)); -- 
    -- CP-element group 31 transition  place  dead  bypass 
    -- predecessors 30 
    -- successors 2 
    -- members (8) 
      -- 	branch_block_stmt_6/if_stmt_48__exit__
      -- 	branch_block_stmt_6/merge_stmt_54__entry__
      -- 	branch_block_stmt_6/if_stmt_48_dead_link/$entry
      -- 	branch_block_stmt_6/if_stmt_48_dead_link/$exit
      -- 	branch_block_stmt_6/if_stmt_48_dead_link/dead_transition
      -- 	branch_block_stmt_6/merge_stmt_54_dead_link/$entry
      -- 	branch_block_stmt_6/merge_stmt_54_dead_link/$exit
      -- 	branch_block_stmt_6/merge_stmt_54_dead_link/dead_transition
      -- 
    dct_engine_CP_0_elements(31) <= false;
    -- CP-element group 32 transition  output  bypass 
    -- predecessors 30 
    -- successors 33 
    -- members (3) 
      -- 	branch_block_stmt_6/if_stmt_48_eval_test/$entry
      -- 	branch_block_stmt_6/if_stmt_48_eval_test/$exit
      -- 	branch_block_stmt_6/if_stmt_48_eval_test/branch_req
      -- 
    dct_engine_CP_0_elements(32) <= dct_engine_CP_0_elements(30);
    branch_req_148_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(32), ack => if_stmt_48_branch_req_0); -- 
    -- CP-element group 33 branch  place  bypass 
    -- predecessors 32 
    -- successors 36 34 
    -- members (1) 
      -- 	branch_block_stmt_6/R_orx_xcond_49_place
      -- 
    dct_engine_CP_0_elements(33) <= dct_engine_CP_0_elements(32);
    -- CP-element group 34 transition  bypass 
    -- predecessors 33 
    -- successors 35 
    -- members (1) 
      -- 	branch_block_stmt_6/if_stmt_48_if_link/$entry
      -- 
    dct_engine_CP_0_elements(34) <= dct_engine_CP_0_elements(33);
    -- CP-element group 35 transition  place  input  bypass 
    -- predecessors 34 
    -- successors 2 
    -- members (9) 
      -- 	branch_block_stmt_6/if_stmt_48_if_link/$exit
      -- 	branch_block_stmt_6/if_stmt_48_if_link/if_choice_transition
      -- 	branch_block_stmt_6/bb_1_bbx_xnphx_xpreheader
      -- 	branch_block_stmt_6/bb_1_bbx_xnphx_xpreheader_PhiReq/$entry
      -- 	branch_block_stmt_6/bb_1_bbx_xnphx_xpreheader_PhiReq/$exit
      -- 	branch_block_stmt_6/merge_stmt_54_PhiReqMerge
      -- 	branch_block_stmt_6/merge_stmt_54_PhiAck/$entry
      -- 	branch_block_stmt_6/merge_stmt_54_PhiAck/$exit
      -- 	branch_block_stmt_6/merge_stmt_54_PhiAck/dummy
      -- 
    if_choice_transition_153_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => if_stmt_48_branch_ack_1, ack => dct_engine_CP_0_elements(35)); -- 
    -- CP-element group 36 transition  bypass 
    -- predecessors 33 
    -- successors 37 
    -- members (1) 
      -- 	branch_block_stmt_6/if_stmt_48_else_link/$entry
      -- 
    dct_engine_CP_0_elements(36) <= dct_engine_CP_0_elements(33);
    -- CP-element group 37 transition  place  input  bypass 
    -- predecessors 36 
    -- successors 177 
    -- members (5) 
      -- 	branch_block_stmt_6/if_stmt_48_else_link/$exit
      -- 	branch_block_stmt_6/if_stmt_48_else_link/else_choice_transition
      -- 	branch_block_stmt_6/bb_1_bb_1
      -- 	branch_block_stmt_6/bb_1_bb_1_PhiReq/$entry
      -- 	branch_block_stmt_6/bb_1_bb_1_PhiReq/$exit
      -- 
    else_choice_transition_157_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => if_stmt_48_branch_ack_0, ack => dct_engine_CP_0_elements(37)); -- 
    -- CP-element group 38 fork  transition  bypass 
    -- predecessors 189 
    -- successors 52 40 39 46 43 
    -- members (1) 
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/$entry
      -- 
    dct_engine_CP_0_elements(38) <= dct_engine_CP_0_elements(189);
    -- CP-element group 39 transition  output  bypass 
    -- predecessors 38 
    -- successors 42 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/MUL_u32_u32_69_update_start_
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/MUL_u32_u32_69_Update/$entry
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/MUL_u32_u32_69_Update/cr
      -- 
    dct_engine_CP_0_elements(39) <= dct_engine_CP_0_elements(38);
    cr_179_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(39), ack => MUL_u32_u32_69_inst_req_1); -- 
    -- CP-element group 40 transition  output  bypass 
    -- predecessors 38 
    -- successors 41 
    -- members (7) 
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/MUL_u32_u32_69_Sample/$entry
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/MUL_u32_u32_69_Sample/rr
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/MUL_u32_u32_69_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/R_ix_x05_66_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/R_ix_x05_66_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/R_ix_x05_66_update_start_
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/R_ix_x05_66_update_completed_
      -- 
    dct_engine_CP_0_elements(40) <= dct_engine_CP_0_elements(38);
    rr_174_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(40), ack => MUL_u32_u32_69_inst_req_0); -- 
    -- CP-element group 41 transition  input  bypass 
    -- predecessors 40 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/MUL_u32_u32_69_Sample/$exit
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/MUL_u32_u32_69_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/MUL_u32_u32_69_Sample/ra
      -- 
    ra_175_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => MUL_u32_u32_69_inst_ack_0, ack => dct_engine_CP_0_elements(41)); -- 
    -- CP-element group 42 transition  input  output  bypass 
    -- predecessors 39 
    -- successors 44 
    -- members (9) 
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/MUL_u32_u32_69_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/MUL_u32_u32_69_Update/$exit
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/MUL_u32_u32_69_Update/ca
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/R_tmp4_74_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/R_tmp4_74_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/R_tmp4_74_update_start_
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/R_tmp4_74_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_index_resize_1/$entry
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_index_resize_1/index_resize_req
      -- 
    ca_180_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => MUL_u32_u32_69_inst_ack_1, ack => dct_engine_CP_0_elements(42)); -- 
    index_resize_req_197_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(42), ack => array_obj_ref_75_index_1_resize_req_0); -- 
    -- CP-element group 43 transition  output  bypass 
    -- predecessors 38 
    -- successors 51 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_update_start_
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_complete/$entry
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_complete/req
      -- 
    dct_engine_CP_0_elements(43) <= dct_engine_CP_0_elements(38);
    req_229_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(43), ack => array_obj_ref_75_final_reg_req_1); -- 
    -- CP-element group 44 transition  input  output  bypass 
    -- predecessors 42 
    -- successors 45 
    -- members (5) 
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_index_resized_1
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_index_resize_1/$exit
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_index_resize_1/index_resize_ack
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_index_scale_1/$entry
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_index_scale_1/scale_rename_req
      -- 
    index_resize_ack_198_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_75_index_1_resize_ack_0, ack => dct_engine_CP_0_elements(44)); -- 
    scale_rename_req_202_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(44), ack => array_obj_ref_75_index_1_rename_req_0); -- 
    -- CP-element group 45 transition  input  output  bypass 
    -- predecessors 44 
    -- successors 47 
    -- members (5) 
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_index_scaled_1
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_index_scale_1/$exit
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_index_scale_1/scale_rename_ack
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_final_index_sum_regn_Sample/$entry
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_final_index_sum_regn_Sample/req
      -- 
    scale_rename_ack_203_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_75_index_1_rename_ack_0, ack => dct_engine_CP_0_elements(45)); -- 
    req_209_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(45), ack => array_obj_ref_75_index_offset_req_0); -- 
    -- CP-element group 46 transition  output  bypass 
    -- predecessors 38 
    -- successors 48 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_final_index_sum_regn_update_start
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_final_index_sum_regn_Update/$entry
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_final_index_sum_regn_Update/req
      -- 
    dct_engine_CP_0_elements(46) <= dct_engine_CP_0_elements(38);
    req_214_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(46), ack => array_obj_ref_75_index_offset_req_1); -- 
    -- CP-element group 47 transition  input  bypass 
    -- predecessors 45 
    -- successors 55 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_final_index_sum_regn_sample_complete
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_final_index_sum_regn_Sample/$exit
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_final_index_sum_regn_Sample/ack
      -- 
    ack_210_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_75_index_offset_ack_0, ack => dct_engine_CP_0_elements(47)); -- 
    -- CP-element group 48 transition  input  output  bypass 
    -- predecessors 46 
    -- successors 49 
    -- members (5) 
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_offset_calculated
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_final_index_sum_regn_Update/$exit
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_final_index_sum_regn_Update/ack
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_base_plus_offset/$entry
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_base_plus_offset/sum_rename_req
      -- 
    ack_215_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_75_index_offset_ack_1, ack => dct_engine_CP_0_elements(48)); -- 
    sum_rename_req_219_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(48), ack => array_obj_ref_75_root_address_inst_req_0); -- 
    -- CP-element group 49 transition  input  output  bypass 
    -- predecessors 48 
    -- successors 50 
    -- members (6) 
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_root_address_calculated
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_base_plus_offset/$exit
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_base_plus_offset/sum_rename_ack
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_request/$entry
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_request/req
      -- 
    sum_rename_ack_220_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_75_root_address_inst_ack_0, ack => dct_engine_CP_0_elements(49)); -- 
    req_224_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(49), ack => array_obj_ref_75_final_reg_req_0); -- 
    -- CP-element group 50 transition  input  bypass 
    -- predecessors 49 
    -- successors 55 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_request/$exit
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_request/ack
      -- 
    ack_225_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_75_final_reg_ack_0, ack => dct_engine_CP_0_elements(50)); -- 
    -- CP-element group 51 transition  input  output  bypass 
    -- predecessors 43 
    -- successors 53 
    -- members (10) 
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_complete/$exit
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/array_obj_ref_75_complete/ack
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/type_cast_80_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/R_scevgep_79_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/R_scevgep_79_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/R_scevgep_79_update_start_
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/R_scevgep_79_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/type_cast_80_Sample/$entry
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/type_cast_80_Sample/rr
      -- 
    ack_230_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_75_final_reg_ack_1, ack => dct_engine_CP_0_elements(51)); -- 
    rr_242_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(51), ack => type_cast_80_inst_req_0); -- 
    -- CP-element group 52 transition  output  bypass 
    -- predecessors 38 
    -- successors 54 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/type_cast_80_update_start_
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/type_cast_80_Update/$entry
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/type_cast_80_Update/cr
      -- 
    dct_engine_CP_0_elements(52) <= dct_engine_CP_0_elements(38);
    cr_247_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(52), ack => type_cast_80_inst_req_1); -- 
    -- CP-element group 53 transition  input  bypass 
    -- predecessors 51 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/type_cast_80_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/type_cast_80_Sample/$exit
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/type_cast_80_Sample/ra
      -- 
    ra_243_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => type_cast_80_inst_ack_0, ack => dct_engine_CP_0_elements(53)); -- 
    -- CP-element group 54 transition  input  bypass 
    -- predecessors 52 
    -- successors 55 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/type_cast_80_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/type_cast_80_Update/$exit
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/type_cast_80_Update/ca
      -- 
    ca_248_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => type_cast_80_inst_ack_1, ack => dct_engine_CP_0_elements(54)); -- 
    -- CP-element group 55 join  transition  bypass 
    -- predecessors 47 50 54 
    -- successors 3 
    -- members (1) 
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81/$exit
      -- 
    cp_element_group_55: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 19) := "cp_element_group_55"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= dct_engine_CP_0_elements(47) & dct_engine_CP_0_elements(50) & dct_engine_CP_0_elements(54);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => dct_engine_CP_0_elements(55), clk => clk, reset => reset); --
    end block;
    -- CP-element group 56 fork  transition  bypass 
    -- predecessors 3 
    -- successors 58 57 
    -- members (1) 
      -- 	branch_block_stmt_6/assign_stmt_84/$entry
      -- 
    dct_engine_CP_0_elements(56) <= dct_engine_CP_0_elements(3);
    -- CP-element group 57 transition  output  bypass 
    -- predecessors 56 
    -- successors 59 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_84/RPIPE_dct_in_data_83_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_84/RPIPE_dct_in_data_83_Sample/$entry
      -- 	branch_block_stmt_6/assign_stmt_84/RPIPE_dct_in_data_83_Sample/rr
      -- 
    dct_engine_CP_0_elements(57) <= dct_engine_CP_0_elements(56);
    rr_259_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(57), ack => RPIPE_dct_in_data_83_inst_req_0); -- 
    -- CP-element group 58 transition  output  bypass 
    -- predecessors 56 
    -- successors 60 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_84/RPIPE_dct_in_data_83_update_start_
      -- 	branch_block_stmt_6/assign_stmt_84/RPIPE_dct_in_data_83_Update/$entry
      -- 	branch_block_stmt_6/assign_stmt_84/RPIPE_dct_in_data_83_Update/cr
      -- 
    dct_engine_CP_0_elements(58) <= dct_engine_CP_0_elements(56);
    cr_264_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(58), ack => RPIPE_dct_in_data_83_inst_req_1); -- 
    -- CP-element group 59 transition  input  bypass 
    -- predecessors 57 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_84/RPIPE_dct_in_data_83_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_84/RPIPE_dct_in_data_83_Sample/$exit
      -- 	branch_block_stmt_6/assign_stmt_84/RPIPE_dct_in_data_83_Sample/ra
      -- 
    ra_260_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_dct_in_data_83_inst_ack_0, ack => dct_engine_CP_0_elements(59)); -- 
    -- CP-element group 60 transition  place  input  bypass 
    -- predecessors 58 
    -- successors 61 
    -- members (6) 
      -- 	branch_block_stmt_6/assign_stmt_84__exit__
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100__entry__
      -- 	branch_block_stmt_6/assign_stmt_84/$exit
      -- 	branch_block_stmt_6/assign_stmt_84/RPIPE_dct_in_data_83_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_84/RPIPE_dct_in_data_83_Update/$exit
      -- 	branch_block_stmt_6/assign_stmt_84/RPIPE_dct_in_data_83_Update/ca
      -- 
    ca_265_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_dct_in_data_83_inst_ack_1, ack => dct_engine_CP_0_elements(60)); -- 
    -- CP-element group 61 fork  transition  bypass 
    -- predecessors 60 
    -- successors 62 70 65 64 95 92 91 
    -- members (1) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/$entry
      -- 
    dct_engine_CP_0_elements(61) <= dct_engine_CP_0_elements(60);
    -- CP-element group 62 transition  bypass 
    -- predecessors 61 
    -- successors 63 
    -- members (4) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/R_iNsTr_9_87_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/R_iNsTr_9_87_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/R_iNsTr_9_87_update_start_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/R_iNsTr_9_87_update_completed_
      -- 
    dct_engine_CP_0_elements(62) <= dct_engine_CP_0_elements(61);
    -- CP-element group 63 join  transition  output  bypass 
    -- predecessors 62 65 71 
    -- successors 80 
    -- members (4) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Sample/$entry
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Sample/ptr_deref_86_Split/$entry
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Sample/ptr_deref_86_Split/split_req
      -- 
    cp_element_group_63: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 19) := "cp_element_group_63"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= dct_engine_CP_0_elements(62) & dct_engine_CP_0_elements(65) & dct_engine_CP_0_elements(71);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => dct_engine_CP_0_elements(63), clk => clk, reset => reset); --
    end block;
    split_req_325_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(63), ack => ptr_deref_86_gather_scatter_req_0); -- 
    -- CP-element group 64 fork  transition  bypass 
    -- predecessors 61 
    -- successors 88 86 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_update_start_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Update/$entry
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Update/word_access_complete/$entry
      -- 
    dct_engine_CP_0_elements(64) <= dct_engine_CP_0_elements(61);
    -- CP-element group 65 fork  transition  bypass 
    -- predecessors 61 
    -- successors 63 66 
    -- members (5) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_base_address_calculated
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/R_scevgep78_85_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/R_scevgep78_85_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/R_scevgep78_85_update_start_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/R_scevgep78_85_update_completed_
      -- 
    dct_engine_CP_0_elements(65) <= dct_engine_CP_0_elements(61);
    -- CP-element group 66 transition  output  bypass 
    -- predecessors 65 
    -- successors 67 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_base_addr_resize/$entry
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_base_addr_resize/base_resize_req
      -- 
    dct_engine_CP_0_elements(66) <= dct_engine_CP_0_elements(65);
    base_resize_req_288_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(66), ack => ptr_deref_86_base_resize_req_0); -- 
    -- CP-element group 67 transition  input  output  bypass 
    -- predecessors 66 
    -- successors 68 
    -- members (5) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_base_address_resized
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_base_addr_resize/$exit
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_base_addr_resize/base_resize_ack
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_base_plus_offset/$entry
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_base_plus_offset/sum_rename_req
      -- 
    base_resize_ack_289_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_86_base_resize_ack_0, ack => dct_engine_CP_0_elements(67)); -- 
    sum_rename_req_293_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(67), ack => ptr_deref_86_root_address_inst_req_0); -- 
    -- CP-element group 68 fork  transition  input  bypass 
    -- predecessors 67 
    -- successors 76 72 
    -- members (4) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_root_address_calculated
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_base_plus_offset/$exit
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_base_plus_offset/sum_rename_ack
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_word_addrgen_sample_start
      -- 
    sum_rename_ack_294_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_86_root_address_inst_ack_0, ack => dct_engine_CP_0_elements(68)); -- 
    -- CP-element group 69 join  transition  bypass 
    -- predecessors 73 77 
    -- successors 98 
    -- members (1) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_word_addrgen_sample_complete
      -- 
    cp_element_group_69: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 19) := "cp_element_group_69"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= dct_engine_CP_0_elements(73) & dct_engine_CP_0_elements(77);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => dct_engine_CP_0_elements(69), clk => clk, reset => reset); --
    end block;
    -- CP-element group 70 fork  transition  bypass 
    -- predecessors 61 
    -- successors 74 78 
    -- members (1) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_word_addrgen_update_start
      -- 
    dct_engine_CP_0_elements(70) <= dct_engine_CP_0_elements(61);
    -- CP-element group 71 join  transition  bypass 
    -- predecessors 79 75 
    -- successors 63 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_word_address_calculated
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_word_addrgen_update_complete
      -- 
    cp_element_group_71: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 19) := "cp_element_group_71"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= dct_engine_CP_0_elements(79) & dct_engine_CP_0_elements(75);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => dct_engine_CP_0_elements(71), clk => clk, reset => reset); --
    end block;
    -- CP-element group 72 transition  output  bypass 
    -- predecessors 68 
    -- successors 73 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_word_addrgen_0_Sample/$entry
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_word_addrgen_0_Sample/rr
      -- 
    dct_engine_CP_0_elements(72) <= dct_engine_CP_0_elements(68);
    rr_302_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(72), ack => ptr_deref_86_addr_0_req_0); -- 
    -- CP-element group 73 transition  input  bypass 
    -- predecessors 72 
    -- successors 69 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_word_addrgen_0_Sample/$exit
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_word_addrgen_0_Sample/ra
      -- 
    ra_303_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_86_addr_0_ack_0, ack => dct_engine_CP_0_elements(73)); -- 
    -- CP-element group 74 transition  output  bypass 
    -- predecessors 70 
    -- successors 75 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_word_addrgen_0_Update/$entry
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_word_addrgen_0_Update/cr
      -- 
    dct_engine_CP_0_elements(74) <= dct_engine_CP_0_elements(70);
    cr_307_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(74), ack => ptr_deref_86_addr_0_req_1); -- 
    -- CP-element group 75 transition  input  bypass 
    -- predecessors 74 
    -- successors 71 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_word_addrgen_0_Update/$exit
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_word_addrgen_0_Update/ca
      -- 
    ca_308_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_86_addr_0_ack_1, ack => dct_engine_CP_0_elements(75)); -- 
    -- CP-element group 76 transition  output  bypass 
    -- predecessors 68 
    -- successors 77 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_word_addrgen_1_Sample/$entry
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_word_addrgen_1_Sample/rr
      -- 
    dct_engine_CP_0_elements(76) <= dct_engine_CP_0_elements(68);
    rr_312_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(76), ack => ptr_deref_86_addr_1_req_0); -- 
    -- CP-element group 77 transition  input  bypass 
    -- predecessors 76 
    -- successors 69 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_word_addrgen_1_Sample/$exit
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_word_addrgen_1_Sample/ra
      -- 
    ra_313_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_86_addr_1_ack_0, ack => dct_engine_CP_0_elements(77)); -- 
    -- CP-element group 78 transition  output  bypass 
    -- predecessors 70 
    -- successors 79 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_word_addrgen_1_Update/$entry
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_word_addrgen_1_Update/cr
      -- 
    dct_engine_CP_0_elements(78) <= dct_engine_CP_0_elements(70);
    cr_317_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(78), ack => ptr_deref_86_addr_1_req_1); -- 
    -- CP-element group 79 transition  input  bypass 
    -- predecessors 78 
    -- successors 71 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_word_addrgen_1_Update/$exit
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_word_addrgen_1_Update/ca
      -- 
    ca_318_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_86_addr_1_ack_1, ack => dct_engine_CP_0_elements(79)); -- 
    -- CP-element group 80 fork  transition  input  bypass 
    -- predecessors 63 
    -- successors 83 81 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Sample/ptr_deref_86_Split/$exit
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Sample/ptr_deref_86_Split/split_ack
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Sample/word_access_start/$entry
      -- 
    split_ack_326_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_86_gather_scatter_ack_0, ack => dct_engine_CP_0_elements(80)); -- 
    -- CP-element group 81 transition  output  bypass 
    -- predecessors 80 
    -- successors 82 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Sample/word_access_start/word_0/$entry
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Sample/word_access_start/word_0/rr
      -- 
    dct_engine_CP_0_elements(81) <= dct_engine_CP_0_elements(80);
    rr_333_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(81), ack => ptr_deref_86_store_0_req_0); -- 
    -- CP-element group 82 transition  input  bypass 
    -- predecessors 81 
    -- successors 85 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Sample/word_access_start/word_0/$exit
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Sample/word_access_start/word_0/ra
      -- 
    ra_334_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_86_store_0_ack_0, ack => dct_engine_CP_0_elements(82)); -- 
    -- CP-element group 83 transition  output  bypass 
    -- predecessors 80 
    -- successors 84 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Sample/word_access_start/word_1/$entry
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Sample/word_access_start/word_1/rr
      -- 
    dct_engine_CP_0_elements(83) <= dct_engine_CP_0_elements(80);
    rr_338_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(83), ack => ptr_deref_86_store_1_req_0); -- 
    -- CP-element group 84 transition  input  bypass 
    -- predecessors 83 
    -- successors 85 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Sample/word_access_start/word_1/$exit
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Sample/word_access_start/word_1/ra
      -- 
    ra_339_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_86_store_1_ack_0, ack => dct_engine_CP_0_elements(84)); -- 
    -- CP-element group 85 join  transition  bypass 
    -- predecessors 84 82 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Sample/$exit
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Sample/word_access_start/$exit
      -- 
    cp_element_group_85: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 19) := "cp_element_group_85"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= dct_engine_CP_0_elements(84) & dct_engine_CP_0_elements(82);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => dct_engine_CP_0_elements(85), clk => clk, reset => reset); --
    end block;
    -- CP-element group 86 transition  output  bypass 
    -- predecessors 64 
    -- successors 87 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Update/word_access_complete/word_0/$entry
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Update/word_access_complete/word_0/cr
      -- 
    dct_engine_CP_0_elements(86) <= dct_engine_CP_0_elements(64);
    cr_349_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(86), ack => ptr_deref_86_store_0_req_1); -- 
    -- CP-element group 87 transition  input  bypass 
    -- predecessors 86 
    -- successors 90 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Update/word_access_complete/word_0/$exit
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Update/word_access_complete/word_0/ca
      -- 
    ca_350_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_86_store_0_ack_1, ack => dct_engine_CP_0_elements(87)); -- 
    -- CP-element group 88 transition  output  bypass 
    -- predecessors 64 
    -- successors 89 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Update/word_access_complete/word_1/$entry
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Update/word_access_complete/word_1/cr
      -- 
    dct_engine_CP_0_elements(88) <= dct_engine_CP_0_elements(64);
    cr_354_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(88), ack => ptr_deref_86_store_1_req_1); -- 
    -- CP-element group 89 transition  input  bypass 
    -- predecessors 88 
    -- successors 90 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Update/word_access_complete/word_1/$exit
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Update/word_access_complete/word_1/ca
      -- 
    ca_355_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_86_store_1_ack_1, ack => dct_engine_CP_0_elements(89)); -- 
    -- CP-element group 90 join  transition  bypass 
    -- predecessors 89 87 
    -- successors 98 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Update/$exit
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ptr_deref_86_Update/word_access_complete/$exit
      -- 
    cp_element_group_90: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 19) := "cp_element_group_90"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= dct_engine_CP_0_elements(89) & dct_engine_CP_0_elements(87);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => dct_engine_CP_0_elements(90), clk => clk, reset => reset); --
    end block;
    -- CP-element group 91 transition  output  bypass 
    -- predecessors 61 
    -- successors 94 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ADD_u32_u32_93_update_start_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ADD_u32_u32_93_Update/$entry
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ADD_u32_u32_93_Update/cr
      -- 
    dct_engine_CP_0_elements(91) <= dct_engine_CP_0_elements(61);
    cr_372_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(91), ack => ADD_u32_u32_93_inst_req_1); -- 
    -- CP-element group 92 transition  output  bypass 
    -- predecessors 61 
    -- successors 93 
    -- members (7) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ADD_u32_u32_93_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/R_ix_x05_90_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/R_ix_x05_90_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/R_ix_x05_90_update_start_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/R_ix_x05_90_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ADD_u32_u32_93_Sample/$entry
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ADD_u32_u32_93_Sample/rr
      -- 
    dct_engine_CP_0_elements(92) <= dct_engine_CP_0_elements(61);
    rr_367_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(92), ack => ADD_u32_u32_93_inst_req_0); -- 
    -- CP-element group 93 transition  input  bypass 
    -- predecessors 92 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ADD_u32_u32_93_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ADD_u32_u32_93_Sample/$exit
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ADD_u32_u32_93_Sample/ra
      -- 
    ra_368_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ADD_u32_u32_93_inst_ack_0, ack => dct_engine_CP_0_elements(93)); -- 
    -- CP-element group 94 transition  input  output  bypass 
    -- predecessors 91 
    -- successors 96 
    -- members (10) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ADD_u32_u32_93_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ADD_u32_u32_93_Update/$exit
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/ADD_u32_u32_93_Update/ca
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/EQ_u32_u1_99_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/R_iNsTr_11_96_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/R_iNsTr_11_96_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/R_iNsTr_11_96_update_start_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/R_iNsTr_11_96_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/EQ_u32_u1_99_Sample/$entry
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/EQ_u32_u1_99_Sample/rr
      -- 
    ca_373_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ADD_u32_u32_93_inst_ack_1, ack => dct_engine_CP_0_elements(94)); -- 
    rr_385_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(94), ack => EQ_u32_u1_99_inst_req_0); -- 
    -- CP-element group 95 transition  output  bypass 
    -- predecessors 61 
    -- successors 97 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/EQ_u32_u1_99_update_start_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/EQ_u32_u1_99_Update/$entry
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/EQ_u32_u1_99_Update/cr
      -- 
    dct_engine_CP_0_elements(95) <= dct_engine_CP_0_elements(61);
    cr_390_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(95), ack => EQ_u32_u1_99_inst_req_1); -- 
    -- CP-element group 96 transition  input  bypass 
    -- predecessors 94 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/EQ_u32_u1_99_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/EQ_u32_u1_99_Sample/$exit
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/EQ_u32_u1_99_Sample/ra
      -- 
    ra_386_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => EQ_u32_u1_99_inst_ack_0, ack => dct_engine_CP_0_elements(96)); -- 
    -- CP-element group 97 transition  input  bypass 
    -- predecessors 95 
    -- successors 98 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/EQ_u32_u1_99_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/EQ_u32_u1_99_Update/$exit
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/EQ_u32_u1_99_Update/ca
      -- 
    ca_391_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => EQ_u32_u1_99_inst_ack_1, ack => dct_engine_CP_0_elements(97)); -- 
    -- CP-element group 98 join  transition  bypass 
    -- predecessors 97 69 90 
    -- successors 4 
    -- members (1) 
      -- 	branch_block_stmt_6/assign_stmt_88_to_assign_stmt_100/$exit
      -- 
    cp_element_group_98: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 19) := "cp_element_group_98"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= dct_engine_CP_0_elements(97) & dct_engine_CP_0_elements(69) & dct_engine_CP_0_elements(90);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => dct_engine_CP_0_elements(98), clk => clk, reset => reset); --
    end block;
    -- CP-element group 99 transition  place  dead  bypass 
    -- predecessors 4 
    -- successors 5 
    -- members (8) 
      -- 	branch_block_stmt_6/if_stmt_101__exit__
      -- 	branch_block_stmt_6/merge_stmt_107__entry__
      -- 	branch_block_stmt_6/if_stmt_101_dead_link/$entry
      -- 	branch_block_stmt_6/if_stmt_101_dead_link/$exit
      -- 	branch_block_stmt_6/if_stmt_101_dead_link/dead_transition
      -- 	branch_block_stmt_6/merge_stmt_107_dead_link/$entry
      -- 	branch_block_stmt_6/merge_stmt_107_dead_link/$exit
      -- 	branch_block_stmt_6/merge_stmt_107_dead_link/dead_transition
      -- 
    dct_engine_CP_0_elements(99) <= false;
    -- CP-element group 100 transition  output  bypass 
    -- predecessors 4 
    -- successors 101 
    -- members (3) 
      -- 	branch_block_stmt_6/if_stmt_101_eval_test/$entry
      -- 	branch_block_stmt_6/if_stmt_101_eval_test/$exit
      -- 	branch_block_stmt_6/if_stmt_101_eval_test/branch_req
      -- 
    dct_engine_CP_0_elements(100) <= dct_engine_CP_0_elements(4);
    branch_req_399_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(100), ack => if_stmt_101_branch_req_0); -- 
    -- CP-element group 101 branch  place  bypass 
    -- predecessors 100 
    -- successors 104 102 
    -- members (1) 
      -- 	branch_block_stmt_6/R_exitcond3_102_place
      -- 
    dct_engine_CP_0_elements(101) <= dct_engine_CP_0_elements(100);
    -- CP-element group 102 transition  bypass 
    -- predecessors 101 
    -- successors 103 
    -- members (1) 
      -- 	branch_block_stmt_6/if_stmt_101_if_link/$entry
      -- 
    dct_engine_CP_0_elements(102) <= dct_engine_CP_0_elements(101);
    -- CP-element group 103 transition  place  input  bypass 
    -- predecessors 102 
    -- successors 5 
    -- members (9) 
      -- 	branch_block_stmt_6/if_stmt_101_if_link/$exit
      -- 	branch_block_stmt_6/if_stmt_101_if_link/if_choice_transition
      -- 	branch_block_stmt_6/bbx_xnph_xx_xpreheaderx_xpreheader
      -- 	branch_block_stmt_6/bbx_xnph_xx_xpreheaderx_xpreheader_PhiReq/$entry
      -- 	branch_block_stmt_6/bbx_xnph_xx_xpreheaderx_xpreheader_PhiReq/$exit
      -- 	branch_block_stmt_6/merge_stmt_107_PhiReqMerge
      -- 	branch_block_stmt_6/merge_stmt_107_PhiAck/$entry
      -- 	branch_block_stmt_6/merge_stmt_107_PhiAck/$exit
      -- 	branch_block_stmt_6/merge_stmt_107_PhiAck/dummy
      -- 
    if_choice_transition_404_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => if_stmt_101_branch_ack_1, ack => dct_engine_CP_0_elements(103)); -- 
    -- CP-element group 104 transition  bypass 
    -- predecessors 101 
    -- successors 105 
    -- members (1) 
      -- 	branch_block_stmt_6/if_stmt_101_else_link/$entry
      -- 
    dct_engine_CP_0_elements(104) <= dct_engine_CP_0_elements(101);
    -- CP-element group 105 fork  transition  place  input  bypass 
    -- predecessors 104 
    -- successors 179 181 
    -- members (8) 
      -- 	branch_block_stmt_6/if_stmt_101_else_link/$exit
      -- 	branch_block_stmt_6/if_stmt_101_else_link/else_choice_transition
      -- 	branch_block_stmt_6/bbx_xnph_bbx_xnph
      -- 	branch_block_stmt_6/bbx_xnph_bbx_xnph_PhiReq/$entry
      -- 	branch_block_stmt_6/bbx_xnph_bbx_xnph_PhiReq/phi_stmt_57/$entry
      -- 	branch_block_stmt_6/bbx_xnph_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/$entry
      -- 	branch_block_stmt_6/bbx_xnph_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/type_cast_60/$entry
      -- 	branch_block_stmt_6/bbx_xnph_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/type_cast_60/SplitProtocol/$entry
      -- 
    else_choice_transition_408_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => if_stmt_101_branch_ack_0, ack => dct_engine_CP_0_elements(105)); -- 
    -- CP-element group 106 fork  transition  bypass 
    -- predecessors 200 
    -- successors 117 108 111 107 
    -- members (1) 
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/$entry
      -- 
    dct_engine_CP_0_elements(106) <= dct_engine_CP_0_elements(200);
    -- CP-element group 107 transition  output  bypass 
    -- predecessors 106 
    -- successors 116 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_update_start_
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_complete/$entry
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_complete/req
      -- 
    dct_engine_CP_0_elements(107) <= dct_engine_CP_0_elements(106);
    req_462_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(107), ack => array_obj_ref_124_final_reg_req_1); -- 
    -- CP-element group 108 transition  output  bypass 
    -- predecessors 106 
    -- successors 109 
    -- members (6) 
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/R_i1x_x0_123_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/R_i1x_x0_123_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/R_i1x_x0_123_update_start_
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/R_i1x_x0_123_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_index_resize_2/$entry
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_index_resize_2/index_resize_req
      -- 
    dct_engine_CP_0_elements(108) <= dct_engine_CP_0_elements(106);
    index_resize_req_430_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(108), ack => array_obj_ref_124_index_2_resize_req_0); -- 
    -- CP-element group 109 transition  input  output  bypass 
    -- predecessors 108 
    -- successors 110 
    -- members (5) 
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_index_resized_2
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_index_resize_2/$exit
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_index_resize_2/index_resize_ack
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_index_scale_2/$entry
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_index_scale_2/scale_rename_req
      -- 
    index_resize_ack_431_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_124_index_2_resize_ack_0, ack => dct_engine_CP_0_elements(109)); -- 
    scale_rename_req_435_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(109), ack => array_obj_ref_124_index_2_rename_req_0); -- 
    -- CP-element group 110 transition  input  output  bypass 
    -- predecessors 109 
    -- successors 112 
    -- members (5) 
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_index_scaled_2
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_index_scale_2/$exit
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_index_scale_2/scale_rename_ack
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_final_index_sum_regn_Sample/$entry
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_final_index_sum_regn_Sample/req
      -- 
    scale_rename_ack_436_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_124_index_2_rename_ack_0, ack => dct_engine_CP_0_elements(110)); -- 
    req_442_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(110), ack => array_obj_ref_124_index_offset_req_0); -- 
    -- CP-element group 111 transition  output  bypass 
    -- predecessors 106 
    -- successors 113 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_final_index_sum_regn_update_start
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_final_index_sum_regn_Update/$entry
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_final_index_sum_regn_Update/req
      -- 
    dct_engine_CP_0_elements(111) <= dct_engine_CP_0_elements(106);
    req_447_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(111), ack => array_obj_ref_124_index_offset_req_1); -- 
    -- CP-element group 112 transition  input  bypass 
    -- predecessors 110 
    -- successors 120 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_final_index_sum_regn_sample_complete
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_final_index_sum_regn_Sample/$exit
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_final_index_sum_regn_Sample/ack
      -- 
    ack_443_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_124_index_offset_ack_0, ack => dct_engine_CP_0_elements(112)); -- 
    -- CP-element group 113 transition  input  output  bypass 
    -- predecessors 111 
    -- successors 114 
    -- members (5) 
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_offset_calculated
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_final_index_sum_regn_Update/$exit
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_final_index_sum_regn_Update/ack
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_base_plus_offset/$entry
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_base_plus_offset/sum_rename_req
      -- 
    ack_448_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_124_index_offset_ack_1, ack => dct_engine_CP_0_elements(113)); -- 
    sum_rename_req_452_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(113), ack => array_obj_ref_124_root_address_inst_req_0); -- 
    -- CP-element group 114 transition  input  output  bypass 
    -- predecessors 113 
    -- successors 115 
    -- members (6) 
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_root_address_calculated
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_base_plus_offset/$exit
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_base_plus_offset/sum_rename_ack
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_request/$entry
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_request/req
      -- 
    sum_rename_ack_453_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_124_root_address_inst_ack_0, ack => dct_engine_CP_0_elements(114)); -- 
    req_457_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(114), ack => array_obj_ref_124_final_reg_req_0); -- 
    -- CP-element group 115 transition  input  bypass 
    -- predecessors 114 
    -- successors 120 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_request/$exit
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_request/ack
      -- 
    ack_458_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_124_final_reg_ack_0, ack => dct_engine_CP_0_elements(115)); -- 
    -- CP-element group 116 transition  input  output  bypass 
    -- predecessors 107 
    -- successors 118 
    -- members (10) 
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_complete/$exit
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/array_obj_ref_124_complete/ack
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/type_cast_128_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/R_scevgep1_127_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/R_scevgep1_127_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/R_scevgep1_127_update_start_
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/R_scevgep1_127_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/type_cast_128_Sample/$entry
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/type_cast_128_Sample/rr
      -- 
    ack_463_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_124_final_reg_ack_1, ack => dct_engine_CP_0_elements(116)); -- 
    rr_475_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(116), ack => type_cast_128_inst_req_0); -- 
    -- CP-element group 117 transition  output  bypass 
    -- predecessors 106 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/type_cast_128_update_start_
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/type_cast_128_Update/$entry
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/type_cast_128_Update/cr
      -- 
    dct_engine_CP_0_elements(117) <= dct_engine_CP_0_elements(106);
    cr_480_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(117), ack => type_cast_128_inst_req_1); -- 
    -- CP-element group 118 transition  input  bypass 
    -- predecessors 116 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/type_cast_128_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/type_cast_128_Sample/$exit
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/type_cast_128_Sample/ra
      -- 
    ra_476_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => type_cast_128_inst_ack_0, ack => dct_engine_CP_0_elements(118)); -- 
    -- CP-element group 119 transition  input  bypass 
    -- predecessors 117 
    -- successors 120 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/type_cast_128_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/type_cast_128_Update/$exit
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/type_cast_128_Update/ca
      -- 
    ca_481_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => type_cast_128_inst_ack_1, ack => dct_engine_CP_0_elements(119)); -- 
    -- CP-element group 120 join  transition  bypass 
    -- predecessors 115 119 112 
    -- successors 6 
    -- members (1) 
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129/$exit
      -- 
    cp_element_group_120: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 20) := "cp_element_group_120"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= dct_engine_CP_0_elements(115) & dct_engine_CP_0_elements(119) & dct_engine_CP_0_elements(112);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => dct_engine_CP_0_elements(120), clk => clk, reset => reset); --
    end block;
    -- CP-element group 121 fork  transition  bypass 
    -- predecessors 6 
    -- successors 122 123 
    -- members (1) 
      -- 	branch_block_stmt_6/assign_stmt_132/$entry
      -- 
    dct_engine_CP_0_elements(121) <= dct_engine_CP_0_elements(6);
    -- CP-element group 122 transition  output  bypass 
    -- predecessors 121 
    -- successors 124 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_132/RPIPE_dct_in_data_131_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_132/RPIPE_dct_in_data_131_Sample/$entry
      -- 	branch_block_stmt_6/assign_stmt_132/RPIPE_dct_in_data_131_Sample/rr
      -- 
    dct_engine_CP_0_elements(122) <= dct_engine_CP_0_elements(121);
    rr_492_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(122), ack => RPIPE_dct_in_data_131_inst_req_0); -- 
    -- CP-element group 123 transition  output  bypass 
    -- predecessors 121 
    -- successors 125 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_132/RPIPE_dct_in_data_131_update_start_
      -- 	branch_block_stmt_6/assign_stmt_132/RPIPE_dct_in_data_131_Update/$entry
      -- 	branch_block_stmt_6/assign_stmt_132/RPIPE_dct_in_data_131_Update/cr
      -- 
    dct_engine_CP_0_elements(123) <= dct_engine_CP_0_elements(121);
    cr_497_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(123), ack => RPIPE_dct_in_data_131_inst_req_1); -- 
    -- CP-element group 124 transition  input  bypass 
    -- predecessors 122 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_132/RPIPE_dct_in_data_131_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_132/RPIPE_dct_in_data_131_Sample/$exit
      -- 	branch_block_stmt_6/assign_stmt_132/RPIPE_dct_in_data_131_Sample/ra
      -- 
    ra_493_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_dct_in_data_131_inst_ack_0, ack => dct_engine_CP_0_elements(124)); -- 
    -- CP-element group 125 transition  place  input  bypass 
    -- predecessors 123 
    -- successors 126 
    -- members (6) 
      -- 	branch_block_stmt_6/assign_stmt_132__exit__
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142__entry__
      -- 	branch_block_stmt_6/assign_stmt_132/$exit
      -- 	branch_block_stmt_6/assign_stmt_132/RPIPE_dct_in_data_131_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_132/RPIPE_dct_in_data_131_Update/$exit
      -- 	branch_block_stmt_6/assign_stmt_132/RPIPE_dct_in_data_131_Update/ca
      -- 
    ca_498_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_dct_in_data_131_inst_ack_1, ack => dct_engine_CP_0_elements(125)); -- 
    -- CP-element group 126 fork  transition  bypass 
    -- predecessors 125 
    -- successors 127 129 130 173 135 172 
    -- members (1) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/$entry
      -- 
    dct_engine_CP_0_elements(126) <= dct_engine_CP_0_elements(125);
    -- CP-element group 127 transition  bypass 
    -- predecessors 126 
    -- successors 128 
    -- members (4) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/R_iNsTr_15_135_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/R_iNsTr_15_135_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/R_iNsTr_15_135_update_start_
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/R_iNsTr_15_135_update_completed_
      -- 
    dct_engine_CP_0_elements(127) <= dct_engine_CP_0_elements(126);
    -- CP-element group 128 join  transition  output  bypass 
    -- predecessors 127 130 136 
    -- successors 153 
    -- members (4) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Sample/$entry
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Sample/ptr_deref_134_Split/$entry
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Sample/ptr_deref_134_Split/split_req
      -- 
    cp_element_group_128: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 20) := "cp_element_group_128"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= dct_engine_CP_0_elements(127) & dct_engine_CP_0_elements(130) & dct_engine_CP_0_elements(136);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => dct_engine_CP_0_elements(128), clk => clk, reset => reset); --
    end block;
    split_req_578_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(128), ack => ptr_deref_134_gather_scatter_req_0); -- 
    -- CP-element group 129 fork  transition  bypass 
    -- predecessors 126 
    -- successors 163 165 167 169 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_update_start_
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Update/$entry
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Update/word_access_complete/$entry
      -- 
    dct_engine_CP_0_elements(129) <= dct_engine_CP_0_elements(126);
    -- CP-element group 130 fork  transition  bypass 
    -- predecessors 126 
    -- successors 128 131 
    -- members (5) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_base_address_calculated
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/R_scevgep6_133_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/R_scevgep6_133_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/R_scevgep6_133_update_start_
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/R_scevgep6_133_update_completed_
      -- 
    dct_engine_CP_0_elements(130) <= dct_engine_CP_0_elements(126);
    -- CP-element group 131 transition  output  bypass 
    -- predecessors 130 
    -- successors 132 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_base_addr_resize/$entry
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_base_addr_resize/base_resize_req
      -- 
    dct_engine_CP_0_elements(131) <= dct_engine_CP_0_elements(130);
    base_resize_req_521_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(131), ack => ptr_deref_134_base_resize_req_0); -- 
    -- CP-element group 132 transition  input  output  bypass 
    -- predecessors 131 
    -- successors 133 
    -- members (5) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_base_address_resized
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_base_addr_resize/$exit
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_base_addr_resize/base_resize_ack
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_base_plus_offset/$entry
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_base_plus_offset/sum_rename_req
      -- 
    base_resize_ack_522_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_134_base_resize_ack_0, ack => dct_engine_CP_0_elements(132)); -- 
    sum_rename_req_526_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(132), ack => ptr_deref_134_root_address_inst_req_0); -- 
    -- CP-element group 133 fork  transition  input  bypass 
    -- predecessors 132 
    -- successors 137 141 145 149 
    -- members (4) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_root_address_calculated
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_base_plus_offset/$exit
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_base_plus_offset/sum_rename_ack
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_sample_start
      -- 
    sum_rename_ack_527_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_134_root_address_inst_ack_0, ack => dct_engine_CP_0_elements(133)); -- 
    -- CP-element group 134 join  transition  bypass 
    -- predecessors 138 142 146 150 
    -- successors 176 
    -- members (1) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_sample_complete
      -- 
    cp_element_group_134: block -- 
      constant place_capacities: IntegerArray(0 to 3) := (0 => 1,1 => 1,2 => 1,3 => 1);
      constant place_markings: IntegerArray(0 to 3)  := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant place_delays: IntegerArray(0 to 3) := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant joinName: string(1 to 20) := "cp_element_group_134"; 
      signal preds: BooleanArray(1 to 4); -- 
    begin -- 
      preds <= dct_engine_CP_0_elements(138) & dct_engine_CP_0_elements(142) & dct_engine_CP_0_elements(146) & dct_engine_CP_0_elements(150);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => dct_engine_CP_0_elements(134), clk => clk, reset => reset); --
    end block;
    -- CP-element group 135 fork  transition  bypass 
    -- predecessors 126 
    -- successors 139 143 147 151 
    -- members (1) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_update_start
      -- 
    dct_engine_CP_0_elements(135) <= dct_engine_CP_0_elements(126);
    -- CP-element group 136 join  transition  bypass 
    -- predecessors 140 144 148 152 
    -- successors 128 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_address_calculated
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_update_complete
      -- 
    cp_element_group_136: block -- 
      constant place_capacities: IntegerArray(0 to 3) := (0 => 1,1 => 1,2 => 1,3 => 1);
      constant place_markings: IntegerArray(0 to 3)  := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant place_delays: IntegerArray(0 to 3) := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant joinName: string(1 to 20) := "cp_element_group_136"; 
      signal preds: BooleanArray(1 to 4); -- 
    begin -- 
      preds <= dct_engine_CP_0_elements(140) & dct_engine_CP_0_elements(144) & dct_engine_CP_0_elements(148) & dct_engine_CP_0_elements(152);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => dct_engine_CP_0_elements(136), clk => clk, reset => reset); --
    end block;
    -- CP-element group 137 transition  output  bypass 
    -- predecessors 133 
    -- successors 138 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_0_Sample/$entry
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_0_Sample/rr
      -- 
    dct_engine_CP_0_elements(137) <= dct_engine_CP_0_elements(133);
    rr_535_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(137), ack => ptr_deref_134_addr_0_req_0); -- 
    -- CP-element group 138 transition  input  bypass 
    -- predecessors 137 
    -- successors 134 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_0_Sample/$exit
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_0_Sample/ra
      -- 
    ra_536_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_134_addr_0_ack_0, ack => dct_engine_CP_0_elements(138)); -- 
    -- CP-element group 139 transition  output  bypass 
    -- predecessors 135 
    -- successors 140 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_0_Update/$entry
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_0_Update/cr
      -- 
    dct_engine_CP_0_elements(139) <= dct_engine_CP_0_elements(135);
    cr_540_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(139), ack => ptr_deref_134_addr_0_req_1); -- 
    -- CP-element group 140 transition  input  bypass 
    -- predecessors 139 
    -- successors 136 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_0_Update/$exit
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_0_Update/ca
      -- 
    ca_541_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_134_addr_0_ack_1, ack => dct_engine_CP_0_elements(140)); -- 
    -- CP-element group 141 transition  output  bypass 
    -- predecessors 133 
    -- successors 142 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_1_Sample/$entry
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_1_Sample/rr
      -- 
    dct_engine_CP_0_elements(141) <= dct_engine_CP_0_elements(133);
    rr_545_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(141), ack => ptr_deref_134_addr_1_req_0); -- 
    -- CP-element group 142 transition  input  bypass 
    -- predecessors 141 
    -- successors 134 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_1_Sample/$exit
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_1_Sample/ra
      -- 
    ra_546_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_134_addr_1_ack_0, ack => dct_engine_CP_0_elements(142)); -- 
    -- CP-element group 143 transition  output  bypass 
    -- predecessors 135 
    -- successors 144 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_1_Update/$entry
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_1_Update/cr
      -- 
    dct_engine_CP_0_elements(143) <= dct_engine_CP_0_elements(135);
    cr_550_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(143), ack => ptr_deref_134_addr_1_req_1); -- 
    -- CP-element group 144 transition  input  bypass 
    -- predecessors 143 
    -- successors 136 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_1_Update/$exit
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_1_Update/ca
      -- 
    ca_551_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_134_addr_1_ack_1, ack => dct_engine_CP_0_elements(144)); -- 
    -- CP-element group 145 transition  output  bypass 
    -- predecessors 133 
    -- successors 146 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_2_Sample/$entry
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_2_Sample/rr
      -- 
    dct_engine_CP_0_elements(145) <= dct_engine_CP_0_elements(133);
    rr_555_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(145), ack => ptr_deref_134_addr_2_req_0); -- 
    -- CP-element group 146 transition  input  bypass 
    -- predecessors 145 
    -- successors 134 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_2_Sample/$exit
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_2_Sample/ra
      -- 
    ra_556_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_134_addr_2_ack_0, ack => dct_engine_CP_0_elements(146)); -- 
    -- CP-element group 147 transition  output  bypass 
    -- predecessors 135 
    -- successors 148 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_2_Update/$entry
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_2_Update/cr
      -- 
    dct_engine_CP_0_elements(147) <= dct_engine_CP_0_elements(135);
    cr_560_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(147), ack => ptr_deref_134_addr_2_req_1); -- 
    -- CP-element group 148 transition  input  bypass 
    -- predecessors 147 
    -- successors 136 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_2_Update/$exit
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_2_Update/ca
      -- 
    ca_561_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_134_addr_2_ack_1, ack => dct_engine_CP_0_elements(148)); -- 
    -- CP-element group 149 transition  output  bypass 
    -- predecessors 133 
    -- successors 150 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_3_Sample/$entry
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_3_Sample/rr
      -- 
    dct_engine_CP_0_elements(149) <= dct_engine_CP_0_elements(133);
    rr_565_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(149), ack => ptr_deref_134_addr_3_req_0); -- 
    -- CP-element group 150 transition  input  bypass 
    -- predecessors 149 
    -- successors 134 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_3_Sample/$exit
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_3_Sample/ra
      -- 
    ra_566_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_134_addr_3_ack_0, ack => dct_engine_CP_0_elements(150)); -- 
    -- CP-element group 151 transition  output  bypass 
    -- predecessors 135 
    -- successors 152 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_3_Update/$entry
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_3_Update/cr
      -- 
    dct_engine_CP_0_elements(151) <= dct_engine_CP_0_elements(135);
    cr_570_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(151), ack => ptr_deref_134_addr_3_req_1); -- 
    -- CP-element group 152 transition  input  bypass 
    -- predecessors 151 
    -- successors 136 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_3_Update/$exit
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_word_addrgen_3_Update/ca
      -- 
    ca_571_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_134_addr_3_ack_1, ack => dct_engine_CP_0_elements(152)); -- 
    -- CP-element group 153 fork  transition  input  bypass 
    -- predecessors 128 
    -- successors 154 156 158 160 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Sample/ptr_deref_134_Split/$exit
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Sample/ptr_deref_134_Split/split_ack
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Sample/word_access_start/$entry
      -- 
    split_ack_579_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_134_gather_scatter_ack_0, ack => dct_engine_CP_0_elements(153)); -- 
    -- CP-element group 154 transition  output  bypass 
    -- predecessors 153 
    -- successors 155 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Sample/word_access_start/word_0/$entry
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Sample/word_access_start/word_0/rr
      -- 
    dct_engine_CP_0_elements(154) <= dct_engine_CP_0_elements(153);
    rr_586_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(154), ack => ptr_deref_134_store_0_req_0); -- 
    -- CP-element group 155 transition  input  bypass 
    -- predecessors 154 
    -- successors 162 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Sample/word_access_start/word_0/$exit
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Sample/word_access_start/word_0/ra
      -- 
    ra_587_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_134_store_0_ack_0, ack => dct_engine_CP_0_elements(155)); -- 
    -- CP-element group 156 transition  output  bypass 
    -- predecessors 153 
    -- successors 157 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Sample/word_access_start/word_1/$entry
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Sample/word_access_start/word_1/rr
      -- 
    dct_engine_CP_0_elements(156) <= dct_engine_CP_0_elements(153);
    rr_591_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(156), ack => ptr_deref_134_store_1_req_0); -- 
    -- CP-element group 157 transition  input  bypass 
    -- predecessors 156 
    -- successors 162 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Sample/word_access_start/word_1/$exit
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Sample/word_access_start/word_1/ra
      -- 
    ra_592_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_134_store_1_ack_0, ack => dct_engine_CP_0_elements(157)); -- 
    -- CP-element group 158 transition  output  bypass 
    -- predecessors 153 
    -- successors 159 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Sample/word_access_start/word_2/$entry
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Sample/word_access_start/word_2/rr
      -- 
    dct_engine_CP_0_elements(158) <= dct_engine_CP_0_elements(153);
    rr_596_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(158), ack => ptr_deref_134_store_2_req_0); -- 
    -- CP-element group 159 transition  input  bypass 
    -- predecessors 158 
    -- successors 162 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Sample/word_access_start/word_2/$exit
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Sample/word_access_start/word_2/ra
      -- 
    ra_597_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_134_store_2_ack_0, ack => dct_engine_CP_0_elements(159)); -- 
    -- CP-element group 160 transition  output  bypass 
    -- predecessors 153 
    -- successors 161 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Sample/word_access_start/word_3/$entry
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Sample/word_access_start/word_3/rr
      -- 
    dct_engine_CP_0_elements(160) <= dct_engine_CP_0_elements(153);
    rr_601_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(160), ack => ptr_deref_134_store_3_req_0); -- 
    -- CP-element group 161 transition  input  bypass 
    -- predecessors 160 
    -- successors 162 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Sample/word_access_start/word_3/$exit
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Sample/word_access_start/word_3/ra
      -- 
    ra_602_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_134_store_3_ack_0, ack => dct_engine_CP_0_elements(161)); -- 
    -- CP-element group 162 join  transition  bypass 
    -- predecessors 155 157 159 161 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Sample/$exit
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Sample/word_access_start/$exit
      -- 
    cp_element_group_162: block -- 
      constant place_capacities: IntegerArray(0 to 3) := (0 => 1,1 => 1,2 => 1,3 => 1);
      constant place_markings: IntegerArray(0 to 3)  := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant place_delays: IntegerArray(0 to 3) := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant joinName: string(1 to 20) := "cp_element_group_162"; 
      signal preds: BooleanArray(1 to 4); -- 
    begin -- 
      preds <= dct_engine_CP_0_elements(155) & dct_engine_CP_0_elements(157) & dct_engine_CP_0_elements(159) & dct_engine_CP_0_elements(161);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => dct_engine_CP_0_elements(162), clk => clk, reset => reset); --
    end block;
    -- CP-element group 163 transition  output  bypass 
    -- predecessors 129 
    -- successors 164 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Update/word_access_complete/word_0/$entry
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Update/word_access_complete/word_0/cr
      -- 
    dct_engine_CP_0_elements(163) <= dct_engine_CP_0_elements(129);
    cr_612_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(163), ack => ptr_deref_134_store_0_req_1); -- 
    -- CP-element group 164 transition  input  bypass 
    -- predecessors 163 
    -- successors 171 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Update/word_access_complete/word_0/$exit
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Update/word_access_complete/word_0/ca
      -- 
    ca_613_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_134_store_0_ack_1, ack => dct_engine_CP_0_elements(164)); -- 
    -- CP-element group 165 transition  output  bypass 
    -- predecessors 129 
    -- successors 166 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Update/word_access_complete/word_1/$entry
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Update/word_access_complete/word_1/cr
      -- 
    dct_engine_CP_0_elements(165) <= dct_engine_CP_0_elements(129);
    cr_617_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(165), ack => ptr_deref_134_store_1_req_1); -- 
    -- CP-element group 166 transition  input  bypass 
    -- predecessors 165 
    -- successors 171 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Update/word_access_complete/word_1/$exit
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Update/word_access_complete/word_1/ca
      -- 
    ca_618_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_134_store_1_ack_1, ack => dct_engine_CP_0_elements(166)); -- 
    -- CP-element group 167 transition  output  bypass 
    -- predecessors 129 
    -- successors 168 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Update/word_access_complete/word_2/$entry
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Update/word_access_complete/word_2/cr
      -- 
    dct_engine_CP_0_elements(167) <= dct_engine_CP_0_elements(129);
    cr_622_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(167), ack => ptr_deref_134_store_2_req_1); -- 
    -- CP-element group 168 transition  input  bypass 
    -- predecessors 167 
    -- successors 171 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Update/word_access_complete/word_2/$exit
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Update/word_access_complete/word_2/ca
      -- 
    ca_623_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_134_store_2_ack_1, ack => dct_engine_CP_0_elements(168)); -- 
    -- CP-element group 169 transition  output  bypass 
    -- predecessors 129 
    -- successors 170 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Update/word_access_complete/word_3/$entry
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Update/word_access_complete/word_3/cr
      -- 
    dct_engine_CP_0_elements(169) <= dct_engine_CP_0_elements(129);
    cr_627_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(169), ack => ptr_deref_134_store_3_req_1); -- 
    -- CP-element group 170 transition  input  bypass 
    -- predecessors 169 
    -- successors 171 
    -- members (2) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Update/word_access_complete/word_3/$exit
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Update/word_access_complete/word_3/ca
      -- 
    ca_628_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_134_store_3_ack_1, ack => dct_engine_CP_0_elements(170)); -- 
    -- CP-element group 171 join  transition  bypass 
    -- predecessors 164 166 168 170 
    -- successors 176 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Update/$exit
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ptr_deref_134_Update/word_access_complete/$exit
      -- 
    cp_element_group_171: block -- 
      constant place_capacities: IntegerArray(0 to 3) := (0 => 1,1 => 1,2 => 1,3 => 1);
      constant place_markings: IntegerArray(0 to 3)  := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant place_delays: IntegerArray(0 to 3) := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant joinName: string(1 to 20) := "cp_element_group_171"; 
      signal preds: BooleanArray(1 to 4); -- 
    begin -- 
      preds <= dct_engine_CP_0_elements(164) & dct_engine_CP_0_elements(166) & dct_engine_CP_0_elements(168) & dct_engine_CP_0_elements(170);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => dct_engine_CP_0_elements(171), clk => clk, reset => reset); --
    end block;
    -- CP-element group 172 transition  output  bypass 
    -- predecessors 126 
    -- successors 175 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ADD_u32_u32_141_update_start_
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ADD_u32_u32_141_Update/$entry
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ADD_u32_u32_141_Update/cr
      -- 
    dct_engine_CP_0_elements(172) <= dct_engine_CP_0_elements(126);
    cr_645_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(172), ack => ADD_u32_u32_141_inst_req_1); -- 
    -- CP-element group 173 transition  output  bypass 
    -- predecessors 126 
    -- successors 174 
    -- members (7) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ADD_u32_u32_141_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/R_i1x_x0_138_sample_start_
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/R_i1x_x0_138_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/R_i1x_x0_138_update_start_
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/R_i1x_x0_138_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ADD_u32_u32_141_Sample/$entry
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ADD_u32_u32_141_Sample/rr
      -- 
    dct_engine_CP_0_elements(173) <= dct_engine_CP_0_elements(126);
    rr_640_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(173), ack => ADD_u32_u32_141_inst_req_0); -- 
    -- CP-element group 174 transition  input  bypass 
    -- predecessors 173 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ADD_u32_u32_141_sample_completed_
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ADD_u32_u32_141_Sample/$exit
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ADD_u32_u32_141_Sample/ra
      -- 
    ra_641_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ADD_u32_u32_141_inst_ack_0, ack => dct_engine_CP_0_elements(174)); -- 
    -- CP-element group 175 transition  input  bypass 
    -- predecessors 172 
    -- successors 176 
    -- members (3) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ADD_u32_u32_141_update_completed_
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ADD_u32_u32_141_Update/$exit
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/ADD_u32_u32_141_Update/ca
      -- 
    ca_646_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ADD_u32_u32_141_inst_ack_1, ack => dct_engine_CP_0_elements(175)); -- 
    -- CP-element group 176 join  transition  bypass 
    -- predecessors 175 134 171 
    -- successors 7 
    -- members (1) 
      -- 	branch_block_stmt_6/assign_stmt_136_to_assign_stmt_142/$exit
      -- 
    cp_element_group_176: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 20) := "cp_element_group_176"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= dct_engine_CP_0_elements(175) & dct_engine_CP_0_elements(134) & dct_engine_CP_0_elements(171);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => dct_engine_CP_0_elements(176), clk => clk, reset => reset); --
    end block;
    -- CP-element group 177 merge  place  bypass 
    -- predecessors 37 0 
    -- successors 178 
    -- members (1) 
      -- 	branch_block_stmt_6/merge_stmt_23_PhiReqMerge
      -- 
    dct_engine_CP_0_elements(177) <= OrReduce(dct_engine_CP_0_elements(37) & dct_engine_CP_0_elements(0));
    -- CP-element group 178 transition  place  bypass 
    -- predecessors 177 
    -- successors 8 
    -- members (5) 
      -- 	branch_block_stmt_6/merge_stmt_23__exit__
      -- 	branch_block_stmt_6/assign_stmt_26__entry__
      -- 	branch_block_stmt_6/merge_stmt_23_PhiAck/$entry
      -- 	branch_block_stmt_6/merge_stmt_23_PhiAck/$exit
      -- 	branch_block_stmt_6/merge_stmt_23_PhiAck/dummy
      -- 
    dct_engine_CP_0_elements(178) <= dct_engine_CP_0_elements(177);
    -- CP-element group 179 transition  output  bypass 
    -- predecessors 105 
    -- successors 180 
    -- members (2) 
      -- 	branch_block_stmt_6/bbx_xnph_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/type_cast_60/SplitProtocol/Sample/$entry
      -- 	branch_block_stmt_6/bbx_xnph_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/type_cast_60/SplitProtocol/Sample/rr
      -- 
    dct_engine_CP_0_elements(179) <= dct_engine_CP_0_elements(105);
    rr_688_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(179), ack => type_cast_60_inst_req_0); -- 
    -- CP-element group 180 transition  input  bypass 
    -- predecessors 179 
    -- successors 183 
    -- members (2) 
      -- 	branch_block_stmt_6/bbx_xnph_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/type_cast_60/SplitProtocol/Sample/$exit
      -- 	branch_block_stmt_6/bbx_xnph_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/type_cast_60/SplitProtocol/Sample/ra
      -- 
    ra_689_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => type_cast_60_inst_ack_0, ack => dct_engine_CP_0_elements(180)); -- 
    -- CP-element group 181 transition  output  bypass 
    -- predecessors 105 
    -- successors 182 
    -- members (2) 
      -- 	branch_block_stmt_6/bbx_xnph_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/type_cast_60/SplitProtocol/Update/$entry
      -- 	branch_block_stmt_6/bbx_xnph_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/type_cast_60/SplitProtocol/Update/cr
      -- 
    dct_engine_CP_0_elements(181) <= dct_engine_CP_0_elements(105);
    cr_693_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(181), ack => type_cast_60_inst_req_1); -- 
    -- CP-element group 182 transition  input  bypass 
    -- predecessors 181 
    -- successors 183 
    -- members (2) 
      -- 	branch_block_stmt_6/bbx_xnph_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/type_cast_60/SplitProtocol/Update/$exit
      -- 	branch_block_stmt_6/bbx_xnph_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/type_cast_60/SplitProtocol/Update/ca
      -- 
    ca_694_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => type_cast_60_inst_ack_1, ack => dct_engine_CP_0_elements(182)); -- 
    -- CP-element group 183 join  transition  output  bypass 
    -- predecessors 180 182 
    -- successors 187 
    -- members (6) 
      -- 	branch_block_stmt_6/bbx_xnph_bbx_xnph_PhiReq/$exit
      -- 	branch_block_stmt_6/bbx_xnph_bbx_xnph_PhiReq/phi_stmt_57/$exit
      -- 	branch_block_stmt_6/bbx_xnph_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/$exit
      -- 	branch_block_stmt_6/bbx_xnph_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/type_cast_60/$exit
      -- 	branch_block_stmt_6/bbx_xnph_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/type_cast_60/SplitProtocol/$exit
      -- 	branch_block_stmt_6/bbx_xnph_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_req
      -- 
    cp_element_group_183: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 20) := "cp_element_group_183"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= dct_engine_CP_0_elements(180) & dct_engine_CP_0_elements(182);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => dct_engine_CP_0_elements(183), clk => clk, reset => reset); --
    end block;
    phi_stmt_57_req_695_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(183), ack => phi_stmt_57_req_0); -- 
    -- CP-element group 184 transition  bypass 
    -- predecessors 2 
    -- successors 186 
    -- members (4) 
      -- 	branch_block_stmt_6/bbx_xnphx_xpreheader_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/type_cast_60/SplitProtocol/Sample/$entry
      -- 	branch_block_stmt_6/bbx_xnphx_xpreheader_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/type_cast_60/SplitProtocol/Sample/$exit
      -- 	branch_block_stmt_6/bbx_xnphx_xpreheader_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/type_cast_60/SplitProtocol/Sample/rr
      -- 	branch_block_stmt_6/bbx_xnphx_xpreheader_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/type_cast_60/SplitProtocol/Sample/ra
      -- 
    dct_engine_CP_0_elements(184) <= dct_engine_CP_0_elements(2);
    -- CP-element group 185 transition  bypass 
    -- predecessors 2 
    -- successors 186 
    -- members (4) 
      -- 	branch_block_stmt_6/bbx_xnphx_xpreheader_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/type_cast_60/SplitProtocol/Update/$entry
      -- 	branch_block_stmt_6/bbx_xnphx_xpreheader_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/type_cast_60/SplitProtocol/Update/$exit
      -- 	branch_block_stmt_6/bbx_xnphx_xpreheader_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/type_cast_60/SplitProtocol/Update/cr
      -- 	branch_block_stmt_6/bbx_xnphx_xpreheader_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/type_cast_60/SplitProtocol/Update/ca
      -- 
    dct_engine_CP_0_elements(185) <= dct_engine_CP_0_elements(2);
    -- CP-element group 186 join  transition  output  bypass 
    -- predecessors 184 185 
    -- successors 187 
    -- members (6) 
      -- 	branch_block_stmt_6/bbx_xnphx_xpreheader_bbx_xnph_PhiReq/$exit
      -- 	branch_block_stmt_6/bbx_xnphx_xpreheader_bbx_xnph_PhiReq/phi_stmt_57/$exit
      -- 	branch_block_stmt_6/bbx_xnphx_xpreheader_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/$exit
      -- 	branch_block_stmt_6/bbx_xnphx_xpreheader_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/type_cast_60/$exit
      -- 	branch_block_stmt_6/bbx_xnphx_xpreheader_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_sources/type_cast_60/SplitProtocol/$exit
      -- 	branch_block_stmt_6/bbx_xnphx_xpreheader_bbx_xnph_PhiReq/phi_stmt_57/phi_stmt_57_req
      -- 
    cp_element_group_186: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 20) := "cp_element_group_186"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= dct_engine_CP_0_elements(184) & dct_engine_CP_0_elements(185);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => dct_engine_CP_0_elements(186), clk => clk, reset => reset); --
    end block;
    phi_stmt_57_req_721_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(186), ack => phi_stmt_57_req_1); -- 
    -- CP-element group 187 merge  place  bypass 
    -- predecessors 183 186 
    -- successors 188 
    -- members (1) 
      -- 	branch_block_stmt_6/merge_stmt_56_PhiReqMerge
      -- 
    dct_engine_CP_0_elements(187) <= OrReduce(dct_engine_CP_0_elements(183) & dct_engine_CP_0_elements(186));
    -- CP-element group 188 transition  bypass 
    -- predecessors 187 
    -- successors 189 
    -- members (1) 
      -- 	branch_block_stmt_6/merge_stmt_56_PhiAck/$entry
      -- 
    dct_engine_CP_0_elements(188) <= dct_engine_CP_0_elements(187);
    -- CP-element group 189 transition  place  input  bypass 
    -- predecessors 188 
    -- successors 38 
    -- members (4) 
      -- 	branch_block_stmt_6/merge_stmt_56__exit__
      -- 	branch_block_stmt_6/assign_stmt_70_to_assign_stmt_81__entry__
      -- 	branch_block_stmt_6/merge_stmt_56_PhiAck/$exit
      -- 	branch_block_stmt_6/merge_stmt_56_PhiAck/phi_stmt_57_ack
      -- 
    phi_stmt_57_ack_726_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_57_ack_0, ack => dct_engine_CP_0_elements(189)); -- 
    -- CP-element group 190 transition  output  bypass 
    -- predecessors 7 
    -- successors 191 
    -- members (2) 
      -- 	branch_block_stmt_6/xx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/type_cast_113/SplitProtocol/Sample/$entry
      -- 	branch_block_stmt_6/xx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/type_cast_113/SplitProtocol/Sample/rr
      -- 
    dct_engine_CP_0_elements(190) <= dct_engine_CP_0_elements(7);
    rr_757_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(190), ack => type_cast_113_inst_req_0); -- 
    -- CP-element group 191 transition  input  bypass 
    -- predecessors 190 
    -- successors 194 
    -- members (2) 
      -- 	branch_block_stmt_6/xx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/type_cast_113/SplitProtocol/Sample/$exit
      -- 	branch_block_stmt_6/xx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/type_cast_113/SplitProtocol/Sample/ra
      -- 
    ra_758_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => type_cast_113_inst_ack_0, ack => dct_engine_CP_0_elements(191)); -- 
    -- CP-element group 192 transition  output  bypass 
    -- predecessors 7 
    -- successors 193 
    -- members (2) 
      -- 	branch_block_stmt_6/xx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/type_cast_113/SplitProtocol/Update/$entry
      -- 	branch_block_stmt_6/xx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/type_cast_113/SplitProtocol/Update/cr
      -- 
    dct_engine_CP_0_elements(192) <= dct_engine_CP_0_elements(7);
    cr_762_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(192), ack => type_cast_113_inst_req_1); -- 
    -- CP-element group 193 transition  input  bypass 
    -- predecessors 192 
    -- successors 194 
    -- members (2) 
      -- 	branch_block_stmt_6/xx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/type_cast_113/SplitProtocol/Update/$exit
      -- 	branch_block_stmt_6/xx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/type_cast_113/SplitProtocol/Update/ca
      -- 
    ca_763_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => type_cast_113_inst_ack_1, ack => dct_engine_CP_0_elements(193)); -- 
    -- CP-element group 194 join  transition  output  bypass 
    -- predecessors 191 193 
    -- successors 198 
    -- members (6) 
      -- 	branch_block_stmt_6/xx_xpreheader_xx_xpreheader_PhiReq/$exit
      -- 	branch_block_stmt_6/xx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/$exit
      -- 	branch_block_stmt_6/xx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/$exit
      -- 	branch_block_stmt_6/xx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/type_cast_113/$exit
      -- 	branch_block_stmt_6/xx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/type_cast_113/SplitProtocol/$exit
      -- 	branch_block_stmt_6/xx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_req
      -- 
    cp_element_group_194: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 20) := "cp_element_group_194"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= dct_engine_CP_0_elements(191) & dct_engine_CP_0_elements(193);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => dct_engine_CP_0_elements(194), clk => clk, reset => reset); --
    end block;
    phi_stmt_110_req_764_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(194), ack => phi_stmt_110_req_0); -- 
    -- CP-element group 195 transition  bypass 
    -- predecessors 5 
    -- successors 197 
    -- members (4) 
      -- 	branch_block_stmt_6/xx_xpreheaderx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/type_cast_113/SplitProtocol/Sample/$entry
      -- 	branch_block_stmt_6/xx_xpreheaderx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/type_cast_113/SplitProtocol/Sample/$exit
      -- 	branch_block_stmt_6/xx_xpreheaderx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/type_cast_113/SplitProtocol/Sample/rr
      -- 	branch_block_stmt_6/xx_xpreheaderx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/type_cast_113/SplitProtocol/Sample/ra
      -- 
    dct_engine_CP_0_elements(195) <= dct_engine_CP_0_elements(5);
    -- CP-element group 196 transition  bypass 
    -- predecessors 5 
    -- successors 197 
    -- members (4) 
      -- 	branch_block_stmt_6/xx_xpreheaderx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/type_cast_113/SplitProtocol/Update/ca
      -- 	branch_block_stmt_6/xx_xpreheaderx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/type_cast_113/SplitProtocol/Update/$entry
      -- 	branch_block_stmt_6/xx_xpreheaderx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/type_cast_113/SplitProtocol/Update/$exit
      -- 	branch_block_stmt_6/xx_xpreheaderx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/type_cast_113/SplitProtocol/Update/cr
      -- 
    dct_engine_CP_0_elements(196) <= dct_engine_CP_0_elements(5);
    -- CP-element group 197 join  transition  output  bypass 
    -- predecessors 195 196 
    -- successors 198 
    -- members (6) 
      -- 	branch_block_stmt_6/xx_xpreheaderx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_req
      -- 	branch_block_stmt_6/xx_xpreheaderx_xpreheader_xx_xpreheader_PhiReq/$exit
      -- 	branch_block_stmt_6/xx_xpreheaderx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/$exit
      -- 	branch_block_stmt_6/xx_xpreheaderx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/$exit
      -- 	branch_block_stmt_6/xx_xpreheaderx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/type_cast_113/$exit
      -- 	branch_block_stmt_6/xx_xpreheaderx_xpreheader_xx_xpreheader_PhiReq/phi_stmt_110/phi_stmt_110_sources/type_cast_113/SplitProtocol/$exit
      -- 
    cp_element_group_197: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 20) := "cp_element_group_197"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= dct_engine_CP_0_elements(195) & dct_engine_CP_0_elements(196);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => dct_engine_CP_0_elements(197), clk => clk, reset => reset); --
    end block;
    phi_stmt_110_req_790_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => dct_engine_CP_0_elements(197), ack => phi_stmt_110_req_1); -- 
    -- CP-element group 198 merge  place  bypass 
    -- predecessors 194 197 
    -- successors 199 
    -- members (1) 
      -- 	branch_block_stmt_6/merge_stmt_109_PhiReqMerge
      -- 
    dct_engine_CP_0_elements(198) <= OrReduce(dct_engine_CP_0_elements(194) & dct_engine_CP_0_elements(197));
    -- CP-element group 199 transition  bypass 
    -- predecessors 198 
    -- successors 200 
    -- members (1) 
      -- 	branch_block_stmt_6/merge_stmt_109_PhiAck/$entry
      -- 
    dct_engine_CP_0_elements(199) <= dct_engine_CP_0_elements(198);
    -- CP-element group 200 transition  place  input  bypass 
    -- predecessors 199 
    -- successors 106 
    -- members (4) 
      -- 	branch_block_stmt_6/merge_stmt_109__exit__
      -- 	branch_block_stmt_6/assign_stmt_125_to_assign_stmt_129__entry__
      -- 	branch_block_stmt_6/merge_stmt_109_PhiAck/$exit
      -- 	branch_block_stmt_6/merge_stmt_109_PhiAck/phi_stmt_110_ack
      -- 
    phi_stmt_110_ack_795_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_110_ack_0, ack => dct_engine_CP_0_elements(200)); -- 
    --  hookup: inputs to control-path 
    -- hookup: output from control-path 
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal R_i1x_x0_123_resized : std_logic_vector(8 downto 0);
    signal R_i1x_x0_123_scaled : std_logic_vector(8 downto 0);
    signal R_tmp4_74_resized : std_logic_vector(4 downto 0);
    signal R_tmp4_74_scaled : std_logic_vector(4 downto 0);
    signal array_obj_ref_124_constant_part_of_offset : std_logic_vector(8 downto 0);
    signal array_obj_ref_124_final_offset : std_logic_vector(8 downto 0);
    signal array_obj_ref_124_offset_scale_factor_0 : std_logic_vector(8 downto 0);
    signal array_obj_ref_124_offset_scale_factor_1 : std_logic_vector(8 downto 0);
    signal array_obj_ref_124_offset_scale_factor_2 : std_logic_vector(8 downto 0);
    signal array_obj_ref_124_resized_base_address : std_logic_vector(8 downto 0);
    signal array_obj_ref_124_root_address : std_logic_vector(8 downto 0);
    signal array_obj_ref_75_constant_part_of_offset : std_logic_vector(4 downto 0);
    signal array_obj_ref_75_final_offset : std_logic_vector(4 downto 0);
    signal array_obj_ref_75_offset_scale_factor_0 : std_logic_vector(4 downto 0);
    signal array_obj_ref_75_offset_scale_factor_1 : std_logic_vector(4 downto 0);
    signal array_obj_ref_75_resized_base_address : std_logic_vector(4 downto 0);
    signal array_obj_ref_75_root_address : std_logic_vector(4 downto 0);
    signal cond_36 : std_logic_vector(0 downto 0);
    signal dct_17 : std_logic_vector(31 downto 0);
    signal exitcond3_100 : std_logic_vector(0 downto 0);
    signal i1x_x0_110 : std_logic_vector(31 downto 0);
    signal iNsTr_11_94 : std_logic_vector(31 downto 0);
    signal iNsTr_15_132 : std_logic_vector(31 downto 0);
    signal iNsTr_17_142 : std_logic_vector(31 downto 0);
    signal iNsTr_2_26 : std_logic_vector(31 downto 0);
    signal iNsTr_4_29 : std_logic_vector(31 downto 0);
    signal iNsTr_5_42 : std_logic_vector(0 downto 0);
    signal iNsTr_9_84 : std_logic_vector(31 downto 0);
    signal ix_x05_57 : std_logic_vector(31 downto 0);
    signal orx_xcond_47 : std_logic_vector(0 downto 0);
    signal pix1_21 : std_logic_vector(31 downto 0);
    signal ptr_deref_134_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_134_data_1 : std_logic_vector(7 downto 0);
    signal ptr_deref_134_data_2 : std_logic_vector(7 downto 0);
    signal ptr_deref_134_data_3 : std_logic_vector(7 downto 0);
    signal ptr_deref_134_resized_base_address : std_logic_vector(8 downto 0);
    signal ptr_deref_134_root_address : std_logic_vector(8 downto 0);
    signal ptr_deref_134_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_134_word_address_0 : std_logic_vector(8 downto 0);
    signal ptr_deref_134_word_address_1 : std_logic_vector(8 downto 0);
    signal ptr_deref_134_word_address_2 : std_logic_vector(8 downto 0);
    signal ptr_deref_134_word_address_3 : std_logic_vector(8 downto 0);
    signal ptr_deref_134_word_offset_0 : std_logic_vector(8 downto 0);
    signal ptr_deref_134_word_offset_1 : std_logic_vector(8 downto 0);
    signal ptr_deref_134_word_offset_2 : std_logic_vector(8 downto 0);
    signal ptr_deref_134_word_offset_3 : std_logic_vector(8 downto 0);
    signal ptr_deref_86_data_0 : std_logic_vector(15 downto 0);
    signal ptr_deref_86_data_1 : std_logic_vector(15 downto 0);
    signal ptr_deref_86_resized_base_address : std_logic_vector(4 downto 0);
    signal ptr_deref_86_root_address : std_logic_vector(4 downto 0);
    signal ptr_deref_86_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_86_word_address_0 : std_logic_vector(4 downto 0);
    signal ptr_deref_86_word_address_1 : std_logic_vector(4 downto 0);
    signal ptr_deref_86_word_offset_0 : std_logic_vector(4 downto 0);
    signal ptr_deref_86_word_offset_1 : std_logic_vector(4 downto 0);
    signal scevgep1_125 : std_logic_vector(31 downto 0);
    signal scevgep6_129 : std_logic_vector(31 downto 0);
    signal scevgep78_81 : std_logic_vector(31 downto 0);
    signal scevgep_76 : std_logic_vector(31 downto 0);
    signal tmp4_70 : std_logic_vector(31 downto 0);
    signal type_cast_113_wire : std_logic_vector(31 downto 0);
    signal type_cast_116_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_140_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_33_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_40_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_60_wire : std_logic_vector(31 downto 0);
    signal type_cast_63_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_68_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_92_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_98_wire_constant : std_logic_vector(31 downto 0);
    signal xxdct_enginexxbodyxxdct_alloc_base_address : std_logic_vector(4 downto 0);
    signal xxdct_enginexxbodyxxpix1_alloc_base_address : std_logic_vector(8 downto 0);
    -- 
  begin -- 
    array_obj_ref_124_constant_part_of_offset <= "000000000";
    array_obj_ref_124_offset_scale_factor_0 <= "100000000";
    array_obj_ref_124_offset_scale_factor_1 <= "000010000";
    array_obj_ref_124_offset_scale_factor_2 <= "000000001";
    array_obj_ref_124_resized_base_address <= "000000000";
    array_obj_ref_75_constant_part_of_offset <= "00000";
    array_obj_ref_75_offset_scale_factor_0 <= "10000";
    array_obj_ref_75_offset_scale_factor_1 <= "00001";
    array_obj_ref_75_resized_base_address <= "00000";
    dct_17 <= "00000000000000000000000000000000";
    pix1_21 <= "00000000000000000000000000000000";
    ptr_deref_134_word_offset_0 <= "000000000";
    ptr_deref_134_word_offset_1 <= "000000001";
    ptr_deref_134_word_offset_2 <= "000000010";
    ptr_deref_134_word_offset_3 <= "000000011";
    ptr_deref_86_word_offset_0 <= "00000";
    ptr_deref_86_word_offset_1 <= "00001";
    type_cast_116_wire_constant <= "00000000000000000000000000000000";
    type_cast_140_wire_constant <= "00000000000000000000000000000001";
    type_cast_33_wire_constant <= "00000000000000000000000000000011";
    type_cast_40_wire_constant <= "00000000000000000000000000111000";
    type_cast_63_wire_constant <= "00000000000000000000000000000000";
    type_cast_68_wire_constant <= "00000000000000000000000000000010";
    type_cast_92_wire_constant <= "00000000000000000000000000000001";
    type_cast_98_wire_constant <= "00000000000000000000000000010000";
    xxdct_enginexxbodyxxdct_alloc_base_address <= "00000";
    xxdct_enginexxbodyxxpix1_alloc_base_address <= "000000000";
    phi_stmt_110: Block -- phi operator 
      signal idata: std_logic_vector(63 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_113_wire & type_cast_116_wire_constant;
      req <= phi_stmt_110_req_0 & phi_stmt_110_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 32) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_110_ack_0,
          idata => idata,
          odata => i1x_x0_110,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_110
    phi_stmt_57: Block -- phi operator 
      signal idata: std_logic_vector(63 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_60_wire & type_cast_63_wire_constant;
      req <= phi_stmt_57_req_0 & phi_stmt_57_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 32) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_57_ack_0,
          idata => idata,
          odata => ix_x05_57,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_57
    array_obj_ref_124_final_reg_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= array_obj_ref_124_final_reg_req_0;
      array_obj_ref_124_final_reg_ack_0<= wack(0);
      rreq(0) <= array_obj_ref_124_final_reg_req_1;
      array_obj_ref_124_final_reg_ack_1<= rack(0);
      array_obj_ref_124_final_reg : InterlockBuffer generic map ( -- 
        name => "array_obj_ref_124_final_reg",
        buffer_size => 1,
        flow_through =>  false ,
        in_data_width => 9,
        out_data_width => 32
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => array_obj_ref_124_root_address,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => scevgep1_125,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    array_obj_ref_75_final_reg_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= array_obj_ref_75_final_reg_req_0;
      array_obj_ref_75_final_reg_ack_0<= wack(0);
      rreq(0) <= array_obj_ref_75_final_reg_req_1;
      array_obj_ref_75_final_reg_ack_1<= rack(0);
      array_obj_ref_75_final_reg : InterlockBuffer generic map ( -- 
        name => "array_obj_ref_75_final_reg",
        buffer_size => 1,
        flow_through =>  false ,
        in_data_width => 5,
        out_data_width => 32
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => array_obj_ref_75_root_address,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => scevgep_76,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    type_cast_113_inst_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= type_cast_113_inst_req_0;
      type_cast_113_inst_ack_0<= wack(0);
      rreq(0) <= type_cast_113_inst_req_1;
      type_cast_113_inst_ack_1<= rack(0);
      type_cast_113_inst : InterlockBuffer generic map ( -- 
        name => "type_cast_113_inst",
        buffer_size => 1,
        flow_through =>  false ,
        in_data_width => 32,
        out_data_width => 32
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => iNsTr_17_142,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => type_cast_113_wire,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    type_cast_128_inst_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= type_cast_128_inst_req_0;
      type_cast_128_inst_ack_0<= wack(0);
      rreq(0) <= type_cast_128_inst_req_1;
      type_cast_128_inst_ack_1<= rack(0);
      type_cast_128_inst : InterlockBuffer generic map ( -- 
        name => "type_cast_128_inst",
        buffer_size => 1,
        flow_through =>  false ,
        in_data_width => 32,
        out_data_width => 32
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => scevgep1_125,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => scevgep6_129,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    type_cast_60_inst_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= type_cast_60_inst_req_0;
      type_cast_60_inst_ack_0<= wack(0);
      rreq(0) <= type_cast_60_inst_req_1;
      type_cast_60_inst_ack_1<= rack(0);
      type_cast_60_inst : InterlockBuffer generic map ( -- 
        name => "type_cast_60_inst",
        buffer_size => 1,
        flow_through =>  false ,
        in_data_width => 32,
        out_data_width => 32
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => iNsTr_11_94,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => type_cast_60_wire,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    type_cast_80_inst_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= type_cast_80_inst_req_0;
      type_cast_80_inst_ack_0<= wack(0);
      rreq(0) <= type_cast_80_inst_req_1;
      type_cast_80_inst_ack_1<= rack(0);
      type_cast_80_inst : InterlockBuffer generic map ( -- 
        name => "type_cast_80_inst",
        buffer_size => 1,
        flow_through =>  false ,
        in_data_width => 32,
        out_data_width => 32
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => scevgep_76,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => scevgep78_81,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    array_obj_ref_124_index_2_rename: Block -- 
      signal in_aggregated_sig: std_logic_vector(8 downto 0);
      signal out_aggregated_sig: std_logic_vector(8 downto 0);
      --
    begin -- 
      array_obj_ref_124_index_2_rename_ack_0 <= array_obj_ref_124_index_2_rename_req_0;
      in_aggregated_sig <= R_i1x_x0_123_resized;
      out_aggregated_sig <= in_aggregated_sig;
      R_i1x_x0_123_scaled <= out_aggregated_sig(8 downto 0);
      --
    end Block;
    array_obj_ref_124_index_2_resize: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(8 downto 0);
      --
    begin -- 
      array_obj_ref_124_index_2_resize_ack_0 <= array_obj_ref_124_index_2_resize_req_0;
      in_aggregated_sig <= i1x_x0_110;
      out_aggregated_sig <= in_aggregated_sig(8 downto 0);
      R_i1x_x0_123_resized <= out_aggregated_sig(8 downto 0);
      --
    end Block;
    array_obj_ref_124_root_address_inst: Block -- 
      signal in_aggregated_sig: std_logic_vector(8 downto 0);
      signal out_aggregated_sig: std_logic_vector(8 downto 0);
      --
    begin -- 
      array_obj_ref_124_root_address_inst_ack_0 <= array_obj_ref_124_root_address_inst_req_0;
      in_aggregated_sig <= array_obj_ref_124_final_offset;
      out_aggregated_sig <= in_aggregated_sig;
      array_obj_ref_124_root_address <= out_aggregated_sig(8 downto 0);
      --
    end Block;
    array_obj_ref_75_index_1_rename: Block -- 
      signal in_aggregated_sig: std_logic_vector(4 downto 0);
      signal out_aggregated_sig: std_logic_vector(4 downto 0);
      --
    begin -- 
      array_obj_ref_75_index_1_rename_ack_0 <= array_obj_ref_75_index_1_rename_req_0;
      in_aggregated_sig <= R_tmp4_74_resized;
      out_aggregated_sig <= in_aggregated_sig;
      R_tmp4_74_scaled <= out_aggregated_sig(4 downto 0);
      --
    end Block;
    array_obj_ref_75_index_1_resize: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(4 downto 0);
      --
    begin -- 
      array_obj_ref_75_index_1_resize_ack_0 <= array_obj_ref_75_index_1_resize_req_0;
      in_aggregated_sig <= tmp4_70;
      out_aggregated_sig <= in_aggregated_sig(4 downto 0);
      R_tmp4_74_resized <= out_aggregated_sig(4 downto 0);
      --
    end Block;
    array_obj_ref_75_root_address_inst: Block -- 
      signal in_aggregated_sig: std_logic_vector(4 downto 0);
      signal out_aggregated_sig: std_logic_vector(4 downto 0);
      --
    begin -- 
      array_obj_ref_75_root_address_inst_ack_0 <= array_obj_ref_75_root_address_inst_req_0;
      in_aggregated_sig <= array_obj_ref_75_final_offset;
      out_aggregated_sig <= in_aggregated_sig;
      array_obj_ref_75_root_address <= out_aggregated_sig(4 downto 0);
      --
    end Block;
    ptr_deref_134_base_resize: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(8 downto 0);
      --
    begin -- 
      ptr_deref_134_base_resize_ack_0 <= ptr_deref_134_base_resize_req_0;
      in_aggregated_sig <= scevgep6_129;
      out_aggregated_sig <= in_aggregated_sig(8 downto 0);
      ptr_deref_134_resized_base_address <= out_aggregated_sig(8 downto 0);
      --
    end Block;
    ptr_deref_134_gather_scatter: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(31 downto 0);
      --
    begin -- 
      ptr_deref_134_gather_scatter_ack_0 <= ptr_deref_134_gather_scatter_req_0;
      in_aggregated_sig <= iNsTr_15_132;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_134_data_3 <= out_aggregated_sig(31 downto 24);
      ptr_deref_134_data_2 <= out_aggregated_sig(23 downto 16);
      ptr_deref_134_data_1 <= out_aggregated_sig(15 downto 8);
      ptr_deref_134_data_0 <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_134_root_address_inst: Block -- 
      signal in_aggregated_sig: std_logic_vector(8 downto 0);
      signal out_aggregated_sig: std_logic_vector(8 downto 0);
      --
    begin -- 
      ptr_deref_134_root_address_inst_ack_0 <= ptr_deref_134_root_address_inst_req_0;
      in_aggregated_sig <= ptr_deref_134_resized_base_address;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_134_root_address <= out_aggregated_sig(8 downto 0);
      --
    end Block;
    ptr_deref_86_base_resize: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(4 downto 0);
      --
    begin -- 
      ptr_deref_86_base_resize_ack_0 <= ptr_deref_86_base_resize_req_0;
      in_aggregated_sig <= scevgep78_81;
      out_aggregated_sig <= in_aggregated_sig(4 downto 0);
      ptr_deref_86_resized_base_address <= out_aggregated_sig(4 downto 0);
      --
    end Block;
    ptr_deref_86_gather_scatter: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(31 downto 0);
      --
    begin -- 
      ptr_deref_86_gather_scatter_ack_0 <= ptr_deref_86_gather_scatter_req_0;
      in_aggregated_sig <= iNsTr_9_84;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_86_data_1 <= out_aggregated_sig(31 downto 16);
      ptr_deref_86_data_0 <= out_aggregated_sig(15 downto 0);
      --
    end Block;
    ptr_deref_86_root_address_inst: Block -- 
      signal in_aggregated_sig: std_logic_vector(4 downto 0);
      signal out_aggregated_sig: std_logic_vector(4 downto 0);
      --
    begin -- 
      ptr_deref_86_root_address_inst_ack_0 <= ptr_deref_86_root_address_inst_req_0;
      in_aggregated_sig <= ptr_deref_86_resized_base_address;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_86_root_address <= out_aggregated_sig(4 downto 0);
      --
    end Block;
    if_stmt_101_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= exitcond3_100;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_101_branch_req_0,
          ack0 => if_stmt_101_branch_ack_0,
          ack1 => if_stmt_101_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    if_stmt_48_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= orx_xcond_47;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_48_branch_req_0,
          ack0 => if_stmt_48_branch_ack_0,
          ack1 => if_stmt_48_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- shared split operator group (0) : ADD_u32_u32_141_inst 
    ApIntAdd_group_0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 1);
      -- 
    begin -- 
      data_in <= i1x_x0_110;
      iNsTr_17_142 <= data_out(31 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= ADD_u32_u32_141_inst_req_0;
      ADD_u32_u32_141_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= ADD_u32_u32_141_inst_req_1;
      ADD_u32_u32_141_inst_ack_1 <= ackR_unguarded(0);
      gI: SplitGuardInterface generic map(nreqs => 1, buffering => guardBuffering, use_guards => guardFlags) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      UnsharedOperator: UnsharedOperatorWithBuffering -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          name => "ApIntAdd_group_0",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 32,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 32,
          constant_operand => "00000000000000000000000000000001",
          constant_width => 32,
          buffering  => 1,
          flow_through => false,
          use_constant  => true
          --
        ) 
        port map ( -- 
          reqL => reqL(0),
          ackL => ackL(0),
          reqR => reqR(0),
          ackR => ackR(0),
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared split operator group (1) : ADD_u32_u32_93_inst 
    ApIntAdd_group_1: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 1);
      -- 
    begin -- 
      data_in <= ix_x05_57;
      iNsTr_11_94 <= data_out(31 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= ADD_u32_u32_93_inst_req_0;
      ADD_u32_u32_93_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= ADD_u32_u32_93_inst_req_1;
      ADD_u32_u32_93_inst_ack_1 <= ackR_unguarded(0);
      gI: SplitGuardInterface generic map(nreqs => 1, buffering => guardBuffering, use_guards => guardFlags) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      UnsharedOperator: UnsharedOperatorWithBuffering -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          name => "ApIntAdd_group_1",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 32,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 32,
          constant_operand => "00000000000000000000000000000001",
          constant_width => 32,
          buffering  => 1,
          flow_through => false,
          use_constant  => true
          --
        ) 
        port map ( -- 
          reqL => reqL(0),
          ackL => ackL(0),
          reqR => reqR(0),
          ackR => ackR(0),
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 1
    -- shared split operator group (2) : AND_u1_u1_46_inst 
    ApIntAnd_group_2: Block -- 
      signal data_in: std_logic_vector(1 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 1);
      -- 
    begin -- 
      data_in <= cond_36 & iNsTr_5_42;
      orx_xcond_47 <= data_out(0 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= AND_u1_u1_46_inst_req_0;
      AND_u1_u1_46_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= AND_u1_u1_46_inst_req_1;
      AND_u1_u1_46_inst_ack_1 <= ackR_unguarded(0);
      gI: SplitGuardInterface generic map(nreqs => 1, buffering => guardBuffering, use_guards => guardFlags) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      UnsharedOperator: UnsharedOperatorWithBuffering -- 
        generic map ( -- 
          operator_id => "ApIntAnd",
          name => "ApIntAnd_group_2",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 1,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 1, 
          num_inputs    => 2,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 1,
          constant_operand => "0",
          constant_width => 1,
          buffering  => 1,
          flow_through => false,
          use_constant  => false
          --
        ) 
        port map ( -- 
          reqL => reqL(0),
          ackL => ackL(0),
          reqR => reqR(0),
          ackR => ackR(0),
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 2
    -- shared split operator group (3) : EQ_u32_u1_34_inst 
    ApIntEq_group_3: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 1);
      -- 
    begin -- 
      data_in <= iNsTr_2_26;
      cond_36 <= data_out(0 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= EQ_u32_u1_34_inst_req_0;
      EQ_u32_u1_34_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= EQ_u32_u1_34_inst_req_1;
      EQ_u32_u1_34_inst_ack_1 <= ackR_unguarded(0);
      gI: SplitGuardInterface generic map(nreqs => 1, buffering => guardBuffering, use_guards => guardFlags) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      UnsharedOperator: UnsharedOperatorWithBuffering -- 
        generic map ( -- 
          operator_id => "ApIntEq",
          name => "ApIntEq_group_3",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 32,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 1,
          constant_operand => "00000000000000000000000000000011",
          constant_width => 32,
          buffering  => 1,
          flow_through => false,
          use_constant  => true
          --
        ) 
        port map ( -- 
          reqL => reqL(0),
          ackL => ackL(0),
          reqR => reqR(0),
          ackR => ackR(0),
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 3
    -- shared split operator group (4) : EQ_u32_u1_41_inst 
    ApIntEq_group_4: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 1);
      -- 
    begin -- 
      data_in <= iNsTr_4_29;
      iNsTr_5_42 <= data_out(0 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= EQ_u32_u1_41_inst_req_0;
      EQ_u32_u1_41_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= EQ_u32_u1_41_inst_req_1;
      EQ_u32_u1_41_inst_ack_1 <= ackR_unguarded(0);
      gI: SplitGuardInterface generic map(nreqs => 1, buffering => guardBuffering, use_guards => guardFlags) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      UnsharedOperator: UnsharedOperatorWithBuffering -- 
        generic map ( -- 
          operator_id => "ApIntEq",
          name => "ApIntEq_group_4",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 32,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 1,
          constant_operand => "00000000000000000000000000111000",
          constant_width => 32,
          buffering  => 1,
          flow_through => false,
          use_constant  => true
          --
        ) 
        port map ( -- 
          reqL => reqL(0),
          ackL => ackL(0),
          reqR => reqR(0),
          ackR => ackR(0),
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 4
    -- shared split operator group (5) : EQ_u32_u1_99_inst 
    ApIntEq_group_5: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 1);
      -- 
    begin -- 
      data_in <= iNsTr_11_94;
      exitcond3_100 <= data_out(0 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= EQ_u32_u1_99_inst_req_0;
      EQ_u32_u1_99_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= EQ_u32_u1_99_inst_req_1;
      EQ_u32_u1_99_inst_ack_1 <= ackR_unguarded(0);
      gI: SplitGuardInterface generic map(nreqs => 1, buffering => guardBuffering, use_guards => guardFlags) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      UnsharedOperator: UnsharedOperatorWithBuffering -- 
        generic map ( -- 
          operator_id => "ApIntEq",
          name => "ApIntEq_group_5",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 32,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 1,
          constant_operand => "00000000000000000000000000010000",
          constant_width => 32,
          buffering  => 1,
          flow_through => false,
          use_constant  => true
          --
        ) 
        port map ( -- 
          reqL => reqL(0),
          ackL => ackL(0),
          reqR => reqR(0),
          ackR => ackR(0),
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 5
    -- shared split operator group (6) : MUL_u32_u32_69_inst 
    ApIntMul_group_6: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 1);
      -- 
    begin -- 
      data_in <= ix_x05_57;
      tmp4_70 <= data_out(31 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= MUL_u32_u32_69_inst_req_0;
      MUL_u32_u32_69_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= MUL_u32_u32_69_inst_req_1;
      MUL_u32_u32_69_inst_ack_1 <= ackR_unguarded(0);
      gI: SplitGuardInterface generic map(nreqs => 1, buffering => guardBuffering, use_guards => guardFlags) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      UnsharedOperator: UnsharedOperatorWithBuffering -- 
        generic map ( -- 
          operator_id => "ApIntMul",
          name => "ApIntMul_group_6",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 32,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 32,
          constant_operand => "00000000000000000000000000000010",
          constant_width => 32,
          buffering  => 1,
          flow_through => false,
          use_constant  => true
          --
        ) 
        port map ( -- 
          reqL => reqL(0),
          ackL => ackL(0),
          reqR => reqR(0),
          ackR => ackR(0),
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 6
    -- shared split operator group (7) : array_obj_ref_124_index_offset 
    ApIntAdd_group_7: Block -- 
      signal data_in: std_logic_vector(8 downto 0);
      signal data_out: std_logic_vector(8 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 1);
      -- 
    begin -- 
      data_in <= R_i1x_x0_123_scaled;
      array_obj_ref_124_final_offset <= data_out(8 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= array_obj_ref_124_index_offset_req_0;
      array_obj_ref_124_index_offset_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= array_obj_ref_124_index_offset_req_1;
      array_obj_ref_124_index_offset_ack_1 <= ackR_unguarded(0);
      gI: SplitGuardInterface generic map(nreqs => 1, buffering => guardBuffering, use_guards => guardFlags) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      UnsharedOperator: UnsharedOperatorWithBuffering -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          name => "ApIntAdd_group_7",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 9,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 9,
          constant_operand => "000000000",
          constant_width => 9,
          buffering  => 1,
          flow_through => false,
          use_constant  => true
          --
        ) 
        port map ( -- 
          reqL => reqL(0),
          ackL => ackL(0),
          reqR => reqR(0),
          ackR => ackR(0),
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 7
    -- shared split operator group (8) : array_obj_ref_75_index_offset 
    ApIntAdd_group_8: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(4 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 1);
      -- 
    begin -- 
      data_in <= R_tmp4_74_scaled;
      array_obj_ref_75_final_offset <= data_out(4 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= array_obj_ref_75_index_offset_req_0;
      array_obj_ref_75_index_offset_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= array_obj_ref_75_index_offset_req_1;
      array_obj_ref_75_index_offset_ack_1 <= ackR_unguarded(0);
      gI: SplitGuardInterface generic map(nreqs => 1, buffering => guardBuffering, use_guards => guardFlags) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      UnsharedOperator: UnsharedOperatorWithBuffering -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          name => "ApIntAdd_group_8",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 5,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 5,
          constant_operand => "00000",
          constant_width => 5,
          buffering  => 1,
          flow_through => false,
          use_constant  => true
          --
        ) 
        port map ( -- 
          reqL => reqL(0),
          ackL => ackL(0),
          reqR => reqR(0),
          ackR => ackR(0),
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 8
    -- shared split operator group (9) : ptr_deref_134_addr_0 
    ApIntAdd_group_9: Block -- 
      signal data_in: std_logic_vector(8 downto 0);
      signal data_out: std_logic_vector(8 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 1);
      -- 
    begin -- 
      data_in <= ptr_deref_134_root_address;
      ptr_deref_134_word_address_0 <= data_out(8 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= ptr_deref_134_addr_0_req_0;
      ptr_deref_134_addr_0_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= ptr_deref_134_addr_0_req_1;
      ptr_deref_134_addr_0_ack_1 <= ackR_unguarded(0);
      gI: SplitGuardInterface generic map(nreqs => 1, buffering => guardBuffering, use_guards => guardFlags) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      UnsharedOperator: UnsharedOperatorWithBuffering -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          name => "ApIntAdd_group_9",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 9,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 9,
          constant_operand => "000000000",
          constant_width => 9,
          buffering  => 1,
          flow_through => false,
          use_constant  => true
          --
        ) 
        port map ( -- 
          reqL => reqL(0),
          ackL => ackL(0),
          reqR => reqR(0),
          ackR => ackR(0),
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 9
    -- shared split operator group (10) : ptr_deref_134_addr_1 
    ApIntAdd_group_10: Block -- 
      signal data_in: std_logic_vector(8 downto 0);
      signal data_out: std_logic_vector(8 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 1);
      -- 
    begin -- 
      data_in <= ptr_deref_134_root_address;
      ptr_deref_134_word_address_1 <= data_out(8 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= ptr_deref_134_addr_1_req_0;
      ptr_deref_134_addr_1_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= ptr_deref_134_addr_1_req_1;
      ptr_deref_134_addr_1_ack_1 <= ackR_unguarded(0);
      gI: SplitGuardInterface generic map(nreqs => 1, buffering => guardBuffering, use_guards => guardFlags) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      UnsharedOperator: UnsharedOperatorWithBuffering -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          name => "ApIntAdd_group_10",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 9,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 9,
          constant_operand => "000000001",
          constant_width => 9,
          buffering  => 1,
          flow_through => false,
          use_constant  => true
          --
        ) 
        port map ( -- 
          reqL => reqL(0),
          ackL => ackL(0),
          reqR => reqR(0),
          ackR => ackR(0),
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 10
    -- shared split operator group (11) : ptr_deref_134_addr_2 
    ApIntAdd_group_11: Block -- 
      signal data_in: std_logic_vector(8 downto 0);
      signal data_out: std_logic_vector(8 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 1);
      -- 
    begin -- 
      data_in <= ptr_deref_134_root_address;
      ptr_deref_134_word_address_2 <= data_out(8 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= ptr_deref_134_addr_2_req_0;
      ptr_deref_134_addr_2_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= ptr_deref_134_addr_2_req_1;
      ptr_deref_134_addr_2_ack_1 <= ackR_unguarded(0);
      gI: SplitGuardInterface generic map(nreqs => 1, buffering => guardBuffering, use_guards => guardFlags) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      UnsharedOperator: UnsharedOperatorWithBuffering -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          name => "ApIntAdd_group_11",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 9,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 9,
          constant_operand => "000000010",
          constant_width => 9,
          buffering  => 1,
          flow_through => false,
          use_constant  => true
          --
        ) 
        port map ( -- 
          reqL => reqL(0),
          ackL => ackL(0),
          reqR => reqR(0),
          ackR => ackR(0),
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 11
    -- shared split operator group (12) : ptr_deref_134_addr_3 
    ApIntAdd_group_12: Block -- 
      signal data_in: std_logic_vector(8 downto 0);
      signal data_out: std_logic_vector(8 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 1);
      -- 
    begin -- 
      data_in <= ptr_deref_134_root_address;
      ptr_deref_134_word_address_3 <= data_out(8 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= ptr_deref_134_addr_3_req_0;
      ptr_deref_134_addr_3_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= ptr_deref_134_addr_3_req_1;
      ptr_deref_134_addr_3_ack_1 <= ackR_unguarded(0);
      gI: SplitGuardInterface generic map(nreqs => 1, buffering => guardBuffering, use_guards => guardFlags) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      UnsharedOperator: UnsharedOperatorWithBuffering -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          name => "ApIntAdd_group_12",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 9,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 9,
          constant_operand => "000000011",
          constant_width => 9,
          buffering  => 1,
          flow_through => false,
          use_constant  => true
          --
        ) 
        port map ( -- 
          reqL => reqL(0),
          ackL => ackL(0),
          reqR => reqR(0),
          ackR => ackR(0),
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 12
    -- shared split operator group (13) : ptr_deref_86_addr_0 
    ApIntAdd_group_13: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(4 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 1);
      -- 
    begin -- 
      data_in <= ptr_deref_86_root_address;
      ptr_deref_86_word_address_0 <= data_out(4 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= ptr_deref_86_addr_0_req_0;
      ptr_deref_86_addr_0_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= ptr_deref_86_addr_0_req_1;
      ptr_deref_86_addr_0_ack_1 <= ackR_unguarded(0);
      gI: SplitGuardInterface generic map(nreqs => 1, buffering => guardBuffering, use_guards => guardFlags) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      UnsharedOperator: UnsharedOperatorWithBuffering -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          name => "ApIntAdd_group_13",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 5,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 5,
          constant_operand => "00000",
          constant_width => 5,
          buffering  => 1,
          flow_through => false,
          use_constant  => true
          --
        ) 
        port map ( -- 
          reqL => reqL(0),
          ackL => ackL(0),
          reqR => reqR(0),
          ackR => ackR(0),
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 13
    -- shared split operator group (14) : ptr_deref_86_addr_1 
    ApIntAdd_group_14: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(4 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 1);
      -- 
    begin -- 
      data_in <= ptr_deref_86_root_address;
      ptr_deref_86_word_address_1 <= data_out(4 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= ptr_deref_86_addr_1_req_0;
      ptr_deref_86_addr_1_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= ptr_deref_86_addr_1_req_1;
      ptr_deref_86_addr_1_ack_1 <= ackR_unguarded(0);
      gI: SplitGuardInterface generic map(nreqs => 1, buffering => guardBuffering, use_guards => guardFlags) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      UnsharedOperator: UnsharedOperatorWithBuffering -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          name => "ApIntAdd_group_14",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 5,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 5,
          constant_operand => "00001",
          constant_width => 5,
          buffering  => 1,
          flow_through => false,
          use_constant  => true
          --
        ) 
        port map ( -- 
          reqL => reqL(0),
          ackL => ackL(0),
          reqR => reqR(0),
          ackR => ackR(0),
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 14
    -- shared store operator group (0) : ptr_deref_134_store_3 ptr_deref_134_store_2 ptr_deref_134_store_1 ptr_deref_134_store_0 
    StoreGroup0: Block -- 
      signal addr_in: std_logic_vector(35 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 3 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 3 downto 0);
      signal reqL_unregulated, ackL_unregulated : BooleanArray( 3 downto 0);
      signal guard_vector : std_logic_vector( 3 downto 0);
      constant inBUFs : IntegerArray(3 downto 0) := (3 => 1, 2 => 1, 1 => 1, 0 => 1);
      constant outBUFs : IntegerArray(3 downto 0) := (3 => 1, 2 => 1, 1 => 1, 0 => 1);
      constant guardFlags : BooleanArray(3 downto 0) := (0 => false, 1 => false, 2 => false, 3 => false);
      constant guardBuffering: IntegerArray(3 downto 0)  := (0 => 1, 1 => 1, 2 => 1, 3 => 1);
      -- 
    begin -- 
      reqL_unguarded(3) <= ptr_deref_134_store_3_req_0;
      reqL_unguarded(2) <= ptr_deref_134_store_2_req_0;
      reqL_unguarded(1) <= ptr_deref_134_store_1_req_0;
      reqL_unguarded(0) <= ptr_deref_134_store_0_req_0;
      ptr_deref_134_store_3_ack_0 <= ackL_unguarded(3);
      ptr_deref_134_store_2_ack_0 <= ackL_unguarded(2);
      ptr_deref_134_store_1_ack_0 <= ackL_unguarded(1);
      ptr_deref_134_store_0_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(3) <= ptr_deref_134_store_3_req_1;
      reqR_unguarded(2) <= ptr_deref_134_store_2_req_1;
      reqR_unguarded(1) <= ptr_deref_134_store_1_req_1;
      reqR_unguarded(0) <= ptr_deref_134_store_0_req_1;
      ptr_deref_134_store_3_ack_1 <= ackR_unguarded(3);
      ptr_deref_134_store_2_ack_1 <= ackR_unguarded(2);
      ptr_deref_134_store_1_ack_1 <= ackR_unguarded(1);
      ptr_deref_134_store_0_ack_1 <= ackR_unguarded(0);
      guard_vector(0)  <=  '1';
      guard_vector(1)  <=  '1';
      guard_vector(2)  <=  '1';
      guard_vector(3)  <=  '1';
      StoreGroup0_accessRegulator_0: access_regulator_base generic map (name => "StoreGroup0_accessRegulator_0", num_slots => 1) -- 
        port map (req => reqL_unregulated(0), -- 
          ack => ackL_unregulated(0),
          regulated_req => reqL(0),
          regulated_ack => ackL(0),
          release_req => reqR(0),
          release_ack => ackR(0),
          clk => clk, reset => reset); -- 
      StoreGroup0_accessRegulator_1: access_regulator_base generic map (name => "StoreGroup0_accessRegulator_1", num_slots => 1) -- 
        port map (req => reqL_unregulated(1), -- 
          ack => ackL_unregulated(1),
          regulated_req => reqL(1),
          regulated_ack => ackL(1),
          release_req => reqR(1),
          release_ack => ackR(1),
          clk => clk, reset => reset); -- 
      StoreGroup0_accessRegulator_2: access_regulator_base generic map (name => "StoreGroup0_accessRegulator_2", num_slots => 1) -- 
        port map (req => reqL_unregulated(2), -- 
          ack => ackL_unregulated(2),
          regulated_req => reqL(2),
          regulated_ack => ackL(2),
          release_req => reqR(2),
          release_ack => ackR(2),
          clk => clk, reset => reset); -- 
      StoreGroup0_accessRegulator_3: access_regulator_base generic map (name => "StoreGroup0_accessRegulator_3", num_slots => 1) -- 
        port map (req => reqL_unregulated(3), -- 
          ack => ackL_unregulated(3),
          regulated_req => reqL(3),
          regulated_ack => ackL(3),
          release_req => reqR(3),
          release_ack => ackR(3),
          clk => clk, reset => reset); -- 
      gI: SplitGuardInterface generic map(nreqs => 4, buffering => guardBuffering, use_guards => guardFlags) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL_unregulated,
        sa_in => ackL_unregulated,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      addr_in <= ptr_deref_134_word_address_3 & ptr_deref_134_word_address_2 & ptr_deref_134_word_address_1 & ptr_deref_134_word_address_0;
      data_in <= ptr_deref_134_data_3 & ptr_deref_134_data_2 & ptr_deref_134_data_1 & ptr_deref_134_data_0;
      StoreReq: StoreReqSharedWithInputBuffers -- 
        generic map ( name => "StoreGroup0 Req ", addr_width => 9,
        data_width => 8,
        num_reqs => 4,
        tag_length => 3,
        time_stamp_width => 0,
        min_clock_period => false,
        input_buffering => inBUFs, 
        no_arbitration => false)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_1_sr_req(0),
          mack => memory_space_1_sr_ack(0),
          maddr => memory_space_1_sr_addr(8 downto 0),
          mdata => memory_space_1_sr_data(7 downto 0),
          mtag => memory_space_1_sr_tag(2 downto 0),
          clk => clk, reset => reset -- 
        );--
      StoreComplete: StoreCompleteShared -- 
        generic map ( -- 
          name => "StoreGroup0 Complete ",
          num_reqs => 4,
          detailed_buffering_per_output => outBUFs,
          tag_length => 3 -- 
        )
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          mreq => memory_space_1_sc_req(0),
          mack => memory_space_1_sc_ack(0),
          mtag => memory_space_1_sc_tag(2 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 0
    -- shared store operator group (1) : ptr_deref_86_store_1 ptr_deref_86_store_0 
    StoreGroup1: Block -- 
      signal addr_in: std_logic_vector(9 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 1 downto 0);
      signal reqL_unregulated, ackL_unregulated : BooleanArray( 1 downto 0);
      signal guard_vector : std_logic_vector( 1 downto 0);
      constant inBUFs : IntegerArray(1 downto 0) := (1 => 1, 0 => 1);
      constant outBUFs : IntegerArray(1 downto 0) := (1 => 1, 0 => 1);
      constant guardFlags : BooleanArray(1 downto 0) := (0 => false, 1 => false);
      constant guardBuffering: IntegerArray(1 downto 0)  := (0 => 1, 1 => 1);
      -- 
    begin -- 
      reqL_unguarded(1) <= ptr_deref_86_store_1_req_0;
      reqL_unguarded(0) <= ptr_deref_86_store_0_req_0;
      ptr_deref_86_store_1_ack_0 <= ackL_unguarded(1);
      ptr_deref_86_store_0_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(1) <= ptr_deref_86_store_1_req_1;
      reqR_unguarded(0) <= ptr_deref_86_store_0_req_1;
      ptr_deref_86_store_1_ack_1 <= ackR_unguarded(1);
      ptr_deref_86_store_0_ack_1 <= ackR_unguarded(0);
      guard_vector(0)  <=  '1';
      guard_vector(1)  <=  '1';
      StoreGroup1_accessRegulator_0: access_regulator_base generic map (name => "StoreGroup1_accessRegulator_0", num_slots => 1) -- 
        port map (req => reqL_unregulated(0), -- 
          ack => ackL_unregulated(0),
          regulated_req => reqL(0),
          regulated_ack => ackL(0),
          release_req => reqR(0),
          release_ack => ackR(0),
          clk => clk, reset => reset); -- 
      StoreGroup1_accessRegulator_1: access_regulator_base generic map (name => "StoreGroup1_accessRegulator_1", num_slots => 1) -- 
        port map (req => reqL_unregulated(1), -- 
          ack => ackL_unregulated(1),
          regulated_req => reqL(1),
          regulated_ack => ackL(1),
          release_req => reqR(1),
          release_ack => ackR(1),
          clk => clk, reset => reset); -- 
      gI: SplitGuardInterface generic map(nreqs => 2, buffering => guardBuffering, use_guards => guardFlags) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL_unregulated,
        sa_in => ackL_unregulated,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      addr_in <= ptr_deref_86_word_address_1 & ptr_deref_86_word_address_0;
      data_in <= ptr_deref_86_data_1 & ptr_deref_86_data_0;
      StoreReq: StoreReqSharedWithInputBuffers -- 
        generic map ( name => "StoreGroup1 Req ", addr_width => 5,
        data_width => 16,
        num_reqs => 2,
        tag_length => 2,
        time_stamp_width => 0,
        min_clock_period => false,
        input_buffering => inBUFs, 
        no_arbitration => false)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_0_sr_req(0),
          mack => memory_space_0_sr_ack(0),
          maddr => memory_space_0_sr_addr(4 downto 0),
          mdata => memory_space_0_sr_data(15 downto 0),
          mtag => memory_space_0_sr_tag(1 downto 0),
          clk => clk, reset => reset -- 
        );--
      StoreComplete: StoreCompleteShared -- 
        generic map ( -- 
          name => "StoreGroup1 Complete ",
          num_reqs => 2,
          detailed_buffering_per_output => outBUFs,
          tag_length => 2 -- 
        )
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          mreq => memory_space_0_sc_req(0),
          mack => memory_space_0_sc_ack(0),
          mtag => memory_space_0_sc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 1
    -- shared inport operator group (0) : RPIPE_dct_in_data_131_inst RPIPE_dct_in_data_83_inst RPIPE_dct_in_data_25_inst RPIPE_dct_in_data_28_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(127 downto 0);
      signal reqL, ackL, reqR, ackR : BooleanArray( 3 downto 0);
      signal reqL_unguarded, ackL_unguarded : BooleanArray( 3 downto 0);
      signal reqR_unguarded, ackR_unguarded : BooleanArray( 3 downto 0);
      signal guard_vector : std_logic_vector( 3 downto 0);
      constant outBUFs : IntegerArray(3 downto 0) := (3 => 1, 2 => 1, 1 => 1, 0 => 1);
      constant guardFlags : BooleanArray(3 downto 0) := (0 => false, 1 => false, 2 => false, 3 => false);
      constant guardBuffering: IntegerArray(3 downto 0)  := (0 => 1, 1 => 1, 2 => 1, 3 => 1);
      -- 
    begin -- 
      reqL_unguarded(3) <= RPIPE_dct_in_data_131_inst_req_0;
      reqL_unguarded(2) <= RPIPE_dct_in_data_83_inst_req_0;
      reqL_unguarded(1) <= RPIPE_dct_in_data_25_inst_req_0;
      reqL_unguarded(0) <= RPIPE_dct_in_data_28_inst_req_0;
      RPIPE_dct_in_data_131_inst_ack_0 <= ackL_unguarded(3);
      RPIPE_dct_in_data_83_inst_ack_0 <= ackL_unguarded(2);
      RPIPE_dct_in_data_25_inst_ack_0 <= ackL_unguarded(1);
      RPIPE_dct_in_data_28_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(3) <= RPIPE_dct_in_data_131_inst_req_1;
      reqR_unguarded(2) <= RPIPE_dct_in_data_83_inst_req_1;
      reqR_unguarded(1) <= RPIPE_dct_in_data_25_inst_req_1;
      reqR_unguarded(0) <= RPIPE_dct_in_data_28_inst_req_1;
      RPIPE_dct_in_data_131_inst_ack_1 <= ackR_unguarded(3);
      RPIPE_dct_in_data_83_inst_ack_1 <= ackR_unguarded(2);
      RPIPE_dct_in_data_25_inst_ack_1 <= ackR_unguarded(1);
      RPIPE_dct_in_data_28_inst_ack_1 <= ackR_unguarded(0);
      guard_vector(0)  <=  '1';
      guard_vector(1)  <=  '1';
      guard_vector(2)  <=  '1';
      guard_vector(3)  <=  '1';
      gI: SplitGuardInterface generic map(nreqs => 4, buffering => guardBuffering, use_guards => guardFlags) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      iNsTr_15_132 <= data_out(127 downto 96);
      iNsTr_9_84 <= data_out(95 downto 64);
      iNsTr_2_26 <= data_out(63 downto 32);
      iNsTr_4_29 <= data_out(31 downto 0);
      dct_in_data_read_0: InputPortFullRate -- 
        generic map ( name => "dct_in_data_read_0", data_width => 32,  num_reqs => 4,  output_buffering => outBUFs,   no_arbitration => false)
        port map (-- 
          sample_req => reqL , 
          sample_ack => ackL, 
          update_req => reqR, 
          update_ack => ackR, 
          data => data_out, 
          oreq => dct_in_data_pipe_read_req(0),
          oack => dct_in_data_pipe_read_ack(0),
          odata => dct_in_data_pipe_read_data(31 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 0
    -- 
  end Block; -- data_path
  dummyWOM_memory_space_0: dummy_write_only_memory_subsystem -- 
    generic map(-- 
      num_stores => 1,
      addr_width => 5,
      data_width => 16,
      tag_width => 2
      ) -- 
    port map(-- 
      sr_addr_in => memory_space_0_sr_addr,
      sr_data_in => memory_space_0_sr_data,
      sr_req_in => memory_space_0_sr_req,
      sr_ack_out => memory_space_0_sr_ack,
      sr_tag_in => memory_space_0_sr_tag,
      sc_req_in=> memory_space_0_sc_req,
      sc_ack_out => memory_space_0_sc_ack,
      sc_tag_out => memory_space_0_sc_tag,
      clock => clk,
      reset => reset); -- 
  dummyWOM_memory_space_1: dummy_write_only_memory_subsystem -- 
    generic map(-- 
      num_stores => 1,
      addr_width => 9,
      data_width => 8,
      tag_width => 3
      ) -- 
    port map(-- 
      sr_addr_in => memory_space_1_sr_addr,
      sr_data_in => memory_space_1_sr_data,
      sr_req_in => memory_space_1_sr_req,
      sr_ack_out => memory_space_1_sr_ack,
      sr_tag_in => memory_space_1_sr_tag,
      sc_req_in=> memory_space_1_sc_req,
      sc_ack_out => memory_space_1_sc_ack,
      sc_tag_out => memory_space_1_sc_tag,
      clock => clk,
      reset => reset); -- 
  -- 
end Default;
library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.memory_subsystem_package.all;
use ahir.types.all;
use ahir.subprograms.all;
use ahir.components.all;
use ahir.basecomponents.all;
use ahir.operatorpackage.all;
use ahir.utilities.all;
use ahir.functionLibraryComponents.all;
library work;
use work.ahir_system_global_package.all;
entity ahir_system is  -- system 
  port (-- 
    clk : in std_logic;
    reset : in std_logic;
    dct_in_data_pipe_write_data: in std_logic_vector(31 downto 0);
    dct_in_data_pipe_write_req : in std_logic_vector(0 downto 0);
    dct_in_data_pipe_write_ack : out std_logic_vector(0 downto 0)); -- 
  -- 
end entity; 
architecture Default of ahir_system is -- system-architecture 
  -- declarations related to module dct_engine
  component dct_engine is -- 
    generic (tag_length : integer); 
    port ( -- 
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic;
      dct_in_data_pipe_read_req : out  std_logic_vector(0 downto 0);
      dct_in_data_pipe_read_ack : in   std_logic_vector(0 downto 0);
      dct_in_data_pipe_read_data : in   std_logic_vector(31 downto 0);
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
    );
    -- 
  end component;
  -- argument signals for module dct_engine
  signal dct_engine_tag_in    : std_logic_vector(1 downto 0) := (others => '0');
  signal dct_engine_tag_out   : std_logic_vector(1 downto 0);
  signal dct_engine_start_req : std_logic;
  signal dct_engine_start_ack : std_logic;
  signal dct_engine_fin_req   : std_logic;
  signal dct_engine_fin_ack : std_logic;
  -- aggregate signals for read from pipe dct_in_data
  signal dct_in_data_pipe_read_data: std_logic_vector(31 downto 0);
  signal dct_in_data_pipe_read_req: std_logic_vector(0 downto 0);
  signal dct_in_data_pipe_read_ack: std_logic_vector(0 downto 0);
  -- 
begin -- 
  -- module dct_engine
  dct_engine_instance:dct_engine-- 
    generic map(tag_length => 2)
    port map(-- 
      start_req => dct_engine_start_req,
      start_ack => dct_engine_start_ack,
      fin_req => dct_engine_fin_req,
      fin_ack => dct_engine_fin_ack,
      clk => clk,
      reset => reset,
      dct_in_data_pipe_read_req => dct_in_data_pipe_read_req(0 downto 0),
      dct_in_data_pipe_read_ack => dct_in_data_pipe_read_ack(0 downto 0),
      dct_in_data_pipe_read_data => dct_in_data_pipe_read_data(31 downto 0),
      tag_in => dct_engine_tag_in,
      tag_out => dct_engine_tag_out-- 
    ); -- 
  -- module will be run forever 
  dct_engine_tag_in <= (others => '0');
  dct_engine_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start_req => dct_engine_start_req, start_ack => dct_engine_start_ack,  fin_req => dct_engine_fin_req,  fin_ack => dct_engine_fin_ack);
  dct_in_data_Pipe: PipeBase -- 
    generic map( -- 
      name => "pipe dct_in_data",
      num_reads => 1,
      num_writes => 1,
      data_width => 32,
      lifo_mode => false,
      signal_mode => false,
      depth => 1 --
    )
    port map( -- 
      read_req => dct_in_data_pipe_read_req,
      read_ack => dct_in_data_pipe_read_ack,
      read_data => dct_in_data_pipe_read_data,
      write_req => dct_in_data_pipe_write_req,
      write_ack => dct_in_data_pipe_write_ack,
      write_data => dct_in_data_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  -- 
end Default;
