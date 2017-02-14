gap> f:=FreeGroup(IsSLPWordsFamily,2);;
gap> x:=AssocWordBySLPRep(FamilyObj(f.1),[[1,2,2,3,1,2,1,2]]);
f1^2*f2^3*f1^2*f1^2
gap> y:=AssocWordBySLPRep(FamilyObj(f.1),[[1,2,1,3,2,2,1,2]]);
f1^2*f1^3*f2^2*f1^2
gap>x*y;
f1^2*f2^3*f1^9*f2^2*f1^2
gap> x^2;
f1^2*f2^3*f1^6*f2^3*f1^4
gap> ReversedOp(x);
f1^2*f1^2*f2^3*f1^2
gap> Length(x);
9
gap> x^-2;
f1^-4*f2^-3*f1^-6*f2^-3*f1^-2

liste:=function(n)
local r,k;
r:=[];
for k in [1..n] do 
	if k mod 2 = 0 then 
		Add(r,2);
		Add(r,2);
	else 
		Add(r,2);
		Add(r,1);
	fi;
od;
return(AssocWordBySLPRep(FamilyObj(f.1),[r]));
end;
	
gap> x:=liste(2000);;
gap> y:=liste(2500);;
gap> time;
563

gap> x:=liste(20000);;
gap> y:=liste(25000);;
gap> time;
59156

#On a multiplié par 10 on multiplie le temps par 100. 