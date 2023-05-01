include "globals.mzn"; % include the globals library

int: S = 3;
int: N = S * S;
int: digs = ceil(log(10.0, int2float(N))); % digits for output

set of int: PuzzleRange = 1..N;
set of int: SubSquareRange = 1..S;

array[PuzzleRange, PuzzleRange] of var PuzzleRange: puzzle; % the puzzle grid
array[1..N, 1..N] of 0..N: start; % 0 represents an empty square

constraint forall(i,j in PuzzleRange)(
  if start[i,j] > 0 then puzzle[i,j] = start[i,j] else true endif);
  
% constraints


constraint forall(i in 1..N) (
  forall(k in PuzzleRange) (
    count_eq([puzzle[i,j] | j in 1..N], k, 1)
  )
);

constraint forall(j in 1..N) (
  forall(k in PuzzleRange) (
    count_eq([puzzle[i,j] | i in 1..N], k, 1)
  )
);

constraint forall(a, o in SubSquareRange)(
  forall(k in PuzzleRange)(
    count_eq([puzzle[(a-1)*S + a1, (o-1)*S + o1] | a1, o1 in SubSquareRange], k, 1)
  )
);


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
