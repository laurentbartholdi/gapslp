gap> g := FreeGroup(2);
<free group on the generators [ f1, f2 ]>
gap> f := FreeGroup(IsSLPWordsFamily,2);
<free group on the generators [ f1, f2 ]>
gap> t:=AssocWordBySLPRep(FamilyObj(f.1),[[2,2],[3,3,2,4],[4,1,1,1],[5,3,2,14]]);
(_1:=f2^2;_2:=_1^3*f2^4;_3:=_2*f1;_3^3*f2^14)
gap> tt := AssocWordByLetterRep(FamilyObj(g.1),LetterRepAssocWord(t));
(f2^10*f1)^3*f2^14
gap> Subword(tt,38,3);
<identity ...>
gap> fibo := function(f,n) local p, i; p := []; for i in [1..n] do Add(p,[i,1,i+1,1]); od; return AssocWordBySLPRep(f,p); end;;
gap> f5 := fibo(FamilyObj(f.1),5);
(_1:=f1*f2;_2:=f2*_1;_3:=_1*_2;_4:=_2*_3;_3*_4)
gap> f25 := fibo(FamilyObj(f.1),25);;
gap> Length(f25);
196418
gap> last=Length(LetterRepAssocWord(f25));
true
gap> ForAll(Combinations([0..Length(f25)],2),c->LetterRepAssocWord(Subword(f5,c[1]+1,c[2]))=LetterRepAssocWord(f5){[c[1]+1..c[2]]});
true

gap>fibo := function(f,n) local p, i; p := []; for i in [1..n] do Add(p,[i,1,i+1,1]); od; return AssocWordBySLPRep(f,p); end;;
gap>f25 := fibo(FamilyObj(f.1),10);;
gap>ForAll(Combinations([0..Length(f25)],2),c->LetterRepAssocWord(Subword(f25,c[1]+1,c[2]))=LetterRepAssocWord(f25){[c[1]+1..c[2]]});
true 

gap>fibo := function(f,n) local p, i; p := []; for i in [1..n] do Add(p,[i,1,i+1,-1]); od; return AssocWordBySLPRep(f,p); end;;
gap>f25 := fibo(FamilyObj(f.1),10);;
gap>ForAll(Combinations([0..Length(f25)],2),c->LetterRepAssocWord(Subword(f25,c[1]+1,c[2]))=LetterRepAssocWord(f25){[c[1]+1..c[2]]});
true


gap>fibo := function(f,n) local p, i; p := []; for i in [1..n] do Add(p,[i,1,i+1,1]); od; return AssocWordBySLPRep(f,p); end;;
gap>f25 := fibo(FamilyObj(f.1),5);;
gap>ForAll(Combinations([0..Length(f25)],2),c->LetterRepAssocWord(Subword(f25,c[1]+1,c[2]))=LetterRepAssocWord(f25){[c[1]+1..c[2]]});
true 

gap>fibo := function(f,n) local p, i; p := []; for i in [1..n] do Add(p,[i,1,i+1,-1]); od; return AssocWordBySLPRep(f,p); end;;
gap>f25 := fibo(FamilyObj(f.1),5);;
gap>ForAll(Combinations([0..Length(f25)],2),c->LetterRepAssocWord(Subword(f25,c[1]+1,c[2]))=LetterRepAssocWord(f25){[c[1]+1..c[2]]});
true 

gap>long := function(f,n) 
	local p,q,j,i; 
	p := []; 
	for i in [1..n] do 
		q:=[];
		for j in [1..i] do
			Add(q,j);
			Add(q,5);
		od;
		Add(p,q); 
	od; 
	return AssocWordBySLPRep(f,p); 
	end;;
gap>f25 := long(FamilyObj(f.1),5);;
gap>ForAll(Combinations([0..Length(f25)],2),c->LetterRepAssocWord(Subword(f25,c[1]+1,c[2]))=LetterRepAssocWord(f25){[c[1]+1..c[2]]});
true 

############################################
##Test produit 
gap>f := FreeGroup(IsSLPWordsFamily,2);
gap>fibo := function(f,n) local p, i; p := []; for i in [1..n] do Add(p,[i,1,i+1,-1]); od; return AssocWordBySLPRep(f,p); end;;
gap>f25 := fibo(FamilyObj(f.1),5);;
gap>ForAll(Combinations([0..Length(f25)],2),c->LetterRepAssocWord(Subword(f25,c[1]+1,c[2])*Subword(f25,c[1]+1,c[2]))=LetterRepAssocWord(Subword(f25,c[1]+1,c[2])*Subword(f25,c[1]+1, c[2])));
true 

gap>fibo := function(f,n) local p, i; p := []; for i in [1..n] do Add(p,[i,1,i+1,-1]); od; return AssocWordBySLPRep(f,p); end;;
gap>f25 := fibo(FamilyObj(f.1),5);;
gap>ForAll(Combinations([0..Length(f25)-2],2),c->LetterRepAssocWord(Subword(f25,c[1]+1,c[2])*Subword(f25,c[1]+2,c[2]+1))=LetterRepAssocWord(Subword(f25,c[1]+1,c[2])*Subword(f25,c[1]+2, c[2]+1)));
true

gap>long := function(f,n) 
	local p,q,j,i; 
	p := []; 
	for i in [1..n] do 
		q:=[];
		for j in [1..i] do
			Add(q,j);
			Add(q,5);
		od;
		Add(p,q); 
	od; 
	return AssocWordBySLPRep(f,p); 
	end;;
gap>f25 := long(FamilyObj(f.1),5);;
gap>ForAll(Combinations([0..Length(f25)-2],2),c->LetterRepAssocWord(Subword(f25,c[1]+1,c[2])*Subword(f25,c[1]+2,c[2]+1))=LetterRepAssocWord(Subword(f25,c[1]+1,c[2])*Subword(f25,c[1]+2, c[2]+1)));
true 
gap> time;
2117907

######################################################
##Test puissance 

gap>f := FreeGroup(IsSLPWordsFamily,2);;

gap>fibo := function(f,n) local p, i; p := []; for i in [1..n] do Add(p,[i,1,i+1,1]); od; return AssocWordBySLPRep(f,p); end;;
gap>f25 := fibo(FamilyObj(f.1),15);;
gap>ForAll(Combinations([0..Length(f25)],2),c->LetterRepOfAssocWord(Subword(f25,c[1]+1,c[2])^3)=Subword(LetterRepOfAssocWord(f25),c[1]+1,c[2])^3);
true

gap>fibo := function(f,n) local p, i; p := []; for i in [1..n] do Add(p,[i,1,i+1,1]); od; return AssocWordBySLPRep(f,p); end;;
gap>long := function(f,n) 
	local p,q,j,i; 
	p := []; 
	for i in [1..n] do 
		q:=[];
		for j in [1..i] do
			Add(q,j);
			Add(q,5);
		od;
		Add(p,q); 
	od; 
	return AssocWordBySLPRep(f,p); 
	end;;
gap>ForAll(Combinations([0..Length(f25)],2),c->LetterRepOfAssocWord(Subword(f25,c[1]+1,c[2])^3)=Subword(LetterRepOfAssocWord(f25),c[1]+1,c[2])^3);
true