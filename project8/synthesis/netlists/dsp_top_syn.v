/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Sat Apr 12 23:02:05 2025
/////////////////////////////////////////////////////////////


module dsp_top_syn ( clk, rst_n, sample_rate, data_in_i, data_in_q, coeff_rw, 
        msg_in, coeff_in, coeff_addr, new_symbol, I_out, Q_out, coeff_read_out
 );
  input [3:0] sample_rate;
  input [3:0] data_in_i;
  input [3:0] data_in_q;
  input [7:0] coeff_in;
  input [9:0] coeff_addr;
  output [9:0] I_out;
  output [9:0] Q_out;
  output [7:0] coeff_read_out;
  input clk, rst_n, coeff_rw, msg_in, new_symbol;
  wire   n306, n307, n308, n309, n310, n311, data_out_valid, N55, N56, N57,
         N58, N59, N60, N61, N72, n40, n41, n42, n43, n44, n45, n46, n47, n48,
         n49, n50, n51, n52, n53, n54, n56, n58, n84, n85, \sub_35/carry[9] ,
         \r107/PROD_not[0] , \r107/PROD_not[1] , \r107/PROD_not[2] ,
         \r107/PROD_not[3] , \r107/PROD_not[4] , \r107/PROD_not[5] ,
         \r107/PROD_not[6] , \r107/PROD_not[7] , \r107/PROD_not[8] ,
         \r107/PROD_not[9] , \r104/PROD_not[0] , \r104/PROD_not[1] ,
         \r104/PROD_not[2] , \r104/PROD_not[3] , \r104/PROD_not[4] ,
         \r104/PROD_not[5] , \r104/PROD_not[6] , \r104/PROD_not[7] ,
         \r104/PROD_not[8] , \r104/PROD_not[9] , n86, n87, n88, n89, n90, n91,
         n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104,
         n105, n106, n107, n108, n109, n110, n111, n112, n113, n114, n115,
         n116, n117, n118, n119, n120, n121, n122, n123, n124, n125, n126,
         n127, n128, n129, n130, n131, n132, n133, n134, n135, n136, n137,
         n138, n139, n140, n141, n142, n143, n144, n145, n147, n149, n151,
         n153, n155, n157, n159, n160, n161, n163, n164, n165, n166, n167,
         n168, n169, n170, n171, n172, n173, n174, n175, n176, n177, n178,
         n179, n180, n181, n182, n183, n184, n185, n186, n187, n188, n189,
         n190, n191, n192, n193, n194, n196, n198, n200, n202, n204, n206,
         n208, n210, n212, n214, n216, n218, n219, n220, n221, n222, n223,
         n224, n225, n226, n227, n228, n229, n230, n231, n232, n233, n234,
         n235, n236, n237, n238, n239, n240, n241, n242, n243, n244, n245,
         n246, n247, n248, n249, n250, n251, n252, n253, n254, n255, n256,
         n257, n258, n259, n260, n261, n262, n263, n264, n265, n266, n267,
         n268, n269, n270, n271, n272, n273, n274, n275, n276, n277, n278,
         n279, n280, n281, n282, n283, n284, n285, n286, n287, n288, n289,
         n290, n291, n292, n293, n294, n295, n296, n297, n298, n299, n300,
         n301, n302, n303, n304, n305;
  wire   [7:0] counter;
  wire   [1:0] state;
  tri   clk;
  tri   rst_n;
  tri   [3:0] sample_rate;
  tri   [3:0] data_in_i;
  tri   [3:0] data_in_q;
  tri   [7:0] coeff_in;
  tri   new_symbol;
  tri   [9:0] coeff_i_addr;
  tri   [9:0] coeff_q_addr;
  tri   coeff_read;
  tri   coeff_write;
  tri   [11:0] filter_out_i;
  tri   [7:0] coeff_read_out_i;
  tri   [11:0] filter_out_q;
  tri   [7:0] coeff_read_out_q;
  tri   N44;
  tri   \upsampler_out_q[3] ;
  tri   \upsampler_out_q[2] ;
  tri   \upsampler_out_q[1] ;
  tri   \upsampler_out_q[0] ;
  tri   \upsampler_out_i[3] ;
  tri   \upsampler_out_i[2] ;
  tri   \upsampler_out_i[1] ;
  tri   \upsampler_out_i[0] ;
  tri   \filter_out_q[1] ;
  tri   \filter_out_q[0] ;
  tri   \filter_out_i[1] ;
  tri   \filter_out_i[0] ;

  OAI22_C U95 ( .A1(1'b1), .A2(n121), .B1(n113), .B2(n302), .Z(coeff_write) );
  reset_synchronization rst ( .clk(clk), .rst_n(rst_n), .rst_n_sync(N44) );
  upsampler u_upsampler ( .clk(clk), .rst_n(N44), .sample_rate(sample_rate), 
        .new_symbol(new_symbol), .input_data_1(data_in_i), .input_data_2(
        data_in_q), .output_data_1({\upsampler_out_i[3] , \upsampler_out_i[2] , 
        \upsampler_out_i[1] , \upsampler_out_i[0] }), .output_data_2({
        \upsampler_out_q[3] , \upsampler_out_q[2] , \upsampler_out_q[1] , 
        \upsampler_out_q[0] }) );
  fir_filter i_fir_filter ( .clk(clk), .sample_in({\upsampler_out_i[3] , 
        \upsampler_out_i[2] , \upsampler_out_i[1] , \upsampler_out_i[0] }), 
        .coeff_read(coeff_read), .coeff_write(coeff_write), .coeff_in(coeff_in), .coeff_addr(coeff_i_addr), .fir_out({filter_out_i[11:2], \filter_out_i[1] , 
        \filter_out_i[0] }), .coeff_read_out(coeff_read_out_i) );
  fir_filter q_fir_filter ( .clk(clk), .sample_in({\upsampler_out_q[3] , 
        \upsampler_out_q[2] , \upsampler_out_q[1] , \upsampler_out_q[0] }), 
        .coeff_read(coeff_read), .coeff_write(coeff_write), .coeff_in(coeff_in), .coeff_addr(coeff_q_addr), .fir_out({filter_out_q[11:2], \filter_out_q[1] , 
        \filter_out_q[0] }), .coeff_read_out(coeff_read_out_q) );
  OAI22_A U96 ( .A1(1'b1), .A2(n303), .B1(n246), .B2(n100), .Z(coeff_i_addr[9]) );
  OAI22_A U97 ( .A1(1'b1), .A2(n303), .B1(n246), .B2(n101), .Z(coeff_i_addr[8]) );
  DFFR_E \counter_reg[3]  ( .D(n43), .CLK(clk), .RN(N44), .Q(counter[3]), 
        .QBAR(n258) );
  DFFR_E \counter_reg[4]  ( .D(n44), .CLK(clk), .RN(N44), .Q(counter[4]), 
        .QBAR(n250) );
  DFFR_E \counter_reg[2]  ( .D(n42), .CLK(clk), .RN(N44), .Q(counter[2]), 
        .QBAR(n248) );
  OAI22_B U106 ( .A1(1'b1), .A2(n304), .B1(n253), .B2(n102), .Z(
        coeff_q_addr[9]) );
  OAI22_B U115 ( .A1(1'b1), .A2(n304), .B1(n305), .B2(n253), .Z(
        coeff_q_addr[0]) );
  DFFR_E \counter_reg[6]  ( .D(n46), .CLK(clk), .RN(N44), .Q(counter[6]), 
        .QBAR(n242) );
  DFFR_E \state_reg[0]  ( .D(n159), .CLK(clk), .RN(N44), .Q(state[0]), .QBAR(
        n240) );
  DFFR_E \counter_reg[5]  ( .D(n45), .CLK(clk), .RN(N44), .Q(counter[5]), 
        .QBAR(n259) );
  OAI22_B U114 ( .A1(1'b1), .A2(n304), .B1(n253), .B2(n295), .Z(
        coeff_q_addr[1]) );
  OAI22_B U105 ( .A1(1'b1), .A2(n303), .B1(n305), .B2(n246), .Z(
        coeff_i_addr[0]) );
  DFFR_E \counter_reg[1]  ( .D(n41), .CLK(clk), .RN(N44), .QBAR(n89) );
  DFFR_E \counter_reg[0]  ( .D(n50), .CLK(clk), .RN(N44), .Q(counter[0]), 
        .QBAR(n247) );
  DFFR_E data_out_valid_reg ( .D(n40), .CLK(clk), .RN(N44), .Q(data_out_valid), 
        .QBAR(n91) );
  DFF_E \coeff_read_out_reg[0]  ( .D(n51), .CLK(clk), .Q(n99), .QBAR(n218) );
  OAI22_E U94 ( .A1(1'b1), .A2(n121), .B1(n114), .B2(n302), .Z(coeff_read) );
  OAI22_B U98 ( .A1(1'b1), .A2(n303), .B1(n246), .B2(n123), .Z(coeff_i_addr[7]) );
  OAI22_B U107 ( .A1(1'b1), .A2(n304), .B1(n253), .B2(n125), .Z(
        coeff_q_addr[8]) );
  OAI22_B U99 ( .A1(1'b1), .A2(n303), .B1(n246), .B2(n297), .Z(coeff_i_addr[6]) );
  OAI22_B U103 ( .A1(1'b1), .A2(n303), .B1(n246), .B2(n301), .Z(
        coeff_i_addr[2]) );
  OAI22_B U104 ( .A1(1'b1), .A2(n303), .B1(n246), .B2(n295), .Z(
        coeff_i_addr[1]) );
  OAI22_B U109 ( .A1(1'b1), .A2(n304), .B1(n253), .B2(n297), .Z(
        coeff_q_addr[6]) );
  OAI22_B U113 ( .A1(1'b1), .A2(n304), .B1(n253), .B2(n301), .Z(
        coeff_q_addr[2]) );
  OAI22_B U108 ( .A1(1'b1), .A2(n304), .B1(n253), .B2(n296), .Z(
        coeff_q_addr[7]) );
  OAI22_B U101 ( .A1(1'b1), .A2(n303), .B1(n246), .B2(n299), .Z(
        coeff_i_addr[4]) );
  OAI22_B U111 ( .A1(1'b1), .A2(n304), .B1(n253), .B2(n299), .Z(
        coeff_q_addr[4]) );
  OAI22_B U102 ( .A1(1'b1), .A2(n303), .B1(n246), .B2(n300), .Z(
        coeff_i_addr[3]) );
  OAI22_B U112 ( .A1(1'b1), .A2(n304), .B1(n253), .B2(n300), .Z(
        coeff_q_addr[3]) );
  DFF_E \coeff_read_out_reg[1]  ( .D(n52), .CLK(clk), .Q(n98), .QBAR(n220) );
  DFF_E \coeff_read_out_reg[2]  ( .D(n53), .CLK(clk), .Q(n97), .QBAR(n222) );
  DFF_E \coeff_read_out_reg[7]  ( .D(n58), .CLK(clk), .Q(n95), .QBAR(n232) );
  DFF_E \coeff_read_out_reg[5]  ( .D(n56), .CLK(clk), .Q(n96), .QBAR(n228) );
  DFF_E \coeff_read_out_reg[6]  ( .D(n87), .CLK(clk), .Q(n94), .QBAR(n230) );
  DFF_E \coeff_read_out_reg[4]  ( .D(n86), .CLK(clk), .Q(n93), .QBAR(n226) );
  DFF_E \coeff_read_out_reg[3]  ( .D(n131), .CLK(clk), .Q(n92), .QBAR(n224) );
  DFFR_E \counter_reg[7]  ( .D(n49), .CLK(clk), .RN(N44), .QBAR(n90) );
  DFFR_E \state_reg[1]  ( .D(n47), .CLK(clk), .RN(N44), .Q(state[1]), .QBAR(
        n262) );
  OAI22_B U100 ( .A1(1'b1), .A2(n303), .B1(n246), .B2(n298), .Z(
        coeff_i_addr[5]) );
  OAI22_B U110 ( .A1(1'b1), .A2(n304), .B1(n253), .B2(n298), .Z(
        coeff_q_addr[5]) );
  BUFFER_J U117 ( .A(data_out_valid), .Z(n270) );
  INVERT_E U118 ( .A(n128), .Z(n178) );
  INVERT_E U119 ( .A(n138), .Z(n182) );
  INVERT_E U120 ( .A(n186), .Z(n184) );
  INVERT_E U121 ( .A(n126), .Z(n174) );
  INVERT_E U122 ( .A(n127), .Z(n176) );
  INVERT_D U123 ( .A(state[0]), .Z(n266) );
  INVERT_H U124 ( .A(coeff_addr[0]), .Z(n103) );
  INVERT_H U125 ( .A(coeff_addr[2]), .Z(n108) );
  INVERT_M U126 ( .A(N44), .Z(n280) );
  INVERT_H U127 ( .A(new_symbol), .Z(n115) );
  INVERT_I U128 ( .A(coeff_addr[5]), .Z(n298) );
  INVERT_I U129 ( .A(n142), .Z(n287) );
  INVERT_J U130 ( .A(n311), .Z(n216) );
  INVERT_J U131 ( .A(n180), .Z(n214) );
  INVERT_J U132 ( .A(n181), .Z(n212) );
  INVERT_J U133 ( .A(n310), .Z(n210) );
  INVERT_J U134 ( .A(n309), .Z(n208) );
  INVERT_J U135 ( .A(n170), .Z(n206) );
  INVERT_J U136 ( .A(n171), .Z(n204) );
  INVERT_J U137 ( .A(n172), .Z(n202) );
  INVERT_J U138 ( .A(n173), .Z(n200) );
  INVERT_J U139 ( .A(n308), .Z(n198) );
  INVERT_J U140 ( .A(n307), .Z(n196) );
  INVERT_J U141 ( .A(n306), .Z(n194) );
  INVERT_H U142 ( .A(n279), .Z(n167) );
  INVERT_D U143 ( .A(n54), .Z(n131) );
  AO222_F U144 ( .A1(coeff_read_out_q[4]), .A2(n234), .B1(coeff_read_out_i[4]), 
        .B2(n130), .C1(n280), .C2(n93), .Z(n86) );
  AO222_F U145 ( .A1(coeff_read_out_q[6]), .A2(n234), .B1(coeff_read_out_i[6]), 
        .B2(n130), .C1(n280), .C2(n94), .Z(n87) );
  INVERT_H U146 ( .A(n264), .Z(n139) );
  INVERT_K U147 ( .A(n263), .Z(n264) );
  INVERT_H U148 ( .A(\r107/PROD_not[6] ), .Z(n181) );
  INVERT_H U149 ( .A(\r104/PROD_not[4] ), .Z(n171) );
  INVERT_H U150 ( .A(\r104/PROD_not[3] ), .Z(n170) );
  INVERT_H U151 ( .A(\r104/PROD_not[6] ), .Z(n173) );
  INVERT_H U152 ( .A(\r107/PROD_not[5] ), .Z(n180) );
  INVERT_H U153 ( .A(\r104/PROD_not[5] ), .Z(n172) );
  INVERT_K U154 ( .A(n270), .Z(n236) );
  INVERT_M U155 ( .A(n236), .Z(n237) );
  NAND3_D U156 ( .A(N44), .B(n303), .C(coeff_read), .Z(n88) );
  AO21_F U157 ( .A1(n256), .A2(n116), .B(n292), .Z(n286) );
  INVERT_I U158 ( .A(n191), .Z(n192) );
  INVERT_I U159 ( .A(n262), .Z(n191) );
  XNOR2_C U160 ( .A(n271), .B(counter[2]), .Z(N56) );
  INVERT_J U161 ( .A(n225), .Z(n149) );
  INVERT_J U162 ( .A(n227), .Z(n151) );
  INVERT_J U163 ( .A(n231), .Z(n155) );
  INVERT_J U164 ( .A(n233), .Z(n157) );
  INVERT_J U165 ( .A(n229), .Z(n153) );
  INVERT_J U166 ( .A(n223), .Z(n147) );
  INVERT_J U167 ( .A(n221), .Z(n145) );
  INVERT_J U168 ( .A(n219), .Z(n161) );
  XOR2_C U169 ( .A(n119), .B(\sub_35/carry[9] ), .Z(n100) );
  XOR2_C U170 ( .A(n123), .B(n125), .Z(n101) );
  XOR2_C U171 ( .A(n119), .B(n125), .Z(n102) );
  INVERT_H U172 ( .A(n103), .Z(n104) );
  INVERT_H U173 ( .A(coeff_addr[1]), .Z(n105) );
  INVERT_H U174 ( .A(n105), .Z(n106) );
  INVERT_F U175 ( .A(n105), .Z(n107) );
  INVERT_H U176 ( .A(n108), .Z(n109) );
  INVERT_H U177 ( .A(coeff_addr[6]), .Z(n110) );
  INVERT_H U178 ( .A(n110), .Z(n111) );
  INVERT_F U179 ( .A(n110), .Z(n112) );
  INVERT_H U180 ( .A(coeff_rw), .Z(n113) );
  INVERT_F U181 ( .A(n113), .Z(n114) );
  INVERT_H U182 ( .A(n115), .Z(n116) );
  INVERT_H U183 ( .A(coeff_addr[9]), .Z(n117) );
  INVERT_H U184 ( .A(n117), .Z(n118) );
  INVERT_F U185 ( .A(n117), .Z(n119) );
  INVERT_H U186 ( .A(msg_in), .Z(n120) );
  INVERT_K U187 ( .A(n120), .Z(n121) );
  INVERT_H U188 ( .A(coeff_addr[7]), .Z(n122) );
  INVERT_K U189 ( .A(n122), .Z(n123) );
  INVERT_H U190 ( .A(coeff_addr[8]), .Z(n124) );
  INVERT_L U191 ( .A(n124), .Z(n125) );
  NAND2BAL_E U192 ( .A(filter_out_i[5]), .B(n133), .Z(\r104/PROD_not[3] ) );
  NAND2_E U193 ( .A(filter_out_i[6]), .B(n132), .Z(\r104/PROD_not[4] ) );
  NAND2BAL_E U194 ( .A(filter_out_i[7]), .B(n132), .Z(\r104/PROD_not[5] ) );
  AND2_H U195 ( .A(filter_out_i[9]), .B(n135), .Z(\r104/PROD_not[7] ) );
  INVERT_D U196 ( .A(\r104/PROD_not[7] ), .Z(n126) );
  AND2_H U197 ( .A(filter_out_i[10]), .B(n135), .Z(\r104/PROD_not[8] ) );
  INVERT_D U198 ( .A(\r104/PROD_not[8] ), .Z(n127) );
  AND2_H U199 ( .A(filter_out_q[6]), .B(n135), .Z(\r107/PROD_not[4] ) );
  INVERT_D U200 ( .A(\r107/PROD_not[4] ), .Z(n128) );
  NAND2BAL_E U201 ( .A(filter_out_q[7]), .B(n135), .Z(\r107/PROD_not[5] ) );
  NAND2BAL_E U202 ( .A(filter_out_i[8]), .B(n133), .Z(\r104/PROD_not[6] ) );
  INVERT_K U203 ( .A(n236), .Z(n133) );
  AOI222_I U204 ( .A1(coeff_read_out_q[3]), .A2(n234), .B1(coeff_read_out_i[3]), .B2(n130), .C1(n280), .C2(n92), .Z(n54) );
  AO22_F U205 ( .A1(n245), .A2(n238), .B1(N59), .B2(n140), .Z(n45) );
  INVERT_I U206 ( .A(n235), .Z(n129) );
  INVERT_M U207 ( .A(n129), .Z(n130) );
  INVERT_H U208 ( .A(n88), .Z(n235) );
  AO222_F U209 ( .A1(coeff_read_out_q[7]), .A2(n234), .B1(coeff_read_out_i[7]), 
        .B2(n130), .C1(n280), .C2(n95), .Z(n58) );
  AO222_F U210 ( .A1(coeff_read_out_q[5]), .A2(n234), .B1(coeff_read_out_i[5]), 
        .B2(n130), .C1(n280), .C2(n96), .Z(n56) );
  INVERT_L U211 ( .A(n167), .Z(n234) );
  AO222_F U212 ( .A1(coeff_read_out_q[2]), .A2(n234), .B1(coeff_read_out_i[2]), 
        .B2(n130), .C1(n280), .C2(n97), .Z(n53) );
  AO222_F U213 ( .A1(coeff_read_out_q[1]), .A2(n234), .B1(coeff_read_out_i[1]), 
        .B2(n130), .C1(n280), .C2(n98), .Z(n52) );
  OAI21_C U214 ( .A1(n288), .A2(n137), .B(n294), .Z(n40) );
  OAI21_C U215 ( .A1(n256), .A2(n291), .B(n133), .Z(n294) );
  AO22_F U216 ( .A1(n245), .A2(n188), .B1(n247), .B2(n140), .Z(n50) );
  INVERT_J U217 ( .A(n91), .Z(n132) );
  INVERT_K U218 ( .A(n237), .Z(n134) );
  INVERT_K U219 ( .A(n134), .Z(n135) );
  INVERT_M U220 ( .A(n134), .Z(n136) );
  AND2_H U221 ( .A(n287), .B(n192), .Z(n293) );
  INVERT_D U222 ( .A(n293), .Z(n137) );
  AND2_H U223 ( .A(filter_out_q[9]), .B(n136), .Z(\r107/PROD_not[7] ) );
  INVERT_D U224 ( .A(\r107/PROD_not[7] ), .Z(n138) );
  XNOR2_C U225 ( .A(n193), .B(n247), .Z(N55) );
  AO22_F U226 ( .A1(n245), .A2(n193), .B1(N55), .B2(n140), .Z(n41) );
  AOI21_B U227 ( .A1(n116), .A2(n256), .B(n291), .Z(n289) );
  INVERT_I U228 ( .A(n255), .Z(n256) );
  BUFFER_J U229 ( .A(n272), .Z(n261) );
  NAND3_D U230 ( .A(n193), .B(n188), .C(n249), .Z(n272) );
  INVERT_I U231 ( .A(n139), .Z(n140) );
  NOR2_C U232 ( .A(n260), .B(n258), .Z(n273) );
  INVERT_H U233 ( .A(N72), .Z(n141) );
  INVERT_H U234 ( .A(n141), .Z(n142) );
  INVERT_H U235 ( .A(counter[6]), .Z(n143) );
  INVERT_H U236 ( .A(n143), .Z(n144) );
  INVERT_O U237 ( .A(n145), .Z(coeff_read_out[1]) );
  INVERT_O U238 ( .A(n147), .Z(coeff_read_out[2]) );
  INVERT_O U239 ( .A(n149), .Z(coeff_read_out[3]) );
  INVERT_O U240 ( .A(n151), .Z(coeff_read_out[4]) );
  INVERT_O U241 ( .A(n153), .Z(coeff_read_out[5]) );
  INVERT_O U242 ( .A(n155), .Z(coeff_read_out[6]) );
  INVERT_O U243 ( .A(n157), .Z(coeff_read_out[7]) );
  INVERT_J U244 ( .A(n89), .Z(n193) );
  XNOR2_C U245 ( .A(n190), .B(n238), .Z(N59) );
  XOR2_B U246 ( .A(n239), .B(n276), .Z(N61) );
  AND3_I U247 ( .A(N44), .B(n304), .C(coeff_read), .Z(n279) );
  OA21_F U248 ( .A1(n287), .A2(n288), .B(n289), .Z(n48) );
  INVERT_D U249 ( .A(n48), .Z(n159) );
  BUFFER_F U250 ( .A(N57), .Z(n160) );
  XNOR2_B U251 ( .A(n277), .B(n258), .Z(N57) );
  INVERT_O U252 ( .A(n161), .Z(coeff_read_out[0]) );
  AO222_F U253 ( .A1(coeff_read_out_q[0]), .A2(n234), .B1(coeff_read_out_i[0]), 
        .B2(n130), .C1(n280), .C2(n99), .Z(n51) );
  NOR2_C U254 ( .A(state[0]), .B(n245), .Z(n290) );
  AO22_F U255 ( .A1(n245), .A2(n239), .B1(N61), .B2(n140), .Z(n49) );
  AO22_F U256 ( .A1(n245), .A2(n243), .B1(N60), .B2(n264), .Z(n46) );
  AO22_F U257 ( .A1(n245), .A2(counter[4]), .B1(N58), .B2(n264), .Z(n44) );
  AO22_F U258 ( .A1(n245), .A2(counter[3]), .B1(n160), .B2(n264), .Z(n43) );
  NAND2_E U259 ( .A(n163), .B(n164), .Z(n284) );
  NAND2BAL_E U260 ( .A(n285), .B(n300), .Z(n165) );
  INVERT_F U261 ( .A(n165), .Z(n163) );
  NAND2BAL_E U262 ( .A(n299), .B(n298), .Z(n166) );
  INVERT_H U263 ( .A(n166), .Z(n164) );
  INVERT_I U264 ( .A(coeff_addr[3]), .Z(n300) );
  INVERT_I U265 ( .A(coeff_addr[4]), .Z(n299) );
  XOR2_C U266 ( .A(n251), .B(n273), .Z(N58) );
  NAND2BAL_E U267 ( .A(n193), .B(n188), .Z(n271) );
  INVERT_I U268 ( .A(n187), .Z(n188) );
  OR2_I U269 ( .A(n144), .B(n238), .Z(n278) );
  BUFFER_L U270 ( .A(counter[5]), .Z(n238) );
  NAND3_D U271 ( .A(n109), .B(n106), .C(n104), .Z(n285) );
  NAND2_E U272 ( .A(filter_out_q[8]), .B(n136), .Z(\r107/PROD_not[6] ) );
  INVERT_H U273 ( .A(\r107/PROD_not[3] ), .Z(n168) );
  INVERT_J U274 ( .A(n168), .Z(n169) );
  NAND2_E U275 ( .A(filter_out_q[5]), .B(n136), .Z(\r107/PROD_not[3] ) );
  INVERT_E U276 ( .A(n174), .Z(n175) );
  INVERT_E U277 ( .A(n176), .Z(n177) );
  NAND2_E U278 ( .A(n237), .B(filter_out_i[11]), .Z(\r104/PROD_not[9] ) );
  INVERT_E U279 ( .A(n178), .Z(n179) );
  INVERT_E U280 ( .A(n182), .Z(n183) );
  INVERT_E U281 ( .A(n184), .Z(n185) );
  AND2_H U282 ( .A(filter_out_q[10]), .B(n136), .Z(\r107/PROD_not[8] ) );
  INVERT_D U283 ( .A(\r107/PROD_not[8] ), .Z(n186) );
  INVERT_H U284 ( .A(n286), .Z(n263) );
  INVERT_H U285 ( .A(counter[0]), .Z(n187) );
  INVERT_E U286 ( .A(n274), .Z(n189) );
  INVERT_H U287 ( .A(n189), .Z(n190) );
  INVERT_O U288 ( .A(n194), .Z(I_out[9]) );
  INVERT_F U289 ( .A(\r104/PROD_not[9] ), .Z(n306) );
  INVERT_O U290 ( .A(n196), .Z(I_out[8]) );
  INVERT_F U291 ( .A(n177), .Z(n307) );
  INVERT_O U292 ( .A(n198), .Z(I_out[7]) );
  INVERT_F U293 ( .A(n175), .Z(n308) );
  INVERT_O U294 ( .A(n200), .Z(I_out[6]) );
  INVERT_O U295 ( .A(n202), .Z(I_out[5]) );
  INVERT_O U296 ( .A(n204), .Z(I_out[4]) );
  INVERT_O U297 ( .A(n206), .Z(I_out[3]) );
  INVERT_O U298 ( .A(\r104/PROD_not[2] ), .Z(I_out[2]) );
  NAND2BAL_J U299 ( .A(filter_out_i[4]), .B(n237), .Z(\r104/PROD_not[2] ) );
  INVERT_O U300 ( .A(\r104/PROD_not[1] ), .Z(I_out[1]) );
  NAND2BAL_J U301 ( .A(filter_out_i[3]), .B(n133), .Z(\r104/PROD_not[1] ) );
  INVERT_O U302 ( .A(\r104/PROD_not[0] ), .Z(I_out[0]) );
  NAND2BAL_J U303 ( .A(filter_out_i[2]), .B(n237), .Z(\r104/PROD_not[0] ) );
  INVERT_O U304 ( .A(\r107/PROD_not[9] ), .Z(Q_out[9]) );
  NAND2BAL_J U305 ( .A(n132), .B(filter_out_q[11]), .Z(\r107/PROD_not[9] ) );
  INVERT_O U306 ( .A(n208), .Z(Q_out[8]) );
  INVERT_F U307 ( .A(n185), .Z(n309) );
  INVERT_O U308 ( .A(n210), .Z(Q_out[7]) );
  INVERT_F U309 ( .A(n183), .Z(n310) );
  INVERT_O U310 ( .A(n212), .Z(Q_out[6]) );
  INVERT_O U311 ( .A(n214), .Z(Q_out[5]) );
  INVERT_O U312 ( .A(n216), .Z(Q_out[4]) );
  INVERT_F U313 ( .A(n179), .Z(n311) );
  INVERT_O U314 ( .A(n169), .Z(Q_out[3]) );
  INVERT_O U315 ( .A(\r107/PROD_not[2] ), .Z(Q_out[2]) );
  NAND2BAL_J U316 ( .A(filter_out_q[4]), .B(n135), .Z(\r107/PROD_not[2] ) );
  INVERT_O U317 ( .A(\r107/PROD_not[1] ), .Z(Q_out[1]) );
  NAND2BAL_J U318 ( .A(filter_out_q[3]), .B(n136), .Z(\r107/PROD_not[1] ) );
  INVERT_O U319 ( .A(\r107/PROD_not[0] ), .Z(Q_out[0]) );
  NAND2BAL_J U320 ( .A(filter_out_q[2]), .B(n136), .Z(\r107/PROD_not[0] ) );
  INVERT_H U321 ( .A(n218), .Z(n219) );
  INVERT_H U322 ( .A(n220), .Z(n221) );
  INVERT_H U323 ( .A(n222), .Z(n223) );
  INVERT_H U324 ( .A(n224), .Z(n225) );
  INVERT_H U325 ( .A(n226), .Z(n227) );
  INVERT_H U326 ( .A(n228), .Z(n229) );
  INVERT_H U327 ( .A(n230), .Z(n231) );
  INVERT_H U328 ( .A(n232), .Z(n233) );
  XOR2_B U329 ( .A(n243), .B(n275), .Z(N60) );
  NOR2_E U330 ( .A(n259), .B(n190), .Z(n275) );
  INVERT_H U331 ( .A(n118), .Z(n283) );
  INVERT_I U332 ( .A(n90), .Z(n239) );
  INVERT_J U333 ( .A(n269), .Z(n252) );
  BUFFER_J U334 ( .A(n85), .Z(n269) );
  BUFFER_L U335 ( .A(n281), .Z(n254) );
  INVERT_I U336 ( .A(n240), .Z(n241) );
  INVERT_H U337 ( .A(n242), .Z(n243) );
  AO22_F U338 ( .A1(n245), .A2(counter[2]), .B1(N56), .B2(n264), .Z(n42) );
  INVERT_O U339 ( .A(n252), .Z(n253) );
  INVERT_N U340 ( .A(n253), .Z(n304) );
  OR2_J U341 ( .A(n123), .B(n125), .Z(\sub_35/carry[9] ) );
  INVERT_I U342 ( .A(state[1]), .Z(n244) );
  INVERT_M U343 ( .A(n244), .Z(n245) );
  INVERT_F U344 ( .A(n260), .Z(n277) );
  BUFFER_J U345 ( .A(n261), .Z(n260) );
  AO21_D U346 ( .A1(n287), .A2(n241), .B(n291), .Z(n47) );
  INVERT_J U347 ( .A(n84), .Z(n268) );
  INVERT_O U348 ( .A(n268), .Z(n246) );
  NAND4_D U349 ( .A(n254), .B(n123), .C(n282), .D(n283), .Z(n84) );
  INVERT_H U350 ( .A(n125), .Z(n282) );
  NAND2_E U351 ( .A(n284), .B(n111), .Z(n281) );
  INVERT_N U352 ( .A(n246), .Z(n303) );
  OAI21_D U353 ( .A1(n251), .A2(n278), .B(n239), .Z(N72) );
  INVERT_H U354 ( .A(n248), .Z(n249) );
  INVERT_H U355 ( .A(n250), .Z(n251) );
  NAND4_C U356 ( .A(n125), .B(n254), .C(n296), .D(n283), .Z(n85) );
  INVERT_F U357 ( .A(n257), .Z(n255) );
  BUFFER_H U358 ( .A(n290), .Z(n257) );
  AND2_H U359 ( .A(n275), .B(n144), .Z(n276) );
  NAND3_C U360 ( .A(counter[3]), .B(n277), .C(counter[4]), .Z(n274) );
  INVERT_H U361 ( .A(n123), .Z(n296) );
  INVERT_I U362 ( .A(n241), .Z(n288) );
  INVERT_H U363 ( .A(n112), .Z(n297) );
  INVERT_H U364 ( .A(n109), .Z(n301) );
  INVERT_H U365 ( .A(n107), .Z(n295) );
  INVERT_H U366 ( .A(n104), .Z(n305) );
  INVERT_I U367 ( .A(n121), .Z(n302) );
  NOR2_F U368 ( .A(n192), .B(n288), .Z(n291) );
  NOR2_D U369 ( .A(n141), .B(n265), .Z(n292) );
  NOR2_C U370 ( .A(n266), .B(n191), .Z(n267) );
  INVERT_E U371 ( .A(n267), .Z(n265) );
endmodule

