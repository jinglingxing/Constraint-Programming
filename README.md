# Constraint-Programming
## TP1 problem:
TP1 is a match schedule problem wrote by Minizinc language. What I did are safisfied several strict constraints for given instances and found solutions and tested results at different consistency level using mzn-gecode and compared two significant models performances, such as failures, search tree, runtime. **Unfortunately, Github cannot detect Minizinc language**, it is very niche, but powerful for CSPs. The website of Minizinc is: [Minizinc](http://www.minizinc.org/)

**Author**: Jinling XING jinling.xing@polymtl.ca

The detailed info of questions, please click the link: [TP1 questions](https://github.com/jinglingxing/Constraint-Programming/blob/master/TP1_Minizinc/tp1.pdf)

The dataset including 15 instances, I tested them using bound and domain consistency levels and compared the runing time, failures and search tree(nodes). Detailed info: [Report](https://github.com/jinglingxing/Constraint-Programming/blob/master/TP1_Minizinc/constraint-programming-tp1.pdf)

I wrote two models: one is normal method. Detailed info: [Model 1](https://github.com/jinglingxing/Constraint-Programming/blob/master/TP1_Minizinc/TP1_INF6101_1.mzn)

one is based on DFA(deterministic finite automaton). Detailed info:[Model 2](https://github.com/jinglingxing/Constraint-Programming/blob/master/TP1_Minizinc/TP1_INF6101_2.mzn)
