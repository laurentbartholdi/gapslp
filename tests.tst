gap> f:=FreeGroup(IsSLPWordsFamily,2);
<free group on the generators [ f1, f2 ]>
gap> t:= AssocWordBySLP(FamilyObj(f.1),[[1,2,1,-2]]);
f1^2*f1^-2
gap> h:= AssocWordBySLP(FamilyObj(f.1),[[2,2],[1,3],[1,2,1,3],[5,2,3,5],[3,1,4,1],[3,1,4,1],[1,1]]);
(_1:=f2^2;_2:=f1^3;_3:=f1^2*f1^3;_4:=_3^2*_1^5;_5:=_1*_2;_6:=_1*_2;f1)
gap> l:=[3,10,3,-6,3,-4,2,3,2,-3];
[ 3, 10, 3, -6, 3, -4, 2, 3, 2, -3 ]

gap> y:=AssocWordBySLP(FamilyObj(f.1),[[2,2],[1,3],[3,-13,4,1],[5,25,4,-1]]);
(_1:=f2^2;_2:=f1^3;_3:=_1^-13*_2;_3^25*_2^-1)
gap> AsLetterRepAssocWord(y);
(f2^-26*f1^3)^25*f1^-3
gap> x:=Subword(y,2,2);
(_1:=f2^2;_2:=f1^3;_3:=_1^-13*_2;f2^-1)
gap> AsLetterRepAssocWord(x);
f2^-1
