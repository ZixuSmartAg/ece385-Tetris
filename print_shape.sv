module print_shape	(
					input [9:0] DrawX, DrawY,
					input [4:0] y [3:0],
					input [3:0] x [3:0],
					output is_shape,
					);
	parameter [9:0] square_pixel_size = 10'd24;
	parameter [9:0] offset = 10'd144;	//about 6 of the blocks
	logic [9:0] x;
	assign x = DrawX - offset;


always_comb
begin
	if(x > (x[0] * square_pixel_size) && ((x[0] + 1'b1) * square_pixel_size) > x 
		&& DrawY > (y[0] * square_pixel_size) && ((y[0] + 1'b1) * square_pixel_size) > DrawY )
			is_shape = 1'b1;

	else if(x > (x[1] * square_pixel_size) && ((x[1] + 1'b1) * square_pixel_size) > x 
		&& DrawY > (y[1] * square_pixel_size) && ((y[1] + 1'b1) * square_pixel_size) > DrawY )
			is_shape = 1'b1;

	else if(x > (x[2] * square_pixel_size) && ((x[2] + 1'b1) * square_pixel_size) > x 
		&& DrawY > (y[2] * square_pixel_size) && ((y[2] + 1'b1) * square_pixel_size) > DrawY )
			is_shape = 1'b1;

	else if(x > (x[3] * square_pixel_size) && ((x[3] + 1'b1) * square_pixel_size) > x 
		&& DrawY > (y[3] * square_pixel_size) && ((y[3] + 1'b1) * square_pixel_size) > DrawY )
			is_shape = 1'b1;

	else
		is_shape = 1'b0;


end
endmodule