%% -*- mode: nitrogen -*-
-module (index).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").

main() -> #template { file="./site/templates/bare.html" }.

title() -> "Welcome to WordServer".

body() ->
    #container_12 { body=[
        #grid_8 { alpha=true, prefix=2, suffix=2, omega=true, body=inner_body() }
    ]}.

inner_body() -> 
    [
        #h1 { text="Welcome to WordServer" },
        #p{},
        "
        This is the first testpage with the new build system. Both app code and web code is seperated!

        Yeah!
        ",
        #p{}, 	
        #button { id=button, text="Click me!", postback=click }
    ].
	
event(click) ->
    wf:replace(button, #panel { 
        body="You clicked the button!", 
        actions=#effect { effect=highlight }
    }).
