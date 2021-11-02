# torch_cuda_data_transfer
Transferring a small chunk of data from the Torch model to the cuda memory of re-initializing elements and returning it back.
USAGE
1. Compilation with libtorch library folder. From terminal
  $ sudo cmake -DCMAKE_PREFIX_PATH=/home/path_to_libtorch/libtorch
terminal logs:
_search_engine_CUDA/torch_cuda/libtorch
-- Configuring done
-- Generating done
-- Build files have been written to:
2. Build release file:
  $ sudo cmake --build . --config Release 
terminal logs:
[ 40%] Built target particles_new_lib
[100%] Built target particle_cuda_test
