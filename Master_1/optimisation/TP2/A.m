function gu = A()
% dans le cas d une fonctionnelle quadratique J,
% AJ renvoie la partie quadratique du gradient de J au point u,
% cad la multiplication par la matrice associee a J.
%
global numex
global a b c p
%
switch numex
 case 1
   gu = [1  -2; 2 -2];
 case 2
   gu = [1  -2; 2 -2] ;
 case 3
   gu = [5 7; 7 5/2] ;
 case {4, 5, 6}
   error('Fonction non quadratique.')
 otherwise
   error('Numero de fonction invalide.')
end

