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

% 本节就简单探索一下字符串的简单玩法。

%% [字符和字符串](https://ww2.mathworks.cn/help/matlab/characters-and-strings.html)

str = "Hello, world" % 创建字符串（在MATLAB里又叫字符数组或字符向量）

str = ["Mercury","Gemini","Apollo";
       "Skylab","Skylab B","ISS"] % 创建字符串数组

A = [1 1 1 1 1]

% 将原数组转化为字符串数组
string(A)

% 创建空的3*3字符串数组
strings(3)
% 创建空的2*3*4字符串数组
strings(2, 3, 4)

% 创建3阶单位矩阵并转换为字符串数组
I = string(eye(3))
% 把字符串数组的每个元素拼接起来
newM = join(I)
% 如你所见，一次只降一维
% 继续拼接
newM = join(newM)

% 可以通过第二个参数设置分隔符
newM = join(I, "分隔符")

textA = 'a'
textB = 'b'
textA + textB
% 两个加起来等于195是什么意思？？？什么鬼

% MATLAB似乎没有f-string或.format()……
% 乱搜了一下，格式化倒是有，但是没有f-string或.format()那样那么灵活好用的东西
% [将数据格式化为字符串或字符向量 - MATLAB sprintf - MathWorks 中国](https://ww2.mathworks.cn/help/matlab/ref/sprintf.html)
% 噢，我找到了

formatSpecification = 'The array is %d * %d'
A1 = 1
A2 = 3
% 跟Py中的str.format()就是一回事了，%d相当于{}
sprintf(formatSpecification, A1, A2)

% 格式设置什么的以后有兴趣或者有需要再折腾吧╮(╯_╰)╭