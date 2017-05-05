#include <linux/module.h>  
#include <linux/kernel.h>  
#include <linux/proc_fs.h>  
#include <linux/string.h>  
#include <linux/vmalloc.h>  
#include <linux/sched.h>
#include <linux/init.h>  
#include <linux/slab.h>  
#include <linux/mm.h>  
#include <linux/vmalloc.h>
#include <linux/highmem.h> 
#include <asm/uaccess.h> 

  
//Print vma of the current process  
static void mtest_list_vma(void)  
{  
    struct mm_struct *mm = current->mm;  
    struct vm_area_struct *vma;  
    char a[4] = {'-', '-', '-'};
    int counter = 0;
    down_read(&mm->mmap_sem); //lock
    printk("mtest_list_vma:\n");
    for (vma = mm->mmap;vma; vma = vma->vm_next) 
    {  
	counter++;        
//printk("%d  0x%lx 0x%lx \n", counter, vma->vm_start, vma->vm_end); //`fflush(); 
        if (vma->vm_flags & VM_READ)   a[0] = 'r';
	else  a[0] = '-';
        if (vma->vm_flags & VM_WRITE)  a[1] = 'w';  
	else  a[1] = '-';
        if (vma->vm_flags & VM_EXEC)   a[2] = 'x';
	else  a[2] = '-'; 
	printk("%d  0x%lx 0x%lx %c%c%c\n", counter, vma->vm_start, vma->vm_end, a[0], a[1], a[2]); 
        //printk("\n");  
    }  
    up_read(&mm->mmap_sem); //release lock 
    
}  
  
static struct page* mtest_seek_page(struct vm_area_struct *vma, unsigned long addr)  
{ 
    pgd_t *pgd;  //top level page table
    pud_t *pud;  //second level page table
    pmd_t *pmd;  //third level page table       
    pte_t *pte;  //last level page table
    spinlock_t *ptl;  

    struct page *page = NULL;  
    struct mm_struct *mm = vma->vm_mm;  
    
    pgd = pgd_offset(mm, addr);           
    if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))  return NULL;  
          
    pud = pud_offset(pgd, addr);  
    if (pud_none(*pud) || unlikely(pud_bad(*pud)))  return NULL;  
                
    pmd = pmd_offset(pud, addr);  
    if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))  return NULL;
  
    pte = pte_offset_map_lock(mm, pmd, addr, &ptl);  
    if (!pte)  return NULL; 

    if (!pte_present(*pte)){
        pte_unmap_unlock(pte, ptl);
	return NULL;
    }  
          
    page = pfn_to_page(pte_pfn(*pte));  
    if (!page)
    {  
        pte_unmap_unlock(pte, ptl);
	return NULL;
    }  
        
    get_page(page);  
    pte_unmap_unlock(pte, ptl);  
    return page;  
}  
  
   
static void mtest_find_page(unsigned long addr)  
{    
    struct vm_area_struct *vma;  
    struct mm_struct *mm = current->mm;    
    struct page *page;  
    unsigned long kernel_addr;
    
    down_read(&mm->mmap_sem);  
    printk("mtest_find_page:\n");
    vma = find_vma(mm, addr);  
    page = mtest_seek_page(vma, addr);  
  
    if (!page)   
    {      
        printk("Translation not found\n");  
        up_read(&mm->mmap_sem); 
  	return;
    }  
    kernel_addr = (unsigned long)page_address(page);  
    kernel_addr += (addr & ~PAGE_MASK);  
    printk("Translate 0x%lx to kernel address 0x%lx\n", addr, kernel_addr); 
    up_read(&mm->mmap_sem);   

}  
 
static void mtest_write_val(unsigned long addr, unsigned long val)  
{  
    struct vm_area_struct *vma;  
    struct mm_struct *mm = current->mm;  
    struct page *page;  
    unsigned long kernel_addr;  
  
    down_read(&mm->mmap_sem); 
    printk("mtest_write_val:\n"); 
    vma = find_vma(mm, addr);  
    if (vma && addr >= vma->vm_start && (addr + sizeof(val)) < vma->vm_end) 
    {  
        if (!(vma->vm_flags & VM_WRITE)) 
        {  
            printk("vma is not writable for 0x%lx\n", addr);  
            up_read(&mm->mmap_sem);
	    return; 
        }  
        page = mtest_seek_page(vma, addr);  
        if (!page) 
        {      
            printk("Page 0x%lx not found\n", addr);  
            up_read(&mm->mmap_sem);
	    return;
        }  
          
        kernel_addr = (unsigned long)page_address(page);  
        kernel_addr += (addr&~PAGE_MASK); 
	*(unsigned long *)kernel_addr = val; 
        printk("Written 0x%lx to address 0x%lx\n", val, kernel_addr);  
          
        put_page(page);  
          
    }  
    up_read(&mm->mmap_sem);
}  
  
  
static ssize_t mtest_proc_write(struct file *file, 
				const char __user * buffer,  
                                size_t count, loff_t * data)  
{        
    char buf[128];  
    unsigned long val, val2;  
    if (count > sizeof(buf))  
        return -EINVAL;  
      
    if (copy_from_user(buf, buffer, count))  
        return -EINVAL;  
      
    if (memcmp(buf, "listvma", 7) == 0)   
        mtest_list_vma();  

    else if (memcmp(buf, "findpage", 8) == 0) {
        if (sscanf(buf + 8, "%lx", &val) == 1) 
            mtest_find_page(val);  
    }
  
    else  if (memcmp(buf, "writeval", 8) == 0) {
        if (sscanf(buf + 8, "%lx %lx", &val, &val2) == 2)  
            mtest_write_val(val, val2);   
    }
    else
        printk("Input error.\n");
    return count;  
}  

  
static struct proc_dir_entry *mtest_proc_entry;  
  

static const struct file_operations mtest_proc_fops = {
   .write = mtest_proc_write  
};

static int __init mtest_init(void)  
{  
    mtest_proc_entry = proc_create("mtest", 0, NULL, &mtest_proc_fops);  
    if (mtest_proc_entry == NULL) {  
        printk("Error creating proc entry\n");  
        return -1;  
    }  
    printk("Succeed creating proc entry\n"); 

    return 0;  
}  
  
static void __exit mtest_exit(void)  
{  
    printk("Good bye proc!\n");    
    remove_proc_entry("mtest", NULL);  
    return;
}  

MODULE_LICENSE("GPL");  
module_init(mtest_init);  
module_exit(mtest_exit); 

