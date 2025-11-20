// Simple LED Blinker for Genesys II (Kintex-7)
// Clock: 200MHz Differential
// Target: 1Hz Blink (0.5s ON, 0.5s OFF)

module led_blinker #(
    // 200 MHz clock = 5ns period. 
    // 0.5 seconds = 100,000,000 cycles.
    parameter COUNT_MAX = 100_000_000 - 1
)(
    input sysclk_p, // Differential Clock Positive
    input sysclk_n, // Differential Clock Negative
    input reset,    // Active-high reset (BtnC)
    output led      // Output to LD0
);

    // Internal single-ended clock signal
    wire clk_200mhz;

    // Instantiate Differential Clock Buffer
    // This converts the LVDS input pair into a standard logic clock
    IBUFGDS #(
        .DIFF_TERM("FALSE"), // Differential Termination (handled on board usually)
        .IBUF_LOW_PWR("TRUE"), 
        .IOSTANDARD("LVDS")
    ) clk_ibufgds (
        .O(clk_200mhz), // Buffer output
        .I(sysclk_p),   // Diff_p buffer input (connect directly to top-level port)
        .IB(sysclk_n)   // Diff_n buffer input (connect directly to top-level port)
    );

    // Counter logic
    // log2(100,000,000) is approx 26.57, so we need 27 bits.
    reg [26:0] count = 27'd0;
    reg led_state = 1'b0;

    always @(posedge clk_200mhz) begin
        // The Genesys 2 buttons are Active High (1 when pressed).
        // We reset when 'reset' is 1.
        if (reset == 1'b1) begin 
            count <= 27'd0;
            led_state <= 1'b0;
        end else begin
            if (count == COUNT_MAX) begin
                count <= 27'd0;
                led_state <= ~led_state;
            end else begin
                count <= count + 1;
            end
        end
    end

    assign led = led_state;

endmodule