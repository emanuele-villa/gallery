cd build;
cmake -DCMAKE_C_COMPILER=$(which gcc) -DCMAKE_CXX_COMPILER=$(which g++)  -DCMAKE_BUILD_TYPE=RelWithDebInfo ..;
make;
./myconverter
cd ..;
