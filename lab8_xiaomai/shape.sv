//-------------------------------------------------------------------------
//    x axis : from 200 to 439                                             
//                                                      
//-------------------------------------------------------------------------



module  shape ( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
               input [7:0]   keycode,
               input logic   choose_s, choose_z, choose_t, choose_l, choose_line, choose_ml, choose_square,
               output logic  is_Shape             // Whether current pixel belongs to Shape or background
               output [4:0] blocks_xpos[3:0],
               output [4:0] blocks_ypos[3:0]
              );
    
    parameter [9:0] Shape_X_init = 10'd320;  // initial position on the X axis
    parameter [9:0] Shape_Y_init = 10'd0;  // initial position on the Y axis
    parameter [9:0] Shape_X_Min = 10'd200;       // Leftmost point on the X axis
    parameter [9:0] Shape_X_Max = 10'd439;     // Rightmost point on the X axis
    parameter [9:0] Shape_Y_Min = 10'd0;       // Topmost point on the Y axis
    parameter [9:0] Shape_Y_Max = 10'd479;     // Bottommost point on the Y axis
    parameter [9:0] Shape_X_Step = 10'd24;      // Step size on the X axis
    parameter [9:0] Shape_Y_Step = 10'd1;      // Step size on the Y axis
    parameter [9:0] Shape_Y_keyStep = 10'd24;      // Step size on the Y axis by keyboard
    parameter [1:0] rotation_init = 2'd00;         // at the beginning rotation is 00
    
    logic [9:0] Shape_X_Pos, Shape_X_Motion, Shape_Y_Pos, Shape_Y_Motion;
    logic [9:0] Shape_X_Pos_in, Shape_X_Motion_in, Shape_Y_Pos_in, Shape_Y_Motion_in;
    logic [1:0] rotation, rotation_test;
    logic [1:0] rotation_in;
    logic [4:0] left, top;
    logic [9:0] Shape_Size;
    logic [4:0] height, height_test;
    logic [4:0] blocks_xpos_test[3:0], blocks_ypos_test[3:0];
    
    s_shape s_instance(.Clk, .Reset, .alive(choose_s), .left, .top, .rotation, .xpos(blocks_xpos), .ypos(blocks_ypos), .height);
    z_shape z_instance(.Clk, .Reset, .alive(choose_z), .left, .top, .rotation, .xpos(blocks_xpos), .ypos(blocks_ypos), .height);
    t_shape t_instance(.Clk, .Reset, .alive(choose_t), .left, .top, .rotation, .xpos(blocks_xpos), .ypos(blocks_ypos), .height);
    l_shape l_instance(.Clk, .Reset, .alive(choose_l), .left, .top, .rotation, .xpos(blocks_xpos), .ypos(blocks_ypos), .height);
    line_shape line_instance(.Clk, .Reset, .alive(choose_line), .left, .top, .rotation, .xpos(blocks_xpos), .ypos(blocks_ypos), .height);
    mirror_l_shape mirror_l_instance(.Clk, .Reset, .alive(choose_ml), .left, .top, .rotation, .xpos(blocks_xpos), .ypos(blocks_ypos), .height);
    square_shape square_instance(.Clk, .Reset, .alive(choose_square), .left, .top, .rotation, .xpos(blocks_xpos), .ypos(blocks_ypos), .height);

    s_shape s_test_instance(.Clk, .Reset, .alive(choose_s), .left, .top, .rotation(rotation_test), .xpos(blocks_xpos_test), .ypos(blocks_ypos_test), .height(height_test));
    z_shape z_test_instance(.Clk, .Reset, .alive(choose_z), .left, .top, .rotation(rotation_test), .xpos(blocks_xpos_test), .ypos(blocks_ypos_test), .height(height_test));
    t_shape t_test_instance(.Clk, .Reset, .alive(choose_t), .left, .top, .rotation(rotation_test), .xpos(blocks_xpos_test), .ypos(blocks_ypos_test), .height(height_test));
    l_shape l_test_instance(.Clk, .Reset, .alive(choose_l), .left, .top, .rotation(rotation_test), .xpos(blocks_xpos_test), .ypos(blocks_ypos_test), .height(height_test));
    line_shape line_test_instance(.Clk, .Reset, .alive(choose_line), .left, .top, .rotation(rotation_test), .xpos(blocks_xpos_test), .ypos(blocks_ypos_test), .height(height_test));
    mirror_l_shape mirror_l_test_instance(.Clk, .Reset, .alive(choose_ml), .left, .top, .rotation(rotation_test), .xpos(blocks_xpos_test), .ypos(blocks_ypos_test), .height(height_test));
    square_shape square_test_instance(.Clk, .Reset, .alive(choose_square), .left, .top, .rotation(rotation_test), .xpos(blocks_xpos_test), .ypos(blocks_ypos_test), .height(height_test));

    //////// Do not modify the always_ff blocks. ////////
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
            Shape_X_Pos <= Shape_X_init;
            Shape_Y_Pos <= Shape_Y_init;
            Shape_X_Motion <= 10'd0;
            Shape_Y_Motion <= Shape_Y_Step;
            rotation <= rotation_init;
            rotation_test <= rotation_init;
        end
        else
        begin
            Shape_X_Pos <= Shape_X_Pos_in;
            Shape_Y_Pos <= Shape_Y_Pos_in;
            Shape_X_Motion <= Shape_X_Motion_in;
            Shape_Y_Motion <= Shape_Y_Motion_in;
            rotation <= rotation_in;
            rotation_test <= rotation_in;
        end
    end
    
    always_comb
    begin
        // By default, keep motion and position unchanged
        Shape_X_Pos_in = Shape_X_Pos;
        Shape_Y_Pos_in = Shape_Y_Pos;
        Shape_X_Motion_in = Shape_X_Motion;
        Shape_Y_Motion_in = Shape_Y_Motion;
        rotation_in = rotation;
        rotation_test = rotation;
        left = (Shape_X_Pos - Shape_X_Min) / Shape_X_Step;
        top = (Shape_Y_Pos - Shape_Y_Min) / Shape_Y_keyStep;
        Shape_Size = (blocks_xpos[3] - left) * Shape_X_Step;
        Shape_Size_test = (blocks_xpos_test[3] - left) * Shape_X_Step;

        // Update position and motion only at rising edge of frame clock
        // Be careful when using comparators with "logic" datatype because compiler treats 
        //   both sides of the operator as UNSIGNED numbers.
        // e.g. Shape_Y_Pos - Shape_Size <= Shape_Y_Min 
        // If Shape_Y_Pos is 0, then Shape_Y_Pos - Shape_Size will not be -4, but rather a large positive number.



        if (frame_clk_rising_edge)
        begin


        /*
            if( Shape_Y_Pos + Shape_Size >= Shape_Y_Max )  // Shape is at the bottom edge, BOUNCE!
                Shape_Y_Motion_in = (~(Shape_Y_Step) + 1'b1);  // 2's complement.  
            else if ( Shape_Y_Pos <= Shape_Y_Min + Shape_Size )  // Shape is at the top edge, BOUNCE!
                Shape_Y_Motion_in = Shape_Y_Step;
            if( Shape_X_Pos + Shape_Size >= Shape_X_Max )  // Shape is at the right edge, BOUNCE!
                Shape_X_Motion_in = (~(Shape_X_Step) + 1'b1);  // 2's complement.  
            else if ( Shape_X_Pos <= Shape_X_Min + Shape_Size )  // Shape is at the left edge, BOUNCE!
                Shape_X_Motion_in = Shape_X_Step;
*/



            case(keycode)
                8'h04 : 
                    begin
                        Shape_X_Motion_in = (~(Shape_X_Step) + 1'b1);   //left
                        Shape_Y_Motion_in = Shape_Y_Step;
                    end
                8'h07 : 
                    begin
                        Shape_X_Motion_in = Shape_X_Step;    //right
                        Shape_Y_Motion_in = Shape_Y_Step;
                    end
                8'h16 : 
                    begin
                        Shape_Y_Motion_in = Shape_Y_keyStep;    //down
                        Shape_X_Motion_in = 10'h000;
                    end

                8'h1d :                                         // z, rotate left
                    begin
                        rotation_test = rotation_in - 1'd1;

                        if( Shape_Y_Pos_in + (height_test * Shape_X_Step) >= Shape_Y_Max )  // Shape is at the bottom edge, stop!
                        begin
                            rotation_in = rotation;
                        end

                        else if( Shape_X_Pos_in + Shape_Size_test >= Shape_X_Max )  // Shape is at the right edge, stop!
                        begin
                            rotation_in = rotation;
                        end

                        else if ( Shape_X_Pos_in <= Shape_X_Min)  // Shape is at the left edge, stop!
                        begin
                            rotation_in = rotation;
                        end

                        else
                        begin
                            rotation_in = rotation_test;
                        end

                    end

                8'h06 :                                         // c, rotate right
                    begin
                        rotation_test = rotation_in + 1'd1;

                        if( Shape_Y_Pos_in + (height_test * Shape_X_Step) >= Shape_Y_Max )  // Shape is at the bottom edge, stop!
                        begin
                            rotation_in = rotation;
                        end

                        else if( Shape_X_Pos_in + Shape_Size_test >= Shape_X_Max )  // Shape is at the right edge, stop!
                        begin
                            rotation_in = rotation;
                        end

                        else if ( Shape_X_Pos_in <= Shape_X_Min)  // Shape is at the left edge, stop!
                        begin
                            rotation_in = rotation;
                        end

                        else
                        begin
                            rotation_in = rotation_test;
                        end

                    end

					default:	
                    begin  
                        Shape_Y_Motion_in = Shape_Y_Step;   
                        Shape_X_Motion_in = 10'h000;
                    end
            endcase

            // Update the Shape's position with its motion
            Shape_X_Pos_in = Shape_X_Pos + Shape_X_Motion;
            Shape_Y_Pos_in = Shape_Y_Pos + Shape_Y_Motion;

            if( Shape_Y_Pos_in + (height * Shape_X_Step) >= Shape_Y_Max )  // Shape is at the bottom edge, stop!
                Shape_Y_Motion_in = 10'h000;  // 2's complement.  
                Shape_Y_Pos_in = Shape_Y_Max;
            if( Shape_X_Pos_in + Shape_Size >= Shape_X_Max )  // Shape is at the right edge, stop!
                Shape_X_Motion_in = 10'h000;  // 2's complement.  
                Shape_X_Pos_in = Shape_X_Max;
            else if ( Shape_X_Pos_in <= Shape_X_Min)  // Shape is at the left edge, stop!
                Shape_X_Motion_in = 10'h000;
                Shape_X_Pos_in = Shape_X_Min;
        end
        
        /**************************************************************************************
            ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
            Hidden Question #2/2:
               Notice that Shape_Y_Pos is updated using Shape_Y_Motion. 
              Will the new value of Shape_Y_Motion be used when Shape_Y_Pos is updated, or the old? 
              What is the difference between writing
                "Shape_Y_Pos_in = Shape_Y_Pos + Shape_Y_Motion;" and 
                "Shape_Y_Pos_in = Shape_Y_Pos + Shape_Y_Motion_in;"?
              How will this impact behavior of the Shape during a bounce, and how might that interact with a response to a keypress?
              Give an answer in your Post-Lab.
        **************************************************************************************/
    end
    
    // Compute whether the pixel corresponds to Shape or background
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int DistX, DistY, Size;
    assign DistX = DrawX - Shape_X_Pos;
    assign DistY = DrawY - Shape_Y_Pos;
    assign Size = Shape_Size;
    always_comb begin
        if ( ( DistX*DistX + DistY*DistY) <= (Size*Size) ) 
            is_Shape = 1'b1;
        else
            is_Shape = 1'b0;
        /* The Shape's (pixelated) circle is generated using the standard circle formula.  Note that while 
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
    end
    
endmodule