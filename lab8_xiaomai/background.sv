module background(
				input logic 	[9:0] DrawX, DrawY,
				input logic 	is_shape, is_boundary,
				input 	[19:0][9:0][6:0] field_color, 	
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
	else if(~is_shape && ~is_boundary && DrawX < 439 && DrawX >= 200)
		begin
			// if (DrawX < 224 && DrawX >= 200 && DrawY < 24 && DrawY >= 0)
			// 	begin
					bottomShape = field_color[DrawY / 24][(DrawX - offsetleft)/ 24];
					backRed = blockRed;
					backGreen = blockGreen;
					backBlue = blockBlue;
					is_background = 1'b1;
				// end
			// else if (DrawX < 248 && DrawX >=224 && DrawY < 24 && DrawY >= 0)
			// 	begin
			// 		bottomShape = field_color[0][1];
			// 		backRed = blockRed;
			// 		backGreen = blockGreen;
			// 		backBlue = blockBlue;
			// 		is_background = 1'b1;
			// 	end
			// else if(DrawX < 272 && DrawX >= 248 && DrawY <24 && DrawY  >= 0)
			// 	begin
			// 		bottomShape = field_color[0][2];
			// 		backRed = blockRed;
			// 		backGreen = blockGreen;
			// 		backBlue = blockBlue;
			// 		is_background = 1'b1;
			// 	end
			// else if(DrawX < 296 && DrawX >= 272 && DrawY < 24 && DrawY >= 0)
			// 	begin
			// 		bottomShape = field_color[0][3];
			// 		backRed = blockRed;
			// 		backGreen = blockGreen;
			// 		backBlue = blockBlue;
			// 		is_background = 1'b1;
			// 	end
			// else if(DrawX < 320 && DrawX >= 296 && DrawY < 24 && DrawY >= 0)
			// 	begin
			// 		bottomShape = field_color[0][4];
			// 		backRed = blockRed;
			// 		backGreen = blockGreen;
			// 		backBlue = blockBlue;
			// 		is_background = 1'b1;
			// 	end
			// else if(DrawX < 320 && DrawX >= 296 && DrawY < 24 && DrawY >= 0)
			// 	begin
			// 		bottomShape = field_color[0][4];
			// 		backRed = blockRed;
			// 		backGreen = blockGreen;
			// 		backBlue = blockBlue;
			// 		is_background = 1'b1;
			// 	end
			// else if(DrawX < 320 && DrawX >= 296 && DrawY < 24 && DrawY >= 0)
			// 	begin
			// 		bottomShape = field_color[0][4];
			// 		backRed = blockRed;
			// 		backGreen = blockGreen;
			// 		backBlue = blockBlue;
			// 		is_background = 1'b1;
			// 	end
			// else if(DrawX < 320 && DrawX >= 296 && DrawY < 24 && DrawY >= 0)
			// 	begin
			// 		bottomShape = field_color[0][4];
			// 		backRed = blockRed;
			// 		backGreen = blockGreen;
			// 		backBlue = blockBlue;
			// 		is_background = 1'b1;
			// 	end
			// else if(DrawX < 320 && DrawX >= 296 && DrawY < 24 && DrawY >= 0)
			// 	begin
			// 		bottomShape = field_color[0][4];
			// 		backRed = blockRed;
			// 		backGreen = blockGreen;
			// 		backBlue = blockBlue;
			// 		is_background = 1'b1;
			// 	end
			// else if(DrawX < 320 && DrawX >= 296 && DrawY < 24 && DrawY >= 0)
			// 	begin
			// 		bottomShape = field_color[0][4];
			// 		backRed = blockRed;
			// 		backGreen = blockGreen;
			// 		backBlue = blockBlue;
			// 		is_background = 1'b1;
			// 	end
			// else if(DrawX < 320 && DrawX >= 296 && DrawY < 24 && DrawY >= 0)
			// 	begin
			// 		bottomShape = field_color[0][4];
			// 		backRed = blockRed;
			// 		backGreen = blockGreen;
			// 		backBlue = blockBlue;
			// 		is_background = 1'b1;
			// 	end



			// for(int i = 19; i > 0; i--)
			// begin
			// 	for(int j = 0; j < 9; j++)
			// 	begin

			// 		bottomShape = field_color[i][j];
			// 		backRed = blockRed;
			// 		backGreen = blockGreen;
			// 		backBlue = blockBlue;
			// 		is_background = 1'b1;
						
			// 	end
			// end

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