# Algorithm #

Binary operations in erlang:

    A = binary:copy(<<1>>,32). 
    <<1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
    1,...>>

    <<C:24/binary, R/binary>> = A.

    E=list_to_binary("hellowol").
    <<"hellowol">>
    
    F = <<C:24/binary, E:8/binary>>.
    <<1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,104,101,
        108,108,111,...>>
    
    binary:part(F, 24, 8).
    <<"hellowol">>


    P = fun(Perms, []) -> [[]];
    (Perms, L) -> [[H|T] || H <- L, T <- Perms(Perms, L--[H])] end.


    {Letter, Index, From, EndOfWord}
    
    ets:new(words, [named_table,duplicate_bag]).
    ets:insert(words, {"A", 1, 0, 0}).
    ets:insert(words, {"R", 2, 1, 0}).
    ets:insert(words, {"J", 3, 2, 0}).
    ets:insert(words, {"E", 4, 3, 0}).
    ets:insert(words, {"N", 5, 4, 1}).
    ets:insert(words, {"A", 6, 3, 0}).
    ets:insert(words, {"N", 7, 6, 1}).
    
    ets:lookup(words, "A").
