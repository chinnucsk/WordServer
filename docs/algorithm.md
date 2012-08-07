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
