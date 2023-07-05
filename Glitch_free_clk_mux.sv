Created BY : JASKARAN SINGH
module Glitchfree_clk_mux 
(
    input  clk1_i,           // CLOCK 1
    input  clk0_i,           // CLOCK 2
    input  select_i,         //CLOCK select_i LINE
    input  rstn_i,           // SYSTEM RESET
    output clk_o             // CLOCK SELECTED
);

// TEMP FLOP USED FOR REGISTERING THE SEL SIGNALS
reg sel1_r;
reg sel1;
reg sel0_r;
reg sel0;

//PROC BLOCK 1:
//THIS BLOCK REGISTERS SELECTS LINE THE clk1_i

always_ff @(posedge clk1_i or negedge rstn_i)
begin
    if(rstn_i == 1'b0)
        begin
            sel1_r <= 0;
        end
    else
        begin
            sel1_r <= ~sel0 & select_i;
        end
end

//PROC BLOCK 2:
//THIS BLOCK PASSES THE REGISTERED SELECT LINE FROM 2ND FLOP THAT IS NEGEDGE TRIGGERED


always_ff @(negedge clk1_i or negedge rstn_i)
begin
    if(rstn_i == 1'b0)
        begin
            sel1 <= 0;
        end
    else
        begin
            sel1 <= sel1_r;
        end
end

//PROC BLOCK 2:
//THIS BLOCK REGISTERS SELECTS LINE THE clk0_i

always_ff @(posedge clk0_i or negedge rstn_i)
begin
    if(rstn_i == 1'b0)
        begin
            sel0_r <= 0;
        end
    else
        begin
            sel0_r <= ~select_i & ~sel1;
        end
end

//PROC BLOCK 4:
//THIS BLOCK PASSES THE REGISTERED SELECT LINE FROM 2ND FLOP THAT IS NEGEDGE TRIGGERED

always @(negedge clk0_i or negedge rstn_i)
begin
    if(rstn_i == 1'b0)
        begin
            sel0 <= 0
        end
    else
        begin
            sel0 <= sel0_r;
        end
end

//ASSIGN STATMENT TO GENERATED OUTPUT SELCTED CLOCK

assign clk_o = (sel1 & clk1_i) | (sel0 & clk0_i);

endmodule
