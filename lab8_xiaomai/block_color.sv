module block_color(
					input logic [6:0] shape,	//7 types of shapes
					output logic[7:0]blockRed,
									blockGreen,
									blockBlue
					);

always_comb
begin
	unique case(shape)
		7'b1000000: 	//yellow
			begin
				blockRed = 8'hff;
				blockGreen = 8'hff;
				blockBlue = 8'h00;
			end

		7'b0100000: 	//red
			begin
				blockRed = 8'hcd;
				blockGreen = 8'h37;
				blockBlue = 8'h00;
			end

		7'b0010000: 	//blue
			begin
				blockRed = 8'h00;
				blockGreen = 8'h3e;
				blockBlue = 8'hff;
			end

		7'b0001000: 	//green
			begin
				blockRed = 8'h00;
				blockGreen = 8'hcd;
				blockBlue = 8'h00;
			end

		7'b0000100: 	//oragnge
			begin
				blockRed = 8'he4;
				blockGreen = 8'h7b;
				blockBlue = 8'h33;
			end

		7'b0000010: 	//pink
			begin
				blockRed = 8'hff;
				blockGreen = 8'h69;
				blockBlue = 8'hb4;
			end

		7'b0000001: 	//purple
			begin
				blockRed = 8'h89;
				blockGreen = 8'h68;
				blockBlue = 8'hcd;
			end

		default: 	//white
			begin
				blockRed = 8'hff;
				blockGreen = 8'hff;
				blockBlue = 8'hff;
			end
	endcase

end
endmodule