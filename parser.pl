:- dynamic person/2.
:- dynamic parents/3.

sentence --> [].
sentence --> indi_record, sentence.
sentence --> fam_record, sentence.

childs(Childs) --> tag('CHIL'), id(Id), childs(Childs2), {Childs = [Id|Childs2]}.
childs(Childs) --> tag('CHIL'), id(Id), {Childs = [Id]}.

family --> tag('HUSB'), id(Husbid), tag('WIFE'), id(Wifeid), childs(Childs), {add_parents(Husbid,Wifeid,Childs)}.
family --> tag('HUSB'), id(_), tag('WIFE'), id(_).

family --> tag('HUSB'), id(Id), childs(Childs), {add_parents(Id,'@@',Childs)}.
family --> tag('HUSB'), id(_).

family --> tag('WIFE'), id(Id), childs(Childs), {add_parents('@@',Id,Childs)}.
family --> tag('WIFE'), id(_).

family --> childs(_).

fam_record --> id(_), tag('FAM'), family.

indi_record --> id(Id), tag('INDI'), tag('NAME'), name(Name), {add_person(Id, Name)}.

tag(Tag) --> [Tag].

name(Name) --> [Name].

id(Id) --> [Id].

add_person(Id,Name) :- clause(person(Id,Name), true).
add_person(Id,Name) :- assert(person(Id,Name)).
add_parents(_,_,[]).

add_parents(Id1,Id2,[Child|Childs]) :- clause(parents(Id1,Id2,Child), true), add_parents(Id1,Id2,Childs).
add_parents(Id1,Id2,[Child|Childs]) :- assert(parents(Id1,Id2,Child)), add_parents(Id1,Id2,Childs).

write_parent(_,'@@',_).
write_parent(Parent,Id1,Id2) :- person(Id1, Name1), person(Id2, Name2), write(Parent), write("("), writeq(Name1), write(","), writeq(Name2), write(")."), nl.

main :- 
	read(File), tell(File),
	read(Text),
	sentence(Text,[]), !,
	parents(Father,Mother,Child), write_parent("father",Father,Child), write_parent("mother",Mother,Child),
	fail.
