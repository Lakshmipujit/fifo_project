`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.02.2026 10:41:02
// Design Name: 
// Module Name: fifo
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



module fifo #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 16
)(
    input  wire                    clk,
    input  wire                    rst,
    input  wire                    wr_en,
    input  wire                    rd_en,
    input  wire [DATA_WIDTH-1:0]   din,
    output reg  [DATA_WIDTH-1:0]   dout,
    output wire                    full,
    output wire                    empty
);

    localparam ADDR_WIDTH = $clog2(DEPTH);

    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
    reg [ADDR_WIDTH:0] wr_ptr;
    reg [ADDR_WIDTH:0] rd_ptr;

    wire [ADDR_WIDTH-1:0] wr_addr = wr_ptr[ADDR_WIDTH-1:0];
    wire [ADDR_WIDTH-1:0] rd_addr = rd_ptr[ADDR_WIDTH-1:0];

    // Full and Empty logic
    assign empty = (wr_ptr == rd_ptr);
    assign full  = (wr_ptr[ADDR_WIDTH] != rd_ptr[ADDR_WIDTH]) &&
                   (wr_ptr[ADDR_WIDTH-1:0] == rd_ptr[ADDR_WIDTH-1:0]);

    // Write Logic
    always @(posedge clk) begin
        if (rst) begin
            wr_ptr <= 0;
        end else if (wr_en && !full) begin
            mem[wr_addr] <= din;
            wr_ptr <= wr_ptr + 1;
        end
    end

    // Read Logic
    always @(posedge clk) begin
        if (rst) begin
            rd_ptr <= 0;
            dout   <= 0;
        end else if (rd_en && !empty) begin
            dout <= mem[rd_addr];
            rd_ptr <= rd_ptr + 1;
        end
    end

endmodule

