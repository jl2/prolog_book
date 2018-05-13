reigns(rhodri, 844, 878).
reigns(anarawd, 878,916).
reigns(hywel_dda, 916,950).
reigns(lago_ad_idwal, 950,979).
reigns(hywel_ab_ieuaf, 979,985).
reigns(cadwallon, 985,986).
reigns(maredudd, 986,999).

prince(X, Y) :-
    reigns(X, A, B),
    Y >= A,
    Y =< B.

pop(usa, 203).
pop(india, 548).
pop(china, 800).
pop(brazil, 108).

area(usa, 3).
area(india, 1).
area(china, 4).
area(brazil, 3).

density(X, Y) :-
    pop(X, P),
    area(X, A),
    Y is P/A.


radius_squared(X, Y) :-
    X is sqrt(Y).

circle_area(Radius, Area) :-
    radius_squared(Radius,RSquared),
    Area is RSquared * 3.141592654.

parent(C, M, F) :- mother(C, M), father(C, F).
mother(john, ann).
mother(mary, ann).

father(mary, fred).
father(john, fred).

add(X, Y, Z) :- Z is X+Y.

p([1,2,3]).
p([the, cat, sat, [on, the, mat]]).


my_member(X, [X|_]).
my_member(X, [_|Y]) :- my_member(X, Y).

my_islist([_|B]) :- my_islist(B).
my_islist([]).


aless(X, Y) :- name(X, L), name(Y, M), alessr(L, M).

alessr([], [_|_]).
alessr([X|_], [Y|_]) :- X < Y.
alessr([A|X], [A|Y]) :- alessr(X, Y).


basicpart(rim).
basicpart(spoke).
basicpart(rearframe).
basicpart(handles).
basicpart(gears).
basicpart(bolt).
basicpart(nut).
basicpart(fork).

assembly(bike, [wheel, wheel, frame]).

assembly(wheel, [spoke, rim, hubs]).
assembly(frame, [rearframe, frontframe]).
assembly(frontframe, [fork, handles]).
assembly(hub, [gears, axle]).
assembly(axle, [bolt, nut]).

partsof(X, [X]) :- basicpart(X).
partsof(X, P) :-
    assembly(X, Subparts),
    partsoflist(Subparts, P).

partsoflist([P | Tail], Total) :-
    partsof(P, Headparts),
    partsoflist(Tail, Tailparts),
    append(Headparts, Tailparts, Total).


door(a,b).
door(b,e).
door(b,c).
door(d,e).
door(c,d).
door(e,f).
door(g,e).
hasphone(g).

go(X,X,_).
go(X,Y,T) :- (door(X, Z); door(Z,X)), not(member(Z,T)), go(Z,Y, [Z|T]), display(T).


hanoi(N) :- move(N, left, centre, right).
move(0,_,_,_) :- !.
move(N,A,B,C) :-
    M is N-1,
    move(M, A,C,B),
    inform(A,B),
    move(M,C,B,A).
inform(X,Y) :-
    write([move,a,disc,from,the,X,pole,to,the,Y,pole]), nl.


partlist(T) :- partsof(1, T, P), collect(P,Q), printpartlist(Q).
partsof(N,X,P) :- assembly(X, S), partsoflist(N,S,P).
parsof(N,X, [quant(X,N)]) :- basicpart(X).

partsoflist(_, [], []).
partsoflist(N, [quant(X, Num)|L],T) :-
    M is N*Num,
    partsof(M, X, Xparts),
    partsoflist(N,L,Restparts),
    append(Xparts, Restparts, T).

collect([], []).
collect([quant(X,N)|R], [quant(X,Ntotal)|R2]) :-
    collectrest(X,N,R,O,Ntotal),
    collect(O, R2).

collectrest(_, N, [], [], N).
collectrest(X,N, [quant(X,Num)|Rest], Others, Ntotal) :-
    !,
    M is N + Num,
    collectrest(X,M,Rest,Others,Ntotal).
collectrest(X, N, [Other|Rest], [Other|Others],Ntotal) :-
    collectrest(X, N, Rest,Others,Ntotal).

printpartlist([]).
printpartlist([quant(X,N) | R]) :-
    tab(4), write(N), put(9),write(X), nl, printpartlist(R).

