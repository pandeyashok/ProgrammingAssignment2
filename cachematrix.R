## Below R functions are able to cache time-consuming repetative inversions of a matrix
## by caching the inverse of a matrix. If the matrix has not changed the inverse is 
## returned from the cache instead of re-calcualtion. 


## This function creates a special "matrix" object that can cache its inverse
makeCacheMatrix <- function(x = matrix()) {
        inv = NULL
        set = function(y) {
                x <<- y
                inv <<- NULL
        }
        get = function() x
        setinverse = function(inverse) inv <<- inverse
        getinverse = function() inv
        list(set = set, get = get,
             setinverse = setinverse,
             getinverse = getinverse)
}


## This function computes the inverse of an invertible matrix 
## returned by makeCacheMatrix. If the inverse has already 
## been calculated (and the matrix has not changed), then it retrieves the inverse from the cache.
cacheSolve <- function(x, ...) {
        ## Get inverse of x
        inv = x$getinverse()

        # Check if inverse value exists, if yes, return from cache
        if(!is.null(inv)) {
                message("getting cached data")
                return(inv)
        }
        data = x$get()
        # Calcualte inverse of a matrix
        inv = solve(data)
        x$setinverse(inv)
        inv
}
