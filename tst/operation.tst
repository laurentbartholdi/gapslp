
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
gap> x<y;
true
gap> x<x;
false
gap> x:=g.1*g.2;; y:=g.1;;
gap> x<y;
false
gap> x:=g.1^-1*g.2;; y:=g.2^-2;;
gap> x<y;
true
gap> fibo := function(f,n) local p, i; p := []; for i in [1..n] do Add(p,[i,1,i+1,1]); od; return AssocWordBySLPRep(f,p); end;;
gap> f5 := fibo(FamilyObj(g.1),5);;
gap> w12:= Subword(f5,1,2);
(_1:=f1*f2;_2:=f2*_1;_3:=_1*_2;_4:=_2*_3;_1)
gap> LetterRepOfAssocWord(w12);
f1*f2
gap> LetterRepOfAssocWord(w12*w12);
(f1*f2)^2
gap> LetterRepOfAssocWord(w12)*LetterRepOfAssocWord(w12);
(f1*f2)^2
gap> g := FreeGroup(IsSLPWordsFamily,2);
<free group on the generators [ f1, f2 ]>
gap> test1 := function(w)
> local r,i,j;
> for i in [1..Length(w)] do 
> 	for j in [1..Length(w)]do 
> 		r:=Subword(w,i,j);
> 		if LetterRepOfAssocWord(r*r)<>LetterRepOfAssocWord(r)*LetterRepOfAssocWord(r) then
> 			return false;
> 		fi;
> 	od;
> od;
> return(true);
> end;;
gap> test1(f5);
true
gap> LengthOfMaximalCommonPrefix(g.1^0,f5);
0
gap> test2 := function(w)
> 		local r,s,i,j,k,l;
> 		for i in [1..3] do 
> 			for j in [1..3]do 
> 				for k in [1..3] do 
> 					for l in [1..3]do
> 						r:=Subword(w,i,j);
> 						s:=Subword(w,k,l);
> 						if LetterRepOfAssocWord(r*s)<>LetterRepOfAssocWord(r)*LetterRepOfAssocWord(s) then
> 							Display(r);
> 							Display(s);
> 							return false;
> 						fi;
> 					od;
> 				od;
> 			od;
> 		 od;
> 		 return(true);
> 		 end;;
gap> test2(f5);
true
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
gap> test2(l3);
true
gap> test3 := function(w)
> 	local r,i,j,a;
> 	for i in [1..Length(w)] do 
> 		for j in [1..Length(w)]do 
>       	for a in [-3..3] do 
> 				r:=Subword(w,i,j);
> 				if LetterRepOfAssocWord(r^a)<>LetterRepOfAssocWord(r)^a then
> 					return false;
> 				fi;
> 			od;
> 		od;
> 	od;
> 	return(true);
> 	end;;
gap> test3(f5);
true
gap> test3(l3);
true
gap> test4 := function(w)
> 	local r,s,i,j,k,l,A,B;
> 	for i in [1..3] do 
> 		for j in [1..3]do 
> 			for k in [1..3] do 
> 				for l in [1..3]do
> 					r:=Subword(w,i,j);
> 					s:=Subword(w,k,l);
> 					A:=(r<s);
> 					B:=(LetterRepOfAssocWord(r)<LetterRepOfAssocWord(s));
> 					if A<>B then
> 						Print(r,s);
> 						return false;
> 					fi;
> 				od;
> 			od;
> 		od;
> 	 od;
> 	return(true);
> 	end;;
gap> test4(f5);
true
gap> test4(l3);
true 