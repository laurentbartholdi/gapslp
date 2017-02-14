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
