mkdir -p build
cd build
rm -r ./*
cmake ../ExampleWorkspace/ExampleApp
make -j8
