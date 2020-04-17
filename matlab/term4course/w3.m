% 10个性格形容词，其中5个正性，5个负性，每次呈现1个形容词，要求被试判断该形容词的词性。
% 作业要求：
% 1.生成这10个形容词的单元数组，要求第一行为刺激编号，第二行为形容词
% 2.模拟一批原始实验数据，被试数为5，trial数为10，记录反应时RT和准确率ACC。
% 3.由于第3名被试实验态度不端正，导致数据无法使用，删除该被试的数据。并新增一名被试（被试编号为6）的实验数据.
% 4.生成包含实验刺激（……= =）、实验数据、被试编码以及主试姓名的结构数组
% 5.调出实验数据

%% 生成形容词cell
Vocabulary = {1 2 3 4 5 6 7 8 9 10; "外向" "内向" "开放" "保守" "正直" "虚伪" "乐观" "悲观" "勇敢" "懦弱"};

%% 生成模拟实验数据的数组
% 创建三维零数组
SimuData = zeros(2,10,5);

ID = 1:5;

for x = ID
    for y = 1:10
        % μ = 500，σ = 50 的正态分布中抽取一个数值赋给变量RT  
        RT = 500 + round(50 * randn);
        % 取随机的0或1赋给变量ACC
        ACC = round(rand);
        % 生成此subject此trial的模拟数据
        SimuData(:,y,x) = [RT, ACC];
    Subject(x).ID = x;
    Subject(x).Experimenter = "假装有主试姓名";
    Subject(x).Data = SimuData(:,:,x);
    end
end

%% 删除被试3数据

Subject(3) = [];

%% 增加被试6数据
Subject(6).ID = 6;
Subject(6).Experimenter = "假装有主试姓名";
Subject(6).Data = zeros(2,10);
for y = 1:10
    RT = 500 + round(50 * randn);
    ACC = round(rand);
    Subject(6).Data(:,y) = [RT, ACC];
end

%% 怎样调出就随便了，看对方或自己具体需要怎样的API