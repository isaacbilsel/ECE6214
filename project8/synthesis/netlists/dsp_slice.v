/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Thu Apr 24 19:43:30 2025
/////////////////////////////////////////////////////////////


module dsp_slice_DW01_add_0 ( A, B, CI, SUM, CO );
  input [11:0] A;
  input [11:0] B;
  output [11:0] SUM;
  input CI;
  output CO;
  wire   n1, n2;
  wire   [11:1] carry;

  ADDF_F U1_10 ( .A(A[10]), .B(B[10]), .CIN(carry[10]), .COUT(carry[11]), 
        .SUM(SUM[10]) );
  ADDF_F U1_9 ( .A(A[9]), .B(B[9]), .CIN(carry[9]), .COUT(carry[10]), .SUM(
        SUM[9]) );
  ADDF_F U1_8 ( .A(A[8]), .B(B[8]), .CIN(carry[8]), .COUT(carry[9]), .SUM(
        SUM[8]) );
  ADDF_F U1_7 ( .A(A[7]), .B(B[7]), .CIN(carry[7]), .COUT(carry[8]), .SUM(
        SUM[7]) );
  ADDF_F U1_6 ( .A(A[6]), .B(B[6]), .CIN(carry[6]), .COUT(carry[7]), .SUM(
        SUM[6]) );
  ADDF_F U1_5 ( .A(A[5]), .B(B[5]), .CIN(carry[5]), .COUT(carry[6]), .SUM(
        SUM[5]) );
  ADDF_F U1_4 ( .A(A[4]), .B(B[4]), .CIN(carry[4]), .COUT(carry[5]), .SUM(
        SUM[4]) );
  ADDF_F U1_3 ( .A(A[3]), .B(B[3]), .CIN(carry[3]), .COUT(carry[4]), .SUM(
        SUM[3]) );
  ADDF_F U1_2 ( .A(A[2]), .B(B[2]), .CIN(carry[2]), .COUT(carry[3]), .SUM(
        SUM[2]) );
  ADDF_B U1_1 ( .A(A[1]), .B(B[1]), .CIN(n2), .COUT(carry[2]), .SUM(SUM[1]) );
  XOR3_D U1_11 ( .A(A[11]), .B(B[11]), .C(carry[11]), .Z(SUM[11]) );
  INVERT_D U1 ( .A(carry[1]), .Z(n1) );
  INVERT_E U2 ( .A(n1), .Z(n2) );
  AND2_H U3 ( .A(A[0]), .B(B[0]), .Z(carry[1]) );
  XOR2_C U4 ( .A(A[0]), .B(B[0]), .Z(SUM[0]) );
endmodule


module dsp_slice_DW01_add_1 ( A, B, CI, SUM, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] SUM;
  input CI;
  output CO;
  wire   \A[1] , \A[0] , n1, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13,
         n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27,
         n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41,
         n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52;
  assign SUM[1] = \A[1] ;
  assign \A[1]  = A[1];
  assign SUM[0] = \A[0] ;
  assign \A[0]  = A[0];

  NOR2_E U2 ( .A(B[4]), .B(A[4]), .Z(n45) );
  INVERT_H U3 ( .A(n31), .Z(n20) );
  AO21_F U4 ( .A1(n24), .A2(n14), .B(n9), .Z(n1) );
  INVERT_H U5 ( .A(n5), .Z(n16) );
  XOR2_B U6 ( .A(n33), .B(n21), .Z(SUM[8]) );
  NOR2_D U7 ( .A(B[5]), .B(A[5]), .Z(n41) );
  INVERT_H U8 ( .A(n41), .Z(n17) );
  AND2_H U9 ( .A(n17), .B(n43), .Z(n44) );
  INVERT_D U10 ( .A(n44), .Z(n3) );
  INVERT_E U11 ( .A(n42), .Z(n4) );
  INVERT_H U12 ( .A(n4), .Z(n5) );
  OA21_H U13 ( .A1(n46), .A2(n45), .B(n47), .Z(n42) );
  OAI21_C U14 ( .A1(n34), .A2(n12), .B(n11), .Z(n31) );
  XOR2_B U15 ( .A(n5), .B(n3), .Z(SUM[5]) );
  INVERT_D U16 ( .A(B[2]), .Z(n28) );
  INVERT_D U17 ( .A(n32), .Z(n6) );
  INVERT_E U18 ( .A(n6), .Z(n7) );
  NAND2BAL_E U19 ( .A(n23), .B(n11), .Z(n36) );
  INVERT_H U20 ( .A(n38), .Z(n8) );
  INVERT_H U21 ( .A(n8), .Z(n9) );
  AND2_I U22 ( .A(B[6]), .B(A[6]), .Z(n38) );
  INVERT_F U23 ( .A(n37), .Z(n13) );
  NOR2_F U24 ( .A(B[7]), .B(A[7]), .Z(n34) );
  INVERT_H U25 ( .A(n35), .Z(n10) );
  INVERT_H U26 ( .A(n10), .Z(n11) );
  XOR2_B U27 ( .A(n29), .B(n30), .Z(SUM[9]) );
  AO21_E U28 ( .A1(n21), .A2(A[8]), .B(n7), .Z(n30) );
  XOR2_C U29 ( .A(n40), .B(n14), .Z(SUM[6]) );
  NOR2_C U30 ( .A(n9), .B(n39), .Z(n40) );
  OA21_F U31 ( .A1(A[8]), .A2(n21), .B(B[8]), .Z(n32) );
  CLKI_O U32 ( .A(n20), .Z(n21) );
  NAND2_F U33 ( .A(B[4]), .B(A[4]), .Z(n47) );
  INVERT_H U34 ( .A(n1), .Z(n12) );
  INVERT_F U35 ( .A(n13), .Z(n14) );
  NAND2_E U36 ( .A(n15), .B(n43), .Z(n37) );
  NAND2_E U37 ( .A(n16), .B(n17), .Z(n15) );
  NAND2_F U38 ( .A(B[5]), .B(A[5]), .Z(n43) );
  INVERT_E U39 ( .A(n28), .Z(n18) );
  INVERT_H U40 ( .A(n18), .Z(n19) );
  INVERT_F U41 ( .A(n34), .Z(n23) );
  INVERT_E U42 ( .A(n51), .Z(n26) );
  NAND2BAL_E U43 ( .A(B[3]), .B(A[3]), .Z(n50) );
  INVERT_H U44 ( .A(n50), .Z(n22) );
  XOR2_B U45 ( .A(B[9]), .B(A[9]), .Z(n29) );
  XNOR2_B U46 ( .A(n48), .B(n46), .Z(SUM[4]) );
  AOI21_D U47 ( .A1(n26), .A2(n49), .B(n22), .Z(n46) );
  NOR2_C U48 ( .A(n25), .B(n45), .Z(n48) );
  XOR2_B U49 ( .A(n49), .B(n52), .Z(SUM[3]) );
  NOR2_C U50 ( .A(n22), .B(n51), .Z(n52) );
  NOR2_E U51 ( .A(B[3]), .B(A[3]), .Z(n51) );
  NOR2_E U52 ( .A(B[6]), .B(A[6]), .Z(n39) );
  XOR2_C U53 ( .A(B[8]), .B(A[8]), .Z(n33) );
  NAND2_E U54 ( .A(B[7]), .B(A[7]), .Z(n35) );
  XOR2_B U55 ( .A(n36), .B(n12), .Z(SUM[7]) );
  NOR2_F U56 ( .A(n19), .B(n27), .Z(n49) );
  INVERT_H U57 ( .A(A[2]), .Z(n27) );
  INVERT_D U58 ( .A(n39), .Z(n24) );
  INVERT_D U59 ( .A(n47), .Z(n25) );
  AOI21_A U60 ( .A1(n19), .A2(n27), .B(n49), .Z(SUM[2]) );
endmodule


module dsp_slice_DW02_mult_0 ( A, B, TC, PRODUCT );
  input [3:0] A;
  input [7:0] B;
  output [11:0] PRODUCT;
  input TC;
  wire   \ab[3][6] , \ab[3][5] , \ab[3][4] , \ab[3][3] , \ab[3][2] ,
         \ab[3][1] , \ab[3][0] , \ab[2][7] , \ab[2][6] , \ab[2][5] ,
         \ab[2][4] , \ab[2][3] , \ab[2][2] , \ab[2][1] , \ab[2][0] ,
         \ab[1][7] , \ab[1][6] , \ab[1][5] , \ab[1][4] , \ab[1][3] ,
         \ab[1][2] , \ab[1][1] , \ab[1][0] , \ab[0][7] , \ab[0][6] ,
         \ab[0][5] , \ab[0][4] , \ab[0][3] , \ab[0][2] , \ab[0][1] ,
         \CARRYB[3][7] , \CARRYB[3][6] , \CARRYB[3][5] , \CARRYB[3][4] ,
         \CARRYB[3][3] , \CARRYB[3][2] , \CARRYB[3][1] , \CARRYB[3][0] ,
         \CARRYB[2][6] , \CARRYB[2][5] , \CARRYB[2][4] , \CARRYB[2][3] ,
         \CARRYB[2][2] , \CARRYB[2][1] , \CARRYB[2][0] , \CARRYB[1][6] ,
         \CARRYB[1][5] , \CARRYB[1][4] , \CARRYB[1][3] , \CARRYB[1][2] ,
         \CARRYB[1][1] , \CARRYB[1][0] , \SUMB[3][7] , \SUMB[3][6] ,
         \SUMB[3][5] , \SUMB[3][4] , \SUMB[3][3] , \SUMB[3][2] , \SUMB[3][1] ,
         \SUMB[3][0] , \SUMB[2][6] , \SUMB[2][5] , \SUMB[2][4] , \SUMB[2][3] ,
         \SUMB[2][2] , \SUMB[2][1] , \SUMB[1][6] , \SUMB[1][5] , \SUMB[1][4] ,
         \SUMB[1][3] , \SUMB[1][2] , \SUMB[1][1] , ZA, ZB, \A1[8] , \A1[7] ,
         \A1[6] , \A1[5] , \A1[4] , \A1[3] , \A1[2] , \A1[1] , \A1[0] ,
         \A2[9] , \A2[8] , \A2[7] , \A2[6] , \A2[5] , \A2[4] , \A2[3] ,
         \A2[2] , n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15,
         n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29,
         n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43,
         n44, n45;
  assign ZA = A[3];
  assign ZB = B[7];

  ADDF_F S4_1 ( .A(\ab[3][1] ), .B(\CARRYB[2][1] ), .CIN(\SUMB[2][2] ), .COUT(
        \CARRYB[3][1] ), .SUM(\SUMB[3][1] ) );
  ADDF_F S4_2 ( .A(\ab[3][2] ), .B(\CARRYB[2][2] ), .CIN(\SUMB[2][3] ), .COUT(
        \CARRYB[3][2] ), .SUM(\SUMB[3][2] ) );
  ADDF_F S4_3 ( .A(\ab[3][3] ), .B(\CARRYB[2][3] ), .CIN(\SUMB[2][4] ), .COUT(
        \CARRYB[3][3] ), .SUM(\SUMB[3][3] ) );
  ADDF_F S4_5 ( .A(\ab[3][5] ), .B(\CARRYB[2][5] ), .CIN(\SUMB[2][6] ), .COUT(
        \CARRYB[3][5] ), .SUM(\SUMB[3][5] ) );
  ADDF_F S5_6 ( .A(\ab[3][6] ), .B(\CARRYB[2][6] ), .CIN(\ab[2][7] ), .COUT(
        \CARRYB[3][6] ), .SUM(\SUMB[3][6] ) );
  ADDF_F S14_7 ( .A(n11), .B(n34), .CIN(n3), .COUT(\CARRYB[3][7] ), .SUM(
        \SUMB[3][7] ) );
  ADDF_F S2_2_2 ( .A(\ab[2][2] ), .B(n17), .CIN(\SUMB[1][3] ), .COUT(
        \CARRYB[2][2] ), .SUM(\SUMB[2][2] ) );
  dsp_slice_DW01_add_1 FS_1 ( .A({n33, \A1[8] , \A1[7] , n26, \A1[5] , \A1[4] , 
        \A1[3] , \A1[2] , \A1[1] , \A1[0] }), .B({\A2[9] , \A2[8] , n31, 
        \A2[6] , n30, n32, n28, \A2[2] , 1'b0, 1'b0}), .CI(1'b0), .SUM(
        PRODUCT[11:2]) );
  ADDF_B S3_2_6 ( .A(\ab[2][6] ), .B(n9), .CIN(\ab[1][7] ), .COUT(
        \CARRYB[2][6] ), .SUM(\SUMB[2][6] ) );
  ADDF_B S1_2_0 ( .A(\ab[2][0] ), .B(n7), .CIN(\SUMB[1][1] ), .COUT(
        \CARRYB[2][0] ), .SUM(\A1[0] ) );
  ADDF_E S4_4 ( .A(\CARRYB[2][4] ), .B(\ab[3][4] ), .CIN(\SUMB[2][5] ), .COUT(
        \CARRYB[3][4] ), .SUM(\SUMB[3][4] ) );
  ADDF_F S14_7_0 ( .A(ZB), .B(\CARRYB[3][3] ), .CIN(\SUMB[3][4] ), .COUT(
        \A2[6] ), .SUM(\A1[5] ) );
  ADDF_B S2_2_5 ( .A(\ab[2][5] ), .B(n29), .CIN(\SUMB[1][6] ), .COUT(
        \CARRYB[2][5] ), .SUM(\SUMB[2][5] ) );
  ADDF_E S4_0 ( .A(n18), .B(\CARRYB[2][0] ), .CIN(\SUMB[2][1] ), .COUT(
        \CARRYB[3][0] ), .SUM(\SUMB[3][0] ) );
  ADDF_B S2_2_4 ( .A(\ab[2][4] ), .B(n27), .CIN(\SUMB[1][5] ), .COUT(
        \CARRYB[2][4] ), .SUM(\SUMB[2][4] ) );
  ADDF_B S2_2_1 ( .A(\ab[2][1] ), .B(n5), .CIN(\SUMB[1][2] ), .COUT(
        \CARRYB[2][1] ), .SUM(\SUMB[2][1] ) );
  ADDF_B S2_2_3 ( .A(\ab[2][3] ), .B(n13), .CIN(\SUMB[1][4] ), .COUT(
        \CARRYB[2][3] ), .SUM(\SUMB[2][3] ) );
  INVERT_E U2 ( .A(A[0]), .Z(n45) );
  INVERT_H U3 ( .A(n25), .Z(n26) );
  INVERT_N U4 ( .A(n10), .Z(n11) );
  INVERT_I U5 ( .A(n42), .Z(n10) );
  INVERT_K U6 ( .A(ZB), .Z(n34) );
  INVERT_H U7 ( .A(A[2]), .Z(n43) );
  INVERT_H U8 ( .A(ZA), .Z(n42) );
  NOR2_D U9 ( .A(B[5]), .B(n11), .Z(\ab[3][5] ) );
  NOR2_D U10 ( .A(n34), .B(n11), .Z(n3) );
  NOR2_C U11 ( .A(n22), .B(n40), .Z(\ab[2][1] ) );
  NOR2_C U12 ( .A(n22), .B(n41), .Z(\ab[2][0] ) );
  NOR2_C U13 ( .A(n22), .B(n37), .Z(\ab[2][4] ) );
  NOR2_C U14 ( .A(n22), .B(n36), .Z(\ab[2][5] ) );
  INVERT_L U15 ( .A(n21), .Z(n22) );
  NOR2_C U16 ( .A(n22), .B(n35), .Z(\ab[2][6] ) );
  NOR2_C U17 ( .A(n22), .B(n38), .Z(\ab[2][3] ) );
  AND2_H U18 ( .A(\SUMB[3][0] ), .B(ZA), .Z(\A2[2] ) );
  NOR2_D U19 ( .A(B[6]), .B(n11), .Z(\ab[3][6] ) );
  NOR2_D U20 ( .A(B[4]), .B(n11), .Z(\ab[3][4] ) );
  OR2_J U21 ( .A(B[0]), .B(n11), .Z(\ab[3][0] ) );
  INVERT_D U22 ( .A(\CARRYB[1][1] ), .Z(n4) );
  INVERT_E U23 ( .A(n4), .Z(n5) );
  INVERT_D U24 ( .A(\CARRYB[1][0] ), .Z(n6) );
  INVERT_E U25 ( .A(n6), .Z(n7) );
  INVERT_D U26 ( .A(\CARRYB[1][6] ), .Z(n8) );
  INVERT_E U27 ( .A(n8), .Z(n9) );
  INVERT_I U28 ( .A(\A2[7] ), .Z(n31) );
  AND2_H U29 ( .A(\ab[1][4] ), .B(\ab[0][5] ), .Z(\CARRYB[1][4] ) );
  AND2_H U30 ( .A(\ab[1][5] ), .B(\ab[0][6] ), .Z(\CARRYB[1][5] ) );
  INVERT_D U31 ( .A(\CARRYB[1][3] ), .Z(n12) );
  INVERT_E U32 ( .A(n12), .Z(n13) );
  AND2_H U33 ( .A(\ab[1][3] ), .B(\ab[0][4] ), .Z(\CARRYB[1][3] ) );
  INVERT_I U34 ( .A(B[1]), .Z(n40) );
  INVERT_H U35 ( .A(n23), .Z(n14) );
  INVERT_I U36 ( .A(n14), .Z(n15) );
  INVERT_D U37 ( .A(\CARRYB[1][2] ), .Z(n16) );
  INVERT_E U38 ( .A(n16), .Z(n17) );
  AND2_H U39 ( .A(\ab[1][2] ), .B(\ab[0][3] ), .Z(\CARRYB[1][2] ) );
  INVERT_E U40 ( .A(\ab[3][0] ), .Z(n18) );
  NOR2_D U41 ( .A(B[3]), .B(n11), .Z(\ab[3][3] ) );
  NOR2_D U42 ( .A(B[2]), .B(n11), .Z(\ab[3][2] ) );
  NOR2_D U43 ( .A(B[1]), .B(n11), .Z(\ab[3][1] ) );
  NOR2_D U44 ( .A(n41), .B(n24), .Z(PRODUCT[0]) );
  INVERT_I U45 ( .A(B[0]), .Z(n41) );
  INVERT_E U46 ( .A(\ab[0][7] ), .Z(n19) );
  INVERT_H U47 ( .A(n19), .Z(n20) );
  NOR2_E U48 ( .A(n35), .B(n44), .Z(\ab[1][6] ) );
  INVERT_I U49 ( .A(B[6]), .Z(n35) );
  INVERT_I U50 ( .A(B[3]), .Z(n38) );
  NOR2_E U51 ( .A(n38), .B(n24), .Z(\ab[0][3] ) );
  NOR2_E U52 ( .A(n35), .B(n24), .Z(\ab[0][6] ) );
  NOR2_E U53 ( .A(n40), .B(n24), .Z(\ab[0][1] ) );
  INVERT_M U54 ( .A(n15), .Z(n24) );
  NOR2_E U55 ( .A(n37), .B(n24), .Z(\ab[0][4] ) );
  INVERT_I U56 ( .A(B[4]), .Z(n37) );
  NOR2_D U57 ( .A(n22), .B(n39), .Z(\ab[2][2] ) );
  NOR2_E U58 ( .A(n39), .B(n24), .Z(\ab[0][2] ) );
  INVERT_I U59 ( .A(B[2]), .Z(n39) );
  NOR2_E U60 ( .A(n36), .B(n24), .Z(\ab[0][5] ) );
  INVERT_I U61 ( .A(B[5]), .Z(n36) );
  INVERT_H U62 ( .A(n43), .Z(n21) );
  INVERT_H U63 ( .A(n45), .Z(n23) );
  NOR2_E U64 ( .A(n39), .B(n44), .Z(\ab[1][2] ) );
  NOR2_E U65 ( .A(n38), .B(n44), .Z(\ab[1][3] ) );
  NOR2_E U66 ( .A(n40), .B(n44), .Z(\ab[1][1] ) );
  NOR2_E U67 ( .A(n37), .B(n44), .Z(\ab[1][4] ) );
  NOR2_E U68 ( .A(n36), .B(n44), .Z(\ab[1][5] ) );
  NOR2_E U69 ( .A(n41), .B(n44), .Z(\ab[1][0] ) );
  INVERT_M U70 ( .A(A[1]), .Z(n44) );
  INVERT_H U71 ( .A(\A1[6] ), .Z(n25) );
  AND2_H U72 ( .A(\ab[1][1] ), .B(\ab[0][2] ), .Z(\CARRYB[1][1] ) );
  XOR2_D U73 ( .A(\SUMB[3][6] ), .B(\CARRYB[3][5] ), .Z(\A1[7] ) );
  XOR2_D U74 ( .A(\SUMB[3][2] ), .B(\CARRYB[3][1] ), .Z(\A1[3] ) );
  BUFFER_H U75 ( .A(\CARRYB[1][4] ), .Z(n27) );
  AND2_H U76 ( .A(\SUMB[3][7] ), .B(\CARRYB[3][6] ), .Z(\A2[9] ) );
  XOR2_D U77 ( .A(\SUMB[3][3] ), .B(\CARRYB[3][2] ), .Z(\A1[4] ) );
  NAND2_E U78 ( .A(\SUMB[3][1] ), .B(\CARRYB[3][0] ), .Z(\A2[3] ) );
  INVERT_I U79 ( .A(\A2[3] ), .Z(n28) );
  BUFFER_H U80 ( .A(\CARRYB[1][5] ), .Z(n29) );
  NAND2BAL_E U81 ( .A(\SUMB[3][3] ), .B(\CARRYB[3][2] ), .Z(\A2[5] ) );
  INVERT_I U82 ( .A(\A2[5] ), .Z(n30) );
  NAND2_E U83 ( .A(\SUMB[3][5] ), .B(\CARRYB[3][4] ), .Z(\A2[7] ) );
  NOR2_D U84 ( .A(A[2]), .B(n34), .Z(\ab[2][7] ) );
  AND2_H U85 ( .A(\ab[1][0] ), .B(\ab[0][1] ), .Z(\CARRYB[1][0] ) );
  NAND2BAL_E U86 ( .A(\SUMB[3][2] ), .B(\CARRYB[3][1] ), .Z(\A2[4] ) );
  INVERT_I U87 ( .A(\A2[4] ), .Z(n32) );
  XOR2_D U88 ( .A(\SUMB[3][7] ), .B(\CARRYB[3][6] ), .Z(\A1[8] ) );
  AND2_J U89 ( .A(\SUMB[3][6] ), .B(\CARRYB[3][5] ), .Z(\A2[8] ) );
  NOR2_C U90 ( .A(A[1]), .B(n34), .Z(\ab[1][7] ) );
  AND2_H U91 ( .A(\ab[1][6] ), .B(n20), .Z(\CARRYB[1][6] ) );
  NOR2_C U92 ( .A(A[0]), .B(n34), .Z(\ab[0][7] ) );
  XOR2_C U93 ( .A(\SUMB[3][0] ), .B(ZA), .Z(\A1[1] ) );
  XOR2_C U94 ( .A(\SUMB[3][1] ), .B(\CARRYB[3][0] ), .Z(\A1[2] ) );
  XOR2_C U95 ( .A(\SUMB[3][5] ), .B(\CARRYB[3][4] ), .Z(\A1[6] ) );
  XOR2_C U96 ( .A(\ab[0][1] ), .B(\ab[1][0] ), .Z(PRODUCT[1]) );
  XOR2_C U97 ( .A(\ab[0][2] ), .B(\ab[1][1] ), .Z(\SUMB[1][1] ) );
  XOR2_C U98 ( .A(\ab[0][3] ), .B(\ab[1][2] ), .Z(\SUMB[1][2] ) );
  XOR2_C U99 ( .A(\ab[0][4] ), .B(\ab[1][3] ), .Z(\SUMB[1][3] ) );
  XOR2_C U100 ( .A(\ab[0][5] ), .B(\ab[1][4] ), .Z(\SUMB[1][4] ) );
  XOR2_C U101 ( .A(\ab[0][6] ), .B(\ab[1][5] ), .Z(\SUMB[1][5] ) );
  XOR2_C U102 ( .A(n20), .B(\ab[1][6] ), .Z(\SUMB[1][6] ) );
  INVERT_D U103 ( .A(\CARRYB[3][7] ), .Z(n33) );
endmodule


module dsp_slice ( clk, sample_in, accum_in, coeff_in, sample_out, accum_out
 );
  input [3:0] sample_in;
  input [11:0] accum_in;
  input [7:0] coeff_in;
  output [3:0] sample_out;
  output [11:0] accum_out;
  input clk;
  wire   N0, N1, N2, N3, N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15,
         N16, N17, N18, N19, N20, N21, N22, N23, n2, n3, n4, n5, n6, n7, n8,
         n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22,
         n24, n25, n26, n27, n29, n30, n31, n32, n34, n35, n36, n38, n39, n40,
         n41, n42, n44, n45, n46, n48, n49, n50, n52, n53, n54, n56, n57, n58,
         n60, n61, n62, n64, n65, n66, n68, n69, n70, n72, n73, n74, n76, n77,
         n78, n80, n81, n82, n84, n85, n86, n88, n89;
  wire   [3:0] sample_delay0;
  wire   [11:0] mult_out;

  DFF_K \mult_out_reg[6]  ( .D(N6), .CLK(clk), .Q(mult_out[6]) );
  DFF_K \mult_out_reg[4]  ( .D(N4), .CLK(clk), .Q(mult_out[4]) );
  dsp_slice_DW01_add_0 add_33 ( .A({accum_in[11:1], n20}), .B({mult_out[11:1], 
        n21}), .CI(1'b0), .SUM({N23, N22, N21, N20, N19, N18, N17, N16, N15, 
        N14, N13, N12}) );
  dsp_slice_DW02_mult_0 mult_32 ( .A({n42, n32, n38, n27}), .B({n18, n16, n14, 
        n12, n10, n8, n6, n4}), .TC(1'b1), .PRODUCT({N11, N10, N9, N8, N7, N6, 
        N5, N4, N3, N2, N1, N0}) );
  DFF_E \mult_out_reg[3]  ( .D(N3), .CLK(clk), .Q(mult_out[3]) );
  DFF_E \mult_out_reg[2]  ( .D(N2), .CLK(clk), .Q(mult_out[2]) );
  DFF_E \mult_out_reg[1]  ( .D(N1), .CLK(clk), .Q(mult_out[1]) );
  DFF_E \sample_delay0_reg[3]  ( .D(sample_in[3]), .CLK(clk), .Q(
        sample_delay0[3]) );
  DFF_E \sample_delay0_reg[2]  ( .D(sample_in[2]), .CLK(clk), .Q(
        sample_delay0[2]) );
  DFF_E \sample_delay0_reg[1]  ( .D(sample_in[1]), .CLK(clk), .Q(
        sample_delay0[1]) );
  DFF_E \sample_delay0_reg[0]  ( .D(sample_in[0]), .CLK(clk), .Q(
        sample_delay0[0]) );
  DFF_E \accum_reg[1]  ( .D(N13), .CLK(clk), .QBAR(n88) );
  DFF_E \accum_reg[2]  ( .D(N14), .CLK(clk), .QBAR(n84) );
  DFF_E \accum_reg[3]  ( .D(N15), .CLK(clk), .QBAR(n80) );
  DFF_E \accum_reg[4]  ( .D(N16), .CLK(clk), .QBAR(n76) );
  DFF_E \accum_reg[5]  ( .D(N17), .CLK(clk), .QBAR(n72) );
  DFF_E \accum_reg[6]  ( .D(N18), .CLK(clk), .QBAR(n68) );
  DFF_E \accum_reg[7]  ( .D(N19), .CLK(clk), .QBAR(n64) );
  DFF_E \accum_reg[8]  ( .D(N20), .CLK(clk), .QBAR(n60) );
  DFF_E \accum_reg[9]  ( .D(N21), .CLK(clk), .QBAR(n56) );
  DFF_E \accum_reg[10]  ( .D(N22), .CLK(clk), .QBAR(n52) );
  DFF_E \accum_reg[11]  ( .D(N23), .CLK(clk), .QBAR(n48) );
  DFF_E \mult_out_reg[5]  ( .D(N5), .CLK(clk), .Q(mult_out[5]) );
  DFF_E \sample_delay1_reg[3]  ( .D(sample_delay0[3]), .CLK(clk), .QBAR(n44)
         );
  DFF_E \sample_delay1_reg[1]  ( .D(sample_delay0[1]), .CLK(clk), .QBAR(n39)
         );
  DFF_E \sample_delay1_reg[2]  ( .D(sample_delay0[2]), .CLK(clk), .QBAR(n34)
         );
  DFF_E \sample_delay1_reg[0]  ( .D(sample_delay0[0]), .CLK(clk), .QBAR(n29)
         );
  DFF_E \accum_reg[0]  ( .D(N12), .CLK(clk), .QBAR(n24) );
  DFF_E \mult_out_reg[0]  ( .D(N0), .CLK(clk), .QBAR(n2) );
  DFF_E \mult_out_reg[7]  ( .D(N7), .CLK(clk), .Q(mult_out[7]) );
  DFF_E \mult_out_reg[11]  ( .D(N11), .CLK(clk), .Q(mult_out[11]) );
  DFF_E \mult_out_reg[10]  ( .D(N10), .CLK(clk), .Q(mult_out[10]) );
  DFF_E \mult_out_reg[9]  ( .D(N9), .CLK(clk), .Q(mult_out[9]) );
  DFF_E \mult_out_reg[8]  ( .D(N8), .CLK(clk), .Q(mult_out[8]) );
  INVERT_I U4 ( .A(n9), .Z(n10) );
  INVERT_H U5 ( .A(coeff_in[3]), .Z(n9) );
  INVERT_I U6 ( .A(n11), .Z(n12) );
  INVERT_H U7 ( .A(coeff_in[4]), .Z(n11) );
  INVERT_I U8 ( .A(n7), .Z(n8) );
  INVERT_H U9 ( .A(coeff_in[2]), .Z(n7) );
  INVERT_I U10 ( .A(n5), .Z(n6) );
  INVERT_H U11 ( .A(coeff_in[1]), .Z(n5) );
  INVERT_I U12 ( .A(n13), .Z(n14) );
  INVERT_H U13 ( .A(coeff_in[5]), .Z(n13) );
  INVERT_H U14 ( .A(coeff_in[7]), .Z(n17) );
  INVERT_I U15 ( .A(n15), .Z(n16) );
  INVERT_H U16 ( .A(coeff_in[6]), .Z(n15) );
  INVERT_H U17 ( .A(accum_in[0]), .Z(n19) );
  INVERT_J U18 ( .A(n25), .Z(n22) );
  INVERT_J U19 ( .A(n89), .Z(n86) );
  INVERT_J U20 ( .A(n85), .Z(n82) );
  INVERT_J U21 ( .A(n81), .Z(n78) );
  INVERT_J U22 ( .A(n77), .Z(n74) );
  INVERT_J U23 ( .A(n73), .Z(n70) );
  INVERT_J U24 ( .A(n69), .Z(n66) );
  INVERT_J U25 ( .A(n65), .Z(n62) );
  INVERT_J U26 ( .A(n61), .Z(n58) );
  INVERT_J U27 ( .A(n57), .Z(n54) );
  INVERT_J U28 ( .A(n53), .Z(n50) );
  INVERT_J U29 ( .A(n49), .Z(n46) );
  INVERT_H U30 ( .A(coeff_in[0]), .Z(n3) );
  INVERT_I U31 ( .A(n3), .Z(n4) );
  INVERT_I U32 ( .A(n17), .Z(n18) );
  INVERT_H U33 ( .A(n19), .Z(n20) );
  INVERT_H U34 ( .A(n2), .Z(n21) );
  INVERT_O U35 ( .A(n22), .Z(accum_out[0]) );
  INVERT_H U36 ( .A(n24), .Z(n25) );
  INVERT_K U37 ( .A(n30), .Z(n26) );
  INVERT_F U38 ( .A(n26), .Z(n27) );
  INVERT_O U39 ( .A(n26), .Z(sample_out[0]) );
  INVERT_H U40 ( .A(n29), .Z(n30) );
  INVERT_K U41 ( .A(n35), .Z(n31) );
  INVERT_H U42 ( .A(n31), .Z(n32) );
  INVERT_O U43 ( .A(n31), .Z(sample_out[2]) );
  INVERT_H U44 ( .A(n34), .Z(n35) );
  INVERT_K U45 ( .A(n40), .Z(n36) );
  INVERT_O U46 ( .A(n36), .Z(sample_out[1]) );
  INVERT_I U47 ( .A(n36), .Z(n38) );
  INVERT_H U48 ( .A(n39), .Z(n40) );
  INVERT_K U49 ( .A(n45), .Z(n41) );
  INVERT_I U50 ( .A(n41), .Z(n42) );
  INVERT_O U51 ( .A(n41), .Z(sample_out[3]) );
  INVERT_H U52 ( .A(n44), .Z(n45) );
  INVERT_O U53 ( .A(n46), .Z(accum_out[11]) );
  INVERT_H U54 ( .A(n48), .Z(n49) );
  INVERT_O U55 ( .A(n50), .Z(accum_out[10]) );
  INVERT_H U56 ( .A(n52), .Z(n53) );
  INVERT_O U57 ( .A(n54), .Z(accum_out[9]) );
  INVERT_H U58 ( .A(n56), .Z(n57) );
  INVERT_O U59 ( .A(n58), .Z(accum_out[8]) );
  INVERT_H U60 ( .A(n60), .Z(n61) );
  INVERT_O U61 ( .A(n62), .Z(accum_out[7]) );
  INVERT_H U62 ( .A(n64), .Z(n65) );
  INVERT_O U63 ( .A(n66), .Z(accum_out[6]) );
  INVERT_H U64 ( .A(n68), .Z(n69) );
  INVERT_O U65 ( .A(n70), .Z(accum_out[5]) );
  INVERT_H U66 ( .A(n72), .Z(n73) );
  INVERT_O U67 ( .A(n74), .Z(accum_out[4]) );
  INVERT_H U68 ( .A(n76), .Z(n77) );
  INVERT_O U69 ( .A(n78), .Z(accum_out[3]) );
  INVERT_H U70 ( .A(n80), .Z(n81) );
  INVERT_O U71 ( .A(n82), .Z(accum_out[2]) );
  INVERT_H U72 ( .A(n84), .Z(n85) );
  INVERT_O U73 ( .A(n86), .Z(accum_out[1]) );
  INVERT_H U74 ( .A(n88), .Z(n89) );
endmodule

