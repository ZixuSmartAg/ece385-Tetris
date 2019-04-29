module background(
				input logic 	[9:0] DrawX, DrawY,
				input logic 	is_shape, is_boundary,
				input 	[6:0] field_color[19:0][9:0], 	
				output logic 	is_background,
				output logic 	[7:0] backRed, backGreen, backBlue
				);

parameter size = 10'd24;	//size of a pixel
parameter offsetleft = 10'd200;		//offseting the wall
parameter offsetleftwall = 10'd190;
parameter offsetright = 10'd440;

logic [6:0]	bottomShape;
logic [7:0] blockRed, blockGreen, blockBlue;

block_color blockscolor(.shape(bottomShape),.blockRed(blockRed),.blockGreen(blockGreen),.blockBlue(blockBlue));

always_comb
begin

	if((DrawX - offsetleftwall >= 0  && DrawX - offsetleftwall < 10) || (DrawX - offsetright >= 0 && DrawX - offsetright < 10))
		begin		//sky blue two side wall
			is_background = 1'b1;
			backRed = 8'h87;
			backGreen = 8'hCE;
			backBlue = 8'hEB;
			bottomShape = 7'h00;
		end
	else if(~is_shape && ~is_boundary && DrawX < 439 && DrawX > 200)
		begin
			for(int i = 19; i > 0; i--)
			begin
				for(int j = 0; j < 9; j++)
				begin
					if((DrawX - offsetleft < (j + 1) * size) && (DrawX - offsetleft > j * size) && (DrawY > (i-1) * size) && (DrawY < i * size))
						begin
							bottomShape = field_color[i][j];
							backRed = blockRed;
							backGreen = blockGreen;
							backBlue = blockBlue;
							is_background = 1'b1;
						end
				end
			end

			//inside the field, black
			bottomShape = 7'h00;
			backRed = 8'h00;
			backGreen = 8'h00;
			backBlue = 8'h00;
			is_background = 1'b1;
		end
	else
		begin
			bottomShape = 7'h00;
			backRed = 8'hff;
			backGreen = 8'hff;
			backBlue = 8'hff;
			is_background = 1'b0;
		end
end
endmodule