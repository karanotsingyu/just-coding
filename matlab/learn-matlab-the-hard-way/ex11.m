% 让用户输入内容，赋给变量
% 搞不了end=''的，见ex07的说明

disp("How old are you?")
age = input("> ");
% MATLAB跟Python不一样的地方是前者的input不一定必定接收为字符串，比如age这里是double
% 可以这样来规定age为char
age = input("> ", 's');

disp("How tall are you?")
height = input("> ");
prompt = "How much do you weight?";
disp(prompt)
weight = input("> ");

% 还要控制格式，也是hin烦的
fprintf("So, you're %s old, %.0f tall and %.0f heavy.", age, height, weight)
% 两段话就粘在一起了诶
fprintf("Just type something.")