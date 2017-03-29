#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/moduleparam.h>


static char *charp_arg = "hello";
static int arr_arg[10] = {0};
static int arr_argc = 0;

module_param(charp_arg, charp, 0644);
module_param_array(arr_arg, int, &arr_argc, 0644);

static int __init param_init(void) {
    int i;
    printk(KERN_INFO "Hello world\n");
    printk(KERN_INFO "Get_string: %s\n", charp_arg);
    for (i = 0; i < arr_argc; i++) {
        printk(KERN_INFO "arr_arg[%d] = %d", i, arr_arg[i]);
    }
    printk(KERN_INFO "array args: %d", arr_argc);
    return 0;
}

static void __exit param_exit(void) {
    printk(KERN_INFO "Goodbye world!\n");
}

MODULE_LICENSE("GPL");
module_init(param_init);
module_exit(param_exit);
