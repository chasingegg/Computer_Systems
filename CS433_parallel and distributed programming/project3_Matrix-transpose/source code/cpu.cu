#include <stdio.h>
#include <math.h>
#include <stdlib.h>


float **initial_matrix(int dim);

void transpose(float **src, float **dst, int dim);

void free_matrix(float **pointer, int dim);

void print(float **pointer, int dim);

int main(int argc, char *argv[]) {
    cudaEvent_t start, finish;
    float duration;

    float **src, **dst;

    int dim = 4096;
    cudaEventCreate(&start);
    cudaEventCreate(&finish);
    src = initial_matrix(dim);
    dst = initial_matrix(dim);
    cudaEventRecord(start, 0);
    for (int i = 0; i < 100; ++i) {
        transpose(src, dst, dim);
    }
    cudaEventRecord(finish, 0);
    cudaEventSynchronize(finish);
    cudaEventElapsedTime(&duration, start, finish);
    
    printf("Time:%.4f(ms)\n",duration/100);
    printf("Bandwidth:%.4f(GB/s)\n", dim*dim*1000.0*2.0*sizeof(float)/1024/1024/1024/(duration/100.0));
   // print(src,dim);
   // print(dst,dim);
    free_matrix(src, dim);
    free_matrix(dst, dim);


    return 0;
}

float **initial_matrix(int dim) {
    float **pointer = new float *[dim];
    for (int i = 0; i < dim; ++i) {
        pointer[i] = new float[dim];

        //fill the matrix
        for (int j = 0; j < dim; ++j) {
            pointer[i][j] = rand() % 100;
        }
    }
    return pointer;
}

void transpose(float **src, float **dst, int dim) {
    for (int i = 0; i < dim; ++i) {
        for (int j = 0; j < dim; ++j)
            dst[i][j] = src[j][i];
    }
}

void free_matrix(float **pointer, int dim) {
    for (int i = 0; i < dim; ++i) {
        free(pointer[i]);
    }
    free(pointer);
}

void print(float **pointer, int dim) {
    for (int i = 0; i < dim; ++i) {
        for (int j = 0; j < dim; ++j) {
            printf("%.1f", pointer[i][j]);
        }
        printf("\n");
    }
}
