%% Compute Fibonacci numbers.
%% F_0 = 0, F_1 = 1, F_{n} = F_{n - 1} + F_{n - 2}. 
%% (F_{n}, F_{n + 1}), n <= 91.
%% int is not handling arbitrary large integers.
				
%% Author: artuuge@gmail.com
%% Language: Mercury


:- module fibonacci. 

:- interface. 
:- import_module io. 
:- pred main( io::di, io::uo ) is cc_multi. 

:- implementation. 
:- import_module int, list, string. 

:- type nat_num ---> zero; succ( n::nat_num ). 
:- type fib_pair ---> fp( x::int, y::int ).

:- pred seq_fib_pair( fib_pair::in, fib_pair::out ) is det.

:- pred nth_fib_pair( int::in, fib_pair::out) is cc_multi.

:- pred nth_fib_pair_nat_num( nat_num::in, fib_pair::out ) is det.

:- pred nat_int( nat_num, int ).
:- mode nat_int( in, out ) is det.
:- mode nat_int( out, in ) is cc_multi.


nat_int( zero, 1 ). 
nat_int( succ( N ), I + 1 ) :- 
	nat_int( N, I ).     

seq_fib_pair( P0, P1 ) :- 
	( P0 = fp( X0, Y0 ), 
	  P1 = fp( X1, Y1 ), 
	  X1 = Y0, 
	  Y1 = X0 + Y0 ).

nth_fib_pair_nat_num( M, P ) :- 
	( M = zero, 
	  P = fp( 1, 1 ); 			     
	  M = succ( N ),  
	  nth_fib_pair_nat_num( N, Q ), 
	  seq_fib_pair( Q, P ) ). 


nth_fib_pair( 1, P ) :- 
	P = fp( 1, 1 ).
nth_fib_pair( N + 1, P ) :- 
	nth_fib_pair( N, Q ), 
	seq_fib_pair( Q, P ). 

:- pred nfp( int, fib_pair ). 
:- mode nfp( in, out ) is cc_multi.

nfp( N, P ) :-
	( N = 1,
	  P = fp( 1, 1 );
	  N = M + 1,
	  seq_fib_pair( Q, P ),
	  nfp( M, Q ) ).



main( !IO ) :- 
	nth_fib_pair( 91, fp( X, Y )), 
	%%   io.write_string( "42\n", !IO ), 
	io.format( "%i, %i\n", [i(X), i(Y)], !IO ),
	nat_int( N, 91 ), 
	nth_fib_pair_nat_num( N, fp( Z, W )), 
	io.format( "%i, %i\n", [i(Z), i(W)], !IO ),
	nfp( 91, fp( U, V )),
	io.format( "%i, %i\n", [i(U), i(V)], !IO ), 
	io.format( "Fibonacci numbers (91st and 92nd).\n", [], !IO ). 
