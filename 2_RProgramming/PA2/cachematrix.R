## Author: PiyushRoutray @p_routray
#Coursera - Intr to R Prog. Assignment2
## The code implements the idea of calculating the inverse of a matrix using cache.
## We are assumming that the input matrix is a square matrix whose inverse calculation
#possible. 
## I have used matrix 4 3 to test the results. The inverse is -2  3
#                     3 2                                      3 -4


## The function makeCacheMatrix creates a matrix object which is to be the input of the 
# next function. set,get, setinv, getinv are defined here, but are called in the 
# cacheSolve() function. 

makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setinv <- function(solve) m <<- solve
  getinv <- function() m
  list(set = set, get = get,
       setinv = setinv,
       getinv = getinv)
}


## cacheSolve() function calculates the inverse of matrix, if it has not been already 
# calculated. The input is object created from makeCacheMatrix() function. If m is NOT null,
# then we know that the inverse was calculated before and is stored in cache. The value is 
# returned directly. Else, we call the solve() function on m and setinv(m) so that next time
# the answer is stored in cache.

cacheSolve <- function(x, ...) {
  m <- x$getinv()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- solve(data, ...) #to calculate the inverse first time.
  x$setinv(m) #to store in cache
  m
}
