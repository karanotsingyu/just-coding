% 学习进行数学运算，并输出运算结果

% [初等数学](https://ww2.mathworks.cn/help/matlab/elementary-math.html)

%% [算术运算](https://ww2.mathworks.cn/help/matlab/arithmetic.html)

disp("加法：1 + 1 = ")
% 直接打变量名和直接赋值也可直接打印变量，而无需disp()
a = 1 + 1

% 想同时打印多个变量的话，要把它们丢进一个矩阵里
% 比如
X = ["加法：1 + 1 = ", 1 + 1]
X
% 亦或
["另一个加法：2 + 3 = ", 2 + 3]
% 当然，不赋给变量的习惯肯定不好的，尽管MATLAB里有ans值（最新一次运算的结果）

% 简单的减法、乘法、除法就略去
% MATLAB数组里空格也可划分元素，有无逗号都可
["幂：2的3次幂 = " 2.^3]

% 模除法
["6除以4取余数 相当于Python的6%4" mod(6,4)]