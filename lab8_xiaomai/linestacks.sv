module  linestacks ( input   Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0] blocks_xpos,
               input [9:0] blocks_ypos,
               input logic add_shape,
               input [6:0]   shape_type,
               output logic [19:0][9:0]field,
               output [19:0][9:0][6:0] field_color,
               output logic linestack_reset
              );


logic [4:0] left, top;
logic [4:0] xpos [3:0];
logic [4:0] ypos [3:0];
logic [4:0] i, j;
       
    // logic [3:0] clear[19:0];  // initial position on the X axis
    // logic field_in[19:0][9:0];
    // logic [6:0] field_color_in[19:0][9:0];
    // logic linestack_reset_in;
    // logic [9:0] temp [19:0];
always_comb
begin
 left = (blocks_xpos - 10'd200) / 10'd24;
 top = blocks_ypos / 10'd24;
end

tetromino tetromino_instance2(.Clk(Clk), .Reset(Reset), .shape_type(shape_type), .left(left), .top(top), 
                                .rotation(/*rotation*/ 2'b00), .xpos(xpos), .ypos(ypos), .height(height));



    // Update registers
    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            // field <= '{'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0}};
            for(int i = 0; i < 20; i++)
                begin
                    for(int j = 0; j < 10; j++)
                        begin
                            field_color[i][j] <= 7'b0000000;
                            field[i][j] <= 1'b0;
                        end
                end
            // clear <= '{4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000};
            // linestack_reset <= 0;
        end
        else if (add_shape) 
                begin
                    field[ypos[0]][xpos[0]] <= 1'b1;
                    field_color[ypos[0]][xpos[0]] <= shape_type;
                    field[ypos[1]][xpos[1]] <= 1'b1;
                    field_color[ypos[1]][xpos[1]] <= shape_type;
                    field[ypos[2]][xpos[2]] <= 1'b1;
                    field_color[ypos[2]][xpos[2]] <= shape_type;
                    field[ypos[3]][xpos[3]] <= 1'b1;
                    field_color[ypos[3]][xpos[3]] <= shape_type;
                // linestack_reset <= 1;
                end
        else
            begin
                field <= field;
                field_color <= field_color;
            // linestack_reset <= 0;
            end
        end

    // always_comb
    // begin
    //     field_in = field;
    //     field_color_in = field_color;
    //     linestack_reset_in = 0;
        
        // if (frame_clk_rising_edge)
        // // begin


                    // field_in[int'(blocks_ypos[0])][int'(blocks_xpos[0])] = 1'b1;
                    // field_in[int'(blocks_ypos[1])][int'(blocks_xpos[1])] = 1'b1;
                    // field_in[int'(blocks_ypos[2])][int'(blocks_xpos[2])] = 1'b1;
                    // field_in[int'(blocks_ypos[3])][int'(blocks_xpos[3])] = 1'b1;
                    // field_color_in[int'(blocks_ypos[0])][int'(blocks_xpos[0])] = shape_type;
                    // field_color_in[int'(blocks_ypos[1])][int'(blocks_xpos[1])] = shape_type;
                    // field_color_in[int'(blocks_ypos[2])][int'(blocks_xpos[2])] = shape_type;
                    // field_color_in[int'(blocks_ypos[3])][int'(blocks_xpos[3])] = shape_type;

                   
                    // clear[blocks_ypos[0]] = blocks_ypos[0] + 1;
                    // clear[blocks_ypos[1]] = blocks_ypos[1] + 1;
                    // clear[blocks_ypos[2]] = blocks_ypos[2] + 1;
                    // clear[blocks_ypos[3]] = blocks_ypos[3] + 1;
                    // clear[blocks_ypos[0]] += 1;  
                    // clear[blocks_ypos[1]] += 1; 
                    // clear[blocks_ypos[2]] += 1; 
                    // clear[blocks_ypos[3]] += 1; 
                    // linestack_reset_in = 1;
                
            // else
            //     begin
            //         for(int i = 0; i < 20; i++)
            //             begin
            //             for(int j = 0; j < 10; j++)
            //                 begin
            //                     field_in[i][j] = field_in[i][j];
            //                     field_color_in[i][j] = field_color_in[i][j]; 
            //                 end
            //             end
                    // field_in[blocks_ypos[0]][blocks_xpos[0]] = field_in[blocks_ypos[0]][blocks_xpos[0]];
                    // field_in[blocks_ypos[1]][blocks_xpos[1]] = field_in[blocks_ypos[1]][blocks_xpos[1]];
                    // field_in[blocks_ypos[2]][blocks_xpos[2]] = field_in[blocks_ypos[2]][blocks_xpos[2]];
                    // field_in[blocks_ypos[3]][blocks_xpos[3]] = field_in[blocks_ypos[3]][blocks_xpos[3]];
                    // field_color_in[blocks_ypos[0]][blocks_xpos[0]] = field_color_in[blocks_ypos[0]][blocks_xpos[0]];
                    // field_color_in[blocks_ypos[1]][blocks_xpos[1]] = field_color_in[blocks_ypos[1]][blocks_xpos[1]];
                    // field_color_in[blocks_ypos[2]][blocks_xpos[2]] = field_color_in[blocks_ypos[2]][blocks_xpos[2]];
                    // field_color_in[blocks_ypos[3]][blocks_xpos[3]] = field_color_in[blocks_ypos[3]][blocks_xpos[3]];
                    // linestack_reset_in = 0;
    //             // end
    //         for (int i = 0; i < 20; i++)
    //         begin
    //             if (field[i][0] == 1'b1 && field[i][1] == 1'b1 && field[i][2] == 1'b1 && field[i][3] == 1'b1 && field[i][4] == 1'b1 && field[i][5] == 1'b1
    //                 && field[i][6] == 1'b1 && field[i][7] == 1'b1 && field[i][8] == 1'b1 && field[i][9] == 1'b1)
    //             begin
    //                 for (int j = i; j > 0; j--)
    //                 begin
    //                     // clear[j] = clear[j-1];
    //                     field[j][0] = field[j-1][0];
    //                     field[j][1] = field[j-1][1];
    //                     field[j][2] = field[j-1][2];
    //                     field[j][3] = field[j-1][3];
    //                     field[j][4] = field[j-1][4];
    //                     field[j][5] = field[j-1][5];
    //                     field[j][6] = field[j-1][6];
    //                     field[j][7] = field[j-1][7];
    //                     field[j][8] = field[j-1][8];
    //                     field[j][9] = field[j-1][9];

    //                     field_color[j][0] = field_color[j-1][0];
    //                     field_color[j][1] = field_color[j-1][1];
    //                     field_color[j][2] = field_color[j-1][2];
    //                     field_color[j][3] = field_color[j-1][3];
    //                     field_color[j][4] = field_color[j-1][4];
    //                     field_color[j][5] = field_color[j-1][5];
    //                     field_color[j][6] = field_color[j-1][6];
    //                     field_color[j][7] = field_color[j-1][7];
    //                     field_color[j][8] = field_color[j-1][8];
    //                     field_color[j][9] = field_color[j-1][9];
    //                 end
    //                 // clear[0] = 4'd0;
    //                 field[0] = '{0,0,0,0,0,0,0,0,0,0};
    //                 field_color[0] = '{7'b0000000, 7'b0000000, 7'b0000000, 7'b0000000, 7'b0000000, 7'b0000000, 7'b0000000, 7'b0000000, 7'b0000000, 7'b0000000};
    //             end
    //         end
    //     // end 
    // end
endmodule
