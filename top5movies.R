all_movies = read.csv("movie_titles.csv")
nrecometflix_first_10 = read.csv("first_ten_movies_1.csv")
library(stringi)
library(reshape2)

#convert the dataset into matrix with customerid as row and movieid as column and Rating as cell values
ratingmatrix = dcast(netflix_ten, CustomerId~MovieId, value.var = "Rating", na.rm=FALSE)

ratingmatrix = as.matrix(ratingmatrix[,-1])

library(recommenderlab)

ratingmatrix = as(ratingmatrix, "realRatingMatrix")

recommend_model = Recommender(ratingmatrix, method = "UBCF", param = list(method = "Cosine", nn=10))

top_5_movies = predict(recommend_model, ratingmatrix[1], n = 5)

top_5_movies_list = as(top_5_movies, "list")
View(top_5_movies_list)


library(dplyr)

Top_5 = data.frame(top_5_movies_list)

colnames(Top_5) = "MovieId"

Top_5$MovieId=as.numeric(levels(Top_5$MovieId))


movie_names=left_join(Top_5, all_movies, by="MovieId")
 View(movie_names)
 
 