%% 作业：点名小程序
% 将这个班所有学生的学号，姓名，存储在文件里（2列，n行），制作一个点名小程序。
% 功能：随机点名，点名后呈现姓名和学号；
% 点名后弹出输入框，在输入框输入出勤情况（1-出勤，0-缺勤）；
% 将当日考勤情况（日期、姓名、学号、出勤）记录在文件attendance.txt里。

%% 随机点名

% 获取学生数量
student_roll_size = size(student_roll);
student_num = student_roll_size(1);
% 从 1 到 student_num 之间（包括 student_num）随机抽取一个索引值
index_extracted = randi(student_num);
% 用这个索引值从矩阵中相应位置调出学生数据
student_picked = student_roll(index_extracted,:);
% 将学生从临时名单中划去
student_roll(index_extracted,:) = [];
% Defensive debugging
disp(student_picked)

%% 弹出输入框并获取用户输入（学生的出勤情况）

% 输入框中显示文字"该学生的出勤情况（0-未出勤；1-出勤）"以及学生姓名
student_attendance = inputdlg("该学生的出勤情况（0-未出勤；1-出勤）", student_picked{2});

%% 将学生的出勤情况导出至存储出勤情况的 TXT? 文档中

% 点名日期作为第一列
output_info{1,1} = date; % date 是内置常量
% 学生信息作为第二列
output_info{1,2} = student_picked{1,1};
% 和第三列
output_info{1,3} = student_picked{1,2};
% 点名情况作为第四列
output_info{1,4} = student_attendance{1};
% Defensive debugging
disp("成功生成该学生的出勤情况。")
% 点名人数+1
picked_num = picked_num + 1;
% 设定写入表格中的位置，通过 picked_num 的变化达成追加写的效果
position_write = ['A' num2str(picked_num)]; % 写入 Ax 单元格
% 将此数据写入至文档中
writecell(output_info, 'students_attendance.xls', 'Sheet', 'sheet1', 'Range', position_write);
% Defensive debugging
disp("成功将该学生的出勤情况写入目标文档.")