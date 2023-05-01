# Sudoku-FinalProject

Sudoku is a logic-based, number-placement puzzle, where each board consists of a 9x9 grid with some fixed values. Each position, also called a cell, can hold a value between 1 and 9. A puzzle is completed when each position has been assigned a value, such that each value appears once per row, column, and 3x3 block of the grid.

## Formal problem statement

Sudoku can be represented as a constraint satisfaction problem, where:

- `X = {X1, ..., X81}` is the set of positions in 9x9 grid representing the variables of this problem 
- `Di = {1, 2, 3, 4, 5, 6, 7, 8, 9}` is the domain describing the values each variable can be assigned (`Xi ∈ D`), and
- The objective function becomes irrelevant because each point satisfies the constraint will represent a solution to the Sudoku puzzle problem

The set of constraints can be defined as follows:

- Each column contains exactly one integer number 1 to 9:
  - `∑i=1^9 xijk = 1, ∀j,k`
- Each row contains exactly one integer number 1 to 9:
  - `∑j=1^9 xijk = 1, ∀i,k`
- Each grid point contains exactly one integer number 1 to 9:
  - `∑k=1^9 xijk = 1, ∀i,j`
- Each sub-grid contains exactly one integer number 1 to 9:
  - `∑j=3q-2^3q ∑i=3p-2^3p xijk = 1, ∀k, ∀p,q ∈ {1, 2, 3}`
- For decision variables that are already known as clues, the value of the decision variable is set to be 1:
  - `xijk = 1, ∀i,j,k ∈ G`
- Non-negativity and binary:
  - `xijk = 1 ∈ {0, 1}`.
