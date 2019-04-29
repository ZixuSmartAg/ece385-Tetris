//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.
module  color_mapper ( input              is_shape,            // Whether current pixel belongs to ball 
                       input        [6:0] shape,
                       input              is_boundary,  
                       input logic [6:0] field_color[19:0][9:0],                      //   or background (computed in ball.sv)
                       input        [9:0] DrawX, DrawY,       // Current pixel coordinates
                       output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
    
    logic [7:0] Red, Green, Blue;
    logic [7:0] blockRed, blockGreen, blockBlue, backRed, backGreen, backBlue;
    logic is_background;

    block_color blockcolors(.*);
    background  backgrounds(.*, .field_color(field_color));
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
    
    // Assign color based on is_ball signal
    always_comb
    begin
        if (is_shape == 1'b1) 
            begin
                // White ball
                Red = blockRed;
                Green = blockGreen;
                Blue = blockBlue;
            end
        else if (is_boundary)
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'h00;
            end
        else if(is_background)
            begin
                Red = backRed;
                Green = backGreen;
                Blue = backBlue;
            end
        else
            begin
                // Background with nice color gradient
                Red = 8'h3f; 
                Green = 8'h00;
                Blue = 8'h7f - {1'b0, DrawX[9:3]};
            end
    end 
    
endmodule
