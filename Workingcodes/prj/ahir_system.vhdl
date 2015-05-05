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
library work;
use work.ahir_system_global_package.all;
entity hardware1 is -- 
  generic (tag_length : integer); 
  port ( -- 
    clk : in std_logic;
    reset : in std_logic;
    start_req : in std_logic;
    start_ack : out std_logic;
    fin_req : in std_logic;
    fin_ack   : out std_logic;
    memory_space_0_sr_req : out  std_logic_vector(0 downto 0);
    memory_space_0_sr_ack : in   std_logic_vector(0 downto 0);
    memory_space_0_sr_addr : out  std_logic_vector(7 downto 0);
    memory_space_0_sr_data : out  std_logic_vector(31 downto 0);
    memory_space_0_sr_tag :  out  std_logic_vector(3 downto 0);
    memory_space_0_sc_req : out  std_logic_vector(0 downto 0);
    memory_space_0_sc_ack : in   std_logic_vector(0 downto 0);
    memory_space_0_sc_tag :  in  std_logic_vector(3 downto 0);
    in_data_pipe_read_req : out  std_logic_vector(0 downto 0);
    in_data_pipe_read_ack : in   std_logic_vector(0 downto 0);
    in_data_pipe_read_data : in   std_logic_vector(31 downto 0);
    out_id_pipe_write_req : out  std_logic_vector(0 downto 0);
    out_id_pipe_write_ack : in   std_logic_vector(0 downto 0);
    out_id_pipe_write_data : out  std_logic_vector(31 downto 0);
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
  );
  -- 
end entity hardware1;
architecture Default of hardware1 is -- 
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
  signal hardware1_CP_26_start: Boolean;
  signal hardware1_CP_26_symbol: Boolean;
  -- links between control-path and data-path
  signal phi_stmt_47_ack_0 : boolean;
  signal array_obj_ref_59_index_0_resize_req_0 : boolean;
  signal ptr_deref_28_base_resize_req_0 : boolean;
  signal ptr_deref_28_base_resize_ack_0 : boolean;
  signal ptr_deref_28_root_address_inst_req_0 : boolean;
  signal ptr_deref_28_root_address_inst_ack_0 : boolean;
  signal ptr_deref_28_addr_0_req_0 : boolean;
  signal ptr_deref_28_addr_0_ack_0 : boolean;
  signal ptr_deref_28_gather_scatter_req_0 : boolean;
  signal ptr_deref_28_gather_scatter_ack_0 : boolean;
  signal phi_stmt_47_req_1 : boolean;
  signal type_cast_53_inst_ack_1 : boolean;
  signal ptr_deref_28_store_0_req_0 : boolean;
  signal ptr_deref_28_store_0_ack_0 : boolean;
  signal type_cast_53_inst_req_1 : boolean;
  signal ptr_deref_28_store_0_req_1 : boolean;
  signal ptr_deref_28_store_0_ack_1 : boolean;
  signal ptr_deref_41_base_resize_req_0 : boolean;
  signal ptr_deref_41_base_resize_ack_0 : boolean;
  signal type_cast_53_inst_ack_0 : boolean;
  signal ptr_deref_41_root_address_inst_req_0 : boolean;
  signal ptr_deref_41_root_address_inst_ack_0 : boolean;
  signal ptr_deref_41_addr_0_req_0 : boolean;
  signal ptr_deref_41_addr_0_ack_0 : boolean;
  signal type_cast_53_inst_req_0 : boolean;
  signal ptr_deref_41_gather_scatter_req_0 : boolean;
  signal ptr_deref_41_gather_scatter_ack_0 : boolean;
  signal ptr_deref_41_store_0_req_0 : boolean;
  signal ptr_deref_41_store_0_ack_0 : boolean;
  signal ptr_deref_41_store_0_req_1 : boolean;
  signal ptr_deref_41_store_0_ack_1 : boolean;
  signal ptr_deref_158_store_0_ack_0 : boolean;
  signal array_obj_ref_80_index_offset_req_0 : boolean;
  signal array_obj_ref_80_index_offset_ack_0 : boolean;
  signal array_obj_ref_80_index_offset_req_1 : boolean;
  signal array_obj_ref_80_index_offset_ack_1 : boolean;
  signal array_obj_ref_80_root_address_inst_req_0 : boolean;
  signal array_obj_ref_59_index_0_resize_ack_0 : boolean;
  signal array_obj_ref_59_index_0_scale_req_0 : boolean;
  signal array_obj_ref_59_index_0_scale_ack_0 : boolean;
  signal array_obj_ref_59_index_0_scale_req_1 : boolean;
  signal array_obj_ref_59_index_0_scale_ack_1 : boolean;
  signal array_obj_ref_59_index_offset_req_0 : boolean;
  signal array_obj_ref_59_index_offset_ack_0 : boolean;
  signal array_obj_ref_59_index_offset_req_1 : boolean;
  signal array_obj_ref_59_index_offset_ack_1 : boolean;
  signal array_obj_ref_59_root_address_inst_req_0 : boolean;
  signal array_obj_ref_59_root_address_inst_ack_0 : boolean;
  signal addr_of_60_final_reg_req_0 : boolean;
  signal addr_of_60_final_reg_ack_0 : boolean;
  signal addr_of_60_final_reg_req_1 : boolean;
  signal addr_of_60_final_reg_ack_1 : boolean;
  signal array_obj_ref_66_index_0_resize_req_0 : boolean;
  signal array_obj_ref_66_index_0_resize_ack_0 : boolean;
  signal phi_stmt_47_req_0 : boolean;
  signal array_obj_ref_66_index_0_scale_req_0 : boolean;
  signal array_obj_ref_66_index_0_scale_ack_0 : boolean;
  signal array_obj_ref_66_index_0_scale_req_1 : boolean;
  signal array_obj_ref_66_index_0_scale_ack_1 : boolean;
  signal array_obj_ref_66_index_offset_req_0 : boolean;
  signal array_obj_ref_66_index_offset_ack_0 : boolean;
  signal array_obj_ref_66_index_offset_req_1 : boolean;
  signal array_obj_ref_66_index_offset_ack_1 : boolean;
  signal array_obj_ref_66_root_address_inst_req_0 : boolean;
  signal array_obj_ref_66_root_address_inst_ack_0 : boolean;
  signal addr_of_67_final_reg_req_0 : boolean;
  signal addr_of_67_final_reg_ack_0 : boolean;
  signal addr_of_67_final_reg_req_1 : boolean;
  signal addr_of_67_final_reg_ack_1 : boolean;
  signal array_obj_ref_73_index_0_resize_req_0 : boolean;
  signal array_obj_ref_73_index_0_resize_ack_0 : boolean;
  signal array_obj_ref_73_index_0_scale_req_0 : boolean;
  signal array_obj_ref_73_index_0_scale_ack_0 : boolean;
  signal array_obj_ref_73_index_0_scale_req_1 : boolean;
  signal array_obj_ref_73_index_0_scale_ack_1 : boolean;
  signal array_obj_ref_73_index_offset_req_0 : boolean;
  signal array_obj_ref_73_index_offset_ack_0 : boolean;
  signal array_obj_ref_73_index_offset_req_1 : boolean;
  signal array_obj_ref_73_index_offset_ack_1 : boolean;
  signal array_obj_ref_73_root_address_inst_req_0 : boolean;
  signal array_obj_ref_73_root_address_inst_ack_0 : boolean;
  signal addr_of_74_final_reg_req_0 : boolean;
  signal addr_of_74_final_reg_ack_0 : boolean;
  signal addr_of_74_final_reg_req_1 : boolean;
  signal addr_of_74_final_reg_ack_1 : boolean;
  signal array_obj_ref_80_index_0_resize_req_0 : boolean;
  signal array_obj_ref_80_index_0_resize_ack_0 : boolean;
  signal array_obj_ref_80_index_0_scale_req_0 : boolean;
  signal array_obj_ref_80_index_0_scale_ack_0 : boolean;
  signal array_obj_ref_80_index_0_scale_req_1 : boolean;
  signal array_obj_ref_80_index_0_scale_ack_1 : boolean;
  signal RPIPE_in_data_134_inst_req_0 : boolean;
  signal RPIPE_in_data_134_inst_ack_0 : boolean;
  signal RPIPE_in_data_134_inst_req_1 : boolean;
  signal RPIPE_in_data_134_inst_ack_1 : boolean;
  signal array_obj_ref_80_root_address_inst_ack_0 : boolean;
  signal WPIPE_out_id_166_inst_ack_1 : boolean;
  signal addr_of_81_final_reg_req_0 : boolean;
  signal addr_of_81_final_reg_ack_0 : boolean;
  signal WPIPE_out_id_166_inst_req_1 : boolean;
  signal addr_of_81_final_reg_req_1 : boolean;
  signal addr_of_81_final_reg_ack_1 : boolean;
  signal array_obj_ref_87_index_0_resize_req_0 : boolean;
  signal array_obj_ref_87_index_0_resize_ack_0 : boolean;
  signal array_obj_ref_87_index_0_scale_req_0 : boolean;
  signal array_obj_ref_87_index_0_scale_ack_0 : boolean;
  signal array_obj_ref_87_index_0_scale_req_1 : boolean;
  signal array_obj_ref_87_index_0_scale_ack_1 : boolean;
  signal WPIPE_out_id_166_inst_ack_0 : boolean;
  signal array_obj_ref_87_index_offset_req_0 : boolean;
  signal array_obj_ref_87_index_offset_ack_0 : boolean;
  signal WPIPE_out_id_166_inst_req_0 : boolean;
  signal array_obj_ref_87_index_offset_req_1 : boolean;
  signal array_obj_ref_87_index_offset_ack_1 : boolean;
  signal array_obj_ref_87_root_address_inst_req_0 : boolean;
  signal array_obj_ref_87_root_address_inst_ack_0 : boolean;
  signal addr_of_88_final_reg_req_0 : boolean;
  signal addr_of_88_final_reg_ack_0 : boolean;
  signal addr_of_88_final_reg_req_1 : boolean;
  signal addr_of_88_final_reg_ack_1 : boolean;
  signal array_obj_ref_94_index_0_resize_req_0 : boolean;
  signal array_obj_ref_94_index_0_resize_ack_0 : boolean;
  signal array_obj_ref_94_index_0_scale_req_0 : boolean;
  signal array_obj_ref_94_index_0_scale_ack_0 : boolean;
  signal array_obj_ref_94_index_0_scale_req_1 : boolean;
  signal array_obj_ref_94_index_0_scale_ack_1 : boolean;
  signal array_obj_ref_94_index_offset_req_0 : boolean;
  signal array_obj_ref_94_index_offset_ack_0 : boolean;
  signal array_obj_ref_94_index_offset_req_1 : boolean;
  signal array_obj_ref_94_index_offset_ack_1 : boolean;
  signal array_obj_ref_94_root_address_inst_req_0 : boolean;
  signal array_obj_ref_94_root_address_inst_ack_0 : boolean;
  signal addr_of_95_final_reg_req_0 : boolean;
  signal addr_of_95_final_reg_ack_0 : boolean;
  signal addr_of_95_final_reg_req_1 : boolean;
  signal addr_of_95_final_reg_ack_1 : boolean;
  signal array_obj_ref_99_index_0_resize_req_0 : boolean;
  signal array_obj_ref_99_index_0_resize_ack_0 : boolean;
  signal array_obj_ref_99_index_0_scale_req_0 : boolean;
  signal array_obj_ref_99_index_0_scale_ack_0 : boolean;
  signal array_obj_ref_99_index_0_scale_req_1 : boolean;
  signal array_obj_ref_99_index_0_scale_ack_1 : boolean;
  signal array_obj_ref_99_index_offset_req_0 : boolean;
  signal array_obj_ref_99_index_offset_ack_0 : boolean;
  signal ptr_deref_162_store_0_ack_1 : boolean;
  signal array_obj_ref_99_root_address_inst_req_0 : boolean;
  signal array_obj_ref_99_root_address_inst_ack_0 : boolean;
  signal ptr_deref_162_store_0_req_1 : boolean;
  signal addr_of_100_final_reg_req_0 : boolean;
  signal addr_of_100_final_reg_ack_0 : boolean;
  signal addr_of_100_final_reg_req_1 : boolean;
  signal addr_of_100_final_reg_ack_1 : boolean;
  signal type_cast_105_inst_req_0 : boolean;
  signal type_cast_105_inst_ack_0 : boolean;
  signal type_cast_105_inst_req_1 : boolean;
  signal type_cast_105_inst_ack_1 : boolean;
  signal ADD_u32_u32_111_inst_req_0 : boolean;
  signal ADD_u32_u32_111_inst_ack_0 : boolean;
  signal ADD_u32_u32_111_inst_req_1 : boolean;
  signal ADD_u32_u32_111_inst_ack_1 : boolean;
  signal ADD_u32_u32_117_inst_req_0 : boolean;
  signal ADD_u32_u32_117_inst_ack_0 : boolean;
  signal ptr_deref_162_store_0_ack_0 : boolean;
  signal ADD_u32_u32_117_inst_req_1 : boolean;
  signal ADD_u32_u32_117_inst_ack_1 : boolean;
  signal ptr_deref_158_store_0_req_0 : boolean;
  signal ptr_deref_162_store_0_req_0 : boolean;
  signal RPIPE_in_data_120_inst_req_0 : boolean;
  signal RPIPE_in_data_120_inst_ack_0 : boolean;
  signal RPIPE_in_data_120_inst_req_1 : boolean;
  signal RPIPE_in_data_120_inst_ack_1 : boolean;
  signal ptr_deref_158_gather_scatter_req_0 : boolean;
  signal ptr_deref_123_base_resize_req_0 : boolean;
  signal ptr_deref_123_base_resize_ack_0 : boolean;
  signal ptr_deref_162_gather_scatter_ack_0 : boolean;
  signal ptr_deref_123_root_address_inst_req_0 : boolean;
  signal ptr_deref_123_root_address_inst_ack_0 : boolean;
  signal ptr_deref_123_addr_0_req_0 : boolean;
  signal ptr_deref_123_addr_0_ack_0 : boolean;
  signal ptr_deref_162_gather_scatter_req_0 : boolean;
  signal ptr_deref_123_gather_scatter_req_0 : boolean;
  signal ptr_deref_123_gather_scatter_ack_0 : boolean;
  signal ptr_deref_123_store_0_req_0 : boolean;
  signal ptr_deref_123_store_0_ack_0 : boolean;
  signal ptr_deref_123_store_0_req_1 : boolean;
  signal ptr_deref_123_store_0_ack_1 : boolean;
  signal ptr_deref_162_addr_0_ack_0 : boolean;
  signal ptr_deref_162_addr_0_req_0 : boolean;
  signal RPIPE_in_data_127_inst_req_0 : boolean;
  signal RPIPE_in_data_127_inst_ack_0 : boolean;
  signal RPIPE_in_data_127_inst_req_1 : boolean;
  signal RPIPE_in_data_127_inst_ack_1 : boolean;
  signal ptr_deref_158_store_0_ack_1 : boolean;
  signal ptr_deref_158_store_0_req_1 : boolean;
  signal ptr_deref_162_root_address_inst_ack_0 : boolean;
  signal ptr_deref_130_base_resize_req_0 : boolean;
  signal ptr_deref_130_base_resize_ack_0 : boolean;
  signal ptr_deref_162_root_address_inst_req_0 : boolean;
  signal ptr_deref_130_root_address_inst_req_0 : boolean;
  signal ptr_deref_130_root_address_inst_ack_0 : boolean;
  signal ptr_deref_130_addr_0_req_0 : boolean;
  signal ptr_deref_130_addr_0_ack_0 : boolean;
  signal ptr_deref_130_gather_scatter_req_0 : boolean;
  signal ptr_deref_130_gather_scatter_ack_0 : boolean;
  signal ptr_deref_162_base_resize_ack_0 : boolean;
  signal ptr_deref_130_store_0_req_0 : boolean;
  signal ptr_deref_130_store_0_ack_0 : boolean;
  signal ptr_deref_162_base_resize_req_0 : boolean;
  signal ptr_deref_130_store_0_req_1 : boolean;
  signal ptr_deref_130_store_0_ack_1 : boolean;
  signal ptr_deref_158_gather_scatter_ack_0 : boolean;
  signal ptr_deref_137_base_resize_req_0 : boolean;
  signal ptr_deref_137_base_resize_ack_0 : boolean;
  signal ptr_deref_137_root_address_inst_req_0 : boolean;
  signal ptr_deref_137_root_address_inst_ack_0 : boolean;
  signal ptr_deref_137_addr_0_req_0 : boolean;
  signal ptr_deref_137_addr_0_ack_0 : boolean;
  signal ptr_deref_137_gather_scatter_req_0 : boolean;
  signal ptr_deref_137_gather_scatter_ack_0 : boolean;
  signal ptr_deref_137_store_0_req_0 : boolean;
  signal ptr_deref_137_store_0_ack_0 : boolean;
  signal ptr_deref_137_store_0_req_1 : boolean;
  signal ptr_deref_137_store_0_ack_1 : boolean;
  signal RPIPE_in_data_141_inst_req_0 : boolean;
  signal RPIPE_in_data_141_inst_ack_0 : boolean;
  signal RPIPE_in_data_141_inst_req_1 : boolean;
  signal RPIPE_in_data_141_inst_ack_1 : boolean;
  signal ptr_deref_144_base_resize_req_0 : boolean;
  signal ptr_deref_144_base_resize_ack_0 : boolean;
  signal ptr_deref_144_root_address_inst_req_0 : boolean;
  signal ptr_deref_144_root_address_inst_ack_0 : boolean;
  signal ptr_deref_144_addr_0_req_0 : boolean;
  signal ptr_deref_144_addr_0_ack_0 : boolean;
  signal ptr_deref_144_gather_scatter_req_0 : boolean;
  signal ptr_deref_144_gather_scatter_ack_0 : boolean;
  signal ptr_deref_144_store_0_req_0 : boolean;
  signal ptr_deref_144_store_0_ack_0 : boolean;
  signal ptr_deref_144_store_0_req_1 : boolean;
  signal ptr_deref_144_store_0_ack_1 : boolean;
  signal RPIPE_in_data_148_inst_req_0 : boolean;
  signal RPIPE_in_data_148_inst_ack_0 : boolean;
  signal RPIPE_in_data_148_inst_req_1 : boolean;
  signal RPIPE_in_data_148_inst_ack_1 : boolean;
  signal ptr_deref_151_base_resize_req_0 : boolean;
  signal ptr_deref_151_base_resize_ack_0 : boolean;
  signal ptr_deref_151_root_address_inst_req_0 : boolean;
  signal ptr_deref_151_root_address_inst_ack_0 : boolean;
  signal ptr_deref_151_addr_0_req_0 : boolean;
  signal ptr_deref_151_addr_0_ack_0 : boolean;
  signal ptr_deref_151_gather_scatter_req_0 : boolean;
  signal ptr_deref_151_gather_scatter_ack_0 : boolean;
  signal ptr_deref_151_store_0_req_0 : boolean;
  signal ptr_deref_151_store_0_ack_0 : boolean;
  signal ptr_deref_151_store_0_req_1 : boolean;
  signal ptr_deref_151_store_0_ack_1 : boolean;
  signal RPIPE_in_data_155_inst_req_0 : boolean;
  signal RPIPE_in_data_155_inst_ack_0 : boolean;
  signal RPIPE_in_data_155_inst_req_1 : boolean;
  signal RPIPE_in_data_155_inst_ack_1 : boolean;
  signal ptr_deref_158_base_resize_req_0 : boolean;
  signal ptr_deref_158_base_resize_ack_0 : boolean;
  signal ptr_deref_158_root_address_inst_req_0 : boolean;
  signal ptr_deref_158_root_address_inst_ack_0 : boolean;
  signal ptr_deref_158_addr_0_req_0 : boolean;
  signal ptr_deref_158_addr_0_ack_0 : boolean;
  -- 
begin --  
  -- input handling ------------------------------------------------
  in_buffer: UnloadBuffer -- 
    generic map(name => "hardware1_input_buffer", -- 
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
  hardware1_CP_26_start <= in_buffer_unload_ack_symbol;
  -- output handling  -------------------------------------------------------
  out_buffer: ReceiveBuffer -- 
    generic map(name => "hardware1_out_buffer", -- 
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
    preds <= hardware1_CP_26_symbol & out_buffer_write_ack_symbol & tag_ilock_read_ack_symbol;
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
    preds <= hardware1_CP_26_start & tag_ilock_write_ack_symbol;
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
    preds <= hardware1_CP_26_start & tag_ilock_read_ack_symbol & out_buffer_write_ack_symbol;
    gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_read_req_symbol, clk => clk, reset => reset); --
  end block;
  -- the control path --------------------------------------------------
  always_true_symbol <= true; 
  default_zero_sig <= '0';
  hardware1_CP_26: Block -- control-path 
    signal hardware1_CP_26_elements: BooleanArray(249 downto 0);
    -- 
  begin -- 
    hardware1_CP_26_elements(0) <= hardware1_CP_26_start;
    hardware1_CP_26_symbol <= hardware1_CP_26_elements(1);
    -- CP-element group 0 transition  place  bypass 
    -- predecessors 
    -- successors 5 
    -- members (4) 
      -- 	$entry
      -- 	branch_block_stmt_18/$entry
      -- 	branch_block_stmt_18/branch_block_stmt_18__entry__
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44__entry__
      -- 
    -- CP-element group 1 transition  place  bypass 
    -- predecessors 
    -- successors 
    -- members (3) 
      -- 	$exit
      -- 	branch_block_stmt_18/$exit
      -- 	branch_block_stmt_18/branch_block_stmt_18__exit__
      -- 
    hardware1_CP_26_elements(1) <= false; 
    -- CP-element group 2 fork  transition  place  bypass 
    -- predecessors 24 
    -- successors 239 240 
    -- members (7) 
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44__exit__
      -- 	branch_block_stmt_18/bb_0_bb_1
      -- 	branch_block_stmt_18/bb_0_bb_1_PhiReq/phi_stmt_47/$entry
      -- 	branch_block_stmt_18/bb_0_bb_1_PhiReq/$entry
      -- 	branch_block_stmt_18/bb_0_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/type_cast_53/SplitProtocol/$entry
      -- 	branch_block_stmt_18/bb_0_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/type_cast_53/$entry
      -- 	branch_block_stmt_18/bb_0_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/$entry
      -- 
    hardware1_CP_26_elements(2) <= hardware1_CP_26_elements(24);
    -- CP-element group 3 place  bypass 
    -- predecessors 119 
    -- successors 120 
    -- members (2) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118__exit__
      -- 	branch_block_stmt_18/assign_stmt_121__entry__
      -- 
    hardware1_CP_26_elements(3) <= hardware1_CP_26_elements(119);
    -- CP-element group 4 place  bypass 
    -- predecessors 233 
    -- successors 234 
    -- members (2) 
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165__exit__
      -- 	branch_block_stmt_18/assign_stmt_168__entry__
      -- 
    hardware1_CP_26_elements(4) <= hardware1_CP_26_elements(233);
    -- CP-element group 5 fork  transition  bypass 
    -- predecessors 0 
    -- successors 7 16 6 15 
    -- members (1) 
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/$entry
      -- 
    hardware1_CP_26_elements(5) <= hardware1_CP_26_elements(0);
    -- CP-element group 6 transition  output  bypass 
    -- predecessors 5 
    -- successors 13 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_update_start_
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_Update/word_access_complete/$entry
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_Update/word_access_complete/word_0/$entry
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_Update/word_access_complete/word_0/cr
      -- 
    hardware1_CP_26_elements(6) <= hardware1_CP_26_elements(5);
    cr_122_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(6), ack => ptr_deref_28_store_0_req_1); -- 
    -- CP-element group 7 transition  output  bypass 
    -- predecessors 5 
    -- successors 8 
    -- members (7) 
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_base_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/R_iNsTr_0_27_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/R_iNsTr_0_27_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/R_iNsTr_0_27_update_start_
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/R_iNsTr_0_27_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_base_addr_resize/$entry
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_base_addr_resize/base_resize_req
      -- 
    hardware1_CP_26_elements(7) <= hardware1_CP_26_elements(5);
    base_resize_req_85_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(7), ack => ptr_deref_28_base_resize_req_0); -- 
    -- CP-element group 8 transition  input  output  bypass 
    -- predecessors 7 
    -- successors 9 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_base_address_resized
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_base_addr_resize/$exit
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_base_addr_resize/base_resize_ack
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_base_plus_offset/$entry
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_base_plus_offset/sum_rename_req
      -- 
    base_resize_ack_86_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_28_base_resize_ack_0, ack => hardware1_CP_26_elements(8)); -- 
    sum_rename_req_90_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(8), ack => ptr_deref_28_root_address_inst_req_0); -- 
    -- CP-element group 9 transition  input  output  bypass 
    -- predecessors 8 
    -- successors 10 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_root_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_base_plus_offset/$exit
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_base_plus_offset/sum_rename_ack
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_word_addrgen/$entry
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_word_addrgen/root_register_req
      -- 
    sum_rename_ack_91_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_28_root_address_inst_ack_0, ack => hardware1_CP_26_elements(9)); -- 
    root_register_req_95_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(9), ack => ptr_deref_28_addr_0_req_0); -- 
    -- CP-element group 10 transition  input  output  bypass 
    -- predecessors 9 
    -- successors 11 
    -- members (7) 
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_word_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_word_addrgen/$exit
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_word_addrgen/root_register_ack
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_Sample/ptr_deref_28_Split/$entry
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_Sample/ptr_deref_28_Split/split_req
      -- 
    root_register_ack_96_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_28_addr_0_ack_0, ack => hardware1_CP_26_elements(10)); -- 
    split_req_103_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(10), ack => ptr_deref_28_gather_scatter_req_0); -- 
    -- CP-element group 11 transition  input  output  bypass 
    -- predecessors 10 
    -- successors 12 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_Sample/ptr_deref_28_Split/$exit
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_Sample/ptr_deref_28_Split/split_ack
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_Sample/word_access_start/$entry
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_Sample/word_access_start/word_0/$entry
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_Sample/word_access_start/word_0/rr
      -- 
    split_ack_104_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_28_gather_scatter_ack_0, ack => hardware1_CP_26_elements(11)); -- 
    rr_111_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(11), ack => ptr_deref_28_store_0_req_0); -- 
    -- CP-element group 12 transition  input  bypass 
    -- predecessors 11 
    -- successors 23 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_Sample/word_access_start/$exit
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_Sample/word_access_start/word_0/$exit
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_Sample/word_access_start/word_0/ra
      -- 
    ra_112_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_28_store_0_ack_0, ack => hardware1_CP_26_elements(12)); -- 
    -- CP-element group 13 transition  input  bypass 
    -- predecessors 6 
    -- successors 24 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_Update/word_access_complete/$exit
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_Update/word_access_complete/word_0/$exit
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_Update/word_access_complete/word_0/ca
      -- 
    ca_123_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_28_store_0_ack_1, ack => hardware1_CP_26_elements(13)); -- 
    -- CP-element group 14 join  transition  output  bypass 
    -- predecessors 23 19 
    -- successors 20 
    -- members (4) 
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_Sample/ptr_deref_41_Split/$entry
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_Sample/ptr_deref_41_Split/split_req
      -- 
    cp_element_group_14: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 19) := "cp_element_group_14"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= hardware1_CP_26_elements(23) & hardware1_CP_26_elements(19);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => hardware1_CP_26_elements(14), clk => clk, reset => reset); --
    end block;
    split_req_157_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(14), ack => ptr_deref_41_gather_scatter_req_0); -- 
    -- CP-element group 15 transition  output  bypass 
    -- predecessors 5 
    -- successors 22 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_update_start_
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_Update/word_access_complete/$entry
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_Update/word_access_complete/word_0/$entry
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_Update/word_access_complete/word_0/cr
      -- 
    hardware1_CP_26_elements(15) <= hardware1_CP_26_elements(5);
    cr_176_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(15), ack => ptr_deref_41_store_0_req_1); -- 
    -- CP-element group 16 transition  output  bypass 
    -- predecessors 5 
    -- successors 17 
    -- members (7) 
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_base_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/R_iNsTr_2_40_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/R_iNsTr_2_40_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/R_iNsTr_2_40_update_start_
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/R_iNsTr_2_40_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_base_addr_resize/$entry
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_base_addr_resize/base_resize_req
      -- 
    hardware1_CP_26_elements(16) <= hardware1_CP_26_elements(5);
    base_resize_req_139_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(16), ack => ptr_deref_41_base_resize_req_0); -- 
    -- CP-element group 17 transition  input  output  bypass 
    -- predecessors 16 
    -- successors 18 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_base_address_resized
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_base_addr_resize/$exit
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_base_addr_resize/base_resize_ack
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_base_plus_offset/$entry
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_base_plus_offset/sum_rename_req
      -- 
    base_resize_ack_140_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_41_base_resize_ack_0, ack => hardware1_CP_26_elements(17)); -- 
    sum_rename_req_144_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(17), ack => ptr_deref_41_root_address_inst_req_0); -- 
    -- CP-element group 18 transition  input  output  bypass 
    -- predecessors 17 
    -- successors 19 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_root_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_base_plus_offset/$exit
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_base_plus_offset/sum_rename_ack
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_word_addrgen/$entry
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_word_addrgen/root_register_req
      -- 
    sum_rename_ack_145_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_41_root_address_inst_ack_0, ack => hardware1_CP_26_elements(18)); -- 
    root_register_req_149_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(18), ack => ptr_deref_41_addr_0_req_0); -- 
    -- CP-element group 19 transition  input  bypass 
    -- predecessors 18 
    -- successors 14 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_word_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_word_addrgen/$exit
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_word_addrgen/root_register_ack
      -- 
    root_register_ack_150_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_41_addr_0_ack_0, ack => hardware1_CP_26_elements(19)); -- 
    -- CP-element group 20 transition  input  output  bypass 
    -- predecessors 14 
    -- successors 21 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_Sample/ptr_deref_41_Split/$exit
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_Sample/ptr_deref_41_Split/split_ack
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_Sample/word_access_start/$entry
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_Sample/word_access_start/word_0/$entry
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_Sample/word_access_start/word_0/rr
      -- 
    split_ack_158_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_41_gather_scatter_ack_0, ack => hardware1_CP_26_elements(20)); -- 
    rr_165_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(20), ack => ptr_deref_41_store_0_req_0); -- 
    -- CP-element group 21 transition  input  bypass 
    -- predecessors 20 
    -- successors 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_Sample/word_access_start/$exit
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_Sample/word_access_start/word_0/$exit
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_Sample/word_access_start/word_0/ra
      -- 
    ra_166_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_41_store_0_ack_0, ack => hardware1_CP_26_elements(21)); -- 
    -- CP-element group 22 transition  input  bypass 
    -- predecessors 15 
    -- successors 24 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_Update/word_access_complete/$exit
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_Update/word_access_complete/word_0/$exit
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_41_Update/word_access_complete/word_0/ca
      -- 
    ca_177_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_41_store_0_ack_1, ack => hardware1_CP_26_elements(22)); -- 
    -- CP-element group 23 transition  bypass 
    -- predecessors 12 
    -- successors 14 
    -- members (1) 
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/ptr_deref_28_ptr_deref_41_delay
      -- 
    -- Element group hardware1_CP_26_elements(23) is a control-delay.
    cp_element_23_delay: control_delay_element  generic map(delay_value => 1)  port map(req => hardware1_CP_26_elements(12), ack => hardware1_CP_26_elements(23), clk => clk, reset =>reset);
    -- CP-element group 24 join  transition  bypass 
    -- predecessors 22 13 
    -- successors 2 
    -- members (1) 
      -- 	branch_block_stmt_18/assign_stmt_26_to_assign_stmt_44/$exit
      -- 
    cp_element_group_24: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 19) := "cp_element_group_24"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= hardware1_CP_26_elements(22) & hardware1_CP_26_elements(13);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => hardware1_CP_26_elements(24), clk => clk, reset => reset); --
    end block;
    -- CP-element group 25 fork  transition  bypass 
    -- predecessors 249 
    -- successors 56 86 87 89 92 98 99 101 108 62 63 65 68 74 75 77 80 44 38 50 39 27 51 29 53 32 26 41 111 112 115 116 
    -- members (1) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/$entry
      -- 
    hardware1_CP_26_elements(25) <= hardware1_CP_26_elements(249);
    -- CP-element group 26 transition  output  bypass 
    -- predecessors 25 
    -- successors 37 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_60_update_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_60_complete/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_60_complete/req
      -- 
    hardware1_CP_26_elements(26) <= hardware1_CP_26_elements(25);
    req_238_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(26), ack => addr_of_60_final_reg_req_1); -- 
    -- CP-element group 27 transition  output  bypass 
    -- predecessors 25 
    -- successors 28 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_index_resize_0/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_index_resize_0/index_resize_req
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_56_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_56_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_56_update_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_56_update_completed_
      -- 
    hardware1_CP_26_elements(27) <= hardware1_CP_26_elements(25);
    index_resize_req_197_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(27), ack => array_obj_ref_59_index_0_resize_req_0); -- 
    -- CP-element group 28 transition  input  output  bypass 
    -- predecessors 27 
    -- successors 30 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_index_resize_0/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_index_resized_0
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_index_resize_0/index_resize_ack
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_index_scale_0_sample_start
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_index_scale_0_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_index_scale_0_Sample/rr
      -- 
    index_resize_ack_198_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_59_index_0_resize_ack_0, ack => hardware1_CP_26_elements(28)); -- 
    rr_206_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(28), ack => array_obj_ref_59_index_0_scale_req_0); -- 
    -- CP-element group 29 transition  output  bypass 
    -- predecessors 25 
    -- successors 31 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_index_scale_0_update_start
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_index_scale_0_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_index_scale_0_Update/cr
      -- 
    hardware1_CP_26_elements(29) <= hardware1_CP_26_elements(25);
    cr_211_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(29), ack => array_obj_ref_59_index_0_scale_req_1); -- 
    -- CP-element group 30 transition  input  bypass 
    -- predecessors 28 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_index_scale_0_sample_complete
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_index_scale_0_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_index_scale_0_Sample/ra
      -- 
    ra_207_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_59_index_0_scale_ack_0, ack => hardware1_CP_26_elements(30)); -- 
    -- CP-element group 31 transition  input  output  bypass 
    -- predecessors 29 
    -- successors 33 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_index_scaled_0
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_index_scale_0_update_complete
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_index_scale_0_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_index_scale_0_Update/ca
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_final_index_sum_regn_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_final_index_sum_regn_Sample/req
      -- 
    ca_212_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_59_index_0_scale_ack_1, ack => hardware1_CP_26_elements(31)); -- 
    req_218_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(31), ack => array_obj_ref_59_index_offset_req_0); -- 
    -- CP-element group 32 transition  output  bypass 
    -- predecessors 25 
    -- successors 34 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_final_index_sum_regn_update_start
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_final_index_sum_regn_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_final_index_sum_regn_Update/req
      -- 
    hardware1_CP_26_elements(32) <= hardware1_CP_26_elements(25);
    req_223_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(32), ack => array_obj_ref_59_index_offset_req_1); -- 
    -- CP-element group 33 transition  input  bypass 
    -- predecessors 31 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_final_index_sum_regn_sample_complete
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_final_index_sum_regn_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_final_index_sum_regn_Sample/ack
      -- 
    ack_219_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_59_index_offset_ack_0, ack => hardware1_CP_26_elements(33)); -- 
    -- CP-element group 34 transition  input  output  bypass 
    -- predecessors 32 
    -- successors 35 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_offset_calculated
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_final_index_sum_regn_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_final_index_sum_regn_Update/ack
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_base_plus_offset/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_base_plus_offset/sum_rename_req
      -- 
    ack_224_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_59_index_offset_ack_1, ack => hardware1_CP_26_elements(34)); -- 
    sum_rename_req_228_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(34), ack => array_obj_ref_59_root_address_inst_req_0); -- 
    -- CP-element group 35 transition  input  output  bypass 
    -- predecessors 34 
    -- successors 36 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_60_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_root_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_base_plus_offset/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_59_base_plus_offset/sum_rename_ack
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_60_request/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_60_request/req
      -- 
    sum_rename_ack_229_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_59_root_address_inst_ack_0, ack => hardware1_CP_26_elements(35)); -- 
    req_233_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(35), ack => addr_of_60_final_reg_req_0); -- 
    -- CP-element group 36 transition  input  bypass 
    -- predecessors 35 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_60_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_60_request/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_60_request/ack
      -- 
    ack_234_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => addr_of_60_final_reg_ack_0, ack => hardware1_CP_26_elements(36)); -- 
    -- CP-element group 37 transition  input  bypass 
    -- predecessors 26 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_60_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_60_complete/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_60_complete/ack
      -- 
    ack_239_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => addr_of_60_final_reg_ack_1, ack => hardware1_CP_26_elements(37)); -- 
    -- CP-element group 38 transition  output  bypass 
    -- predecessors 25 
    -- successors 49 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_67_update_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_67_complete/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_67_complete/req
      -- 
    hardware1_CP_26_elements(38) <= hardware1_CP_26_elements(25);
    req_296_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(38), ack => addr_of_67_final_reg_req_1); -- 
    -- CP-element group 39 transition  output  bypass 
    -- predecessors 25 
    -- successors 40 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_63_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_63_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_63_update_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_63_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_index_resize_0/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_index_resize_0/index_resize_req
      -- 
    hardware1_CP_26_elements(39) <= hardware1_CP_26_elements(25);
    index_resize_req_255_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(39), ack => array_obj_ref_66_index_0_resize_req_0); -- 
    -- CP-element group 40 transition  input  output  bypass 
    -- predecessors 39 
    -- successors 42 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_index_resized_0
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_index_resize_0/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_index_resize_0/index_resize_ack
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_index_scale_0_sample_start
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_index_scale_0_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_index_scale_0_Sample/rr
      -- 
    index_resize_ack_256_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_66_index_0_resize_ack_0, ack => hardware1_CP_26_elements(40)); -- 
    rr_264_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(40), ack => array_obj_ref_66_index_0_scale_req_0); -- 
    -- CP-element group 41 transition  output  bypass 
    -- predecessors 25 
    -- successors 43 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_index_scale_0_update_start
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_index_scale_0_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_index_scale_0_Update/cr
      -- 
    hardware1_CP_26_elements(41) <= hardware1_CP_26_elements(25);
    cr_269_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(41), ack => array_obj_ref_66_index_0_scale_req_1); -- 
    -- CP-element group 42 transition  input  bypass 
    -- predecessors 40 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_index_scale_0_sample_complete
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_index_scale_0_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_index_scale_0_Sample/ra
      -- 
    ra_265_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_66_index_0_scale_ack_0, ack => hardware1_CP_26_elements(42)); -- 
    -- CP-element group 43 transition  input  output  bypass 
    -- predecessors 41 
    -- successors 45 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_index_scaled_0
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_index_scale_0_update_complete
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_index_scale_0_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_index_scale_0_Update/ca
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_final_index_sum_regn_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_final_index_sum_regn_Sample/req
      -- 
    ca_270_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_66_index_0_scale_ack_1, ack => hardware1_CP_26_elements(43)); -- 
    req_276_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(43), ack => array_obj_ref_66_index_offset_req_0); -- 
    -- CP-element group 44 transition  output  bypass 
    -- predecessors 25 
    -- successors 46 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_final_index_sum_regn_update_start
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_final_index_sum_regn_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_final_index_sum_regn_Update/req
      -- 
    hardware1_CP_26_elements(44) <= hardware1_CP_26_elements(25);
    req_281_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(44), ack => array_obj_ref_66_index_offset_req_1); -- 
    -- CP-element group 45 transition  input  bypass 
    -- predecessors 43 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_final_index_sum_regn_sample_complete
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_final_index_sum_regn_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_final_index_sum_regn_Sample/ack
      -- 
    ack_277_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_66_index_offset_ack_0, ack => hardware1_CP_26_elements(45)); -- 
    -- CP-element group 46 transition  input  output  bypass 
    -- predecessors 44 
    -- successors 47 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_offset_calculated
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_final_index_sum_regn_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_final_index_sum_regn_Update/ack
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_base_plus_offset/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_base_plus_offset/sum_rename_req
      -- 
    ack_282_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_66_index_offset_ack_1, ack => hardware1_CP_26_elements(46)); -- 
    sum_rename_req_286_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(46), ack => array_obj_ref_66_root_address_inst_req_0); -- 
    -- CP-element group 47 transition  input  output  bypass 
    -- predecessors 46 
    -- successors 48 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_67_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_root_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_base_plus_offset/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_66_base_plus_offset/sum_rename_ack
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_67_request/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_67_request/req
      -- 
    sum_rename_ack_287_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_66_root_address_inst_ack_0, ack => hardware1_CP_26_elements(47)); -- 
    req_291_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(47), ack => addr_of_67_final_reg_req_0); -- 
    -- CP-element group 48 transition  input  bypass 
    -- predecessors 47 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_67_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_67_request/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_67_request/ack
      -- 
    ack_292_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => addr_of_67_final_reg_ack_0, ack => hardware1_CP_26_elements(48)); -- 
    -- CP-element group 49 transition  input  bypass 
    -- predecessors 38 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_67_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_67_complete/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_67_complete/ack
      -- 
    ack_297_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => addr_of_67_final_reg_ack_1, ack => hardware1_CP_26_elements(49)); -- 
    -- CP-element group 50 transition  output  bypass 
    -- predecessors 25 
    -- successors 61 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_74_update_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_74_complete/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_74_complete/req
      -- 
    hardware1_CP_26_elements(50) <= hardware1_CP_26_elements(25);
    req_354_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(50), ack => addr_of_74_final_reg_req_1); -- 
    -- CP-element group 51 transition  output  bypass 
    -- predecessors 25 
    -- successors 52 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_70_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_70_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_70_update_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_70_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_index_resize_0/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_index_resize_0/index_resize_req
      -- 
    hardware1_CP_26_elements(51) <= hardware1_CP_26_elements(25);
    index_resize_req_313_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(51), ack => array_obj_ref_73_index_0_resize_req_0); -- 
    -- CP-element group 52 transition  input  output  bypass 
    -- predecessors 51 
    -- successors 54 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_index_resized_0
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_index_resize_0/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_index_resize_0/index_resize_ack
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_index_scale_0_sample_start
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_index_scale_0_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_index_scale_0_Sample/rr
      -- 
    index_resize_ack_314_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_73_index_0_resize_ack_0, ack => hardware1_CP_26_elements(52)); -- 
    rr_322_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(52), ack => array_obj_ref_73_index_0_scale_req_0); -- 
    -- CP-element group 53 transition  output  bypass 
    -- predecessors 25 
    -- successors 55 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_index_scale_0_update_start
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_index_scale_0_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_index_scale_0_Update/cr
      -- 
    hardware1_CP_26_elements(53) <= hardware1_CP_26_elements(25);
    cr_327_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(53), ack => array_obj_ref_73_index_0_scale_req_1); -- 
    -- CP-element group 54 transition  input  bypass 
    -- predecessors 52 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_index_scale_0_sample_complete
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_index_scale_0_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_index_scale_0_Sample/ra
      -- 
    ra_323_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_73_index_0_scale_ack_0, ack => hardware1_CP_26_elements(54)); -- 
    -- CP-element group 55 transition  input  output  bypass 
    -- predecessors 53 
    -- successors 57 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_index_scaled_0
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_index_scale_0_update_complete
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_index_scale_0_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_index_scale_0_Update/ca
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_final_index_sum_regn_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_final_index_sum_regn_Sample/req
      -- 
    ca_328_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_73_index_0_scale_ack_1, ack => hardware1_CP_26_elements(55)); -- 
    req_334_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(55), ack => array_obj_ref_73_index_offset_req_0); -- 
    -- CP-element group 56 transition  output  bypass 
    -- predecessors 25 
    -- successors 58 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_final_index_sum_regn_update_start
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_final_index_sum_regn_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_final_index_sum_regn_Update/req
      -- 
    hardware1_CP_26_elements(56) <= hardware1_CP_26_elements(25);
    req_339_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(56), ack => array_obj_ref_73_index_offset_req_1); -- 
    -- CP-element group 57 transition  input  bypass 
    -- predecessors 55 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_final_index_sum_regn_sample_complete
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_final_index_sum_regn_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_final_index_sum_regn_Sample/ack
      -- 
    ack_335_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_73_index_offset_ack_0, ack => hardware1_CP_26_elements(57)); -- 
    -- CP-element group 58 transition  input  output  bypass 
    -- predecessors 56 
    -- successors 59 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_offset_calculated
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_final_index_sum_regn_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_final_index_sum_regn_Update/ack
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_base_plus_offset/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_base_plus_offset/sum_rename_req
      -- 
    ack_340_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_73_index_offset_ack_1, ack => hardware1_CP_26_elements(58)); -- 
    sum_rename_req_344_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(58), ack => array_obj_ref_73_root_address_inst_req_0); -- 
    -- CP-element group 59 transition  input  output  bypass 
    -- predecessors 58 
    -- successors 60 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_74_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_root_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_base_plus_offset/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_73_base_plus_offset/sum_rename_ack
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_74_request/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_74_request/req
      -- 
    sum_rename_ack_345_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_73_root_address_inst_ack_0, ack => hardware1_CP_26_elements(59)); -- 
    req_349_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(59), ack => addr_of_74_final_reg_req_0); -- 
    -- CP-element group 60 transition  input  bypass 
    -- predecessors 59 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_74_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_74_request/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_74_request/ack
      -- 
    ack_350_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => addr_of_74_final_reg_ack_0, ack => hardware1_CP_26_elements(60)); -- 
    -- CP-element group 61 transition  input  bypass 
    -- predecessors 50 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_74_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_74_complete/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_74_complete/ack
      -- 
    ack_355_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => addr_of_74_final_reg_ack_1, ack => hardware1_CP_26_elements(61)); -- 
    -- CP-element group 62 transition  output  bypass 
    -- predecessors 25 
    -- successors 73 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_81_update_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_81_complete/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_81_complete/req
      -- 
    hardware1_CP_26_elements(62) <= hardware1_CP_26_elements(25);
    req_412_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(62), ack => addr_of_81_final_reg_req_1); -- 
    -- CP-element group 63 transition  output  bypass 
    -- predecessors 25 
    -- successors 64 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_77_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_77_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_77_update_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_77_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_index_resize_0/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_index_resize_0/index_resize_req
      -- 
    hardware1_CP_26_elements(63) <= hardware1_CP_26_elements(25);
    index_resize_req_371_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(63), ack => array_obj_ref_80_index_0_resize_req_0); -- 
    -- CP-element group 64 transition  input  output  bypass 
    -- predecessors 63 
    -- successors 66 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_index_resized_0
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_index_resize_0/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_index_resize_0/index_resize_ack
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_index_scale_0_sample_start
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_index_scale_0_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_index_scale_0_Sample/rr
      -- 
    index_resize_ack_372_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_80_index_0_resize_ack_0, ack => hardware1_CP_26_elements(64)); -- 
    rr_380_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(64), ack => array_obj_ref_80_index_0_scale_req_0); -- 
    -- CP-element group 65 transition  output  bypass 
    -- predecessors 25 
    -- successors 67 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_index_scale_0_update_start
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_index_scale_0_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_index_scale_0_Update/cr
      -- 
    hardware1_CP_26_elements(65) <= hardware1_CP_26_elements(25);
    cr_385_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(65), ack => array_obj_ref_80_index_0_scale_req_1); -- 
    -- CP-element group 66 transition  input  bypass 
    -- predecessors 64 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_index_scale_0_sample_complete
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_index_scale_0_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_index_scale_0_Sample/ra
      -- 
    ra_381_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_80_index_0_scale_ack_0, ack => hardware1_CP_26_elements(66)); -- 
    -- CP-element group 67 transition  input  output  bypass 
    -- predecessors 65 
    -- successors 69 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_final_index_sum_regn_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_final_index_sum_regn_Sample/req
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_index_scaled_0
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_index_scale_0_update_complete
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_index_scale_0_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_index_scale_0_Update/ca
      -- 
    ca_386_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_80_index_0_scale_ack_1, ack => hardware1_CP_26_elements(67)); -- 
    req_392_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(67), ack => array_obj_ref_80_index_offset_req_0); -- 
    -- CP-element group 68 transition  output  bypass 
    -- predecessors 25 
    -- successors 70 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_final_index_sum_regn_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_final_index_sum_regn_Update/req
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_final_index_sum_regn_update_start
      -- 
    hardware1_CP_26_elements(68) <= hardware1_CP_26_elements(25);
    req_397_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(68), ack => array_obj_ref_80_index_offset_req_1); -- 
    -- CP-element group 69 transition  input  bypass 
    -- predecessors 67 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_final_index_sum_regn_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_final_index_sum_regn_Sample/ack
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_final_index_sum_regn_sample_complete
      -- 
    ack_393_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_80_index_offset_ack_0, ack => hardware1_CP_26_elements(69)); -- 
    -- CP-element group 70 transition  input  output  bypass 
    -- predecessors 68 
    -- successors 71 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_final_index_sum_regn_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_final_index_sum_regn_Update/ack
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_base_plus_offset/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_base_plus_offset/sum_rename_req
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_offset_calculated
      -- 
    ack_398_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_80_index_offset_ack_1, ack => hardware1_CP_26_elements(70)); -- 
    sum_rename_req_402_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(70), ack => array_obj_ref_80_root_address_inst_req_0); -- 
    -- CP-element group 71 transition  input  output  bypass 
    -- predecessors 70 
    -- successors 72 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_base_plus_offset/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_81_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_root_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_80_base_plus_offset/sum_rename_ack
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_81_request/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_81_request/req
      -- 
    sum_rename_ack_403_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_80_root_address_inst_ack_0, ack => hardware1_CP_26_elements(71)); -- 
    req_407_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(71), ack => addr_of_81_final_reg_req_0); -- 
    -- CP-element group 72 transition  input  bypass 
    -- predecessors 71 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_81_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_81_request/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_81_request/ack
      -- 
    ack_408_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => addr_of_81_final_reg_ack_0, ack => hardware1_CP_26_elements(72)); -- 
    -- CP-element group 73 transition  input  bypass 
    -- predecessors 62 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_81_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_81_complete/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_81_complete/ack
      -- 
    ack_413_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => addr_of_81_final_reg_ack_1, ack => hardware1_CP_26_elements(73)); -- 
    -- CP-element group 74 transition  output  bypass 
    -- predecessors 25 
    -- successors 85 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_88_update_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_88_complete/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_88_complete/req
      -- 
    hardware1_CP_26_elements(74) <= hardware1_CP_26_elements(25);
    req_470_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(74), ack => addr_of_88_final_reg_req_1); -- 
    -- CP-element group 75 transition  output  bypass 
    -- predecessors 25 
    -- successors 76 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_84_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_84_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_84_update_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_84_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_index_resize_0/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_index_resize_0/index_resize_req
      -- 
    hardware1_CP_26_elements(75) <= hardware1_CP_26_elements(25);
    index_resize_req_429_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(75), ack => array_obj_ref_87_index_0_resize_req_0); -- 
    -- CP-element group 76 transition  input  output  bypass 
    -- predecessors 75 
    -- successors 78 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_index_resized_0
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_index_resize_0/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_index_resize_0/index_resize_ack
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_index_scale_0_sample_start
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_index_scale_0_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_index_scale_0_Sample/rr
      -- 
    index_resize_ack_430_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_87_index_0_resize_ack_0, ack => hardware1_CP_26_elements(76)); -- 
    rr_438_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(76), ack => array_obj_ref_87_index_0_scale_req_0); -- 
    -- CP-element group 77 transition  output  bypass 
    -- predecessors 25 
    -- successors 79 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_index_scale_0_update_start
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_index_scale_0_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_index_scale_0_Update/cr
      -- 
    hardware1_CP_26_elements(77) <= hardware1_CP_26_elements(25);
    cr_443_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(77), ack => array_obj_ref_87_index_0_scale_req_1); -- 
    -- CP-element group 78 transition  input  bypass 
    -- predecessors 76 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_index_scale_0_sample_complete
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_index_scale_0_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_index_scale_0_Sample/ra
      -- 
    ra_439_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_87_index_0_scale_ack_0, ack => hardware1_CP_26_elements(78)); -- 
    -- CP-element group 79 transition  input  output  bypass 
    -- predecessors 77 
    -- successors 81 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_index_scaled_0
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_index_scale_0_update_complete
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_index_scale_0_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_index_scale_0_Update/ca
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_final_index_sum_regn_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_final_index_sum_regn_Sample/req
      -- 
    ca_444_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_87_index_0_scale_ack_1, ack => hardware1_CP_26_elements(79)); -- 
    req_450_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(79), ack => array_obj_ref_87_index_offset_req_0); -- 
    -- CP-element group 80 transition  output  bypass 
    -- predecessors 25 
    -- successors 82 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_final_index_sum_regn_update_start
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_final_index_sum_regn_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_final_index_sum_regn_Update/req
      -- 
    hardware1_CP_26_elements(80) <= hardware1_CP_26_elements(25);
    req_455_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(80), ack => array_obj_ref_87_index_offset_req_1); -- 
    -- CP-element group 81 transition  input  bypass 
    -- predecessors 79 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_final_index_sum_regn_sample_complete
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_final_index_sum_regn_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_final_index_sum_regn_Sample/ack
      -- 
    ack_451_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_87_index_offset_ack_0, ack => hardware1_CP_26_elements(81)); -- 
    -- CP-element group 82 transition  input  output  bypass 
    -- predecessors 80 
    -- successors 83 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_offset_calculated
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_final_index_sum_regn_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_final_index_sum_regn_Update/ack
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_base_plus_offset/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_base_plus_offset/sum_rename_req
      -- 
    ack_456_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_87_index_offset_ack_1, ack => hardware1_CP_26_elements(82)); -- 
    sum_rename_req_460_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(82), ack => array_obj_ref_87_root_address_inst_req_0); -- 
    -- CP-element group 83 transition  input  output  bypass 
    -- predecessors 82 
    -- successors 84 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_88_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_root_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_base_plus_offset/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_87_base_plus_offset/sum_rename_ack
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_88_request/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_88_request/req
      -- 
    sum_rename_ack_461_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_87_root_address_inst_ack_0, ack => hardware1_CP_26_elements(83)); -- 
    req_465_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(83), ack => addr_of_88_final_reg_req_0); -- 
    -- CP-element group 84 transition  input  bypass 
    -- predecessors 83 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_88_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_88_request/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_88_request/ack
      -- 
    ack_466_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => addr_of_88_final_reg_ack_0, ack => hardware1_CP_26_elements(84)); -- 
    -- CP-element group 85 transition  input  bypass 
    -- predecessors 74 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_88_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_88_complete/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_88_complete/ack
      -- 
    ack_471_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => addr_of_88_final_reg_ack_1, ack => hardware1_CP_26_elements(85)); -- 
    -- CP-element group 86 transition  output  bypass 
    -- predecessors 25 
    -- successors 97 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_95_update_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_95_complete/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_95_complete/req
      -- 
    hardware1_CP_26_elements(86) <= hardware1_CP_26_elements(25);
    req_528_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(86), ack => addr_of_95_final_reg_req_1); -- 
    -- CP-element group 87 transition  output  bypass 
    -- predecessors 25 
    -- successors 88 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_91_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_91_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_91_update_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_91_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_index_resize_0/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_index_resize_0/index_resize_req
      -- 
    hardware1_CP_26_elements(87) <= hardware1_CP_26_elements(25);
    index_resize_req_487_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(87), ack => array_obj_ref_94_index_0_resize_req_0); -- 
    -- CP-element group 88 transition  input  output  bypass 
    -- predecessors 87 
    -- successors 90 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_index_resized_0
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_index_resize_0/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_index_resize_0/index_resize_ack
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_index_scale_0_sample_start
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_index_scale_0_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_index_scale_0_Sample/rr
      -- 
    index_resize_ack_488_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_94_index_0_resize_ack_0, ack => hardware1_CP_26_elements(88)); -- 
    rr_496_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(88), ack => array_obj_ref_94_index_0_scale_req_0); -- 
    -- CP-element group 89 transition  output  bypass 
    -- predecessors 25 
    -- successors 91 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_index_scale_0_update_start
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_index_scale_0_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_index_scale_0_Update/cr
      -- 
    hardware1_CP_26_elements(89) <= hardware1_CP_26_elements(25);
    cr_501_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(89), ack => array_obj_ref_94_index_0_scale_req_1); -- 
    -- CP-element group 90 transition  input  bypass 
    -- predecessors 88 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_index_scale_0_sample_complete
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_index_scale_0_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_index_scale_0_Sample/ra
      -- 
    ra_497_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_94_index_0_scale_ack_0, ack => hardware1_CP_26_elements(90)); -- 
    -- CP-element group 91 transition  input  output  bypass 
    -- predecessors 89 
    -- successors 93 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_index_scaled_0
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_index_scale_0_update_complete
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_index_scale_0_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_index_scale_0_Update/ca
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_final_index_sum_regn_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_final_index_sum_regn_Sample/req
      -- 
    ca_502_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_94_index_0_scale_ack_1, ack => hardware1_CP_26_elements(91)); -- 
    req_508_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(91), ack => array_obj_ref_94_index_offset_req_0); -- 
    -- CP-element group 92 transition  output  bypass 
    -- predecessors 25 
    -- successors 94 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_final_index_sum_regn_update_start
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_final_index_sum_regn_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_final_index_sum_regn_Update/req
      -- 
    hardware1_CP_26_elements(92) <= hardware1_CP_26_elements(25);
    req_513_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(92), ack => array_obj_ref_94_index_offset_req_1); -- 
    -- CP-element group 93 transition  input  bypass 
    -- predecessors 91 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_final_index_sum_regn_sample_complete
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_final_index_sum_regn_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_final_index_sum_regn_Sample/ack
      -- 
    ack_509_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_94_index_offset_ack_0, ack => hardware1_CP_26_elements(93)); -- 
    -- CP-element group 94 transition  input  output  bypass 
    -- predecessors 92 
    -- successors 95 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_offset_calculated
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_final_index_sum_regn_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_final_index_sum_regn_Update/ack
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_base_plus_offset/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_base_plus_offset/sum_rename_req
      -- 
    ack_514_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_94_index_offset_ack_1, ack => hardware1_CP_26_elements(94)); -- 
    sum_rename_req_518_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(94), ack => array_obj_ref_94_root_address_inst_req_0); -- 
    -- CP-element group 95 transition  input  output  bypass 
    -- predecessors 94 
    -- successors 96 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_95_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_root_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_base_plus_offset/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_94_base_plus_offset/sum_rename_ack
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_95_request/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_95_request/req
      -- 
    sum_rename_ack_519_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_94_root_address_inst_ack_0, ack => hardware1_CP_26_elements(95)); -- 
    req_523_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(95), ack => addr_of_95_final_reg_req_0); -- 
    -- CP-element group 96 transition  input  bypass 
    -- predecessors 95 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_95_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_95_request/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_95_request/ack
      -- 
    ack_524_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => addr_of_95_final_reg_ack_0, ack => hardware1_CP_26_elements(96)); -- 
    -- CP-element group 97 transition  input  bypass 
    -- predecessors 86 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_95_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_95_complete/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_95_complete/ack
      -- 
    ack_529_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => addr_of_95_final_reg_ack_1, ack => hardware1_CP_26_elements(97)); -- 
    -- CP-element group 98 transition  output  bypass 
    -- predecessors 25 
    -- successors 107 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_100_update_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_100_complete/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_100_complete/req
      -- 
    hardware1_CP_26_elements(98) <= hardware1_CP_26_elements(25);
    req_579_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(98), ack => addr_of_100_final_reg_req_1); -- 
    -- CP-element group 99 transition  output  bypass 
    -- predecessors 25 
    -- successors 100 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_98_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_98_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_98_update_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_98_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_index_resize_0/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_index_resize_0/index_resize_req
      -- 
    hardware1_CP_26_elements(99) <= hardware1_CP_26_elements(25);
    index_resize_req_545_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(99), ack => array_obj_ref_99_index_0_resize_req_0); -- 
    -- CP-element group 100 transition  input  output  bypass 
    -- predecessors 99 
    -- successors 102 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_index_resized_0
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_index_resize_0/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_index_resize_0/index_resize_ack
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_index_scale_0_sample_start
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_index_scale_0_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_index_scale_0_Sample/rr
      -- 
    index_resize_ack_546_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_99_index_0_resize_ack_0, ack => hardware1_CP_26_elements(100)); -- 
    rr_554_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(100), ack => array_obj_ref_99_index_0_scale_req_0); -- 
    -- CP-element group 101 transition  output  bypass 
    -- predecessors 25 
    -- successors 103 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_index_scale_0_update_start
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_index_scale_0_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_index_scale_0_Update/cr
      -- 
    hardware1_CP_26_elements(101) <= hardware1_CP_26_elements(25);
    cr_559_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(101), ack => array_obj_ref_99_index_0_scale_req_1); -- 
    -- CP-element group 102 transition  input  bypass 
    -- predecessors 100 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_index_scale_0_sample_complete
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_index_scale_0_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_index_scale_0_Sample/ra
      -- 
    ra_555_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_99_index_0_scale_ack_0, ack => hardware1_CP_26_elements(102)); -- 
    -- CP-element group 103 transition  input  output  bypass 
    -- predecessors 101 
    -- successors 104 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_index_scaled_0
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_index_scale_0_update_complete
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_index_scale_0_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_index_scale_0_Update/ca
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_final_index_sum_regn/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_final_index_sum_regn/req
      -- 
    ca_560_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_99_index_0_scale_ack_1, ack => hardware1_CP_26_elements(103)); -- 
    req_564_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(103), ack => array_obj_ref_99_index_offset_req_0); -- 
    -- CP-element group 104 transition  input  output  bypass 
    -- predecessors 103 
    -- successors 105 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_offset_calculated
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_final_index_sum_regn/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_final_index_sum_regn/ack
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_base_plus_offset/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_base_plus_offset/sum_rename_req
      -- 
    ack_565_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_99_index_offset_ack_0, ack => hardware1_CP_26_elements(104)); -- 
    sum_rename_req_569_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(104), ack => array_obj_ref_99_root_address_inst_req_0); -- 
    -- CP-element group 105 transition  input  output  bypass 
    -- predecessors 104 
    -- successors 106 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_100_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_root_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_base_plus_offset/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/array_obj_ref_99_base_plus_offset/sum_rename_ack
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_100_request/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_100_request/req
      -- 
    sum_rename_ack_570_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => array_obj_ref_99_root_address_inst_ack_0, ack => hardware1_CP_26_elements(105)); -- 
    req_574_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(105), ack => addr_of_100_final_reg_req_0); -- 
    -- CP-element group 106 transition  input  bypass 
    -- predecessors 105 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_100_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_100_request/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_100_request/ack
      -- 
    ack_575_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => addr_of_100_final_reg_ack_0, ack => hardware1_CP_26_elements(106)); -- 
    -- CP-element group 107 transition  input  output  bypass 
    -- predecessors 98 
    -- successors 109 
    -- members (10) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_100_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_100_complete/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/addr_of_100_complete/ack
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/type_cast_105_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_scevgep_104_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_scevgep_104_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_scevgep_104_update_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_scevgep_104_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/type_cast_105_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/type_cast_105_Sample/rr
      -- 
    ack_580_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => addr_of_100_final_reg_ack_1, ack => hardware1_CP_26_elements(107)); -- 
    rr_592_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(107), ack => type_cast_105_inst_req_0); -- 
    -- CP-element group 108 transition  output  bypass 
    -- predecessors 25 
    -- successors 110 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/type_cast_105_update_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/type_cast_105_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/type_cast_105_Update/cr
      -- 
    hardware1_CP_26_elements(108) <= hardware1_CP_26_elements(25);
    cr_597_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(108), ack => type_cast_105_inst_req_1); -- 
    -- CP-element group 109 transition  input  bypass 
    -- predecessors 107 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/type_cast_105_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/type_cast_105_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/type_cast_105_Sample/ra
      -- 
    ra_593_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => type_cast_105_inst_ack_0, ack => hardware1_CP_26_elements(109)); -- 
    -- CP-element group 110 transition  input  bypass 
    -- predecessors 108 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/type_cast_105_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/type_cast_105_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/type_cast_105_Update/ca
      -- 
    ca_598_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => type_cast_105_inst_ack_1, ack => hardware1_CP_26_elements(110)); -- 
    -- CP-element group 111 transition  output  bypass 
    -- predecessors 25 
    -- successors 114 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/ADD_u32_u32_111_update_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/ADD_u32_u32_111_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/ADD_u32_u32_111_Update/cr
      -- 
    hardware1_CP_26_elements(111) <= hardware1_CP_26_elements(25);
    cr_615_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(111), ack => ADD_u32_u32_111_inst_req_1); -- 
    -- CP-element group 112 transition  output  bypass 
    -- predecessors 25 
    -- successors 113 
    -- members (7) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/ADD_u32_u32_111_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_108_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_108_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_108_update_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_108_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/ADD_u32_u32_111_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/ADD_u32_u32_111_Sample/rr
      -- 
    hardware1_CP_26_elements(112) <= hardware1_CP_26_elements(25);
    rr_610_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(112), ack => ADD_u32_u32_111_inst_req_0); -- 
    -- CP-element group 113 transition  input  bypass 
    -- predecessors 112 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/ADD_u32_u32_111_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/ADD_u32_u32_111_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/ADD_u32_u32_111_Sample/ra
      -- 
    ra_611_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ADD_u32_u32_111_inst_ack_0, ack => hardware1_CP_26_elements(113)); -- 
    -- CP-element group 114 transition  input  bypass 
    -- predecessors 111 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/ADD_u32_u32_111_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/ADD_u32_u32_111_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/ADD_u32_u32_111_Update/ca
      -- 
    ca_616_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ADD_u32_u32_111_inst_ack_1, ack => hardware1_CP_26_elements(114)); -- 
    -- CP-element group 115 transition  output  bypass 
    -- predecessors 25 
    -- successors 118 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/ADD_u32_u32_117_update_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/ADD_u32_u32_117_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/ADD_u32_u32_117_Update/cr
      -- 
    hardware1_CP_26_elements(115) <= hardware1_CP_26_elements(25);
    cr_633_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(115), ack => ADD_u32_u32_117_inst_req_1); -- 
    -- CP-element group 116 transition  output  bypass 
    -- predecessors 25 
    -- successors 117 
    -- members (7) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/ADD_u32_u32_117_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_114_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_114_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_114_update_start_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/R_ix_x0_114_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/ADD_u32_u32_117_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/ADD_u32_u32_117_Sample/rr
      -- 
    hardware1_CP_26_elements(116) <= hardware1_CP_26_elements(25);
    rr_628_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(116), ack => ADD_u32_u32_117_inst_req_0); -- 
    -- CP-element group 117 transition  input  bypass 
    -- predecessors 116 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/ADD_u32_u32_117_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/ADD_u32_u32_117_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/ADD_u32_u32_117_Sample/ra
      -- 
    ra_629_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ADD_u32_u32_117_inst_ack_0, ack => hardware1_CP_26_elements(117)); -- 
    -- CP-element group 118 transition  input  bypass 
    -- predecessors 115 
    -- successors 119 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/ADD_u32_u32_117_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/ADD_u32_u32_117_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/ADD_u32_u32_117_Update/ca
      -- 
    ca_634_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ADD_u32_u32_117_inst_ack_1, ack => hardware1_CP_26_elements(118)); -- 
    -- CP-element group 119 join  transition  bypass 
    -- predecessors 57 60 61 90 93 96 97 102 106 66 69 72 73 78 81 84 85 49 37 30 45 48 36 54 42 33 110 114 118 
    -- successors 3 
    -- members (1) 
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118/$exit
      -- 
    cp_element_group_119: block -- 
      constant place_capacities: IntegerArray(0 to 28) := (0 => 1,1 => 1,2 => 1,3 => 1,4 => 1,5 => 1,6 => 1,7 => 1,8 => 1,9 => 1,10 => 1,11 => 1,12 => 1,13 => 1,14 => 1,15 => 1,16 => 1,17 => 1,18 => 1,19 => 1,20 => 1,21 => 1,22 => 1,23 => 1,24 => 1,25 => 1,26 => 1,27 => 1,28 => 1);
      constant place_markings: IntegerArray(0 to 28)  := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0,6 => 0,7 => 0,8 => 0,9 => 0,10 => 0,11 => 0,12 => 0,13 => 0,14 => 0,15 => 0,16 => 0,17 => 0,18 => 0,19 => 0,20 => 0,21 => 0,22 => 0,23 => 0,24 => 0,25 => 0,26 => 0,27 => 0,28 => 0);
      constant place_delays: IntegerArray(0 to 28) := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0,6 => 0,7 => 0,8 => 0,9 => 0,10 => 0,11 => 0,12 => 0,13 => 0,14 => 0,15 => 0,16 => 0,17 => 0,18 => 0,19 => 0,20 => 0,21 => 0,22 => 0,23 => 0,24 => 0,25 => 0,26 => 0,27 => 0,28 => 0);
      constant joinName: string(1 to 20) := "cp_element_group_119"; 
      signal preds: BooleanArray(1 to 29); -- 
    begin -- 
      preds <= hardware1_CP_26_elements(57) & hardware1_CP_26_elements(60) & hardware1_CP_26_elements(61) & hardware1_CP_26_elements(90) & hardware1_CP_26_elements(93) & hardware1_CP_26_elements(96) & hardware1_CP_26_elements(97) & hardware1_CP_26_elements(102) & hardware1_CP_26_elements(106) & hardware1_CP_26_elements(66) & hardware1_CP_26_elements(69) & hardware1_CP_26_elements(72) & hardware1_CP_26_elements(73) & hardware1_CP_26_elements(78) & hardware1_CP_26_elements(81) & hardware1_CP_26_elements(84) & hardware1_CP_26_elements(85) & hardware1_CP_26_elements(49) & hardware1_CP_26_elements(37) & hardware1_CP_26_elements(30) & hardware1_CP_26_elements(45) & hardware1_CP_26_elements(48) & hardware1_CP_26_elements(36) & hardware1_CP_26_elements(54) & hardware1_CP_26_elements(42) & hardware1_CP_26_elements(33) & hardware1_CP_26_elements(110) & hardware1_CP_26_elements(114) & hardware1_CP_26_elements(118);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => hardware1_CP_26_elements(119), clk => clk, reset => reset); --
    end block;
    -- CP-element group 120 fork  transition  bypass 
    -- predecessors 3 
    -- successors 121 122 
    -- members (1) 
      -- 	branch_block_stmt_18/assign_stmt_121/$entry
      -- 
    hardware1_CP_26_elements(120) <= hardware1_CP_26_elements(3);
    -- CP-element group 121 transition  output  bypass 
    -- predecessors 120 
    -- successors 123 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_121/RPIPE_in_data_120_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_121/RPIPE_in_data_120_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_121/RPIPE_in_data_120_Sample/rr
      -- 
    hardware1_CP_26_elements(121) <= hardware1_CP_26_elements(120);
    rr_645_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(121), ack => RPIPE_in_data_120_inst_req_0); -- 
    -- CP-element group 122 transition  output  bypass 
    -- predecessors 120 
    -- successors 124 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_121/RPIPE_in_data_120_update_start_
      -- 	branch_block_stmt_18/assign_stmt_121/RPIPE_in_data_120_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_121/RPIPE_in_data_120_Update/cr
      -- 
    hardware1_CP_26_elements(122) <= hardware1_CP_26_elements(120);
    cr_650_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(122), ack => RPIPE_in_data_120_inst_req_1); -- 
    -- CP-element group 123 transition  input  bypass 
    -- predecessors 121 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_121/RPIPE_in_data_120_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_121/RPIPE_in_data_120_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_121/RPIPE_in_data_120_Sample/ra
      -- 
    ra_646_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_120_inst_ack_0, ack => hardware1_CP_26_elements(123)); -- 
    -- CP-element group 124 transition  place  input  bypass 
    -- predecessors 122 
    -- successors 125 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_121__exit__
      -- 	branch_block_stmt_18/assign_stmt_125__entry__
      -- 	branch_block_stmt_18/assign_stmt_121/$exit
      -- 	branch_block_stmt_18/assign_stmt_121/RPIPE_in_data_120_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_121/RPIPE_in_data_120_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_121/RPIPE_in_data_120_Update/ca
      -- 
    ca_651_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_120_inst_ack_1, ack => hardware1_CP_26_elements(124)); -- 
    -- CP-element group 125 fork  transition  bypass 
    -- predecessors 124 
    -- successors 126 128 129 
    -- members (1) 
      -- 	branch_block_stmt_18/assign_stmt_125/$entry
      -- 
    hardware1_CP_26_elements(125) <= hardware1_CP_26_elements(124);
    -- CP-element group 126 transition  bypass 
    -- predecessors 125 
    -- successors 127 
    -- members (4) 
      -- 	branch_block_stmt_18/assign_stmt_125/R_iNsTr_7_124_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_125/R_iNsTr_7_124_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_125/R_iNsTr_7_124_update_start_
      -- 	branch_block_stmt_18/assign_stmt_125/R_iNsTr_7_124_update_completed_
      -- 
    hardware1_CP_26_elements(126) <= hardware1_CP_26_elements(125);
    -- CP-element group 127 join  transition  output  bypass 
    -- predecessors 126 129 133 
    -- successors 134 
    -- members (4) 
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_Sample/ptr_deref_123_Split/$entry
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_Sample/ptr_deref_123_Split/split_req
      -- 
    cp_element_group_127: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 20) := "cp_element_group_127"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= hardware1_CP_26_elements(126) & hardware1_CP_26_elements(129) & hardware1_CP_26_elements(133);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => hardware1_CP_26_elements(127), clk => clk, reset => reset); --
    end block;
    split_req_692_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(127), ack => ptr_deref_123_gather_scatter_req_0); -- 
    -- CP-element group 128 transition  output  bypass 
    -- predecessors 125 
    -- successors 136 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_update_start_
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_Update/word_access_complete/$entry
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_Update/word_access_complete/word_0/$entry
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_Update/word_access_complete/word_0/cr
      -- 
    hardware1_CP_26_elements(128) <= hardware1_CP_26_elements(125);
    cr_711_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(128), ack => ptr_deref_123_store_0_req_1); -- 
    -- CP-element group 129 fork  transition  bypass 
    -- predecessors 125 
    -- successors 127 130 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_base_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_125/R_scevgep7_122_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_125/R_scevgep7_122_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_125/R_scevgep7_122_update_start_
      -- 	branch_block_stmt_18/assign_stmt_125/R_scevgep7_122_update_completed_
      -- 
    hardware1_CP_26_elements(129) <= hardware1_CP_26_elements(125);
    -- CP-element group 130 transition  output  bypass 
    -- predecessors 129 
    -- successors 131 
    -- members (2) 
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_base_addr_resize/$entry
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_base_addr_resize/base_resize_req
      -- 
    hardware1_CP_26_elements(130) <= hardware1_CP_26_elements(129);
    base_resize_req_674_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(130), ack => ptr_deref_123_base_resize_req_0); -- 
    -- CP-element group 131 transition  input  output  bypass 
    -- predecessors 130 
    -- successors 132 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_base_address_resized
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_base_addr_resize/$exit
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_base_addr_resize/base_resize_ack
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_base_plus_offset/$entry
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_base_plus_offset/sum_rename_req
      -- 
    base_resize_ack_675_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_123_base_resize_ack_0, ack => hardware1_CP_26_elements(131)); -- 
    sum_rename_req_679_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(131), ack => ptr_deref_123_root_address_inst_req_0); -- 
    -- CP-element group 132 transition  input  output  bypass 
    -- predecessors 131 
    -- successors 133 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_root_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_base_plus_offset/$exit
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_base_plus_offset/sum_rename_ack
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_word_addrgen/$entry
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_word_addrgen/root_register_req
      -- 
    sum_rename_ack_680_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_123_root_address_inst_ack_0, ack => hardware1_CP_26_elements(132)); -- 
    root_register_req_684_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(132), ack => ptr_deref_123_addr_0_req_0); -- 
    -- CP-element group 133 transition  input  bypass 
    -- predecessors 132 
    -- successors 127 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_word_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_word_addrgen/$exit
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_word_addrgen/root_register_ack
      -- 
    root_register_ack_685_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_123_addr_0_ack_0, ack => hardware1_CP_26_elements(133)); -- 
    -- CP-element group 134 transition  input  output  bypass 
    -- predecessors 127 
    -- successors 135 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_Sample/ptr_deref_123_Split/$exit
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_Sample/ptr_deref_123_Split/split_ack
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_Sample/word_access_start/$entry
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_Sample/word_access_start/word_0/$entry
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_Sample/word_access_start/word_0/rr
      -- 
    split_ack_693_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_123_gather_scatter_ack_0, ack => hardware1_CP_26_elements(134)); -- 
    rr_700_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(134), ack => ptr_deref_123_store_0_req_0); -- 
    -- CP-element group 135 transition  input  bypass 
    -- predecessors 134 
    -- successors 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_Sample/word_access_start/$exit
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_Sample/word_access_start/word_0/$exit
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_Sample/word_access_start/word_0/ra
      -- 
    ra_701_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_123_store_0_ack_0, ack => hardware1_CP_26_elements(135)); -- 
    -- CP-element group 136 transition  place  input  bypass 
    -- predecessors 128 
    -- successors 137 
    -- members (8) 
      -- 	branch_block_stmt_18/assign_stmt_125__exit__
      -- 	branch_block_stmt_18/assign_stmt_128__entry__
      -- 	branch_block_stmt_18/assign_stmt_125/$exit
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_Update/word_access_complete/$exit
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_Update/word_access_complete/word_0/$exit
      -- 	branch_block_stmt_18/assign_stmt_125/ptr_deref_123_Update/word_access_complete/word_0/ca
      -- 
    ca_712_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_123_store_0_ack_1, ack => hardware1_CP_26_elements(136)); -- 
    -- CP-element group 137 fork  transition  bypass 
    -- predecessors 136 
    -- successors 138 139 
    -- members (1) 
      -- 	branch_block_stmt_18/assign_stmt_128/$entry
      -- 
    hardware1_CP_26_elements(137) <= hardware1_CP_26_elements(136);
    -- CP-element group 138 transition  output  bypass 
    -- predecessors 137 
    -- successors 140 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_128/RPIPE_in_data_127_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_128/RPIPE_in_data_127_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_128/RPIPE_in_data_127_Sample/rr
      -- 
    hardware1_CP_26_elements(138) <= hardware1_CP_26_elements(137);
    rr_723_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(138), ack => RPIPE_in_data_127_inst_req_0); -- 
    -- CP-element group 139 transition  output  bypass 
    -- predecessors 137 
    -- successors 141 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_128/RPIPE_in_data_127_update_start_
      -- 	branch_block_stmt_18/assign_stmt_128/RPIPE_in_data_127_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_128/RPIPE_in_data_127_Update/cr
      -- 
    hardware1_CP_26_elements(139) <= hardware1_CP_26_elements(137);
    cr_728_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(139), ack => RPIPE_in_data_127_inst_req_1); -- 
    -- CP-element group 140 transition  input  bypass 
    -- predecessors 138 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_128/RPIPE_in_data_127_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_128/RPIPE_in_data_127_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_128/RPIPE_in_data_127_Sample/ra
      -- 
    ra_724_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_127_inst_ack_0, ack => hardware1_CP_26_elements(140)); -- 
    -- CP-element group 141 transition  place  input  bypass 
    -- predecessors 139 
    -- successors 142 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_128__exit__
      -- 	branch_block_stmt_18/assign_stmt_132__entry__
      -- 	branch_block_stmt_18/assign_stmt_128/$exit
      -- 	branch_block_stmt_18/assign_stmt_128/RPIPE_in_data_127_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_128/RPIPE_in_data_127_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_128/RPIPE_in_data_127_Update/ca
      -- 
    ca_729_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_127_inst_ack_1, ack => hardware1_CP_26_elements(141)); -- 
    -- CP-element group 142 fork  transition  bypass 
    -- predecessors 141 
    -- successors 143 145 146 
    -- members (1) 
      -- 	branch_block_stmt_18/assign_stmt_132/$entry
      -- 
    hardware1_CP_26_elements(142) <= hardware1_CP_26_elements(141);
    -- CP-element group 143 transition  bypass 
    -- predecessors 142 
    -- successors 144 
    -- members (4) 
      -- 	branch_block_stmt_18/assign_stmt_132/R_iNsTr_10_131_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_132/R_iNsTr_10_131_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_132/R_iNsTr_10_131_update_start_
      -- 	branch_block_stmt_18/assign_stmt_132/R_iNsTr_10_131_update_completed_
      -- 
    hardware1_CP_26_elements(143) <= hardware1_CP_26_elements(142);
    -- CP-element group 144 join  transition  output  bypass 
    -- predecessors 143 146 150 
    -- successors 151 
    -- members (4) 
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_Sample/ptr_deref_130_Split/$entry
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_Sample/ptr_deref_130_Split/split_req
      -- 
    cp_element_group_144: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 20) := "cp_element_group_144"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= hardware1_CP_26_elements(143) & hardware1_CP_26_elements(146) & hardware1_CP_26_elements(150);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => hardware1_CP_26_elements(144), clk => clk, reset => reset); --
    end block;
    split_req_770_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(144), ack => ptr_deref_130_gather_scatter_req_0); -- 
    -- CP-element group 145 transition  output  bypass 
    -- predecessors 142 
    -- successors 153 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_update_start_
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_Update/word_access_complete/$entry
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_Update/word_access_complete/word_0/$entry
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_Update/word_access_complete/word_0/cr
      -- 
    hardware1_CP_26_elements(145) <= hardware1_CP_26_elements(142);
    cr_789_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(145), ack => ptr_deref_130_store_0_req_1); -- 
    -- CP-element group 146 fork  transition  bypass 
    -- predecessors 142 
    -- successors 144 147 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_base_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_132/R_scevgep6_129_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_132/R_scevgep6_129_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_132/R_scevgep6_129_update_start_
      -- 	branch_block_stmt_18/assign_stmt_132/R_scevgep6_129_update_completed_
      -- 
    hardware1_CP_26_elements(146) <= hardware1_CP_26_elements(142);
    -- CP-element group 147 transition  output  bypass 
    -- predecessors 146 
    -- successors 148 
    -- members (2) 
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_base_addr_resize/$entry
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_base_addr_resize/base_resize_req
      -- 
    hardware1_CP_26_elements(147) <= hardware1_CP_26_elements(146);
    base_resize_req_752_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(147), ack => ptr_deref_130_base_resize_req_0); -- 
    -- CP-element group 148 transition  input  output  bypass 
    -- predecessors 147 
    -- successors 149 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_base_address_resized
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_base_addr_resize/$exit
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_base_addr_resize/base_resize_ack
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_base_plus_offset/$entry
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_base_plus_offset/sum_rename_req
      -- 
    base_resize_ack_753_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_130_base_resize_ack_0, ack => hardware1_CP_26_elements(148)); -- 
    sum_rename_req_757_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(148), ack => ptr_deref_130_root_address_inst_req_0); -- 
    -- CP-element group 149 transition  input  output  bypass 
    -- predecessors 148 
    -- successors 150 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_root_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_base_plus_offset/$exit
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_base_plus_offset/sum_rename_ack
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_word_addrgen/$entry
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_word_addrgen/root_register_req
      -- 
    sum_rename_ack_758_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_130_root_address_inst_ack_0, ack => hardware1_CP_26_elements(149)); -- 
    root_register_req_762_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(149), ack => ptr_deref_130_addr_0_req_0); -- 
    -- CP-element group 150 transition  input  bypass 
    -- predecessors 149 
    -- successors 144 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_word_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_word_addrgen/$exit
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_word_addrgen/root_register_ack
      -- 
    root_register_ack_763_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_130_addr_0_ack_0, ack => hardware1_CP_26_elements(150)); -- 
    -- CP-element group 151 transition  input  output  bypass 
    -- predecessors 144 
    -- successors 152 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_Sample/ptr_deref_130_Split/$exit
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_Sample/ptr_deref_130_Split/split_ack
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_Sample/word_access_start/$entry
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_Sample/word_access_start/word_0/$entry
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_Sample/word_access_start/word_0/rr
      -- 
    split_ack_771_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_130_gather_scatter_ack_0, ack => hardware1_CP_26_elements(151)); -- 
    rr_778_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(151), ack => ptr_deref_130_store_0_req_0); -- 
    -- CP-element group 152 transition  input  bypass 
    -- predecessors 151 
    -- successors 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_Sample/word_access_start/$exit
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_Sample/word_access_start/word_0/$exit
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_Sample/word_access_start/word_0/ra
      -- 
    ra_779_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_130_store_0_ack_0, ack => hardware1_CP_26_elements(152)); -- 
    -- CP-element group 153 transition  place  input  bypass 
    -- predecessors 145 
    -- successors 154 
    -- members (8) 
      -- 	branch_block_stmt_18/assign_stmt_132__exit__
      -- 	branch_block_stmt_18/assign_stmt_135__entry__
      -- 	branch_block_stmt_18/assign_stmt_132/$exit
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_Update/word_access_complete/$exit
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_Update/word_access_complete/word_0/$exit
      -- 	branch_block_stmt_18/assign_stmt_132/ptr_deref_130_Update/word_access_complete/word_0/ca
      -- 
    ca_790_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_130_store_0_ack_1, ack => hardware1_CP_26_elements(153)); -- 
    -- CP-element group 154 fork  transition  bypass 
    -- predecessors 153 
    -- successors 155 156 
    -- members (1) 
      -- 	branch_block_stmt_18/assign_stmt_135/$entry
      -- 
    hardware1_CP_26_elements(154) <= hardware1_CP_26_elements(153);
    -- CP-element group 155 transition  output  bypass 
    -- predecessors 154 
    -- successors 157 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_135/RPIPE_in_data_134_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_135/RPIPE_in_data_134_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_135/RPIPE_in_data_134_Sample/rr
      -- 
    hardware1_CP_26_elements(155) <= hardware1_CP_26_elements(154);
    rr_801_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(155), ack => RPIPE_in_data_134_inst_req_0); -- 
    -- CP-element group 156 transition  output  bypass 
    -- predecessors 154 
    -- successors 158 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_135/RPIPE_in_data_134_update_start_
      -- 	branch_block_stmt_18/assign_stmt_135/RPIPE_in_data_134_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_135/RPIPE_in_data_134_Update/cr
      -- 
    hardware1_CP_26_elements(156) <= hardware1_CP_26_elements(154);
    cr_806_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(156), ack => RPIPE_in_data_134_inst_req_1); -- 
    -- CP-element group 157 transition  input  bypass 
    -- predecessors 155 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_135/RPIPE_in_data_134_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_135/RPIPE_in_data_134_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_135/RPIPE_in_data_134_Sample/ra
      -- 
    ra_802_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_134_inst_ack_0, ack => hardware1_CP_26_elements(157)); -- 
    -- CP-element group 158 transition  place  input  bypass 
    -- predecessors 156 
    -- successors 159 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_135__exit__
      -- 	branch_block_stmt_18/assign_stmt_139__entry__
      -- 	branch_block_stmt_18/assign_stmt_135/$exit
      -- 	branch_block_stmt_18/assign_stmt_135/RPIPE_in_data_134_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_135/RPIPE_in_data_134_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_135/RPIPE_in_data_134_Update/ca
      -- 
    ca_807_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_134_inst_ack_1, ack => hardware1_CP_26_elements(158)); -- 
    -- CP-element group 159 fork  transition  bypass 
    -- predecessors 158 
    -- successors 160 162 163 
    -- members (1) 
      -- 	branch_block_stmt_18/assign_stmt_139/$entry
      -- 
    hardware1_CP_26_elements(159) <= hardware1_CP_26_elements(158);
    -- CP-element group 160 transition  bypass 
    -- predecessors 159 
    -- successors 161 
    -- members (4) 
      -- 	branch_block_stmt_18/assign_stmt_139/R_iNsTr_13_138_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_139/R_iNsTr_13_138_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_139/R_iNsTr_13_138_update_start_
      -- 	branch_block_stmt_18/assign_stmt_139/R_iNsTr_13_138_update_completed_
      -- 
    hardware1_CP_26_elements(160) <= hardware1_CP_26_elements(159);
    -- CP-element group 161 join  transition  output  bypass 
    -- predecessors 160 163 167 
    -- successors 168 
    -- members (4) 
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_Sample/ptr_deref_137_Split/$entry
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_Sample/ptr_deref_137_Split/split_req
      -- 
    cp_element_group_161: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 20) := "cp_element_group_161"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= hardware1_CP_26_elements(160) & hardware1_CP_26_elements(163) & hardware1_CP_26_elements(167);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => hardware1_CP_26_elements(161), clk => clk, reset => reset); --
    end block;
    split_req_848_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(161), ack => ptr_deref_137_gather_scatter_req_0); -- 
    -- CP-element group 162 transition  output  bypass 
    -- predecessors 159 
    -- successors 170 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_update_start_
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_Update/word_access_complete/$entry
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_Update/word_access_complete/word_0/$entry
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_Update/word_access_complete/word_0/cr
      -- 
    hardware1_CP_26_elements(162) <= hardware1_CP_26_elements(159);
    cr_867_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(162), ack => ptr_deref_137_store_0_req_1); -- 
    -- CP-element group 163 fork  transition  bypass 
    -- predecessors 159 
    -- successors 161 164 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_base_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_139/R_scevgep5_136_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_139/R_scevgep5_136_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_139/R_scevgep5_136_update_start_
      -- 	branch_block_stmt_18/assign_stmt_139/R_scevgep5_136_update_completed_
      -- 
    hardware1_CP_26_elements(163) <= hardware1_CP_26_elements(159);
    -- CP-element group 164 transition  output  bypass 
    -- predecessors 163 
    -- successors 165 
    -- members (2) 
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_base_addr_resize/$entry
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_base_addr_resize/base_resize_req
      -- 
    hardware1_CP_26_elements(164) <= hardware1_CP_26_elements(163);
    base_resize_req_830_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(164), ack => ptr_deref_137_base_resize_req_0); -- 
    -- CP-element group 165 transition  input  output  bypass 
    -- predecessors 164 
    -- successors 166 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_base_address_resized
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_base_addr_resize/$exit
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_base_addr_resize/base_resize_ack
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_base_plus_offset/$entry
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_base_plus_offset/sum_rename_req
      -- 
    base_resize_ack_831_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_137_base_resize_ack_0, ack => hardware1_CP_26_elements(165)); -- 
    sum_rename_req_835_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(165), ack => ptr_deref_137_root_address_inst_req_0); -- 
    -- CP-element group 166 transition  input  output  bypass 
    -- predecessors 165 
    -- successors 167 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_root_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_base_plus_offset/$exit
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_base_plus_offset/sum_rename_ack
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_word_addrgen/$entry
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_word_addrgen/root_register_req
      -- 
    sum_rename_ack_836_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_137_root_address_inst_ack_0, ack => hardware1_CP_26_elements(166)); -- 
    root_register_req_840_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(166), ack => ptr_deref_137_addr_0_req_0); -- 
    -- CP-element group 167 transition  input  bypass 
    -- predecessors 166 
    -- successors 161 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_word_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_word_addrgen/$exit
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_word_addrgen/root_register_ack
      -- 
    root_register_ack_841_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_137_addr_0_ack_0, ack => hardware1_CP_26_elements(167)); -- 
    -- CP-element group 168 transition  input  output  bypass 
    -- predecessors 161 
    -- successors 169 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_Sample/ptr_deref_137_Split/$exit
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_Sample/ptr_deref_137_Split/split_ack
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_Sample/word_access_start/$entry
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_Sample/word_access_start/word_0/$entry
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_Sample/word_access_start/word_0/rr
      -- 
    split_ack_849_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_137_gather_scatter_ack_0, ack => hardware1_CP_26_elements(168)); -- 
    rr_856_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(168), ack => ptr_deref_137_store_0_req_0); -- 
    -- CP-element group 169 transition  input  bypass 
    -- predecessors 168 
    -- successors 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_Sample/word_access_start/$exit
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_Sample/word_access_start/word_0/$exit
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_Sample/word_access_start/word_0/ra
      -- 
    ra_857_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_137_store_0_ack_0, ack => hardware1_CP_26_elements(169)); -- 
    -- CP-element group 170 transition  place  input  bypass 
    -- predecessors 162 
    -- successors 171 
    -- members (8) 
      -- 	branch_block_stmt_18/assign_stmt_139__exit__
      -- 	branch_block_stmt_18/assign_stmt_142__entry__
      -- 	branch_block_stmt_18/assign_stmt_139/$exit
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_Update/word_access_complete/$exit
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_Update/word_access_complete/word_0/$exit
      -- 	branch_block_stmt_18/assign_stmt_139/ptr_deref_137_Update/word_access_complete/word_0/ca
      -- 
    ca_868_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_137_store_0_ack_1, ack => hardware1_CP_26_elements(170)); -- 
    -- CP-element group 171 fork  transition  bypass 
    -- predecessors 170 
    -- successors 172 173 
    -- members (1) 
      -- 	branch_block_stmt_18/assign_stmt_142/$entry
      -- 
    hardware1_CP_26_elements(171) <= hardware1_CP_26_elements(170);
    -- CP-element group 172 transition  output  bypass 
    -- predecessors 171 
    -- successors 174 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_142/RPIPE_in_data_141_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_142/RPIPE_in_data_141_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_142/RPIPE_in_data_141_Sample/rr
      -- 
    hardware1_CP_26_elements(172) <= hardware1_CP_26_elements(171);
    rr_879_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(172), ack => RPIPE_in_data_141_inst_req_0); -- 
    -- CP-element group 173 transition  output  bypass 
    -- predecessors 171 
    -- successors 175 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_142/RPIPE_in_data_141_update_start_
      -- 	branch_block_stmt_18/assign_stmt_142/RPIPE_in_data_141_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_142/RPIPE_in_data_141_Update/cr
      -- 
    hardware1_CP_26_elements(173) <= hardware1_CP_26_elements(171);
    cr_884_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(173), ack => RPIPE_in_data_141_inst_req_1); -- 
    -- CP-element group 174 transition  input  bypass 
    -- predecessors 172 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_142/RPIPE_in_data_141_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_142/RPIPE_in_data_141_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_142/RPIPE_in_data_141_Sample/ra
      -- 
    ra_880_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_141_inst_ack_0, ack => hardware1_CP_26_elements(174)); -- 
    -- CP-element group 175 transition  place  input  bypass 
    -- predecessors 173 
    -- successors 176 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_142__exit__
      -- 	branch_block_stmt_18/assign_stmt_146__entry__
      -- 	branch_block_stmt_18/assign_stmt_142/$exit
      -- 	branch_block_stmt_18/assign_stmt_142/RPIPE_in_data_141_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_142/RPIPE_in_data_141_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_142/RPIPE_in_data_141_Update/ca
      -- 
    ca_885_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_141_inst_ack_1, ack => hardware1_CP_26_elements(175)); -- 
    -- CP-element group 176 fork  transition  bypass 
    -- predecessors 175 
    -- successors 177 179 180 
    -- members (1) 
      -- 	branch_block_stmt_18/assign_stmt_146/$entry
      -- 
    hardware1_CP_26_elements(176) <= hardware1_CP_26_elements(175);
    -- CP-element group 177 transition  bypass 
    -- predecessors 176 
    -- successors 178 
    -- members (4) 
      -- 	branch_block_stmt_18/assign_stmt_146/R_iNsTr_16_145_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_146/R_iNsTr_16_145_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_146/R_iNsTr_16_145_update_start_
      -- 	branch_block_stmt_18/assign_stmt_146/R_iNsTr_16_145_update_completed_
      -- 
    hardware1_CP_26_elements(177) <= hardware1_CP_26_elements(176);
    -- CP-element group 178 join  transition  output  bypass 
    -- predecessors 177 180 184 
    -- successors 185 
    -- members (4) 
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_Sample/ptr_deref_144_Split/$entry
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_Sample/ptr_deref_144_Split/split_req
      -- 
    cp_element_group_178: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 20) := "cp_element_group_178"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= hardware1_CP_26_elements(177) & hardware1_CP_26_elements(180) & hardware1_CP_26_elements(184);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => hardware1_CP_26_elements(178), clk => clk, reset => reset); --
    end block;
    split_req_926_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(178), ack => ptr_deref_144_gather_scatter_req_0); -- 
    -- CP-element group 179 transition  output  bypass 
    -- predecessors 176 
    -- successors 187 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_update_start_
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_Update/word_access_complete/$entry
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_Update/word_access_complete/word_0/$entry
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_Update/word_access_complete/word_0/cr
      -- 
    hardware1_CP_26_elements(179) <= hardware1_CP_26_elements(176);
    cr_945_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(179), ack => ptr_deref_144_store_0_req_1); -- 
    -- CP-element group 180 fork  transition  bypass 
    -- predecessors 176 
    -- successors 178 181 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_base_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_146/R_scevgep4_143_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_146/R_scevgep4_143_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_146/R_scevgep4_143_update_start_
      -- 	branch_block_stmt_18/assign_stmt_146/R_scevgep4_143_update_completed_
      -- 
    hardware1_CP_26_elements(180) <= hardware1_CP_26_elements(176);
    -- CP-element group 181 transition  output  bypass 
    -- predecessors 180 
    -- successors 182 
    -- members (2) 
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_base_addr_resize/$entry
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_base_addr_resize/base_resize_req
      -- 
    hardware1_CP_26_elements(181) <= hardware1_CP_26_elements(180);
    base_resize_req_908_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(181), ack => ptr_deref_144_base_resize_req_0); -- 
    -- CP-element group 182 transition  input  output  bypass 
    -- predecessors 181 
    -- successors 183 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_base_address_resized
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_base_addr_resize/$exit
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_base_addr_resize/base_resize_ack
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_base_plus_offset/$entry
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_base_plus_offset/sum_rename_req
      -- 
    base_resize_ack_909_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_144_base_resize_ack_0, ack => hardware1_CP_26_elements(182)); -- 
    sum_rename_req_913_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(182), ack => ptr_deref_144_root_address_inst_req_0); -- 
    -- CP-element group 183 transition  input  output  bypass 
    -- predecessors 182 
    -- successors 184 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_root_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_base_plus_offset/$exit
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_base_plus_offset/sum_rename_ack
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_word_addrgen/$entry
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_word_addrgen/root_register_req
      -- 
    sum_rename_ack_914_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_144_root_address_inst_ack_0, ack => hardware1_CP_26_elements(183)); -- 
    root_register_req_918_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(183), ack => ptr_deref_144_addr_0_req_0); -- 
    -- CP-element group 184 transition  input  bypass 
    -- predecessors 183 
    -- successors 178 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_word_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_word_addrgen/$exit
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_word_addrgen/root_register_ack
      -- 
    root_register_ack_919_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_144_addr_0_ack_0, ack => hardware1_CP_26_elements(184)); -- 
    -- CP-element group 185 transition  input  output  bypass 
    -- predecessors 178 
    -- successors 186 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_Sample/ptr_deref_144_Split/$exit
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_Sample/ptr_deref_144_Split/split_ack
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_Sample/word_access_start/$entry
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_Sample/word_access_start/word_0/$entry
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_Sample/word_access_start/word_0/rr
      -- 
    split_ack_927_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_144_gather_scatter_ack_0, ack => hardware1_CP_26_elements(185)); -- 
    rr_934_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(185), ack => ptr_deref_144_store_0_req_0); -- 
    -- CP-element group 186 transition  input  bypass 
    -- predecessors 185 
    -- successors 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_Sample/word_access_start/$exit
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_Sample/word_access_start/word_0/$exit
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_Sample/word_access_start/word_0/ra
      -- 
    ra_935_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_144_store_0_ack_0, ack => hardware1_CP_26_elements(186)); -- 
    -- CP-element group 187 transition  place  input  bypass 
    -- predecessors 179 
    -- successors 188 
    -- members (8) 
      -- 	branch_block_stmt_18/assign_stmt_146__exit__
      -- 	branch_block_stmt_18/assign_stmt_149__entry__
      -- 	branch_block_stmt_18/assign_stmt_146/$exit
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_Update/word_access_complete/$exit
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_Update/word_access_complete/word_0/$exit
      -- 	branch_block_stmt_18/assign_stmt_146/ptr_deref_144_Update/word_access_complete/word_0/ca
      -- 
    ca_946_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_144_store_0_ack_1, ack => hardware1_CP_26_elements(187)); -- 
    -- CP-element group 188 fork  transition  bypass 
    -- predecessors 187 
    -- successors 189 190 
    -- members (1) 
      -- 	branch_block_stmt_18/assign_stmt_149/$entry
      -- 
    hardware1_CP_26_elements(188) <= hardware1_CP_26_elements(187);
    -- CP-element group 189 transition  output  bypass 
    -- predecessors 188 
    -- successors 191 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_149/RPIPE_in_data_148_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_149/RPIPE_in_data_148_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_149/RPIPE_in_data_148_Sample/rr
      -- 
    hardware1_CP_26_elements(189) <= hardware1_CP_26_elements(188);
    rr_957_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(189), ack => RPIPE_in_data_148_inst_req_0); -- 
    -- CP-element group 190 transition  output  bypass 
    -- predecessors 188 
    -- successors 192 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_149/RPIPE_in_data_148_update_start_
      -- 	branch_block_stmt_18/assign_stmt_149/RPIPE_in_data_148_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_149/RPIPE_in_data_148_Update/cr
      -- 
    hardware1_CP_26_elements(190) <= hardware1_CP_26_elements(188);
    cr_962_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(190), ack => RPIPE_in_data_148_inst_req_1); -- 
    -- CP-element group 191 transition  input  bypass 
    -- predecessors 189 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_149/RPIPE_in_data_148_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_149/RPIPE_in_data_148_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_149/RPIPE_in_data_148_Sample/ra
      -- 
    ra_958_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_148_inst_ack_0, ack => hardware1_CP_26_elements(191)); -- 
    -- CP-element group 192 transition  place  input  bypass 
    -- predecessors 190 
    -- successors 193 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_149__exit__
      -- 	branch_block_stmt_18/assign_stmt_153__entry__
      -- 	branch_block_stmt_18/assign_stmt_149/$exit
      -- 	branch_block_stmt_18/assign_stmt_149/RPIPE_in_data_148_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_149/RPIPE_in_data_148_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_149/RPIPE_in_data_148_Update/ca
      -- 
    ca_963_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_148_inst_ack_1, ack => hardware1_CP_26_elements(192)); -- 
    -- CP-element group 193 fork  transition  bypass 
    -- predecessors 192 
    -- successors 194 196 197 
    -- members (1) 
      -- 	branch_block_stmt_18/assign_stmt_153/$entry
      -- 
    hardware1_CP_26_elements(193) <= hardware1_CP_26_elements(192);
    -- CP-element group 194 transition  bypass 
    -- predecessors 193 
    -- successors 195 
    -- members (4) 
      -- 	branch_block_stmt_18/assign_stmt_153/R_iNsTr_19_152_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_153/R_iNsTr_19_152_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_153/R_iNsTr_19_152_update_start_
      -- 	branch_block_stmt_18/assign_stmt_153/R_iNsTr_19_152_update_completed_
      -- 
    hardware1_CP_26_elements(194) <= hardware1_CP_26_elements(193);
    -- CP-element group 195 join  transition  output  bypass 
    -- predecessors 194 197 201 
    -- successors 202 
    -- members (4) 
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_Sample/ptr_deref_151_Split/$entry
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_Sample/ptr_deref_151_Split/split_req
      -- 
    cp_element_group_195: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 20) := "cp_element_group_195"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= hardware1_CP_26_elements(194) & hardware1_CP_26_elements(197) & hardware1_CP_26_elements(201);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => hardware1_CP_26_elements(195), clk => clk, reset => reset); --
    end block;
    split_req_1004_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(195), ack => ptr_deref_151_gather_scatter_req_0); -- 
    -- CP-element group 196 transition  output  bypass 
    -- predecessors 193 
    -- successors 204 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_update_start_
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_Update/word_access_complete/$entry
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_Update/word_access_complete/word_0/$entry
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_Update/word_access_complete/word_0/cr
      -- 
    hardware1_CP_26_elements(196) <= hardware1_CP_26_elements(193);
    cr_1023_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(196), ack => ptr_deref_151_store_0_req_1); -- 
    -- CP-element group 197 fork  transition  bypass 
    -- predecessors 193 
    -- successors 195 198 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_base_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_153/R_scevgep3_150_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_153/R_scevgep3_150_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_153/R_scevgep3_150_update_start_
      -- 	branch_block_stmt_18/assign_stmt_153/R_scevgep3_150_update_completed_
      -- 
    hardware1_CP_26_elements(197) <= hardware1_CP_26_elements(193);
    -- CP-element group 198 transition  output  bypass 
    -- predecessors 197 
    -- successors 199 
    -- members (2) 
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_base_addr_resize/$entry
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_base_addr_resize/base_resize_req
      -- 
    hardware1_CP_26_elements(198) <= hardware1_CP_26_elements(197);
    base_resize_req_986_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(198), ack => ptr_deref_151_base_resize_req_0); -- 
    -- CP-element group 199 transition  input  output  bypass 
    -- predecessors 198 
    -- successors 200 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_base_address_resized
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_base_addr_resize/$exit
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_base_addr_resize/base_resize_ack
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_base_plus_offset/$entry
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_base_plus_offset/sum_rename_req
      -- 
    base_resize_ack_987_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_151_base_resize_ack_0, ack => hardware1_CP_26_elements(199)); -- 
    sum_rename_req_991_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(199), ack => ptr_deref_151_root_address_inst_req_0); -- 
    -- CP-element group 200 transition  input  output  bypass 
    -- predecessors 199 
    -- successors 201 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_root_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_base_plus_offset/$exit
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_base_plus_offset/sum_rename_ack
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_word_addrgen/$entry
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_word_addrgen/root_register_req
      -- 
    sum_rename_ack_992_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_151_root_address_inst_ack_0, ack => hardware1_CP_26_elements(200)); -- 
    root_register_req_996_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(200), ack => ptr_deref_151_addr_0_req_0); -- 
    -- CP-element group 201 transition  input  bypass 
    -- predecessors 200 
    -- successors 195 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_word_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_word_addrgen/$exit
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_word_addrgen/root_register_ack
      -- 
    root_register_ack_997_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_151_addr_0_ack_0, ack => hardware1_CP_26_elements(201)); -- 
    -- CP-element group 202 transition  input  output  bypass 
    -- predecessors 195 
    -- successors 203 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_Sample/ptr_deref_151_Split/$exit
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_Sample/ptr_deref_151_Split/split_ack
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_Sample/word_access_start/$entry
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_Sample/word_access_start/word_0/$entry
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_Sample/word_access_start/word_0/rr
      -- 
    split_ack_1005_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_151_gather_scatter_ack_0, ack => hardware1_CP_26_elements(202)); -- 
    rr_1012_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(202), ack => ptr_deref_151_store_0_req_0); -- 
    -- CP-element group 203 transition  input  bypass 
    -- predecessors 202 
    -- successors 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_Sample/word_access_start/$exit
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_Sample/word_access_start/word_0/$exit
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_Sample/word_access_start/word_0/ra
      -- 
    ra_1013_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_151_store_0_ack_0, ack => hardware1_CP_26_elements(203)); -- 
    -- CP-element group 204 transition  place  input  bypass 
    -- predecessors 196 
    -- successors 205 
    -- members (8) 
      -- 	branch_block_stmt_18/assign_stmt_153__exit__
      -- 	branch_block_stmt_18/assign_stmt_156__entry__
      -- 	branch_block_stmt_18/assign_stmt_153/$exit
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_Update/word_access_complete/$exit
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_Update/word_access_complete/word_0/$exit
      -- 	branch_block_stmt_18/assign_stmt_153/ptr_deref_151_Update/word_access_complete/word_0/ca
      -- 
    ca_1024_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_151_store_0_ack_1, ack => hardware1_CP_26_elements(204)); -- 
    -- CP-element group 205 fork  transition  bypass 
    -- predecessors 204 
    -- successors 206 207 
    -- members (1) 
      -- 	branch_block_stmt_18/assign_stmt_156/$entry
      -- 
    hardware1_CP_26_elements(205) <= hardware1_CP_26_elements(204);
    -- CP-element group 206 transition  output  bypass 
    -- predecessors 205 
    -- successors 208 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_156/RPIPE_in_data_155_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_156/RPIPE_in_data_155_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_156/RPIPE_in_data_155_Sample/rr
      -- 
    hardware1_CP_26_elements(206) <= hardware1_CP_26_elements(205);
    rr_1035_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(206), ack => RPIPE_in_data_155_inst_req_0); -- 
    -- CP-element group 207 transition  output  bypass 
    -- predecessors 205 
    -- successors 209 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_156/RPIPE_in_data_155_update_start_
      -- 	branch_block_stmt_18/assign_stmt_156/RPIPE_in_data_155_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_156/RPIPE_in_data_155_Update/cr
      -- 
    hardware1_CP_26_elements(207) <= hardware1_CP_26_elements(205);
    cr_1040_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(207), ack => RPIPE_in_data_155_inst_req_1); -- 
    -- CP-element group 208 transition  input  bypass 
    -- predecessors 206 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_156/RPIPE_in_data_155_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_156/RPIPE_in_data_155_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_156/RPIPE_in_data_155_Sample/ra
      -- 
    ra_1036_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_155_inst_ack_0, ack => hardware1_CP_26_elements(208)); -- 
    -- CP-element group 209 transition  place  input  bypass 
    -- predecessors 207 
    -- successors 210 
    -- members (6) 
      -- 	branch_block_stmt_18/assign_stmt_156__exit__
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165__entry__
      -- 	branch_block_stmt_18/assign_stmt_156/$exit
      -- 	branch_block_stmt_18/assign_stmt_156/RPIPE_in_data_155_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_156/RPIPE_in_data_155_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_156/RPIPE_in_data_155_Update/ca
      -- 
    ca_1041_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_155_inst_ack_1, ack => hardware1_CP_26_elements(209)); -- 
    -- CP-element group 210 fork  transition  bypass 
    -- predecessors 209 
    -- successors 211 213 214 223 224 
    -- members (1) 
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/$entry
      -- 
    hardware1_CP_26_elements(210) <= hardware1_CP_26_elements(209);
    -- CP-element group 211 transition  bypass 
    -- predecessors 210 
    -- successors 212 
    -- members (4) 
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/R_iNsTr_22_159_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/R_iNsTr_22_159_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/R_iNsTr_22_159_update_start_
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/R_iNsTr_22_159_update_completed_
      -- 
    hardware1_CP_26_elements(211) <= hardware1_CP_26_elements(210);
    -- CP-element group 212 join  transition  output  bypass 
    -- predecessors 211 214 218 
    -- successors 219 
    -- members (4) 
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_Sample/ptr_deref_158_Split/split_req
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_Sample/ptr_deref_158_Split/$entry
      -- 
    cp_element_group_212: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 20) := "cp_element_group_212"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= hardware1_CP_26_elements(211) & hardware1_CP_26_elements(214) & hardware1_CP_26_elements(218);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => hardware1_CP_26_elements(212), clk => clk, reset => reset); --
    end block;
    split_req_1082_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(212), ack => ptr_deref_158_gather_scatter_req_0); -- 
    -- CP-element group 213 transition  output  bypass 
    -- predecessors 210 
    -- successors 221 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_Update/word_access_complete/word_0/cr
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_Update/word_access_complete/word_0/$entry
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_Update/word_access_complete/$entry
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_update_start_
      -- 
    hardware1_CP_26_elements(213) <= hardware1_CP_26_elements(210);
    cr_1101_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(213), ack => ptr_deref_158_store_0_req_1); -- 
    -- CP-element group 214 fork  transition  bypass 
    -- predecessors 210 
    -- successors 212 215 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_base_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/R_scevgep2_157_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/R_scevgep2_157_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/R_scevgep2_157_update_start_
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/R_scevgep2_157_update_completed_
      -- 
    hardware1_CP_26_elements(214) <= hardware1_CP_26_elements(210);
    -- CP-element group 215 transition  output  bypass 
    -- predecessors 214 
    -- successors 216 
    -- members (2) 
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_base_addr_resize/$entry
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_base_addr_resize/base_resize_req
      -- 
    hardware1_CP_26_elements(215) <= hardware1_CP_26_elements(214);
    base_resize_req_1064_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(215), ack => ptr_deref_158_base_resize_req_0); -- 
    -- CP-element group 216 transition  input  output  bypass 
    -- predecessors 215 
    -- successors 217 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_base_address_resized
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_base_addr_resize/$exit
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_base_addr_resize/base_resize_ack
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_base_plus_offset/$entry
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_base_plus_offset/sum_rename_req
      -- 
    base_resize_ack_1065_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_158_base_resize_ack_0, ack => hardware1_CP_26_elements(216)); -- 
    sum_rename_req_1069_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(216), ack => ptr_deref_158_root_address_inst_req_0); -- 
    -- CP-element group 217 transition  input  output  bypass 
    -- predecessors 216 
    -- successors 218 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_root_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_base_plus_offset/$exit
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_base_plus_offset/sum_rename_ack
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_word_addrgen/$entry
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_word_addrgen/root_register_req
      -- 
    sum_rename_ack_1070_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_158_root_address_inst_ack_0, ack => hardware1_CP_26_elements(217)); -- 
    root_register_req_1074_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(217), ack => ptr_deref_158_addr_0_req_0); -- 
    -- CP-element group 218 transition  input  bypass 
    -- predecessors 217 
    -- successors 212 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_word_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_word_addrgen/$exit
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_word_addrgen/root_register_ack
      -- 
    root_register_ack_1075_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_158_addr_0_ack_0, ack => hardware1_CP_26_elements(218)); -- 
    -- CP-element group 219 transition  input  output  bypass 
    -- predecessors 212 
    -- successors 220 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_Sample/word_access_start/$entry
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_Sample/word_access_start/word_0/rr
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_Sample/word_access_start/word_0/$entry
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_Sample/ptr_deref_158_Split/$exit
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_Sample/ptr_deref_158_Split/split_ack
      -- 
    split_ack_1083_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_158_gather_scatter_ack_0, ack => hardware1_CP_26_elements(219)); -- 
    rr_1090_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(219), ack => ptr_deref_158_store_0_req_0); -- 
    -- CP-element group 220 transition  input  bypass 
    -- predecessors 219 
    -- successors 232 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_Sample/word_access_start/word_0/ra
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_Sample/word_access_start/word_0/$exit
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_Sample/word_access_start/$exit
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_Sample/$exit
      -- 
    ra_1091_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_158_store_0_ack_0, ack => hardware1_CP_26_elements(220)); -- 
    -- CP-element group 221 transition  input  bypass 
    -- predecessors 213 
    -- successors 233 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_Update/word_access_complete/word_0/ca
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_Update/word_access_complete/word_0/$exit
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_Update/word_access_complete/$exit
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_update_completed_
      -- 
    ca_1102_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_158_store_0_ack_1, ack => hardware1_CP_26_elements(221)); -- 
    -- CP-element group 222 join  transition  output  bypass 
    -- predecessors 224 228 232 
    -- successors 229 
    -- members (4) 
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_Sample/ptr_deref_162_Split/split_req
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_Sample/ptr_deref_162_Split/$entry
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_Sample/$entry
      -- 
    cp_element_group_222: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 20) := "cp_element_group_222"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= hardware1_CP_26_elements(224) & hardware1_CP_26_elements(228) & hardware1_CP_26_elements(232);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => hardware1_CP_26_elements(222), clk => clk, reset => reset); --
    end block;
    split_req_1136_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(222), ack => ptr_deref_162_gather_scatter_req_0); -- 
    -- CP-element group 223 transition  output  bypass 
    -- predecessors 210 
    -- successors 231 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_Update/word_access_complete/word_0/cr
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_Update/word_access_complete/word_0/$entry
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_Update/word_access_complete/$entry
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_update_start_
      -- 
    hardware1_CP_26_elements(223) <= hardware1_CP_26_elements(210);
    cr_1155_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(223), ack => ptr_deref_162_store_0_req_1); -- 
    -- CP-element group 224 fork  transition  bypass 
    -- predecessors 210 
    -- successors 222 225 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/R_scevgep1_161_update_start_
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/R_scevgep1_161_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/R_scevgep1_161_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_base_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/R_scevgep1_161_update_completed_
      -- 
    hardware1_CP_26_elements(224) <= hardware1_CP_26_elements(210);
    -- CP-element group 225 transition  output  bypass 
    -- predecessors 224 
    -- successors 226 
    -- members (2) 
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_base_addr_resize/$entry
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_base_addr_resize/base_resize_req
      -- 
    hardware1_CP_26_elements(225) <= hardware1_CP_26_elements(224);
    base_resize_req_1118_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(225), ack => ptr_deref_162_base_resize_req_0); -- 
    -- CP-element group 226 transition  input  output  bypass 
    -- predecessors 225 
    -- successors 227 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_base_address_resized
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_base_plus_offset/sum_rename_req
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_base_plus_offset/$entry
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_base_addr_resize/base_resize_ack
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_base_addr_resize/$exit
      -- 
    base_resize_ack_1119_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_162_base_resize_ack_0, ack => hardware1_CP_26_elements(226)); -- 
    sum_rename_req_1123_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(226), ack => ptr_deref_162_root_address_inst_req_0); -- 
    -- CP-element group 227 transition  input  output  bypass 
    -- predecessors 226 
    -- successors 228 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_root_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_word_addrgen/root_register_req
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_word_addrgen/$entry
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_base_plus_offset/sum_rename_ack
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_base_plus_offset/$exit
      -- 
    sum_rename_ack_1124_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_162_root_address_inst_ack_0, ack => hardware1_CP_26_elements(227)); -- 
    root_register_req_1128_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(227), ack => ptr_deref_162_addr_0_req_0); -- 
    -- CP-element group 228 transition  input  bypass 
    -- predecessors 227 
    -- successors 222 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_word_address_calculated
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_word_addrgen/root_register_ack
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_word_addrgen/$exit
      -- 
    root_register_ack_1129_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_162_addr_0_ack_0, ack => hardware1_CP_26_elements(228)); -- 
    -- CP-element group 229 transition  input  output  bypass 
    -- predecessors 222 
    -- successors 230 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_Sample/word_access_start/word_0/rr
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_Sample/word_access_start/word_0/$entry
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_Sample/word_access_start/$entry
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_Sample/ptr_deref_162_Split/split_ack
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_Sample/ptr_deref_162_Split/$exit
      -- 
    split_ack_1137_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_162_gather_scatter_ack_0, ack => hardware1_CP_26_elements(229)); -- 
    rr_1144_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(229), ack => ptr_deref_162_store_0_req_0); -- 
    -- CP-element group 230 transition  input  bypass 
    -- predecessors 229 
    -- successors 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_Sample/word_access_start/word_0/ra
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_Sample/word_access_start/word_0/$exit
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_Sample/word_access_start/$exit
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_Sample/$exit
      -- 
    ra_1145_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_162_store_0_ack_0, ack => hardware1_CP_26_elements(230)); -- 
    -- CP-element group 231 transition  input  bypass 
    -- predecessors 223 
    -- successors 233 
    -- members (5) 
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_Update/word_access_complete/word_0/ca
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_Update/word_access_complete/word_0/$exit
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_Update/word_access_complete/$exit
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_162_update_completed_
      -- 
    ca_1156_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => ptr_deref_162_store_0_ack_1, ack => hardware1_CP_26_elements(231)); -- 
    -- CP-element group 232 transition  bypass 
    -- predecessors 220 
    -- successors 222 
    -- members (1) 
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/ptr_deref_158_ptr_deref_162_delay
      -- 
    -- Element group hardware1_CP_26_elements(232) is a control-delay.
    cp_element_232_delay: control_delay_element  generic map(delay_value => 1)  port map(req => hardware1_CP_26_elements(220), ack => hardware1_CP_26_elements(232), clk => clk, reset =>reset);
    -- CP-element group 233 join  transition  bypass 
    -- predecessors 221 231 
    -- successors 4 
    -- members (1) 
      -- 	branch_block_stmt_18/assign_stmt_160_to_assign_stmt_165/$exit
      -- 
    cp_element_group_233: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 20) := "cp_element_group_233"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= hardware1_CP_26_elements(221) & hardware1_CP_26_elements(231);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => hardware1_CP_26_elements(233), clk => clk, reset => reset); --
    end block;
    -- CP-element group 234 fork  transition  bypass 
    -- predecessors 4 
    -- successors 235 236 
    -- members (1) 
      -- 	branch_block_stmt_18/assign_stmt_168/$entry
      -- 
    hardware1_CP_26_elements(234) <= hardware1_CP_26_elements(4);
    -- CP-element group 235 transition  output  bypass 
    -- predecessors 234 
    -- successors 237 
    -- members (7) 
      -- 	branch_block_stmt_18/assign_stmt_168/WPIPE_out_id_166_Sample/req
      -- 	branch_block_stmt_18/assign_stmt_168/WPIPE_out_id_166_Sample/$entry
      -- 	branch_block_stmt_18/assign_stmt_168/WPIPE_out_id_166_sample_start_
      -- 	branch_block_stmt_18/assign_stmt_168/R_tmp_167_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_168/R_tmp_167_update_start_
      -- 	branch_block_stmt_18/assign_stmt_168/R_tmp_167_sample_completed_
      -- 	branch_block_stmt_18/assign_stmt_168/R_tmp_167_sample_start_
      -- 
    hardware1_CP_26_elements(235) <= hardware1_CP_26_elements(234);
    req_1172_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(235), ack => WPIPE_out_id_166_inst_req_0); -- 
    -- CP-element group 236 transition  output  bypass 
    -- predecessors 234 
    -- successors 238 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_168/WPIPE_out_id_166_Update/req
      -- 	branch_block_stmt_18/assign_stmt_168/WPIPE_out_id_166_Update/$entry
      -- 	branch_block_stmt_18/assign_stmt_168/WPIPE_out_id_166_update_start_
      -- 
    hardware1_CP_26_elements(236) <= hardware1_CP_26_elements(234);
    req_1177_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(236), ack => WPIPE_out_id_166_inst_req_1); -- 
    -- CP-element group 237 transition  input  bypass 
    -- predecessors 235 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_18/assign_stmt_168/WPIPE_out_id_166_Sample/ack
      -- 	branch_block_stmt_18/assign_stmt_168/WPIPE_out_id_166_Sample/$exit
      -- 	branch_block_stmt_18/assign_stmt_168/WPIPE_out_id_166_sample_completed_
      -- 
    ack_1173_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_out_id_166_inst_ack_0, ack => hardware1_CP_26_elements(237)); -- 
    -- CP-element group 238 fork  transition  place  input  bypass 
    -- predecessors 236 
    -- successors 242 244 
    -- members (11) 
      -- 	branch_block_stmt_18/assign_stmt_168__exit__
      -- 	branch_block_stmt_18/bb_1_bb_1
      -- 	branch_block_stmt_18/bb_1_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/type_cast_53/SplitProtocol/$entry
      -- 	branch_block_stmt_18/bb_1_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/type_cast_53/$entry
      -- 	branch_block_stmt_18/bb_1_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/$entry
      -- 	branch_block_stmt_18/bb_1_bb_1_PhiReq/phi_stmt_47/$entry
      -- 	branch_block_stmt_18/bb_1_bb_1_PhiReq/$entry
      -- 	branch_block_stmt_18/assign_stmt_168/WPIPE_out_id_166_Update/ack
      -- 	branch_block_stmt_18/assign_stmt_168/WPIPE_out_id_166_Update/$exit
      -- 	branch_block_stmt_18/assign_stmt_168/WPIPE_out_id_166_update_completed_
      -- 	branch_block_stmt_18/assign_stmt_168/$exit
      -- 
    ack_1178_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_out_id_166_inst_ack_1, ack => hardware1_CP_26_elements(238)); -- 
    -- CP-element group 239 transition  bypass 
    -- predecessors 2 
    -- successors 241 
    -- members (4) 
      -- 	branch_block_stmt_18/bb_0_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/type_cast_53/SplitProtocol/Sample/ra
      -- 	branch_block_stmt_18/bb_0_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/type_cast_53/SplitProtocol/Sample/rr
      -- 	branch_block_stmt_18/bb_0_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/type_cast_53/SplitProtocol/Sample/$exit
      -- 	branch_block_stmt_18/bb_0_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/type_cast_53/SplitProtocol/Sample/$entry
      -- 
    hardware1_CP_26_elements(239) <= hardware1_CP_26_elements(2);
    -- CP-element group 240 transition  bypass 
    -- predecessors 2 
    -- successors 241 
    -- members (4) 
      -- 	branch_block_stmt_18/bb_0_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/type_cast_53/SplitProtocol/Update/ca
      -- 	branch_block_stmt_18/bb_0_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/type_cast_53/SplitProtocol/Update/cr
      -- 	branch_block_stmt_18/bb_0_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/type_cast_53/SplitProtocol/Update/$exit
      -- 	branch_block_stmt_18/bb_0_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/type_cast_53/SplitProtocol/Update/$entry
      -- 
    hardware1_CP_26_elements(240) <= hardware1_CP_26_elements(2);
    -- CP-element group 241 join  transition  output  bypass 
    -- predecessors 239 240 
    -- successors 247 
    -- members (6) 
      -- 	branch_block_stmt_18/bb_0_bb_1_PhiReq/$exit
      -- 	branch_block_stmt_18/bb_0_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_req
      -- 	branch_block_stmt_18/bb_0_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/type_cast_53/SplitProtocol/$exit
      -- 	branch_block_stmt_18/bb_0_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/type_cast_53/$exit
      -- 	branch_block_stmt_18/bb_0_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/$exit
      -- 	branch_block_stmt_18/bb_0_bb_1_PhiReq/phi_stmt_47/$exit
      -- 
    cp_element_group_241: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 20) := "cp_element_group_241"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= hardware1_CP_26_elements(239) & hardware1_CP_26_elements(240);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => hardware1_CP_26_elements(241), clk => clk, reset => reset); --
    end block;
    phi_stmt_47_req_1204_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(241), ack => phi_stmt_47_req_0); -- 
    -- CP-element group 242 transition  output  bypass 
    -- predecessors 238 
    -- successors 243 
    -- members (2) 
      -- 	branch_block_stmt_18/bb_1_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/type_cast_53/SplitProtocol/Sample/rr
      -- 	branch_block_stmt_18/bb_1_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/type_cast_53/SplitProtocol/Sample/$entry
      -- 
    hardware1_CP_26_elements(242) <= hardware1_CP_26_elements(238);
    rr_1223_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(242), ack => type_cast_53_inst_req_0); -- 
    -- CP-element group 243 transition  input  bypass 
    -- predecessors 242 
    -- successors 246 
    -- members (2) 
      -- 	branch_block_stmt_18/bb_1_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/type_cast_53/SplitProtocol/Sample/ra
      -- 	branch_block_stmt_18/bb_1_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/type_cast_53/SplitProtocol/Sample/$exit
      -- 
    ra_1224_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => type_cast_53_inst_ack_0, ack => hardware1_CP_26_elements(243)); -- 
    -- CP-element group 244 transition  output  bypass 
    -- predecessors 238 
    -- successors 245 
    -- members (2) 
      -- 	branch_block_stmt_18/bb_1_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/type_cast_53/SplitProtocol/Update/cr
      -- 	branch_block_stmt_18/bb_1_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/type_cast_53/SplitProtocol/Update/$entry
      -- 
    hardware1_CP_26_elements(244) <= hardware1_CP_26_elements(238);
    cr_1228_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(244), ack => type_cast_53_inst_req_1); -- 
    -- CP-element group 245 transition  input  bypass 
    -- predecessors 244 
    -- successors 246 
    -- members (2) 
      -- 	branch_block_stmt_18/bb_1_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/type_cast_53/SplitProtocol/Update/ca
      -- 	branch_block_stmt_18/bb_1_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/type_cast_53/SplitProtocol/Update/$exit
      -- 
    ca_1229_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => type_cast_53_inst_ack_1, ack => hardware1_CP_26_elements(245)); -- 
    -- CP-element group 246 join  transition  output  bypass 
    -- predecessors 243 245 
    -- successors 247 
    -- members (6) 
      -- 	branch_block_stmt_18/bb_1_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_req
      -- 	branch_block_stmt_18/bb_1_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/type_cast_53/SplitProtocol/$exit
      -- 	branch_block_stmt_18/bb_1_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/type_cast_53/$exit
      -- 	branch_block_stmt_18/bb_1_bb_1_PhiReq/phi_stmt_47/phi_stmt_47_sources/$exit
      -- 	branch_block_stmt_18/bb_1_bb_1_PhiReq/phi_stmt_47/$exit
      -- 	branch_block_stmt_18/bb_1_bb_1_PhiReq/$exit
      -- 
    cp_element_group_246: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 20) := "cp_element_group_246"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= hardware1_CP_26_elements(243) & hardware1_CP_26_elements(245);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => hardware1_CP_26_elements(246), clk => clk, reset => reset); --
    end block;
    phi_stmt_47_req_1230_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => hardware1_CP_26_elements(246), ack => phi_stmt_47_req_1); -- 
    -- CP-element group 247 merge  place  bypass 
    -- predecessors 241 246 
    -- successors 248 
    -- members (1) 
      -- 	branch_block_stmt_18/merge_stmt_46_PhiReqMerge
      -- 
    hardware1_CP_26_elements(247) <= OrReduce(hardware1_CP_26_elements(241) & hardware1_CP_26_elements(246));
    -- CP-element group 248 transition  bypass 
    -- predecessors 247 
    -- successors 249 
    -- members (1) 
      -- 	branch_block_stmt_18/merge_stmt_46_PhiAck/$entry
      -- 
    hardware1_CP_26_elements(248) <= hardware1_CP_26_elements(247);
    -- CP-element group 249 transition  place  input  bypass 
    -- predecessors 248 
    -- successors 25 
    -- members (4) 
      -- 	branch_block_stmt_18/merge_stmt_46__exit__
      -- 	branch_block_stmt_18/assign_stmt_61_to_assign_stmt_118__entry__
      -- 	branch_block_stmt_18/merge_stmt_46_PhiAck/phi_stmt_47_ack
      -- 	branch_block_stmt_18/merge_stmt_46_PhiAck/$exit
      -- 
    phi_stmt_47_ack_1235_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_47_ack_0, ack => hardware1_CP_26_elements(249)); -- 
    --  hookup: inputs to control-path 
    -- hookup: output from control-path 
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal R_ix_x0_56_resized : std_logic_vector(7 downto 0);
    signal R_ix_x0_56_scaled : std_logic_vector(7 downto 0);
    signal R_ix_x0_63_resized : std_logic_vector(7 downto 0);
    signal R_ix_x0_63_scaled : std_logic_vector(7 downto 0);
    signal R_ix_x0_70_resized : std_logic_vector(7 downto 0);
    signal R_ix_x0_70_scaled : std_logic_vector(7 downto 0);
    signal R_ix_x0_77_resized : std_logic_vector(7 downto 0);
    signal R_ix_x0_77_scaled : std_logic_vector(7 downto 0);
    signal R_ix_x0_84_resized : std_logic_vector(7 downto 0);
    signal R_ix_x0_84_scaled : std_logic_vector(7 downto 0);
    signal R_ix_x0_91_resized : std_logic_vector(7 downto 0);
    signal R_ix_x0_91_scaled : std_logic_vector(7 downto 0);
    signal R_ix_x0_98_resized : std_logic_vector(7 downto 0);
    signal R_ix_x0_98_scaled : std_logic_vector(7 downto 0);
    signal array_obj_ref_59_constant_part_of_offset : std_logic_vector(7 downto 0);
    signal array_obj_ref_59_final_offset : std_logic_vector(7 downto 0);
    signal array_obj_ref_59_offset_scale_factor_0 : std_logic_vector(7 downto 0);
    signal array_obj_ref_59_offset_scale_factor_1 : std_logic_vector(7 downto 0);
    signal array_obj_ref_59_resized_base_address : std_logic_vector(7 downto 0);
    signal array_obj_ref_59_root_address : std_logic_vector(7 downto 0);
    signal array_obj_ref_66_constant_part_of_offset : std_logic_vector(7 downto 0);
    signal array_obj_ref_66_final_offset : std_logic_vector(7 downto 0);
    signal array_obj_ref_66_offset_scale_factor_0 : std_logic_vector(7 downto 0);
    signal array_obj_ref_66_offset_scale_factor_1 : std_logic_vector(7 downto 0);
    signal array_obj_ref_66_resized_base_address : std_logic_vector(7 downto 0);
    signal array_obj_ref_66_root_address : std_logic_vector(7 downto 0);
    signal array_obj_ref_73_constant_part_of_offset : std_logic_vector(7 downto 0);
    signal array_obj_ref_73_final_offset : std_logic_vector(7 downto 0);
    signal array_obj_ref_73_offset_scale_factor_0 : std_logic_vector(7 downto 0);
    signal array_obj_ref_73_offset_scale_factor_1 : std_logic_vector(7 downto 0);
    signal array_obj_ref_73_resized_base_address : std_logic_vector(7 downto 0);
    signal array_obj_ref_73_root_address : std_logic_vector(7 downto 0);
    signal array_obj_ref_80_constant_part_of_offset : std_logic_vector(7 downto 0);
    signal array_obj_ref_80_final_offset : std_logic_vector(7 downto 0);
    signal array_obj_ref_80_offset_scale_factor_0 : std_logic_vector(7 downto 0);
    signal array_obj_ref_80_offset_scale_factor_1 : std_logic_vector(7 downto 0);
    signal array_obj_ref_80_resized_base_address : std_logic_vector(7 downto 0);
    signal array_obj_ref_80_root_address : std_logic_vector(7 downto 0);
    signal array_obj_ref_87_constant_part_of_offset : std_logic_vector(7 downto 0);
    signal array_obj_ref_87_final_offset : std_logic_vector(7 downto 0);
    signal array_obj_ref_87_offset_scale_factor_0 : std_logic_vector(7 downto 0);
    signal array_obj_ref_87_offset_scale_factor_1 : std_logic_vector(7 downto 0);
    signal array_obj_ref_87_resized_base_address : std_logic_vector(7 downto 0);
    signal array_obj_ref_87_root_address : std_logic_vector(7 downto 0);
    signal array_obj_ref_94_constant_part_of_offset : std_logic_vector(7 downto 0);
    signal array_obj_ref_94_final_offset : std_logic_vector(7 downto 0);
    signal array_obj_ref_94_offset_scale_factor_0 : std_logic_vector(7 downto 0);
    signal array_obj_ref_94_offset_scale_factor_1 : std_logic_vector(7 downto 0);
    signal array_obj_ref_94_resized_base_address : std_logic_vector(7 downto 0);
    signal array_obj_ref_94_root_address : std_logic_vector(7 downto 0);
    signal array_obj_ref_99_final_offset : std_logic_vector(7 downto 0);
    signal array_obj_ref_99_offset_scale_factor_0 : std_logic_vector(7 downto 0);
    signal array_obj_ref_99_resized_base_address : std_logic_vector(7 downto 0);
    signal array_obj_ref_99_root_address : std_logic_vector(7 downto 0);
    signal iNsTr_0_26 : std_logic_vector(31 downto 0);
    signal iNsTr_10_128 : std_logic_vector(31 downto 0);
    signal iNsTr_13_135 : std_logic_vector(31 downto 0);
    signal iNsTr_16_142 : std_logic_vector(31 downto 0);
    signal iNsTr_19_149 : std_logic_vector(31 downto 0);
    signal iNsTr_22_156 : std_logic_vector(31 downto 0);
    signal iNsTr_2_39 : std_logic_vector(31 downto 0);
    signal iNsTr_5_118 : std_logic_vector(31 downto 0);
    signal iNsTr_7_121 : std_logic_vector(31 downto 0);
    signal ix_x0_47 : std_logic_vector(31 downto 0);
    signal ptr_deref_123_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_123_resized_base_address : std_logic_vector(7 downto 0);
    signal ptr_deref_123_root_address : std_logic_vector(7 downto 0);
    signal ptr_deref_123_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_123_word_address_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_123_word_offset_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_130_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_130_resized_base_address : std_logic_vector(7 downto 0);
    signal ptr_deref_130_root_address : std_logic_vector(7 downto 0);
    signal ptr_deref_130_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_130_word_address_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_130_word_offset_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_137_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_137_resized_base_address : std_logic_vector(7 downto 0);
    signal ptr_deref_137_root_address : std_logic_vector(7 downto 0);
    signal ptr_deref_137_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_137_word_address_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_137_word_offset_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_144_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_144_resized_base_address : std_logic_vector(7 downto 0);
    signal ptr_deref_144_root_address : std_logic_vector(7 downto 0);
    signal ptr_deref_144_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_144_word_address_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_144_word_offset_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_151_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_151_resized_base_address : std_logic_vector(7 downto 0);
    signal ptr_deref_151_root_address : std_logic_vector(7 downto 0);
    signal ptr_deref_151_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_151_word_address_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_151_word_offset_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_158_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_158_resized_base_address : std_logic_vector(7 downto 0);
    signal ptr_deref_158_root_address : std_logic_vector(7 downto 0);
    signal ptr_deref_158_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_158_word_address_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_158_word_offset_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_162_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_162_resized_base_address : std_logic_vector(7 downto 0);
    signal ptr_deref_162_root_address : std_logic_vector(7 downto 0);
    signal ptr_deref_162_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_162_word_address_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_162_word_offset_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_28_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_28_resized_base_address : std_logic_vector(7 downto 0);
    signal ptr_deref_28_root_address : std_logic_vector(7 downto 0);
    signal ptr_deref_28_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_28_word_address_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_28_word_offset_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_41_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_41_resized_base_address : std_logic_vector(7 downto 0);
    signal ptr_deref_41_root_address : std_logic_vector(7 downto 0);
    signal ptr_deref_41_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_41_word_address_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_41_word_offset_0 : std_logic_vector(7 downto 0);
    signal scevgep1_106 : std_logic_vector(31 downto 0);
    signal scevgep2_96 : std_logic_vector(31 downto 0);
    signal scevgep3_89 : std_logic_vector(31 downto 0);
    signal scevgep4_82 : std_logic_vector(31 downto 0);
    signal scevgep5_75 : std_logic_vector(31 downto 0);
    signal scevgep6_68 : std_logic_vector(31 downto 0);
    signal scevgep7_61 : std_logic_vector(31 downto 0);
    signal scevgep_101 : std_logic_vector(31 downto 0);
    signal tmp_112 : std_logic_vector(31 downto 0);
    signal type_cast_110_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_116_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_164_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_30_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_43_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_51_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_53_wire : std_logic_vector(31 downto 0);
    -- 
  begin -- 
    array_obj_ref_59_constant_part_of_offset <= "00000001";
    array_obj_ref_59_offset_scale_factor_0 <= "00000111";
    array_obj_ref_59_offset_scale_factor_1 <= "00000001";
    array_obj_ref_59_resized_base_address <= "00000000";
    array_obj_ref_66_constant_part_of_offset <= "00000010";
    array_obj_ref_66_offset_scale_factor_0 <= "00000111";
    array_obj_ref_66_offset_scale_factor_1 <= "00000001";
    array_obj_ref_66_resized_base_address <= "00000000";
    array_obj_ref_73_constant_part_of_offset <= "00000011";
    array_obj_ref_73_offset_scale_factor_0 <= "00000111";
    array_obj_ref_73_offset_scale_factor_1 <= "00000001";
    array_obj_ref_73_resized_base_address <= "00000000";
    array_obj_ref_80_constant_part_of_offset <= "00000100";
    array_obj_ref_80_offset_scale_factor_0 <= "00000111";
    array_obj_ref_80_offset_scale_factor_1 <= "00000001";
    array_obj_ref_80_resized_base_address <= "00000000";
    array_obj_ref_87_constant_part_of_offset <= "00000101";
    array_obj_ref_87_offset_scale_factor_0 <= "00000111";
    array_obj_ref_87_offset_scale_factor_1 <= "00000001";
    array_obj_ref_87_resized_base_address <= "00000000";
    array_obj_ref_94_constant_part_of_offset <= "00000110";
    array_obj_ref_94_offset_scale_factor_0 <= "00000111";
    array_obj_ref_94_offset_scale_factor_1 <= "00000001";
    array_obj_ref_94_resized_base_address <= "00000000";
    array_obj_ref_99_offset_scale_factor_0 <= "00000111";
    array_obj_ref_99_resized_base_address <= "00000000";
    iNsTr_0_26 <= "00000000000000000000000000000000";
    iNsTr_2_39 <= "00000000000000000000000000000111";
    ptr_deref_123_word_offset_0 <= "00000000";
    ptr_deref_130_word_offset_0 <= "00000000";
    ptr_deref_137_word_offset_0 <= "00000000";
    ptr_deref_144_word_offset_0 <= "00000000";
    ptr_deref_151_word_offset_0 <= "00000000";
    ptr_deref_158_word_offset_0 <= "00000000";
    ptr_deref_162_word_offset_0 <= "00000000";
    ptr_deref_28_word_offset_0 <= "00000000";
    ptr_deref_41_word_offset_0 <= "00000000";
    type_cast_110_wire_constant <= "00000000000000000000000000000001";
    type_cast_116_wire_constant <= "00000000000000000000000000000001";
    type_cast_164_wire_constant <= "00000000000000000000000000000001";
    type_cast_30_wire_constant <= "00000000000000000000000000000000";
    type_cast_43_wire_constant <= "00000000000000000000000000000000";
    type_cast_51_wire_constant <= "00000000000000000000000000000000";
    phi_stmt_47: Block -- phi operator 
      signal idata: std_logic_vector(63 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_51_wire_constant & type_cast_53_wire;
      req <= phi_stmt_47_req_0 & phi_stmt_47_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 32) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_47_ack_0,
          idata => idata,
          odata => ix_x0_47,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_47
    addr_of_100_final_reg_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= addr_of_100_final_reg_req_0;
      addr_of_100_final_reg_ack_0<= wack(0);
      rreq(0) <= addr_of_100_final_reg_req_1;
      addr_of_100_final_reg_ack_1<= rack(0);
      addr_of_100_final_reg : InterlockBuffer generic map ( -- 
        name => "addr_of_100_final_reg",
        buffer_size => 1,
        flow_through =>  false ,
        in_data_width => 8,
        out_data_width => 32
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => array_obj_ref_99_root_address,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => scevgep_101,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    addr_of_60_final_reg_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= addr_of_60_final_reg_req_0;
      addr_of_60_final_reg_ack_0<= wack(0);
      rreq(0) <= addr_of_60_final_reg_req_1;
      addr_of_60_final_reg_ack_1<= rack(0);
      addr_of_60_final_reg : InterlockBuffer generic map ( -- 
        name => "addr_of_60_final_reg",
        buffer_size => 1,
        flow_through =>  false ,
        in_data_width => 8,
        out_data_width => 32
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => array_obj_ref_59_root_address,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => scevgep7_61,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    addr_of_67_final_reg_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= addr_of_67_final_reg_req_0;
      addr_of_67_final_reg_ack_0<= wack(0);
      rreq(0) <= addr_of_67_final_reg_req_1;
      addr_of_67_final_reg_ack_1<= rack(0);
      addr_of_67_final_reg : InterlockBuffer generic map ( -- 
        name => "addr_of_67_final_reg",
        buffer_size => 1,
        flow_through =>  false ,
        in_data_width => 8,
        out_data_width => 32
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => array_obj_ref_66_root_address,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => scevgep6_68,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    addr_of_74_final_reg_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= addr_of_74_final_reg_req_0;
      addr_of_74_final_reg_ack_0<= wack(0);
      rreq(0) <= addr_of_74_final_reg_req_1;
      addr_of_74_final_reg_ack_1<= rack(0);
      addr_of_74_final_reg : InterlockBuffer generic map ( -- 
        name => "addr_of_74_final_reg",
        buffer_size => 1,
        flow_through =>  false ,
        in_data_width => 8,
        out_data_width => 32
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => array_obj_ref_73_root_address,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => scevgep5_75,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    addr_of_81_final_reg_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= addr_of_81_final_reg_req_0;
      addr_of_81_final_reg_ack_0<= wack(0);
      rreq(0) <= addr_of_81_final_reg_req_1;
      addr_of_81_final_reg_ack_1<= rack(0);
      addr_of_81_final_reg : InterlockBuffer generic map ( -- 
        name => "addr_of_81_final_reg",
        buffer_size => 1,
        flow_through =>  false ,
        in_data_width => 8,
        out_data_width => 32
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => array_obj_ref_80_root_address,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => scevgep4_82,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    addr_of_88_final_reg_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= addr_of_88_final_reg_req_0;
      addr_of_88_final_reg_ack_0<= wack(0);
      rreq(0) <= addr_of_88_final_reg_req_1;
      addr_of_88_final_reg_ack_1<= rack(0);
      addr_of_88_final_reg : InterlockBuffer generic map ( -- 
        name => "addr_of_88_final_reg",
        buffer_size => 1,
        flow_through =>  false ,
        in_data_width => 8,
        out_data_width => 32
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => array_obj_ref_87_root_address,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => scevgep3_89,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    addr_of_95_final_reg_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= addr_of_95_final_reg_req_0;
      addr_of_95_final_reg_ack_0<= wack(0);
      rreq(0) <= addr_of_95_final_reg_req_1;
      addr_of_95_final_reg_ack_1<= rack(0);
      addr_of_95_final_reg : InterlockBuffer generic map ( -- 
        name => "addr_of_95_final_reg",
        buffer_size => 1,
        flow_through =>  false ,
        in_data_width => 8,
        out_data_width => 32
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => array_obj_ref_94_root_address,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => scevgep2_96,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    type_cast_105_inst_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= type_cast_105_inst_req_0;
      type_cast_105_inst_ack_0<= wack(0);
      rreq(0) <= type_cast_105_inst_req_1;
      type_cast_105_inst_ack_1<= rack(0);
      type_cast_105_inst : InterlockBuffer generic map ( -- 
        name => "type_cast_105_inst",
        buffer_size => 1,
        flow_through =>  false ,
        in_data_width => 32,
        out_data_width => 32
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => scevgep_101,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => scevgep1_106,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    type_cast_53_inst_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= type_cast_53_inst_req_0;
      type_cast_53_inst_ack_0<= wack(0);
      rreq(0) <= type_cast_53_inst_req_1;
      type_cast_53_inst_ack_1<= rack(0);
      type_cast_53_inst : InterlockBuffer generic map ( -- 
        name => "type_cast_53_inst",
        buffer_size => 1,
        flow_through =>  false ,
        in_data_width => 32,
        out_data_width => 32
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => iNsTr_5_118,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => type_cast_53_wire,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    array_obj_ref_59_index_0_resize: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      array_obj_ref_59_index_0_resize_ack_0 <= array_obj_ref_59_index_0_resize_req_0;
      in_aggregated_sig <= ix_x0_47;
      out_aggregated_sig <= in_aggregated_sig(7 downto 0);
      R_ix_x0_56_resized <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    array_obj_ref_59_root_address_inst: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      array_obj_ref_59_root_address_inst_ack_0 <= array_obj_ref_59_root_address_inst_req_0;
      in_aggregated_sig <= array_obj_ref_59_final_offset;
      out_aggregated_sig <= in_aggregated_sig;
      array_obj_ref_59_root_address <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    array_obj_ref_66_index_0_resize: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      array_obj_ref_66_index_0_resize_ack_0 <= array_obj_ref_66_index_0_resize_req_0;
      in_aggregated_sig <= ix_x0_47;
      out_aggregated_sig <= in_aggregated_sig(7 downto 0);
      R_ix_x0_63_resized <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    array_obj_ref_66_root_address_inst: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      array_obj_ref_66_root_address_inst_ack_0 <= array_obj_ref_66_root_address_inst_req_0;
      in_aggregated_sig <= array_obj_ref_66_final_offset;
      out_aggregated_sig <= in_aggregated_sig;
      array_obj_ref_66_root_address <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    array_obj_ref_73_index_0_resize: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      array_obj_ref_73_index_0_resize_ack_0 <= array_obj_ref_73_index_0_resize_req_0;
      in_aggregated_sig <= ix_x0_47;
      out_aggregated_sig <= in_aggregated_sig(7 downto 0);
      R_ix_x0_70_resized <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    array_obj_ref_73_root_address_inst: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      array_obj_ref_73_root_address_inst_ack_0 <= array_obj_ref_73_root_address_inst_req_0;
      in_aggregated_sig <= array_obj_ref_73_final_offset;
      out_aggregated_sig <= in_aggregated_sig;
      array_obj_ref_73_root_address <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    array_obj_ref_80_index_0_resize: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      array_obj_ref_80_index_0_resize_ack_0 <= array_obj_ref_80_index_0_resize_req_0;
      in_aggregated_sig <= ix_x0_47;
      out_aggregated_sig <= in_aggregated_sig(7 downto 0);
      R_ix_x0_77_resized <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    array_obj_ref_80_root_address_inst: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      array_obj_ref_80_root_address_inst_ack_0 <= array_obj_ref_80_root_address_inst_req_0;
      in_aggregated_sig <= array_obj_ref_80_final_offset;
      out_aggregated_sig <= in_aggregated_sig;
      array_obj_ref_80_root_address <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    array_obj_ref_87_index_0_resize: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      array_obj_ref_87_index_0_resize_ack_0 <= array_obj_ref_87_index_0_resize_req_0;
      in_aggregated_sig <= ix_x0_47;
      out_aggregated_sig <= in_aggregated_sig(7 downto 0);
      R_ix_x0_84_resized <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    array_obj_ref_87_root_address_inst: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      array_obj_ref_87_root_address_inst_ack_0 <= array_obj_ref_87_root_address_inst_req_0;
      in_aggregated_sig <= array_obj_ref_87_final_offset;
      out_aggregated_sig <= in_aggregated_sig;
      array_obj_ref_87_root_address <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    array_obj_ref_94_index_0_resize: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      array_obj_ref_94_index_0_resize_ack_0 <= array_obj_ref_94_index_0_resize_req_0;
      in_aggregated_sig <= ix_x0_47;
      out_aggregated_sig <= in_aggregated_sig(7 downto 0);
      R_ix_x0_91_resized <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    array_obj_ref_94_root_address_inst: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      array_obj_ref_94_root_address_inst_ack_0 <= array_obj_ref_94_root_address_inst_req_0;
      in_aggregated_sig <= array_obj_ref_94_final_offset;
      out_aggregated_sig <= in_aggregated_sig;
      array_obj_ref_94_root_address <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    array_obj_ref_99_index_0_resize: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      array_obj_ref_99_index_0_resize_ack_0 <= array_obj_ref_99_index_0_resize_req_0;
      in_aggregated_sig <= ix_x0_47;
      out_aggregated_sig <= in_aggregated_sig(7 downto 0);
      R_ix_x0_98_resized <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    array_obj_ref_99_index_offset: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      array_obj_ref_99_index_offset_ack_0 <= array_obj_ref_99_index_offset_req_0;
      in_aggregated_sig <= R_ix_x0_98_scaled;
      out_aggregated_sig <= in_aggregated_sig;
      array_obj_ref_99_final_offset <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    array_obj_ref_99_root_address_inst: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      array_obj_ref_99_root_address_inst_ack_0 <= array_obj_ref_99_root_address_inst_req_0;
      in_aggregated_sig <= array_obj_ref_99_final_offset;
      out_aggregated_sig <= in_aggregated_sig;
      array_obj_ref_99_root_address <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_123_addr_0: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_123_addr_0_ack_0 <= ptr_deref_123_addr_0_req_0;
      in_aggregated_sig <= ptr_deref_123_root_address;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_123_word_address_0 <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_123_base_resize: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_123_base_resize_ack_0 <= ptr_deref_123_base_resize_req_0;
      in_aggregated_sig <= scevgep7_61;
      out_aggregated_sig <= in_aggregated_sig(7 downto 0);
      ptr_deref_123_resized_base_address <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_123_gather_scatter: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(31 downto 0);
      --
    begin -- 
      ptr_deref_123_gather_scatter_ack_0 <= ptr_deref_123_gather_scatter_req_0;
      in_aggregated_sig <= iNsTr_7_121;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_123_data_0 <= out_aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_123_root_address_inst: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_123_root_address_inst_ack_0 <= ptr_deref_123_root_address_inst_req_0;
      in_aggregated_sig <= ptr_deref_123_resized_base_address;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_123_root_address <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_130_addr_0: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_130_addr_0_ack_0 <= ptr_deref_130_addr_0_req_0;
      in_aggregated_sig <= ptr_deref_130_root_address;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_130_word_address_0 <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_130_base_resize: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_130_base_resize_ack_0 <= ptr_deref_130_base_resize_req_0;
      in_aggregated_sig <= scevgep6_68;
      out_aggregated_sig <= in_aggregated_sig(7 downto 0);
      ptr_deref_130_resized_base_address <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_130_gather_scatter: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(31 downto 0);
      --
    begin -- 
      ptr_deref_130_gather_scatter_ack_0 <= ptr_deref_130_gather_scatter_req_0;
      in_aggregated_sig <= iNsTr_10_128;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_130_data_0 <= out_aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_130_root_address_inst: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_130_root_address_inst_ack_0 <= ptr_deref_130_root_address_inst_req_0;
      in_aggregated_sig <= ptr_deref_130_resized_base_address;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_130_root_address <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_137_addr_0: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_137_addr_0_ack_0 <= ptr_deref_137_addr_0_req_0;
      in_aggregated_sig <= ptr_deref_137_root_address;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_137_word_address_0 <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_137_base_resize: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_137_base_resize_ack_0 <= ptr_deref_137_base_resize_req_0;
      in_aggregated_sig <= scevgep5_75;
      out_aggregated_sig <= in_aggregated_sig(7 downto 0);
      ptr_deref_137_resized_base_address <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_137_gather_scatter: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(31 downto 0);
      --
    begin -- 
      ptr_deref_137_gather_scatter_ack_0 <= ptr_deref_137_gather_scatter_req_0;
      in_aggregated_sig <= iNsTr_13_135;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_137_data_0 <= out_aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_137_root_address_inst: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_137_root_address_inst_ack_0 <= ptr_deref_137_root_address_inst_req_0;
      in_aggregated_sig <= ptr_deref_137_resized_base_address;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_137_root_address <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_144_addr_0: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_144_addr_0_ack_0 <= ptr_deref_144_addr_0_req_0;
      in_aggregated_sig <= ptr_deref_144_root_address;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_144_word_address_0 <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_144_base_resize: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_144_base_resize_ack_0 <= ptr_deref_144_base_resize_req_0;
      in_aggregated_sig <= scevgep4_82;
      out_aggregated_sig <= in_aggregated_sig(7 downto 0);
      ptr_deref_144_resized_base_address <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_144_gather_scatter: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(31 downto 0);
      --
    begin -- 
      ptr_deref_144_gather_scatter_ack_0 <= ptr_deref_144_gather_scatter_req_0;
      in_aggregated_sig <= iNsTr_16_142;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_144_data_0 <= out_aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_144_root_address_inst: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_144_root_address_inst_ack_0 <= ptr_deref_144_root_address_inst_req_0;
      in_aggregated_sig <= ptr_deref_144_resized_base_address;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_144_root_address <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_151_addr_0: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_151_addr_0_ack_0 <= ptr_deref_151_addr_0_req_0;
      in_aggregated_sig <= ptr_deref_151_root_address;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_151_word_address_0 <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_151_base_resize: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_151_base_resize_ack_0 <= ptr_deref_151_base_resize_req_0;
      in_aggregated_sig <= scevgep3_89;
      out_aggregated_sig <= in_aggregated_sig(7 downto 0);
      ptr_deref_151_resized_base_address <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_151_gather_scatter: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(31 downto 0);
      --
    begin -- 
      ptr_deref_151_gather_scatter_ack_0 <= ptr_deref_151_gather_scatter_req_0;
      in_aggregated_sig <= iNsTr_19_149;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_151_data_0 <= out_aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_151_root_address_inst: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_151_root_address_inst_ack_0 <= ptr_deref_151_root_address_inst_req_0;
      in_aggregated_sig <= ptr_deref_151_resized_base_address;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_151_root_address <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_158_addr_0: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_158_addr_0_ack_0 <= ptr_deref_158_addr_0_req_0;
      in_aggregated_sig <= ptr_deref_158_root_address;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_158_word_address_0 <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_158_base_resize: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_158_base_resize_ack_0 <= ptr_deref_158_base_resize_req_0;
      in_aggregated_sig <= scevgep2_96;
      out_aggregated_sig <= in_aggregated_sig(7 downto 0);
      ptr_deref_158_resized_base_address <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_158_gather_scatter: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(31 downto 0);
      --
    begin -- 
      ptr_deref_158_gather_scatter_ack_0 <= ptr_deref_158_gather_scatter_req_0;
      in_aggregated_sig <= iNsTr_22_156;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_158_data_0 <= out_aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_158_root_address_inst: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_158_root_address_inst_ack_0 <= ptr_deref_158_root_address_inst_req_0;
      in_aggregated_sig <= ptr_deref_158_resized_base_address;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_158_root_address <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_162_addr_0: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_162_addr_0_ack_0 <= ptr_deref_162_addr_0_req_0;
      in_aggregated_sig <= ptr_deref_162_root_address;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_162_word_address_0 <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_162_base_resize: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_162_base_resize_ack_0 <= ptr_deref_162_base_resize_req_0;
      in_aggregated_sig <= scevgep1_106;
      out_aggregated_sig <= in_aggregated_sig(7 downto 0);
      ptr_deref_162_resized_base_address <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_162_gather_scatter: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(31 downto 0);
      --
    begin -- 
      ptr_deref_162_gather_scatter_ack_0 <= ptr_deref_162_gather_scatter_req_0;
      in_aggregated_sig <= type_cast_164_wire_constant;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_162_data_0 <= out_aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_162_root_address_inst: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_162_root_address_inst_ack_0 <= ptr_deref_162_root_address_inst_req_0;
      in_aggregated_sig <= ptr_deref_162_resized_base_address;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_162_root_address <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_28_addr_0: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_28_addr_0_ack_0 <= ptr_deref_28_addr_0_req_0;
      in_aggregated_sig <= ptr_deref_28_root_address;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_28_word_address_0 <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_28_base_resize: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_28_base_resize_ack_0 <= ptr_deref_28_base_resize_req_0;
      in_aggregated_sig <= iNsTr_0_26;
      out_aggregated_sig <= in_aggregated_sig(7 downto 0);
      ptr_deref_28_resized_base_address <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_28_gather_scatter: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(31 downto 0);
      --
    begin -- 
      ptr_deref_28_gather_scatter_ack_0 <= ptr_deref_28_gather_scatter_req_0;
      in_aggregated_sig <= type_cast_30_wire_constant;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_28_data_0 <= out_aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_28_root_address_inst: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_28_root_address_inst_ack_0 <= ptr_deref_28_root_address_inst_req_0;
      in_aggregated_sig <= ptr_deref_28_resized_base_address;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_28_root_address <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_41_addr_0: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_41_addr_0_ack_0 <= ptr_deref_41_addr_0_req_0;
      in_aggregated_sig <= ptr_deref_41_root_address;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_41_word_address_0 <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_41_base_resize: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_41_base_resize_ack_0 <= ptr_deref_41_base_resize_req_0;
      in_aggregated_sig <= iNsTr_2_39;
      out_aggregated_sig <= in_aggregated_sig(7 downto 0);
      ptr_deref_41_resized_base_address <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_41_gather_scatter: Block -- 
      signal in_aggregated_sig: std_logic_vector(31 downto 0);
      signal out_aggregated_sig: std_logic_vector(31 downto 0);
      --
    begin -- 
      ptr_deref_41_gather_scatter_ack_0 <= ptr_deref_41_gather_scatter_req_0;
      in_aggregated_sig <= type_cast_43_wire_constant;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_41_data_0 <= out_aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_41_root_address_inst: Block -- 
      signal in_aggregated_sig: std_logic_vector(7 downto 0);
      signal out_aggregated_sig: std_logic_vector(7 downto 0);
      --
    begin -- 
      ptr_deref_41_root_address_inst_ack_0 <= ptr_deref_41_root_address_inst_req_0;
      in_aggregated_sig <= ptr_deref_41_resized_base_address;
      out_aggregated_sig <= in_aggregated_sig;
      ptr_deref_41_root_address <= out_aggregated_sig(7 downto 0);
      --
    end Block;
    -- shared split operator group (0) : ADD_u32_u32_111_inst 
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
      data_in <= ix_x0_47;
      tmp_112 <= data_out(31 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= ADD_u32_u32_111_inst_req_0;
      ADD_u32_u32_111_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= ADD_u32_u32_111_inst_req_1;
      ADD_u32_u32_111_inst_ack_1 <= ackR_unguarded(0);
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
    -- shared split operator group (1) : ADD_u32_u32_117_inst 
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
      data_in <= ix_x0_47;
      iNsTr_5_118 <= data_out(31 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= ADD_u32_u32_117_inst_req_0;
      ADD_u32_u32_117_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= ADD_u32_u32_117_inst_req_1;
      ADD_u32_u32_117_inst_ack_1 <= ackR_unguarded(0);
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
    -- shared split operator group (2) : array_obj_ref_94_index_0_scale array_obj_ref_80_index_0_scale array_obj_ref_87_index_0_scale array_obj_ref_73_index_0_scale array_obj_ref_59_index_0_scale array_obj_ref_66_index_0_scale array_obj_ref_99_index_0_scale 
    ApIntMul_group_2: Block -- 
      signal data_in: std_logic_vector(55 downto 0);
      signal data_out: std_logic_vector(55 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 6 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 6 downto 0);
      signal reqL_unregulated, ackL_unregulated : BooleanArray( 6 downto 0);
      signal guard_vector : std_logic_vector( 6 downto 0);
      constant inBUFs : IntegerArray(6 downto 0) := (6 => 1, 5 => 1, 4 => 1, 3 => 1, 2 => 1, 1 => 1, 0 => 1);
      constant outBUFs : IntegerArray(6 downto 0) := (6 => 1, 5 => 1, 4 => 1, 3 => 1, 2 => 1, 1 => 1, 0 => 1);
      constant guardFlags : BooleanArray(6 downto 0) := (0 => false, 1 => false, 2 => false, 3 => false, 4 => false, 5 => false, 6 => false);
      constant guardBuffering: IntegerArray(6 downto 0)  := (0 => 1, 1 => 1, 2 => 1, 3 => 1, 4 => 1, 5 => 1, 6 => 1);
      -- 
    begin -- 
      data_in <= R_ix_x0_91_resized & R_ix_x0_77_resized & R_ix_x0_84_resized & R_ix_x0_70_resized & R_ix_x0_56_resized & R_ix_x0_63_resized & R_ix_x0_98_resized;
      R_ix_x0_91_scaled <= data_out(55 downto 48);
      R_ix_x0_77_scaled <= data_out(47 downto 40);
      R_ix_x0_84_scaled <= data_out(39 downto 32);
      R_ix_x0_70_scaled <= data_out(31 downto 24);
      R_ix_x0_56_scaled <= data_out(23 downto 16);
      R_ix_x0_63_scaled <= data_out(15 downto 8);
      R_ix_x0_98_scaled <= data_out(7 downto 0);
      guard_vector(0)  <=  '1';
      guard_vector(1)  <=  '1';
      guard_vector(2)  <=  '1';
      guard_vector(3)  <=  '1';
      guard_vector(4)  <=  '1';
      guard_vector(5)  <=  '1';
      guard_vector(6)  <=  '1';
      reqL_unguarded(6) <= array_obj_ref_94_index_0_scale_req_0;
      reqL_unguarded(5) <= array_obj_ref_80_index_0_scale_req_0;
      reqL_unguarded(4) <= array_obj_ref_87_index_0_scale_req_0;
      reqL_unguarded(3) <= array_obj_ref_73_index_0_scale_req_0;
      reqL_unguarded(2) <= array_obj_ref_59_index_0_scale_req_0;
      reqL_unguarded(1) <= array_obj_ref_66_index_0_scale_req_0;
      reqL_unguarded(0) <= array_obj_ref_99_index_0_scale_req_0;
      array_obj_ref_94_index_0_scale_ack_0 <= ackL_unguarded(6);
      array_obj_ref_80_index_0_scale_ack_0 <= ackL_unguarded(5);
      array_obj_ref_87_index_0_scale_ack_0 <= ackL_unguarded(4);
      array_obj_ref_73_index_0_scale_ack_0 <= ackL_unguarded(3);
      array_obj_ref_59_index_0_scale_ack_0 <= ackL_unguarded(2);
      array_obj_ref_66_index_0_scale_ack_0 <= ackL_unguarded(1);
      array_obj_ref_99_index_0_scale_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(6) <= array_obj_ref_94_index_0_scale_req_1;
      reqR_unguarded(5) <= array_obj_ref_80_index_0_scale_req_1;
      reqR_unguarded(4) <= array_obj_ref_87_index_0_scale_req_1;
      reqR_unguarded(3) <= array_obj_ref_73_index_0_scale_req_1;
      reqR_unguarded(2) <= array_obj_ref_59_index_0_scale_req_1;
      reqR_unguarded(1) <= array_obj_ref_66_index_0_scale_req_1;
      reqR_unguarded(0) <= array_obj_ref_99_index_0_scale_req_1;
      array_obj_ref_94_index_0_scale_ack_1 <= ackR_unguarded(6);
      array_obj_ref_80_index_0_scale_ack_1 <= ackR_unguarded(5);
      array_obj_ref_87_index_0_scale_ack_1 <= ackR_unguarded(4);
      array_obj_ref_73_index_0_scale_ack_1 <= ackR_unguarded(3);
      array_obj_ref_59_index_0_scale_ack_1 <= ackR_unguarded(2);
      array_obj_ref_66_index_0_scale_ack_1 <= ackR_unguarded(1);
      array_obj_ref_99_index_0_scale_ack_1 <= ackR_unguarded(0);
      ApIntMul_group_2_accessRegulator_0: access_regulator_base generic map (name => "ApIntMul_group_2_accessRegulator_0", num_slots => 1) -- 
        port map (req => reqL_unregulated(0), -- 
          ack => ackL_unregulated(0),
          regulated_req => reqL(0),
          regulated_ack => ackL(0),
          release_req => reqR(0),
          release_ack => ackR(0),
          clk => clk, reset => reset); -- 
      ApIntMul_group_2_accessRegulator_1: access_regulator_base generic map (name => "ApIntMul_group_2_accessRegulator_1", num_slots => 1) -- 
        port map (req => reqL_unregulated(1), -- 
          ack => ackL_unregulated(1),
          regulated_req => reqL(1),
          regulated_ack => ackL(1),
          release_req => reqR(1),
          release_ack => ackR(1),
          clk => clk, reset => reset); -- 
      ApIntMul_group_2_accessRegulator_2: access_regulator_base generic map (name => "ApIntMul_group_2_accessRegulator_2", num_slots => 1) -- 
        port map (req => reqL_unregulated(2), -- 
          ack => ackL_unregulated(2),
          regulated_req => reqL(2),
          regulated_ack => ackL(2),
          release_req => reqR(2),
          release_ack => ackR(2),
          clk => clk, reset => reset); -- 
      ApIntMul_group_2_accessRegulator_3: access_regulator_base generic map (name => "ApIntMul_group_2_accessRegulator_3", num_slots => 1) -- 
        port map (req => reqL_unregulated(3), -- 
          ack => ackL_unregulated(3),
          regulated_req => reqL(3),
          regulated_ack => ackL(3),
          release_req => reqR(3),
          release_ack => ackR(3),
          clk => clk, reset => reset); -- 
      ApIntMul_group_2_accessRegulator_4: access_regulator_base generic map (name => "ApIntMul_group_2_accessRegulator_4", num_slots => 1) -- 
        port map (req => reqL_unregulated(4), -- 
          ack => ackL_unregulated(4),
          regulated_req => reqL(4),
          regulated_ack => ackL(4),
          release_req => reqR(4),
          release_ack => ackR(4),
          clk => clk, reset => reset); -- 
      ApIntMul_group_2_accessRegulator_5: access_regulator_base generic map (name => "ApIntMul_group_2_accessRegulator_5", num_slots => 1) -- 
        port map (req => reqL_unregulated(5), -- 
          ack => ackL_unregulated(5),
          regulated_req => reqL(5),
          regulated_ack => ackL(5),
          release_req => reqR(5),
          release_ack => ackR(5),
          clk => clk, reset => reset); -- 
      ApIntMul_group_2_accessRegulator_6: access_regulator_base generic map (name => "ApIntMul_group_2_accessRegulator_6", num_slots => 1) -- 
        port map (req => reqL_unregulated(6), -- 
          ack => ackL_unregulated(6),
          regulated_req => reqL(6),
          regulated_ack => ackL(6),
          release_req => reqR(6),
          release_ack => ackR(6),
          clk => clk, reset => reset); -- 
      gI: SplitGuardInterface generic map(nreqs => 7, buffering => guardBuffering, use_guards => guardFlags) -- 
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
      SplitOperator: SplitOperatorShared -- 
        generic map ( -- 
          name => "ApIntMul_group_2",
          operator_id => "ApIntMul",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 8,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 8,
          constant_operand => "00000111",
          constant_width => 8,
          use_constant  => true,
          no_arbitration => false,
          min_clock_period => false,
          num_reqs => 7,
          use_input_buffering => true,
          detailed_buffering_per_input => inBUFs,
          detailed_buffering_per_output => outBUFs --
        )
        port map ( reqL => reqL , ackL => ackL, reqR => reqR, ackR => ackR, dataL => data_in, dataR => data_out, clk => clk, reset => reset); -- 
      -- 
    end Block; -- split operator group 2
    -- shared split operator group (3) : array_obj_ref_59_index_offset 
    ApIntAdd_group_3: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 1);
      -- 
    begin -- 
      data_in <= R_ix_x0_56_scaled;
      array_obj_ref_59_final_offset <= data_out(7 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= array_obj_ref_59_index_offset_req_0;
      array_obj_ref_59_index_offset_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= array_obj_ref_59_index_offset_req_1;
      array_obj_ref_59_index_offset_ack_1 <= ackR_unguarded(0);
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
          name => "ApIntAdd_group_3",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 8,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 8,
          constant_operand => "00000001",
          constant_width => 8,
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
    -- shared split operator group (4) : array_obj_ref_66_index_offset 
    ApIntAdd_group_4: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 1);
      -- 
    begin -- 
      data_in <= R_ix_x0_63_scaled;
      array_obj_ref_66_final_offset <= data_out(7 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= array_obj_ref_66_index_offset_req_0;
      array_obj_ref_66_index_offset_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= array_obj_ref_66_index_offset_req_1;
      array_obj_ref_66_index_offset_ack_1 <= ackR_unguarded(0);
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
          name => "ApIntAdd_group_4",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 8,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 8,
          constant_operand => "00000010",
          constant_width => 8,
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
    -- shared split operator group (5) : array_obj_ref_73_index_offset 
    ApIntAdd_group_5: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 1);
      -- 
    begin -- 
      data_in <= R_ix_x0_70_scaled;
      array_obj_ref_73_final_offset <= data_out(7 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= array_obj_ref_73_index_offset_req_0;
      array_obj_ref_73_index_offset_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= array_obj_ref_73_index_offset_req_1;
      array_obj_ref_73_index_offset_ack_1 <= ackR_unguarded(0);
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
          name => "ApIntAdd_group_5",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 8,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 8,
          constant_operand => "00000011",
          constant_width => 8,
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
    -- shared split operator group (6) : array_obj_ref_80_index_offset 
    ApIntAdd_group_6: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 1);
      -- 
    begin -- 
      data_in <= R_ix_x0_77_scaled;
      array_obj_ref_80_final_offset <= data_out(7 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= array_obj_ref_80_index_offset_req_0;
      array_obj_ref_80_index_offset_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= array_obj_ref_80_index_offset_req_1;
      array_obj_ref_80_index_offset_ack_1 <= ackR_unguarded(0);
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
          name => "ApIntAdd_group_6",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 8,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 8,
          constant_operand => "00000100",
          constant_width => 8,
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
    -- shared split operator group (7) : array_obj_ref_87_index_offset 
    ApIntAdd_group_7: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 1);
      -- 
    begin -- 
      data_in <= R_ix_x0_84_scaled;
      array_obj_ref_87_final_offset <= data_out(7 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= array_obj_ref_87_index_offset_req_0;
      array_obj_ref_87_index_offset_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= array_obj_ref_87_index_offset_req_1;
      array_obj_ref_87_index_offset_ack_1 <= ackR_unguarded(0);
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
          iwidth_1  => 8,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 8,
          constant_operand => "00000101",
          constant_width => 8,
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
    -- shared split operator group (8) : array_obj_ref_94_index_offset 
    ApIntAdd_group_8: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 1);
      -- 
    begin -- 
      data_in <= R_ix_x0_91_scaled;
      array_obj_ref_94_final_offset <= data_out(7 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= array_obj_ref_94_index_offset_req_0;
      array_obj_ref_94_index_offset_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= array_obj_ref_94_index_offset_req_1;
      array_obj_ref_94_index_offset_ack_1 <= ackR_unguarded(0);
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
          iwidth_1  => 8,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 8,
          constant_operand => "00000110",
          constant_width => 8,
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
    -- shared store operator group (0) : ptr_deref_130_store_0 ptr_deref_41_store_0 ptr_deref_123_store_0 ptr_deref_28_store_0 ptr_deref_137_store_0 ptr_deref_144_store_0 ptr_deref_151_store_0 ptr_deref_158_store_0 ptr_deref_162_store_0 
    StoreGroup0: Block -- 
      signal addr_in: std_logic_vector(71 downto 0);
      signal data_in: std_logic_vector(287 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 8 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 8 downto 0);
      signal reqL_unregulated, ackL_unregulated : BooleanArray( 8 downto 0);
      signal guard_vector : std_logic_vector( 8 downto 0);
      constant inBUFs : IntegerArray(8 downto 0) := (8 => 1, 7 => 1, 6 => 1, 5 => 1, 4 => 1, 3 => 1, 2 => 1, 1 => 1, 0 => 1);
      constant outBUFs : IntegerArray(8 downto 0) := (8 => 1, 7 => 1, 6 => 1, 5 => 1, 4 => 1, 3 => 1, 2 => 1, 1 => 1, 0 => 1);
      constant guardFlags : BooleanArray(8 downto 0) := (0 => false, 1 => false, 2 => false, 3 => false, 4 => false, 5 => false, 6 => false, 7 => false, 8 => false);
      constant guardBuffering: IntegerArray(8 downto 0)  := (0 => 1, 1 => 1, 2 => 1, 3 => 1, 4 => 1, 5 => 1, 6 => 1, 7 => 1, 8 => 1);
      -- 
    begin -- 
      reqL_unguarded(8) <= ptr_deref_130_store_0_req_0;
      reqL_unguarded(7) <= ptr_deref_41_store_0_req_0;
      reqL_unguarded(6) <= ptr_deref_123_store_0_req_0;
      reqL_unguarded(5) <= ptr_deref_28_store_0_req_0;
      reqL_unguarded(4) <= ptr_deref_137_store_0_req_0;
      reqL_unguarded(3) <= ptr_deref_144_store_0_req_0;
      reqL_unguarded(2) <= ptr_deref_151_store_0_req_0;
      reqL_unguarded(1) <= ptr_deref_158_store_0_req_0;
      reqL_unguarded(0) <= ptr_deref_162_store_0_req_0;
      ptr_deref_130_store_0_ack_0 <= ackL_unguarded(8);
      ptr_deref_41_store_0_ack_0 <= ackL_unguarded(7);
      ptr_deref_123_store_0_ack_0 <= ackL_unguarded(6);
      ptr_deref_28_store_0_ack_0 <= ackL_unguarded(5);
      ptr_deref_137_store_0_ack_0 <= ackL_unguarded(4);
      ptr_deref_144_store_0_ack_0 <= ackL_unguarded(3);
      ptr_deref_151_store_0_ack_0 <= ackL_unguarded(2);
      ptr_deref_158_store_0_ack_0 <= ackL_unguarded(1);
      ptr_deref_162_store_0_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(8) <= ptr_deref_130_store_0_req_1;
      reqR_unguarded(7) <= ptr_deref_41_store_0_req_1;
      reqR_unguarded(6) <= ptr_deref_123_store_0_req_1;
      reqR_unguarded(5) <= ptr_deref_28_store_0_req_1;
      reqR_unguarded(4) <= ptr_deref_137_store_0_req_1;
      reqR_unguarded(3) <= ptr_deref_144_store_0_req_1;
      reqR_unguarded(2) <= ptr_deref_151_store_0_req_1;
      reqR_unguarded(1) <= ptr_deref_158_store_0_req_1;
      reqR_unguarded(0) <= ptr_deref_162_store_0_req_1;
      ptr_deref_130_store_0_ack_1 <= ackR_unguarded(8);
      ptr_deref_41_store_0_ack_1 <= ackR_unguarded(7);
      ptr_deref_123_store_0_ack_1 <= ackR_unguarded(6);
      ptr_deref_28_store_0_ack_1 <= ackR_unguarded(5);
      ptr_deref_137_store_0_ack_1 <= ackR_unguarded(4);
      ptr_deref_144_store_0_ack_1 <= ackR_unguarded(3);
      ptr_deref_151_store_0_ack_1 <= ackR_unguarded(2);
      ptr_deref_158_store_0_ack_1 <= ackR_unguarded(1);
      ptr_deref_162_store_0_ack_1 <= ackR_unguarded(0);
      guard_vector(0)  <=  '1';
      guard_vector(1)  <=  '1';
      guard_vector(2)  <=  '1';
      guard_vector(3)  <=  '1';
      guard_vector(4)  <=  '1';
      guard_vector(5)  <=  '1';
      guard_vector(6)  <=  '1';
      guard_vector(7)  <=  '1';
      guard_vector(8)  <=  '1';
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
      StoreGroup0_accessRegulator_4: access_regulator_base generic map (name => "StoreGroup0_accessRegulator_4", num_slots => 1) -- 
        port map (req => reqL_unregulated(4), -- 
          ack => ackL_unregulated(4),
          regulated_req => reqL(4),
          regulated_ack => ackL(4),
          release_req => reqR(4),
          release_ack => ackR(4),
          clk => clk, reset => reset); -- 
      StoreGroup0_accessRegulator_5: access_regulator_base generic map (name => "StoreGroup0_accessRegulator_5", num_slots => 1) -- 
        port map (req => reqL_unregulated(5), -- 
          ack => ackL_unregulated(5),
          regulated_req => reqL(5),
          regulated_ack => ackL(5),
          release_req => reqR(5),
          release_ack => ackR(5),
          clk => clk, reset => reset); -- 
      StoreGroup0_accessRegulator_6: access_regulator_base generic map (name => "StoreGroup0_accessRegulator_6", num_slots => 1) -- 
        port map (req => reqL_unregulated(6), -- 
          ack => ackL_unregulated(6),
          regulated_req => reqL(6),
          regulated_ack => ackL(6),
          release_req => reqR(6),
          release_ack => ackR(6),
          clk => clk, reset => reset); -- 
      StoreGroup0_accessRegulator_7: access_regulator_base generic map (name => "StoreGroup0_accessRegulator_7", num_slots => 1) -- 
        port map (req => reqL_unregulated(7), -- 
          ack => ackL_unregulated(7),
          regulated_req => reqL(7),
          regulated_ack => ackL(7),
          release_req => reqR(7),
          release_ack => ackR(7),
          clk => clk, reset => reset); -- 
      StoreGroup0_accessRegulator_8: access_regulator_base generic map (name => "StoreGroup0_accessRegulator_8", num_slots => 1) -- 
        port map (req => reqL_unregulated(8), -- 
          ack => ackL_unregulated(8),
          regulated_req => reqL(8),
          regulated_ack => ackL(8),
          release_req => reqR(8),
          release_ack => ackR(8),
          clk => clk, reset => reset); -- 
      gI: SplitGuardInterface generic map(nreqs => 9, buffering => guardBuffering, use_guards => guardFlags) -- 
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
      addr_in <= ptr_deref_130_word_address_0 & ptr_deref_41_word_address_0 & ptr_deref_123_word_address_0 & ptr_deref_28_word_address_0 & ptr_deref_137_word_address_0 & ptr_deref_144_word_address_0 & ptr_deref_151_word_address_0 & ptr_deref_158_word_address_0 & ptr_deref_162_word_address_0;
      data_in <= ptr_deref_130_data_0 & ptr_deref_41_data_0 & ptr_deref_123_data_0 & ptr_deref_28_data_0 & ptr_deref_137_data_0 & ptr_deref_144_data_0 & ptr_deref_151_data_0 & ptr_deref_158_data_0 & ptr_deref_162_data_0;
      StoreReq: StoreReqSharedWithInputBuffers -- 
        generic map ( name => "StoreGroup0 Req ", addr_width => 8,
        data_width => 32,
        num_reqs => 9,
        tag_length => 4,
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
          maddr => memory_space_0_sr_addr(7 downto 0),
          mdata => memory_space_0_sr_data(31 downto 0),
          mtag => memory_space_0_sr_tag(3 downto 0),
          clk => clk, reset => reset -- 
        );--
      StoreComplete: StoreCompleteShared -- 
        generic map ( -- 
          name => "StoreGroup0 Complete ",
          num_reqs => 9,
          detailed_buffering_per_output => outBUFs,
          tag_length => 4 -- 
        )
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          mreq => memory_space_0_sc_req(0),
          mack => memory_space_0_sc_ack(0),
          mtag => memory_space_0_sc_tag(3 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 0
    -- shared inport operator group (0) : RPIPE_in_data_134_inst RPIPE_in_data_120_inst RPIPE_in_data_127_inst RPIPE_in_data_141_inst RPIPE_in_data_148_inst RPIPE_in_data_155_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(191 downto 0);
      signal reqL, ackL, reqR, ackR : BooleanArray( 5 downto 0);
      signal reqL_unguarded, ackL_unguarded : BooleanArray( 5 downto 0);
      signal reqR_unguarded, ackR_unguarded : BooleanArray( 5 downto 0);
      signal guard_vector : std_logic_vector( 5 downto 0);
      constant outBUFs : IntegerArray(5 downto 0) := (5 => 1, 4 => 1, 3 => 1, 2 => 1, 1 => 1, 0 => 1);
      constant guardFlags : BooleanArray(5 downto 0) := (0 => false, 1 => false, 2 => false, 3 => false, 4 => false, 5 => false);
      constant guardBuffering: IntegerArray(5 downto 0)  := (0 => 1, 1 => 1, 2 => 1, 3 => 1, 4 => 1, 5 => 1);
      -- 
    begin -- 
      reqL_unguarded(5) <= RPIPE_in_data_134_inst_req_0;
      reqL_unguarded(4) <= RPIPE_in_data_120_inst_req_0;
      reqL_unguarded(3) <= RPIPE_in_data_127_inst_req_0;
      reqL_unguarded(2) <= RPIPE_in_data_141_inst_req_0;
      reqL_unguarded(1) <= RPIPE_in_data_148_inst_req_0;
      reqL_unguarded(0) <= RPIPE_in_data_155_inst_req_0;
      RPIPE_in_data_134_inst_ack_0 <= ackL_unguarded(5);
      RPIPE_in_data_120_inst_ack_0 <= ackL_unguarded(4);
      RPIPE_in_data_127_inst_ack_0 <= ackL_unguarded(3);
      RPIPE_in_data_141_inst_ack_0 <= ackL_unguarded(2);
      RPIPE_in_data_148_inst_ack_0 <= ackL_unguarded(1);
      RPIPE_in_data_155_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(5) <= RPIPE_in_data_134_inst_req_1;
      reqR_unguarded(4) <= RPIPE_in_data_120_inst_req_1;
      reqR_unguarded(3) <= RPIPE_in_data_127_inst_req_1;
      reqR_unguarded(2) <= RPIPE_in_data_141_inst_req_1;
      reqR_unguarded(1) <= RPIPE_in_data_148_inst_req_1;
      reqR_unguarded(0) <= RPIPE_in_data_155_inst_req_1;
      RPIPE_in_data_134_inst_ack_1 <= ackR_unguarded(5);
      RPIPE_in_data_120_inst_ack_1 <= ackR_unguarded(4);
      RPIPE_in_data_127_inst_ack_1 <= ackR_unguarded(3);
      RPIPE_in_data_141_inst_ack_1 <= ackR_unguarded(2);
      RPIPE_in_data_148_inst_ack_1 <= ackR_unguarded(1);
      RPIPE_in_data_155_inst_ack_1 <= ackR_unguarded(0);
      guard_vector(0)  <=  '1';
      guard_vector(1)  <=  '1';
      guard_vector(2)  <=  '1';
      guard_vector(3)  <=  '1';
      guard_vector(4)  <=  '1';
      guard_vector(5)  <=  '1';
      gI: SplitGuardInterface generic map(nreqs => 6, buffering => guardBuffering, use_guards => guardFlags) -- 
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
      iNsTr_13_135 <= data_out(191 downto 160);
      iNsTr_7_121 <= data_out(159 downto 128);
      iNsTr_10_128 <= data_out(127 downto 96);
      iNsTr_16_142 <= data_out(95 downto 64);
      iNsTr_19_149 <= data_out(63 downto 32);
      iNsTr_22_156 <= data_out(31 downto 0);
      in_data_read_0: InputPortFullRate -- 
        generic map ( name => "in_data_read_0", data_width => 32,  num_reqs => 6,  output_buffering => outBUFs,   no_arbitration => false)
        port map (-- 
          sample_req => reqL , 
          sample_ack => ackL, 
          update_req => reqR, 
          update_ack => ackR, 
          data => data_out, 
          oreq => in_data_pipe_read_req(0),
          oack => in_data_pipe_read_ack(0),
          odata => in_data_pipe_read_data(31 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 0
    -- shared outport operator group (0) : WPIPE_out_id_166_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal sample_req, sample_ack : BooleanArray( 0 downto 0);
      signal update_req, update_ack : BooleanArray( 0 downto 0);
      signal sample_req_unguarded, sample_ack_unguarded : BooleanArray( 0 downto 0);
      signal update_req_unguarded, update_ack_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 1);
      -- 
    begin -- 
      sample_req_unguarded(0) <= WPIPE_out_id_166_inst_req_0;
      WPIPE_out_id_166_inst_ack_0 <= sample_ack_unguarded(0);
      update_req_unguarded(0) <= WPIPE_out_id_166_inst_req_1;
      WPIPE_out_id_166_inst_ack_1 <= update_ack_unguarded(0);
      guard_vector(0)  <=  '1';
      gI: SplitGuardInterface generic map(nreqs => 1, buffering => guardBuffering, use_guards => guardFlags) -- 
        port map(clk => clk, reset => reset,
        sr_in => sample_req_unguarded,
        sr_out => sample_req,
        sa_in => sample_ack,
        sa_out => sample_ack_unguarded,
        cr_in => update_req_unguarded,
        cr_out => update_req,
        ca_in => update_ack,
        ca_out => update_ack_unguarded,
        guards => guard_vector); -- 
      data_in <= tmp_112;
      out_id_write_0: OutputPortFullRate -- 
        generic map ( name => "out_id", data_width => 32, num_reqs => 1, input_buffering => inBUFs, no_arbitration => false)
        port map (--
          sample_req => sample_req , 
          sample_ack => sample_ack , 
          update_req => update_req , 
          update_ack => update_ack , 
          data => data_in, 
          oreq => out_id_pipe_write_req(0),
          oack => out_id_pipe_write_ack(0),
          odata => out_id_pipe_write_data(31 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 0
    -- 
  end Block; -- data_path
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
library work;
use work.ahir_system_global_package.all;
entity ahir_system is  -- system 
  port (-- 
    clk : in std_logic;
    reset : in std_logic;
    in_data_pipe_write_data: in std_logic_vector(31 downto 0);
    in_data_pipe_write_req : in std_logic_vector(0 downto 0);
    in_data_pipe_write_ack : out std_logic_vector(0 downto 0);
    out_id_pipe_read_data: out std_logic_vector(31 downto 0);
    out_id_pipe_read_req : in std_logic_vector(0 downto 0);
    out_id_pipe_read_ack : out std_logic_vector(0 downto 0)); -- 
  -- 
end entity; 
architecture Default of ahir_system is -- system-architecture 
  -- interface signals to connect to memory space memory_space_0
  signal memory_space_0_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_0_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_0_sr_addr : std_logic_vector(7 downto 0);
  signal memory_space_0_sr_data : std_logic_vector(31 downto 0);
  signal memory_space_0_sr_tag : std_logic_vector(3 downto 0);
  signal memory_space_0_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_0_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_0_sc_tag :  std_logic_vector(3 downto 0);
  -- interface signals to connect to memory space memory_space_1
  -- declarations related to module hardware1
  component hardware1 is -- 
    generic (tag_length : integer); 
    port ( -- 
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic;
      memory_space_0_sr_req : out  std_logic_vector(0 downto 0);
      memory_space_0_sr_ack : in   std_logic_vector(0 downto 0);
      memory_space_0_sr_addr : out  std_logic_vector(7 downto 0);
      memory_space_0_sr_data : out  std_logic_vector(31 downto 0);
      memory_space_0_sr_tag :  out  std_logic_vector(3 downto 0);
      memory_space_0_sc_req : out  std_logic_vector(0 downto 0);
      memory_space_0_sc_ack : in   std_logic_vector(0 downto 0);
      memory_space_0_sc_tag :  in  std_logic_vector(3 downto 0);
      in_data_pipe_read_req : out  std_logic_vector(0 downto 0);
      in_data_pipe_read_ack : in   std_logic_vector(0 downto 0);
      in_data_pipe_read_data : in   std_logic_vector(31 downto 0);
      out_id_pipe_write_req : out  std_logic_vector(0 downto 0);
      out_id_pipe_write_ack : in   std_logic_vector(0 downto 0);
      out_id_pipe_write_data : out  std_logic_vector(31 downto 0);
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
    );
    -- 
  end component;
  -- argument signals for module hardware1
  signal hardware1_tag_in    : std_logic_vector(1 downto 0) := (others => '0');
  signal hardware1_tag_out   : std_logic_vector(1 downto 0);
  signal hardware1_start_req : std_logic;
  signal hardware1_start_ack : std_logic;
  signal hardware1_fin_req   : std_logic;
  signal hardware1_fin_ack : std_logic;
  -- aggregate signals for read from pipe in_data
  signal in_data_pipe_read_data: std_logic_vector(31 downto 0);
  signal in_data_pipe_read_req: std_logic_vector(0 downto 0);
  signal in_data_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe out_id
  signal out_id_pipe_write_data: std_logic_vector(31 downto 0);
  signal out_id_pipe_write_req: std_logic_vector(0 downto 0);
  signal out_id_pipe_write_ack: std_logic_vector(0 downto 0);
  -- 
begin -- 
  -- module hardware1
  hardware1_instance:hardware1-- 
    generic map(tag_length => 2)
    port map(-- 
      start_req => hardware1_start_req,
      start_ack => hardware1_start_ack,
      fin_req => hardware1_fin_req,
      fin_ack => hardware1_fin_ack,
      clk => clk,
      reset => reset,
      memory_space_0_sr_req => memory_space_0_sr_req(0 downto 0),
      memory_space_0_sr_ack => memory_space_0_sr_ack(0 downto 0),
      memory_space_0_sr_addr => memory_space_0_sr_addr(7 downto 0),
      memory_space_0_sr_data => memory_space_0_sr_data(31 downto 0),
      memory_space_0_sr_tag => memory_space_0_sr_tag(3 downto 0),
      memory_space_0_sc_req => memory_space_0_sc_req(0 downto 0),
      memory_space_0_sc_ack => memory_space_0_sc_ack(0 downto 0),
      memory_space_0_sc_tag => memory_space_0_sc_tag(3 downto 0),
      in_data_pipe_read_req => in_data_pipe_read_req(0 downto 0),
      in_data_pipe_read_ack => in_data_pipe_read_ack(0 downto 0),
      in_data_pipe_read_data => in_data_pipe_read_data(31 downto 0),
      out_id_pipe_write_req => out_id_pipe_write_req(0 downto 0),
      out_id_pipe_write_ack => out_id_pipe_write_ack(0 downto 0),
      out_id_pipe_write_data => out_id_pipe_write_data(31 downto 0),
      tag_in => hardware1_tag_in,
      tag_out => hardware1_tag_out-- 
    ); -- 
  -- module will be run forever 
  hardware1_tag_in <= (others => '0');
  hardware1_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start_req => hardware1_start_req, start_ack => hardware1_start_ack,  fin_req => hardware1_fin_req,  fin_ack => hardware1_fin_ack);
  in_data_Pipe: PipeBase -- 
    generic map( -- 
      name => "pipe in_data",
      num_reads => 1,
      num_writes => 1,
      data_width => 32,
      lifo_mode => false,
      depth => 8 --
    )
    port map( -- 
      read_req => in_data_pipe_read_req,
      read_ack => in_data_pipe_read_ack,
      read_data => in_data_pipe_read_data,
      write_req => in_data_pipe_write_req,
      write_ack => in_data_pipe_write_ack,
      write_data => in_data_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  out_id_Pipe: PipeBase -- 
    generic map( -- 
      name => "pipe out_id",
      num_reads => 1,
      num_writes => 1,
      data_width => 32,
      lifo_mode => false,
      depth => 8 --
    )
    port map( -- 
      read_req => out_id_pipe_read_req,
      read_ack => out_id_pipe_read_ack,
      read_data => out_id_pipe_read_data,
      write_req => out_id_pipe_write_req,
      write_ack => out_id_pipe_write_ack,
      write_data => out_id_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  dummyWOM_memory_space_0: dummy_write_only_memory_subsystem -- 
    generic map(-- 
      num_stores => 1,
      addr_width => 8,
      data_width => 32,
      tag_width => 4
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
  -- 
end Default;
