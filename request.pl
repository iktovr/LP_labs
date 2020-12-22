:- include("relative.pl").

:- op(200, xfy, ':').

:- nb_setval(last_name, [n, n]).

dict(relations, Dict) :- Dict = [
	father        : fathers,
	mother        : mothers,
	son           : sons,
	dauther       : dauthers,
	brother       : brothers,
	sister        : sisters,
	grandson      : grandsons,
	granddaughter : granddaughters,
	grandfather   : grandfathers,
	grandmother   : grandmothers,
	shurin        : shurins
].

dict(pronouns, Dict) :- Dict = [
	he  : m,
	his : m,
	she : f,
	her : f
].

find(Dict, Word) :- dict(Dict, List), member(Word, List).

count_relative(Name, Rel, N) :- setof(X, relative(Rel, X, Name), Names), !, length(Names, N).
count_relative(_, _, 0).

yesno(Term, Res) :- Term, !, Res = 'yes'.
yesno(_, Res) :- Res = 'no'.

sentence(X) --> [is], name(Name1), relation_phrase(s, Rel), object_phrase(Name2), ['?'],  {save_name(Name2), yesno(relative(Rel, Name1, Name2), X)}.
sentence(X) --> [who, is], relation_phrase(s, Rel), object_phrase(Name), ['?'],           {save_name(Name), relative(Rel, X, Name)}.
sentence(X) --> [whose], relation_phrase(s, Rel), [is], name(Name), ['?'],                {save_name(Name), relative(Rel, Name, X)}.
sentence(X) --> [how, relate], name(Name1), [and], name(Name2), ['?'],                    {save_name(Name2), relative(X, Name1, Name2)}.

sentence(X) --> [does], name(Name), [have], num(N), relation_phrase(pl, Rel), ['?'],      {save_name(Name), yesno(count_relative(Name, Rel, N), X)}.
sentence(X) --> [how, many], relation_phrase(pl, Rel), [does], name(Name), [have], ['?'], {save_name(Name), count_relative(Name, Rel, X)}.

num(Num) --> [Num], {number(Num)}.

noun_phrase(Name) --> det, adjective_phrase, noun(Name).

det --> [the]; [a]; [].

adjective_phrase --> [].
adjective_phrase --> adjective, adjective_phrase.

adjective --> [small]; [old].

noun(Word) --> [Word].

name(Name) --> noun_phrase(Word), {load_name(Word, Name)}.

relation_phrase(Num, [Rel]) --> relation(Num, Rel).
relation_phrase(Num, [Rel1|Rel2]) --> relation(Num, Rel1), [of], relation_phrase(Num, Rel2).

relation(s, Rel) --> noun_phrase(Rel), {find(relations, Rel:_)}.
relation(pl, Rel) --> noun_phrase(Rels), {find(relations, Rel:Rels)}.

object_phrase(Name) --> [of], name(Name).

load_name(Pr, Name) :- find(pronouns, Pr:S), nb_getval(last_name, [Name, S]), !.
load_name(Pr, Name) :- find(pronouns, Pr:_), !, nb_getval(last_name, [Name, u]).
load_name(Name, Name).

save_name(Pr) :- find(pronouns, Pr:_), !.
save_name(Name) :- sex(Name, S), !, nb_setval(last_name, [Name, S]).
save_name(Name) :- nb_setval(last_name, [Name, u]).

request(Q, A) :- sentence(A, Q, []).
