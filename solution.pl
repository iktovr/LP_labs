solve(Voronov, Pavlov, Levitskiy, Saharov) :-
	permutation([Voronov, Pavlov, Levitskiy, Saharov], [dancer, painter, singer, writer]), 
	not(contradiction([Voronov, Pavlov, Levitskiy, Saharov])).

contradiction(V) :- data(V, A, TF), logicalnot(TF, FT), data(V, A, FT).

logicalnot(true, false).
logicalnot(false, true).

data([Voronov, _, Levitskiy, _], [Voronov, Levitskiy, singer], true).
data([_, Pavlov, _, _], [Pavlov, writer, painter], true).
data([Voronov, _, _, Saharov], [Voronov, Saharov, writer], true).
data(_, [X, X, _], false).
data(_, [X, _, X], false).
data(_, [_, X, X], false).
data([Voronov, _, Levitskiy, _], [Levitskiy, _, Voronov], false).
data([Voronov, _, Levitskiy, _], [_, Levitskiy, Voronov], false).
