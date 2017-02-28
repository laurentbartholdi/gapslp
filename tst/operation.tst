
##Fichier test des opérations

gap> g := FreeGroup(IsSLPWordsFamily,2);;
gap> g.1*g.2/g.1; 
f1*f2*f1^-1
gap> g.1^0; 
<identity ...>
gap> One(g.1);
<identity ...> 
gap> IsOne(g.1^0);
true
gap> one := AssocWordBySLPRep(FamilyObj(g.1),[[]]);
<identity ...>
gap> g.1^0=one;
true
gap> g.1*g.1^-1;
<identity ...>
gap> x := g.1*g.2;; y := g.2^-1*g.1;;
gap> x*y; 
f1^2
gap>x<y;
false
gap>x<x;
false
gap> x:=g.1*g.2;; y=g.1;;
gap> x<y;
false 
gap> x:=g.1^-1*g.2;; y=g.2^-2;;
gap>x<y;
true