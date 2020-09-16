// © IBM Corp. 2020
// This softcore is licensed under and subject to the terms of the CC-BY 4.0
// license (https://creativecommons.org/licenses/by/4.0/legalcode). 
// Additional rights, including the right to physically implement a softcore 
// that is compliant with the required sections of the Power ISA 
// Specification, will be available at no cost via the OpenPOWER Foundation. 
// This README will be updated with additional information when OpenPOWER's 
// license is available.

//********************************************************************
//*
//* TITLE: Debug Mux Component (4:1 Debug Groups; 4:1 Trigger Groups)
//*
//* NAME: tri_debug_mux4.vhdl
//*
//********************************************************************


module tri_debug_mux4(
//   vd,
//   gd,
   select_bits,
   dbg_group0,
   dbg_group1,
   dbg_group2,
   dbg_group3,
   trace_data_in,
   trace_data_out,

   // Instruction Trace (HTM) Controls
   coretrace_ctrls_in,
   coretrace_ctrls_out
);

// Include model build parameters
   parameter              DBG_WIDTH = 32;	// A2o=32; A2i=88

//=====================================================================
// Port Definitions
//=====================================================================

   input  [0:10]          select_bits;
   input  [0:DBG_WIDTH-1] dbg_group0;
   input  [0:DBG_WIDTH-1] dbg_group1;
   input  [0:DBG_WIDTH-1] dbg_group2;
   input  [0:DBG_WIDTH-1] dbg_group3;
   input  [0:DBG_WIDTH-1] trace_data_in;
   output [0:DBG_WIDTH-1] trace_data_out;

// Instruction Trace (HTM) Control Signals:
//  0    - ac_an_coretrace_first_valid
//  1    - ac_an_coretrace_valid
//  2:3  - ac_an_coretrace_type[0:1]
   input  [0:3]           coretrace_ctrls_in;
   output [0:3]           coretrace_ctrls_out;

//=====================================================================
// Signal Declarations / Misc
//=====================================================================
   parameter              DBG_1FOURTH = DBG_WIDTH/4;
   parameter              DBG_2FOURTH = DBG_WIDTH/2;
   parameter              DBG_3FOURTH = 3 * DBG_WIDTH/4;

   wire [0:DBG_WIDTH-1]   debug_grp_selected;
   wire [0:DBG_WIDTH-1]   debug_grp_rotated;

// Don't reference unused inputs:
(* analysis_not_referenced="true" *)
   wire                   unused;
   assign unused = (|select_bits[2:4]) ;

// Instruction Trace controls are passed-through:
   assign coretrace_ctrls_out =  coretrace_ctrls_in ;

//=====================================================================
// Mux Function
//=====================================================================
   // Debug Mux
   assign debug_grp_selected = (select_bits[0:1] == 2'b00) ? dbg_group0 :
                               (select_bits[0:1] == 2'b01) ? dbg_group1 :
                               (select_bits[0:1] == 2'b10) ? dbg_group2 :
                               dbg_group3;

   assign debug_grp_rotated  = (select_bits[5:6] == 2'b11) ? {debug_grp_selected[DBG_1FOURTH:DBG_WIDTH - 1], debug_grp_selected[0:DBG_1FOURTH - 1]} :
                               (select_bits[5:6] == 2'b10) ? {debug_grp_selected[DBG_2FOURTH:DBG_WIDTH - 1], debug_grp_selected[0:DBG_2FOURTH - 1]} :
                               (select_bits[5:6] == 2'b01) ? {debug_grp_selected[DBG_3FOURTH:DBG_WIDTH - 1], debug_grp_selected[0:DBG_3FOURTH - 1]} :
                               debug_grp_selected[0:DBG_WIDTH - 1];


   assign trace_data_out[0:DBG_1FOURTH - 1]		= (select_bits[7] == 1'b0) ? trace_data_in[0:DBG_1FOURTH - 1] :
				                              debug_grp_rotated[0:DBG_1FOURTH - 1];

   assign trace_data_out[DBG_1FOURTH:DBG_2FOURTH - 1]	= (select_bits[8] == 1'b0) ? trace_data_in[DBG_1FOURTH:DBG_2FOURTH - 1] :
                                                          debug_grp_rotated[DBG_1FOURTH:DBG_2FOURTH - 1];

   assign trace_data_out[DBG_2FOURTH:DBG_3FOURTH - 1]	= (select_bits[9] == 1'b0) ? trace_data_in[DBG_2FOURTH:DBG_3FOURTH - 1] :
                                                          debug_grp_rotated[DBG_2FOURTH:DBG_3FOURTH - 1];

   assign trace_data_out[DBG_3FOURTH:DBG_WIDTH - 1]	= (select_bits[10] == 1'b0) ? trace_data_in[DBG_3FOURTH:DBG_WIDTH - 1] :
                                                          debug_grp_rotated[DBG_3FOURTH:DBG_WIDTH - 1];


endmodule
