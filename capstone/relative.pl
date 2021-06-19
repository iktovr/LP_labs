:- include("tree.pl").

sex(X,m) :- father(X,_).
sex(X,f) :- mother(X,_).

direct_relative(father,X,Y) :- father(X,Y).
direct_relative(mother,X,Y) :- mother(X,Y).

direct_relative(son,X,Y) :- father(Y,X), sex(X,m).
direct_relative(son,X,Y) :- mother(Y,X), sex(X,m).

direct_relative(dauther,X,Y) :- father(Y,X), sex(X,f).
direct_relative(dauther,X,Y) :- mother(Y,X), sex(X,f).

direct_relative(brother,X,Y) :- father(A,X), father(A,Y), X \= Y, sex(X,m).
direct_relative(brother,X,Y) :- mother(A,X), mother(A,Y), X \= Y, sex(X,m).

direct_relative(sister,X,Y) :- father(A,X), father(A,Y), X \= Y, sex(X,f).
direct_relative(sister,X,Y) :- mother(A,X), mother(A,Y), X \= Y, sex(X,f).

direct_relative(grandfather,X,Y) :- father(X,Z), father(Z,Y).
direct_relative(grandfather,X,Y) :- father(X,Z), mother(Z,Y).

direct_relative(grandmother,X,Y) :- mother(X,Z), mother(Z,Y).
direct_relative(grandmother,X,Y) :- mother(X,Z), father(Z,Y).

direct_relative(grandson,X,Y) :- direct_relative(grandfather,Y,X), sex(X,m).
direct_relative(grandson,X,Y) :- direct_relative(grandmother,Y,X), sex(X,m).

direct_relative(granddaughter,X,Y) :- direct_relative(grandfather,Y,X), sex(X,f).
direct_relative(granddaughter,X,Y) :- direct_relative(grandmother,Y,X), sex(X,f).

direct_relative(shurin,X,Y) :- father(Y,A), mother(B,A), father(C,B), father(C,X), sex(X,m).
direct_relative(shurin,X,Y) :- father(Y,A), mother(B,A), mother(C,B), mother(C,X), sex(X,m).

relative(Rel, X, Y) :- nonvar(Rel), !, dfs(Rel, Y, [X]).
relative(Rel, X, Y) :- bfs(Rel, Y, [[X]]).

dfs([], Y, [Y|_]).
dfs([Rel1|Rel2], Y, [X|T]) :-
	direct_relative(Rel1, X, Z), not(member(Z, [X|T])),
	dfs(Rel2, Y, [Z,X|T]).

prolong([X|T], [Y, X|T]) :- direct_relative(_, X, Y), not(member(Y, [X|T])).

to_relation([], [_]).
to_relation([R|T1], [Y, X|T2]) :- direct_relative(R, X, Y), to_relation(T1, [X|T2]).

bfs(R, Y, [[Y|T]|_]) :- to_relation(R1, [Y|T]), reverse(R1, R).
bfs(R, Y, [[X|P]|Q1]) :-
	setof(Z, prolong([X|P], Z), T), append(Q1, T, Q2), !,
	bfs(R, Y, Q2).
bfs(R, Y, [_|T]) :- bfs(R, Y, T).
