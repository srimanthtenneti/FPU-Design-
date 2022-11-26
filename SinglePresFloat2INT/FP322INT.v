// ******************************************************
// Author : Srimanth Tenneti 
// Date : 11/25/2022
// Rev : 0.01
// Description : 32 bit Floating point to 32 bit Integer
// ******************************************************

module FP2INT (
  input [31:0] FP32,
  input rst,
  output reg [31:0] INT32
); 
  
 // Temporary Variables
 reg rst;
 reg [55:0] temp0;
 reg [55:0] temp1;
  
 reg s;
 reg hidden; 
  reg [8:0] shift; 
  
  // Main Logic
  
  always @ *
    begin 
      if (rst) 
        begin
           INT32 = 0; 
           hidden = 0; 
           s = 0;
           shift = 0;
        end
       
      else 
        begin
          // Sign Logic
          s = FP32[31];
          // Hidden Logic - 1fa part
          hidden = |FP32[30:22]; 
          // Shift logic
          shift = 9'd158 - {1'b0, FP32[30:23]};
          // Final Shift Fraction to adjust decimal point
          temp0 = {hidden, FP32[22:0], 32'h0};
          // Shifting 
          temp1 = ($signed(shift) > 9'd32) ?  temp0 >> 9'd32 : temp0 >> shift; 
          // Integer Generation 
          INT32 = (s) ? ~temp1[55:24] + 32'd1 : temp1[55:24]; 
        end
    end
endmodule 
  
  
  
  
