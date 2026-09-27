#!/bin/bash
echo "=== AIRA SDR Estarreja - Compilador Automatico ==="
if ! command -v java &> /dev/null; then
  echo "Instala Java 17"
  exit 1
fi
if [ ! -d "cmdline-tools" ]; then
  echo "A descarregar Android SDK..."
  wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O tools.zip
  unzip -q tools.zip
  mkdir -p cmdline-tools/latest
  mv cmdline-tools/bin cmdline-tools/latest/
  mv cmdline-tools/lib cmdline-tools/latest/ 2>/dev/null || true
  mv cmdline-tools/NOTICE.txt cmdline-tools/latest/ 2>/dev/null || true
fi
export ANDROID_HOME=$(pwd)/android-sdk
export ANDROID_SDK_ROOT=$(pwd)/android-sdk
mkdir -p $ANDROID_HOME
mv cmdline-tools $ANDROID_HOME/ 2>/dev/null || true
$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --install "platform-tools" "platforms;android-34" "build-tools;34.0.0"
echo "A compilar..."
./gradlew assembleDebug || gradle wrapper && ./gradlew assembleDebug
echo "APK em app/build/outputs/apk/debug/app-debug.apk"
