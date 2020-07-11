%% Randomly choose a student who is still existing in the temporary student list

% Get the number of "current" students
student_roll_size = size(student_roll);
student_num = student_roll_size(1);
% Randomly pick an index from 1 to student_num(include it)
index_extracted = randi(student_num);
% Use this index to extract certain student info from the temporary student
% list data
student_picked = student_roll(index_extracted,:);
% Delete certain student info in the temporary student list data, in case
% he/she is picked again
student_roll(index_extracted,:) = [];
% Defensive debugging
disp(student_picked)

%% Get the student attendence info

% Pop an intput dialogue box for entering the info
student_attendance = inputdlg("Attendence（0 - no; 1 - yes）", student_picked{2});

%% Output the data into a file

% Date as the first column
output_info{1,1} = date;
% Student's info as the second and third columns
output_info{1,2} = student_picked{1,1};
output_info{1,3} = student_picked{1,2};
% Attendence info as the fourth colunm
output_info{1,4} = student_attendance{1};
% Defensive debugging
disp("Successfully get the attendence info of this student.")
% Number of people being picked added by 1
picked_num = picked_num + 1;
% Set the position where the data write in the Excel table
position_write = ['A' num2str(picked_num)];
% Write the data this round into the Excel table
writecell(output_info, 'students_attendance.xls', 'Sheet', 'sheet1', 'Range', position_write);
% Defensive debugging
disp("Successfully outputing data.")