@echo off
echo.
echo.�����ļ������϶��������ϣ�ת�������������ˢ���з��գ�������Ը���
echo.
echo.
echo ���������������磬���ű�������WIN10��ȥˮӡ������װӦ���̵�Ȼ�������
echo.
echo                                          2020.4 �㼯By comer,V3.15
echo.
echo.
echo ����1  ����WIN10���Ż����ġ�ȥˮӡ,��װӦ���̵�ȣ���ȷ�������Ӻ�����)
echo.
echo ����2  ����ȥˮӡר�� (�˲�ǰ,������U�ָ̻�ģʽ����2RT.cmd������3�˵�)
echo.
echo ����3  ��ˢWIN10��,�����������豸,������win8�н�SecureBoot(�Ǳ�������)
echo.
echo -----  ʲô������,˫���س���,ֱ���˳�
echo.
echo.
set /p choice= ��ѡ��Ҫ���еĲ������� ,Ȼ�󰴻س���:
if "%choice%"=="1" goto Num1
if "%choice%"=="2" goto Num2
if "%choice%"=="3" goto Num3
if "%choice%"=="" goto Exit
goto Exit


:Num1
cls
echo.
echo ����װ���п⡢IE��Flash��Ӧ���̵�� ......
cd d:\APPXs\
powershell.exe -command Set-executionpolicy "bypass"
powershell.exe -command get-executionpolicy
powershell.exe -command "&{%~dp0\APPXs\install.ps1}"
cls
echo.
echo �����밴��ʾ��ȷ��,���ȷ�ϻش�"Y"����Զ�������ɰ�װ
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
echo ������ȥˮӡ ���˲�ǰ��������U�ָ̻�ģʽ����2RT.cmd�� ����3 �˵��󣬲������ȥˮӡ��.....
pause
regedit.exe/s %desk%\SecureBoot\DisableUAC.reg
echo.
echo ������ɣ�������˳���ˢ��һ�����漴����ȫȥˮӡ
goto exit


:Num3
cls
set EnableLUA=0
for /f "tokens=2,*" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA"') do (
set EnableLUA=%%j)
rem echo ע���HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System��EnableLUALֵΪ��%EnableLUA%
if  "%EnableLUA%"=="0x0" goto do2
echo.
echo ��Secure Boot��Ҫ��WIN8��һ����������3Active.bat
echo.
echo ���ǵ�һ������3Active.bat,����ֹUAC��ִ�к��Զ�������WIN8
echo.
echo ��ϵͳ���Ҽ�����Ա������һ��3Active.bat�����ƽ�
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
echo ���ǵڶ�����WIN8������3Active.bat
echo.
echo ��һ�ν�����Secure Boot�ƽ�ĺ�����������װ"����"��
echo.
echo ����ƽ�󣬿ɽ�U�ָ̻�ģʽһ����װWIN10
echo.
pause
cls
echo.
echo �������ڼ����ϰ���WINͼ���+R����������regeditȷ��
echo.
echo �ڴ򿪵�ע����ѡ��HKKEY_LOCAL_MACHINE\BCD00000000
echo.
echo Ȼ�������"�ļ�"�˵��е�"ж�����õ�Ԫ"����ȷ����ɺ�
echo.
pause
echo.
for /f "tokens=2,*" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Desktop"') do (set desk=%%j)
echo.
echo ���ڸ���U������ļ������������......
xcopy /q /y d:\SecureBoot\*.*  %desk%\SecureBoot\
cd %desk%\SecureBoot\
cls
echo.
echo ����ȥ��ִ���ƽ�Secure Boot�����һ�����裨ִ��"����"��
echo.
echo ��ʾ�ĸ�"ִ�гɹ���"���������Զ�����
echo.
echo �������ֽ����,�û������"����-��"ѡ��Accept and Insatll
echo.
echo Ȼ����������Ļ�·��ġ�WINͼ�ꡱ,ȷ��ִ�н�SecureBoot
echo.
echo ���޳�����Ϣ���ص�WIN8,��ʱ�ɽ�U�ָ̻�ģʽһ����װWIN10��
echo.
pause
echo.
%desk%\SecureBoot\InstallPolicy.cmd
goto exit


:exit
pause>nul&&exit

