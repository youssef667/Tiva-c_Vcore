@echo off
setlocal

REM Set the path to IAR Embedded Workbench tools
set IAR_PATH=C:\Program Files\IAR Systems\Embedded Workbench 9.1\arm\bin

REM Set the source files and include directories
set SOURCES=src\main.c
set INCLUDES=-Iinclude

REM Set the output file names
set OUTPUT=output
set ELF_FILE=%OUTPUT%.elf
set HEX_FILE=%OUTPUT%.hex

REM Set the full path to the linker script
set LINKER_SCRIPT="C:\Program Files\IAR Systems\Embedded Workbench 9.1\arm\config\linker\TexasInstruments\TM4C123GH6.icf"

REM Compile the source files
"%IAR_PATH%\iccarm" %SOURCES% %INCLUDES% --cpu Cortex-M4 --thumb -o %ELF_FILE%

REM Link the object files
"%IAR_PATH%\ilinkarm" %ELF_FILE% --config %LINKER_SCRIPT% -o %ELF_FILE%

REM Convert the ELF file to a hex file
"%IAR_PATH%\ielftool" --ihex %ELF_FILE% %HEX_FILE%

echo Build complete. HEX file generated: %HEX_FILE%

endlocal