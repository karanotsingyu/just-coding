% 继续玩一下格式化字符串，并且看看能不能套娃（递归）
% [将数据格式化为字符串或字符向量](https://ww2.mathworks.cn/help/matlab/ref/sprintf.html)

formatter = "%d %d %d %d";

a1 = 'a1';
a2 = 'a2';
a3 = 'a3';
a4 = 'a4';

sprintf(formatter, a1, a2, a3, a4)
% sprintf(formatter, "a1", "a2", "a3", "a4")
% 难道说这只支持数值类型？菜鸡？？？

formatter = '%d %d %d %d';
sprintf(formatter, a1, a2, a3, a4)

% 额，没区别

% 不支持字符串的话就模仿不了ex08了，哼

a1 = pi;
formatter2 = '%.2f %d %5.10f %.2g % .2f %-.2f';
% 至少弄明白了.xf代表x位小数；g则是有效位数
sprintf(formatter2, a1, a1, a1, a1, a1, a1)

% 哦，%d意味着这里只能塞整数

formatter3 = '{%s %s %s %s}';
sprintf(formatter3, "a1", "a2", "a3", "a4")
sprintf(formatter3, a1, a2, a3, a4)

% 原始设想好像还是可以实现的，我再玩玩：

sprintf(formatter3, formatter3, formatter3, formatter3, formatter3)

sprintf(formatter3, "Try you", "Own text here", "Maybe a poem", "Or a song about fear")

% % 要以字符串形式返回格式化文本，请在调用 sprintf 函数时将 formatSpec 指定为字符串而不是字符向量。
% % 从 R2017a 开始，您可以使用双引号创建字符串。转换数据并以字符串的形式返回结果。

% MATLAB真是个憨憨，又字符串又字符向量真是让人无语