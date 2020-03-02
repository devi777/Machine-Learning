dataset = read.csv('Ads_CTR_Optimisation.csv')

#Implementing UCB
#theta i is the prob of success
N = 10000
d = 10
ads_selected = integer(0)
no_0 = integer(d)
no_1 = integer(d)
total_reward = 0
for (n in 1:N) {
  ad = 0
  max_random = 0
  for (i in 1:d) {
    random_beta = rbeta(n=1,
                        shape1 = no_1[i] + 1, 
                        shape2 = no_0[i] + 1)
    if (random_beta > max_random) {
      max_random = random_beta
      ad = i
    }
  }
  ads_selected = append(ads_selected, ad)
  reward = dataset[n,ad]
  total_reward = total_reward + reward
  if (reward==1) {
    no_1[ad] = no_1[ad] + 1 
  } else {
    no_0[ad] = no_0[ad] + 1 
  }
}

#> options(max.print = 10000)
#> ads_selected

hist(ads_selected,
     col = 'blue',
     main = 'Histogram of ads selections',
     xlab = 'Ads',
     ylab = 'Number of times each ad was selected')