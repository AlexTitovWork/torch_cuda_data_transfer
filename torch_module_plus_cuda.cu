//coded by Alex. 28.10.2021
//alexeytitovwork@gmail.com
//Torch to CUDA data transfer test.

#include <stdio.h>
#include <math.h>
#include <time.h>
#include <cuda.h>
#include "cuda_runtime.h"
#include "torch_module_plus_cuda.h"


#include <iostream>
#include <memory>


__global__ void MatrixMulKernel(float *M, float *N, float *P, int width, float *slice /*Torch data*/, int size_slice)
{
    int Row = blockIdx.y * blockDim.y + threadIdx.y;
    int Col = blockIdx.x * blockDim.x + threadIdx.x;
    if (Row < width && Col < width)
    {
        float Pvalue = 0;
        for (int i = 0; i < width; ++i)
        {
            Pvalue += M[Row * width + i] * N[width * i + Col];
        }
        P[Row * width + Col] = Pvalue;
    }
    //Reinint data
    if(Row < size_slice)
        slice[Row] = 333.333;
        
}

// void MatMul(float *M, float *N, float *P, int width)
void MatMul(float *M, float *N, float *P, int width, float* data)
{
    float *d_M;
    float *d_N;
    float *d_P;
    float *d_Slice;

    int size = width * width * sizeof(float);

    //allocate CUDA mem for Torch slice
    int size_slice  = 5*sizeof(float); 
    cudaMalloc((void **)&d_Slice, size_slice);
    cudaMemcpy(d_Slice, data, size_slice, cudaMemcpyHostToDevice);

    

    cudaMalloc((void **)&d_M, size);
    cudaMemcpy(d_M, M, size, cudaMemcpyHostToDevice);

    cudaMalloc((void **)&d_N, size);
    cudaMemcpy(d_N, N, size, cudaMemcpyHostToDevice);

    cudaMalloc((void **)&d_P, size);

    std :: cout << "Prepared Torch Tensor float * data for loading into CUDA memory:" << std :: endl;
    for(int i = 0; i< 5;i++)
       std::cout << data[i]<< '\n';
      

    dim3 dimGrid(2, 2, 1);
    dim3 dimBlock(width / 2, width / 2, 1);
    // <<<>>> will replace macro KERNEL_ARG2 when compiling 
    MatrixMulKernel <<<dimGrid,dimBlock>>>(d_M, d_M, d_P, width, d_Slice/*Torch data*/, size_slice /*size Td*/);
    cudaMemcpy(P, d_P, size, cudaMemcpyDeviceToHost);
    //Copy back 
    cudaMemcpy(data, d_Slice, size_slice, cudaMemcpyDeviceToHost);

    cudaFree(d_M);
    cudaFree(d_N);
    cudaFree(d_P);
}

//classic CUDA call
int test_CUDA(float* data) {

    std::cout << "Start... torch_module_plus_cuda.cu CUDA module \n";

    int elem = 100;
    float *M = new float[elem];
    float *N = new float[elem];
    float *P = new float[elem];

    for (int i = 0; i < elem; ++i)
        M[i] = i;

    for (int i = 0; i < elem; ++i)
        N[i] = i + elem;

    time_t t1 = time(NULL);
  
    MatMul(M, N, P, sqrt(elem), data);
    time_t t2 = time(NULL);
    double seconds = difftime(t2,t1);
    printf ("%.3f seconds total time\n", seconds);
    printf("Calculation result:\n");
    
    for (int i = 0; i < 10; ++i)
        printf("%.3f\t", P[i]);
    printf("\n");
    std::cout << "ok!\n";

    //Reinint data
    for (int i = 0; i < 5; ++i)
        printf("%.3f\t", data[i]);
    
    std::cout << "ok!\n";

   
    delete[] M;
    delete[] N;
    delete[] P;
    return 0;
}