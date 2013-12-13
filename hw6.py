# Name: Joseph Clevenger
# Evergreen Login: Clejos10
# Computer Science Foundations
# Programming as a Way of Life
# Homework 6

# You may do your work by editing this file, or by typing code at the
# command line and copying it into the appropriate part of this file when
# you are done.  When you are done, running this file should compute and
# print the answers to all the problems.


###
### Problem 3
###

# DO NOT CHANGE THE FOLLOWING LINE
print "Problem 3 solution follows:"

def afunction(x,y,z):
    
    return((x * y) + z)


###
### Problem 4
###

# DO NOT CHANGE THE FOLLOWING LINE
print "Problem 4 solution follows:"

numbers = {'Joe':'111-222-3333','Bob':'222-333-4444','Zach':'333-444-5555'}
del(numbers['Bob'])
numbers['Suzy'] = '444-555-6666'


###
### Problem 5
###

# DO NOT CHANGE THE FOLLOWING LINE
print "Problem 5 solution follows:"

dict1 = {1:2, 3:4, 5:6}
dict3 = dict1

print id(dict1)==id(dict3)
print id(dict3)==id(dict1) + id(dict3)

###
### Problem 6
###

# DO NOT CHANGE THE FOLLOWING LINE
print "Problem 6 solution follows:"

list1 = [1,2,3,4,5]

for i in range(0,5):
    x = list1[i] + 1
    print x

###
### Problem 7
###

# DO NOT CHANGE THE FOLLOWING LINE
print "Problem 7 solution follows:"

import random

###
### Collaboration
###

# ... List your collaborators and other sources of help here (websites, books, etc.),
# ... as a comment (on a line starting with "#").