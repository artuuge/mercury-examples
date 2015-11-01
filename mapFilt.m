%% Implement map, foldr, and filter, in terms of logical programming.
    
%% Author: artuuge@gmail.com
%% Language: Mercury


:- module mapFilt.

:- interface.
:- import_module io.
:- pred main( io::di, io::uo ) is det.

:- implementation.
:- import_module list, int, string.

:- pred map_list( pred( T1, T2 ), list( T1 ), list( T2 ) ).
:- mode map_list( in( pred( in, out ) is det ), in, out ) is det.
map_list( _, [], [] ).
map_list( F, [X | Xs0], Ys ) :-
	map_list( F, Xs0, Ys0 ),
	F( X, Y ),
	Ys = [Y | Ys0]. 

:- pred filter_list( pred( T ), list( T ), list( T ), list( T ) ).
:- mode filter_list( in( pred( in ) is semidet ), in, out, out ) is det.
filter_list( _, [], [], [] ).
filter_list( P, [X | Xs0], Ys, Zs ) :-
	filter_list( P, Xs0, Ys0, Zs0 ),
	( if P( X )
	then Ys = [X | Ys0], Zs = Zs0
	else Ys = Ys0, Zs = [X | Zs0] ). 

:- pred foldr_list( pred( A, B, B ), B, list( A ), B ).
:- mode foldr_list( in( pred( in, in, out ) is det), in, in, out ) is det. 
foldr_list( _, B, [], B). 
foldr_list( P, B0, [A | As], B1) :-
	foldr_list( P, B0, As, B),
	P( A, B, B1 ).

:- pred inc_int( int, int ).
:- mode inc_int( in, out ) is det.
inc_int( X, Y ) :-
	Y = X + 1. 

:- pred positive_int( int ).
:- mode positive_int( in ) is semidet.
positive_int( X ) :-
	( X > 0 ). 

:- pred add_int( int, int, int ).
:- mode add_int( in, in, out ) is det.
add_int( X, Y, Z ) :-
	Z = X + Y. 

:- pred print_list_int( list( int ), io, io ).
:- mode print_list_int( in, di, uo ) is det. 
print_list_int( [], !IO ) :-
	io.format( "Nil", [], !IO ). 
print_list_int( [X | Xs], !IO ) :-
	io.format( "%i : ", [i( X )], !IO ),
	print_list_int( Xs, !IO ). 

:- pred print_int( int, io, io ).
:- mode print_int( in, di, uo ) is det.
print_int( X, !IO ) :-
	io.format( "%i ", [i( X )], !IO ). 

main( !IO ) :-
	io.format( "Hello, World!\n", [], !IO ),
	Xs = [-10, 20, 30],
	U0 = 0, 
	map_list( inc_int, Xs, Ys ),
	filter_list( positive_int, Xs, Zs, Ws ),
	foldr_list( add_int, U0, Xs, U1),  
	print_list_int( Xs, !IO ), nl( !IO ),
	print_list_int( Ys, !IO ), nl( !IO ),
	print_list_int( Zs, !IO ), nl( !IO ),
	print_list_int( Ws, !IO ), nl( !IO ),
	print_int( U1, !IO ), nl( !IO ), 
	io.format( "Map, Foldr, and Filter.\n", [], !IO ).
