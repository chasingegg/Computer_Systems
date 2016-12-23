#include<stdlib.h>
#include<stdio.h>
#include <math.h>
#define REP_TIME 100
#define TILE 32
#define SIDE 8
float *initial_matrix(int rows, int cols);
void print_matrix(float *matrix, int rows,int cols);
void check(float *src, float *dst, int rows,int cols);

__global__ void kernel(float *d_src, float *d_dst, int cols, int rows) {

    __shared__ float mat[TILE][TILE+1];

    //block start element
     int bx=blockIdx.x*TILE;  //block start x
     int by=blockIdx.y*TILE;  //block start y
     //thread element
     int i = by+ threadIdx.y;
     int j = bx+ threadIdx.x;

    #pragma unroll
      for(int k=0;k<TILE;k+=SIDE){
        if(i+k<rows&&j<cols)
          mat[threadIdx.y+k][threadIdx.x]=d_src[((i+k)*cols)+j]; 
      }

    __syncthreads();

    int ti=bx+threadIdx.y;
    int tj=by+threadIdx.x;
    #pragma unroll
    for(int k=0;k<TILE;k+=SIDE){
      if((ti+k)<cols&&tj<rows)
        d_dst[(ti+k)*rows+tj]=mat[threadIdx.x][threadIdx.y+k];

    }

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
    dim3 GridDim(cols/TILE, rows/TILE);
    dim3 BlockDim(TILE, SIDE); //we don't need so TILE*TILE threads in fact

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


  //  print_matrix(src,rows,cols);
  //  printf("\n\n\n");
  //  print_matrix(dst,cols,rows);

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
            printf("%.0f ", matrix[i * cols + j]);
        }
        printf("\n");
    }
}
