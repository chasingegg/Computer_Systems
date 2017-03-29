#include <linux/module.h>  
#include <linux/sched.h>  
#include <linux/uaccess.h>  
#include <linux/proc_fs.h>  
#include <linux/fs.h>  
#include <linux/seq_file.h>  
#include <linux/slab.h>  
  
#define BUFFER 10
int buffer_size = 0;
char tmp[BUFFER];
  
struct proc_dir_entry *myTest;
 
static int my_proc_show(struct seq_file *m, void *v)  
{    
    seq_printf(m, "I am Chao Gao, hello proc!\n"); 
    seq_printf(m, "current_size is %d\n", buffer_size); 
    seq_printf(m, "the content is %s\n", tmp);  
    return 0;  
}
  

static ssize_t my_proc_write(struct file *file, const char __user *buffer,  
                             size_t count, loff_t *f_pos)  
{
    buffer_size = count;
    if(buffer_size >= BUFFER)
	buffer_size = BUFFER;
    if(copy_from_user(tmp, buffer, buffer_size))  
    {   
        return EFAULT;  
    }   
    tmp[buffer_size] = '\0';
    return count;  
}  
  
static int my_proc_open(struct inode *inode, struct file *file)  
{   
    return single_open(file, my_proc_show, NULL);  
}  
   
static struct file_operations my_fops = {  
    .owner   = THIS_MODULE,  
    .open    = my_proc_open,  
    .release = single_release,  
    .read    = seq_read,  
    .llseek  = seq_lseek,  
    .write   = my_proc_write,  
};  
  
static int __init my_init(void)  
{  
    struct proc_dir_entry *file;  
    
    myTest = proc_mkdir("test", NULL);

    file = proc_create("abc", 0666, myTest, &my_fops);  
    if(!file)  
        return -ENOMEM;  
    return 0;  
}  
  
  
static void __exit my_exit(void)  
{  
    remove_proc_entry("abc", myTest);  
    remove_proc_entry("test", NULL); 
}  
  
module_init(my_init);  
module_exit(my_exit);  
MODULE_LICENSE("GPL");  
 



