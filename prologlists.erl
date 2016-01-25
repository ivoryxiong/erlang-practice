%% solution for problem list https://sites.google.com/site/prologsite/prolog-problems/1
-module(prologlists).
-export([last/1, element_at/2, count/1, reverse/1,is_palindrome/1,flat/1,compress/1]).
-export([pack/1, encode/1, encode_modifier/1]).

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

compress_do([], R) -> R;
compress_do([H|T], [R|K]) when H =:= R -> compress_do(T, [R|K]);
compress_do([H|T], R) -> compress_do(T, [H] ++ R). 
compress(K) -> reverse(compress_do(K, [])).

pack_do([], R) -> R;
pack_do([H|T],[]) -> pack_do(T,[[H]]);
pack_do([H|T],[[RH|RT]|K])  when H =:= RH -> pack_do(T, [[H] ++ [RH|RT] | K]);
pack_do([H|T],[[RH|RT]|K]) -> pack_do(T, [[H]] ++ [[RH|RT] | K]).
pack(K) -> reverse(pack_do(K,[])).

encode_do([], R) -> R;
encode_do([H|T],[]) -> encode_do(T,[{H,1}]);
encode_do([H|T],[{RE,RACC}|K])  when H =:= RE -> encode_do(T, [{RE, RACC+1} | K]);
encode_do([H|T],[{RE,RACC}|K])  -> encode_do(T, [{H, 1}] ++ [{RE, RACC} | K]).
encode(K) -> reverse(encode_do(K,[])).

encode_modifier_do([], [[RE] | K]) -> [RE] ++ K;
encode_modifier_do([], R) -> R;
encode_modifier_do([H|T],[]) -> encode_modifier_do(T,[[H]]);
encode_modifier_do([H|T],[{RE,RACC}|K])  when H =:= RE -> encode_modifier_do(T, [{RE, RACC+1} | K]);
encode_modifier_do([H|T],[{RE,RACC}|K])  -> encode_modifier_do(T, [[H]] ++ [{RE, RACC} | K]);
encode_modifier_do([H|T],[[RE]|K])  when H =:= RE -> encode_modifier_do(T, [{RE, 2} | K]);
encode_modifier_do([H|T],[[RE]|K])  -> encode_modifier_do(T, [[H]] ++ [RE | K]).
encode_modifier(K) -> reverse(encode_modifier_do(K,[])).
