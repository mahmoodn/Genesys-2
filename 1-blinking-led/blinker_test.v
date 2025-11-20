`timescale 1ns / 1ps

module led_blinker_tb;

    // Inputs
    reg sysclk_p;
    reg sysclk_n;
    reg reset;

    // Outputs
    wire led;

    // Instantiate UUT with small count for simulation speed
    led_blinker #(
        .COUNT_MAX(10)
    ) uut (
        .sysclk_p(sysclk_p),
        .sysclk_n(sysclk_n),
        .reset(reset), 
        .led(led)
    );

    // Clock generation for 200 MHz (5ns period)
    // Toggle every 2.5ns
    initial begin
        sysclk_p = 0;
        sysclk_n = 1;
        forever begin
            #2.5;
            sysclk_p = ~sysclk_p;
            sysclk_n = ~sysclk_n;
        end
    end

    initial begin
        // Initialize Inputs
        reset = 1; // Reset active (High)
        
        // Wait 100 ns
        #100;
        
        // Release reset
        reset = 0;
        $display("Reset released. Simulation started.");
        
        // Run for a while
        #500;
        
        $display("Simulation finished.");
        $finish;
    end
      
endmodule