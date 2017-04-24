gap> g := FreeGroup(2);
<free group on the generators [ f1, f2 ]>
gap> f := FreeGroup(IsSLPWordsFamily,2);
<free group on the generators [ f1, f2 ]>
gap> t := AssocWordBySLP(FamilyObj(f.1),[[2,2],[3,3,2,4],[4,1,1,1],[5,3,2,14]]);
(_1:=f2^2;_2:=_1^3*f2^4;_3:=_2*f1;_3^3*f2^14)
gap> tt := AssocWordByLetterRep(FamilyObj(g.1),LetterRepAssocWord(t));
(f2^10*f1)^3*f2^14
gap> Subword(tt,38,3);
<identity ...>
gap> fibo := function(f,n) local p, i; p := []; for i in [1..n] do Add(p,[i,1,i+1,1]); od; return AssocWordBySLP(f,p); end;;
gap> f5 := fibo(FamilyObj(f.1),5);
(_1:=f1*f2;_2:=f2*_1;_3:=_1*_2;_4:=_2*_3;_3*_4)
gap> f8 := fibo(FamilyObj(f.1),8);;
gap> f25 := fibo(FamilyObj(f.1),25);;
gap> Length(f25);
196418
gap> Length(LetterRepAssocWord(f25));
196418
gap> Filtered(Combinations([0..Length(f5)],2),c->LetterRepAssocWord(Subword(f5,c[1]+1,c[2]))<>LetterRepAssocWord(f5){[c[1]+1..c[2]]});
[  ]
gap> Filtered(Combinations([0..Length(f8)],2),c->LetterRepAssocWord(Subword(f8,c[1]+1,c[2]))<>LetterRepAssocWord(f8){[c[1]+1..c[2]]});
[  ]
gap> long := function(f,n)
> 	local p,q,j,i; 
> 	p := []; 
> 	for i in [1..n] do 
> 		q:=[];
> 		for j in [1..i] do
> 			Add(q,j);
> 			Add(q,5);
> 		od;
> 		Add(p,q); 
> 	od; 
> 	return AssocWordBySLP(f,p); 
> 	end;;
gap> l3 := long(FamilyObj(f.1),3);;
gap> Filtered(Combinations([0..Length(l3)],2),c->LetterRepAssocWord(Subword(l3,c[1]+1,c[2]))<>LetterRepAssocWord(l3){[c[1]+1..c[2]]});
[  ]

############################################
##Test produit 
gap> Filtered(Combinations([0..Length(f5)],2),c->AsLetterRepAssocWord(Subword(f5,c[1]+1,c[2])*Subword(f5,c[1]+1,c[2]))<>AsLetterRepAssocWord(Subword(f5,c[1]+1,c[2]))*AsLetterRepAssocWord(Subword(f5,c[1]+1,c[2])));
[  ]
gap> Filtered(Combinations([0..Length(l3)-2],2),c->AsLetterRepAssocWord(Subword(l3,c[1]+1,c[2])*Subword(l3,c[1]+2,c[2]+1))<>AsLetterRepAssocWord(Subword(l3,c[1]+1,c[2]))*AsLetterRepAssocWord(Subword(l3,c[1]+2,c[2]+1)));
[  ]

######################################################
##Test puissance 
gap> Filtered(Combinations([0..Length(f8)],2),c->AsLetterRepAssocWord(Subword(f8,c[1]+1,c[2])^3)<>Subword(AsLetterRepAssocWord(f8),c[1]+1,c[2])^3);
[  ]
gap> Filtered(Combinations([0..Length(l3)],2),c->AsLetterRepAssocWord(Subword(l3,c[1]+1,c[2])^3)<>Subword(AsLetterRepAssocWord(l3),c[1]+1,c[2])^3);
[  ]