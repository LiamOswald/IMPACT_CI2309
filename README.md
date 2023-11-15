# Caravel User Project

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![UPRJ_CI](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml) [![Caravel Build](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml)


## IMPACT_Custom_SRAM_01

University of South Alabama, IMPACT and VLSI lab design.

The chip contains a 32x1024 6T SRAM design (4kb), built from Xschem and Magic EDA tools. The chip is designed to verify and validate the operations of the SRAM bank. All communications for the SRAM chip are routed to GPIO pins for external testing. 

The custom design will be used as a standard comparison against future chips that redefine the SRAM architecture. 

-- Short Description --
The design uses as little of the PicoRV32 CPU as possible, with all SRAM control lines going to GPIO. The design allocates only 8 pins to Data-In and 8 pins for Data-Out. Additional 2 bits are used to select a specific byte from the 32bit word. Functionally when reading or writing to the the device, 32bit registers are used to translate serial byte data from GPIO to 32bit words. The Macro and RTL designs are timed using an external clock via a GPIO pin for additional control. 


-- Pin allocation --
Pins		Description

5 - 12		Data-IN

13 - 20		Data-Out

21 - 30		Memory Address

31 & 32		Byte Select

33		Write Enable

34		Read Enable

35		Word Line Enable

36		Precharge Enable Bar

37		Project Clock




Contributing members of the design.

-William (Liam) Oswald	

-Md. Sajjad Hossain

-Dr. Mario Renteria-Pinon

-Kyle Mooney

-Antony Nguyen




Principal Investigators:


Dr. Jinhui Wang

Dr. Na Gong
