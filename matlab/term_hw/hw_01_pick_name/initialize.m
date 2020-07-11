%% Homework 01: Roll Calling Program

% Make a roll calling mini program, according to the student ID, name of
% our class.

% Randomly pick a name and present the name and ID of the picked student.
% And then pop an input dialog box where you need type the state of
% attendence (1 - yes; 0 - no).
% Finally, output the data in a file.

% !!!CAUTION!!! Only available in version 2019a or hereafter since the script use
% functions "readmatrix()" and "writecell()" recommend by Matlab official
% site, which were updated in 2019a. (while "xlsread()" and "xlswrite()" is not
% recommanded)

%% Usage

% Makesure files initialize.m pick_name.m student_list.xls students_attendance.xls are in the same folder
% Type "initialize" first
% Then type "pick_name" to pick a student

%% Read the student ID and name list from Excel file, and generate a data list

opts = detectImportOptions('student_list.xls');
opts.SelectedVariableNames = [1:2]; 
student_roll = readmatrix('student_list.xls', opts);

%% Read the picked students data, so that subsequent pick-name process
% proceeded successfully @{pick_name.m}

students_attendance = readmatrix('students_attendance.xls');
data_size = size(students_attendance);
picked_num = data_size(1);

%% Indicating initialization completed

disp('Initilization completed.')
disp('Type "pick_name" to pick a student.')