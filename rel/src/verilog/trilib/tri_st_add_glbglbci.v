// © IBM Corp. 2020
// This softcore is licensed under and subject to the terms of the CC-BY 4.0
// license (https://creativecommons.org/licenses/by/4.0/legalcode). 
// Additional rights, including the right to physically implement a softcore 
// that is compliant with the required sections of the Power ISA 
// Specification, will be available at no cost via the OpenPOWER Foundation. 
// This README will be updated with additional information when OpenPOWER's 
// license is available.

//  Description:  Adder Component
//
//*****************************************************************************

// input phase is important
// (change X (B) by switching xor/xnor )

module tri_st_add_glbglbci(
   g08,
   t08,
   ci,
   c64_b
);
   input [0:7]  g08;
   input [0:7]  t08;
   input        ci;
   output [0:7] c64_b;

   wire [0:3]   b0_g16_b;
   wire [0:2]   b0_t16_b;
   wire [0:1]   b0_g32;
   wire [0:0]   b0_t32;
   wire [0:3]   b1_g16_b;
   wire [0:2]   b1_t16_b;
   wire [0:1]   b1_g32;
   wire [0:0]   b1_t32;
   wire [0:3]   b2_g16_b;
   wire [0:2]   b2_t16_b;
   wire [0:1]   b2_g32;
   wire [0:0]   b2_t32;
   wire [0:3]   b3_g16_b;
   wire [0:2]   b3_t16_b;
   wire [0:1]   b3_g32;
   wire [0:0]   b3_t32;
   wire [0:3]   b4_g16_b;
   wire [0:2]   b4_t16_b;
   wire [0:1]   b4_g32;
   wire [0:0]   b4_t32;
   wire [0:2]   b5_g16_b;
   wire [0:1]   b5_t16_b;
   wire [0:1]   b5_g32;
   wire [0:0]   b5_t32;
   wire [0:1]   b6_g16_b;
   wire [0:0]   b6_t16_b;
   wire [0:0]   b6_g32;
   wire [0:0]   b7_g16_b;
   wire [0:0]   b7_g32;
   wire         b0_g56_b;
   wire         b0_c64;
   wire [0:0]   g08_b;
   wire [0:0]   t08_b;

   ////#############################
   ////## byte 0 <for CO only ??
   ////#############################

   assign b0_g16_b[0] = (~(g08[1] | (t08[1] & g08[2])));
   assign b0_g16_b[1] = (~(g08[3] | (t08[3] & g08[4])));
   assign b0_g16_b[2] = (~(g08[5] | (t08[5] & g08[6])));
   assign b0_g16_b[3] = (~(g08[7] | (t08[7] & ci)));

   assign b0_t16_b[0] = (~(t08[1] & t08[2]));
   assign b0_t16_b[1] = (~(t08[3] & t08[4]));
   assign b0_t16_b[2] = (~(t08[5] & t08[6]));

   assign b0_g32[0] = (~(b0_g16_b[0] & (b0_t16_b[0] | b0_g16_b[1])));
   assign b0_g32[1] = (~(b0_g16_b[2] & (b0_t16_b[2] | b0_g16_b[3])));
   assign b0_t32[0] = (~(b0_t16_b[0] | b0_t16_b[1]));

   assign g08_b[0] = (~g08[0]);
   assign t08_b[0] = (~t08[0]);

   assign b0_g56_b = (~(b0_g32[0] | (b0_t32[0] & b0_g32[1])));		//output--

   assign b0_c64 = (~(g08_b[0] & (t08_b[0] | b0_g56_b)));

   assign c64_b[0] = (~(b0_c64));

   ////#############################
   ////## byte 1
   ////#############################

   assign b1_g16_b[0] = (~(g08[1] | (t08[1] & g08[2])));
   assign b1_g16_b[1] = (~(g08[3] | (t08[3] & g08[4])));
   assign b1_g16_b[2] = (~(g08[5] | (t08[5] & g08[6])));
   assign b1_g16_b[3] = (~(g08[7] | (t08[7] & ci)));

   assign b1_t16_b[0] = (~(t08[1] & t08[2]));
   assign b1_t16_b[1] = (~(t08[3] & t08[4]));
   assign b1_t16_b[2] = (~(t08[5] & t08[6]));

   assign b1_g32[0] = (~(b1_g16_b[0] & (b1_t16_b[0] | b1_g16_b[1])));
   assign b1_g32[1] = (~(b1_g16_b[2] & (b1_t16_b[2] | b1_g16_b[3])));
   assign b1_t32[0] = (~(b1_t16_b[0] | b1_t16_b[1]));

   assign c64_b[1] = (~(b1_g32[0] | (b1_t32[0] & b1_g32[1])));		//output--

   ////#############################
   ////## byte 2
   ////#############################

   assign b2_g16_b[0] = (~(g08[2] | (t08[2] & g08[3])));
   assign b2_g16_b[1] = (~(g08[4] | (t08[4] & g08[5])));
   assign b2_g16_b[2] = (~(g08[6]));
   assign b2_g16_b[3] = (~(g08[7] | (t08[7] & ci)));

   assign b2_t16_b[0] = (~(t08[2] & t08[3]));
   assign b2_t16_b[1] = (~(t08[4] & t08[5]));
   assign b2_t16_b[2] = (~(t08[6]));

   assign b2_g32[0] = (~(b2_g16_b[0] & (b2_t16_b[0] | b2_g16_b[1])));
   assign b2_g32[1] = (~(b2_g16_b[2] & (b2_t16_b[2] | b2_g16_b[3])));
   assign b2_t32[0] = (~(b2_t16_b[0] | b2_t16_b[1]));

   assign c64_b[2] = (~(b2_g32[0] | (b2_t32[0] & b2_g32[1])));		//output--

   ////#############################
   ////## byte 3
   ////#############################

   assign b3_g16_b[0] = (~(g08[3] | (t08[3] & g08[4])));
   assign b3_g16_b[1] = (~(g08[5]));
   assign b3_g16_b[2] = (~(g08[6]));
   assign b3_g16_b[3] = (~(g08[7] | (t08[7] & ci)));

   assign b3_t16_b[0] = (~(t08[3] & t08[4]));
   assign b3_t16_b[1] = (~(t08[5]));
   assign b3_t16_b[2] = (~(t08[6]));

   assign b3_g32[0] = (~(b3_g16_b[0] & (b3_t16_b[0] | b3_g16_b[1])));
   assign b3_g32[1] = (~(b3_g16_b[2] & (b3_t16_b[2] | b3_g16_b[3])));
   assign b3_t32[0] = (~(b3_t16_b[0] | b3_t16_b[1]));

   assign c64_b[3] = (~(b3_g32[0] | (b3_t32[0] & b3_g32[1])));		//output--

   ////#############################
   ////## byte 4
   ////#############################

   assign b4_g16_b[0] = (~(g08[4]));
   assign b4_g16_b[1] = (~(g08[5]));
   assign b4_g16_b[2] = (~(g08[6]));
   assign b4_g16_b[3] = (~(g08[7] | (t08[7] & ci)));

   assign b4_t16_b[0] = (~(t08[4]));
   assign b4_t16_b[1] = (~(t08[5]));
   assign b4_t16_b[2] = (~(t08[6]));

   assign b4_g32[0] = (~(b4_g16_b[0] & (b4_t16_b[0] | b4_g16_b[1])));
   assign b4_g32[1] = (~(b4_g16_b[2] & (b4_t16_b[2] | b4_g16_b[3])));
   assign b4_t32[0] = (~(b4_t16_b[0] | b4_t16_b[1]));

   assign c64_b[4] = (~(b4_g32[0] | (b4_t32[0] & b4_g32[1])));		//output--

   ////#############################
   ////## byte 5
   ////#############################

   assign b5_g16_b[0] = (~(g08[5]));
   assign b5_g16_b[1] = (~(g08[6]));
   assign b5_g16_b[2] = (~(g08[7] | (t08[7] & ci)));

   assign b5_t16_b[0] = (~(t08[5]));
   assign b5_t16_b[1] = (~(t08[6]));

   assign b5_g32[0] = (~(b5_g16_b[0] & (b5_t16_b[0] | b5_g16_b[1])));
   assign b5_g32[1] = (~(b5_g16_b[2]));
   assign b5_t32[0] = (~(b5_t16_b[0] | b5_t16_b[1]));

   assign c64_b[5] = (~(b5_g32[0] | (b5_t32[0] & b5_g32[1])));		//output--

   ////#############################
   ////## byte 6
   ////#############################

   assign b6_g16_b[0] = (~(g08[6]));
   assign b6_g16_b[1] = (~(g08[7] | (t08[7] & ci)));

   assign b6_t16_b[0] = (~(t08[6]));

   assign b6_g32[0] = (~(b6_g16_b[0] & (b6_t16_b[0] | b6_g16_b[1])));

   assign c64_b[6] = (~(b6_g32[0]));		//output--

   ////#############################
   ////## byte 7
   ////#############################

   assign b7_g16_b[0] = (~(g08[7] | (t08[7] & ci)));

   assign b7_g32[0] = (~(b7_g16_b[0]));

   assign c64_b[7] = (~(b7_g32[0]));		//output--



endmodule
