require('dplyr')
require('ggplot2')
require('data.table')

# read in the Death records
dr <- read.csv('/Users/Steve/Downloads/DeathRecords/DeathRecords.csv')

# and manner of death
mod <- read.csv('/Users/Steve/Downloads/DeathRecords/MannerOfDeath.csv')

# join the two
inner_join(dr, mod, c('MannerOfDeath' = 'Code'))

# plot it
mod_plot <- ggplot(dr_join, aes(x=Description)) + geom_bar()

#save it
ggsave('death_by_manner.jpeg', plot=mod_plot)

# use data table for easy manipulation
dr_join_dt <- data.table(dr_join)

# filter out the outliers - come back to this problem to determine 
# what to do
dr_join_dt <- dr_join_dt[Age < 120]

# sanity check
hist(dr_join_dt$Age)

#deaths by age by manner
mod_plot <- ggplot(dr_join_dt, aes(x=Age, Fill=Description, col=Description)) + geom_bar()

#save it
ggsave('deaths_by_age_by_manner.jpeg', mod_plot)

# create descriptive stats
freq_table = count(dr_join_dt$Description)

total_deaths = nrows(dr_join_dt)

# stats by manner
freq_table$percentage = sapply(freq_table$freq, function(x) 100*x/total_deaths)

freq_table

# quick look at homicide deaths
homicide_deaths = dr_join_dt[Description=='Homicide']

# plot it
my_plot = ggplot(homicide_deaths, aes(x=Age, fill=Sex)) + geom_bar()

# save it
ggsave('homicides_byage_bySex.jpeg', my_plot)

# quick look at accident deaths
accident_deaths = dr_join_dt[Description=='Accident']

# plot it by age, by sex
my_plot = ggplot(accident_deaths, aes(x=Age, fill=Sex)) + geom_bar()


#save it
ggsave('accident_deaths_byage_bySex.jpeg', my_plot)




