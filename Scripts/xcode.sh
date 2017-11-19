cd ../ExampleWorkspace/ExampleFramework
mkdir -p build
cd build
cmake .. -GXcode -DTART_TARGET_OS:STRING=iOS -DTART_TARGET_ARCH:STRING=arm64
