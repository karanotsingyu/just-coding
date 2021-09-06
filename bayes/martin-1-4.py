import numpy as np
import seaborn as sns
from scipy import stats
import matplotlib.pyplot as plt

def naive_hpd(post):
    # plot univariate or bivariate distributions using kernel density estimation (KDE)
    # https://seaborn.pydata.org/generated/seaborn.kdeplot.html
    sns.kdeplot(post)
    # get the 2.5th and 97.5th percentile
    # https://numpy.org/doc/stable/reference/generated/numpy.percentile.html
    HPD = np.percentile(post, [2.5, 97.5])
    # unpack the array "HPD" as arguments
    # https://docs.python.org/dev/reference/expressions.html#calls
    plt.plot(HPD, [0, 0], label='HPD [{:.2f} {:.2f}]'.format(*HPD), 
      linewidth=8, color='k')
    plt.legend(fontsize=16);
    plt.xlabel(r"$\theta$", fontsize=14)
    plt.gca().axes.get_yaxis().set_ticks([])

np.random.seed(1)
# https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.rv_continuous.rvs.html
# https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.beta.html
# generate 1000 random variables
post = stats.beta.rvs(5, 11, size=1000)
naive_hpd(post)
plt.xlim(0, 1)
plt.show()

# multinomial distribution cases are little harder... pls refer to the source code