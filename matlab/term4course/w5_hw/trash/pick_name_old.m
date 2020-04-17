%% 作业：点名小程序
% 将这个班所有学生的学号，姓名，存储在文件里（2列，n行），制作一个点名小程序。
% 功能：随机点名，点名后呈现姓名和学号；
% 点名后弹出输入框，在输入框输入出勤情况（1-出勤，0-缺勤）；
% 将当日考勤情况（日期、姓名、学号、出勤）记录在文件attendance.txt里。

%% 随机点名

% 获取向量长度
student_num = size(student_id);

% 随机抽学号
index_extracted = randi(student_num(1));
% disp("index_extracted:") % debug use
% disp(index_extracted) % debug use

% 获取学生学号
id_extracted = str2num(student_id(index_extracted));
disp(student_data(id_extracted,2))

% 工作区的原矩阵中将抽到的那个学生删除
student_id(index_extracted) = [];

%% 输入框和信息录入

% 弹出输入框
% 得到的answer是一个cell array
answer = inputdlg("该学生的出勤情况（0-未出勤；1-出勤）",student_data(id_extracted,2));
% 若answer(1)则是一个cell，必须用{}以读取cell里的东西
answer = answer{1};

% 将输入的信息输入到出勤情况的那一列
attendence(id_extracted,3) = answer;

%% 将考勤情况输出至txt里

file = fopen('attendence.txt', 'a');
fprintf(file, 'id \t name \t attendence\n');

for i = 1:vector_size(1)
    fprintf(file, char(attendence(i,1)), '\t');
    fprintf(file, char(attendence(i,2)), '\t');
    fprintf(file, char(attendence(i,3)), '\n');
end