%% 想要在MATLAB里做到类似Py里print(str, end='')的效果该怎么做捏？

% ex03里已经说啦，只能丢进数组里~
% 那么这里再来温习一下吧

A = '这里是有点点点点点点点点点点点点点点点点点点点点点长的第一行。';
B = '然后这里是有点点点点点点点点点点点点点点点点点点点长的第二行。';
C = '然后，这三行被拼了起来！';

X = [A, B, C]
disp(X)
% 支线B 为什么不能自然换行呢？后续ex中揭晓如何解决！@[创建换行符 - MATLAB newline - MathWorks 中国](https://ww2.mathworks.cn/help/matlab/ref/newline.html)
% 支线A 噫咿いいいいいいいいいいいいいいいいいいいい竟然要单引号才行！
        % 双引号的话打印出来的则是字符串数组！

%% 开启支线任务！两种字符串有什么区别呢？

% [字符串数组](https://ww2.mathworks.cn/help/matlab/ref/string.html)
% [字符数组](https://ww2.mathworks.cn/help/matlab/ref/char.html)

% 哦，双引号是string，单引号是char……服了
% 至少在这里，MATLAB好制杖

%% 猎奇时间

%C * 3 % 好吧，莫得像Python那样玩