# Learning trajectories:
# Martin, O. (2016). Bayesian analysis with python. Packt Publishing Ltd.
# Martin, O. (2018). Python贝叶斯分析. https://book.douban.com/subject/30165551/
# -----------------------------------

import numpy as np
import scipy.stats as stats
import matplotlib.pyplot as plt

##### 1.3 single parameter inference

#### 1.3.1

# ### choose the likelihood func
#
# """which is p(y|theta), probability of *y* times success given the 
# parameter of distribution (bias of the coin) is *theta*"""
#
# ## generate 9 binomial distributions
#
# # param n of binomial distribution
# n_params = [1, 2, 4]
# # param p of binomial distribution
# p_params = [0.25, 0.5, 0.75]
# # at most flip 5 times
# x = np.arange(0, max(n_params) + 1)
#
# # https://matplotlib.org/stable/api/_as_gen/matplotlib.pyplot.subplots.html
# f, ax = plt.subplots(len(n_params), len(p_params), sharex=True, sharey=True)
#
# # generate plots one by one
# for i in range(3):
#     for j in range(3):
#         n = n_params[i]
#         p = p_params[j]
#         # generate a sequence of y based on x
#         y = stats.binom(n=n, p=p).pmf(x)
#         # specify the plot: vertical lines at each x from ymin to ymax
#         # https://matplotlib.org/stable/api/_as_gen/matplotlib.pyplot.vlines.html
#         # https://matplotlib.org/stable/api/_as_gen/matplotlib.axes.Axes.vlines.html
#         ax[i,j].vlines(x, 0, y, colors='b', lw=5) # lw refers to linewidth
#         ax[i,j].set_ylim(0, 1)
#         # label of the subplots
#         # https://docs.python.org/3/library/string.html#formatspec
#         label = "n = {:3.2f}\np = {:3.2f}".format(n, p)
#         # plot according to specification
#         ax[i,j].plot(0, 0, label=label, alpha=0) # opache
#         ax[i,j].legend(fontsize=12)
# ax[2,1].set_xlabel('$\\theta$', fontsize=14)
# ax[1,0].set_ylabel('$p(y|\\theta)$', fontsize=14)
# ax[0,0].set_xticks(x)
#
# plt.show()
#
# ### choose the prior
#
# params = [0.5, 1, 2, 3]
# x = np.linspace(0, 1, 100)
# f, ax = plt.subplots(len(params), len(params), sharex=True, sharey=True)
# for i in range(4):
#     for j in range(4):
#         a = params[i]
#         b = params[j]
#         y = stats.beta(a, b).pdf(x)
#         ax[i,j].plot(x, y)
#         ax[i,j].plot(0, 0,
#             label="$\\alpha$ = {:3.2f}\n$\\beta$ = {:3.2f}".format(a,b),
#             alpha=0)
#         ax[i,j].legend(fontsize=12)
# ax[3,1].set_xlabel('$\\theta$', fontsize=14)
# ax[0,0].set_ylabel('$p(\\theta)$', fontsize=14)

### compute the posterior

## which is p(theta|y)

# for comparison
theta_real = 0.35

# numbers of trials, namely, parameter *N*
trials = [0, 1, 2, 3, 4, 8, 16, 32, 50, 150]
# numbers of success trials (heads), namely, data *y*
data = [0, 1, 1, 1, 1, 4, 6, 9, 13, 48]

beta_params = [(1, 1), (0.5, 0.5), (20, 20)]
# specify the var "dist" as a stats.beta object, i.e. a beta distribution
dist = stats.beta
# np array, 0 to 1, 100 even steps
x = np.linspace(0, 1, 100)

# https://docs.python.org/3/library/functions.html?highlight=enumerate#enumerate
# e.g. the first idx and N are 0 and 0
# e.g. and the last(10th) idx and N are 9 and 150
for idx, N in enumerate(trials):
    if idx == 0:
        # 4*3=12 subplots in total, though start at 2nd subplot 
        plt.subplot(4, 3, 2)
    else:
        # same logic as above, skipped the 3rd subplot
        # thus, the 1rd and 3rd subplots are empty
        plt.subplot(4, 3, idx+3)
    # get the *y* value according to index
    y = data[idx]
    # "c" refers to "color"
    # https://docs.python.org/3/library/functions.html#zip
    # e.g. the first (a_prior, b_prior) is (1, 1), 
    # whose distribution is represented as blue one.
    # e.g. prior (0.5, 0.5) for red and (20, 20) for green
    for (a_prior, b_prior), c in zip(beta_params, ('b', 'r', 'g')):
        # posterior is obtained through direct calculation of the probability terms
        p_theta_given_y = dist.pdf(x, a_prior + y, b_prior + N - y)
        plt.plot(x, p_theta_given_y, c)
        plt.fill_between(x, 0, p_theta_given_y, color=c, alpha=0.6)
    
    # plot a vertical line
    plt.axvline(theta_real, ymax=0.3, color='k')
    plt.plot(0, 0, 
        label="{:d} experiments\n{:d} heads".format(N, y), 
        alpha=0)
    plt.xlim(0, 1)
    plt.ylim(0, 12)
    plt.xlabel(r"$\theta$")
    plt.legend()
    # get the current Axes, make the y axis invisible
    # https://matplotlib.org/stable/api/_as_gen/matplotlib.pyplot.gca.html?highlight=gca#matplotlib.pyplot.gca
    # https://matplotlib.org/stable/api/_as_gen/matplotlib.axes.Axes.get_yaxis.html
    plt.gca().axes.get_yaxis().set_visible(False)
# https://matplotlib.org/stable/api/_as_gen/matplotlib.pyplot.tight_layout.html
plt.tight_layout()
# plt.savefig('test.png', dpi=300, figsize=(5.5, 5.5))

plt.show()