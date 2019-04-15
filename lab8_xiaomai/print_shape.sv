module print_shape	(
					input logic [9:0] DrawX, DrawY,
					input logic [4:0] y [3:0],
					input logic [3:0] x [3:0],
					output logic is_shape,
					output logic is_boundary
					);
	parameter [9:0] square_pixel_size = 10'd24;
	parameter [9:0] offset = 10'd144;	//about 6 of the blocks
	logic [9:0] x;
	assign x = DrawX - offset;


always_comb
begin
	if(x > (x[0] * square_pixel_size) && ((x[0] + 1'b1) * square_pixel_size) > x 
		&& DrawY > (y[0] * square_pixel_size) && ((y[0] + 1'b1) * square_pixel_size) > DrawY )
			begin

			if(x > (x[0] * square_pixel_size + 10'd2) && ((x[0] + 1'b1) * square_pixel_size - 10'd2) > x 
		&& DrawY > (y[0] * square_pixel_size + 10'd2) && ((y[0] + 1'b1) * square_pixel_size - 10'd2) > DrawY )
				begin
					is_shape = 1'b1;
					is_boundary = 1'b0;
				end
			else
				begin
					is_shape = 1'b0;
					is_boundary = 1'b1;
				end

			end

	else if(x > (x[1] * square_pixel_size) && ((x[1] + 1'b1) * square_pixel_size) > x 
		&& DrawY > (y[1] * square_pixel_size) && ((y[1] + 1'b1) * square_pixel_size) > DrawY )
			begin

			if(x > (x[1] * square_pixel_size + 10'd2) && ((x[1] + 1'b1) * square_pixel_size - 10'd2) > x 
		&& DrawY > (y[1] * square_pixel_size + 10'd2) && ((y[1] + 1'b1) * square_pixel_size - 10'd2) > DrawY )
				begin
					is_shape = 1'b1;
					is_boundary = 1'b0;
				end
			else
				begin
					is_shape = 1'b0;
					is_boundary = 1'b1;
				end
			end

	else if(x > (x[2] * square_pixel_size) && ((x[2] + 1'b1) * square_pixel_size) > x 
		&& DrawY > (y[2] * square_pixel_size) && ((y[2] + 1'b1) * square_pixel_size) > DrawY )
			begin

			if(x > (x[2] * square_pixel_size + 10'd2) && ((x[2] + 1'b1) * square_pixel_size - 10'd2) > x 
		&& DrawY > (y[2] * square_pixel_size + 10'd2) && ((y[2] + 1'b1) * square_pixel_size - 10'd2) > DrawY )
				begin
					is_shape = 1'b1;
					is_boundary = 1'b0;
				end
			else
				begin
					is_shape = 1'b0;
					is_boundary = 1'b1;
				end
			end

	else if(x > (x[3] * square_pixel_size) && ((x[3] + 1'b1) * square_pixel_size) > x 
		&& DrawY > (y[3] * square_pixel_size) && ((y[3] + 1'b1) * square_pixel_size) > DrawY )
			begin

			if(x > (x[3] * square_pixel_size + 10'd2) && ((x[3] + 1'b1) * square_pixel_size - 10'd2) > x 
		&& DrawY > (y[3] * square_pixel_size + 10'd2) && ((y[3] + 1'b1) * square_pixel_size - 10'd2) > DrawY )
				begin
					is_boundary = 1'b0;
					is_shape = 1'b1;
				end
			else
				begin
					is_boundary = 1'b1;
					is_shape = 1'b0;
				end

			end
	else
		begin
			is_shape = 1'b0;
			is_boundary = 1'b0;
		end


end
endmodule