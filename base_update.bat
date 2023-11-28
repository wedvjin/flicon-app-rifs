@echo off

set DIR_CUBE_P=C:\Program Files\STMicroelectronics\STM32Cube\STM32CubeProgrammer\bin
"%DIR_CUBE_P%\STM32_Programmer_CLI.exe" -c port=usb1 -w %1 -v -s 0x08008000
