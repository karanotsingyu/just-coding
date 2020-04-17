%% 作业：点名小程序
% 将这个班所有学生的学号，姓名，存储在文件里（2列，n行），制作一个点名小程序。
% 功能：随机点名，点名后呈现姓名和学号；
% 点名后弹出输入框，在输入框输入出勤情况（1-出勤，0-缺勤）；
% 将当日考勤情况（日期、姓名、学号、出勤）记录在文件attendance.txt里。

%% 获取学生信息

load('student_data')

% 生成用于抽取学号的向量
student_id = student_data(:,1);
% 生成存储点名信息的空矩阵
vector_size = size(student_id);
attendence = [student_data, NaN(vector_size(1), 1)];

fprintf("学生名单已加载完毕。\n输入 pick_name 以进行一次点名：\n")