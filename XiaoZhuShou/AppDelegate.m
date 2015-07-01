//
//  AppDelegate.m
//  XiaoZhuShou
//
//  Created by yrq on 15-1-13.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import "AppDelegate.h"
#import "DDMenuController.h"
#import "MainViewController.h"
#import "TipViewController.h"
#import "UMSocial.h"
@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}
int a=1;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    // Override point for customization after application launch.
    
    self.dataWorker = [[CodeSQL alloc]init];
    [self.dataWorker createDB];
    
    if (a==1) {
        BOOL firstEnter=[[NSUserDefaults standardUserDefaults]boolForKey:@"firstEnter"];
        if (firstEnter==NO) {
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"firstEnter"];
            NSLog(@"first");
            [NSUserDefaults resetStandardUserDefaults];
            
            [self.dataWorker createTable:@"create table if not exists PLTable (PLTitle text,PLID int)"];
            [self.dataWorker createTable:@"create table if not exists CatalogueTable (PLID int,CatalogueID int,CatalogueTitle text,CatalogueExplain text,CatalogueExample text,CatalogueClass text,CatalogueUsage text)"];
            [self.dataWorker createTable:@"create table if not exists NoteTable (Note text,PLID int,CatalogueID)"];
            [self.dataWorker createTable:@"create table if not exists CollectTable (PLID int,CatalogueID)"];
            [self.dataWorker insertCatalogueTitle:@"HelloWorld" catalogueClass:@"介绍" catalogueUsage:@"初始化" catalogueExplain:@"你好，世界"
                catalogueExample:@"#include <stdio.h>\n int main( )\n {\n   printf(\"Hello, World! \");\n   return 0;\n}"
                catalogueID:0 cataloguePLID:0];
            [self.dataWorker insertCatalogueTitle:@"if 判断" catalogueClass:@"判断" catalogueUsage:@"  if\n  if...else\n  if...elseif" catalogueExplain:@"  用if语句可以构成分支结构。它根据给定的条件进行判断，以决定执行某个分支程序段。C语言的if语句有三种基本形式。"
                catalogueExample:@"＃include <stdio.h>\n int a=2,b=3;\n int main( )\n {\n   if(a<b){\n      printf(\"使用了if\\n\");\n   }\n\n   if(a>b){\n      printf(\"使用了if...else\\n\");\n   }else{\n      print(\"使用了if...else\\n\");\n   }\n  \n   if(a>b){\n      printf(\"使用了if...else if\\n\");\n   }else if(a=b){\n      printf(\"使用了if...else if\\n\");\n   }else{\n      printf(\"使用了if...else if\\n\");\n   }\n   return 0;\n }"
                catalogueID:1 cataloguePLID:0];
            [self.dataWorker insertCatalogueTitle:@"?: 运算符" catalogueClass:@"判断" catalogueUsage:@"Exp1 ? Exp2 : Exp3;" catalogueExplain:@"  Exp1、Exp2 和 Exp3 是表达式。请注意，冒号的使用和位置。\n  ? 表达式的值是由 Exp1 决定的。如果 Exp1 为真，则计算 Exp2 的值，结果即为整个 ? 表达式的值。如果 Exp1 为假，则计算 Exp3 的值，结果即为整个 ? 表达式的值。"
                catalogueExample:@" #include <stdio.h>\n main( )\n {\n    int a=4;\n    short b;\n    /* 条件运算符实例 */\n    a=10;\n    b=(a==1)?20:30;\n    printf(\"b 的值是 %d\\n\",b);\n    b=(a==10)?20:30;\n    printf(\"b 的值是 %d\\n\",b);\n }" catalogueID:2 cataloguePLID:0];
            [self.dataWorker insertCatalogueTitle:@"while 循环" catalogueClass:@"循环" catalogueUsage:@"while(condition)\n{\n  statement(s);\n}" catalogueExplain:@"  statement(s) 可以是一个单独的语句，也可以是几个语句组成的代码块。condition 可以是任意的表达式，当为任意非零值时都为真。当条件为真时执行循环。当条件为假时，程序流将继续执行紧接着循环的下一条语句。" catalogueExample:@" #include <stdio.h>\n int main ( )\n {\n   /* 局部变量定义 */\n   int a = 10;\n\n   /* while 循环执行 */\n   while(a<20)\n   {\n     printf(\"a的值:%d\\n\",a);\n     a++;\n   }\n\n   return 0;\n }" catalogueID:3 cataloguePLID:0];
            [self.dataWorker insertCatalogueTitle:@"for 循环" catalogueClass:@"循环" catalogueUsage:@" for(init;condition;increment)\n{\n  statement(s);\n}" catalogueExplain:@" for循环的控制流：\n 1.init会首先被执行，且只会执行一次。这一步允许您声明并初始化任何循环控制变量。您也可以不在这里写任何语句，只要有一个分号出现即可。\n 2.接下来，会判断 condition。如果为真，则执行循环主体。如果为假，则不执行循环主体，且控制流会跳转到紧接着 for 循环的下一条语句。\n 3.在执行完 for 循环主体后，控制流会跳回上面的 increment 语句。该语句允许您更新循环控制变量。该语句可以留空，只要在条件后有一个分号出现即可。\n 4.条件再次被判断。如果为真，则执行循环，这个过程会不断重复（循环主体，然后增加步值，再然后重新判断条件）。在条件变为假时，for循环终止。"
                catalogueExample:@" #include <stdio.h>\n\n int main( )\n {\n  /* for循环执行 */\n   for(int a=10;a<20;a=a+1)\n   {\n     printf(\"a的值：%d\\n\",a);\n }\n   return 0;\n }" catalogueID:4 cataloguePLID:0];
            [self.dataWorker insertCatalogueTitle:@"do...while 循环" catalogueClass:@"循环" catalogueUsage:@" do\n {\n   statement(s);\n }while(condition ;" catalogueExplain:@" 请注意，条件表达式出现在循环的尾部，所以循环中的statement(s) 会在条件被测试之前至少执行一次。\n 如果条件为真，控制流会跳转回上面的do，然后重新执行循环中的statement(s)。这个过程会不断重复，直到给定条件变为假为止。"
                catalogueExample:@" #include <stdio.h>\n int main( )\n {\n   /* 局部变量定义 */\n   int a = 10;\n\n   /* do 循环执行 */\n   do\n   {\n     printf(\"a 的值：%d\\n\",a);\n     a=a+1;\n   }while(a<20);\n\n   return 0;\n }" catalogueID:5 cataloguePLID:0];
            [self.dataWorker insertCatalogueTitle:@"break 语句" catalogueClass:@"循环" catalogueUsage:@" break;" catalogueExplain:@" 1.当break语句出现在一个循环内时，循环会立即终止，且程序流将继续执行紧接着循环的下一条语句。\n 2.它可用于终止 switch 语句中的一个case。\n 3.如果您使用的是嵌套循环（即一个循环内嵌套另一个循环），break语句会停止执行最内层的循环，然后开始执行该块之后的下一行代码。"
                catalogueExample:@" #include <stdio.h>\n int main ( )\n {\n   /* 局部变量定义 */\n   int a = 10;\n\n   /* while 循环执行 */\n   while(a<20)\n   {\n     printf(\"a的值:%d\\n\",a);\n     a++;\n     if(a>15)\n     {\n       break;\n     }\n   }\n\n   return 0;\n }" catalogueID:6 cataloguePLID:0];
            [self.dataWorker insertCatalogueTitle:@"continue 语句" catalogueClass:@"循环" catalogueUsage:@" continue;" catalogueExplain:@" 1.C语言中的 continue 语句有点像break语句。但它不是强迫终止，continue 会跳过当前循环中的代码，强迫开始下一次循环。\n 2.对于for循环，continue语句会导致执行条件测试和循环增量部分。对于while和 do...while 循环，continue语句会导致程序控制回到条件测试上。"
                catalogueExample:@" #include <stdio.h>\n int main( )\n {\n   /* 局部变量定义 */\n   int a=10;\n   /* do 循环执行 */\n   do\n   {\n     if(a==15)\n     {\n       /* 跳过迭代 */\n       a=a+1;\n       continue;\n     }\n     printf(\"a的值：%d\\n\", a);\n     a++;\n\n   }while( a < 20 );\n   return 0;\n }" catalogueID:7 cataloguePLID:0];
            [self.dataWorker insertCatalogueTitle:@"goto 语句" catalogueClass:@"循环" catalogueUsage:@" goto label;\n ..\n .\n label: statement;" catalogueExplain:@" 在这里，label可以是任何除C关键字以外的纯文本，它可以设置在C程序中goto语句的前面或者后面。\n 1.C 语言中的goto语句允许把控制无条件转移到同一函数内的被标记的语句。\n 2.注意：在任何编程语言中，都不建议使用goto语句。因为它使得程序的控制流难以跟踪，使程序难以理解和难以修改。任何使用goto语句的程序可以改写成不需要使用 goto 语句的写法。"
                catalogueExample:@" #include <stdio.h>\n int main( )\n {\n   /* 局部变量定义 */\n   int a=10;\n\n   /* do 循环执行 */\n LOOP:do\n {\n   if(a==15)\n   {\n     /* 跳过迭代 */\n     a=a+1;\n     goto LOOP;\n   }\n   printf(\"a的值：%d\\n\",a);\n   a++;\n\n }while(a<20);\n   return 0;\n }" catalogueID:8 cataloguePLID:0];
            [self.dataWorker insertCatalogueTitle:@"定义函数" catalogueClass:@"函数" catalogueUsage:@" return_type function_name(parameter list)\n {\n   body of the function\n }" catalogueExplain:@" 在C语言中，函数由一个函数头和一个函数主体组成。下面列出一个函数的所有组成部分：\n   1.返回类型：一个函数可以返回一个值。return_type 是函数返回的值的数据类型。有些函数执行所需的操作而不返回值，在这种情况下，return_type 是关键字 void。\n   2.函数名称：这是函数的实际名称。函数名和参数列表一起构成了函数签名。\n   3.参数：参数就像是占位符。当函数被调用时，您向参数传递一个值，这个值被称为实际参数。参数列表包括函数参数的类型、顺序、数量。参数是可选的，也就是说，函数可能不包含参数。\n   4.函数主体：函数主体包含一组定义函数执行任务的语句。" catalogueExample:@" /* 函数返回两个数中较大的那个数 */\n int max(int num1, int num2)\n {\n   /* 局部变量声明 */\n   int result;\n   if (num1 > num2)\n     result = num1;\n   else\n     result = num2;\n\n   return result;\n }" catalogueID:9 cataloguePLID:0];
            [self.dataWorker insertCatalogueTitle:@"声明与调用函数" catalogueClass:@"函数" catalogueUsage:@" 针对上一条函数的声明：\n int max(int num1,int num2);\n or\n int max(int,int);" catalogueExplain:@" 关于声明：\n 1.函数声明会告诉编译器函数名称及如何调用函数。函数的实际主体可以单独定义。函数声明包括以下几个部分：\n return_type function_name(parameter list);\n 2.在函数声明中，参数的名称并不重要，只有参数的类型是必需的。\n 3.当在一个源文件中定义函数且在另一个文件中调用函数时，函数声明是必需的。在这种情况下，应该在调用函数的文件顶部声明函数。\n 关于调用：\n 1.创建C函数时，会定义函数做什么，然后通过调用函数来完成已定义的任务。\n 2.当程序调用函数时，程序控制权会转移给被调用的函数。被调用的函数执行已定义的任务，当函数的返回语句被执行时，或到达函数的结束括号时，会把程序控制权交还给主程序。\n 3.调用函数时，传递所需参数，如果函数返回一个值，则可以存储返回值。例如："
                catalogueExample:@" #include <stdio.h>\n /* 函数声明 */\n int max(int num1, int num2);\n int main( )\n {\n   /* 局部变量定义 */\n   int a = 100;\n   int b = 200;\n   int ret;\n\n   /* 调用函数来获取最大值 */\n   ret = max(a, b);\n   printf(\"Max value is : %d\\n\",ret);\n   return 0;\n }" catalogueID:10 cataloguePLID:0];
            [self.dataWorker insertCatalogueTitle:@"声明数组" catalogueClass:@"数组" catalogueUsage:@" type arrayName [arraySize];" catalogueExplain:@" 如上所示，这叫做一维数组。在C中要声明一个数组，需要指定元素的类型和元素的数量。\n arraySize必须是一个大于零的整数常量，type 可以是任意有效的C数据类型。\n 例如，要声明一个类型为 double 的包含10个元素的数组balance，声明语句如下："
                catalogueExample:@" double balance[10];\n /* balance 是一个可用的数组，可以容纳 10 个类型为 double 的数字。 */" catalogueID:11 cataloguePLID:0];
            [self.dataWorker insertCatalogueTitle:@"初始化数组" catalogueClass:@"数组" catalogueUsage:@"double balance[5] = {1000.0, 2.0, 3.4, 7.0, 50.0};" catalogueExplain:@" 如上所示，在C中，您可以逐个初始化数组，也可以使用一个初始化语句。\n 大括号 { } 之间的值的数目不能大于我们在数组声明时在方括号[ ]中指定的元素数目。\n 如果您省略掉了数组的大小，数组的大小则为初始化时元素的个数。" catalogueExample:@" double balance[] = {1000.0, 2.0, 3.4, 7.0, 50.0};" catalogueID:12 cataloguePLID:0];
            [self.dataWorker insertCatalogueTitle:@"访问数组元素" catalogueClass:@"数组" catalogueUsage:@" double salary = balance[9];" catalogueExplain:@" 上面的语句将把数组中第10个元素的值赋给salary变量。\n 数组元素可以通过数组名称加索引进行访问。元素的索引是放在方括号内，跟在数组名称的后边。" catalogueExample:@"" catalogueID:13 cataloguePLID:0];
            [self.dataWorker insertCatalogueTitle:@"指针" catalogueClass:@"指针" catalogueUsage:@" type *var-name;" catalogueExplain:@" 如上所示为指针变量声明的一般形式。指针是一个变量，其值为另一个变量的地址，即，内存位置的直接地址。就像其他变量或常量一样，您必须在使用指针存储其他变量地址之前，对其进行声明。\n type是指针的基类型，它必须是一个有效的C数据类型，var-name 是指针变量的名称。用来声明指针的星号 *与乘法中使用的星号是相同的。但是，在这个语句中，星号是用来指定一个变量是指针。\n 以下是有效的指针声明：" catalogueExample:@" int    *ip;    /* 一个整型的指针 */\n double *dp;    /* 一个 double 型的指针 */\n float  *fp;    /* 一个浮点型的指针 */\n char   *ch     /* 一个字符型的指针 */" catalogueID:14 cataloguePLID:0];
            [self.dataWorker insertCatalogueTitle:@"使用指针" catalogueClass:@"指针" catalogueUsage:@"" catalogueExplain:@" 使用指针时会频繁进行以下几个操作：定义一个指针变量、把变量地址赋值给指针、访问指针变量中可用地址的值。这些是通过使用一元运算符*来返回位于操作数所指定地址的变量的值。下面的实例涉及到了这些操作：" catalogueExample:@" #include <stdio.h>\n int main( )\n {\n   int  var = 20;   /* 实际变量的声明 */\n   int  *ip;        /* 指针变量的声明 */\n\n   ip = &var;  /* 在指针变量中存储var的地址 */\n   printf(\"Address of var variable: %x\\n\",&var);\n\n   /* 在指针变量中存储的地址 */\n   printf(\"Address stored in ip variable: %x\\n\",ip);\n\n   /* 使用指针访问值 */\n   printf(\"Value of *ip variable: %d\\n\", *ip );\n\n   return 0;\n }" catalogueID:15 cataloguePLID:0];
            [self.dataWorker insertCatalogueTitle:@"字符串" catalogueClass:@"字符串" catalogueUsage:@" char greeting[]=\"Hello\";" catalogueExplain:@" 在C语言中，字符串实际上是使用null字符'\0'终止的一维字符数组。因此，一个以 null 结尾的字符串，包含了组成字符串的字符。\n 上面的声明和初始化创建了一个 \"Hello\"字符串。由于在数组的末尾存储了空字符，所以字符数组的大小比单词\"Hello\"的字符数多一个。\n 其实，不需要把 null 字符放在字符串常量的末尾。C 编译器会在初始化数组时，自动把 '\0' 放在字符串的末尾。让我们尝试输出上面的字符串：" catalogueExample:@" #include <stdio.h>\n int main( )\n {\n   char greeting[6] = {'H', 'e', 'l', 'l', 'o', '\0'};\n\n   printf(\"Greeting message: %s\\n\", greeting );\n\n   return 0;\n }" catalogueID:16 cataloguePLID:0];
            [self.dataWorker insertCatalogueTitle:@"字符串相关函数" catalogueClass:@"字符串" catalogueUsage:@" strcpy(s1, s2);\n /*复制字符串 s2 到字符串 s1。*/\n strcat(s1, s2);\n /*连接字符串 s2 到字符串 s1 的末尾。*/\n strlen(s1);\n /*返回字符串 s1 的长度。*/\n strcmp(s1, s2);\n /*如果 s1 和 s2 是相同的，则返回 0；如果 s1<s2 则返回小于 0；如果 s1>s2 则返回大于 0。*/\n strchr(s1, ch);\n /*返回一个指针，指向字符串 s1 中字符 ch 的第一次出现的位置。*/\n strstr(s1, s2);\n /*返回一个指针，指向字符串 s1 中字符串 s2 的第一次出现的位置。*/" catalogueExplain:@"下面的实例使用了上述的一些函数：" catalogueExample:@" #include <stdio.h>\n #include <string.h>\n int main( )\n {\n   char str1[12]=\"Hello\";\n   char str2[12] = \"World\";\n   char str3[12];\n   int  len;\n\n   /* 复制 str1 到 str3 */\n   strcpy(str3, str1);\n   printf(\"strcpy(str3,str1): %s\\n\",str3);\n\n   /* 连接 str1 和 str2 */\n   strcat(str1,str2);\n   printf(\"strcat(str1,str2):%s\\n\",str1);\n\n   /* 连接后，str1 的总长度 */\n   len = strlen(str1);\n   printf(\"strlen(str1):%d\\n\",len);\n\n   return 0;\n }" catalogueID:17 cataloguePLID:0];
            [self.dataWorker insertCatalogueTitle:@"声明结构体" catalogueClass:@"结构体" catalogueUsage:@" struct [structure tag]\n {\n   member definition;\n   member definition;\n   ...\n   member definition;\n } [one or more structure variables];" catalogueExplain:@" 为了定义结构体，必须使用struct语句。struct语句定义了一个包含多个成员的新的数据类型，struct语句的格式如上所示：\n structure tag 是可选的，每个 member definition 是标准的变量定义，比如 int i; 或者 float f; 或者其他有效的变量定义。在结构定义的末尾，最后一个分号之前，您可以指定一个或多个结构变量，这是可选的。下面是声明 Book 结构的方式：" catalogueExample:@" struct Books\n {\n   char  title[50];\n   char  author[50];\n   char  subject[100];\n   int   book_id;\n } book;" catalogueID:18 cataloguePLID:0];
            [self.dataWorker insertCatalogueTitle:@"访问结构体成员" catalogueClass:@"结构体" catalogueUsage:@"" catalogueExplain:@" 为了访问结构的成员，使用成员访问运算符（.）。成员访问运算符是结构变量名称和我们要访问的结构成员之间的一个句号。可以使用struct关键字来定义结构类型的变量。下面的实例演示了结构的用法：" catalogueExample:@" #include <stdio.h>\n #include <string.h>\n\n struct Books\n {\n   char  title[50];\n   char  author[50];\n   char  subject[100];\n   int   book_id;\n };\n\n int main( )\n {\n   struct Books Book1;        /* 声明 Book1，类型为 Book */\n   struct Books Book2;        /* 声明 Book2，类型为 Book */\n\n   /* Book1 详述 */\n   strcpy( Book1.title, \"C Programming\");\n   strcpy( Book1.author, \"Nuha Ali\");\n   strcpy( Book1.subject, \"C Programming Tutorial\");\n   Book1.book_id = 6495407;\n\n   /* Book2 详述 */\n   strcpy( Book2.title, \"Telecom Billing\");\n   strcpy( Book2.author, \"Zara Ali\");\n   strcpy( Book2.subject, \"Telecom Billing Tutorial\");\n   Book2.book_id = 6495700;\n\n   /* 输出 Book1 信息 */\n   printf( \"Book 1 title : %s\\n\", Book1.title);\n   printf( \"Book 1 author : %s\\n\", Book1.author);\n   printf( \"Book 1 subject : %s\\n\", Book1.subject);\n   printf( \"Book 1 book_id : %d\\n\", Book1.book_id);\n\n   /* 输出 Book2 信息 */\n   printf( \"Book 2 title : %s\\n\", Book2.title);\n   printf( \"Book 2 author : %s\\n\", Book2.author);\n   printf( \"Book 2 subject : %s\\n\", Book2.subject);\n   printf( \"Book 2 book_id : %d\\n\", Book2.book_id);\n\n   return 0;\n }" catalogueID:19 cataloguePLID:0];
            [self.dataWorker insertCatalogueTitle:@"HelloWorld" catalogueClass:@"介绍" catalogueUsage:@"" catalogueExplain:@" 你好，世界"
                catalogueExample:@" #include<iostream.h>\n using namespace std;\n int main()\n {\n	cout<<\"Hello,World!\"<<endl;\n	return 0;\n}" catalogueID:0 cataloguePLID:1];
            [self.dataWorker insertCatalogueTitle:@"if 判断" catalogueClass:@"判断" catalogueUsage:@" if(boolean_expression)\n {\n   // 如果布尔表达式为真将执行的语句\n }" catalogueExplain:@" 如果布尔表达式为true，则if语句内的代码块将被执行。如果布尔表达式为false，则if语句结束后的第一组代码（闭括号后）将被执行。\n C++把任何非零和非空的值假定为true，把零或null假定为false。" catalogueExample:@" #include <iostream>\n using namespace std;\n int main( )\n {\n   // 局部变量声明\n   int a=10;\n\n   // 使用if语句检查布尔条件\n   if(a<20)\n   {\n     // 如果条件为真，则输出下面的语句\n     cout << \"a小于20\" << endl;\n   }\n   cout << \"a的值是 \" << a << endl;\n\n   return 0;\n }" catalogueID:1 cataloguePLID:1];
            [self.dataWorker insertCatalogueTitle:@"switch 判断" catalogueClass:@"判断" catalogueUsage:@" switch(expression){\n case constant-expression:\n statement(s);\n break; // 可选的\n case constant-expression:\n statement(s);\n break; // 可选的\n\n // 您可以有任意数量的case 语句\n default : // 可选的\n statement(s);\n}" catalogueExplain:@" 1.switch 语句中的 expression 必须是一个整型或枚举类型，或者是一个 class 类型，其中 class 有一个单一的转换函数将其转换为整型或枚举类型。\n 2.在一个 switch 中可以有任意数量的 case 语句。每个 case 后跟一个要比较的值和一个冒号。\n 3.case 的 constant-expression 必须与 switch 中的变量具有相同的数据类型，且必须是一个常量或字面量。\n 4.当被测试的变量等于 case 中的常量时，case 后跟的语句将被执行，直到遇到 break 语句为止。\n 5.当遇到 break 语句时，switch 终止，控制流将跳转到 switch 语句后的下一行。\n 6.不是每一个 case 都需要包含 break。如果 case 语句不包含 break，控制流将会 继续 后续的 case，直到遇到 break 为止。\n 7.一个 switch 语句可以有一个可选的 default case，出现在 switch 的结尾。default case 可用于在上面所有 case 都不为真时执行一个任务。default case 中的 break 语句不是必需的。" catalogueExample:@" #include <iostream>\n using namespace std;\n\n int main( )\n {\n   // 局部变量声明\n   char grade = 'D';\n\n   switch(grade)\n   {\n     case 'A':\n       cout << \"很棒！\" << endl;\n       break;\n     case 'B':\n     case 'C':\n       cout << \"做得好\" << endl;\n       break;\n     case 'D' :\n       cout << \"您通过了\" << endl;\n       break;\n     case 'F':\n       cout << \"最好再试一下\" << endl;\n       break;\n     default:\n       cout << \"无效的成绩\" << endl;\n   }\n   cout << \"您的成绩是\" << grade << endl;\n\n   return 0;\n }" catalogueID:2 cataloguePLID:1];
            [self.dataWorker insertCatalogueTitle:@"while 循环" catalogueClass:@"循环" catalogueUsage:@" while(condition)\n {\n   statement(s);\n }" catalogueExplain:@" 在这里，statement(s)可以是一个单独的语句，也可以是几个语句组成的代码块。condition可以是任意的表达式，当为任意非零值时都为真。当条件为真时执行循环。\n 当条件为假时，程序流将继续执行紧接着循环的下一条语句。\n while循环的关键点是循环可能一次都不会执行。当条件被测试且结果为假时，会跳过循环主体，直接执行紧接着while循环的下一条语句。" catalogueExample:@" #include <iostream>\n using namespace std;\n\n int main( )\n {\n   // 局部变量声明\n   int a = 10;\n\n   // while 循环执行\n   while(a<20)\n   {\n     cout << \"a 的值：\" << a << endl;\n     a++;\n   }\n\n   return 0;\n }" catalogueID:3 cataloguePLID:1];
            [self.dataWorker insertCatalogueTitle:@"for 循环" catalogueClass:@"循环" catalogueUsage:@" for(init; condition;increment)\n {\n   statement(s);\n }" catalogueExplain:@" 1.init会首先被执行，且只会执行一次。这一步允许您声明并初始化任何循环控制变量。您也可以不在这里写任何语句，只要有一个分号出现即可。\n 2.接下来，会判断 condition。如果为真，则执行循环主体。如果为假，则不执行循环主体，且控制流会跳转到紧接着 for 循环的下一条语句。\n 3.在执行完 for 循环主体后，控制流会跳回上面的 increment 语句。该语句允许您更新循环控制变量。该语句可以留空，只要在条件后有一个分号出现即可。\n 4.条件再次被判断。如果为真，则执行循环，这个过程会不断重复（循环主体，然后增加步值，再然后重新判断条件）。在条件变为假时，for 循环终止。" catalogueExample:@" #include <iostream>\n using namespace std;\n\n int main( )\n {\n   // for 循环执行\n   for( int a=10; a<20; a=a+1 )\n   {\n     cout << \"a 的值：\" << a << endl;\n   }\n\n   return 0;\n }" catalogueID:4 cataloguePLID:1];
            [self.dataWorker insertCatalogueTitle:@"do...while 循环" catalogueClass:@"循环" catalogueUsage:@" do\n {\n   statement(s);\n\n }while(condition);" catalogueExplain:@" 请注意，条件表达式出现在循环的尾部，所以循环中的statement(s) 会在条件被测试之前至少执行一次。\n 如果条件为真，控制流会跳转回上面的do，然后重新执行循环中的statement(s)。这个过程会不断重复，直到给定条件变为假为止。" catalogueExample:@" #include <iostream>\n using namespace std;\n\n int main( )\n {\n   // 局部变量声明\n   int a=10;\n\n   // do 循环执行\n   do\n   {\n     cout << \"a 的值：\" << a << endl;\n     a=a+1;\n   }while(a<20);\n\n   return 0;\n }" catalogueID:5 cataloguePLID:1];
            [self.dataWorker insertCatalogueTitle:@"定义函数" catalogueClass:@"函数" catalogueUsage:@" return_type function_name(parameter list)\n{   body of the function\n}" catalogueExplain:@" C++ 中的函数定义的一般形式如上所示。\n 在 C++ 中，函数由一个函数头和一个函数主体组成。下面列出一个函数的所有组成部分：\n   返回类型：一个函数可以返回一个值。return_type 是函数返回的值的数据类型。有些函数执行所需的操\n   作而不返回值，在这种情况下，return_type 是关键字 void。\n   函数名称：这是函数的实际名称。函数名和参数列表一起构成了函数签名。\n   参数：参数就像是占位符。当函数被调用时，您向参数传递一个值，这个值被称为实际参数。参数列表包括函数参数的类型、顺序、数量。参数是可选的，也就是说，函数可能不包含参数。\n   函数主体：函数主体包含一组定义函数执行任务的语句。"
                catalogueExample:@" // 函数返回两个数中较大的那个数\n\n int max(int num1, int num2) \n {\n   // 局部变量声明\n   int result;\n   if (num1 > num2)\n     result = num1;\n   else\n     result = num2;\n   return result;\n }"
                catalogueID:6 cataloguePLID:1];
            [self.dataWorker insertCatalogueTitle:@"函数声明" catalogueClass:@"函数" catalogueUsage:@" return_type function_name(parameter list);" catalogueExplain:@" 针对上面定义的函数 max()，以上是函数声明。\n 函数声明会告诉编译器函数名称及如何调用函数。函数的实际主体可以单独定义。\n 当在一个源文件中定义函数且在另一个文件中调用函数时，函数声明是必需的。在这种情况下，您应该在调用函数的文件顶部声明函数。"
                catalogueExample:@" int max(int num1,int num2);"
                catalogueID:7 cataloguePLID:1];
            [self.dataWorker insertCatalogueTitle:@"声明数组" catalogueClass:@"数组" catalogueUsage:@" type arrayName [arraySize];" catalogueExplain:@" 在 C++ 中要声明一个数组，需要指定元素的类型和元素的数量，如上所示。\n 这叫做一维数组。arraySize 必须是一个大于零的整数常量，type 可以是任意有效的 C++ 数据类型。\n 例如，要声明一个类型为 double 的包含10个元素的数组 balance，声明语句如下："
                catalogueExample:@" double balance[10];"
                catalogueID:8 cataloguePLID:1];
            [self.dataWorker insertCatalogueTitle:@"初始化数组" catalogueClass:@"数组" catalogueUsage:@" double balance[5] = {1000.0, 2.0, 3.4, 17.0, 50.0};" catalogueExplain:@" 在 C++ 中，可以逐个初始化数组，也可以使用一个初始化语句，如上所示。\n 大括号 { } 之间的值的数目不能大于我们在数组声明时在方括号 [ ] 中指定的元素数目。\n 如果您省略掉了数组的大小，数组的大小则为初始化时元素的个数。如下所示：" catalogueExample:@" double balance[] = {1000.0, 2.0, 3.4, 17.0, 50.0};" catalogueID:9 cataloguePLID:1];
            [self.dataWorker insertCatalogueTitle:@"访问数组元素" catalogueClass:@"数组" catalogueUsage:@" double salary = balance[9];"
                catalogueExplain:@" 数组元素可以通过数组名称加索引进行访问。元素的索引是放在方括号内，跟在数组名称的后边。\n 上面的语句将把数组中第 10 个元素的值赋给 salary 变量。下面的实例使用了上述的三个概念，即，声明数组、数组赋值、访问数组："
                catalogueExample:@" #include <iostream>\n using namespace std;\n #include <iomanip>\n using std::setw;\n int main ()\n {\n   int n[ 10 ]; // n 是一个包含 10 个整数的数组\n\n   // 初始化数组元素\n   for ( int i = 0; i < 10; i++ )\n   {\n     n[i] = i + 100; // 设置元素 i 为 i + 100\n   }\n   cout << \"Element\" << setw( 13 ) << \"Value\" << endl;\n\n   // 输出数组中每个元素的值\n   for ( int j = 0; j < 10; j++ )\n   {\n     cout << setw( 7 )<< j << setw( 13 ) << n[ j ] << endl;\n   }\n\n   return 0;\n }"
                catalogueID:10 cataloguePLID:1];
            [self.dataWorker insertCatalogueTitle:@"字符串函数" catalogueClass:@"字符串" catalogueUsage:@" strcpy(s1, s2);\n 复制字符串 s2 到字符串 s1。\n strcat(s1, s2);\n 连接字符串 s2 到字符串 s1 的末尾。\n strlen(s1);\n 返回字符串 s1 的长度。\n strcmp(s1, s2);\n 如果 s1 和 s2 是相同的，则返回 0；如果 s1<s2 则返回小于 0；如果 s1>s2 则返回大于 0。\n strchr(s1, ch);\n 返回一个指针，指向字符串 s1 中字符 ch 的第一次出现的位置。\n strstr(s1, s2);\n 返回一个指针，指向字符串 s1 中字符串 s2 的第一次出现的位置。"
                catalogueExplain:@" 下面的实例使用了上述的一些函数："
                catalogueExample:@" #include <iostream>\n #include <cstring>\n\n using namespace std;\n\n int main ()\n{\n   char str1[10] = \"Hello\";\n   char str2[10] = \"World\";\n   char str3[10];\n   int  len ;\n\n   // 复制 str1 到 str3\n   strcpy( str3, str1);\n   cout << \"strcpy( str3, str1) : \" << str3 << endl;\n\n   // 连接 str1 和 str2\n   strcat( str1, str2);\n   cout << \"strcat( str1, str2): \" << str1 << endl;\n\n   // 连接后，str1 的总长度\n   len = strlen(str1);\n   cout << \"strlen(str1) : \" << len << endl;\n\n   return 0;\n }"
                catalogueID:11 cataloguePLID:1];
            [self.dataWorker insertCatalogueTitle:@"指针" catalogueClass:@"指针" catalogueUsage:@" type *var-name;" catalogueExplain:@" 指针变量声明的一般形式如上所示。\n 指针是一个变量，其值为另一个变量的地址，即，内存位置的直接地址。就像其他变量或常量一样，您必须在使用指针存储其他变量地址之前，对其进行声明。\n 在这里，type 是指针的基类型，它必须是一个有效的 C++ 数据类型，var-name 是指针变量的名称。用来声明指针的星号 * 与乘法中使用的星号是相同的。但是，在这个语句中，星号是用来指定一个变量是指针。\n 所有指针的值的实际数据类型，不管是整型、浮点型、字符型，还是其他的数据类型，都是一样的，都是一个代表内存地址的长的十六进制数。不同数据类型的指针之间唯一的不同是，指针所指向的变量或常量的数据类型不同。\n 以下是有效的指针声明："
                catalogueExample:@" int    *ip;    /* 一个整型的指针 */\n double *dp;    /* 一个 double 型的指针 */\n float  *fp;    /* 一个浮点型的指针 */\n char   *ch     /* 一个字符型的指针 */"
                catalogueID:12 cataloguePLID:1];
            [self.dataWorker insertCatalogueTitle:@"使用指针" catalogueClass:@"指针" catalogueUsage:@"" catalogueExplain:@" 使用指针时会频繁进行以下几个操作：定义一个指针变量、把变量地址赋值给指针、访问指针变量中可用地址的值。这些是通过使用一元运算符 * 来返回位于操作数所指定地址的变量的值。下面的实例涉及到了这些操作："
                catalogueExample:@" #include <iostream>\nusing namespace std;\n int main ()\n{\n   int  var = 20;   // 实际变量的声明\n   int  *ip;        // 指针变量的声明\n\n   ip = &var;       // 在指针变量中存储 var 的地址\n\n   cout << \"Value of var variable: \";\n   cout << var << endl;\n\n   // 输出在指针变量中存储的地址\n   cout << \"Address stored in ip variable: \";\n   cout << ip << endl;\n\n   // 访问指针中地址的值\n   cout << \"Value of *ip variable: \";\n   cout << *ip << endl;\n   return 0;\n }"
                catalogueID:13 cataloguePLID:1];
            [self.dataWorker insertCatalogueTitle:@"引用" catalogueClass:@"引用" catalogueUsage:@" int    i = 17;\n\n //为 i 声明引用变量，如下所示：\n int&    r = i;"
                catalogueExplain:@" 在这些声明中，& 读作引用。因此，第一个声明可以读作\"r 是一个初始化为 i 的整型引用\"，第二个声明可以读作\"s 是一个初始化为 d 的 double 型引用\"。\n 变量名称是变量附属在内存位置中的标签，可以把引用当成是变量附属在内存位置中的第二个标签。因此，可以通过原始变量名称或引用来访问变量的内容。\n 下面的实例使用了 int 和 double 引用："
                catalogueExample:@" #include <iostream>\n using namespace std;\n int main ()\n {\n   // 声明简单的变量\n   int    i;\n   double d;\n\n   // 声明引用变量\n   int&    r = i;\n   double& s = d;\n\n   i = 5;\n   cout << \"Value of i : \" << i << endl;\n   cout << \"Value of i reference : \" << r  << endl;\n\n   d = 11.7;\n   cout << \"Value of d : \" << d << endl;\n   cout << \"Value of d reference : \" << s  << endl;\n\n   return 0;\n }"
                catalogueID:14 cataloguePLID:1];
            [self.dataWorker insertCatalogueTitle:@"标准输出流" catalogueClass:@"I/O" catalogueUsage:@"" catalogueExplain:@" 预定义的对象 cout 是 ostream 类的一个实例。cout 对象\"连接\"到标准输出设备，通常是显示屏。cout 是与流插入运算符 << 结合使用的，如下所示："
                catalogueExample:@" #include <iostream>\n using namespace std;\n int main( )\n {\n   char str[] = \"Hello C++\";\n   //流插入运算符 << 在一个语句中可以多次使用，endl 用于在行末添加一个换行符。\n   cout << \"Value of str is : \" << str << endl;\n }"
                catalogueID:15 cataloguePLID:1];
            [self.dataWorker insertCatalogueTitle:@"标准输入流" catalogueClass:@"I/O" catalogueUsage:@"" catalogueExplain:@" 预定义的对象 cin 是 istream 类的一个实例。cin 对象附属到标准输入设备，通常是键盘。cin 是与流提取运算符 >> 结合使用的，如下所示：" catalogueExample:@" #include <iostream>\n using namespace std;\n int main( )\n {\n   char name[50];\n\n   cout << \"请输入您的名称： \";\n   cin >> name;\n   cout << \"您的名称是： \" << name << endl;\n }"
                catalogueID:16 cataloguePLID:1];
            [self.dataWorker insertCatalogueTitle:@"标准错误流" catalogueClass:@"I/O" catalogueUsage:@"" catalogueExplain:@" 预定义的对象 cerr 是 ostream 类的一个实例。cerr 对象附属到标准错误设备，通常也是显示屏，但是 cerr 对象是非缓冲的，且每个流插入到 cerr 都会立即输出。\n cerr 也是与流插入运算符 << 结合使用的，如下所示："
                catalogueExample:@" #include <iostream>\n using namespace std;\n int main( )\n {\n   char str[] = \"Unable to read....\";\n\n   cerr << \"Error message : \" << str << endl;\n }" catalogueID:17 cataloguePLID:1];
            [self.dataWorker insertCatalogueTitle:@"标准日志流" catalogueClass:@"I/O" catalogueUsage:@"" catalogueExplain:@" 预定义的对象 clog 是 ostream 类的一个实例。clog 对象附属到标准错误设备，通常也是显示屏，但是 clog 对象是缓冲的。这意味着每个流插入到 clog 都会先存储在缓冲在，直到缓冲填满或者缓冲区刷新时才会输出。\n clog 也是与流插入运算符 << 结合使用的，如下所示："
                catalogueExample:@" #include <iostream>\n using namespace std;\n int main( )\n {\n   char str[] = \"Unable to read....\";\n\n   clog << \"Error message : \" << str << endl;\n }" catalogueID:18 cataloguePLID:1];
            [self.dataWorker insertCatalogueTitle:@"HelloWorld" catalogueClass:@"介绍" catalogueUsage:@"初始化" catalogueExplain:@"你好，世界"
                catalogueExample:@"public class HelloWorld {\n\n   public static void main(String []args) {\n    System.out.println(\"Hello,World!\");\n   }\n}" catalogueID:0 cataloguePLID:2];
            [self.dataWorker insertCatalogueTitle:@"if 判断" catalogueClass:@"判断" catalogueUsage:@" if(布尔表达式)\n {\n   //如果布尔表达式为true将执行的语句\n }" catalogueExplain:@" 如果布尔表达式的值为true，则执行if语句中的代码块。否则执行If语句块后面的代码。" catalogueExample:@" public class Test {\n\n   public static void main(String args[ ]){\n     int x=10;\n\n     if(x <20){\n       System.out.print(\"这是if语句\");\n     }\n   }\n }" catalogueID:1 cataloguePLID:2];
            [self.dataWorker insertCatalogueTitle:@"if...else 判断" catalogueClass:@"判断" catalogueUsage:@" if(布尔表达式){\n   //如果布尔表达式的值为true\n }else{\n   //如果布尔表达式的值为false\n }" catalogueExplain:@" if语句后面可以跟else语句，当if语句的布尔表达式值为false时，else语句块会被执行。" catalogueExample:@"\n public class Test {\n   public static void main(String args[ ]){\n     int x = 30;\n\n     if(x<20){\n       System.out.print(\"这是if语句\");\n     }else{\n       System.out.print(\"这是else语句\");\n     }\n   }\n }" catalogueID:2 cataloguePLID:2];
            [self.dataWorker insertCatalogueTitle:@"if...else if 判断" catalogueClass:@"判断" catalogueUsage:@" if(布尔表达式 1){\n   //如果布尔表达式 1的值为true执行代码\n }else if(布尔表达式 2){\n   //如果布尔表达式 2的值为true执行代码\n }else if(布尔表达式 3){\n   //如果布尔表达式 3的值为true执行代码\n }else {\n   //如果以上布尔表达式都不为true执行代码\n }" catalogueExplain:@" if语句后面可以跟elseif…else语句，这种语句可以检测到多种可能的情况。\n 使用if，else if，else语句的时候，需要注意下面几点：\n   1.if语句至多有1个else语句，else语句在所有的elseif语句之后。\n   2.If语句可以有若干个elseif语句，它们必须在else语句之前。\n   3.一旦其中一个else if语句检测为true，其他的else if以及else语句都将跳过执行。" catalogueExample:@"\n public class Test {\n   public static void main(String args[ ]){\n     int x = 30;\n\n     if(x==10){\n       System.out.print(\"Value of X is 10\");\n     }else if(x==20){\n       System.out.print(\"Value of X is 20\");\n     }else if(x==30){\n       System.out.print(\"Value of X is 30\");\n     }else{\n       System.out.print(\"This is else statement\");\n     }\n   }\n }" catalogueID:3 cataloguePLID:2];
            [self.dataWorker insertCatalogueTitle:@"while 循环" catalogueClass:@"循环" catalogueUsage:@" while(布尔表达式) {\n   //循环内容\n }" catalogueExplain:@"  只要布尔表达式为true，循环体会一直执行下去。" catalogueExample:@"public class Test {\n public static void main(String args[ ]) {\n   int x = 10;\n   while(x<20) {\n     System.out.print(\"value of x : \"+x);\n     x++;\n     System.out.print(\"\\n\");\n   }\n }\n }" catalogueID:4 cataloguePLID:2];
            [self.dataWorker insertCatalogueTitle:@"do…while 循环" catalogueClass:@"循环" catalogueUsage:@" do {\n   //代码语句\n }while(布尔表达式);" catalogueExplain:@" 对于while语句而言，如果不满足条件，则不能进入循环。但有时候我们需要即使不满足条件，也至少执行一次。\n do…while循环和while循环相似，不同的是，do…while循环至少会执行一次。\n 注意：布尔表达式在循环体的后面，所以语句块在检测布尔表达式之前已经执行了。 如果布尔表达式的值为true，则语句块一直执行，直到布尔表达式的值为false。" catalogueExample:@" public class Test {\n   public static void main(String args[]){\n     int x = 10;\n\n     do{\n       System.out.print(\"value of x : \" + x );\n       x++;\n       System.out.print(\"\\n\");\n     }while( x < 20 );\n   }\n }" catalogueID:5 cataloguePLID:2];
            [self.dataWorker insertCatalogueTitle:@"for 循环" catalogueClass:@"循环" catalogueUsage:@" for(初始化; 布尔表达式; 更新) {\n   //代码语句\n }" catalogueExplain:@" 关于for循环有以下几点说明：\n 最先执行初始化步骤。可以声明一种类型，但可初始化一个或多个循环控制变量，也可以是空语句。\n 然后，检测布尔表达式的值。如果为true，循环体被执行。如果为false，循环终止，开始执行循环体后面的语句。\n 执行一次循环后，更新循环控制变量。\n 再次检测布尔表达式。循环执行上面的过程。"
                catalogueExample:@" public class Test {\n   public static void main(String args[]) {\n     for(int x = 10; x < 20; x = x+1) {\n        System.out.print(\"value of x : \" + x );\n       System.out.print(\"\\n\");\n     }\n   }\n }" catalogueID:6 cataloguePLID:2];
            [self.dataWorker insertCatalogueTitle:@"Java增强for 循环" catalogueClass:@"循环" catalogueUsage:@" for(声明语句 : 表达式)\n {\n   //代码句子\n }" catalogueExplain:@" Java增强for循环语法格式如上。\n 声明语句：声明新的局部变量，该变量的类型必须和数组元素的类型匹配。其作用域限定在循环语句块，其值与此时数组元素的值相等。\n 表达式：表达式是要访问的数组名，或者是返回值为数组的方法。"
                catalogueExample:@" public class Test {\n   public static void main(String args[]){\n      int [] numbers = {10, 20, 30, 40, 50};\n\n     for(int x : numbers ){\n       System.out.print( x );\n       System.out.print(\",\");\n     }\n     System.out.print(\"\\n\");\n     String [] names ={\"James\", \"Larry\", \"Tom\", \"Lacy\"};\n     for( String name : names ) {\n       System.out.print( name );\n       System.out.print(\",\");\n     }\n   }\n }" catalogueID:7 cataloguePLID:2];
            [self.dataWorker insertCatalogueTitle:@"声明数组" catalogueClass:@"数组" catalogueUsage:@" dataType[] arrayRefVar;   // 首选的方法\n //或\n dataType arrayRefVar[];  // 效果相同，但不是首选方法" catalogueExplain:@" 上面是声明数组变量的语法。\n 首先必须声明数组变量，才能在程序中使用数组。\n 注意: 建议使用dataType[] arrayRefVar 的声明风格声明数组变量。 dataType arrayRefVar[] 风格是来自 C/C++ 语言 ，在Java中采用是为了让 C/C++ 程序员能够快速理解java语言。" catalogueExample:@" double[] myList;\n double myList[]; " catalogueID:8 cataloguePLID:2];
            [self.dataWorker insertCatalogueTitle:@"创建数组" catalogueClass:@"数组" catalogueUsage:@" arrayRefVar = new dataType[arraySize];\n //数组变量的声明，和创建数组可以用一条语句完成，如下所示：\n dataType[] arrayRefVar = new dataType[arraySize];" catalogueExplain:@" 下面的语句首先声明了一个数组变量myList，接着创建了一个包含10个double类型元素的数组，并且把它的引用赋值给myList变量。" catalogueExample:@" double[] myList = new double[10];" catalogueID:9 cataloguePLID:2];
            [self.dataWorker insertCatalogueTitle:@"处理数组" catalogueClass:@"数组" catalogueUsage:@"" catalogueExplain:@" 数组的元素类型和数组的大小都是确定的，所以当处理数组元素时候，我们通常使用基本循环或者foreach循环。\n 该实例完整地展示了如何创建、初始化和操纵数组：" catalogueExample:@" public class TestArray {\n   public static void main(String[] args) {\n     double[] myList = {1.9, 2.9, 3.4, 3.5};\n\n     // 打印所有数组元素\n     for (int i = 0; i < myList.length; i++) {\n       System.out.println(myList[i] + \" \");     }\n     // 计算所有元素的总和\n     double total = 0;\n     for (int i = 0; i < myList.length; i++) {\n       total += myList[i];\n     }\n     System.out.println(\"Total is \" + total);\n     // 查找最大元素\n     double max = myList[0];\n     for (int i = 1; i < myList.length; i++) {\n       if (myList[i] > max) max = myList[i];\n     }\n     System.out.println(\"Max is \" + max);\n   }\n }"
                catalogueID:10 cataloguePLID:2];
//            [self.dataWorker insertCatalogueTitle:@"" catalogueClass:@"" catalogueUsage:@"" catalogueExplain:@"" catalogueExample:@"" catalogueID:11 cataloguePLID:2];
//            [self.dataWorker insertCatalogueTitle:@"" catalogueClass:@"" catalogueUsage:@"" catalogueExplain:@"" catalogueExample:@"" catalogueID:12 cataloguePLID:2];
//            [self.dataWorker insertCatalogueTitle:@"" catalogueClass:@"" catalogueUsage:@"" catalogueExplain:@"" catalogueExample:@"" catalogueID:13 cataloguePLID:2];
//            [self.dataWorker insertCatalogueTitle:@"" catalogueClass:@"" catalogueUsage:@"" catalogueExplain:@"" catalogueExample:@"" catalogueID:14 cataloguePLID:2];
            
            NSArray *arr1=[NSArray arrayWithObjects:@"C",@"C++",@"JAVA",@"C#",@"JavaScript",@"PHP",@"Ruby",@"Python", nil];
            for (int i=0; i<8; i++) {
                [self.dataWorker insertPLTitle:[arr1 objectAtIndex:i] andPLID:i];
            }
            [self initializePlat];
        }else
        {
            [self initializePlat];
            NSLog(@"not first");
        }
    }else{
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        NSLog(@"UserData Cleared");
    }
    
    BOOL first=[[NSUserDefaults standardUserDefaults]boolForKey:@"first"];
    if (first==NO) {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"first"];
        TipViewController *appStartController = [[TipViewController alloc] init];
        self.window.rootViewController=appStartController;
        [appStartController release];
    }else{
        MainViewController *MainVC=(MainViewController *)[MainViewController shareMainViewController];
        self.window.rootViewController=MainVC;
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)initializePlat
{
    [UMSocialData setAppKey:@"553eeb0667e58ed991006457"];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
