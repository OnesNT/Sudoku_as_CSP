% sudoku solver
include "alldifferent.mzn";

int: S = 3;
int: N = S * S;
int: digs = ceil(log(10.0, int2float(N))); % digits for output

set of int: PuzzleRange = 1..N;
set of int: SubSquareRange = 1..S;

array[1..N, 1..N] of 0..N: start; % 0 represents an empty square
array[1..N, 1..N] of var PuzzleRange: puzzle;

% fill initial grid
constraint forall(i,j in PuzzleRange)(
  if start[i,j] > 0 then puzzle[i,j] = start[i,j] else true endif );

% all different in rows
constraint forall(i in PuzzleRange)(
  alldifferent([puzzle[i,j] | j in 1..N]));

% all different in columns
constraint forall(j in PuzzleRange)(
  alldifferent([puzzle[i,j] | i in 1..N]));

% all different in sub-squares
constraint forall(i, j in SubSquareRange)(
  alldifferent([puzzle[(i-1) *S + i1, (j-1)*S + j1] | i1, j1 in SubSquareRange]));


solve satisfy;

output [ 
  show_int(digs,puzzle[i,j]) ++ " " ++
    if j mod S == 0 then " " else "" endif ++
    if j == N /\ i != N then
      if i mod S == 0 then "\n\n" else "\n" endif
    else "" endif
  | i,j in PuzzleRange ] ++ 
  ["\n"];