% 练一练乱七八糟的东西。

% 回顾一下fprintf()

text = "我\n裂\n开\n了\n";

fprintf(text)

% 等于Python中的type()
class(text)

% 创建脚本文件ex11.m
% 如果文件已存在，则直接打开，否则提示是否创建一个
edit ex11

% 生成5阶幻方矩阵 可幻方矩阵是什么玩意儿
magic(5)