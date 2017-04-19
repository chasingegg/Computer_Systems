#include <stdio.h>
#include <error.h>
#include <unistd.h>

int main()
{
    FILE *fp;
    while(1) {
     
    char buf[1024]; 

    fp=fopen("/proc/ctx_proc","r"); 
    if(fp==NULL) 
    { 
        perror("fopen"); 
        return -1; 
    } 

    while(!feof(fp)) 
    { 
        if(fgets(buf,sizeof(buf),fp)!=NULL) {
            printf("%s",buf); 
	    fflush(stdout);
	}
    } 
    fflush(stdout);
    sleep(2);
    printf("\033c");
    }

    return 0;
}
