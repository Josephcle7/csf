# Joseph Clevenger
# Clejos10
# Computer Science Foundations
# Programming as a Way of Life
# Homework 1

# You may do your work by editing this file, or by typing code at the
# command line and copying it into the appropriate part of this file when
# you are done.  When you are done, running this file should compute and
# print the answers to all the problems.

import math                     # makes the math.sqrt function available
# Example of math.sqrt: print math.sqrt(2)



print "Problem 1 solution follows:"

#Original equation: x^2 - 5.86x + 8.5408
#Equation with Variables: ax^2 + bx + c

a = 1.0
b = 5.86
c = 8.5408

x = (-b + math.sqrt(b**2 - 4*a*c)) / 2*a;
y = (-b-math.sqrt(b**2 - 4*a*c)) / 2*a;

print y
print x, "\n"

###
### Problem 2
###

print "Problem 2 solution follows:"
import os, sys
os.chdir(os.path.dirname(sys.argv[0]))
import hw1_test

a = hw1_test.a
b = hw1_test.b
c = hw1_test.c
d = hw1_test.d
e = hw1_test.e
f = hw1_test.f

print a, "\n", b, "\n", c, "\n", d, "\n", e, "\n", f, "\n \n"

###
### Problem 3
###

print "Problem 3 solution follows:"

print (a and b) or (~c) and not (d or e or f)

###
### Reflection
###

#This assignment took me about five hours. The reading all took me about three hours and the actual programming excersized took me one and a half to two hours.
#The reading, tutorials, and lecture definitely contained everything I needed to complete in this assignment.