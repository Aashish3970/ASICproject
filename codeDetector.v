module  codeDetector(
    input clk,
    input reset,
    input buttonTop,
    input buttonDown,
    input buttonLeft,
    input buttonRight,
    output [6:0] SSG_D
);

parameter IDLE = 3'b000;
parameter ST0= 3'b001;
parameter ST1= 3'b010;
parameter ST2= 3'b011;
parameter ST3= 3'b100;


// reg [3:0] ledValue;
reg [6:0] SSG_D;
reg [2:0] c_state;
reg [4:0] n_state;

reg [2:0]counter;

always @(*) begin
    case(c_state)
    IDLE: if (buttonTop== 1'b1) n_state= ST0;
          else n_state= 3'b000;
    ST0: if (buttonLeft== 1'b1) n_state= ST1;
          else n_state= 3'b000;
    ST1: if (buttonLeft== 1'b1) n_state= ST2;
          else n_state= 3'b000;
    ST2: if (buttonRight== 1'b1) n_state= ST3;
          else n_state= 3'b000;
    ST3: n_state =3'b000;

   default: n_state= 3'b000;
    endcase
end


//always@(negedge reset) rst <= 0;
////Create a timer for 30 clock period, increase timer in each clock posedge after the reset signal


//always@(posedge clk or negedge reset)
//begin
//if (clk) timer <= timer + 1'b1;
//end

always @(posedge clk or posedge reset)
begin
if (reset) c_state <= IDLE;
else c_state <= n_state;
end

 
always@(posedge clk or posedge buttonDown or posedge buttonLeft or posedge buttonRight or posedge buttonTop or posedge reset)
begin
    if (reset) counter <= 3'b000;
    else if(buttonDown || buttonLeft || buttonRight || buttonTop)  counter <= counter + 1'b1;
end

always@(*)
begin
    if(counter == 3'b100)
    begin
        if (c_state == ST3) SSG_D =7'b0010000 ; // display 9
        else  SSG_D= 7'b0000110; // E
    end
    else if (counter == 3'b000) SSG_D= 7'b1000000; //0 
end                                 

endmodule