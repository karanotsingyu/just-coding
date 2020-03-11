% 学习让字符串换行

days = "Mon Tue Wed Thu Fri Sat Sun";
disp(days)
% 跟Python一样也是\n
months = "Jan\nFeb\nMar\nApr\nMay\nJun\nJul\nAug";
sprintf(months)

t1 = 'There is something going on here.\n';
t2 = 'With the three double-quotes -- Nope!\n';
t3 = 'We will be able to type as much as we like.\n';
t4 = 'Even 4 lines if we want, or 5, or 6.\n';
t5 = 'Nope, it''s boring.'; % 使用''来打印单引号

disp([t1 t2 t3 t4 t5])
fprintf([t1 t2 t3 t4 t5])

t6 = '\f甚至可以换页嗷\f'; % 呜……文档你骗我，所以你说的"换页"是什么意思昂？？
fprintf(['\n' t1 t2 t3 t4 t5 t6 '%%'])
% 用%%打印百分比符号
% 反斜杠则是\\，这个也跟Py一样