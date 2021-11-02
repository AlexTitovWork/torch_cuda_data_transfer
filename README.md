<h2> The Torch data to cuda transferring.</h2>
Transferring a small chunk of data from the Torch model to the cuda memory. Re-initializing elements and returning it back.<br>
<h3>USAGE<br></h3>
<h3>
  1. Prepare libtorch folder<br></h3>
  Download libtorch from: <br>
  https://pytorch.org/get-started/locally/#supported-linux-distributions<br>
   - for CPU libtorch-shared-with-deps-1.9.1+cpu.zip<br>
   - for GPU libtorch-shared-with-deps-1.9.1+cu102.zip<br>
Place unzipped files to the path_to_libtorch/libtorch: <br>
  <pre>
  ./libtorch_
       &nbsp;&nbsp;&nbsp  |_bin<br>
       &nbsp;&nbsp;&nbsp  |_include<br>
       &nbsp;&nbsp;&nbsp  |_lib<br>
       &nbsp;&nbsp;&nbsp  |_share<br>
       &nbsp;&nbsp;&nbsp  |_build-hash<br>
       &nbsp;&nbsp;&nbsp  |_build-version<br></pre>

  
<h3>2. Compilation with libtorch library folder. </h3><br>
  From terminal:<br>
  $ sudo cmake -DCMAKE_PREFIX_PATH=/home/path_to_libtorch/libtorch<br>
terminal logs:<br><i>
_search_engine_CUDA/torch_cuda/libtorch<br>
-- Configuring done<br>
-- Generating done<br>
-- Build files have been written to:<br>
  </i>
<h3>3. Build release file:<br></h3>
  $ sudo cmake --build . --config Release <br>
terminal logs:<br>
<i>
[ 40%] Built target particles_new_lib<br>
[100%] Built target particle_cuda_test<br>
</i>

  
  Additional links.
  https://pytorch.org/tutorials/advanced/cpp_export.html
