% [数据类型](https://ww2.mathworks.cn/help/matlab/data-types.html)

% MATLAB的数据类型主要有：

% - 数值类型
% - 字符和字符串
% - 日期和时间
% - 分类数组
% - 表
% - 时间表
% - 结构体
% - 元胞数组
% - 函数句柄
% - 映射容器
% - 时序

% 本节就简单探索一下数值的简单玩法。

%% [数值类型](https://ww2.mathworks.cn/help/matlab/numeric-types.html)

% double	双精度数组
% single	单精度数组
% int8	8 位有符号整数数组
% int16	16 位有符号整数数组
% int32	32 位有符号整数数组
% int64	64 位有符号整数数组
% uint8	8 位无符号整数数组
% uint16	16 位无符号整数数组
% uint32	32 位无符号整数数组
% uint64	64 位无符号整数数组
% cast	将变量转换为不同的数据类型
% typecast	在不更改基础数据的情况下转换数据类型
% isinteger	确定输入是否为整数数组
% isfloat	确定输入是否为浮点数组
% isnumeric	确定输入是否为数值数组
% isreal	确定数组是否为实数数组
% isfinite	确定数组元素是否为有限值
% isinf	确定数组元素是否为无限值
% isnan	判断查询数组元素是否包含 NaN 值
% eps	浮点相对精度
% flintmax	浮点格式的最大连续整数
% Inf	创建所有值均为 Inf 的数组
% intmax	指定整数类型的最大值
% intmin	指定整数类型的最小值
% NaN	创建所有值均为 NaN 的数组
% realmax	最大的正浮点数
% realmin	最小的标准正浮点数

% 以后有兴趣或有需求再慢慢玩↑↑↑

% 判断是否为数值
A = 1
join(string([1 "是numeric吗" isnumeric(A)]))
B = 'str'; % 加了";"之后这行代码的执行结果就不会被打印出来了
disp(["is B numeric?" isnumeric(B)])
C = 1.0
isfloat(A)
isfloat(C)
disp("1和1.0都是float呢")
% 原来转化为字符串之后逻辑值会由1或0变为true或false
% 注意布尔值的字符串版本是全小写噢~

% 这里的float和默认的数值类型也和Py不同
% MATLAB这里默认是「双精度浮点数」（8bit；64位小数）