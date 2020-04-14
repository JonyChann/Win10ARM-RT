@echo off
echo.
echo.所有文件及资料都来自网上，转载请标明出处，刷机有风险，后果请自负！
echo.
echo.
echo 现在请连接上网络，本脚本将激活WIN10、去水印，并安装应用商店等基本程序
echo.
echo                                          2020.4 汇集By comer,V3.15
echo.
echo.
echo 数字1  激活WIN10并优化中文、去水印,安装应用商店等（先确保已连接好网络)
echo.
echo 数字2  单独去水印专用 (此步前,需先在U盘恢复模式运行2RT.cmd的数字3菜单)
echo.
echo 数字3  对刷WIN10后,启动黑屏的设备,尝试在win8中解SecureBoot(非必需勿用)
echo.
echo -----  什么都不做,双击回车键,直接退出
echo.
echo.
set /p choice= 请选择要进行的操作数字 ,然后按回车键:
if "%choice%"=="1" goto Num1
if "%choice%"=="2" goto Num2
if "%choice%"=="3" goto Num3
if "%choice%"=="" goto Exit
goto Exit


:Num1
cls
echo.
echo 将安装运行库、IE、Flash和应用商店等 ......
cd d:\APPXs\
powershell.exe -command Set-executionpolicy "bypass"
powershell.exe -command get-executionpolicy
powershell.exe -command "&{%~dp0\APPXs\install.ps1}"
cls
echo.
echo 以下请按提示点确定,最后确认回答"Y"后会自动重启完成安装
echo.
slmgr.vbs /upk
slmgr /ipk NPPR9-FWDCX-D2C8J-H872K-2YT43
slmgr /skms kms.03k.org
slmgr /ato
slmgr /skms zhang.yt
regedit.exe /s d:\SecureBoot\MUIw.reg
echo.
cd d:\APPXs\
xcopy /y /q "d:\APPXs\Flash\Flash.ocx" "C:\Windows\System32\Flash\" 
xcopy /y  /q "d:\APPXs\Flash\FlashPlayerApp.exe" "C:\Windows\System32\Flash\"
xcopy /y  /q "d:\APPXs\Flash\FlashPlayerCPLApp.cpl" "C:\Windows\System32\Flash\"
xcopy /y  /q "d:\APPXs\Flash\FlashUtil_ActiveX.dll" "C:\Windows\System32\Flash\"
xcopy /y  /q "d:\APPXs\Flash\FlashUtil_ActiveX.exe" "C:\Windows\System32\Flash\"
echo.
regsvr32 C:\Windows\System32\Flash\Flash.ocx
echo.
dism /online /add-package /packagepath:microsoft-windows-netfx3-ondemand-package.cab
dism /online /add-package /packagepath:microsoft-windows-internetexplorer-optional-package.cab
goto exit


:Num2
echo.
echo 将单独去水印 （此步前，须先在U盘恢复模式运行2RT.cmd的 数字3 菜单后，才能完成去水印）.....
pause
regedit.exe/s %desk%\SecureBoot\DisableUAC.reg
echo.
echo 运行完成，任意键退出，刷新一下桌面即可完全去水印
goto exit


:Num3
cls
set EnableLUA=0
for /f "tokens=2,*" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA"') do (
set EnableLUA=%%j)
rem echo 注册表HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System的EnableLUAL值为：%EnableLUA%
if  "%EnableLUA%"=="0x0" goto do2
echo.
echo 解Secure Boot需要在WIN8中一共运行两次3Active.bat
echo.
echo 这是第一次运行3Active.bat,来禁止UAC，执行后自动重启回WIN8
echo.
echo 进系统后，右键管理员再运行一次3Active.bat继续破解
echo.
pause
cd d:\SecureBoot\
regedit.exe/sD:\SecureBoot\DisableUAC.reg
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0
shutdown /t 5 /r


goto exit


:do2
cls
echo.
echo 这是第二次在WIN8中运行3Active.bat
echo.
echo 这一次将进行Secure Boot破解的后续工作（安装"规则"）
echo.
echo 完成破解后，可进U盘恢复模式一键安装WIN10
echo.
pause
cls
echo.
echo 现在请在键盘上按“WIN图标键+R键”，输入regedit确定
echo.
echo 在打开的注册表里，选中HKKEY_LOCAL_MACHINE\BCD00000000
echo.
echo 然后点上面"文件"菜单中的"卸载配置单元"，点确定完成后
echo.
pause
echo.
for /f "tokens=2,*" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Desktop"') do (set desk=%%j)
echo.
echo 正在复制U盘相关文件到桌面后运行......
xcopy /q /y d:\SecureBoot\*.*  %desk%\SecureBoot\
cd %desk%\SecureBoot\
cls
echo.
echo 接下去将执行破解Secure Boot的最后一个步骤（执行"规则"）
echo.
echo 显示四个"执行成功后"，机器会自动重启
echo.
echo 进入文字界面后,用机器左侧"音量-键"选中Accept and Insatll
echo.
echo 然后点击机器屏幕下方的“WIN图标”,确认执行解SecureBoot
echo.
echo 如无出错信息将回到WIN8,这时可进U盘恢复模式一键安装WIN10了
echo.
pause
echo.
%desk%\SecureBoot\InstallPolicy.cmd
goto exit


:exit
pause>nul&&exit

