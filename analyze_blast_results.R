library(ggplot2)

# filenames
SUS_FN <- "Sus.blastinfo.txt"
RES_FN <- "Res.blastinfo.txt"

# import data
sus.df <- read.delim(SUS_FN, header=FALSE)
res.df <- read.delim(RES_FN, header=FALSE)

# add headers
names(sus.df) <- c("gene", "genome", "indels", "shift")
names(res.df) <- c("gene", "genome", "indels", "shift")

# combine data into one data.frame
sus.df$profile <- "susceptible"
res.df$profile <- "resistant"
all.df <- rbind(sus.df, res.df)

# get unique combinations of gene, profile, and shift
genes <- c()
profs <- c()
shifs <- c()

for(gene in unique(all.df$gene)){
  for(prof in unique(all.df$profile)){
    for(shif in unique(all.df$shift)){
      genes <- c(gene, genes)
      profs <- c(prof, profs)
      shifs <- c(shif, shifs)
    }
  }
}

# create a new dataframe for these combinations to summarize
sum.df <- data.frame(gene=genes, profile=profs, shift=shifs)

# count the number of isolates for each gene, shift, and profile
for(row in 1:nrow(sum.df)){
  sum.df$count[row] <- nrow(all.df[which(all.df$gene==sum.df$gene[row] & 
                                         all.df$profile==sum.df$profile[row] &
                                         all.df$shift==sum.df$shift[row]),])
}


# calculate percentages for plotting
sum.df$percent <- NA
for(g in unique(sum.df$gene)){
  for(p in unique(sum.df$profile)){
    o.row <- with(sum.df, which(gene==g & profile==p & shift=="outF"))
    i.row <- with(sum.df, which(gene==g & profile==p & shift=="inF"))
    
    total <- sum.df$count[o.row] + sum.df$count[i.row]
    
    sum.df$percent[o.row] <- sum.df$count[o.row] / total * 100
    sum.df$percent[i.row] <- sum.df$count[i.row] / total * 100
  }
}


# generate a plot for all five genes
ggplot(sum.df, aes(x=gene, y=percent, fill=interaction(shift, profile))) +
  geom_bar(stat="identity", position=position_dodge(width=0.8), width=0.8) +
  scale_fill_manual(values=c('skyblue', 'blue', 'salmon', 'red')) +
  scale_x_discrete(expand=expansion(add=0.2)) +
  labs(y="Percent of isolates", title="All Five Porin Genes") +
  theme_minimal() +
  theme(panel.grid.major.x=element_blank())

# generate a plot for ompF only
ggplot(sum.df[which(sum.df$gene=="ompF"),], aes(x=profile, y=percent, fill=shift)) +
  geom_bar(stat='identity', position=position_dodge(width=0.8), width=0.8) +
  scale_fill_manual(values=c('skyblue', 'salmon')) +
  labs(y="Percent of isolates", title="ompF") +
  theme_minimal() +
  theme(panel.grid.major.x=element_blank())
  


# only ompF has a signal; create a square matrix for statistical testing
sq.df <- with(sum.df, data.frame(outF=count[which(shift=="outF" & gene=="ompF")],
                                 inF=count[which(shift=="inF" & gene=="ompF")]))
row.names(sq.df) <- c('resistant', 'susceptible')

# do a chi-squared test
chisq.test(sq.df)

# do a fisher's exact test
fisher.test(sq.df)
