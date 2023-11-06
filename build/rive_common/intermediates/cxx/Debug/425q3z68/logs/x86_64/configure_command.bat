@echo off
"C:\\Users\\abiya\\AppData\\Local\\Android\\sdk\\cmake\\3.18.1\\bin\\cmake.exe" ^
  "-HC:\\Users\\abiya\\AppData\\Local\\Pub\\Cache\\hosted\\pub.dev\\rive_common-0.2.7\\android" ^
  "-DCMAKE_SYSTEM_NAME=Android" ^
  "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" ^
  "-DCMAKE_SYSTEM_VERSION=19" ^
  "-DANDROID_PLATFORM=android-19" ^
  "-DANDROID_ABI=x86_64" ^
  "-DCMAKE_ANDROID_ARCH_ABI=x86_64" ^
  "-DANDROID_NDK=C:\\Users\\abiya\\AppData\\Local\\Android\\sdk\\ndk\\25.1.8937393" ^
  "-DCMAKE_ANDROID_NDK=C:\\Users\\abiya\\AppData\\Local\\Android\\sdk\\ndk\\25.1.8937393" ^
  "-DCMAKE_TOOLCHAIN_FILE=C:\\Users\\abiya\\AppData\\Local\\Android\\sdk\\ndk\\25.1.8937393\\build\\cmake\\android.toolchain.cmake" ^
  "-DCMAKE_MAKE_PROGRAM=C:\\Users\\abiya\\AppData\\Local\\Android\\sdk\\cmake\\3.18.1\\bin\\ninja.exe" ^
  "-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=D:\\Belajar\\Flutter\\flutter_fic9_ecommerce_template-master\\build\\rive_common\\intermediates\\cxx\\Debug\\425q3z68\\obj\\x86_64" ^
  "-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=D:\\Belajar\\Flutter\\flutter_fic9_ecommerce_template-master\\build\\rive_common\\intermediates\\cxx\\Debug\\425q3z68\\obj\\x86_64" ^
  "-DCMAKE_BUILD_TYPE=Debug" ^
  "-BC:\\Users\\abiya\\AppData\\Local\\Pub\\Cache\\hosted\\pub.dev\\rive_common-0.2.7\\android\\.cxx\\Debug\\425q3z68\\x86_64" ^
  -GNinja
