/* File:     mpi_io.c
 * Purpose:  Implement I/O functions that will be useful in an
 *           an MPI implementation of Dijkstra's algorithm.  
 *           In particular, the program creates an MPI_Datatype
 *           that can be used to implement input and output of
 *           a matrix that is distributed by block columns.  It
 *           also implements input and output functions that use
 *           this datatype.  Finally, it implements a function
 *           that prints out a process' submatrix as a string.
 *           This makes it more likely that printing the submatrix 
 *           assigned to one process will be printed without 
 *           interruption by another process.
 *
 * Compile:  mpicc -g -Wall -o mpi_io mpi_io.c
 * Run:      mpiexec -n <p> ./mpi_io (on lab machines)
 *           csmpiexec -n <p> ./mpi_io (on the penguin cluster)
 *
 * Input:    n:  the number of rows and the number of columns 
 *               in the matrix
 *           mat:  the matrix:  note that INFINITY should be
 *               input as 1000000
 * Output:   The submatrix assigned to each process and the
 *           complete matrix printed from process 0.  Both
 *           print "i" instead of 1000000 for infinity.
 *
 * Notes:
 * 1.  The number of processes, p, should evenly divide n.
 * 2.  You should free the MPI_Datatype object created by
 *     the program with a call to MPI_Type_free:  see the
 *     main function.
 * 3.  Example:  Suppose the matrix is
 *
 *        0 1 2 3
 *        4 0 5 6 
 *        7 8 0 9
 *        8 7 6 0
 *
 *     Then if there are two processes, the matrix will be
 *     distributed as follows:
 *
 *        Proc 0:  0 1    Proc 1:  2 3
 *                 4 0             5 6
 *                 7 8             0 9
 *                 8 7             6 0
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mpi.h>

#define MAX_STRING 10000
#define INFINITY 1000000

int Read_n(int my_rank, MPI_Comm comm);
MPI_Datatype Build_blk_col_type(int n, int loc_n);
void Read_matrix(int loc_mat[], int n, int loc_n, 
      MPI_Datatype blk_col_mpi_t, int my_rank, MPI_Comm comm);
void Print_local_matrix(int loc_mat[], int n, int loc_n, int my_rank);
void Print_matrix(int loc_mat[], int n, int loc_n, 
      MPI_Datatype blk_col_mpi_t, int my_rank, MPI_Comm comm);

void Dijkstra(int loc_mat[], int loc_dist[], int n, int loc_n, int loc_pred[], int my_rank, MPI_Comm comm);
int Find_min_dist_loc(int loc_dist[], int loc_known[], int loc_n);
void Print_dists(int loc_dist[], int n, int loc_n, int my_rank, int comm);
void Print_paths(int loc_pred[], int n, int loc_n, int my_rank, int comm);

int main(int argc, char* argv[]) {
   int *loc_mat;
   int n, loc_n, p, my_rank;
   MPI_Comm comm;
   MPI_Datatype blk_col_mpi_t;

#  ifdef DEBUG
   int i, j;
#  endif

   MPI_Init(&argc, &argv);
   comm = MPI_COMM_WORLD;
   MPI_Comm_size(comm, &p);
   MPI_Comm_rank(comm, &my_rank);
   
   //printf("How many vertices?\n");
   
   n = Read_n(my_rank, comm);
   loc_n = n/p;
   loc_mat = malloc(n*loc_n*sizeof(int));
   int *loc_dist = malloc(loc_n * sizeof(int));
   int *loc_pred = malloc(loc_n * sizeof(int));


#  ifdef DEBUG
   printf("Proc %d > p = %d, n = %d, loc_n = %d\n",
         my_rank, p, n, loc_n);

   /* This ensures that the matrix elements are initialized when */
   /* debugging.  It shouldn't be necessary */
   for (i = 0; i < n; i++)
      for (j = 0; j < loc_n; j++)
         loc_mat[i*loc_n + j] = -1;
#  endif   
   
   /* Build the special MPI_Datatype before doing matrix I/O */
   blk_col_mpi_t = Build_blk_col_type(n, loc_n);

   Read_matrix(loc_mat, n, loc_n, blk_col_mpi_t, my_rank, comm);
   //Print_local_matrix(loc_mat, n, loc_n, my_rank);
   //Print_matrix(loc_mat, n, loc_n, blk_col_mpi_t, my_rank, comm);
   
   Dijkstra(loc_mat, loc_dist, n, loc_n, loc_pred, my_rank, comm);
   Print_dists(loc_dist, n, loc_n, my_rank, comm);
   Print_paths(loc_pred, n, loc_n, my_rank, comm);

   free(loc_mat);
   free(loc_dist);
   free(loc_pred);
   /* When you're done with the MPI_Datatype, free it */
   MPI_Type_free(&blk_col_mpi_t);

   MPI_Finalize();
   return 0;
}  /* main */


/*---------------------------------------------------------------------
 * Function:  Read_n
 * Purpose:   Read in the number of rows in the matrix on process 0
 *            and broadcast this value to the other processes
 * In args:   my_rank:  the calling process' rank
 *            comm:  Communicator containing all calling processes
 * Ret val:   n:  the number of rows in the matrix
 */
int Read_n(int my_rank, MPI_Comm comm) {
   int n;

   if (my_rank == 0)
      scanf("%d", &n);
   MPI_Bcast(&n, 1, MPI_INT, 0, comm);
   return n;
}  /* Read_n */


/*---------------------------------------------------------------------
 * Function:  Build_blk_col_type
 * Purpose:   Build an MPI_Datatype that represents a block column of
 *            a matrix
 * In args:   n:  number of rows in the matrix and the block column
 *            loc_n = n/p:  number cols in the block column
 * Ret val:   blk_col_mpi_t:  MPI_Datatype that represents a block
 *            column
 */
MPI_Datatype Build_blk_col_type(int n, int loc_n) {
   MPI_Aint lb, extent;
   MPI_Datatype block_mpi_t;
   MPI_Datatype first_bc_mpi_t;
   MPI_Datatype blk_col_mpi_t;

   MPI_Type_contiguous(loc_n, MPI_INT, &block_mpi_t);
   MPI_Type_get_extent(block_mpi_t, &lb, &extent);

   MPI_Type_vector(n, loc_n, n, MPI_INT, &first_bc_mpi_t);
   MPI_Type_create_resized(first_bc_mpi_t, lb, extent,
         &blk_col_mpi_t);
   MPI_Type_commit(&blk_col_mpi_t);

   MPI_Type_free(&block_mpi_t);
   MPI_Type_free(&first_bc_mpi_t);

   return blk_col_mpi_t;
}  /* Build_blk_col_type */

/*---------------------------------------------------------------------
 * Function:  Read_matrix
 * Purpose:   Read in an nxn matrix of ints on process 0, and
 *            distribute it among the processes so that each
 *            process gets a block column with n rows and n/p
 *            columns
 * In args:   n:  the number of rows in the matrix and the submatrices
 *            loc_n = n/p:  the number of columns in the submatrices
 *            blk_col_mpi_t:  the MPI_Datatype used on process 0
 *            my_rank:  the caller's rank in comm
 *            comm:  Communicator consisting of all the processes
 * Out arg:   loc_mat:  the calling process' submatrix (needs to be 
 *               allocated by the caller)
 */
void Read_matrix(int loc_mat[], int n, int loc_n, 
      MPI_Datatype blk_col_mpi_t, int my_rank, MPI_Comm comm) {
   int* mat = NULL, i, j;

   if (my_rank == 0) {
      mat = malloc(n*n*sizeof(int));
      for (i = 0; i < n; i++)
         for (j = 0; j < n; j++)
            scanf("%d", &mat[i*n + j]);
   }

   MPI_Scatter(mat, 1, blk_col_mpi_t,
           loc_mat, n*loc_n, MPI_INT, 0, comm);

   if (my_rank == 0) free(mat);
}  /* Read_matrix */


/*---------------------------------------------------------------------
 * Function:  Print_local_matrix
 * Purpose:   Store a process' submatrix as a string and print the
 *            string.  Printing as a string reduces the chance 
 *            that another process' output will interrupt the output.
 *            from the calling process.
 * In args:   loc_mat:  the calling process' submatrix
 *            n:  the number of rows in the submatrix
 *            loc_n:  the number of cols in the submatrix
 *            my_rank:  the calling process' rank
 */
void Print_local_matrix(int loc_mat[], int n, int loc_n, int my_rank) {
   char temp[MAX_STRING];
   char *cp = temp;
   int i, j;

   sprintf(cp, "Proc %d >\n", my_rank);
   cp = temp + strlen(temp);
   for (i = 0; i < n; i++) {
      for (j = 0; j < loc_n; j++) {
         if (loc_mat[i*loc_n + j] == INFINITY)
            sprintf(cp, " i ");
         else
            sprintf(cp, "%2d ", loc_mat[i*loc_n + j]);
         cp = temp + strlen(temp);
      }
      sprintf(cp, "\n");
      cp = temp + strlen(temp);
   }

   printf("%s\n", temp);
}  /* Print_local_matrix */


/*---------------------------------------------------------------------
 * Function:  Print_matrix
 * Purpose:   Print the matrix that's been distributed among the 
 *            processes.
 * In args:   loc_mat:  the calling process' submatrix
 *            n:  number of rows in the matrix and the submatrices
 *            loc_n:  the number of cols in the submatrix
 *            blk_col_mpi_t:  MPI_Datatype used on process 0 to
 *               receive a process' submatrix
 *            my_rank:  the calling process' rank
 *            comm:  Communicator consisting of all the processes
 */
void Print_matrix(int loc_mat[], int n, int loc_n,
      MPI_Datatype blk_col_mpi_t, int my_rank, MPI_Comm comm) {
   int* mat = NULL, i, j;

   if (my_rank == 0) mat = malloc(n*n*sizeof(int));
   MPI_Gather(loc_mat, n*loc_n, MPI_INT,
         mat, 1, blk_col_mpi_t, 0, comm);
   if (my_rank == 0) {
      for (i = 0; i < n; i++) {
         for (j = 0; j < n; j++)
            if (mat[i*n + j] == INFINITY)
               printf(" i ");
            else
               printf("%2d ", mat[i*n + j]);
         printf("\n");
      }
      free(mat);
   }
}  /* Print_matrix */


void Dijkstra(int loc_mat[], int loc_dist[], int n, int loc_n, int loc_pred[], int my_rank, MPI_Comm comm)
{
   int u, v, i, loc_u, dist_u, new_dist;
   int *loc_known = malloc(loc_n * sizeof(int));
   int my_min[2], glbl_min[2];

   for(i = 0; i < loc_n; ++i)
   {
      loc_dist[i] = loc_mat[0 * loc_n + i];
      loc_pred[i] = 0;
      loc_known[i] = 0;
   }
   if(my_rank == 0)
      loc_known[0] = 1;   //全局编号为0的已知

   for(i = 1; i < n; ++i)
   {
      loc_u = Find_min_dist_loc(loc_dist, loc_known, loc_n);

      if(loc_u >= 0)
      {
         my_min[0] = loc_dist[loc_u];
         my_min[1] = loc_u + my_rank * loc_n; //globl vertex
      }
      else if(loc_u == -1)
      {
         my_min[0] = INFINITY;
         my_min[1] = -1;
      }
      MPI_Allreduce(my_min, glbl_min, 1, MPI_2INT, MPI_MINLOC, comm);
      dist_u = glbl_min[0];
      u = glbl_min[1];

      if(u / loc_n == my_rank)
         loc_known[loc_u] = 1;
      for(v = 0; v < loc_n; ++v)
      {
         if(!loc_known[v])
         {
            new_dist = dist_u + loc_mat[u * loc_n + v];
            if(new_dist < loc_dist[v])
            {
               loc_dist[v] = new_dist;
               loc_pred[v] = u;
            }
         }
      }
   }
   free(loc_known);
}

int Find_min_dist_loc(int loc_dist[], int loc_known[], int loc_n)
{
   int loc_u = -1;
   int loc_v;
   int loc_min_dist = INFINITY;
   for(loc_v = 0; loc_v < loc_n; ++loc_v)
      if(!loc_known[loc_v])
         if(loc_dist[loc_v] < loc_min_dist)
         {
            loc_u = loc_v;
            loc_min_dist = loc_dist[loc_v];
         }
   return loc_u;
}

void Print_dists(int loc_dist[], int n, int loc_n, int my_rank, int comm)
{
   int *dist = NULL, v;
   if(my_rank == 0)
      dist = malloc(n * sizeof(int));
   MPI_Gather(loc_dist, loc_n, MPI_INT, dist, loc_n, MPI_INT, 0, comm);
   if(my_rank == 0)
   {
      printf("  v    dist 0->v\n");
      printf("----   ---------\n");

      for (v = 1; v < n; v++)
         printf("%3d       %4d\n", v, dist[v]);
      printf("\n");
      free(dist);
   }
}

void Print_paths(int loc_pred[], int n, int loc_n, int my_rank, int comm)
{
   int v, w, *path, *pred = NULL, count, i;
   if(my_rank == 0)
      pred = malloc(n * sizeof(int));
   MPI_Gather(loc_pred, loc_n, MPI_INT, pred, loc_n, MPI_INT, 0, comm);
   if(my_rank == 0)
   {
      path = malloc(n * sizeof(int));

      printf("  v     Path 0->v\n");
      printf("----    ---------\n");
      for (v = 1; v < n; v++) 
      {
         printf("%3d:    ", v);
         count = 0;
         w = v;
         while(w != 0)
         {
            path[count] = w;
            count++;
            w = pred[w];
         }
         printf("0 ");
         for(i = count - 1; i >= 0; i--)
            printf("%d ", path[i]);
         printf("\n");
      } 
      free(path);
      free(pred);
   }
}