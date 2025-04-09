/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Thu Feb 20 19:08:56 2025
/////////////////////////////////////////////////////////////


module booth_mult_ver_syn_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [31:0] A;
  input [31:0] B;
  output [31:0] DIFF;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33;
  wire   [32:0] carry;

  ADDF_B U2_30 ( .A(A[30]), .B(n3), .CIN(carry[30]), .COUT(carry[31]), .SUM(
        DIFF[30]) );
  ADDF_B U2_29 ( .A(A[29]), .B(n4), .CIN(carry[29]), .COUT(carry[30]), .SUM(
        DIFF[29]) );
  ADDF_B U2_28 ( .A(A[28]), .B(n5), .CIN(carry[28]), .COUT(carry[29]), .SUM(
        DIFF[28]) );
  ADDF_B U2_27 ( .A(A[27]), .B(n6), .CIN(carry[27]), .COUT(carry[28]), .SUM(
        DIFF[27]) );
  ADDF_B U2_26 ( .A(A[26]), .B(n7), .CIN(carry[26]), .COUT(carry[27]), .SUM(
        DIFF[26]) );
  ADDF_B U2_25 ( .A(A[25]), .B(n8), .CIN(carry[25]), .COUT(carry[26]), .SUM(
        DIFF[25]) );
  ADDF_B U2_24 ( .A(A[24]), .B(n9), .CIN(carry[24]), .COUT(carry[25]), .SUM(
        DIFF[24]) );
  ADDF_B U2_23 ( .A(A[23]), .B(n10), .CIN(carry[23]), .COUT(carry[24]), .SUM(
        DIFF[23]) );
  ADDF_B U2_22 ( .A(A[22]), .B(n11), .CIN(carry[22]), .COUT(carry[23]), .SUM(
        DIFF[22]) );
  ADDF_B U2_21 ( .A(A[21]), .B(n12), .CIN(carry[21]), .COUT(carry[22]), .SUM(
        DIFF[21]) );
  ADDF_B U2_20 ( .A(A[20]), .B(n13), .CIN(carry[20]), .COUT(carry[21]), .SUM(
        DIFF[20]) );
  ADDF_B U2_19 ( .A(A[19]), .B(n14), .CIN(carry[19]), .COUT(carry[20]), .SUM(
        DIFF[19]) );
  ADDF_B U2_18 ( .A(A[18]), .B(n15), .CIN(carry[18]), .COUT(carry[19]), .SUM(
        DIFF[18]) );
  ADDF_B U2_17 ( .A(A[17]), .B(n16), .CIN(carry[17]), .COUT(carry[18]), .SUM(
        DIFF[17]) );
  ADDF_B U2_16 ( .A(A[16]), .B(n17), .CIN(carry[16]), .COUT(carry[17]), .SUM(
        DIFF[16]) );
  ADDF_B U2_15 ( .A(A[15]), .B(n18), .CIN(carry[15]), .COUT(carry[16]), .SUM(
        DIFF[15]) );
  ADDF_B U2_14 ( .A(A[14]), .B(n19), .CIN(carry[14]), .COUT(carry[15]), .SUM(
        DIFF[14]) );
  ADDF_B U2_13 ( .A(A[13]), .B(n20), .CIN(carry[13]), .COUT(carry[14]), .SUM(
        DIFF[13]) );
  ADDF_B U2_12 ( .A(A[12]), .B(n21), .CIN(carry[12]), .COUT(carry[13]), .SUM(
        DIFF[12]) );
  ADDF_B U2_11 ( .A(A[11]), .B(n22), .CIN(carry[11]), .COUT(carry[12]), .SUM(
        DIFF[11]) );
  ADDF_B U2_10 ( .A(A[10]), .B(n23), .CIN(carry[10]), .COUT(carry[11]), .SUM(
        DIFF[10]) );
  ADDF_B U2_9 ( .A(A[9]), .B(n24), .CIN(carry[9]), .COUT(carry[10]), .SUM(
        DIFF[9]) );
  ADDF_B U2_8 ( .A(A[8]), .B(n25), .CIN(carry[8]), .COUT(carry[9]), .SUM(
        DIFF[8]) );
  ADDF_B U2_7 ( .A(A[7]), .B(n26), .CIN(carry[7]), .COUT(carry[8]), .SUM(
        DIFF[7]) );
  ADDF_B U2_6 ( .A(A[6]), .B(n27), .CIN(carry[6]), .COUT(carry[7]), .SUM(
        DIFF[6]) );
  ADDF_B U2_5 ( .A(A[5]), .B(n28), .CIN(carry[5]), .COUT(carry[6]), .SUM(
        DIFF[5]) );
  ADDF_B U2_4 ( .A(A[4]), .B(n29), .CIN(carry[4]), .COUT(carry[5]), .SUM(
        DIFF[4]) );
  ADDF_B U2_3 ( .A(A[3]), .B(n30), .CIN(carry[3]), .COUT(carry[4]), .SUM(
        DIFF[3]) );
  ADDF_B U2_2 ( .A(A[2]), .B(n31), .CIN(carry[2]), .COUT(carry[3]), .SUM(
        DIFF[2]) );
  ADDF_B U2_1 ( .A(A[1]), .B(n32), .CIN(n1), .COUT(carry[2]), .SUM(DIFF[1]) );
  XOR3_D U2_31 ( .A(A[31]), .B(n2), .C(carry[31]), .Z(DIFF[31]) );
  INVERT_H U1 ( .A(carry[1]), .Z(n1) );
  INVERT_H U2 ( .A(B[0]), .Z(n33) );
  NOR2_D U3 ( .A(n33), .B(A[0]), .Z(carry[1]) );
  INVERT_E U4 ( .A(B[1]), .Z(n32) );
  XNOR2_C U5 ( .A(A[0]), .B(n33), .Z(DIFF[0]) );
  INVERT_D U6 ( .A(B[31]), .Z(n2) );
  INVERT_D U7 ( .A(B[30]), .Z(n3) );
  INVERT_D U8 ( .A(B[29]), .Z(n4) );
  INVERT_D U9 ( .A(B[28]), .Z(n5) );
  INVERT_D U10 ( .A(B[27]), .Z(n6) );
  INVERT_D U11 ( .A(B[26]), .Z(n7) );
  INVERT_D U12 ( .A(B[25]), .Z(n8) );
  INVERT_D U13 ( .A(B[24]), .Z(n9) );
  INVERT_D U14 ( .A(B[23]), .Z(n10) );
  INVERT_D U15 ( .A(B[22]), .Z(n11) );
  INVERT_D U16 ( .A(B[21]), .Z(n12) );
  INVERT_D U17 ( .A(B[20]), .Z(n13) );
  INVERT_D U18 ( .A(B[19]), .Z(n14) );
  INVERT_D U19 ( .A(B[18]), .Z(n15) );
  INVERT_D U20 ( .A(B[17]), .Z(n16) );
  INVERT_D U21 ( .A(B[16]), .Z(n17) );
  INVERT_D U22 ( .A(B[15]), .Z(n18) );
  INVERT_D U23 ( .A(B[14]), .Z(n19) );
  INVERT_D U24 ( .A(B[13]), .Z(n20) );
  INVERT_D U25 ( .A(B[12]), .Z(n21) );
  INVERT_D U26 ( .A(B[11]), .Z(n22) );
  INVERT_D U27 ( .A(B[10]), .Z(n23) );
  INVERT_D U28 ( .A(B[9]), .Z(n24) );
  INVERT_D U29 ( .A(B[8]), .Z(n25) );
  INVERT_D U30 ( .A(B[7]), .Z(n26) );
  INVERT_D U31 ( .A(B[6]), .Z(n27) );
  INVERT_D U32 ( .A(B[5]), .Z(n28) );
  INVERT_D U33 ( .A(B[4]), .Z(n29) );
  INVERT_D U34 ( .A(B[3]), .Z(n30) );
  INVERT_D U35 ( .A(B[2]), .Z(n31) );
endmodule


module booth_mult_ver_syn_DW01_add_0 ( A, B, CI, SUM, CO );
  input [31:0] A;
  input [31:0] B;
  output [31:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [31:1] carry;

  ADDF_B U1_30 ( .A(A[30]), .B(B[30]), .CIN(carry[30]), .COUT(carry[31]), 
        .SUM(SUM[30]) );
  ADDF_B U1_29 ( .A(A[29]), .B(B[29]), .CIN(carry[29]), .COUT(carry[30]), 
        .SUM(SUM[29]) );
  ADDF_B U1_28 ( .A(A[28]), .B(B[28]), .CIN(carry[28]), .COUT(carry[29]), 
        .SUM(SUM[28]) );
  ADDF_B U1_27 ( .A(A[27]), .B(B[27]), .CIN(carry[27]), .COUT(carry[28]), 
        .SUM(SUM[27]) );
  ADDF_B U1_26 ( .A(A[26]), .B(B[26]), .CIN(carry[26]), .COUT(carry[27]), 
        .SUM(SUM[26]) );
  ADDF_B U1_25 ( .A(A[25]), .B(B[25]), .CIN(carry[25]), .COUT(carry[26]), 
        .SUM(SUM[25]) );
  ADDF_B U1_24 ( .A(A[24]), .B(B[24]), .CIN(carry[24]), .COUT(carry[25]), 
        .SUM(SUM[24]) );
  ADDF_B U1_23 ( .A(A[23]), .B(B[23]), .CIN(carry[23]), .COUT(carry[24]), 
        .SUM(SUM[23]) );
  ADDF_B U1_22 ( .A(A[22]), .B(B[22]), .CIN(carry[22]), .COUT(carry[23]), 
        .SUM(SUM[22]) );
  ADDF_B U1_21 ( .A(A[21]), .B(B[21]), .CIN(carry[21]), .COUT(carry[22]), 
        .SUM(SUM[21]) );
  ADDF_B U1_20 ( .A(A[20]), .B(B[20]), .CIN(carry[20]), .COUT(carry[21]), 
        .SUM(SUM[20]) );
  ADDF_B U1_19 ( .A(A[19]), .B(B[19]), .CIN(carry[19]), .COUT(carry[20]), 
        .SUM(SUM[19]) );
  ADDF_B U1_18 ( .A(A[18]), .B(B[18]), .CIN(carry[18]), .COUT(carry[19]), 
        .SUM(SUM[18]) );
  ADDF_B U1_17 ( .A(A[17]), .B(B[17]), .CIN(carry[17]), .COUT(carry[18]), 
        .SUM(SUM[17]) );
  ADDF_B U1_16 ( .A(A[16]), .B(B[16]), .CIN(carry[16]), .COUT(carry[17]), 
        .SUM(SUM[16]) );
  ADDF_B U1_15 ( .A(A[15]), .B(B[15]), .CIN(carry[15]), .COUT(carry[16]), 
        .SUM(SUM[15]) );
  ADDF_B U1_14 ( .A(A[14]), .B(B[14]), .CIN(carry[14]), .COUT(carry[15]), 
        .SUM(SUM[14]) );
  ADDF_B U1_13 ( .A(A[13]), .B(B[13]), .CIN(carry[13]), .COUT(carry[14]), 
        .SUM(SUM[13]) );
  ADDF_B U1_12 ( .A(A[12]), .B(B[12]), .CIN(carry[12]), .COUT(carry[13]), 
        .SUM(SUM[12]) );
  ADDF_B U1_11 ( .A(A[11]), .B(B[11]), .CIN(carry[11]), .COUT(carry[12]), 
        .SUM(SUM[11]) );
  ADDF_B U1_10 ( .A(A[10]), .B(B[10]), .CIN(carry[10]), .COUT(carry[11]), 
        .SUM(SUM[10]) );
  ADDF_B U1_9 ( .A(A[9]), .B(B[9]), .CIN(carry[9]), .COUT(carry[10]), .SUM(
        SUM[9]) );
  ADDF_B U1_8 ( .A(A[8]), .B(B[8]), .CIN(carry[8]), .COUT(carry[9]), .SUM(
        SUM[8]) );
  ADDF_B U1_7 ( .A(A[7]), .B(B[7]), .CIN(carry[7]), .COUT(carry[8]), .SUM(
        SUM[7]) );
  ADDF_B U1_6 ( .A(A[6]), .B(B[6]), .CIN(carry[6]), .COUT(carry[7]), .SUM(
        SUM[6]) );
  ADDF_B U1_5 ( .A(A[5]), .B(B[5]), .CIN(carry[5]), .COUT(carry[6]), .SUM(
        SUM[5]) );
  ADDF_B U1_4 ( .A(A[4]), .B(B[4]), .CIN(carry[4]), .COUT(carry[5]), .SUM(
        SUM[4]) );
  ADDF_B U1_3 ( .A(A[3]), .B(B[3]), .CIN(carry[3]), .COUT(carry[4]), .SUM(
        SUM[3]) );
  ADDF_B U1_2 ( .A(A[2]), .B(B[2]), .CIN(carry[2]), .COUT(carry[3]), .SUM(
        SUM[2]) );
  ADDF_B U1_1 ( .A(A[1]), .B(B[1]), .CIN(n1), .COUT(carry[2]), .SUM(SUM[1]) );
  XOR3_D U1_31 ( .A(A[31]), .B(B[31]), .C(carry[31]), .Z(SUM[31]) );
  INVERT_D U1 ( .A(carry[1]), .Z(n1) );
  NAND2BAL_E U2 ( .A(A[0]), .B(B[0]), .Z(carry[1]) );
  XOR2_B U3 ( .A(A[0]), .B(B[0]), .Z(SUM[0]) );
endmodule


module booth_mult_ver_syn_syn ( clk, rst_n, a, b, c, ready );
  input [15:0] a;
  input [15:0] b;
  output [31:0] c;
  input clk, rst_n;
  output ready;
  wire   n511, n512, n513, n514, n515, n516, n517, n518, n519, n520, n521,
         n522, n523, n524, n525, n526, n527, n528, n529, n530, n531, n532,
         n533, n534, n535, n536, n537, n538, n539, n540, n541, n542,
         \state[1] , previous, \b_reg[0] , N19, N20, N21, N22, N23, N24, N25,
         N26, N27, N28, N29, N30, N31, N32, N33, N34, N35, N36, N37, N38, N39,
         N40, N41, N42, N43, N44, N45, N46, N47, N48, N49, N50, N51, N52, N53,
         N54, N55, N56, N57, N58, N59, N60, N61, N62, N63, N64, N65, N66, N67,
         N68, N69, N70, N71, N72, N73, N74, N75, N76, N77, N78, N79, N80, N81,
         N82, N122, N123, N125, N126, N127, N128, N129, N130, N131, N132, N133,
         N134, N135, N136, N137, N138, N139, N140, N141, N142, N143, N146,
         N147, N148, N149, N150, N151, N152, N153, N154, N155, N156, N157,
         N159, n9, n10, n14, n15, n16, n17, n20, n21, n162, n163, n164, n165,
         n166, n167, n168, n169, n170, n171, n172, n173, n174, n175, n176,
         n177, n178, n179, n180, n181, n182, n183, n184, n185, n186, n187,
         n188, n189, n190, n191, n192, n193, n194, n195, n196, n197, n198,
         n199, n200, n201, n202, n203, n204, n205, n206, n207, n208, n209,
         n210, n211, n212, n213, n214, n215, n216, n217, n218, n219, n220,
         n221, n222, n223, n224, n225, n226, n227, n228, n229, n230, n231,
         n232, n233, n234, n235, n236, n237, n238, n239, n240, n241, n242,
         n243, n244, n245, n246, n247, n248, n249, n250, n251, n252, n253,
         n254, n255, n256, n257, n258, n259, n260, n261, n262, n263, n264,
         n265, n266, n267, n268, n269, n270, n271, n272, n273, n274, n275,
         n276, n277, n278, n279, n280, n281, n282, n283, n284, n285, n286,
         n287, n288, n289, n291, n292, n293, n294, n295, n296, n297, n298,
         n299, n300, n301, n302, n303, n304, n305, n306, n307, n309, n311,
         n313, n315, n317, n319, n321, n323, n325, n327, n329, n331, n333,
         n335, n337, n339, n341, n343, n345, n347, n349, n351, n353, n355,
         n357, n359, n361, n363, n365, n367, n369, n371, n372, n373, n374,
         n375, n376, n377, n378, n379, n380, n381, n382, n383, n384, n385,
         n386, n387, n388, n389, n390, n391, n392, n393, n394, n395, n396,
         n397, n398, n399, n400, n401, n402, n403, n404, n405, n406, n407,
         n408, n409, n410, n411, n412, n413, n414, n415, n416, n417, n418,
         n419, n420, n421, n422, n423, n424, n425, n426, n427, n428, n429,
         n430, n431, n432, n433, n434, n435, n436, n437, n438, n439, n440,
         n441, n442, n443, n444, n445, n446, n447, n448, n449, n450, n451,
         n452, n453, n454, n455, n456, n457, n458, n459, n460, n461, n462,
         n463, n464, n465, n466, n467, n468, n469, n470, n471, n472, n473,
         n474, n475, n476, n477, n478, n479, n480, n481, n482, n483, n484,
         n485, n486, n487, n488, n489, n490, n491, n492, n493, n494, n495,
         n496, n497, n498, n499, n500, n501, n502, n503, n504, n505, n506,
         n507, n508, n509, n510;
  wire   [31:0] partial;
  wire   [31:0] partial_next;
  wire   [31:0] a_reg;

  LATSR_E ready_reg ( .CLK(n445), .D(n509), .RN(1'b1), .S(1'b0), .Q(n542) );
  LATSR_E \a_reg_reg[31]  ( .CLK(n443), .D(n182), .RN(1'b1), .S(1'b0), .Q(
        a_reg[31]) );
  LATSR_E \a_reg_reg[30]  ( .CLK(n441), .D(n182), .RN(1'b1), .S(1'b0), .Q(
        a_reg[30]) );
  LATSR_E \a_reg_reg[29]  ( .CLK(n441), .D(n182), .RN(1'b1), .S(1'b0), .Q(
        a_reg[29]) );
  LATSR_E \a_reg_reg[28]  ( .CLK(n441), .D(n182), .RN(1'b1), .S(1'b0), .Q(
        a_reg[28]) );
  LATSR_E \a_reg_reg[27]  ( .CLK(n441), .D(n182), .RN(1'b1), .S(1'b0), .Q(
        a_reg[27]) );
  LATSR_E \a_reg_reg[26]  ( .CLK(n441), .D(n182), .RN(1'b1), .S(1'b0), .Q(
        a_reg[26]) );
  LATSR_E \a_reg_reg[25]  ( .CLK(n441), .D(n182), .RN(1'b1), .S(1'b0), .Q(
        a_reg[25]) );
  LATSR_E \a_reg_reg[24]  ( .CLK(n442), .D(n182), .RN(1'b1), .S(1'b0), .Q(
        a_reg[24]) );
  LATSR_E \a_reg_reg[23]  ( .CLK(n442), .D(n182), .RN(1'b1), .S(1'b0), .Q(
        a_reg[23]) );
  LATSR_E \a_reg_reg[22]  ( .CLK(n442), .D(n183), .RN(1'b1), .S(1'b0), .Q(
        a_reg[22]) );
  LATSR_E \a_reg_reg[21]  ( .CLK(n442), .D(n183), .RN(1'b1), .S(1'b0), .Q(
        a_reg[21]) );
  LATSR_E \a_reg_reg[20]  ( .CLK(n442), .D(n183), .RN(1'b1), .S(1'b0), .Q(
        a_reg[20]) );
  LATSR_E \a_reg_reg[19]  ( .CLK(n442), .D(n183), .RN(1'b1), .S(1'b0), .Q(
        a_reg[19]) );
  LATSR_E \a_reg_reg[18]  ( .CLK(n442), .D(n183), .RN(1'b1), .S(1'b0), .Q(
        a_reg[18]) );
  LATSR_E \a_reg_reg[17]  ( .CLK(n443), .D(n183), .RN(1'b1), .S(1'b0), .Q(
        a_reg[17]) );
  LATSR_E \a_reg_reg[16]  ( .CLK(n443), .D(n183), .RN(1'b1), .S(1'b0), .Q(
        a_reg[16]) );
  LATSR_E \a_reg_reg[15]  ( .CLK(n443), .D(n183), .RN(1'b1), .S(1'b0), .Q(
        a_reg[15]) );
  LATSR_E \a_reg_reg[14]  ( .CLK(n443), .D(a[14]), .RN(1'b1), .S(1'b0), .Q(
        a_reg[14]) );
  LATSR_E \a_reg_reg[13]  ( .CLK(n443), .D(a[13]), .RN(1'b1), .S(1'b0), .Q(
        a_reg[13]) );
  LATSR_E \a_reg_reg[12]  ( .CLK(n443), .D(a[12]), .RN(1'b1), .S(1'b0), .Q(
        a_reg[12]) );
  LATSR_E \a_reg_reg[11]  ( .CLK(n444), .D(a[11]), .RN(1'b1), .S(1'b0), .Q(
        a_reg[11]) );
  LATSR_E \a_reg_reg[10]  ( .CLK(n444), .D(a[10]), .RN(1'b1), .S(1'b0), .Q(
        a_reg[10]) );
  LATSR_E \a_reg_reg[9]  ( .CLK(n444), .D(a[9]), .RN(1'b1), .S(1'b0), .Q(
        a_reg[9]) );
  LATSR_E \a_reg_reg[8]  ( .CLK(n444), .D(a[8]), .RN(1'b1), .S(1'b0), .Q(
        a_reg[8]) );
  LATSR_E \a_reg_reg[7]  ( .CLK(n444), .D(a[7]), .RN(1'b1), .S(1'b0), .Q(
        a_reg[7]) );
  LATSR_E \a_reg_reg[6]  ( .CLK(n444), .D(a[6]), .RN(1'b1), .S(1'b0), .Q(
        a_reg[6]) );
  LATSR_E \a_reg_reg[5]  ( .CLK(n444), .D(a[5]), .RN(1'b1), .S(1'b0), .Q(
        a_reg[5]) );
  LATSR_E \a_reg_reg[4]  ( .CLK(n445), .D(a[4]), .RN(1'b1), .S(1'b0), .Q(
        a_reg[4]) );
  LATSR_E \a_reg_reg[3]  ( .CLK(n445), .D(a[3]), .RN(1'b1), .S(1'b0), .Q(
        a_reg[3]) );
  LATSR_E \a_reg_reg[2]  ( .CLK(n445), .D(a[2]), .RN(1'b1), .S(1'b0), .Q(
        a_reg[2]) );
  LATSR_E \a_reg_reg[1]  ( .CLK(n445), .D(a[1]), .RN(1'b1), .S(1'b0), .Q(
        a_reg[1]), .QBAR(n437) );
  LATSR_E \a_reg_reg[0]  ( .CLK(n445), .D(a[0]), .RN(1'b1), .S(1'b0), .QBAR(
        n180) );
  LATSR_E \partial_next_reg[0]  ( .CLK(n487), .D(N126), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[0]) );
  LATSR_E \partial_next_reg[31]  ( .CLK(n487), .D(n288), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[31]) );
  LATSR_E \partial_next_reg[30]  ( .CLK(n487), .D(N156), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[30]) );
  LATSR_E \partial_next_reg[29]  ( .CLK(n487), .D(N155), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[29]) );
  LATSR_E \partial_next_reg[28]  ( .CLK(n487), .D(N154), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[28]) );
  LATSR_E \partial_next_reg[27]  ( .CLK(n487), .D(N153), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[27]) );
  LATSR_E \partial_next_reg[26]  ( .CLK(n487), .D(N152), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[26]) );
  LATSR_E \partial_next_reg[25]  ( .CLK(n487), .D(N151), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[25]) );
  LATSR_E \partial_next_reg[24]  ( .CLK(n486), .D(n275), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[24]) );
  LATSR_E \partial_next_reg[23]  ( .CLK(n486), .D(N149), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[23]) );
  LATSR_E \partial_next_reg[22]  ( .CLK(n486), .D(N148), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[22]) );
  LATSR_E \partial_next_reg[21]  ( .CLK(n486), .D(N147), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[21]) );
  LATSR_E \partial_next_reg[20]  ( .CLK(n486), .D(n202), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[20]) );
  LATSR_E \partial_next_reg[19]  ( .CLK(n486), .D(n168), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[19]) );
  LATSR_E \partial_next_reg[18]  ( .CLK(n486), .D(n201), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[18]) );
  LATSR_E \partial_next_reg[17]  ( .CLK(n486), .D(N143), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[17]) );
  LATSR_E \partial_next_reg[16]  ( .CLK(n485), .D(N142), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[16]) );
  LATSR_E \partial_next_reg[15]  ( .CLK(n485), .D(N141), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[15]) );
  LATSR_E \partial_next_reg[14]  ( .CLK(n485), .D(N140), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[14]) );
  LATSR_E \partial_next_reg[13]  ( .CLK(n485), .D(N139), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[13]) );
  LATSR_E \partial_next_reg[12]  ( .CLK(n485), .D(N138), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[12]) );
  LATSR_E \partial_next_reg[11]  ( .CLK(n485), .D(N137), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[11]) );
  LATSR_E \partial_next_reg[10]  ( .CLK(n485), .D(N136), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[10]) );
  LATSR_E \partial_next_reg[9]  ( .CLK(n485), .D(N135), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[9]) );
  LATSR_E \partial_next_reg[8]  ( .CLK(n484), .D(N134), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[8]) );
  LATSR_E \partial_next_reg[7]  ( .CLK(n484), .D(N133), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[7]) );
  LATSR_E \partial_next_reg[6]  ( .CLK(n484), .D(N132), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[6]) );
  LATSR_E \partial_next_reg[5]  ( .CLK(n484), .D(N131), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[5]) );
  LATSR_E \partial_next_reg[4]  ( .CLK(n484), .D(N130), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[4]) );
  LATSR_E \partial_next_reg[3]  ( .CLK(n484), .D(N129), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[3]) );
  LATSR_E \partial_next_reg[2]  ( .CLK(n484), .D(N128), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[2]) );
  LATSR_E \partial_next_reg[1]  ( .CLK(n484), .D(N127), .RN(1'b1), .S(1'b0), 
        .Q(partial_next[1]) );
  LATSR_E \b_reg_reg[0]  ( .CLK(N122), .D(N123), .RN(1'b1), .S(1'b0), .Q(
        \b_reg[0] ) );
  DFFR_K \state_reg[0]  ( .D(n162), .CLK(clk), .RN(n492), .Q(n436), .QBAR(n164) );
  DFFR_K \state_reg[1]  ( .D(n440), .CLK(clk), .RN(n492), .Q(\state[1] ) );
  DFFR_K \partial_reg[0]  ( .D(partial_next[0]), .CLK(clk), .RN(n492), .Q(
        partial[0]) );
  DFFR_K \c_reg[0]  ( .D(n434), .CLK(clk), .RN(n492), .Q(n541), .QBAR(n21) );
  DFFR_K \partial_reg[31]  ( .D(partial_next[31]), .CLK(clk), .RN(n492), .Q(
        partial[31]), .QBAR(n167) );
  DFFR_K \c_reg[31]  ( .D(n372), .CLK(clk), .RN(n492), .Q(n511) );
  DFFR_K \partial_reg[30]  ( .D(partial_next[30]), .CLK(clk), .RN(n492), .Q(
        partial[30]), .QBAR(n176) );
  DFFR_K \c_reg[30]  ( .D(n432), .CLK(clk), .RN(n493), .Q(n512) );
  DFFR_K \partial_reg[29]  ( .D(partial_next[29]), .CLK(clk), .RN(n493), .Q(
        partial[29]) );
  DFFR_K \c_reg[29]  ( .D(n430), .CLK(clk), .RN(n493), .Q(n513) );
  DFFR_K \partial_reg[28]  ( .D(partial_next[28]), .CLK(clk), .RN(n493), .Q(
        partial[28]) );
  DFFR_K \c_reg[28]  ( .D(n428), .CLK(clk), .RN(n493), .Q(n514) );
  DFFR_K \partial_reg[27]  ( .D(partial_next[27]), .CLK(clk), .RN(n493), .Q(
        partial[27]) );
  DFFR_K \c_reg[27]  ( .D(n426), .CLK(clk), .RN(n493), .Q(n515) );
  DFFR_K \partial_reg[26]  ( .D(partial_next[26]), .CLK(clk), .RN(n494), .Q(
        partial[26]) );
  DFFR_K \c_reg[26]  ( .D(n424), .CLK(clk), .RN(n494), .Q(n516) );
  DFFR_K \partial_reg[25]  ( .D(partial_next[25]), .CLK(clk), .RN(n494), .Q(
        partial[25]), .QBAR(n178) );
  DFFR_K \c_reg[25]  ( .D(n422), .CLK(clk), .RN(n494), .Q(n517) );
  DFFR_K \partial_reg[24]  ( .D(partial_next[24]), .CLK(clk), .RN(n494), .Q(
        partial[24]), .QBAR(n172) );
  DFFR_K \c_reg[24]  ( .D(n420), .CLK(clk), .RN(n494), .Q(n518) );
  DFFR_K \partial_reg[23]  ( .D(partial_next[23]), .CLK(clk), .RN(n494), .Q(
        partial[23]), .QBAR(n175) );
  DFFR_K \c_reg[23]  ( .D(n418), .CLK(clk), .RN(n495), .Q(n519) );
  DFFR_K \partial_reg[22]  ( .D(partial_next[22]), .CLK(clk), .RN(n495), .Q(
        partial[22]) );
  DFFR_K \c_reg[22]  ( .D(n416), .CLK(clk), .RN(n495), .Q(n520) );
  DFFR_K \partial_reg[21]  ( .D(partial_next[21]), .CLK(clk), .RN(n495), .Q(
        partial[21]), .QBAR(n177) );
  DFFR_K \c_reg[21]  ( .D(n414), .CLK(clk), .RN(n495), .Q(n521) );
  DFFR_K \partial_reg[20]  ( .D(partial_next[20]), .CLK(clk), .RN(n495), .Q(
        partial[20]), .QBAR(n173) );
  DFFR_K \c_reg[20]  ( .D(n412), .CLK(clk), .RN(n495), .Q(n522) );
  DFFR_K \partial_reg[19]  ( .D(partial_next[19]), .CLK(clk), .RN(n496), .Q(
        partial[19]) );
  DFFR_K \c_reg[19]  ( .D(n410), .CLK(clk), .RN(n496), .Q(n523) );
  DFFR_K \partial_reg[18]  ( .D(partial_next[18]), .CLK(clk), .RN(n496), .Q(
        partial[18]) );
  DFFR_K \c_reg[18]  ( .D(n408), .CLK(clk), .RN(n496), .Q(n524) );
  DFFR_K \partial_reg[17]  ( .D(partial_next[17]), .CLK(clk), .RN(n496), .Q(
        partial[17]) );
  DFFR_K \c_reg[17]  ( .D(n406), .CLK(clk), .RN(n496), .Q(n525) );
  DFFR_K \partial_reg[16]  ( .D(partial_next[16]), .CLK(clk), .RN(n496), .Q(
        partial[16]) );
  DFFR_K \c_reg[16]  ( .D(n404), .CLK(clk), .RN(n497), .Q(n526) );
  DFFR_K \partial_reg[15]  ( .D(partial_next[15]), .CLK(clk), .RN(n497), .Q(
        partial[15]) );
  DFFR_K \c_reg[15]  ( .D(n402), .CLK(clk), .RN(n497), .Q(n527) );
  DFFR_K \partial_reg[14]  ( .D(partial_next[14]), .CLK(clk), .RN(n497), .Q(
        partial[14]) );
  DFFR_K \c_reg[14]  ( .D(n400), .CLK(clk), .RN(n497), .Q(n528) );
  DFFR_K \partial_reg[13]  ( .D(partial_next[13]), .CLK(clk), .RN(n497), .Q(
        partial[13]), .QBAR(n179) );
  DFFR_K \c_reg[13]  ( .D(n398), .CLK(clk), .RN(n497), .Q(n529) );
  DFFR_K \partial_reg[12]  ( .D(partial_next[12]), .CLK(clk), .RN(n498), .Q(
        partial[12]), .QBAR(n171) );
  DFFR_K \c_reg[12]  ( .D(n396), .CLK(clk), .RN(n498), .Q(n530) );
  DFFR_K \partial_reg[11]  ( .D(partial_next[11]), .CLK(clk), .RN(n498), .Q(
        partial[11]), .QBAR(n174) );
  DFFR_K \c_reg[11]  ( .D(n394), .CLK(clk), .RN(n498), .Q(n531) );
  DFFR_K \partial_reg[10]  ( .D(partial_next[10]), .CLK(clk), .RN(n498), .Q(
        partial[10]) );
  DFFR_K \c_reg[10]  ( .D(n392), .CLK(clk), .RN(n498), .Q(n532) );
  DFFR_K \partial_reg[9]  ( .D(partial_next[9]), .CLK(clk), .RN(n498), .Q(
        partial[9]) );
  DFFR_K \c_reg[9]  ( .D(n390), .CLK(clk), .RN(n499), .Q(n533) );
  DFFR_K \partial_reg[8]  ( .D(partial_next[8]), .CLK(clk), .RN(n492), .Q(
        partial[8]) );
  DFFR_K \c_reg[8]  ( .D(n388), .CLK(clk), .RN(n493), .Q(n534) );
  DFFR_K \partial_reg[7]  ( .D(partial_next[7]), .CLK(clk), .RN(n494), .Q(
        partial[7]) );
  DFFR_K \c_reg[7]  ( .D(n386), .CLK(clk), .RN(n495), .Q(n535) );
  DFFR_K \partial_reg[6]  ( .D(partial_next[6]), .CLK(clk), .RN(n496), .Q(
        partial[6]) );
  DFFR_K \c_reg[6]  ( .D(n384), .CLK(clk), .RN(n497), .Q(n536) );
  DFFR_K \partial_reg[5]  ( .D(partial_next[5]), .CLK(clk), .RN(n499), .Q(
        partial[5]) );
  DFFR_K \c_reg[5]  ( .D(n382), .CLK(clk), .RN(n499), .Q(n537) );
  DFFR_K \partial_reg[4]  ( .D(partial_next[4]), .CLK(clk), .RN(n499), .Q(
        partial[4]) );
  DFFR_K \c_reg[4]  ( .D(n380), .CLK(clk), .RN(n499), .Q(n538) );
  DFFR_K \partial_reg[3]  ( .D(partial_next[3]), .CLK(clk), .RN(n499), .Q(
        partial[3]) );
  DFFR_K \c_reg[3]  ( .D(n378), .CLK(clk), .RN(n499), .Q(n539) );
  DFFR_K \partial_reg[2]  ( .D(partial_next[2]), .CLK(clk), .RN(n499), .Q(
        partial[2]) );
  DFFR_K \c_reg[2]  ( .D(n376), .CLK(clk), .RN(n500), .Q(n540) );
  DFFR_K \partial_reg[1]  ( .D(partial_next[1]), .CLK(clk), .RN(n500), .Q(
        partial[1]) );
  DFFR_K \c_reg[1]  ( .D(n374), .CLK(clk), .RN(n500), .QBAR(n165) );
  NOR2_D U14 ( .A(n21), .B(n480), .Z(N159) );
  NOR2_D U61 ( .A(n292), .B(n306), .Z(n10) );
  NOR2_D U63 ( .A(n291), .B(n306), .Z(n163) );
  booth_mult_ver_syn_DW01_sub_0 sub_66 ( .A({n372, n432, n430, n428, n426, 
        n424, n422, n420, n418, n416, n414, n412, n410, n408, n406, n404, n402, 
        n400, n398, n396, n394, n392, n390, n388, n386, n384, n382, n380, n378, 
        n376, n374, n434}), .B({a_reg[31:1], n301}), .CI(1'b0), .DIFF({N82, 
        N81, N80, N79, N78, N77, N76, N75, N74, N73, N72, N71, N70, N69, N68, 
        N67, N66, N65, N64, N63, N62, N61, N60, N59, N58, N57, N56, N55, N54, 
        N53, N52, N51}) );
  booth_mult_ver_syn_DW01_add_0 add_64 ( .A({n372, n432, n430, n428, n426, 
        n424, n422, n420, n418, n416, n414, n412, n410, n408, n406, n404, n402, 
        n400, n398, n396, n394, n392, n390, n388, n386, n384, n382, n380, n378, 
        n376, n374, n434}), .B({a_reg[31:2], n438, n301}), .CI(1'b0), .SUM({
        N50, N49, N48, N47, N46, N45, N44, N43, N42, N41, N40, N39, N38, N37, 
        N36, N35, N34, N33, N32, N31, N30, N29, N28, N27, N26, N25, N24, N23, 
        N22, N21, N20, N19}) );
  LATSR_E previous_reg ( .CLK(N122), .D(N159), .RN(1'b1), .S(1'b0), .Q(
        previous), .QBAR(n439) );
  INVERT_H U199 ( .A(partial[31]), .Z(n371) );
  INVERT_E U200 ( .A(n294), .Z(n299) );
  INVERTBAL_E U201 ( .A(n17), .Z(n297) );
  INVERT_E U202 ( .A(n14), .Z(n295) );
  INVERT_H U203 ( .A(n461), .Z(n236) );
  INVERT_K U204 ( .A(n457), .Z(n456) );
  INVERT_H U205 ( .A(n459), .Z(n221) );
  INVERT_I U206 ( .A(n508), .Z(n507) );
  INVERT_I U207 ( .A(n180), .Z(n301) );
  INVERT_K U208 ( .A(a[15]), .Z(n181) );
  INVERT_E U209 ( .A(N157), .Z(n288) );
  INVERT_H U210 ( .A(n478), .Z(n266) );
  INVERT_J U211 ( .A(n457), .Z(n455) );
  INVERT_I U212 ( .A(n472), .Z(n470) );
  INVERT_H U213 ( .A(n469), .Z(n251) );
  INVERT_D U214 ( .A(n170), .Z(n201) );
  INVERT_K U215 ( .A(n481), .Z(n477) );
  INVERT_K U216 ( .A(n465), .Z(n461) );
  INVERT_H U217 ( .A(n460), .Z(n211) );
  AND2_H U218 ( .A(n186), .B(n187), .Z(n166) );
  INVERT_K U219 ( .A(n480), .Z(n478) );
  INVERT_I U220 ( .A(n456), .Z(n451) );
  INVERT_I U221 ( .A(n371), .Z(n372) );
  INVERT_D U222 ( .A(N150), .Z(n275) );
  AO2222_F U223 ( .A1(n412), .A2(n479), .B1(n410), .B2(n452), .C1(N38), .C2(
        n471), .D1(N70), .D2(n459), .Z(n168) );
  INVERT_D U224 ( .A(N146), .Z(n202) );
  INVERT_I U225 ( .A(n507), .Z(n502) );
  AND2_H U226 ( .A(n184), .B(n185), .Z(n169) );
  INVERT_K U227 ( .A(n465), .Z(n459) );
  AND2_H U228 ( .A(n169), .B(n166), .Z(n170) );
  INVERT_J U229 ( .A(n395), .Z(n396) );
  INVERT_J U230 ( .A(n419), .Z(n420) );
  INVERT_L U231 ( .A(n473), .Z(n469) );
  INVERT_I U232 ( .A(n411), .Z(n412) );
  INVERT_I U233 ( .A(n393), .Z(n394) );
  INVERT_I U234 ( .A(n417), .Z(n418) );
  INVERT_I U235 ( .A(n431), .Z(n432) );
  INVERT_I U236 ( .A(n413), .Z(n414) );
  INVERT_I U237 ( .A(n421), .Z(n422) );
  INVERT_I U238 ( .A(n397), .Z(n398) );
  INVERT_J U239 ( .A(n435), .Z(n289) );
  INVERT_I U240 ( .A(n165), .Z(n435) );
  INVERT_M U241 ( .A(n181), .Z(n182) );
  INVERT_M U242 ( .A(n181), .Z(n183) );
  INVERTBAL_J U243 ( .A(n540), .Z(n309) );
  INVERTBAL_J U244 ( .A(n539), .Z(n311) );
  INVERTBAL_J U245 ( .A(n538), .Z(n313) );
  INVERTBAL_J U246 ( .A(n537), .Z(n315) );
  INVERTBAL_J U247 ( .A(n536), .Z(n317) );
  INVERTBAL_J U248 ( .A(n535), .Z(n319) );
  INVERTBAL_J U249 ( .A(n534), .Z(n321) );
  INVERTBAL_J U250 ( .A(n533), .Z(n323) );
  INVERTBAL_J U251 ( .A(n532), .Z(n325) );
  INVERTBAL_J U252 ( .A(n531), .Z(n327) );
  INVERTBAL_J U253 ( .A(n530), .Z(n329) );
  INVERTBAL_J U254 ( .A(n529), .Z(n331) );
  INVERTBAL_J U255 ( .A(n528), .Z(n333) );
  INVERTBAL_J U256 ( .A(n527), .Z(n335) );
  INVERTBAL_J U257 ( .A(n526), .Z(n337) );
  INVERTBAL_J U258 ( .A(n525), .Z(n339) );
  INVERTBAL_J U259 ( .A(n524), .Z(n341) );
  INVERTBAL_J U260 ( .A(n523), .Z(n343) );
  INVERTBAL_J U261 ( .A(n522), .Z(n345) );
  INVERTBAL_J U262 ( .A(n521), .Z(n347) );
  INVERTBAL_J U263 ( .A(n520), .Z(n349) );
  INVERTBAL_J U264 ( .A(n519), .Z(n351) );
  INVERTBAL_J U265 ( .A(n518), .Z(n353) );
  INVERTBAL_J U266 ( .A(n517), .Z(n355) );
  INVERTBAL_J U267 ( .A(n516), .Z(n357) );
  INVERTBAL_J U268 ( .A(n515), .Z(n359) );
  INVERTBAL_J U269 ( .A(n514), .Z(n361) );
  INVERTBAL_J U270 ( .A(n513), .Z(n363) );
  INVERTBAL_J U271 ( .A(n512), .Z(n365) );
  INVERTBAL_J U272 ( .A(n511), .Z(n367) );
  INVERTBAL_J U273 ( .A(n541), .Z(n369) );
  INVERT_K U274 ( .A(n466), .Z(n465) );
  INVERT_K U275 ( .A(n466), .Z(n464) );
  NAND2BAL_E U276 ( .A(n410), .B(n479), .Z(n184) );
  NAND2BAL_E U277 ( .A(n408), .B(n452), .Z(n185) );
  NAND2BAL_E U278 ( .A(N37), .B(n471), .Z(n186) );
  NAND2BAL_E U279 ( .A(N69), .B(n459), .Z(n187) );
  NOR2_C U280 ( .A(n188), .B(n189), .Z(N146) );
  NOR2_C U281 ( .A(n266), .B(n177), .Z(n190) );
  INVERT_E U282 ( .A(n451), .Z(n191) );
  NOR2_C U283 ( .A(n191), .B(n173), .Z(n192) );
  INVERT_F U284 ( .A(n471), .Z(n193) );
  INVERT_H U285 ( .A(N39), .Z(n194) );
  NOR2_C U286 ( .A(n193), .B(n194), .Z(n195) );
  INVERT_D U287 ( .A(n459), .Z(n196) );
  INVERT_H U288 ( .A(N71), .Z(n197) );
  NOR2_C U289 ( .A(n196), .B(n197), .Z(n198) );
  NOR2_C U290 ( .A(n190), .B(n192), .Z(n199) );
  INVERT_E U291 ( .A(n199), .Z(n188) );
  NOR2_C U292 ( .A(n195), .B(n198), .Z(n200) );
  INVERT_E U293 ( .A(n200), .Z(n189) );
  INVERT_N U294 ( .A(n472), .Z(n471) );
  AO2222_F U295 ( .A1(n418), .A2(n479), .B1(n416), .B2(n451), .C1(N41), .C2(
        n471), .D1(N73), .D2(n459), .Z(N148) );
  INVERT_K U296 ( .A(n464), .Z(n460) );
  AO2222_F U297 ( .A1(n406), .A2(n478), .B1(n404), .B2(n452), .C1(N35), .C2(
        n471), .D1(N67), .D2(n461), .Z(N142) );
  AO2222_F U298 ( .A1(n408), .A2(n478), .B1(n406), .B2(n452), .C1(N36), .C2(
        n471), .D1(N68), .D2(n461), .Z(N143) );
  AO2222_F U299 ( .A1(n416), .A2(n478), .B1(n414), .B2(n451), .C1(N40), .C2(
        n470), .D1(N72), .D2(n460), .Z(N147) );
  INVERT_E U300 ( .A(n263), .Z(n203) );
  AO2222_F U301 ( .A1(n426), .A2(n479), .B1(n424), .B2(n450), .C1(N45), .C2(
        n471), .D1(N77), .D2(n460), .Z(N152) );
  AO2222_F U302 ( .A1(n424), .A2(n479), .B1(n422), .B2(n451), .C1(N44), .C2(
        n470), .D1(N76), .D2(n460), .Z(N151) );
  AO2222_F U303 ( .A1(n428), .A2(n479), .B1(n426), .B2(n450), .C1(N46), .C2(
        n471), .D1(N78), .D2(n203), .Z(N153) );
  AO2222_F U304 ( .A1(n430), .A2(n479), .B1(n428), .B2(n450), .C1(N47), .C2(
        n471), .D1(N79), .D2(n460), .Z(N154) );
  AO2222_F U305 ( .A1(n432), .A2(n479), .B1(n430), .B2(n450), .C1(N48), .C2(
        n471), .D1(N80), .D2(n459), .Z(N155) );
  NAND2BAL_E U306 ( .A(n306), .B(n436), .Z(n9) );
  INVERT_H U307 ( .A(n20), .Z(n304) );
  AND2_I U308 ( .A(n306), .B(n292), .Z(n20) );
  NOR2_C U309 ( .A(n204), .B(n205), .Z(N150) );
  NOR2_C U310 ( .A(n481), .B(n178), .Z(n206) );
  INVERT_H U311 ( .A(n420), .Z(n207) );
  NOR2_C U312 ( .A(n239), .B(n207), .Z(n208) );
  INVERT_H U313 ( .A(N43), .Z(n209) );
  NOR2_C U314 ( .A(n473), .B(n209), .Z(n210) );
  INVERT_H U315 ( .A(N75), .Z(n212) );
  NOR2_C U316 ( .A(n211), .B(n212), .Z(n213) );
  NOR2_C U317 ( .A(n206), .B(n208), .Z(n214) );
  INVERT_E U318 ( .A(n214), .Z(n204) );
  NOR2_C U319 ( .A(n210), .B(n213), .Z(n215) );
  INVERT_E U320 ( .A(n215), .Z(n205) );
  NOR2_C U321 ( .A(n216), .B(n217), .Z(N157) );
  INVERT_E U322 ( .A(n470), .Z(n218) );
  INVERT_E U323 ( .A(N50), .Z(n219) );
  NOR2_C U324 ( .A(n218), .B(n219), .Z(n220) );
  INVERT_E U325 ( .A(N82), .Z(n222) );
  NOR2_C U326 ( .A(n221), .B(n222), .Z(n223) );
  INVERT_H U327 ( .A(n450), .Z(n224) );
  INVERT_D U328 ( .A(n372), .Z(n225) );
  NOR2_D U329 ( .A(n224), .B(n225), .Z(n216) );
  NOR2_C U330 ( .A(n220), .B(n223), .Z(n226) );
  INVERT_E U331 ( .A(n226), .Z(n217) );
  INVERT_H U332 ( .A(n233), .Z(n227) );
  AO2222_F U333 ( .A1(n374), .A2(n476), .B1(n434), .B2(n457), .C1(N19), .C2(
        n468), .D1(N51), .D2(n463), .Z(N126) );
  AO2222_F U334 ( .A1(n376), .A2(n476), .B1(n374), .B2(n450), .C1(N20), .C2(
        n468), .D1(N52), .D2(n463), .Z(N127) );
  AO2222_F U335 ( .A1(n378), .A2(n476), .B1(n376), .B2(n454), .C1(N21), .C2(
        n468), .D1(N53), .D2(n463), .Z(N128) );
  AO2222_F U336 ( .A1(n380), .A2(n476), .B1(n378), .B2(n454), .C1(N22), .C2(
        n468), .D1(N54), .D2(n463), .Z(N129) );
  AO2222_F U337 ( .A1(n382), .A2(n476), .B1(n380), .B2(n454), .C1(N23), .C2(
        n468), .D1(N55), .D2(n462), .Z(N130) );
  NAND2_E U338 ( .A(n227), .B(n228), .Z(N131) );
  NAND2BAL_E U339 ( .A(N56), .B(n462), .Z(n229) );
  NAND2BAL_E U340 ( .A(N24), .B(n468), .Z(n230) );
  NAND2BAL_E U341 ( .A(n382), .B(n454), .Z(n231) );
  NAND2BAL_E U342 ( .A(n384), .B(n476), .Z(n232) );
  NAND2BAL_E U343 ( .A(n229), .B(n230), .Z(n233) );
  NAND2BAL_E U344 ( .A(n231), .B(n232), .Z(n234) );
  INVERT_H U345 ( .A(n234), .Z(n228) );
  INVERT_M U346 ( .A(n481), .Z(n476) );
  INVERT_M U347 ( .A(n473), .Z(n468) );
  INVERT_L U348 ( .A(n464), .Z(n462) );
  AO2222_F U349 ( .A1(n386), .A2(n476), .B1(n384), .B2(n454), .C1(N25), .C2(
        n468), .D1(N57), .D2(n462), .Z(N132) );
  AO2222_F U350 ( .A1(n388), .A2(n477), .B1(n386), .B2(n454), .C1(N26), .C2(
        n468), .D1(N58), .D2(n462), .Z(N133) );
  AO2222_F U351 ( .A1(n390), .A2(n477), .B1(n388), .B2(n453), .C1(N27), .C2(
        n469), .D1(N59), .D2(n462), .Z(N134) );
  AO2222_F U352 ( .A1(n392), .A2(n477), .B1(n390), .B2(n453), .C1(N28), .C2(
        n469), .D1(N60), .D2(n462), .Z(N135) );
  AO2222_F U353 ( .A1(n394), .A2(n477), .B1(n392), .B2(n453), .C1(N29), .C2(
        n469), .D1(N61), .D2(n462), .Z(N136) );
  INVERT_E U354 ( .A(n235), .Z(N137) );
  INVERT_H U355 ( .A(N62), .Z(n237) );
  INVERT_H U356 ( .A(N30), .Z(n238) );
  INVERT_H U357 ( .A(n453), .Z(n239) );
  INVERT_H U358 ( .A(n396), .Z(n240) );
  NOR2_C U359 ( .A(n236), .B(n237), .Z(n241) );
  NOR2_C U360 ( .A(n193), .B(n238), .Z(n242) );
  NOR2_C U361 ( .A(n239), .B(n174), .Z(n243) );
  NOR2_C U362 ( .A(n480), .B(n240), .Z(n244) );
  NOR2_C U363 ( .A(n245), .B(n246), .Z(n235) );
  NOR2_C U364 ( .A(n241), .B(n242), .Z(n247) );
  INVERT_E U365 ( .A(n247), .Z(n245) );
  NOR2_C U366 ( .A(n243), .B(n244), .Z(n248) );
  INVERT_E U367 ( .A(n248), .Z(n246) );
  INVERT_E U368 ( .A(n249), .Z(N138) );
  INVERT_H U369 ( .A(N63), .Z(n250) );
  INVERT_H U370 ( .A(N31), .Z(n252) );
  INVERT_H U371 ( .A(n453), .Z(n253) );
  NOR2_C U372 ( .A(n211), .B(n250), .Z(n254) );
  NOR2_C U373 ( .A(n251), .B(n252), .Z(n255) );
  NOR2_C U374 ( .A(n253), .B(n171), .Z(n256) );
  NOR2_C U375 ( .A(n480), .B(n179), .Z(n257) );
  NOR2_C U376 ( .A(n258), .B(n259), .Z(n249) );
  NOR2_C U377 ( .A(n254), .B(n255), .Z(n260) );
  INVERT_E U378 ( .A(n260), .Z(n258) );
  NOR2_C U379 ( .A(n256), .B(n257), .Z(n261) );
  INVERT_E U380 ( .A(n261), .Z(n259) );
  AO2222_F U381 ( .A1(n400), .A2(n477), .B1(n398), .B2(n453), .C1(N32), .C2(
        n469), .D1(N64), .D2(n461), .Z(N139) );
  AO2222_F U382 ( .A1(n402), .A2(n477), .B1(n400), .B2(n452), .C1(N33), .C2(
        n469), .D1(N65), .D2(n461), .Z(N140) );
  AO2222_F U383 ( .A1(n404), .A2(n478), .B1(n402), .B2(n452), .C1(N34), .C2(
        n469), .D1(N66), .D2(n461), .Z(N141) );
  INVERT_E U384 ( .A(n262), .Z(N149) );
  INVERT_F U385 ( .A(n460), .Z(n263) );
  INVERT_H U386 ( .A(N74), .Z(n264) );
  INVERT_H U387 ( .A(N42), .Z(n265) );
  NOR2_C U388 ( .A(n263), .B(n264), .Z(n267) );
  NOR2_C U389 ( .A(n472), .B(n265), .Z(n268) );
  NOR2_C U390 ( .A(n253), .B(n175), .Z(n269) );
  NOR2_C U391 ( .A(n266), .B(n172), .Z(n270) );
  NOR2_C U392 ( .A(n271), .B(n272), .Z(n262) );
  NOR2_C U393 ( .A(n267), .B(n268), .Z(n273) );
  INVERT_E U394 ( .A(n273), .Z(n271) );
  NOR2_C U395 ( .A(n269), .B(n270), .Z(n274) );
  INVERT_E U396 ( .A(n274), .Z(n272) );
  INVERT_M U397 ( .A(n480), .Z(n479) );
  INVERT_E U398 ( .A(n276), .Z(N156) );
  INVERT_H U399 ( .A(N81), .Z(n277) );
  INVERT_H U400 ( .A(N49), .Z(n278) );
  INVERT_E U401 ( .A(n478), .Z(n279) );
  NOR2_C U402 ( .A(n465), .B(n277), .Z(n280) );
  NOR2_C U403 ( .A(n251), .B(n278), .Z(n281) );
  NOR2_C U404 ( .A(n224), .B(n176), .Z(n282) );
  NOR2_C U405 ( .A(n279), .B(n167), .Z(n283) );
  NOR2_C U406 ( .A(n284), .B(n285), .Z(n276) );
  NOR2_C U407 ( .A(n280), .B(n281), .Z(n286) );
  INVERT_E U408 ( .A(n286), .Z(n284) );
  NOR2_C U409 ( .A(n282), .B(n283), .Z(n287) );
  INVERT_E U410 ( .A(n287), .Z(n285) );
  AO22_F U411 ( .A1(b[0]), .A2(n441), .B1(n476), .B2(n435), .Z(N123) );
  INVERT_O U412 ( .A(n289), .Z(c[1]) );
  INVERT_H U413 ( .A(n164), .Z(n291) );
  INVERT_H U414 ( .A(n291), .Z(n292) );
  INVERT_F U415 ( .A(previous), .Z(n293) );
  INVERT_H U416 ( .A(n293), .Z(n294) );
  INVERT_E U417 ( .A(n295), .Z(n296) );
  NOR2_C U418 ( .A(n297), .B(n298), .Z(n14) );
  NOR2_C U419 ( .A(n304), .B(n299), .Z(n300) );
  INVERT_E U420 ( .A(n300), .Z(n298) );
  OR2_I U421 ( .A(n445), .B(n162), .Z(N125) );
  NAND2_F U422 ( .A(n480), .B(n303), .Z(n162) );
  AND3_I U423 ( .A(n510), .B(n439), .C(n17), .Z(n15) );
  NOR2_D U424 ( .A(n303), .B(n17), .Z(n16) );
  XOR2_D U425 ( .A(n294), .B(\b_reg[0] ), .Z(n17) );
  INVERT_F U426 ( .A(n304), .Z(n302) );
  INVERT_I U427 ( .A(n302), .Z(n303) );
  INVERT_H U428 ( .A(\state[1] ), .Z(n305) );
  INVERT_J U429 ( .A(n305), .Z(n306) );
  INVERT_J U430 ( .A(n542), .Z(n307) );
  INVERT_O U431 ( .A(n307), .Z(ready) );
  INVERT_O U432 ( .A(n309), .Z(c[2]) );
  INVERT_O U433 ( .A(n311), .Z(c[3]) );
  INVERT_O U434 ( .A(n313), .Z(c[4]) );
  INVERT_O U435 ( .A(n315), .Z(c[5]) );
  INVERT_O U436 ( .A(n317), .Z(c[6]) );
  INVERT_O U437 ( .A(n319), .Z(c[7]) );
  INVERT_O U438 ( .A(n321), .Z(c[8]) );
  INVERT_O U439 ( .A(n323), .Z(c[9]) );
  INVERT_O U440 ( .A(n325), .Z(c[10]) );
  INVERT_O U441 ( .A(n327), .Z(c[11]) );
  INVERT_O U442 ( .A(n329), .Z(c[12]) );
  INVERT_O U443 ( .A(n331), .Z(c[13]) );
  INVERT_O U444 ( .A(n333), .Z(c[14]) );
  INVERT_O U445 ( .A(n335), .Z(c[15]) );
  INVERT_O U446 ( .A(n337), .Z(c[16]) );
  INVERT_O U447 ( .A(n339), .Z(c[17]) );
  INVERT_O U448 ( .A(n341), .Z(c[18]) );
  INVERT_O U449 ( .A(n343), .Z(c[19]) );
  INVERT_O U450 ( .A(n345), .Z(c[20]) );
  INVERT_O U451 ( .A(n347), .Z(c[21]) );
  INVERT_O U452 ( .A(n349), .Z(c[22]) );
  INVERT_O U453 ( .A(n351), .Z(c[23]) );
  INVERT_O U454 ( .A(n353), .Z(c[24]) );
  INVERT_O U455 ( .A(n355), .Z(c[25]) );
  INVERT_O U456 ( .A(n357), .Z(c[26]) );
  INVERT_O U457 ( .A(n359), .Z(c[27]) );
  INVERT_O U458 ( .A(n361), .Z(c[28]) );
  INVERT_O U459 ( .A(n363), .Z(c[29]) );
  INVERT_O U460 ( .A(n365), .Z(c[30]) );
  INVERT_O U461 ( .A(n367), .Z(c[31]) );
  INVERT_O U462 ( .A(n369), .Z(c[0]) );
  INVERT_H U463 ( .A(partial[1]), .Z(n373) );
  INVERT_K U464 ( .A(n373), .Z(n374) );
  INVERT_H U465 ( .A(partial[2]), .Z(n375) );
  INVERT_K U466 ( .A(n375), .Z(n376) );
  INVERT_H U467 ( .A(partial[3]), .Z(n377) );
  INVERT_K U468 ( .A(n377), .Z(n378) );
  INVERT_H U469 ( .A(partial[4]), .Z(n379) );
  INVERT_K U470 ( .A(n379), .Z(n380) );
  INVERT_H U471 ( .A(partial[5]), .Z(n381) );
  INVERT_K U472 ( .A(n381), .Z(n382) );
  INVERT_H U473 ( .A(partial[6]), .Z(n383) );
  INVERT_K U474 ( .A(n383), .Z(n384) );
  INVERT_H U475 ( .A(partial[7]), .Z(n385) );
  INVERT_K U476 ( .A(n385), .Z(n386) );
  INVERT_H U477 ( .A(partial[8]), .Z(n387) );
  INVERT_K U478 ( .A(n387), .Z(n388) );
  INVERT_H U479 ( .A(partial[9]), .Z(n389) );
  INVERT_K U480 ( .A(n389), .Z(n390) );
  INVERT_H U481 ( .A(partial[10]), .Z(n391) );
  INVERT_K U482 ( .A(n391), .Z(n392) );
  INVERT_H U483 ( .A(partial[11]), .Z(n393) );
  INVERT_H U484 ( .A(partial[12]), .Z(n395) );
  INVERT_H U485 ( .A(partial[13]), .Z(n397) );
  INVERT_H U486 ( .A(partial[14]), .Z(n399) );
  INVERT_K U487 ( .A(n399), .Z(n400) );
  INVERT_H U488 ( .A(partial[15]), .Z(n401) );
  INVERT_K U489 ( .A(n401), .Z(n402) );
  INVERT_H U490 ( .A(partial[16]), .Z(n403) );
  INVERT_K U491 ( .A(n403), .Z(n404) );
  INVERT_H U492 ( .A(partial[17]), .Z(n405) );
  INVERT_K U493 ( .A(n405), .Z(n406) );
  INVERT_H U494 ( .A(partial[18]), .Z(n407) );
  INVERT_K U495 ( .A(n407), .Z(n408) );
  INVERT_H U496 ( .A(partial[19]), .Z(n409) );
  INVERT_K U497 ( .A(n409), .Z(n410) );
  INVERT_H U498 ( .A(partial[20]), .Z(n411) );
  INVERT_H U499 ( .A(partial[21]), .Z(n413) );
  INVERT_H U500 ( .A(partial[22]), .Z(n415) );
  INVERT_K U501 ( .A(n415), .Z(n416) );
  INVERT_H U502 ( .A(partial[23]), .Z(n417) );
  INVERT_H U503 ( .A(partial[24]), .Z(n419) );
  INVERT_H U504 ( .A(partial[25]), .Z(n421) );
  INVERT_H U505 ( .A(partial[26]), .Z(n423) );
  INVERT_K U506 ( .A(n423), .Z(n424) );
  INVERT_H U507 ( .A(partial[27]), .Z(n425) );
  INVERT_K U508 ( .A(n425), .Z(n426) );
  INVERT_H U509 ( .A(partial[28]), .Z(n427) );
  INVERT_K U510 ( .A(n427), .Z(n428) );
  INVERT_H U511 ( .A(partial[29]), .Z(n429) );
  INVERT_K U512 ( .A(n429), .Z(n430) );
  INVERT_H U513 ( .A(partial[30]), .Z(n431) );
  INVERT_H U514 ( .A(partial[0]), .Z(n433) );
  INVERT_K U515 ( .A(n433), .Z(n434) );
  INVERT_H U516 ( .A(n437), .Z(n438) );
  OR2_H U517 ( .A(N122), .B(n509), .Z(n440) );
  NAND2_H U518 ( .A(n446), .B(n480), .Z(N122) );
  INVERT_J U519 ( .A(rst_n), .Z(n508) );
  INVERT_J U520 ( .A(n491), .Z(n490) );
  INVERT_F U521 ( .A(N125), .Z(n491) );
  INVERT_F U522 ( .A(n303), .Z(n510) );
  INVERT_L U523 ( .A(n508), .Z(n506) );
  INVERT_F U524 ( .A(n9), .Z(n509) );
  INVERT_J U525 ( .A(n467), .Z(n466) );
  INVERT_J U526 ( .A(n475), .Z(n474) );
  INVERT_K U527 ( .A(n490), .Z(n489) );
  INVERT_K U528 ( .A(n490), .Z(n488) );
  INVERT_K U529 ( .A(n506), .Z(n503) );
  INVERT_K U530 ( .A(n506), .Z(n504) );
  INVERT_K U531 ( .A(n506), .Z(n505) );
  INVERT_J U532 ( .A(n507), .Z(n501) );
  INVERT_K U533 ( .A(n458), .Z(n457) );
  INVERT_K U534 ( .A(n448), .Z(n447) );
  INVERT_K U535 ( .A(n482), .Z(n481) );
  INVERT_K U536 ( .A(n474), .Z(n472) );
  INVERT_K U537 ( .A(n474), .Z(n473) );
  INVERT_K U538 ( .A(n483), .Z(n482) );
  INVERT_K U539 ( .A(n449), .Z(n448) );
  INVERT_M U540 ( .A(n489), .Z(n484) );
  INVERT_M U541 ( .A(n489), .Z(n485) );
  INVERT_M U542 ( .A(n488), .Z(n486) );
  INVERT_M U543 ( .A(n488), .Z(n487) );
  INVERT_M U544 ( .A(n503), .Z(n497) );
  INVERT_M U545 ( .A(n503), .Z(n496) );
  INVERT_M U546 ( .A(n504), .Z(n495) );
  INVERT_M U547 ( .A(n504), .Z(n494) );
  INVERT_M U548 ( .A(n505), .Z(n493) );
  INVERT_M U549 ( .A(n505), .Z(n492) );
  INVERT_M U550 ( .A(n501), .Z(n499) );
  INVERT_M U551 ( .A(n502), .Z(n498) );
  INVERT_K U552 ( .A(n456), .Z(n450) );
  INVERT_K U553 ( .A(n455), .Z(n454) );
  INVERT_K U554 ( .A(n455), .Z(n453) );
  INVERT_K U555 ( .A(n456), .Z(n452) );
  INVERT_I U556 ( .A(n501), .Z(n500) );
  INVERT_M U557 ( .A(n446), .Z(n444) );
  INVERT_M U558 ( .A(n446), .Z(n443) );
  INVERT_M U559 ( .A(n447), .Z(n441) );
  INVERT_M U560 ( .A(n446), .Z(n445) );
  INVERT_M U561 ( .A(n447), .Z(n442) );
  INVERT_I U562 ( .A(n464), .Z(n463) );
  INVERT_N U563 ( .A(n448), .Z(n446) );
  INVERT_H U564 ( .A(n16), .Z(n458) );
  INVERT_H U565 ( .A(n10), .Z(n483) );
  INVERT_H U566 ( .A(n163), .Z(n449) );
  INVERT_H U567 ( .A(n15), .Z(n467) );
  INVERT_H U568 ( .A(n296), .Z(n475) );
  INVERT_N U569 ( .A(n482), .Z(n480) );
endmodule

