-----------------------------------------------------------
CMPU-377
CUDA Demo code

To be compiled and run on hpc.cs.vassar.edu
                   and on lambda-quad.cs.vassar.edu

Readme file for example code from:
https://devblogs.nvidia.com/even-easier-introduction-cuda/
-----------------------------------------------------------

To compile and run add.cpp:
$ g++ add.cpp -o add
$ ./add

-----------------------------------------------------------

To compile and run add.cu:
$ nvcc add.cu -o add_cuda
$ ./add_cuda

To profile add.cu:
$ nvprof ./add_cuda

-----------------------------------------------------------

To compile and run add_block.cu:
$ nvcc add_block.cu -o add_block
$ ./add_block

To profile add_block.cu:
$ nvprof ./add_block

-----------------------------------------------------------

To compile and run add_grid.cu:
$ nvcc add_grid.cu -o add_grid
$ ./add_grid

To profile add_grid.cu:
$ nvprof ./add_grid


