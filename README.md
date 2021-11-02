# torch_cuda_data_transfer
<h2>
Transferring a small chunk of data from the Torch model to the cuda memory of re-initializing elements and returning it back.<h2>
USAGE<br>
<h3>1. Compilation with libtorch library folder. From terminal<br></h3>
  $ sudo cmake -DCMAKE_PREFIX_PATH=/home/path_to_libtorch/libtorch<br>
terminal logs:<br><i>
_search_engine_CUDA/torch_cuda/libtorch<br>
-- Configuring done<br>
-- Generating done<br>
-- Build files have been written to:<br>
  </i>
<h3>2. Build release file:<br></h3>
  $ sudo cmake --build . --config Release <br>
terminal logs:<br>
<i>
[ 40%] Built target particles_new_lib<br>
[100%] Built target particle_cuda_test<br>
</i>
