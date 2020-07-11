% 来玩一玩文件的读写
% [支持的导入和导出文件格式 - MATLAB & Simulink - MathWorks 中国](https://ww2.mathworks.cn/help/matlab/import_export/supported-file-formats.html)

filename = 'ex15_sample.txt';
fileID = fopen(filename);

txt1 = textscan(fileID, '%c');
txt2 = textscan(fileID, '%s');

disp(txt1)
disp(txt2)

txt3 = textscan(fileID, '%c', 10);

% 好像很麻烦，乱糟糟的，先鸽在这吧……