%% T1:
%   长方体的长宽高分别为123.06，88.48，98.7，请计算该长方体的体积。

a = 123.06;
b = 88.48;
c = 98.7;

v = a * b * c;
disp(['第1题结果'])
% 为什么用round除了不设第二位参数的时候，都显示那么长一串玩意儿？
% 不知道为什么默认就显示5位有效数字，可为什么round除非取整，否则约到一两位小数也改变不了？
disp(v)
disp(round(v,2))
disp(round(v))

%% T2:
%   1. 定义一个元胞数组myCell，包含一个浮点型数据，一个字符型数据，
%      一个结构体数组，一个逻辑型数据。
%   2. 索引myCell中的第2个元素的值。

% [数据类型](https://ww2.mathworks.cn/help/matlab/data-types.html)

% 可使用{}或cell()来创建，以下使用两种方法来达成目的

% 【方法1】cell()

% 来观察一下不同：
% 4阶方阵
myCellA = cell(4)
% 4行1列
myCellA = cell(4,1)
% 1行2列，3个样本
% md，轴的顺序跟NumPy完全相反，这里是由内向外，而Python是由外向内
% 三维数组的话，可以想一想3维直角坐标系，第1个轴对应x轴，随后依次是y轴和z轴
myCellA = cell(1,2,3)
% 1行4列
myCellA = cell(1,4)

% 单精度数组（这里的数组就是浮点数）
myCellA{1,1} = single(10);
whos myCellA(1,1) % 无效，因为MATLAB不像Python那样是面向对象型语言
% 只能这样
whos myCellA
% 或者直接赋数值，默认为双精度（8bit，64位）数组
% 注意，这里赋值要用花括号（是所有数组都这样，还是只是元胞数组？有待确认）
myCellA{1,1} = 10;
disp(myCellA)

myCellA{1,2} = 'this is str';
disp(myCellA)

myCellA{1,4} = true;
disp(myCellA)

% 创建结构体数组，语法同Python里的对象及其属性，别混淆了嗷
patient(1).name = 'John Doe';
patient(1).billing = 127.00;
patient(1).test = [79, 75, 73; 180, 178, 177.5; 220, 210, 205];
% MATLAB里居然可以用括号来作为变量名，哼，自找麻烦
patient(1)
myCellA{1,3} = patient(1);
disp(myCellA)

% 【方法2-1】使用{}
% 从一个空数组开始，重复上述操作

disp('\n重来嗷\n')

myCellA = {}
myCellA{1,1} = 10;
myCellA{1,2} = 'this is str';
myCellA{1,3} = patient(1);
myCellA{1,4} = true;

myCellA

% 【方法2-2】使用{}
% 一口气创建

myCell = {10, 'this is str', patient(1), true}


%% T3:
%   A = [1 2; 3 4];
%   B = [2 1; 3 3];
%   写出A ≤ B的结果。

% [1 0; 1 0]

% 验证一下：

disp('第3题结果')

A = [1 2; 3 4];
B = [2 1; 3 3];

disp(A <= B)

%　できた！