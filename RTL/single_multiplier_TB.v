
`timescale 1ns/1ns 

module multiplier_TB();
  reg clk=0, rst=1;
  reg   [31:0] a, b,valid_z;
  wire   [31:0] z;
  reg a_stb, b_stb, z_ack;
  wire a_ack, b_ack, z_stb;

  initial
  $monitor ("a = %h, b = %h, z = %h valid result: %h, z_ack: %b,z_stb: %b", a, b, z,valid_z,z_ack,z_stb);

  always #10 clk=~clk;  // 25MHz
  
  single_multiplier multiplier(
    .clk(clk),
    .rst(rst),
    .input_a(a),
    .input_a_stb(a_stb),
    .input_a_ack(a_ack),
    .input_b(b),
    .input_b_stb(b_stb),
    .input_b_ack(b_ack),
    .output_z(z),
    .output_z_stb(z_stb),
    .output_z_ack(z_ack));
  initial begin
    $display("this is a test");
    a = 0;
    b = 0;
    rst = 1;
    #1000
    rst = 0;
    //+5 x +3 = +15
    a = 32'h40A00000;
    b = 32'h40400000;
    valid_z = 32'h41700000;
    a_stb = 1;
    b_stb = 1;
    #2000
    z_ack = 1;
    //+7 x -5 = -35
    a = 32'hC0A00000;
    b = 32'h40E00000;
    valid_z = 32'hC20C0000;
    #100
    z_ack = 0;
    #2000 
    $stop;
  end
endmodule
