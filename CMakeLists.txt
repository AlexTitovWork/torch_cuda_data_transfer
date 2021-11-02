cmake_minimum_required(VERSION 3.8 FATAL_ERROR)
project(cmake_and_cuda LANGUAGES CXX CUDA)
 
include(CTest)
 
find_package(Torch REQUIRED)

add_library(particles_new_lib STATIC

  torch_module_plus_cuda.cu
  torch_module_plus_cuda.h
  )
  
# Request that particles_new_lib be built with -std=c++11
# As this is a public compile feature anything that links to 
# particles_new_lib will also build with -std=c++11
target_compile_features(particles_new_lib PUBLIC cxx_std_14)
 
# We need to explicitly state that we need all CUDA files in the 
# particles_new_lib library to be built with -dc as the member functions 
# could be called by other libraries and executables
set_target_properties( particles_new_lib
                       PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
 
add_executable(particle_cuda_test torch_and_cuda_call.cpp)
 
set_property(TARGET particle_cuda_test 
             PROPERTY CUDA_SEPARABLE_COMPILATION ON)
# target_link_libraries(particle_cuda_test PRIVATE particles_new_lib)
target_link_libraries(particle_cuda_test PRIVATE "${TORCH_LIBRARIES}")

target_link_libraries(particle_cuda_test PRIVATE particles_new_lib)


if(APPLE)
  # We need to add the path to the driver (libcuda.dylib) as an rpath, 
  # so that the static cuda runtime can find it at runtime.
  set_property(TARGET particle_cuda_test 
               PROPERTY
               BUILD_RPATH ${CMAKE_CUDA_IMPLICIT_LINK_DIRECTORIES})
endif()

set_property(TARGET particle_cuda_test PROPERTY CXX_STANDARD 14)
