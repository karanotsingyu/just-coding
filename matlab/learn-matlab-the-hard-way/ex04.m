% 学习对数字四舍五入的方法
% 学习矩阵的常用食用方法

%% [算术运算](https://ww2.mathworks.cn/help/matlab/arithmetic-operators.html)

disp("四舍五入到整数")
round(0.1)
round(0.5)
round(0.6)

disp("四舍五入到两位数")
round(0.236666, 2)
round(0.333333, 2)

disp("emm hum?")
round(23333, -2)

%% [矩阵和数组](https://ww2.mathworks.cn/help/matlab/matrices-and-arrays.html)

disp("创建全零数组")

X = zeros % 返回标量0
X = zeros(5) % 返回5*5的全零矩阵
X = zeros(2,3,4) % 返回形状为2，3，4的全零矩阵
% 这里的「形状」与NumPy的类似
% 只是4为样本轴的维度就有点迷（至少打印出来的是这样的）
% 在样本轴（至少是我认为的样本轴）上，每个数组都是一个2*3矩阵

disp("创建元素全为1的数组，用法一样，略去")

% rand	均匀分布的随机数
% true	逻辑值 1（真）
% false	逻辑值 0（假）

disp("创建随机数数组、元素全为逻辑值1的数组、元素全为逻辑值0的数组")
disp("形状的定义同上")

rand(3)
true(3)
false(3)

disp("单位矩阵")

% return the scalar 1
I = eye
% 返回3阶单位矩阵
I = eye(3)

disp("对角矩阵")

% 创建向量
v = [1 2 3 4]
% 以此生成一个对角矩阵
D = diag(v)