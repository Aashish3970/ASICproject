module codeDetector_tb();

    parameter half_cycle=5;

    reg clk;
    reg buttonTop;
    reg buttonDown;
    reg buttonLeft;
    reg buttonRight;
    reg buttonReset;
    wire [6:0]SSG_D;

    codeDetector insta1(clk,buttonReset,buttonTop, buttonDown,buttonLeft,buttonRight, SSG_D);

    initial
    begin
        buttonReset=0;
        clk=0;
        buttonTop=0;
        buttonRight=0;
        buttonLeft=0;
        buttonDown=0;
    end

    always 
        #half_cycle clk=!clk;

    initial
    begin
        #20 buttonReset=1;
        #30 buttonReset=0;
        #5 buttonTop=1;
        #5 buttonTop=0;
        #5 buttonLeft=1;
        #5 buttonLeft=0;
        #5 buttonLeft=1;
        #5 buttonLeft=0;
        #5 buttonRight=1;
        #5 buttonRight=0;
        #5 buttonReset=1;
        #5 buttonReset=0;
////       InCorrect Code
//        #20 buttonReset=1;
//        #30 buttonReset=0;
        #5 buttonTop=1;
        #5 buttonTop=0;
        #5 buttonRight=1;
        #5 buttonRight=0;
        #5 buttonLeft=1;
        #5 buttonLeft=0;
        #5 buttonRight=1;
        #5 buttonRight=0;       
        #30 $finish;
    end

    initial
    begin
        $monitor($time,"clk=%b,rst=%b, top=%b,btm=%b,left=%b, right=%b,SSG_D= %b",clk,buttonReset,buttonTop,buttonDown,buttonLeft,buttonRight,SSG_D[6:0]);
    end
endmodule
