# Algorithm #

To start simply lets build a simple datastructure with digraph to make the word file to tuples

``
{ Index, NextIndex, Letter }
{ LastIndex, Letter } -- end of word


{ 1, 2, A }
{ 2, 3, R }
{ 3, 4, J }
{ 3, 6, J }
{ 4, 5, E }
{ 5, N }
{ 6, 7, A }
{ 7, N }

W = digraph:new().
``

