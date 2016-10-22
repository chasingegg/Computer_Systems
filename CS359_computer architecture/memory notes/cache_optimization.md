#cache optimizations

##background
what we want to acheive
- reducing the miss rate
- reducing the miss penalty
- reducing the time to hit in the cache

three categories of misses  
- compulsory: the very first access to a block cannot be in the cache
- capacity: if the cache cannot contain all the blocks, capacity misses occur
- conflict: in case of set associative and direct mapped, conflict misses occur

##basic cache optimizations

###larger block size
- reduce compulsory misses(spatial locality)
- increase miss penalty, incease conflict misses

###larger caches
- good for reducing capacity misses
- potentially longer hit time, and higher cost and power

###higher associativity
n-way cache, we increase n, the cache has small number of sets

###multilevel cache
insert additional levels of cache
performance analysis: average memory access time = hit time1 + miss rate1 * miss penalty1
miss penalty1 = hit time2 + miss rate2 * miss penalty2

###give priority to read misses
two solutions:  
- for a read miss, to wait until the write buffer is empty
- upon a read miss, to check the contents of the write buffer

###avoiding address translation(reduce hit time)
check if the data is in cache  
- locating the possible data in cache
- compare the tags
if we use cache with virtual address, the time for address translation is saved. So it requires address translation only on cache misses.  
**why not use virtual address to organize cache**  
- protection
- process switching: switch once, the cache should be flushed!
- synonyms or aliases: coherence issues, update all cache entries
- IO use physical address

**get the best of both virtual and physical caches**  
overlapping the *access* with the *TLB access*  
- high order bits of VA to access the TLB  
- the low order bits are used as index into cache  
use page offset to index the cache(page offset is not used for address translation)


