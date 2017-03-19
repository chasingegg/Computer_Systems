#include<linux/kernel.h>
#include<linux/module.h>
#include<linux/init.h>
#include<linux/moduleparam.h>

static int test;
module_param(test, int, 0644);

void hello_foo(void)
{
    printk("Hello\n");
}
EXPORT_SYMBOL(hello_foo);

static int __init hello_init(void)
{
    printk(KERN_INFO "Hello world\n");
    printk(KERN_INFO "Params: test: %d;\n", test);
    return 0;
}
static void __exit hello_exit(void)
{
    printk(KERN_INFO "Goodbye world\n");
}

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Test");
MODULE_AUTHOR("Chao.G");
module_init(hello_init);
module_exit(hello_exit);