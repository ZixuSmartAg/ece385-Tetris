module  tetromino ( input  Clk,
                         Reset,
                  input [6:0] shape_type,
                  input [4:0] left, top,  
                  input [1:0]   rotation,
                  output [4:0] xpos[3:0],
                  output [4:0] ypos[3:0],
                  output [4:0] height
                  );

    always_comb
    begin
        case(shape_type)
            7'b0000001://s
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
                                height = 2'b10;
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
                                height = 2'b11;
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
                                height = 2'b10;
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
                                height = 2'b11;
                            end
                        default:	
                        begin
                                xpos[0] = left; 
                                ypos[0] = top + 1'b1; 
                                xpos[1] = left + 1'b1; 
                                ypos[1] = top; 
                                xpos[2] = left + 1'b1; 
                                ypos[2] = top + 1'b1; 
                                xpos[3] = left + 2'b10; 
                                ypos[3] = top; 
                                height = 2'b10;
                        end
                    endcase
                end
            7'b0000010://z
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
                                height = 2'b10;
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
                                height = 2'b11;
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
                                height = 2'b10;
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
                                height = 2'b11;
                            end
                            default:	
                            begin
                                xpos[0] = left; 
                                ypos[0] = top; 
                                xpos[1] = left + 1'b1; 
                                ypos[1] = top; 
                                xpos[2] = left + 1'b1; 
                                ypos[2] = top + 1'b1; 
                                xpos[3] = left + 2'b10; 
                                ypos[3] = top + 1'b1; 
                                height = 2'b10;
                            end
                    endcase
                end
            7'b0000100://t
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
                                height = 2'b10;
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
                                height = 2'b11;
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
                                ypos[3] = top + 1'b1; 
                                height = 2'b10;
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
                                height = 2'b11;
                            end
                            default:
                            begin
                                xpos[0] = left; 
                                ypos[0] = top; 
                                xpos[1] = left + 1'b1; 
                                ypos[1] = top; 
                                xpos[2] = left + 1'b1; 
                                ypos[2] = top + 1'b1; 
                                xpos[3] = left + 2'b10; 
                                ypos[3] = top; 
                                height = 2'b10;
                            end
                    endcase
                end
            7'b0001000://l
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
                                height = 2'b10;
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
                                height = 2'b11;
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
                                height = 2'b10;
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
                                height = 2'b11;
                            end
                            default:
                            begin
                                xpos[0] = left; 
                                ypos[0] = top; 
                                xpos[1] = left; 
                                ypos[1] = top + 1'b1; 
                                xpos[2] = left + 1'b1; 
                                ypos[2] = top; 
                                xpos[3] = left + 2'b10; 
                                ypos[3] = top; 
                                height = 2'b10;
                            end
                    endcase
                end
            7'b0010000://line
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
                                height = 1'b1;
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
                                height = 3'b100;
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
                                height = 1'b1;
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
                                height = 3'b100;
                            end
                            default:
                            begin
                                xpos[0] = left; 
                                ypos[0] = top; 
                                xpos[1] = left + 1'b1; 
                                ypos[1] = top; 
                                xpos[2] = left + 2'b10; 
                                ypos[2] = top; 
                                xpos[3] = left + 2'b11; 
                                ypos[3] = top; 
                                height = 1'b1;
                            end
                    endcase
                end
            7'b0100000://ml
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
                                height = 2'b10;
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
                                height = 2'b11;
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
                                height = 2'b10;
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
                                height = 2'b11;
                            end
                            default:
                            begin
                                xpos[0] = left; 
                                ypos[0] = top; 
                                xpos[1] = left + 1'b1; 
                                ypos[1] = top; 
                                xpos[2] = left + 2'b10; 
                                ypos[2] = top; 
                                xpos[3] = left + 2'b10; 
                                ypos[3] = top + 1'b1; 
                                height = 2'b10;
                            end
                    endcase
                end
            7'b1000000://square
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
                                height = 2'b10;
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
                                height = 2'b10;
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
                                height = 2'b10;
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
                                height = 2'b10;
                            end
                            default:
                            begin
                                xpos[0] = left; 
                                ypos[0] = top; 
                                xpos[1] = left; 
                                ypos[1] = top + 1'b1; 
                                xpos[2] = left + 1'b1; 
                                ypos[2] = top; 
                                xpos[3] = left + 1'b1; 
                                ypos[3] = top + 1'b1; 
                                height = 2'b10;
                            end
                    endcase
                end
            default:
            begin
                xpos[0] = left; 
                ypos[0] = top + 1'b1; 
                xpos[1] = left + 1'b1; 
                ypos[1] = top; 
                xpos[2] = left + 1'b1; 
                ypos[2] = top + 1'b1; 
                xpos[3] = left + 2'b10; 
                ypos[3] = top; 
                height = 2'b10;
            end
        endcase
    end
endmodule
