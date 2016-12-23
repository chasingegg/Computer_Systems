#include<stdlib.h>
#include<stdio.h>
#include <math.h>
#define REP_TIME 100
#define BLOCK_SIZE_X 32
#define BLOCK_SIZE_Y 32
float *initial_matrix(int rows, int cols);
void print_matrix(float *matrix, int rows,int cols);
void check(float *src, float *dst, int rows,int cols);

__global__ void kernel(float *d_src, float *d_dst, int cols, int rows) {
    
    __shared__ float mat[BLOCK_SIZE_X][BLOCK_SIZE_Y+1];

    //block start element
    int bx=blockIdx.x*BLOCK_SIZE_X;  //block start x
    int by=blockIdx.y*BLOCK_SIZE_Y;  //block start y
    //thread element
    int i = by+ threadIdx.y;
    int j = bx+ threadIdx.x;
    //transfered element
    int ti=bx+threadIdx.y;
    int tj=by+threadIdx.x;
   
    //load element to corresponding block
    if(i<rows&&j<cols)
	mat[threadIdx.y][threadIdx.x]=d_src[i*cols+j];
    __syncthreads();
 
    if(tj<rows&&ti<cols)	
	d_dst[ti*rows+tj]=mat[threadIdx.x][threadIdx.y];
}

int main(int argc, char *argv[]) {
    int rows, cols;
    if (argc >= 3) {
        rows = atoi(argv[1]);
        cols = atoi(argv[2]);
    } else {
        rows = 4096;
        cols = 4096;
    }


    //initialization
    float *src, *dst;
    float *d_src, *d_dst;
    src = initial_matrix(rows, cols);
    dst = (float *) malloc(rows * cols * sizeof(float));

    //size_t pitch;
    //cudaMallocPitch(&d_src, &pitch, cols * sizeof(int), rows);
    //Upload Data
    int size = rows * cols * sizeof(float);
    cudaMalloc((void **) &d_src, size);
    cudaMalloc((void **) &d_dst, size);
    cudaMemcpy(d_src, src, size, cudaMemcpyHostToDevice);

    //Kernel
    dim3 GridDim(cols/32, rows/32);
    dim3 BlockDim(BLOCK_SIZE_X, BLOCK_SIZE_Y);//notice at most 32*32=1024 threads per block

    //count time
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start, 0);
    for(int i=0;i<REP_TIME;++i)
    	kernel <<< GridDim, BlockDim >>> (d_src, d_dst, cols, rows);
    cudaEventRecord(stop, 0);
    cudaEventSynchronize(stop);
    float kernelTime;
    cudaEventElapsedTime(&kernelTime, start, stop);

    printf("Bandwidth:%.4fGB/s\nTotal Time:%.4f(ms)\nIter:%d\nSize:(%d,%d)\n",
	 size*2.0*1000.0/1024/1024/1024/(kernelTime/REP_TIME),
	 kernelTime,
	 REP_TIME,
	 rows,cols);

    //Download Data
    cudaMemcpy(dst, d_dst, size, cudaMemcpyDeviceToHost);
    check(src,dst,rows,cols);
	
    /*
    print_matrix(src,rows,cols);
    printf("\n\n\n");
    print_matrix(dst,cols,rows);
    */
    cudaFree(d_src);
    cudaFree(d_dst);
    free(src);
    free(dst);

    return 0;
}

float *initial_matrix(int rows, int cols) {
    float *pointer = (float *) malloc(rows * cols * sizeof(float));
    for (int i = 0; i < rows * cols; ++i)
        pointer[i] = rand() % 100;
    return pointer;
}

void check(float *src, float *dst, int rows,int cols) {
    for (int i = 0; i < rows; ++i) {
        for (int j = 0; j < cols; ++j) {
            if (abs(src[i * cols + j] - dst[j * rows + i]) > 0.01) {
                printf("Result dismatch\n");
                return;
            }
        }
    }
    printf("\nResult match!\n");
    return;
}

void print_matrix(float *matrix, int rows,int cols) {
    for (int i = 0; i < rows; ++i) {
        for (int j = 0; j < cols; ++j) {
            printf("%.1f ", matrix[i * cols + j]);
        }
        printf("\n");
    }
}

