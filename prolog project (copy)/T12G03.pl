

:- use_module(library(clpfd)).
                   

straight_chain_alkane(1,[cab(h,h,h,h)]).
straight_chain_alkane(N,[carb(h,h,h,c)|T]):-
N>1  ,
X is N-1,
helper(X,T) .
helper(1,[carb(c,h,h,h)]).
helper(N,[carb(c,h,h,c)|T] ):-
N>1 ,
X is N-1,
helper(X,T).

branch_name(S,N):- HS is S*2+1,
                        atomic_list_concat([c,S,h,HS],N).

add_branch_to_carbon(carb(c,h,h,c),0,carb(c,h,h,c)) .
add_branch_to_carbon(carb(c,h,h,c),N,Ans):-
                                        branch_name(N,C),
                                        Ans =carb(c,C,h,c).
add_branch_to_carbon(carb(c,X,h,c),N,Ans):-
                                         branch_name(N,X),
                                         Ans =carb(c,X,X,c).




replace_branch_over_everylist(X,[H1|T],[H1|T2],C):- C>1,
                                                   C1 is C-1,
                                                   replace_branch_over_everylist(X,T,T2,C1).
                                      
replace_branch_over_everylist(X,[H1|T],[H2|T],C):-
                                                 C=1,
                                                 add_branch_to_carbon(H1,X,H2).
calling_replace(X,N,L1,L2,C):-  C<N-1,
                                C1 is  C+1,
                                calling_replace(X,N,L1,L2,C1).
calling_replace(X,N,L1,L2,C):- C <N-1,
                               length(L1,B),
                               C>X,
                               H is B-C+1,
                               X<H,
                               replace_branch_over_everylist(X,L1,L2,C).



helper6([],N,L1,L1,C).
helper6([H|T],N,L1,L3,C):-
                          calling_replace(H,N,L1,L2,C),
                          helper6(T,N,L2,L3,C).
                          


                          
helper8(Y,N,L1,L3,C) :-
                      break_down2(Y,L2),
                      helper6(L2,N,L1,L3,C).
                          
branch_alkane3(X,Z,N,L):-
                        straight_chain_alkane(N,L1),
                        helper8(Z,X,L1,L,2).
                          
branch_alkane4(X,N,L):-
                      Z is X-N,
                      branch_alkane3(X,Z,N,L).

branch_alkane4(X,N,L):-
                             N>2,
                          N1 is N-1,

                          branch_alkane4(X,N1,L).



branch_alkanefinal(N,L):-
                          N>3,
                          N1 is N-1,
                          branch_alkane4(N,N1,L)  .

                                                              
 accum(H,[H|[]]):- H#>=0.
                       accum(D ,[H|T]):-
                                H#>=0,
                                accum(D1,T),
                                D = H+D1.



break_down(N,L2):-
                                length(L,N),
                                accum(D ,L),
                                N #= D ,
                                labeling([],L),
                                msort(L,L1),
                                delete(L1,0,L2).

break_down2(N,X):-
                                setof(L,break_down(N,L),L3),
                                member(X,L3).

                                       



                                              

                                              
                                       
                                       
                                       
                                                   

