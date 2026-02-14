`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.02.2026 10:51:19
// Design Name: 
// Module Name: fifo_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////




module fifo_tb;

    parameter DATA_WIDTH = 8;
    parameter DEPTH = 16;

    reg clk;
    reg rst;
    reg wr_en;
    reg rd_en;
    reg [DATA_WIDTH-1:0] din;
    wire [DATA_WIDTH-1:0] dout;
    wire full;
    wire empty;

    integer i;
    reg [DATA_WIDTH-1:0] test_data [0:DEPTH-1];

    fifo #(DATA_WIDTH, DEPTH) DUT (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .din(din),
        .dout(dout),
        .full(full),
        .empty(empty)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        wr_en = 0;
        rd_en = 0;
        din = 0;

        #20 rst = 0;

        // Write phase
        for (i = 0; i < DEPTH; i = i + 1) begin
            @(posedge clk);
            if (!full) begin
                wr_en = 1;
                din = i + 10;
                test_data[i] = i + 10;
            end
        end
        @(posedge clk);
        wr_en = 0;

        // Read phase
        for (i = 0; i < DEPTH; i = i + 1) begin
            @(posedge clk);
            if (!empty) begin
                rd_en = 1;
                @(posedge clk);
                if (dout !== test_data[i]) begin
                    $display("ERROR at index %0d: Expected %0d, Got %0d",
                              i, test_data[i], dout);
                end else begin
                    $display("PASS at index %0d: %0d",
                              i, dout);
                end
            end
        end

        rd_en = 0;

        #20;
        $display("Simulation Finished");
        $finish;
    end

endmodule
