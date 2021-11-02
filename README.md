# torch_cuda_data_transfer
<h2>
Transferring a small chunk of data from the Torch model to the cuda memory of re-initializing elements and returning it back.<h2>
USAGE<br>
<h3>0. Prepare libtorch folder<br></h3>
  download libtorch from <br>
  https://pytorch.org/get-started/locally/#supported-linux-distributions<br>
  for CPU libtorch-shared-with-deps-1.9.1+cpu.zip<br>
  for GPU libtorch-shared-with-deps-1.9.1+cu102.zip<br>
Place unzipped files to the path_to_libtorch/libtorch <br>
  <pre>
  ./libtorch_
       &nbsp;&nbsp;&nbsp  |_bin<br>
       &nbsp;&nbsp;&nbsp  |_include<br>
       &nbsp;&nbsp;&nbsp  |_lib<br>
       &nbsp;&nbsp;&nbsp  |_share<br>
       &nbsp;&nbsp;&nbsp  |_build-hash<br>
       &nbsp;&nbsp;&nbsp  |_build-version<br></pre>

  
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

  
  Additional links.
  https://pytorch.org/tutorials/advanced/cpp_export.html
