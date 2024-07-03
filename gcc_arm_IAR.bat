
@echo off
setlocal

REM Set the path to IAR Embedded Workbench tools
set IAR_PATH=C:\Program Files\IAR Systems\Embedded Workbench 9.1\arm\bin

REM Set the source files and include directories
set SOURCES=src\main.c
set INCLUDES=-Iinclude

REM Set the output directory and file names
set OUTPUT_DIR=output
set OBJ_DIR=output\obj
set OUTPUT=%OUTPUT_DIR%\project
set ELF_FILE=%OUTPUT%.elf
set HEX_FILE=%OUTPUT%.hex

REM Create the output and object directories if they do not exist
if not exist %OUTPUT_DIR% (
    mkdir %OUTPUT_DIR%
    if %errorlevel% neq 0 (
        echo Error: Could not create output directory %OUTPUT_DIR%
        exit /b 1
    )
)
if not exist %OBJ_DIR% (
    mkdir %OBJ_DIR%
    if %errorlevel% neq 0 (
        echo Error: Could not create object directory %OBJ_DIR%
        exit /b 1
    )
)

REM Set the full path to the linker script
set LINKER_SCRIPT="C:\Program Files\IAR Systems\Embedded Workbench 9.1\arm\config\linker\TexasInstruments\TM4C123GH6.icf"

REM Compile the source files to object files
echo Compiling source files...
for %%f in (%SOURCES%) do (
    "%IAR_PATH%\iccarm" %%f %INCLUDES% --cpu Cortex-M4 --thumb -o %OBJ_DIR%\%%~nf.o
    if %errorlevel% neq 0 (
        echo Error: Compilation failed for %%f
        exit /b 1
    )
)
REM Link the object files
echo Linking object files...
"%IAR_PATH%\ilinkarm" %OBJ_DIR%\main.o --config %LINKER_SCRIPT% -o %ELF_FILE%
if %errorlevel% neq 0 (
    echo Error: Linking failed
    exit /b 1
)

REM Convert the ELF file to a hex file
echo Converting ELF to HEX...
"%IAR_PATH%\ielftool" --ihex %ELF_FILE% %HEX_FILE%
if %errorlevel% neq 0 (
    echo Error: Conversion to HEX failed
    exit /b 1
)
echo Build complete. HEX file generated: %HEX_FILE%


endlocal
