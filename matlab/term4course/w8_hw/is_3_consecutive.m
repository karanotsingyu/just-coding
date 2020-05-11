%% 各种造轮子

% 检查 3 个相邻元素是否重复
% 输入必须为长度为 3 的向量
function bool = is_3_consecutive(vector)
    if vector(3) == vector(2) == vector(1)
        bool = true;
    else
        bool = false;
    end
end