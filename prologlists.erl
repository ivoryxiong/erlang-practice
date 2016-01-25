-module(prologlists).
-export([last/1, element_at/2, count/1, reverse/1,is_palindrome/1,flat/1]).

last([]) -> undefined;
last([H]) -> H;
last([_|T]) -> last(T).

element_at(_,[]) -> unfefined;
element_at(1,[H|_]) -> H;
element_at(K,[_|T]) -> element_at(K-1, T).

count_do([],K) -> K;
count_do([_|T], K) -> count_do(T, K+1).
count(T) -> count_do(T, 0).

reverse_do([],K) -> K;
reverse_do([H|T], K) -> reverse_do(T, [H] ++ K).
reverse(K) -> reverse_do(K, []).

is_palindrome_do([], M, N) -> M =:= N;
is_palindrome_do([H|T], M, N) -> is_palindrome_do(T, [H] ++ M, N ++ [H]).
is_palindrome(K) -> is_palindrome_do(K,[],[]).

flat_do([], R) -> R;
flat_do([H|T],R) when erlang:is_list(H) -> flat_do(H ++ T, R);
flat_do([H|T],R) -> flat_do(T, R ++ [H]). 
flat(K) -> flat_do(K,[]).
