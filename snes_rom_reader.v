module snes_rom_reader
#(
    parameter [2:0] FREQ_DIV = 3'd1
)(
    input reset,
    input enable,
    input clk,
    input [7:0] data,
    output reg [19:0] address = 20'h00000
);
    // freq_div_cnt is incremented up to FREQ_DIV. When they're equal,
    //  address is incremented by 1 and freq_div_cnt is reset to 1.
    reg [2:0] freq_div_cnt = 3'd1;
    reg [7:0] cur_byte = 8'h00;

    always @(negedge clk or posedge reset) begin
        if (reset) begin
            address <= 20'h00000;
            freq_div_cnt <= 3'd1;
            cur_byte <= 8'h00;
        end else if (enable) begin
            if (freq_div_cnt < FREQ_DIV) begin
                freq_div_cnt <= freq_div_cnt + 3'd1;
            end else begin
                address <= address + 20'h00001;
                freq_div_cnt <= 3'd1;
                cur_byte <= data;
            end
        end
    end
endmodule