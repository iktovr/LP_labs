:- include("tree.pl").

sex(X,m) :- father(X,_).
sex(X,f) :- mother(X,_).

shurin(X,Y) :- father(Y,A), mother(B,A), father(C,B), father(C,X), sex(X,m).
shurin(X,Y) :- father(Y,A), mother(B,A), mother(C,B), mother(C,X), sex(X,m).
