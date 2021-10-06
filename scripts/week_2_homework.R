set.seed(15)
hw2 <- runif(50, 4, 50)
hw2 <- replace(hw2, c(4,12,22,27), NA)
hw2

#problem 1 - Take your hw2 vector and removed all the NAs then select all the numbers between 14 and 38 inclusive, call this vector prob1.
prob1 <- hw2[!is.na(hw2)] #remove nas - !makes it remove, if not included then will only be left with NA
prob1
prob1 <- prob1[prob1 >14 & prob1 <38] # selecting numbers between 14 and 38
prob1
 #returns: 31.69725 20.88531 15.68254 35.61262 27.41816 36.50491 24.58241 20.44790 30.02432 34.31432
#[11] 25.91301 26.93370 15.81016 26.61679 27.58909 34.26240 27.73300 17.87733 25.04181 15.91946
#[21] 19.81379 23.74194 19.19282

#problem 2 - Multiply each number in the prob1 vector by 3 to create a new vector called times3. Then add 10 to each number in your times3 vector to create a new vector called plus10.
times3 <- prob1 * 3 #multiplied the numbers in the vector by 3
times3

plus10 <- times3 + 10 #added 10 to each number in the vector of times 3
plus10

#problem 3 - Select every other number in your plus10 vector by selecting the first number, not the second, the third, not the fourth, etc. If you’ve worked through these three problems in order, you should now have a vector that is 12 numbers long that looks exactly like this one

final <- plus10[c(TRUE, FALSE)]
final
#results:  [1] 105.09174  57.04763  92.25447  83.74723 100.07297  87.73902  57.43049  92.76726  93.19901
#[10]  85.12543  69.44137  67.57845