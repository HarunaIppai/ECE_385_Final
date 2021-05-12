module Reg_24 (input  logic Clk, Reset, Shift_In, Load, Shift_En,
              input  logic [23:0]  D,
              output logic Shift_Out,
              output logic [23:0]  Data_Out);

    always_ff @ (posedge Clk)
    begin
	 	 if (Reset) //notice, this is a sycnrhonous reset, which is recommended on the FPGA
			  Data_Out <= 24'h0;
		 else if (Load)
			  Data_Out <= D;
		 else if (Shift_En)
			  Data_Out <= { Data_Out[22:0], Shift_In }; 
    end
	
    assign Shift_Out = Data_Out[23];

endmodule
