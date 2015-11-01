%% Implement a simple dialogue. 

%% Author: artuuge@gmail.com
%% Language: Mercury


:- module dialogue. 

:- interface. 
:- import_module io.

:- pred main( io::di, io::uo ) is det.


:- implementation. 
:- import_module list, string.

main( !IO ) :- 
io.write_string( "What is your name?\n", !IO), 
   io.read_line_as_string( R0, !IO ), 
   ( ( R0 = ok( S0 )
       , S1 = string.strip( S0 )
       , S1 \= "" ) 
     -> io.format("Hello, %s.\n", [ s(S1) ], !IO ); 
     io.format( "Good bye! %i.\n", [ i(42) ], !IO)
     ).

