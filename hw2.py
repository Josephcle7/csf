# Name: Joseph Clevenger
# Evergreen Login: Clejos10
# Computer Science Foundations
# Programming as a Way of Life
# Homework 2

# You may do your work by editing this file, or by typing code at the
# command line and copying it into the appropriate part of this file when
# you are done.  When you are done, running this file should compute and
# print the answers to all the problems.


###
### Problem 1
###

# DO NOT CHANGE THE FOLLOWING LINE
print "Problem 1 solution follows:"


import os, sys
os.chdir(os.path.dirname(sys.argv[0]))
import hw2_test

q = 0
m = 1
n = hw2_test.n
x = 100

while ( m < 50 ):
    y = m + x
    m = m + 1
    x = x - 1
    q = q + y + y
    print q


###
### Problem 2
###

# DO NOT CHANGE THE FOLLOWING LINE
print "Problem 2 solution follows:"

for i in range(2, 11):
    print 1 / i


###
### Problem 3
###

# DO NOT CHANGE THE FOLLOWING LINE
print "Problem 3 solution follows:"

n = 10
triangular = 0
for i in range(1, n):
    triangular = n * (n + 1) / 2
print "Triangular number", n, "via loop:", triangular
print "Triangular number", n, "via formula:", n*(n+1)/2

###
### Problem 4
###

# DO NOT CHANGE THE FOLLOWING LINE
print "Problem 4 solution follows:"

n = 10
g = 1
for i in range (1, n + 1):
    g = g * i
    
print g

###
### Problem 5
###

# DO NOT CHANGE THE FOLLOWING LINE
print "Problem 5 solution follows:"

m = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
n = 10
g = 1

for i in range (1, n + 1):
    g = g * i
    print g

###
### Problem 6
###

# DO NOT CHANGE THE FOLLOWING LINE
print "Problem 6 solution follows:"



###
### Collaboration
###

# ... List your collaborators and other sources of help here (websites, books, etc.),
# ... as a comment (on a line starting with "#").

#This assignment took me about 2 hours. The reading and lecture helped, but I had trouble understanding certain parts.

# ... Write how long this assignment took you, including doing all the readings
# ... and tutorials linked to from the homework page. Did the readings, tutorials,
# ... and lecture contain everything you needed to complete this assignment?
