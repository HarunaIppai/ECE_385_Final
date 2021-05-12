module Adder (
					input  logic reset,
					input  logic add_en,
               input  logic [4:0] Data_In,
               output logic [4:0] Data_Out
		);
		always_comb begin
			if (reset) 
				Data_Out = 5'b0;
			else if (add_en)
				Data_Out = Data_In + 5'b1;
			else
				Data_Out = Data_In;
		end
		
endmodule 