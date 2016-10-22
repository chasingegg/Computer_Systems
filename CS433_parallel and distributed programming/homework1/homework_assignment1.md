#homework assignment1             
5142029014    高超

**(1)**  
If comm_sz doesn't evenly divide n, we can't assign the same trapezoids to each process. we can do the calculation q = n / comm_sz, r = n % comm_sz, so the first r processes will get (q + 1) trapezoids, and the rest of processes will get q trapezoids.    
below is the psedo-code:

```
p = n / comm_sz;
r = n % comm_sz;
h = (b - a) / n;
if(my_rank < r)
{
    local_n = p + 1;
	local_a = a + my_rank * local_n * h;
	local_b = local_a + local_n * h;
}
else
{
	local_n = p;
	local_a = a + my_rank * local_n * h + r * h;
	local_b = local_a + local_n * h;
}
```

**(2)**  
*a*. the block distribution:  
process 0: x[0], x[1], x[2], x[12]  
process 1: x[3], x[4], x[5], x[13]  
process 2: x[6], x[7], x[8]  
process 3: x[9], x[10], x[11]  
For the general situation, we can compute q = n / comm_sz, r = n % comm_sz, if r equals 0, we can distribute q components to each process sequentially. If r is not 0, we can first distribute q components to each prcocess sequentially, after that, we can distribute 1 more component (the remainder) to each process whose rank is less than r.  
below is the psedo-code:  

```
q = n / comm_sz;  
r = n % comm_sz; 
for(i = 0; i < comm_sz; ++i) 
{
    if(i < r)
    {
		for(j = 0; j < q; ++j) 
			add x[i * q + j] to process[i];
		add x[q * comm_sz + i] to process[i];
	}
	else 
	{
		for(j = 0; j < q; ++j)
			add x[i * q + j] to process[i];
	}
}
```  

*b*. the cyclic distribution:  
process 0: x[0], x[4], x[8], x[12]  
process 1: x[1], x[5], x[9], x[13]  
process 2: x[2], x[6], x[10]  
process 3: x[3], x[7], x[11]  
For the general situation, we distribute one component at one time to process in a loop of 0,1,2,...,comm_sz-1 until all the components are distributed.  
below is the psedo-code:  

```
for(i = 0; i < n; ++i)
{
    add x[i] to process[i % comm_sz];
} 
```
*c*. 
the block-cyclic distribution with block size b = 2:  
process 0: x[0], x[1], x[8], x[9]  
process 1: x[2], x[3], x[10], x[11]  
process 2: x[4], x[5], x[12], x[13]  
process 3: x[6], x[7]  
For the general situation, it is a little bit like the cyclic distribution, assume that block size is m, 
we distribute every m components at one time to process in a loop of 0,1,2...,comm_sz-1 until all the components are distributed (if at last the number of remainder is less than m, distribute the remainder to the process).  
the psedo-code:  

```
for(i = 0; i < n / m; ++i)
{	
	for(j = 0; j < m; ++j)
    	add x[i * m + j] to process[i % comm_sz]; 
}
if(n % m != 0)
	add x[n / m * m],x[ n / m * m + 1]...,x[n - 1] to process[(n / m) % comm_sz];
```

**(3)**  
As we all know, collective functions like MPI_Gather, MPI_reduce have 
an input buffer and an output buffer, if there is only one single process
in the communicator, so the output should be the same as the input. 
Besides, collective functions like MPI_Bcast have only an input buffer, 
there is no change in the input buffer, it broadcasts all the contents 
in the input buffer just to itself.
  
**(4)**  
*a*. The speed has relations to the computer architecture. Cache-friendly 
code is all about the principle of locality, and we can place related 
data in the cache closer than memory to allow efficient accessing, 
therefore we can save lots of time on data accessing, it could happen that
the program achieves speedup greater than p.

*b*. The resource limitation is the limitation of available cache.  
 I think it can be possible for a certain program to obtain superlinear speedup without overcoming resourse limitations, actually it is just the luck due to some special cases which cannot happen on the average case.  
For example, find a number in an array a[n], maybe the number we want to search is the a[n/2], when we divide the array into two parts, we actually find the number immediately, less than the half time of sequential search.

