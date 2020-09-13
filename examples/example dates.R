leaderboard <- gm_leaderboard("us")

gm_names <- sapply(leaderboard$ladderTeams, 
                   function(x) {
                     print(x$teamMembers[[1]]$displayName)
                   }
)

profile_ids <- sapply(leaderboard$ladderTeams, 
                      function(x) {
                        x$teamMembers[[1]]$id
                      }
)

match_history <- legacy_match_history("us",1,profile_ids[match('PandaBearMe',gm_names)])


dates <- sapply(match_history$matches,
                function(x) {
                  x$date
                })

as.POSIXct(dates, origin="1970-01-01")

# gm_mmr <- sapply(leaderboard$ladderTeams, 
#        function(x) {
#          x$mmr
#        }
# )
# 
# hist(gm_mmr)
