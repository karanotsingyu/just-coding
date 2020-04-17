%% 作业：点名小程序

% 将这个班所有学生的学号，姓名，存储在文件里（2列，n行），制作一个点名小程序。
% 功能：随机点名，点名后呈现姓名和学号；
% 点名后弹出输入框，在输入框输入出勤情况（1-出勤，0-缺勤）；
% 将当日考勤情况（日期、姓名、学号、出勤）记录在文件attendance.txt里。

%% 使用方法

% 确保 initialize.m pick_name.m student_list.xls students_attendance.xls 位于同一文件夹中
% 先输入 initialize
% 再输入 pick_name 进行一次点名

%% 从 Excel 文档里读取学生学号姓名生成一个学生名单

% 设定：导入该文件
opts = detectImportOptions('student_list.xls');
% 设定：读取前两列数据
opts.SelectedVariableNames = [1:2]; 
% 按照设定将文件的数据导入为矩阵（元胞数组）
student_roll = readmatrix('student_list.xls', opts);

%% 其它初始化设定

students_attendance = readmatrix('students_attendance.xls');
% 获取点名记录已有的数据的 size
data_size = size(students_attendance);
% 初始化已抽取的学生人数
picked_num = data_size(1);
% 提示语
disp('初始化完毕。')
disp('输入 pick_name 进行一次点名')