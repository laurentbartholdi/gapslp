gap> g := FreeGroup(2);
<free group on the generators [ f1, f2 ]>
gap> f := FreeGroup(IsSLPWordsFamily,2);
<free group on the generators [ f1, f2 ]>
gap> t:=AssocWordBySLPRep(FamilyObj(f.1),[[2,2],[3,3,2,4],[4,1,1,1],[5,3,2,14]]);
_1:=f2^2;_2:=_1^3*f2^4;_3:=_2*f1;_3^3*f2^14
gap> tt := AssocWordByLetterRep(FamilyObj(g.1),LetterRepAssocWord(t));
f2^10*f1*f2^10*f1*f2^10*f1*f2^14
gap> Subword(tt,38,3);
<identity ...>
gap> Subword(t,38,3);
<identity ...>
