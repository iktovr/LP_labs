:- include("tree.pl").

sex(X,m) :- father(X,_).
sex(X,f) :- mother(X,_).

shurin(X,Y) :- sex(X,m), father(Y,A), mother(B,A), father(C,B), father(C,X).
shurin(X,Y) :- sex(X,m), father(Y,A), mother(B,A), mother(C,B), mother(C,X).