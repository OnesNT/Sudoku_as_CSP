include "globals.mzn"; % include the globals library

int: S = 3;
int: SUM = 45;
int: N = S * S;
int: digs = ceil(log(10.0, int2float(N))); % digits for output

set of int: PuzzleRange = 1..N;
set of int: SubSquareRange = 1..S;

array[PuzzleRange, PuzzleRange] of var PuzzleRange: puzzle; % the puzzle grid
array[1..N, 1..N] of 0..N: start; % 0 represents an empty square


% % constraints

% fill initial grid
constraint forall(i,j in PuzzleRange)(
  if start[i,j] > 0 then puzzle[i,j] = start[i,j] else true endif );

% Constraint 1: sum of each row, column and grid should be equal to SUM
constraint forall(i in PuzzleRange) (sum(j in PuzzleRange)(puzzle[i,j]) = SUM); % rows
constraint forall(j in PuzzleRange) (sum(i in PuzzleRange)(puzzle[i,j]) = SUM); % columns
constraint forall(a, o in SubSquareRange) (sum(i in (a-1)*S+1..a*S, j in (o-1)*S+1..o*S)(puzzle[i,j]) = SUM); % sub-squares

% % Constraint 2: difference between any two elements in the same row, column, or grid should not be 0
constraint forall(i in PuzzleRange) 
  (forall( j1, j2 in PuzzleRange where j1 != j2)
      (puzzle[i, j1] - puzzle[i, j2] != 0)); % rows 
      
 constraint forall(j in PuzzleRange) 
  (forall( i1, i2 in PuzzleRange where i1 != i2)
      (puzzle[i1, j] - puzzle[i2, j] != 0)); % column
      
        
constraint forall(a, o in SubSquareRange) (forall(i1, j1, i2, j2 in (a-1)*S+1..a*S where (i1,j1) != (i2,j2)) (puzzle[i1,j1] - puzzle[i2,j2] != 0)); % sub-squares


solve satisfy;

% output the solution
output [ 
  show_int(digs,puzzle[i,j]) ++ " " ++
    if j mod S == 0 then " " else "" endif ++
    if j == N /\ i != N then
      if i mod S == 0 then "\n\n" else "\n" endif
    else "" endif
  | i,j in PuzzleRange ] ++ 
  ["\n"];
