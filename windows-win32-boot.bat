@echo off
echo Put your Switch in RCM mode now
tegrarcmsmash\TegraRcmSmash_win32.exe -w --relocator= "payloads/cbfs.bin" "CBFS:payloads/coreboot.rom"
echo Done
pause