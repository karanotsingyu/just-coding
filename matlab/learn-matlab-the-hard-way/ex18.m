% 学习自定义函数的语法 function

% van了，matlab里的function就是数学function，跟py里的method区别很大

% 不对诶，还是可以的

% 创建函数 函数名为myFunction 输入为变量year
year = input('输入你的出生年份：');
myFunction(year)

% 如何才能用input输入文字捏？哦，好麻烦，要用参数来控制
% MATLAB菜鸡！没商量！除去专业的数学运算部分，一般的程序设计能力比Python菜很多
% 如果想对付一般情况，默认用's'会好一些
arg1 = input('输入第一个参数：', 's');
arg2 = input('输入第二个参数：', 's');
print_two(arg1, arg2)

% matlab里function必须放在结尾，也是很神奇，不知道这些代码到底怎么运作的
function myFunction(year)
    if year>2020
        disp('蛤？你在干什么？')
    else
        disp(['哟，你大概是' num2str(2020-year) '岁'])
    end
end

function print_two(arg1, arg2)
% 函数里不用缩进 控制语句才需要
disp([arg1, arg2])
end