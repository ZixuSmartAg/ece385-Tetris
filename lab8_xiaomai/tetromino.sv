module  s_shape ( input  Clk,
                         Reset,
                  input logic alive,
                  input [4:0] left, top,  
                  input [1:0]   rotation,
                  output [4:0] xpos[3:0],
                  output [4:0] ypos[3:0]
                  );

    always_comb
    begin
        if (alive)
        begin
            case(rotation)
                2'b00 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top + 1'b1; 
                        xpos[1] = left + 1'b1; 
                        ypos[1] = top; 
                        xpos[2] = left + 1'b1; 
                        ypos[2] = top + 1'b1; 
                        xpos[3] = left + 2'b10; 
                        ypos[3] = top; 
                    end
                2'b01 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top; 
                        xpos[1] = left; 
                        ypos[1] = top + 1'b1; 
                        xpos[2] = left + 1'b1; 
                        ypos[2] = top + 1'b1; 
                        xpos[3] = left + 1'b1; 
                        ypos[3] = top + 2'b10; 
                    end
                2'b10 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top + 1'b1; 
                        xpos[1] = left + 1'b1; 
                        ypos[1] = top; 
                        xpos[2] = left + 1'b1; 
                        ypos[2] = top + 1'b1; 
                        xpos[3] = left + 2'b10; 
                        ypos[3] = top; 
                    end
                2'b11 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top; 
                        xpos[1] = left; 
                        ypos[1] = top + 1'b1; 
                        xpos[2] = left + 1'b1; 
                        ypos[2] = top + 1'b1; 
                        xpos[3] = left + 1'b1; 
                        ypos[3] = top + 2'b10; 
                    end
					default:	;
            endcase
        end
        else
        begin
            xpos = xpos;
            ypos = ypos;
        end
    end
endmodule


module  z_shape ( input  Clk,
                         Reset,
                  intput logic alive,
                  input [4:0] left, top,  
                  input [1:0]   rotation,
                  output [4:0] xpos[4:0],
                  output [4:0] ypos[4:0]
                  );

    always_comb
    begin
        if (alive)
        begin
            case(rotation)
                2'b00 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top; 
                        xpos[1] = left + 1'b1; 
                        ypos[1] = top; 
                        xpos[2] = left + 1'b1; 
                        ypos[2] = top + 1'b1; 
                        xpos[3] = left + 2'b10; 
                        ypos[3] = top + 1'b1; 
                    end
                2'b01 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top + 1'b1; 
                        xpos[1] = left; 
                        ypos[1] = top + 2'b10; 
                        xpos[2] = left + 1'b1; 
                        ypos[2] = top; 
                        xpos[3] = left + 1'b1; 
                        ypos[3] = top + 1'b1; 
                    end
                2'b10 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top; 
                        xpos[1] = left + 1'b1; 
                        ypos[1] = top; 
                        xpos[2] = left + 1'b1; 
                        ypos[2] = top + 1'b1; 
                        xpos[3] = left + 2'b10; 
                        ypos[3] = top + 1'b1; 
                    end
                2'b11 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top + 1'b1; 
                        xpos[1] = left; 
                        ypos[1] = top + 2'b10; 
                        xpos[2] = left + 1'b1; 
                        ypos[2] = top; 
                        xpos[3] = left + 1'b1; 
                        ypos[3] = top + 1'b1; 
                    end
					default:	;
            endcase
        end
        else
        begin
            xpos = xpos;
            ypos = ypos;
        end
    end
endmodule


module  t_shape ( input  Clk,
                         Reset,
                  intput logic alive,
                  input [4:0] left, top,  
                  input [1:0]   rotation,
                  output [4:0] xpos[4:0],
                  output [4:0] ypos[4:0]
                  );

    always_comb
    begin
        if (alive)
        begin
            case(rotation)
                2'b00 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top; 
                        xpos[1] = left + 1'b1; 
                        ypos[1] = top; 
                        xpos[2] = left + 1'b1; 
                        ypos[2] = top + 1'b1; 
                        xpos[3] = left + 2'b10; 
                        ypos[3] = top; 
                    end
                2'b01 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top + 1'b1; 
                        xpos[1] = left + 1'b1; 
                        ypos[1] = top; 
                        xpos[2] = left + 1'b1; 
                        ypos[2] = top + 1'b1; 
                        xpos[3] = left + 1'b1; 
                        ypos[3] = top + 2'b10; 
                    end
                2'b10 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top + 1'b1; 
                        xpos[1] = left + 1'b1; 
                        ypos[1] = top; 
                        xpos[2] = left + 1'b1; 
                        ypos[2] = top + 1'b1; 
                        xpos[3] = left + 2'b10; 
                        ypos[3] = top + 2'b10; 
                    end
                2'b11 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top; 
                        xpos[1] = left; 
                        ypos[1] = top + 1'b1; 
                        xpos[2] = left; 
                        ypos[2] = top + 2'b10; 
                        xpos[3] = left + 1'b1; 
                        ypos[3] = top + 1'b1; 
                    end
					default:	;
            endcase
        end
        else
        begin
            xpos = xpos;
            ypos = ypos;
        end
    end
endmodule



module  l_shape ( input  Clk,
                         Reset,
                  intput logic alive,
                  input [4:0] left, top,  
                  input [1:0]   rotation,
                  output [4:0] xpos[4:0],
                  output [4:0] ypos[4:0]
                  );

    always_comb
    begin
        if (alive)
        begin
            case(rotation)
                2'b00 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top; 
                        xpos[1] = left; 
                        ypos[1] = top + 1'b1; 
                        xpos[2] = left + 1'b1; 
                        ypos[2] = top; 
                        xpos[3] = left + 2'b10; 
                        ypos[3] = top; 
                    end
                2'b01 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top; 
                        xpos[1] = left + 1'b1; 
                        ypos[1] = top; 
                        xpos[2] = left + 1'b1; 
                        ypos[2] = top + 1'b1; 
                        xpos[3] = left + 1'b1; 
                        ypos[3] = top + 2'b10; 
                    end
                2'b10 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top + 1'b1; 
                        xpos[1] = left + 1'b1; 
                        ypos[1] = top + 1'b1; 
                        xpos[2] = left + 2'b10; 
                        ypos[2] = top; 
                        xpos[3] = left + 2'b10; 
                        ypos[3] = top + 1'b1; 
                    end
                2'b11 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top; 
                        xpos[1] = left; 
                        ypos[1] = top + 1'b1; 
                        xpos[2] = left; 
                        ypos[2] = top + 2'b10; 
                        xpos[3] = left + 1'b1; 
                        ypos[3] = top + 2'b10; 
                    end
					default:	;
            endcase
        end
        else
        begin
            xpos = xpos;
            ypos = ypos;
        end
    end
endmodule


module  line_shape ( input  Clk,
                         Reset,
                  intput logic alive,
                  input [4:0] left, top,  
                  input [1:0]   rotation,
                  output [4:0] xpos[4:0],
                  output [4:0] ypos[4:0]
                  );

    always_comb
    begin
        if (alive)
        begin
            case(rotation)
                2'b00 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top; 
                        xpos[1] = left + 1'b1; 
                        ypos[1] = top; 
                        xpos[2] = left + 2'b10; 
                        ypos[2] = top; 
                        xpos[3] = left + 2'b11; 
                        ypos[3] = top; 
                    end
                2'b01 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top; 
                        xpos[1] = left; 
                        ypos[1] = top + 1'b1; 
                        xpos[2] = left; 
                        ypos[2] = top + 2'b10; 
                        xpos[3] = left; 
                        ypos[3] = top + 2'b11; 
                    end
                2'b10 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top; 
                        xpos[1] = left + 1'b1; 
                        ypos[1] = top; 
                        xpos[2] = left + 2'b10; 
                        ypos[2] = top; 
                        xpos[3] = left + 2'b11; 
                        ypos[3] = top; 
                    end
                2'b11 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top; 
                        xpos[1] = left; 
                        ypos[1] = top + 1'b1; 
                        xpos[2] = left; 
                        ypos[2] = top + 2'b10; 
                        xpos[3] = left; 
                        ypos[3] = top + 2'b11; 
                    end
					default:	;
            endcase
        end
        else
        begin
            xpos = xpos;
            ypos = ypos;
        end
    end
endmodule


module  mirror_l_shape ( input  Clk,
                         Reset,
                  intput logic alive,
                  input [4:0] left, top,  
                  input [1:0]   rotation,
                  output [4:0] xpos[4:0],
                  output [4:0] ypos[4:0]
                  );

    always_comb
    begin
        if (alive)
        begin
            case(rotation)
                2'b00 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top; 
                        xpos[1] = left + 1'b1; 
                        ypos[1] = top; 
                        xpos[2] = left + 2'b10; 
                        ypos[2] = top; 
                        xpos[3] = left + 2'b10; 
                        ypos[3] = top + 1'b1; 
                    end
                2'b01 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top + 2'b10; 
                        xpos[1] = left + 1'b1; 
                        ypos[1] = top; 
                        xpos[2] = left + 1'b1; 
                        ypos[2] = top + 1'b1; 
                        xpos[3] = left + 1'b1; 
                        ypos[3] = top + 2'b10; 
                    end
                2'b10 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top; 
                        xpos[1] = left; 
                        ypos[1] = top + 1'b1; 
                        xpos[2] = left + 1'b1; 
                        ypos[2] = top + 1'b1; 
                        xpos[3] = left + 2'b10; 
                        ypos[3] = top + 1'b1; 
                    end
                2'b11 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top; 
                        xpos[1] = left; 
                        ypos[1] = top + 1'b1; 
                        xpos[2] = left; 
                        ypos[2] = top + 2'b10; 
                        xpos[3] = left + 1'b1; 
                        ypos[3] = top; 
                    end
					default:	;
            endcase
        end
        else
        begin
            xpos = xpos;
            ypos = ypos;
        end
    end
endmodule


module  square_shape ( input  Clk,
                         Reset,
                  intput logic alive,
                  input [4:0] left, top,  
                  input [1:0]   rotation,
                  output [4:0] xpos[4:0],
                  output [4:0] ypos[4:0]
                  );

    always_comb
    begin
        if (alive)
        begin
            case(rotation)
                2'b00 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top; 
                        xpos[1] = left; 
                        ypos[1] = top + 1'b1; 
                        xpos[2] = left + 1'b1; 
                        ypos[2] = top; 
                        xpos[3] = left + 1'b1; 
                        ypos[3] = top + 1'b1; 
                    end
                2'b01 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top; 
                        xpos[1] = left; 
                        ypos[1] = top + 1'b1; 
                        xpos[2] = left + 1'b1; 
                        ypos[2] = top; 
                        xpos[3] = left + 1'b1; 
                        ypos[3] = top + 1'b1; 
                    end
                2'b10 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top; 
                        xpos[1] = left; 
                        ypos[1] = top + 1'b1; 
                        xpos[2] = left + 1'b1; 
                        ypos[2] = top; 
                        xpos[3] = left + 1'b1; 
                        ypos[3] = top + 1'b1; 
                    end
                2'b11 : 
                    begin
                        xpos[0] = left; 
                        ypos[0] = top; 
                        xpos[1] = left; 
                        ypos[1] = top + 1'b1; 
                        xpos[2] = left + 1'b1; 
                        ypos[2] = top; 
                        xpos[3] = left + 1'b1; 
                        ypos[3] = top + 1'b1; 
                    end
					default:	;
            endcase
        end
        else
        begin
            xpos = xpos;
            ypos = ypos;
        end
    end
endmodule
