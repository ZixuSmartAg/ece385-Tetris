//-------------------------------------------------------------------------
//    x axis : from 200 to 439                                             
//                           
/*
                    begin
                        if( Shape_Y_Pos_in + (height_test * Shape_X_Step) >= Shape_Y_Max )  // Shape is at the bottom edge, stop!
                        begin
                            rotation_in = rotation;
                            Shape_Y_Motion_in = 10'h000;    //don't go down
                            Shape_X_Motion_in = 10'h000;
                            add_shape_in = 0;

                        end

                        else if( Shape_X_Pos_in + Shape_Size_test >= Shape_X_Max )  // Shape is at the right edge, stop!
                        begin
                            rotation_in = rotation;
                            Shape_Y_Motion_in = Shape_Y_Step;    //down
                            Shape_X_Motion_in = 10'h000;
                            add_shape_in = 0;

                        end

                        else if ( Shape_X_Pos_in <= Shape_X_Min)  // Shape is at the left edge, stop!
                        begin
                            rotation_in = rotation;
                            Shape_Y_Motion_in = Shape_Y_Step;    //down
                            Shape_X_Motion_in = 10'h000;
                            add_shape_in = 0;

                        end

                        else
                        begin
                            rotation_in = rotation_in + 1'd1;
                            Shape_Y_Motion_in = Shape_Y_Step;    //down
                            Shape_X_Motion_in = 10'h000;
                            add_shape_in = 0;

                        end
                    end

*/
//-------------------------------------------------------------------------



module  shape ( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             linestack_reset,
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
               input [7:0]   keycode,
               input [6:0]   shape_type,
               input logic field[19:0][9:0],
               output [4:0] blocks_xpos[3:0],
               output [4:0] blocks_ypos[3:0],
               output logic add_shape
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
    logic [9:0] Shape_X_Pos_in_temp, Shape_Y_Pos_in_temp;
    logic [1:0] rotation, rotation_test;
    logic [1:0] rotation_in;
    logic [4:0] left, top, left_test, top_test;
    logic [9:0] Shape_Size, Shape_Size_test;
    logic [4:0] height, height_test;
    logic [4:0] blocks_xpos_test[3:0], blocks_ypos_test[3:0];
    logic add_shape_in;
    

    tetromino tetromino_instance(.Clk(Clk), .Reset(Reset), .shape_type(shape_type), .left(left), .top(top), .rotation(rotation), .xpos(blocks_xpos), .ypos(blocks_ypos), .height(height));
    tetromino tetromino_test_instance(.Clk(Clk), .Reset(Reset), .shape_type(shape_type), .left(left_test), .top(top_test), .rotation(rotation_test), .xpos(blocks_xpos_test), .ypos(blocks_ypos_test), .height(height_test));


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
            add_shape <= 0;
        end
        else if (linestack_reset)    
        begin
            Shape_X_Pos <= Shape_X_init;
            Shape_Y_Pos <= Shape_Y_init;
            Shape_X_Motion <= 10'd0;
            Shape_Y_Motion <= Shape_Y_Step;
            rotation <= rotation_init;
            add_shape <= 0; 
            //shape_type
        end
        else
        begin
            Shape_X_Pos <= Shape_X_Pos_in;
            Shape_Y_Pos <= Shape_Y_Pos_in;
            Shape_X_Motion <= Shape_X_Motion_in;
            Shape_Y_Motion <= Shape_Y_Motion_in;
            rotation <= rotation_in;
            add_shape <= add_shape_in;  //updating the add_shape signal at the same time with the motion
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
        rotation_test = rotation + 1'd1;
        left = (Shape_X_Pos_in - Shape_X_Min) / Shape_X_Step;
        top = (Shape_Y_Pos_in - Shape_Y_Min) / Shape_Y_keyStep;
        left_test = (Shape_X_Pos - Shape_X_Min) / Shape_X_Step;
        top_test = (Shape_Y_Pos - Shape_Y_Min) / Shape_Y_keyStep;  
        Shape_Size = (blocks_xpos[3] - left + 1) * Shape_X_Step;
        Shape_Size_test = (blocks_xpos_test[3] - left + 1) * Shape_X_Step;
        add_shape_in = add_shape;           //adding this line to quiet error
        // Update position and motion only at rising edge of frame clock
        // Be careful when using comparators with "logic" datatype because compiler treats 
        //   both sides of the operator as UNSIGNED numbers.
        // e.g. Shape_Y_Pos - Shape_Size <= Shape_Y_Min 
        // If Shape_Y_Pos is 0, then Shape_Y_Pos - Shape_Size will not be -4, but rather a large positive number.

        if (frame_clk_rising_edge)
        begin
            // if (Shape_Y_Motion == 10'h000)
            // add_shape = 1;
            // else
            // add_shape = 0;

            case(keycode)   //only changes motion_in for x and y, and rotation_in
                8'h04 : 
                    begin
                        Shape_X_Motion_in = (~(Shape_X_Step) + 1'b1);   //left
                        Shape_Y_Motion_in = Shape_Y_Step;
                        rotation_in = rotation;
                    end

                8'h07 : 
                    begin
                        Shape_X_Motion_in = Shape_X_Step;    //right
                        Shape_Y_Motion_in = Shape_Y_Step;
                        rotation_in = rotation;
                    end

                8'h16 : 
                    begin
                        Shape_Y_Motion_in = Shape_Y_keyStep;    //down
                        Shape_X_Motion_in = 10'h000;
                        rotation_in = rotation;
                    end

                8'h1A :                                         // w, rotate right
                    begin
                        rotation_in = rotation_in + 1'd1;
                        Shape_Y_Motion_in = Shape_Y_Step;   
                        Shape_X_Motion_in = 10'h000;
                    end

				default:	
                    begin  
                        Shape_Y_Motion_in = Shape_Y_Step;   
                        Shape_X_Motion_in = 10'h000;
                        rotation_in = rotation;
                    end
            endcase

            //Update the Shape's position with its motion
            //Shape_X_Pos_in_temp = Shape_X_Pos + Shape_X_Motion;
            //Shape_Y_Pos_in_temp = Shape_Y_Pos + Shape_Y_Motion;

            if (rotation_in == rotation)
            begin
                if( Shape_Y_Pos + (height * Shape_X_Step) >= Shape_Y_Max)  // Shape is at the bottom edge, stop!
                begin
                    Shape_Y_Motion_in = 10'h000;  // 2's complement. 
                    Shape_Y_Pos_in = Shape_Y_Max - (height * Shape_X_Step);
                    add_shape_in = 1;      //new shape should come in
                    rotation_in = rotation_in;
                end
                else
                begin
                    Shape_Y_Motion_in = Shape_Y_Motion_in;  // 2's complement.  
                    Shape_Y_Pos_in = Shape_Y_Pos + Shape_Y_Motion;
                    add_shape_in = 0;
                    rotation_in = rotation_in;
                end

                if( Shape_X_Pos + Shape_Size >= Shape_X_Max )  // Shape is at the right edge, stop!
                begin
                    Shape_X_Motion_in = 10'h000;  // 2's complement.  
                    Shape_X_Pos_in = Shape_X_Max - Shape_Size;
                    add_shape_in = 0 | add_shape_in;
                    rotation_in = rotation_in;
                end
                else if ( Shape_X_Pos <= Shape_X_Min)  // Shape is at the left edge, stop!
                begin
                    Shape_X_Motion_in = 10'h000;
                    Shape_X_Pos_in = Shape_X_Min;
                    add_shape_in = 0 | add_shape_in;
                    rotation_in = rotation_in;
                end
                else
                begin
                    Shape_X_Pos_in = Shape_X_Pos + Shape_X_Motion;
                    Shape_X_Motion_in = Shape_X_Motion_in;
                    add_shape_in = 0 | add_shape_in;
                    rotation_in = rotation_in;
                end

                if(field[blocks_ypos[0]][blocks_xpos[0]] == 1 || field[blocks_ypos[1]][blocks_xpos[1]] == 1 || field[blocks_ypos[2]][blocks_xpos[2]] == 1 || field[blocks_ypos[3]][blocks_xpos[3]] == 1)
                begin
                    Shape_Y_Motion_in = 10'h000;  
                    Shape_X_Motion_in = 10'h000;  
                    Shape_Y_Pos_in = Shape_Y_Pos;
                    Shape_X_Pos_in = Shape_X_Pos;
                    add_shape_in = 1;      //new shape should come in  
                    rotation_in = rotation_in;              
                end
                else
                begin
                    Shape_Y_Motion_in = Shape_Y_Motion_in;  
                    Shape_X_Motion_in = Shape_X_Motion_in;
                    Shape_Y_Pos_in = Shape_Y_Pos_in;
                    Shape_X_Pos_in = Shape_X_Pos_in;
                    add_shape_in = 0 | add_shape_in;     
                    rotation_in = rotation_in;          
                end
            end
            else
            begin
                if( Shape_Y_Pos + (height_test * Shape_X_Step) >= Shape_Y_Max)  // Shape is at the bottom edge, stop!
                begin
                    Shape_Y_Motion_in = 10'h000;  // 2's complement. 
                    Shape_Y_Pos_in = Shape_Y_Max - (height_test * Shape_X_Step);
                    add_shape_in = 1;      //new shape should come in
                    rotation_in = rotation;  
                end
                else
                begin
                    Shape_Y_Motion_in = Shape_Y_Motion_in;  // 2's complement.  
                    Shape_Y_Pos_in = Shape_Y_Pos + Shape_Y_Motion;
                    add_shape_in = 0;
                    rotation_in = rotation_in; 
                end

                if( Shape_X_Pos + Shape_Size_test >= Shape_X_Max )  // Shape is at the right edge, stop!
                begin
                    Shape_X_Motion_in = 10'h000;  // 2's complement.  
                    Shape_X_Pos_in = Shape_X_Max - Shape_Size_test;
                    add_shape_in = 0 | add_shape_in;
                    rotation_in = rotation; 
                end
                else if ( Shape_X_Pos <= Shape_X_Min)  // Shape is at the left edge, stop!
                begin
                    Shape_X_Motion_in = 10'h000;
                    Shape_X_Pos_in = Shape_X_Min;
                    add_shape_in = 0 | add_shape_in;
                    rotation_in = rotation; 
                end
                else
                begin
                    Shape_X_Pos_in = Shape_X_Pos + Shape_X_Motion;
                    Shape_X_Motion_in = Shape_X_Motion_in;
                    add_shape_in = 0 | add_shape_in;
                    rotation_in = rotation_in; 
                end

                if(field[blocks_ypos_test[0]][blocks_xpos_test[0]] == 1 || field[blocks_ypos_test[1]][blocks_xpos_test[1]] == 1 || field[blocks_ypos_test[2]][blocks_xpos_test[2]] == 1 || field[blocks_ypos_test[3]][blocks_xpos_test[3]] == 1)
                begin
                    Shape_Y_Motion_in = 10'h000;  
                    Shape_X_Motion_in = 10'h000;  
                    Shape_Y_Pos_in = Shape_Y_Pos;
                    Shape_X_Pos_in = Shape_X_Pos;
                    add_shape_in = 1;      //new shape should come in     
                    rotation_in = rotation;            
                end
                else
                begin
                    Shape_Y_Motion_in = Shape_Y_Motion_in;  
                    Shape_X_Motion_in = Shape_X_Motion_in; 
                    Shape_Y_Pos_in = Shape_Y_Pos_in;
                    Shape_X_Pos_in = Shape_X_Pos_in;
                    add_shape_in = 0 | add_shape_in;  
                    rotation_in = rotation_in;              
                end
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
    end   //if
end     //always_comb
endmodule
