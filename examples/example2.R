library(tidyverse)

df <- data.frame(league=c(),
                 tier=c(),
                 rating = c(),
                 race = c(),
                 wins=c(),
                 losses=c(),
                 played_race_count=c(),
                 battle_tag=c(),
                 last_played=c(),
                 path=c()
                 )

for (i in 0:6) {
  #i indicates a unique league (i.e. bronze, silver, etc.)
  leagues <- league_get_league_data(44,201,0,i) #API CALL
  tiers <- length(leagues$tier)
  for (j in 1:tiers) {
    #j indiciates a tier (i.e. bronze 1, bronze 2, bronze 3, etc.)
    num_ladders <- length(leagues$tier[[j]]$division) #Number of unique divisions (i.e. ladders)
    for (k in 1:num_ladders) {
      print(paste("League:", i, "Tier:", j, "Ladder #:", k))
      ladder_id = leagues$tier[[j]]$division[[k]]$ladder_id
      players = ladder_data(ladder_id) #API CALL
      league=i
      tier=j
      ratings = sapply(players$team, function(x) x$rating)
      races = sapply(players$team, function(x) x$member[[1]]$played_race_count[[1]]$race$en_US) #Is this correct?
      wins =  sapply(players$team, function(x) x$wins)
      losses =  sapply(players$team, function(x) x$losses)
      played_race_count = sapply(players$team, function(x) x$member[[1]]$played_race_count[[1]]$count)
      battle_tag = sapply(players$team, function(x) {
        if(is.null(x$member[[1]]$character_link$battle_tag)) {
          return("000")
        } else {
          x$member[[1]]$character_link$battle_tag
        }
      })
      last_played <- sapply(players$team, function(x) x$last_played_time_stamp)
      path = sapply(players$team, function(x) {
        if(is.null(x$member[[1]]$legacy_link$path)) {
          return("000")
        } else {
          x$member[[1]]$legacy_link$path
        }
      })
      new.data <- data.frame(league,tier,ratings,races,wins,losses,played_race_count,battle_tag,last_played,path)
      df <- rbind(df,new.data)
      Sys.sleep(0.02)
    }
  }
}

df$display_name <- str_extract(df$path,'([^/]+$)')
df <- df[order(-df$ratings),]
df$last_played_human <- as.POSIXct(df$last_played, origin="1970-01-01")
df$races <- as.factor(df$races)
filtered_df <- df[df$played_race_count>=10 & df$last_played_human >= (Sys.Date()-60) &
                    df$races!='Random',]

ggplot(filtered_df,aes(x=ratings)) +
  geom_density(aes(y=..density..,group=races,colour=races),adjust=1.5,lwd=1) +
  scale_color_manual(values=c('Orange','Blue','Red')) +
  theme_light()

filtered_df %>% group_by(races) %>% summarize(median(ratings))
