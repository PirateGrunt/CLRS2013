1. Structure of data
  1. Move data into a data frame
  1. Distinguish between stochastic and static predictors
2. Visualize data
    1. Plot predictors and responses - ggplot2
    2. Two-dimensional plots are challenging
    3. Group points
2. lm
    1. formula
    2. weights - alpha
    2. coefficients
3. Fit diagnostics
    1. F-stat
    1. Durbin-watson and others
    1. Breusch-Pagan
    1. Cross validation - part 1
3. Plot diagnostics - 1
    1. F-stat
    1. Testing assumption testing
    1. p-p plot
    1. foursquare - heteroskedasticity
3. Grouped regression
    1. Use as.factor to group the predictor
    1. Design matrix - try that in Excel
    1. Collate the tail
4. Plot diagnostics - 2
    1. Plot model factors
    1. Change tail assumption and replot
    1. Andrew Gelman doesn''t like to test significance of groups
4. Brief aside about lmer
    1. Tornado plot
    1. lmer requires an intercept
    1. Hierarchical regression
5. Projection
    1. 
6. Another view of regression
    1. Normal case - use optim
    1. Another form of error
7. glm
    1. glm is another assumption about variance