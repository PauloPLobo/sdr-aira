@echo off
echo === AIRA SDR Estarreja - Compilador Automatico ===
echo A verificar Java...
java -version
if %errorlevel% neq 0 (
  echo Instala Java 17 primeiro: https://adoptium.net
  pause
  exit /b
)

echo A descarregar Android Command Line Tools...
if not exist cmdline-tools (
  powershell -Command "Invoke-WebRequest -Uri https://dl.google.com/android/repository/commandlinetools-win-11076708_latest.zip -OutFile tools.zip"
  powershell -Command "Expand-Archive tools.zip -Force"
  mkdir cmdline-tools\latest
  move cmdline-tools\bin cmdline-tools\latest\
  move cmdline-tools\lib cmdline-tools\latest\
)

set ANDROID_HOME=%CD%\android-sdk
set ANDROID_SDK_ROOT=%CD%\android-sdk
mkdir %ANDROID_HOME% 2>nul
move cmdline-tools %ANDROID_HOME%\ 2>nul

echo A instalar SDK...
%ANDROID_HOME%\cmdline-tools\latest\bin\sdkmanager.bat --install "platform-tools" "platforms;android-34" "build-tools;34.0.0"

echo A compilar APK...
call gradlew.bat assembleDebug 2>nul || (
  echo A criar projeto Gradle wrapper...
  gradle wrapper
  gradlew.bat assembleDebug
)

echo.
echo APK GERADO EM: app\build\outputs\apk\debug\app-debug.apk
pause
