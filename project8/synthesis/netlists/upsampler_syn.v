/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Thu Apr 24 19:49:17 2025
/////////////////////////////////////////////////////////////


module upsampler_syn ( clk, rst_n, new_symbol, input_data_1, input_data_2, 
        sample_rate, output_data_1, output_data_2 );
  input [3:0] input_data_1;
  input [3:0] input_data_2;
  input [3:0] sample_rate;
  output [3:0] output_data_1;
  output [3:0] output_data_2;
  input clk, rst_n, new_symbol;
  wire   state_current, n23, n24, n25, n26, n27, n28, n29, n31, n32, n33, n34,
         n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48,
         n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62,
         n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76,
         n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90,
         n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103,
         n104, n105, n106, n107, n108, n109, n110, n111;
  wire   [3:0] sample_count_current;
  wire   [3:0] sample_rate_q;

  DFFR_E state_current_reg ( .D(n35), .CLK(clk), .RN(rst_n), .Q(state_current)
         );
  DFFR_E \sample_count_current_reg[1]  ( .D(n27), .CLK(clk), .RN(rst_n), 
        .QBAR(n43) );
  DFFR_E \sample_count_current_reg[3]  ( .D(n45), .CLK(clk), .RN(rst_n), .Q(
        sample_count_current[3]), .QBAR(n79) );
  DFFR_E \sample_count_current_reg[2]  ( .D(n48), .CLK(clk), .RN(rst_n), .Q(
        sample_count_current[2]) );
  DFFR_E \sample_count_current_reg[0]  ( .D(n41), .CLK(clk), .RN(rst_n), .Q(
        sample_count_current[0]), .QBAR(n64) );
  DFFR_H \output_data_1_reg[0]  ( .D(n23), .CLK(clk), .RN(rst_n), .Q(
        output_data_1[0]) );
  DFFR_H \output_data_1_reg[1]  ( .D(n24), .CLK(clk), .RN(rst_n), .Q(
        output_data_1[1]) );
  DFFR_H \output_data_1_reg[2]  ( .D(n25), .CLK(clk), .RN(rst_n), .Q(
        output_data_1[2]) );
  DFFR_H \output_data_1_reg[3]  ( .D(n26), .CLK(clk), .RN(rst_n), .Q(
        output_data_1[3]) );
  DFFR_H \output_data_2_reg[0]  ( .D(n31), .CLK(clk), .RN(rst_n), .Q(
        output_data_2[0]) );
  DFFR_H \output_data_2_reg[1]  ( .D(n32), .CLK(clk), .RN(rst_n), .Q(
        output_data_2[1]) );
  DFFR_H \output_data_2_reg[2]  ( .D(n33), .CLK(clk), .RN(rst_n), .Q(
        output_data_2[2]) );
  DFFR_H \output_data_2_reg[3]  ( .D(n34), .CLK(clk), .RN(rst_n), .Q(
        output_data_2[3]) );
  DFF_E \sample_rate_q_reg[3]  ( .D(n39), .CLK(clk), .Q(sample_rate_q[3]), 
        .QBAR(n86) );
  DFF_E \sample_rate_q_reg[0]  ( .D(n36), .CLK(clk), .Q(sample_rate_q[0]), 
        .QBAR(n81) );
  DFF_E \sample_rate_q_reg[1]  ( .D(n37), .CLK(clk), .Q(sample_rate_q[1]), 
        .QBAR(n83) );
  DFF_E \sample_rate_q_reg[2]  ( .D(n38), .CLK(clk), .Q(sample_rate_q[2]), 
        .QBAR(n82) );
  INVERT_D U40 ( .A(n70), .Z(n74) );
  INVERT_K U41 ( .A(n68), .Z(n69) );
  AND2_I U42 ( .A(n60), .B(sample_count_current[0]), .Z(n99) );
  INVERT_H U43 ( .A(new_symbol), .Z(n111) );
  XNOR2_C U44 ( .A(n59), .B(n65), .Z(n40) );
  MUX21I_C U45 ( .D0(n95), .D1(n96), .SD(n65), .Z(n41) );
  AO21_F U46 ( .A1(n80), .A2(n106), .B(n107), .Z(n42) );
  XOR2_C U47 ( .A(n102), .B(n57), .Z(n44) );
  INVERT_H U48 ( .A(sample_count_current[2]), .Z(n61) );
  MUX21_D U49 ( .D0(n100), .D1(n101), .SD(sample_count_current[3]), .Z(n28) );
  INVERT_C U50 ( .A(n28), .Z(n45) );
  INVERT_E U51 ( .A(n98), .Z(n46) );
  INVERT_H U52 ( .A(n46), .Z(n47) );
  OA21_H U53 ( .A1(n55), .A2(n95), .B(n96), .Z(n98) );
  NAND2_I U54 ( .A(n69), .B(n103), .Z(n95) );
  OA21_F U55 ( .A1(n95), .A2(n62), .B(n47), .Z(n101) );
  MUX21_E U56 ( .D0(n97), .D1(n47), .SD(n63), .Z(n29) );
  INVERT_C U57 ( .A(n29), .Z(n48) );
  XOR2_C U58 ( .A(n63), .B(n49), .Z(n107) );
  MUX21_E U59 ( .D0(n52), .D1(sample_rate[2]), .SD(rst_n), .Z(n38) );
  MUX21_E U60 ( .D0(n57), .D1(sample_rate[1]), .SD(rst_n), .Z(n37) );
  MUX21_E U61 ( .D0(n59), .D1(sample_rate[0]), .SD(rst_n), .Z(n36) );
  AND2_H U62 ( .A(n89), .B(n53), .Z(n108) );
  INVERT_D U63 ( .A(n108), .Z(n49) );
  AND2_H U64 ( .A(n102), .B(n93), .Z(n84) );
  INVERT_D U65 ( .A(n84), .Z(n50) );
  NAND2BAL_E U66 ( .A(n83), .B(n90), .Z(n109) );
  INVERT_H U67 ( .A(sample_rate_q[2]), .Z(n51) );
  INVERT_H U68 ( .A(n51), .Z(n52) );
  OA21_F U69 ( .A1(n59), .A2(n57), .B(n52), .Z(n110) );
  INVERT_D U70 ( .A(n110), .Z(n53) );
  NAND2_D U71 ( .A(n50), .B(n85), .Z(n27) );
  NAND2_E U72 ( .A(n60), .B(n72), .Z(n85) );
  XOR2_D U73 ( .A(n65), .B(n60), .Z(n102) );
  NAND3_C U74 ( .A(n93), .B(n62), .C(n55), .Z(n100) );
  NAND2_D U75 ( .A(n55), .B(n93), .Z(n97) );
  INVERT_H U76 ( .A(n99), .Z(n54) );
  INVERT_I U77 ( .A(n54), .Z(n55) );
  INVERT_H U78 ( .A(sample_rate_q[1]), .Z(n56) );
  INVERT_I U79 ( .A(n56), .Z(n57) );
  INVERT_H U80 ( .A(sample_rate_q[0]), .Z(n58) );
  INVERT_I U81 ( .A(n58), .Z(n59) );
  INVERT_I U82 ( .A(n43), .Z(n60) );
  INVERT_H U83 ( .A(n61), .Z(n62) );
  INVERT_F U84 ( .A(n61), .Z(n63) );
  INVERT_I U85 ( .A(n64), .Z(n65) );
  INVERT_I U86 ( .A(n92), .Z(n66) );
  INVERT_M U87 ( .A(n66), .Z(n67) );
  NOR2_E U88 ( .A(n111), .B(n69), .Z(n92) );
  INVERT_H U89 ( .A(state_current), .Z(n68) );
  BUFFER_F U90 ( .A(n104), .Z(n70) );
  INVERT_I U91 ( .A(n94), .Z(n71) );
  INVERT_N U92 ( .A(n71), .Z(n72) );
  INVERT_F U93 ( .A(n72), .Z(n96) );
  NOR2_E U94 ( .A(new_symbol), .B(n69), .Z(n94) );
  INVERT_H U95 ( .A(n73), .Z(n103) );
  NOR2_D U96 ( .A(n75), .B(n76), .Z(n73) );
  NOR2_C U97 ( .A(n74), .B(n42), .Z(n77) );
  INVERT_E U98 ( .A(n77), .Z(n75) );
  NOR2_C U99 ( .A(n40), .B(n44), .Z(n78) );
  INVERT_E U100 ( .A(n78), .Z(n76) );
  INVERT_I U101 ( .A(n95), .Z(n93) );
  MUX21_E U102 ( .D0(n87), .D1(sample_rate[3]), .SD(rst_n), .Z(n39) );
  INVERT_H U103 ( .A(n79), .Z(n80) );
  INVERT_H U104 ( .A(n91), .Z(n90) );
  NAND2BAL_E U105 ( .A(n81), .B(n82), .Z(n91) );
  AO22_H U106 ( .A1(output_data_2[3]), .A2(n72), .B1(input_data_2[3]), .B2(n67), .Z(n34) );
  AO22_H U107 ( .A1(output_data_2[2]), .A2(n72), .B1(input_data_2[2]), .B2(n67), .Z(n33) );
  AO22_H U108 ( .A1(output_data_2[1]), .A2(n72), .B1(input_data_2[1]), .B2(n67), .Z(n32) );
  AO22_H U109 ( .A1(output_data_2[0]), .A2(n72), .B1(input_data_2[0]), .B2(n67), .Z(n31) );
  AO22_H U110 ( .A1(output_data_1[3]), .A2(n72), .B1(input_data_1[3]), .B2(n67), .Z(n26) );
  AO22_H U111 ( .A1(output_data_1[2]), .A2(n72), .B1(input_data_1[2]), .B2(n67), .Z(n25) );
  AO22_H U112 ( .A1(output_data_1[1]), .A2(n72), .B1(input_data_1[1]), .B2(n67), .Z(n24) );
  AO22_H U113 ( .A1(output_data_1[0]), .A2(n72), .B1(input_data_1[0]), .B2(n67), .Z(n23) );
  OR2_H U114 ( .A(n67), .B(n93), .Z(n35) );
  INVERT_H U115 ( .A(n86), .Z(n87) );
  XNOR2_B U116 ( .A(sample_rate_q[3]), .B(n105), .Z(n104) );
  OR2_H U117 ( .A(sample_count_current[3]), .B(n106), .Z(n105) );
  INVERT_F U118 ( .A(n109), .Z(n88) );
  INVERT_H U119 ( .A(n88), .Z(n89) );
  INVERT_F U120 ( .A(n89), .Z(n106) );
endmodule

