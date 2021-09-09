# Learning trajectories:
# Martin, O. (2016). Bayesian analysis with python. Packt Publishing Ltd.
# Martin, O. (2018). Python贝叶斯分析. https://book.douban.com/subject/30165551/
# -----------------------------------

import pymc3 as pm
import numpy as np
import scipy.stats as stats
import matplotlib.pyplot as plt
import seaborn as sns
import arviz as az

az.style.use('arviz-darkgrid')

#### 2.1 用计算的方法解决抛硬币问题

np.random.seed(123)
# try for 4 times
n_experiments = 4
# unkwon value in a real experiment
theta_real = 0.35
# flip the coin with bias p=0.35 for size=4 times
data = stats.bernoulli.rvs(p=theta_real, size=n_experiments)
# print("data: ", data)

### 模型描述

# ?
# https://www.geeksforgeeks.org/with-statement-in-python/
with pm.Model() as our_first_model:
    # Specify the Beta prior
    # https://docs.pymc.io/api/distributions/continuous.html#pymc3.distributions.continuous.Beta
    # the second theta is an argument(name) of Beta, and it's a good 
    # habit to keep the name same as the variable
    θ = pm.Beta('θ', alpha=1, beta=1)
    # Specify the Bernoulli->Binomial likelihood
    # https://docs.pymc.io/api/distributions/discrete.html#pymc3.distributions.discrete.Bernoulli
    y = pm.Bernoulli('y', p=θ, observed=data)
    # ### 按下推断按钮
    # # ?
    # start = pm.find_MAP()
    # # ?
    # # https://docs.pymc.io/api/inference.html#pymc3.step_methods.metropolis.Metropolis
    # step = pm.Metropolis()
    # Push the inference button
    # https://docs.pymc.io/api/inference.html#pymc3.sampling.sample
    # https://github.com/pymc-devs/pymc3/issues/4089
    # https://discourse.pymc.io/t/updated-solution-to-brokenpipeerror-errno-32-broken-pipe/4832
    # trace = pm.sample(1000, step=step, start=start, chains=1, cores=1)
    # ask for 1000 samples from the posterior and store them in the
    # "trace" object
    trace = pm.sample(1000, cores=1, random_seed=123)

#### 2.3 Summarizing the posterior

# az.plot_trace(trace)
# plt.show()

### ROPE

print(az.summary(trace))
# az.plot_posterior(trace, rope=[0.45, 0.55])
# az.plot_posterior(trace, ref_val=0.5)
# plt.show()

### Loss functions

grid = np.linspace(0, 1, 200)
print("trace: ", trace)
θ_pos = trace['θ']
lossf_a = [np.mean(abs(i - θ_pos)) for i in grid]
# LMS
lossf_b = [np.mean((i - θ_pos)**2) for i in grid]

for lossf, c in zip([lossf_a, lossf_b], ['C0', 'C1']):
    mini = np.argmin(lossf)
    # curve
    plt.plot(grid, lossf, c)
    # dot annotate
    plt.plot(grid[mini], lossf[mini], 'o', color=c)
    # text annotate
    # https://matplotlib.org/stable/api/_as_gen/matplotlib.pyplot.annotate.html
    plt.annotate('{:.2f}'.format(grid[mini]),
                 (grid[mini], lossf[mini] + 0.03), 
                 color=c)
    plt.yticks([])
    plt.xlabel(r'$\hat \theta$')

plt.show()

lossf = []
for i in grid:
    if i < 0.5:
        f = np.mean(np.pi * θ_pos / np.abs(i - θ_pos))
    else:
        f = np.mean(1 / (i - θ_pos))
    lossf.append(f)

mini = np.argmin(lossf)
plt.plot(grid, lossf)
plt.plot(grid[mini], lossf[mini], 'o')
plt.annotate('{:.2f}'.format(grid[mini]),
             (grid[mini] + 0.01, lossf[mini] + 0.1))
plt.yticks([])
plt.xlabel(r'$\hat \theta$')
plt.show()