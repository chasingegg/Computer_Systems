#memory hierarchy

##principle of locality
- **temporal locality**: recently referenced items are likely to be referenced in the near future.
- **spatial locality**: items with nearby address tend to be refenced close together in time.

##block placement
 - **fully associative**: anywhere you can go
 - **direct mapped**: block number % (the number of blocks in a cache)
 - **set associative**: first calculate the set = block number % (the number of set), then you can chooce anywhere in a set  
    n-way set associative, in each set you have n choices
 
##block identification
 - **address tag**: if it matches the block address from the processor  
 how do we know if a data item in cache - by tag  
 how do we find it: mapping
 - **valid bit**: indicate if the entry has a valid address
 
##block replacement
 a miss occurs, the cache controlller selects a block to be replaced

##write strategy
- **write-through**: write both the cache and main memory
- **write-back**: write only to cache, to main memory when it is replaced
  

##**measuring memory hierarchy performance**
average memory access time = hit time + miss rate * miss penalty  
CPU time = (CPU execution clock cycles + memory stall clock cycles) * cycle time

##virtual memory
a virtual address is translated to a physical address  this may takes an extra memory, the hardware fix is to use TLB. TLB access time is typically smaller than cache access time.

