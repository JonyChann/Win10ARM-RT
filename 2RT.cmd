@echo off
echo.�����ļ������϶��������ϣ�ת�������������ˢ���з��գ�������Ը���
echo.
echo.
echo ======����������surface RT/2 ��U�ָ̻�״̬���������ʹ��========
echo.
echo                                  2020.4 �㼯By comer,v3.15
echo.
echo.
echo ����1 ˢ��WIN8����ʼ����U��\Sources������WIN8 ��install.wim��װ�ļ���
echo.
echo ����2 һ����װWIN10 (����������Ӳ�����·���,��ȫ���ʽ��,������!!!)
echo.
echo ����3 ����ȥWIN10ˮӡ(��ɺ��ٵ�WIN10��Ҽ�����Ա����3Active.bat)
echo.
echo ����0 �����Ѿ���WIN10��ֻ�볢��һ��ˢWIN10 ARM32(ȥˮӡ)�ĳ�ˬ 
echo.
echo  ---- ʲô��������˫���س���,ֱ���˳�
echo.
echo.
set /p choice= ��ѡ��Ҫ���еĲ������� ,Ȼ�󰴻س���:
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
echo ˢ��WIN8 ��ʼ�����ӣ�Ӳ�̽����·�����ʽ����
echo.
pause
echo.
diskpart /s d:\SecureBoot\diskpart
cls
echo.
echo �����ָ���WIN8.1 RT......
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
echo WIN8.1 RT ��װ�ɹ�, ��������˳�
goto exit



:Num2
cls
echo.
echo ��װWIN10 ARM32��Ӳ�̽����·�����ʽ����
echo.
pause
echo.
diskpart /s d:\SecureBoot\diskpart
cls
echo.
echo �����������WIN10 ARM32......
dism /apply-image /imagefile:d:\install.wim /index:1 /applydir:c:\
bcdboot c:\windows /s S: /f uefi /l zh-cn
c:
cd c:\
xcopy d:\Chinese\*.* /s /a /H /R /Y /q
cd c:\windows\system32
del c:\windows\system32\licensingUI.exe
cls
echo.
echo WIN10 ARM32 �ѽ�������, U���Ѿ����԰ε��ˣ�
echo.
echo ����������ؽ���,ѡ��"����"��������,��WIN10��ʼ������(�ڼ���Զ���������)
goto exit


:Num3
cls
echo.
echo ������WIN10 ARM32ϵͳ����ȥˮӡ��
echo.
pause
echo.
c:
cd c:\
xcopy d:\Chinese\*.* /s /a /H /R /Y /q
cls
echo.
echo ȥˮӡ���ܵ�1�������� ����������ؽ��棬ѡ�񡰼�������������WIN10������3Active.bat���ȥˮӡ
goto exit



:Num9 
cls
echo.
echo ������EFI��������,�ؽ�BCD��
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
echo ���޸����, U���Ѿ����԰ε��ˣ�
echo.
echo ����������ؽ���,ѡ�񡰼������������ԣ�����WIN10��ʼ�����ã��ڼ���Զ��������Σ�
goto exit


:Num0
cls
echo.
echo һ��ˢWIN10����ϵͳ����ʽ����
pause
diskpart /s d:\SecureBoot\RUN
cls
echo.
echo �����������WIN10 ARM32......
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
echo WIN10 ARM32 �ѽ�������, U���Ѿ����԰ε��ˣ�
echo ��������˳���ѡ�񡰼������������ԣ�����WIN10��ʼ�����ã��ڼ���Զ��������Σ�
goto exit


:exit
pause>nul&&exit
