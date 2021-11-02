//coded by Alex. 28.10.2021
//alexeytitovwork@gmail.com
//Torch to CUDA data transfer test.
#include <torch/script.h> 
#include <iostream>
#include <memory>

#include "torch_module_plus_cuda.h"

//-----------------------


int main(int argc, const char* argv[]) {
  if (argc != 2) {
 //   std::cerr << "usage: example-app <path-to-exported-script-module>\n";
 //   return -1;
 // direct load for test
      argv[1] = "traced_resnet_model.pt";
  }
 


  torch::jit::script::Module module;
  try {
    // Deserialize the ScriptModule from a file using torch::jit::load().
    module = torch::jit::load(argv[1]);

    // std::cout<< module.get_property("weight") <<std::endl;
    //CPU load 
      torch::Tensor tensor = torch::randint(20, {2, 3});
        std::cout << tensor << std::endl; 
         int a = tensor[0][0].item<int>(); 
          std::cout << a << std::endl;
    //TODO CUDA load data, CUDA load model
//     //load to CUDA
    
//     std::vector<torch::jit::IValue> inputs_to_CUDA;
//     //load to CUDA
//     inputs_to_CUDA.push_back(torch::ones({1, 3, 224, 224}).to(at::kCUDA));
     
// // Execute the model and turn its output into a tensor.
//     at::Tensor output_from_CUDA = mdl.forward(inputs_to_CUDA).toTensor();
//     std::cout << output_from_CUDA.slice(/*dim=*/1, /*start=*/0, /*end=*/5) << '\n';

//     std::cout << "Cuda job ok\n";

    
    
    // Create a vector of inputs.
    std::vector<torch::jit::IValue> inputs;
    inputs.push_back(torch::ones({1, 3, 224, 224}));

    // Execute the model and turn its output into a tensor.
    at::Tensor output = module.forward(inputs).toTensor();
    std::cout<< "Host allocated at::Tensor:"<<std::endl;
    std::cout << output.slice(/*dim=*/1, /*start=*/0, /*end=*/5) << '\n';
    // float *data = new float[5];
    torch::NoGradGuard no_grad;

    // Convert data form Torch model to C++ array.
    // The transfer of Torch data to CUDA memory  
    float* data = static_cast<float*>(output.slice(/*dim=*/1, /*start=*/0, /*end=*/5).data_ptr());
    // memcpy(data , output.slice(/*dim=*/1, /*start=*/0, /*end=*/5));
    std::cout<< "Translate at::Tensor to C++ float data:"<<std::endl;
    for(int i = 0; i< 5;i++)
       std::cout << data[i]<< '\n';
      
    //CUDA function direct call
    test_CUDA(data);

  }
  catch (const c10::Error& e) {
    std::cerr << "error loading the model\n";
    return -1;
  }
    
    // torch::Tensor ts = torch::randint(20, {2, 3});
    //   ts.to(at::kCUDA);

  std::cout << "Start... torch_and_cuda_call.cpp main module \n";
  std::cout << "ok!\n";


}