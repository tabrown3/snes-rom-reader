`timescale 10ns/1ns; // slow rom is 200ns
module tb_snes_rom_reader();

    reg reset = 1'b0;
    reg enable = 1'b1;
    reg clk = 1'b1;
    reg [7:0] data = 8'h00;
    wire [19:0] address;

    // master clk (100ns) is divided by 2 for slow rom to get 200ns
    snes_rom_reader #(.FREQ_DIV(3'd2)) DUT(
        .reset(reset),
        .enable(enable),
        .clk(clk),
        .data(data),
        .address(address)
    );

    initial begin
        #300;
        $stop;
    end

    always begin
        data <= $random;
        #20;
    end

    always begin
        #5;
        clk <= ~clk;
        #5;
        clk <= ~clk;
    end
endmodule