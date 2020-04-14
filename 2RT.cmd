@echo off
echo.所有文件及资料都来自网上，转载请标明出处，刷机有风险，后果请自负！
echo.
echo.
echo ======本程序须在surface RT/2 的U盘恢复状态的命令窗口下使用========
echo.
echo                                  2020.4 汇集By comer,v3.15
echo.
echo.
echo 数字1 刷回WIN8做初始化（U盘\Sources下须有WIN8 的install.wim安装文件）
echo.
echo 数字2 一键安装WIN10 (本条操作将硬盘重新分区,并全面格式化,请慎重!!!)
echo.
echo 数字3 单独去WIN10水印(完成后再到WIN10里，右键管理员运行3Active.bat)
echo.
echo 数字0 现在已经是WIN10，只想尝试一键刷WIN10 ARM32(去水印)的畅爽 
echo.
echo  ---- 什么都不做，双击回车键,直接退出
echo.
echo.
set /p choice= 请选择要进行的操作数字 ,然后按回车键:
if "%choice%"=="1" goto Num1
if "%choice%"=="2" goto Num2
if "%choice%"=="3" goto Num3
if "%choice%"=="9" goto Num9
if "%choice%"=="0" goto Num0
if "%choice%"=="" goto Exit
goto Exit



:Num1
cls
echo.
echo 刷回WIN8 初始化机子，硬盘将重新分区格式化！
echo.
pause
echo.
diskpart /s d:\SecureBoot\diskpart
cls
echo.
echo 即将恢复成WIN8.1 RT......
dism /apply-image /imagefile:d:\sources\install.wim /index:1 /applydir:c:\
bcdboot c:\windows /s S: /f uefi /l zh-cn
mountvol S: /s
S:
cd S:\EFI
xcopy d:\EFISP\*.* /s /y /q
del S:\EFI\Microsoft\Boot\BCD
bootrec /rebuildbcd
bcdedit /store S:\EFI\Microsoft\Boot\BCD /set {bootmgr} testsigning on
bcdedit /store S:\EFI\Microsoft\Boot\BCD /set {bootmgr} nointegritychecks on
bcdedit /store S:\EFI\Microsoft\Boot\BCD /set {default} testsigning on
bcdedit /store S:\EFI\Microsoft\Boot\BCD /set {default} nointegritychecks on
rem bcdedit /enum
cls
echo.
echo WIN8.1 RT 安装成功, 按任意键退出
goto exit



:Num2
cls
echo.
echo 安装WIN10 ARM32，硬盘将重新分区格式化！
echo.
pause
echo.
diskpart /s d:\SecureBoot\diskpart
cls
echo.
echo 即将解包部署WIN10 ARM32......
dism /apply-image /imagefile:d:\install.wim /index:1 /applydir:c:\
bcdboot c:\windows /s S: /f uefi /l zh-cn
c:
cd c:\
xcopy d:\Chinese\*.* /s /a /H /R /Y /q
cd c:\windows\system32
del c:\windows\system32\licensingUI.exe
cls
echo.
echo WIN10 ARM32 已解包部署好, U盘已经可以拔掉了！
echo.
echo 按任意键返回界面,选择"继续"重启电脑,进WIN10初始化设置(期间会自动重启两次)
goto exit


:Num3
cls
echo.
echo 将进行WIN10 ARM32系统单独去水印！
echo.
pause
echo.
c:
cd c:\
xcopy d:\Chinese\*.* /s /a /H /R /Y /q
cls
echo.
echo 去水印功能第1步结束， 按任意键返回界面，选择“继续”重启，进WIN10后运行3Active.bat完成去水印
goto exit



:Num9 
cls
echo.
echo 将更新EFI引导分区,重建BCD！
echo.
pause
echo.
mountvol S: /s
S:
cd S:\EFI
xcopy d:\EFISP\*.* /s /y /q
del S:\EFI\Microsoft\Boot\BCD
bootrec /rebuildbcd
bcdedit /store S:\EFI\Microsoft\Boot\BCD /set {bootmgr} testsigning on
bcdedit /store S:\EFI\Microsoft\Boot\BCD /set {bootmgr} nointegritychecks on
bcdedit /store S:\EFI\Microsoft\Boot\BCD /set {default} testsigning on
bcdedit /store S:\EFI\Microsoft\Boot\BCD /set {default} nointegritychecks on
mountvol S: /d
cls
bcdedit /enum
echo.
echo 已修复完毕, U盘已经可以拔掉了！
echo.
echo 按任意键返回界面,选择“继续”重启电脑，进入WIN10初始化设置（期间会自动重启两次）
goto exit


:Num0
cls
echo.
echo 一键刷WIN10，仅系统区格式化！
pause
diskpart /s d:\SecureBoot\RUN
cls
echo.
echo 即将解包部署WIN10 ARM32......
dism /apply-image /imagefile:d:\install.wim /index:1 /applydir:c:\
rem bootrec /rebuildbcd
c:
cd c:\
xcopy d:\Chinese\*.* /s /a /H /R /Y /q
cd c:\windows\system32
del c:\windows\system32\licensingUI.exe
cls
rem bcdedit /enum
echo.
echo WIN10 ARM32 已解包部署好, U盘已经可以拔掉了！
echo 按任意键退出，选择“继续”重启电脑，进入WIN10初始化设置（期间会自动重启两次）
goto exit


:exit
pause>nul&&exit
