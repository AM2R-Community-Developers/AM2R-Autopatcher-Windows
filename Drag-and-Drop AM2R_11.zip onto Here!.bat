@ECHO OFF
SET version=15_2

REM AM2R Patching Utility
REM Written by Wanderer
REM Maintained by Lojical

SET output=AM2R_%version%

ECHO AM2R v11 to v%version% Patching Utility
ECHO ----------------------------------
ECHO.

cd "%~dp0"


REM Clean up existing files.
if exist %output% rmdir /s /q %output%
if exist utilities\android\assets rmdir /s /q utilities\android\assets
if exist utilities\android\AM2RWrapper.apk del utilities\android\AM2RWrapper.apk
if exist AndroidM2R_%version%-signed.apk del AndroidM2R_%version%-signed.apk


echo Java check...
where java > nul
SET JavaCode=%ErrorLevel%
if "%JavaCode%" == "0" (
	echo Found.
) else (
	echo Not found.
)
echo.


if "%~x1" == ".zip" (
	ECHO Extracting AM2R_11.zip to %output%...
	utilities\7za920\7za.exe x "%~1" -y -o%output% > nul
) else (
	ECHO Copying AM2R_11 to %output%...
	MD %output%
	echo D | xcopy /s /v /y /q "%~1" %output%
)

if not exist %output% (
	ECHO.
	ECHO Extraction failed!
	ECHO Aborting patching process.
	ECHO Extract AM2R_11.zip manually and try again with that folder.
	ECHO It is recommended to complete this process from the desktop.
	ECHO.
	pause
	exit /b
)

ECHO Extraction successful.
ECHO.


utilities\gui\DropDownBox.exe "Windows;Android" "Choose your target platform:" "Platform" /I:0 /RI /C:13 >NUL
SET ReturnCode=%ErrorLevel%

if "%ReturnCode%"=="0" (
	rmdir /s /q %output%
	exit /b
)

if "%ReturnCode%"=="2" (
	if not "%JavaCode%" == "0" (
		rmdir /s /q %output%
		utilities\gui\MessageBox.exe "Java was not found by this patcher! Java is required to sign the APK (app) and a signature is required to install to Android. Please do a standard installation of Java to this PC to create the Android version." "Warning!" "OK" "Exclamation" > nul
		exit /b
	)
)


ECHO Patching AM2R.exe...
REM utilities\floating\flips.exe --apply patch_data\AM2R.bps %output%\data.win %output%\AM2R.exe
utilities\xdelta\xdelta3.exe -f -d -s %output%\data.win patch_data\AM2R.xdelta %output%\AM2R.exe
ECHO.

if not "%ErrorLevel%"=="0" (
	ECHO Patching failed!
	ECHO Aborting patching process.
	ECHO This patch applies ONLY to v1.1 of AM2R.
	ECHO.
	rmdir /s /q %output%
	pause
	exit /b
)

REM del /q %output%\data.win

if not "%ErrorLevel%"=="0" (
	ECHO Patching failed!
	ECHO Aborting patching process.
	ECHO This patch applies ONLY to v1.1 of AM2R.
	ECHO.
	rmdir /s /q %output%
	pause
	exit /b
)


ECHO Copying patch files...
xcopy /s /v /y /q patch_data\files_to_copy %output%

Call :YesNoBox "Install high quality in-game music? Increases filesize by 194 MB!"

if "%YesNo%"=="6" (
	REM IF "%ReturnCode%"=="2" utilities\gui\MessageBox.exe "You have chosen to install high quality music to the Android package. While this will work, please note that performance may suffer on slower devices, and music may be distorted. If you experience slowdowns and hangs, or the music is distorted, please try recreating the package with standard quality music." "Warning!" "OK" "Exclamation" > nul
	
	ECHO.
	ECHO Copying high quality music...
	xcopy /s /v /y /q patch_data\HDR_HQ_in-game_music %output%
)


rem PACKAGE ANDROID APK
IF "%ReturnCode%"=="2" (

	ECHO.
	ECHO Packaging Android APK...

	xcopy /s /v /y /q patch_data\android\AM2RWrapper.apk utilities\android > nul

	move %output% utilities\android\assets > nul
	
	xcopy /s /v /y /q patch_data\android\AM2R.ini utilities\android\assets > nul
	
	ECHO Patching game.droid...
	REM utilities\floating\flips.exe --apply patch_data\droid.bps utilities\android\assets\AM2R.exe utilities\android\assets\game.droid
	utilities\xdelta\xdelta3.exe -f -d -s utilities\android\assets\data.win patch_data\droid.xdelta utilities\android\assets\game.droid

	call utilities\android\apk_package_assets.bat

	cd "%~dp0"

	rmdir /s /q utilities\android\assets

	move utilities\android\AM2RWrapper-aligned-debugSigned.apk AndroidM2R_%version%-signed.apk > nul
)

if "%ReturnCode%"=="1" (
    del /q %output%\data.win
)

ECHO.
ECHO The operation was completed successfully. See you next mission!

IF "%ReturnCode%"=="1" explorer /select,%output%
IF "%ReturnCode%"=="2" explorer /select,AndroidM2R_%version%-signed.apk

timeout /t 8

exit /b


REM Pop-up prompt code below.
:YesNoBox
REM returns 6 = Yes, 7 = No. Type=4 = Yes/No
set YesNo=
set MsgType=4
set heading=%~2
set message=%~1
echo wscript.echo msgbox(WScript.Arguments(0),%MsgType%,WScript.Arguments(1)) >"%temp%\input.vbs"
for /f "tokens=* delims=" %%a in ('cscript //nologo "%temp%\input.vbs" "%message%" "%heading%"') do set YesNo=%%a
exit /b