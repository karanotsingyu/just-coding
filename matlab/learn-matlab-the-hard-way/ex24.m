% practice everything

disp('Let''s practice everything.')
fprintf('You''d need to know ''bout escapes with \\ that do:')
fprintf('\n newlines and \t tabs.')

poem = ['\t The lovely world\n' ...
    'with logic so firmly planted\n' ...
    'cannot discern \n the needs of love\n' ...
    'nor comprehend passion from intuition\n' ...
    '\n\t\twhere there is none.\n'];

fprintf("\n--------\n")
fprintf(poem)
fprintf("\n--------\n")

five = 10 - 2 + 3 - 6;
fprintf("This should be five: %s\n", num2str(five))

start_point = 10000;

[beans, jars, crates] = secret_formula(start_point);

fprintf('With a starting point of: %s\n', num2str(start_point))
% 认输了。。。
fprintf('We''d have %s beans, %s jars, and %s crates.\n',num2str(beans), num2str(jars), num2str(crates))

function [jelly_beans, jars, crates] = secret_formula(started)
jelly_beans = started * 500;
jars = jelly_beans / 1000;
crates = jars / 100;
end