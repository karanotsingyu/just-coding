%% 作业：点名小程序
% 将这个班所有学生的学号，姓名，存储在文件里（2列，n行），制作一个点名小程序。
% 功能：随机点名，点名后呈现姓名和学号；
% 点名后弹出输入框，在输入框输入出勤情况（1-出勤，0-缺勤）；
% 将当日考勤情况（日期、姓名、学号、出勤）记录在文件attendance.txt里。

%% 建立班级学生信息

% n行2列
student_id = string(1:10).';
student_name = ["张一", "张二", "张三", "张四", "张五", "张六", "张七", "张八", "张九", "张十"].';

student_data = [student_id, student_name];
clearvars student_id student_name

save('student_data.mat');