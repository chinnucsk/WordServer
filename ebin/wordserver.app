{application,wordserver,
             [{description,"Server to find Scrabble words"},
              {vsn,"0.0.1"},
              {modules,[wordserver_app,wordserver_sup,wordserver_yaws]},
              {registered,[]},
              {applications,[kernel,stdlib]},
              {mod,{wordserver_app,[]}},
              {env,[]}]}.
