#I use Iris data.class
#This famous (Fisher's or Anderson's) iris data set gives the measurements
#in centimeters of the variables sepal length and width and petal length 
#and width, respectively, for 50 flowers from each of 3 species of iris. 
#The species are Iris setosa, versicolor, and virginica.

data(iris)
iris
set.seed(73)

#Preparig sample
smp <- sample(x=1:150,size=105)

#Traning and test set
train <-iris[smp,]
test <-iris[-smp,]

#Load the tree package
library(tree)

#Train a decision tree model
model <- tree(formula = Species ~ ., data = train)

#Showing summary
summary(model)

#Show tree model
plot(model)
text(model)

#Using RColorBrewer to show scatterplot
library(RColorBrewer)
palette <- brewer.pal(8,"Dark2")

#Scatter plot
plot(x = iris$Petal.Length, y=iris$Petal.Width,pch = 20, col = palette[as.numeric(iris$Species)],main = "Petal Length vs Petal width", xlab= "Petal Lenght", ylab = "Petal Width")

#Plot the decision boundaries
partition.tree(tree = model, label = "Species",add = TRUE )

#Predict
predictions <- predict(object = model, newdata = test, type = "class")

#Create and show confusionMatrix
table(x= predictions,y = test$Species)
library(caret)
confusionMatrix(data = predictions, reference = test$Species)

#Predict new value
predict(object = model, newdata = data.frame(
  Petal.Width = c(2,5,7),
  Petal.Length =c(2,3.5,4),
  Sepal.Width =c(3,3.5,4.1),
  Sepal.Length =c(1.5,2,0.2)))
