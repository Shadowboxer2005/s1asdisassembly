@ECHO OFF

REM // make sure we can write to the file s1built.bin
REM // also make a backup to s1built.prev.bin
IF NOT EXIST s1built.bin goto LABLNOCOPY
IF EXIST s1built.prev.bin del s1built.prev.bin
IF EXIST s1built.prev.bin goto LABLNOCOPY
move /Y s1built.bin s1built.prev.bin
IF EXIST s1built.bin goto LABLERROR3
REM IF EXIST s1built.prev.bin copy /Y s1built.prev.bin s1built.bin
:LABLNOCOPY

REM // delete some intermediate assembler output just in case
IF EXIST s1.p del s1.p
IF EXIST s1.p goto LABLERROR2
IF EXIST s1.h del s1.h
IF EXIST s1.h goto LABLERROR1

REM // clear the output window
cls


REM // run the assembler
REM // -xx shows the most detailed error output
REM // -c outputs a shared file (s1.h)
REM // -A gives us a small speedup
set AS_MSGPATH=win32/msg
set USEANSI=n

REM // allow the user to choose to print error messages out by supplying the -pe parameter
IF "%1"=="-pe" ( "win32/asw" -xx -c -A -L s1.asm ) ELSE "win32/asw" -xx -c -E -A -L s1.asm

REM // if there were errors, there won't be any s1.p output
IF NOT EXIST s1.p goto LABLERROR5

REM // combine the assembler output into a rom
"win32/s1p2bin" s1.p s1built.bin s1.h

REM REM // fix the rom header (checksum)
IF EXIST s1built.bin "win32/fixheader" s1built.bin

REM // if there were errors/warnings, a log file is produced
IF EXIST s1.log goto LABLERROR4


REM // done -- pause if we seem to have failed, then exit
IF EXIST s1built.bin exit /b

pause


exit /b

:LABLERROR1
echo Failed to build because write access to s1.h was denied.
pause


exit /b

:LABLERROR2
echo Failed to build because write access to s1.p was denied.
pause


exit /b

:LABLERROR3
echo Failed to build because write access to s1built.bin was denied.
pause

exit /b

:LABLERROR4
REM // display a noticeable message
echo.
echo **********************************************************************
echo *                                                                    *
echo *      There were build warnings. See s1.log for more details.       *
echo *                                                                    *
echo **********************************************************************
echo.
pause

exit /b

:LABLERROR5
REM // display a noticeable message
echo.
echo **********************************************************************
echo *                                                                    *
echo *       There were build errors. See s1.log for more details.        *
echo *                                                                    *
echo **********************************************************************
echo.
pause


