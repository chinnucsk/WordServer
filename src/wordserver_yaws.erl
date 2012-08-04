-module(wordserver_yaws).
-export ([out/1]).

%%
%% Initialisation file for Yaws / Nitrogen
%%

out(Arg) ->
    % Setup the Yaws request bridge
    RequestBridge = simple_bridge:make_request(yaws_request_bridge, Arg),
    ResponseBridge = simple_bridge:make_response(yaws_response_bridge, Arg),
    % hook up Nitrogen to it
    nitrogen:init_request(RequestBridge, ResponseBridge),
    % Kickoff nitrogen
    nitrogen:run().
