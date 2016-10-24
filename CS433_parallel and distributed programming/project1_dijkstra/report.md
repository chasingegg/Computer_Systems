# Project 1 Report

##How to parallelize the serial implementation
The main() is almost same as the implement in `dijkstra.c`, except add  `if(my_rank == 0)` before the output part.
```
if (my_rank == 0) {
		printf("The distance from 0 to each vertex is:\n");
		Print_dists(dist, n);
		printf("The shortest path from 0 to each vertex is:\n");
		Print_paths(pred, n);
	} 
```
The main adjustments are in the function ` void Dijkstra(int *dist, int *pred, int n)` , and there are three MPI functions used to implement the paralleization.

`MPI_Allreduce(my_min, glbl_min, 1, MPI_2INT, MPI_MINLOC, MPI_COMM_WORLD);`
`MPI_Gather(loc_dist, loc_n, MPI_INT, dist, loc_n, MPI_INT, 0, MPI_COMM_WORLD);`
`MPI_Gather(loc_pred, loc_n, MPI_INT, pred, loc_n, MPI_INT, 0, MPI_COMM_WORLD);`

** Flow describtion of Dijkstra()**
1.  Every processor finds the vertex that has the smallest distance.
2.  Use ` MPI_Allreduce()` to find the smallest vertex `v` and the shortest distrance `shortest_dis` in global.
3.  Change the vetex in corresponding processor to `known`
4.  Every processor finds if there is any distance of vertex's (`u`) in `loc_dist`  can be replaced by `shortest_dis`+ `dist(v,u)`;
5.  repeat 1-4 for n-1 times
6.  Use `MPI_Gather()` to gather `loc_dist` and `loc_pred`  from all processor to `dist` and ` pred` in processor 0.


##Bugs meet during implement
1. The code below comes from `dijkstra.c`
```
       int Find_min_dist(int dist[], int known[], int n) {
       int v, u, best_so_far = INFINITY;
    
       for (v = 1; v < n; v++)
          if (!known[v])
             if (dist[v] < best_so_far) {
                u = v;
                best_so_far = dist[v];
             }
    
       return u;
       }  /* Find_min_dist */
```
In the parallelized version, we cannot insure every time we call this function in one processor can find such an u . Unlike the serial version,  the data that one processor has is just partial, one potential case is all the vertex in one processor is known, so the program will go wrong. 
**Modified Version**
```
        int Find_min_dist(int dist[], int known[], int n) {
    	int v, u=-1, best_so_far = INFINITY;
    	for (v = 0; v < n; v++)
    		if (!known[v])
    			if (dist[v] < best_so_far) {
    				u = v;
    				best_so_far = dist[v];
    			}
    	return u;
        }  
```
When there is no vertex found in the processor, the function returns -1 as a flag. And the corresponding adjustment to `my_min[ ]` is:
		loc_u = Find_min_dist(loc_dist, loc_known, loc_n);
		my_min[0] = loc_u == -1 ? INFINITY : loc_dist[loc_u];
		my_min[1] = global_vertex(loc_u);
2.  The same Bug comes from the **magic number** in a loop-head.
```
        for (v = 1; v < n; v++) 
         if (!known[v]) {
            new_dist = dist[u] + mat[u*n + v];
            if (new_dist < dist[v]) {
               dist[v] = new_dist;
               pred[v] = u;
            }
         }
```
This might be right in the serial version, but in parallelization, this means all the processor will ignore their first vertex;
**Modified Version**
```
        for (v = 0; v < loc_n; v++)
        if (!loc_known[v]) {
        new_dist = glbl_min[0] + loc_mat[u*loc_n + v];
        if (new_dist < loc_dist[v]) {
        	loc_dist[v] = new_dist;;
        	loc_pred[v] = u;
        	}
        }
```
##Speed-up compared to the serial one
The first column is the dimension of the input matrix and the second and third columns are the seconds to return result for paralledled version and serial version. The fourth column is the speed up rate.
![](http://i.imgur.com/xsUmS3K.png)

The  left-y axis is calculated by `Time*10^5/(Dimension/100)^2` for `Paralleled ` and `Serial` line.
The right axis is the speedup rate for `SpeedUp` line
![](http://i.imgur.com/UDawZGO.png)

From the graph, we find that:
1. The weight of overload for MPI communication will decrease with the calculated amount increasing.
2. The Speed up rate belows 1 and increase rapidly with the data set increase, finally slowing down when it reaches about 2.20.