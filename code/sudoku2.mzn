int: N = 9;        % size of the puzzle
int: S = 3;        % size of sub-grids
set of int: PuzzleRange = 1..N;
set of int: SubSquareRange = 1..S;
set of int: Cells = 1..N * N;
int: digs = ceil(log(10.0, int2float(N)));
array[1..N, 1..N] of var PuzzleRange: puzzle;   % the puzzle grid

% constraints
constraint forall(i in 1..N, j in 1..N where puzzle[i,j] != 0) (
    puzzle[i,j] in PuzzleRange    % make sure every cell contains a valid value
);

constraint
    % rows have distinct values
    forall(i in 1..N, j in 1..N where j != i) (
        forall(k in PuzzleRange) (
            puzzle[i,k] != puzzle[j,k]
        )
    ) /\
    % columns have distinct values
    forall(i in 1..N, j in 1..N where j != i) (
        forall(k in PuzzleRange) (
            puzzle[k,i] != puzzle[k,j]
        )
    ) /\
    %s sub-square have distinct values
      forall(g in SubSquareRange, i in SubSquareRange, j in SubSquareRange, u in SubSquareRange, v in SubSquareRange, x in SubSquareRange, y in SubSquareRange where
        ((i*S+u),(j*S+v)) != ((i*S+x),(j*S+y)) 
    ) (
        puzzle[((i-1)*S+u),((j-1)*S+v)] != puzzle[((i-1)*S+x),((j-1)*S+y)] 
    );

solve satisfy;

output [ 
  show_int(digs,puzzle[i,j]) ++ " " ++
    if j mod S == 0 then " " else "" endif ++
    if j == N /\ i != N then
      if i mod S == 0 then "\n\n" else "\n" endif
    else "" endif
  | i,j in PuzzleRange ] ++ 
  ["\n"];