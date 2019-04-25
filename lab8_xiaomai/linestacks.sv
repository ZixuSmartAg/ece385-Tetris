module  linestacks ( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [4:0] blocks_xpos[3:0],
               input [4:0] blocks_ypos[3:0],
               input logic add_shape,
               input [6:0]   shape_type,
               output logic field[19:0][9:0],
               output logic linestack_reset
              );

    logic [4:0] clear[19:0];  // initial position on the X axis
    logic field_in[19:0][9:0];
    logic [6:0] field_color_in[19:0][9:0];
    logic [6:0] field_color[19:0][9:0];
    logic linestack_reset_in;

    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
    // Update registers
    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            field <= '{'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0,0}};
            field_color <= {20{7'b1111111, 7'b1111111, , 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111}};
            clear <= '{4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000, 4'd0000};
            linestack_reset <= 0;
        end
        else
        begin
            field <= field_in;
            field_color <= field_color_in;
            linestack_reset <= linestack_reset_in;
        end
    end

    always_comb
    begin
        field_in = field;
        field_color_in = field_color;
        linestack_reset_in = 0;
        
        if (frame_clk_rising_edge)
        begin
            if (add_shape) 
            begin
                field_in[blocks_ypos[0]][blocks_xpos[0]] = 1'b1;
                field_in[blocks_ypos[1]][blocks_xpos[1]] = 1'b1;
                field_in[blocks_ypos[2]][blocks_xpos[2]] = 1'b1;
                field_in[blocks_ypos[3]][blocks_xpos[3]] = 1'b1;
                field_color_in[blocks_ypos[3]][blocks_xpos[3]] = shape_type;
                field_color_in[blocks_ypos[3]][blocks_xpos[3]] = shape_type;
                field_color_in[blocks_ypos[3]][blocks_xpos[3]] = shape_type;
                field_color_in[blocks_ypos[3]][blocks_xpos[3]] = shape_type;
                clear[blocks_ypos[0]] = blocks_ypos[0] + 1;
                clear[blocks_ypos[1]] = blocks_ypos[1] + 1;
                clear[blocks_ypos[2]] = blocks_ypos[2] + 1;
                clear[blocks_ypos[3]] = blocks_ypos[3] + 1;
                linestack_reset_in = 1;
            end

            for (int i = 0; i < 20; i++)
            begin
                if (clear[i] == 4'd1010)
                begin
                    for (int j = i; j > 0; j--)
                    begin
                        clear[j] = clear[j-1];
                        field_in[j][0] = field_in[j-1][0];
                        field_in[j][1] = field_in[j-1][1];
                        field_in[j][2] = field_in[j-1][2];
                        field_in[j][3] = field_in[j-1][3];
                        field_in[j][4] = field_in[j-1][4];
                        field_in[j][5] = field_in[j-1][5];
                        field_in[j][6] = field_in[j-1][6];
                        field_in[j][7] = field_in[j-1][7];
                        field_in[j][8] = field_in[j-1][8];
                        field_in[j][9] = field_in[j-1][9];

                        field_color_in[j][0] = field_color_in[j-1][0];
                        field_color_in[j][1] = field_color_in[j-1][1];
                        field_color_in[j][2] = field_color_in[j-1][2];
                        field_color_in[j][3] = field_color_in[j-1][3];
                        field_color_in[j][4] = field_color_in[j-1][4];
                        field_color_in[j][5] = field_color_in[j-1][5];
                        field_color_in[j][6] = field_color_in[j-1][6];
                        field_color_in[j][7] = field_color_in[j-1][7];
                        field_color_in[j][8] = field_color_in[j-1][8];
                        field_color_in[j][9] = field_color_in[j-1][9];
                    end
                    clear[0] = 4'd0000;
                    field_in[0] = '{0,0,0,0,0,0,0,0,0,0};
                    field_color_in[0] = '{7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111};
                end
            end
        end 
    end
endmodule
