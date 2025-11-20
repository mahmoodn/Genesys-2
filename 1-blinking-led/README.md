This guide details the comprehensive workflow to synthesize, implement, and run a simple blinking LED program on the Digilent Genesys II board. This project serves as the "Hello World" of FPGA development, demonstrating the complete path from writing Hardware Description Language (HDL) code to configuring physical hardware using the Xilinx Vivado toolchain.

# Prerequisites

**Hardware:** Digilent Genesys II Board (Xilinx Kintex-7). Ensure the power supply is connected and the board is turned on.

**Software:** Xilinx Vivado Design Suite (WebPACK or Lab Edition is sufficient).

**Files:** Please download the following files from the repository which we want to add them to the project later.

* `led_blinker.v`: The Verilog design source defining the logic.

* `blinker_test.v`: The testbench for simulation.

* `genesys2.xdc`: The constraints file mapping logic ports to physical pins.

# 1. Create Project

Open Vivado and select **Create Project**. Choose a descriptive name and project location. Select **RTL Project** and check "Do not specify sources at this time" to keep the initial setup clean.

1. Part Selection is Critical: You must match the exact silicon on the board.

2. Select Board: Digilent Genesys 2. Alternatively, select **Part**: Family: Kintex-7, Package: FFG900, Speed: -2. The specific part is `xc7k325tffg900-2`.
Click Finish to initialize the workspace.

The steps are shown in the figures below.

<p align="center">
![project-create-1](https://github.com/user-attachments/assets/dd83efb7-65cb-4037-a12a-fcba65dfb78e)
![project-create-2](https://github.com/user-attachments/assets/27507007-26de-43b3-9e4a-1f81392d247d)
![project-create-3](https://github.com/user-attachments/assets/a21082e3-fa2b-4e0c-952a-481d58459eb9)
![project-create-4](https://github.com/user-attachments/assets/343b93c4-8616-4dd3-b5ab-61ba2227dc10)
![project-create-5](https://github.com/user-attachments/assets/0b1605a9-e43b-4beb-9dbd-133fee3e1581)
</p>



# 2. Add Source Files

In the **Flow Navigator** (left pane), click **Add Sources**.

1. Select **Add or create design sources**, browse to `led_blinker.v` and add it.

2. Select **Add or create simulation sources**, browse to `blinker_test.v` and add it.

3. Select **Add or create constraints**, browse to `genesys2.xdc`, and add it.

Ensure `blinker_test.v` is set as the top module for **Simulation Sources**, and `led_blinker.v` is the top module for **Design Sources**. The steps are shown in the figures below.

<p align="center">
![project-create-6](https://github.com/user-attachments/assets/52da776c-0537-407b-81fa-ab058a0ecc8e)
</p>

# 3. Run Simulation

Before loading onto hardware, it is best practice to verify logic.

1. In **Flow Navigator**, click **Run Simulation -> Run Behavioral Simulation**.

2. A waveform window will open.

Because the testbench reduces the count limit, you should see the led signal toggling every 10 clock cycles (100ns) after the reset is released. Verify the led transitions from 0 to 1 and back. The steps are shown in the figures below.

<p align="center">
![sim1](https://github.com/user-attachments/assets/92aebf6e-8a62-4558-ac1b-acfc30b83237)
![sim2](https://github.com/user-attachments/assets/6106db2e-83a7-4792-8a6e-24e643b523a0)
</p>


# 4. Synthesis and Implementation

This is a two-stage compilation process:

1. Click **Run Synthesis**. This compiles your Verilog code into a logical netlist of gates and flip-flops. It checks for syntax errors and logical validity.

2. Once Synthesis completes, select **Run Implementation**. This step maps the logical netlist onto the actual physical resources of the Kintex-7 chip (Slices, DSPs, BRAMs) and performs routing to connect signals, adhering to the timing constraints.

The steps are shown in the figures below.

<p align="center">
![syn1](https://github.com/user-attachments/assets/0bcb6907-024f-4bd5-808d-09587102e424)
![syn2](https://github.com/user-attachments/assets/907ae205-0d58-4ee8-9475-02e4cd19af79)
![imp1](https://github.com/user-attachments/assets/80118ec0-3507-4e55-9549-f3452656f8aa)
![imp2](https://github.com/user-attachments/assets/8f94e69d-90b8-4662-9b09-2f52fbcd3dbc)
</p>





# 5. Generate Bitstream

After Implementation finishes successfully, select **Generate Bitstream**. This process translates the fully routed design into a binary configuration file (`./genesys2_blinker.runs/impl_1/led_blinker.bit`) that the FPGA understands. This is the final artifact required to program the device. The steps are shown in the figures below.

<p align="center">
![bit](https://github.com/user-attachments/assets/851d8063-e58b-4bac-bebb-7d19df0b0d2d)
</p>

# 6. Program Hardware

Please note that if you have a free version of Vivado on your local PC and a remote server with full features (to run synthesizer), at this point you may want download the generated `.bit` file to you local computer and program the board locally.

1. Connect the Genesys II to your PC via the Micro-USB cable labeled **JTAG**. 

2. In the **Flow Navigator**, expand **Open Hardware Manager** and click **Open Target -> Auto Connect**. Vivado will scan the JTAG chain.

3. Select the detected device (`xc7k325t`). Right-click and choose **Program Device**.

4. Browse to the generated/downloaded `./genesys2_blinker.runs/impl_1/led_blinker.bit` file and click **Program**.

The steps are shown in the figures below.

<p align="center">
![open-target](https://github.com/user-attachments/assets/7e938cf2-253f-4fa1-8d16-292c18b9ed52)
![hardware](https://github.com/user-attachments/assets/b3b908ed-48e3-45f8-8976-d1c8f6d7dab0)
![program1](https://github.com/user-attachments/assets/b493efa5-6ccb-49f9-aa9c-7e015df8e914)
![program2](https://github.com/user-attachments/assets/2292b7a5-41d4-4802-beae-c60aad018db8)
</p>


The FPGA configuration memory is now written. You should immediately see the **LD0** LED blinking at 1Hz and the reset button is **BTNC(E18)**. The steps are shown in the figures below.

<p align="center">
![power](https://github.com/user-attachments/assets/83790bb3-9422-4b30-8353-895a81a1642c)
![jtag](https://github.com/user-attachments/assets/2a553ede-568b-476c-8099-9f7df68ffc4b)
![led-button](https://github.com/user-attachments/assets/6ff71962-19f1-430f-b4c2-8ca9f832fd4b)
</p>
