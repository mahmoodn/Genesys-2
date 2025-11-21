This tutorial guides you through creating a persistent bitstream for your Genesys 2 FPGA, ensuring the LED blinking program runs automatically whenever the board is powered on. 
The board has an on-board non-volatile Quad-SPI flash memory which allows the Kintex-7 FPGA to configure itself immediately upon power-up without needing a programmer connected. Please note that:

* The flash chip manufacturer is Spansion and product number starts with `fl256` as shown below:
* Make sure the jumper on JP5 is in the QSPI position as shown below:

# Prerequisites

This tutorial assumes you have run the simple [blinking LED tutorial](https://github.com/mahmoodn/Genesys-2/tree/main/1-blinking-led). The source, simulation and constraint files are the same as the first tutorial. They only difference between this tutorial and the previous one, is the way we program the device. Therefore, before continuing, make sure you have syntheize and implemented the blinking LED correctly.

# Configuring Bitstream Generation for Quad-SPI Flash

For the four ways to program your Genesys2 FPGA there are two file types available; `.bit` and `.bin` files. Using a `.bit` file we can use either the JTAG programming cable, or a standard USB storage device to load the bit file into the FPGA. Programming with a `.bin` file will use the QuadSPI to program the FPGA each time it is powered on. This means you will not have to reprogram it each time via a micro USB cable or by a thumb drive. The following steps bellow will get you all prepared to program your Genesys 2. In order to program the FPGA on startup we have to specify that we want to generate a .bin file. Please follow the steps below:

1. Go to **Tools** and then **Project Settings** and then **Bitstream**. In this window we will check the box next to **.bin_file**. Now Vivado will create both a `.bit` and `.bin` file when we generate a Bitstream.
2. Click on **Configure additional bitstream settings**.
   2.1. Select **Configuration** on the left and under **Configuration Setup**, set ** Configuration Rate (MHz)** to 33 and under **SPI Configuration**, set **Bus width** to 4.
   2.2. Select ** Configuration Modes** on the left and then check **Master SPI x4**.
3. In the **FLow Navigator**, click on **Generate Bitstream**.
   
Please see the figures below.

![bitstream](https://github.com/user-attachments/assets/ca8040fa-0bd8-4039-bb71-d026cac0a58f)
![configuration](https://github.com/user-attachments/assets/18605b62-1596-4d43-be1d-6246cfcf3a1d)
![master-spi](https://github.com/user-attachments/assets/23f5fe0d-8f69-47bf-9f0f-0ea63b5f0b87)

If the bit stream generation is successful, then you should see two files in `genesys2_blinker_mem.runs/impl_1/`: `led_blinker.bit` and `led_blinker.bin`.

# Programming QSPI Flash

Connect the board to your PC, turn the it on and follow the steps below:

1. From the **Flow Navigator** on the left pane and under **Open Hardware Manager**, select **Open Target** and then **Auto Connect**. You should see that the device has been detected.
2. Under **Open Hardware Manager**, select **Add Configuration Memory Device**. A window will pop up. Search for "Spansion" and select `s25fl256sxxxxxx0-spi-x1_x2_x4`. Click OK on the next window asking if you want to program the configuration memory device.
3. Select the `.bin` file where it asks for a configuration file and finally click OK.

Vivado will now erase the old configuration file, and reprogram your Genesys2 with the demo file. From now on, when you power up the Genesys2, the demo will load at startup until you reprogram it. See the steps below:

![program-debug](https://github.com/user-attachments/assets/ece8e2c9-44f3-41ba-8bc9-2ce9961ba80c)
![mem-config](https://github.com/user-attachments/assets/ecdc040b-170e-4114-b352-badcb3f1e699)
![program3](https://github.com/user-attachments/assets/ad6ec02f-1195-47b4-9956-72eb0ec272c6)
![step1](https://github.com/user-attachments/assets/3258ff2e-5633-416f-9ade-7b5cd7cf13e6)
![step2](https://github.com/user-attachments/assets/9e15c780-7e0c-4fec-a6a9-37fdab28ec30)

