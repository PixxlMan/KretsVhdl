## How it works

Our project consists of 4 separate 8-bit registers which are ddressed separately
 and then read from or written to, either writing the input to the addressed register or reading the value of the addressed register to the output. It uses a MUX to determine the output when reading from a register, a simple control unit is also used for addressing and determining read/write mode.
To test the project, try writing data to the various registers and then try reading it.
The circuit operates in two modes, write or read mode. Read mode is enabled when the write bit (uio[0]) is low, and write mode is enabled when the bit is high.
Select which of the four registers to use using the two selector bits (uio[1],uio[2]). 
The output (uo) will be the value of the selected register if using read mode, and if using write mode the input values (ui) will be written to the register.

![high level schematic](image.png)
