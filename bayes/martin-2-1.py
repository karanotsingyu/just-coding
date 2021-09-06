# Learning trajectories:
# Martin, O. (2016). Bayesian analysis with python. Packt Publishing Ltd.
# Martin, O. (2018). Python贝叶斯分析. https://book.douban.com/subject/30165551/
# -----------------------------------

import pymc3 as pm
import numpy as np
import scipy.stats as stats
import matplotlib.pyplot as plt
import seaborn as sns

palette = 'muted'
sns.set_palette(palette)
sns.set_color_codes(palette)

#### 2.1.1 推断引擎

### Metropolis-Hasting 算法

def metropolis(func, steps=10000):
    """A very simple Metropolis implementation"""
    # zero vector of default 10000 elements
    # https://numpy.org/doc/stable/reference/generated/numpy.zeros.html
    samples = np.zeros(steps)
    print("initial samples: ", samples, "of shape", samples.shape)
    # mean of the "func" distribution
    # https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.beta.html
    # validate: mean=a/(a+b)=0.4/(0.4+2)=0.16666667
    old_x = func.mean()
    print("initial old_x: ", old_x)
    # probability density according to mean
    old_prob = func.pdf(old_x)
    print("initial old_prob: ", old_prob)
    # 上面这样一个初始化和下面的类似的迭代是干啥用的？@卡片
    # 为什么用均值作为初始的参数值？ TODO

    for i in range(steps):
        # 从标准正态分布中随机抽一个值加给原先的采样参数x（这里可以看做随机漫步）
        # https://numpy.org/doc/stable/reference/random/generated/numpy.random.normal.html
        new_x = old_x + np.random.normal(0, 1)
        # 根据新的x计算出新的概率密度
        new_prob = func.pdf(new_x)
        ## Metropolis准则
        # 接受概率——新旧概率比值——什么意思？？TODO 过拟合了，得参考其它贝叶斯书了
        acceptance = new_prob / old_prob
        # 如果这个比值大于标准均匀分布（0到1）中抽出的随机值
        if acceptance >= np.random.random():
            # 这个新的x值就作为本轮的采样点，记录下来（塞入矩阵/向量“samples”中）
            samples[i] = new_x
            # 该x值成为下一轮采样的旧x值
            old_x = new_x
            # 同上，同理
            old_prob = new_prob
        else:
            # 否则采样值用旧的点，抽样后验亦不变
            samples[i] = old_x
    # # visualizational comprehension
    # print("samples: ", samples)
    # plt.plot(range(len(samples)), samples)
    # plt.show()
    
    return samples

np.random.seed(345)
# denote "func" as beta distribution with params a=0.4, b=2
func = stats.beta(0.4, 2)
# ?
samples = metropolis(func=func)

# plotting
x = np.linspace(0.01, .99, 100)
y = func.pdf(x)
plt.xlim(0, 1)
plt.plot(x, y, 'r-', lw=3, label='True distribution')
plt.hist(samples, density=True, bins=30, label='Estimated distribution')
plt.xlabel('$x$', fontsize=14)
plt.ylabel('$pdf(x)$', fontsize=14)
plt.legend(fontsize=14)
# plt.show()