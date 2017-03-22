gap> g := FreeGroup(IsSLPWordsFamily,2);;
gap> fibo := function(f,n) local p, i; p := []; for i in [1..n] do Add(p,[i,1,i+1,1]); od; return AssocWordBySLPRep(f,p); end;;
gap> f5 := fibo(FamilyObj(g.1),5);;
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
> 	return AssocWordBySLPRep(f,p); 
> 	end;;
gap> l3 := long(FamilyObj(g.1),3);;
gap> test3 := function(w)
> 	local r,i,j;
> 	for i in [1..Length(w)] do 
> 		for j in [1..Length(w)]do 
> 			r:=Subword(w,i,j);
> 			if SyllableRepAssocWord(r)<>LetterRepOfAssocWord(r) then
> 				return false;
> 			fi;
> 		od;
> 	od;
> 	return(true);
> 	end;;
gap> test3(f5);
true
gap> test3(l3);
true
gap> test4 := function(w)
> 	local r,i,j,A,B;
> 	for i in [1..Length(w)] do 
> 		for j in [1..Length(w)]do 
> 			A:=SyllableRepAssocWord(CyclicallyReducedWord(Subword(w,i,j)));
> 			B:=CyclicallyReducedWord(SyllableRepAssocWord(Subword(w,i,j)));
> 			if A<>B then
> 				return false;
> 			fi;
> 		od;
> 	od;
> 	return(true);
> 	end;;
gap> test4(f5);
true
gap> test4(l3);
true