#
# gapslp: SLP for free groups
#
# Implementations 
#
#############################################################################
##Création d'une fonction sous-mot 

InstallOtherMethod(Subword, [ IsAssocWord and IsSLPAssocWordRep, IsPosInt, IsInt ],0,function(w,o,l)
	local c,
		  x,
	      n,
		  i,
		  j,
		  s,
		  k,
		  T,
		  ng,
		  fin,
		  m,
		  r,
		  debut;
	
	
	#Initialisation
	c:=0;
	r:=[];
	fin:=[];
	i:=o-1;
	x:=w![1];
	n:=Length(x);
	debut:=[];
	s:=1;
	ng:= FamilyObj(w)!.SLPrank;
	T:=SubLengths(w);
	if o>l then 
		return(AssocWordBySLPRep(FamilyObj(w),[[]]));
	fi;
	if EstVide(w) then 
		return(AssocWordBySLPRep(FamilyObj(w),[]));
	fi;
	
	#Si on commence à 0 
	if i=0 then 
		for k in [Length(x[n])-1,Length(x[n])-3..1] do
				Add(debut,x[n][k]);
				Add(debut,x[n][k+1]);
		od;
	fi;
	
	#Travail pour le debut
	while c<>i and n>0 do
		if s>0 then 
			j:=1;
			while c<i and j<Length(x[n]) do                   #On parcourt grossièrement la liste 
			c:=c+T[x[n][j]]*AbsInt(x[n][j+1]);
			j:=j+2;
			od;
			if c<l then 
				for k in [Length(x[n])-1,Length(x[n])-3..j] do    #On récupère la partie de la liste qui nous intéresse (à l'enver) sans prendre l'élément de travail
					Add(debut,x[n][k]);
					Add(debut,x[n][k+1]*s);
				od;
			fi;
		elif s<0 then 
			j:=Length(x[n])-1;
			while c<i and j>0 do                              #On parcourt grossièrement la liste 
			c:=c+T[x[n][j]]*AbsInt(x[n][j+1]);
			j:=j-2;
			od;
			if c<l then
				for k in [1,3..j] do #On récupère la partie de la liste qui nous intéresse (à l'enver) sans prendre l'élément de travail
					Add(debut,x[n][k]);
					Add(debut,x[n][k+1]*s);
				od;
			fi;
		fi;
		if s>0 and j-2>0 then 
				j:=j-2;
		elif s<0 and j+2<Length(x[n]) then 
				j:=j+2;
		fi;
		if AbsInt(x[n][j+1])<>1 and c<>i then                #Si la puissance est différente de -1 ou 1 on affine la sélection 
			c:= c-T[x[n][j]]*AbsInt(x[n][j+1]);
			k:=0;
			while c<i do 
				c:=c+T[x[n][j]];
				k:=k+1;
			od;
			if c<>i then 
				if AbsInt(x[n][j+1])-k <>0 then				#Si on garde une partie des puissance on l'ajoute à la fin de la liste 
					if c<=l then 
						Add(debut,x[n][j]);
						Add(debut,(AbsInt(x[n][j+1])-k)*SignInt(x[n][j+1])*s);
					fi;
					s:=s*SignInt(x[n][j+1]);
					c:=c-T[x[n][j]];
					n:=x[n][j]-ng;
								
				else                                        #Dans tous les cas on met à jour n et s pour recommencer la boucle 
					s:=s*SignInt(x[n][j+1]);
					c:=c-T[x[n][j]];
					n:=x[n][j]-ng;
				fi;
			else
				if c<=l then 
					Add(debut,x[n][j]);
					Add(debut,(AbsInt(x[n][j+1])-k)*SignInt(x[n][j+1])*s);
				fi;
				s:=s*SignInt(x[n][j+1]);
				c:=c-T[x[n][j]];
				n:=x[n][j]-ng;
			fi;
		elif AbsInt(x[n][j+1])=1 and c<>i then             #on met à jour n et s pour recommencer la boucle
			s:=s*SignInt(x[n][j+1]);
			c:=c-T[x[n][j]];
			n:=x[n][j]-ng;
		fi;
	od;
	
	m:=0;
	for k in [1,3..Length(debut)-1] do
		m:=m+T[debut[k]]*AbsInt(debut[k+1]);
	od;
	m:=m+i-l;
	
	
	n:=Length(x);
	c:=0;
	s:=(-1);
	
	
	while c<>m and n>0 do
		if n=Length(x) then 
			if s<0 then 
				j:=1;
				while c<m and j<Length(debut) do                   #On parcourt grossièrement la liste 
					c:=c+T[debut[j]]*AbsInt(debut[j+1]);
					j:=j+2;
					od;
					for k in [Length(debut)-1,Length(debut)-3..j] do    #On récupère la partie de la liste qui nous intéresse (à l'enver) sans prendre l'élément de travail
						Add(r,debut[k]);
						Add(r,debut[k+1]*s);
					od;
					
			elif s>0 then 
				j:=Length(debut)-1;
				while c<m and j>0 do                              #On parcourt grossièrement la liste 
				c:=c+T[debut[j]]*AbsInt(debut[j+1]);
				j:=j-2;
				od;
				for k in [1,3..j] do #On récupère la partie de la liste qui nous intéresse (à l'enver) sans prendre l'élément de travail
					Add(r,debut[k]);
					Add(r,debut[k+1]*s);
				od;
			fi;
		if s<0 and j-2>0 then 
				j:=j-2;
		elif s>0 and j+2<Length(debut) then 
				j:=j+2;
		fi;
			
			if AbsInt(debut[j+1])<>1 and c<>m then                #Si la puissance est différente de -1 ou 1 on affine la sélection 
				c:= c-T[debut[j]]*AbsInt(debut[j+1]);
				k:=0;
				while c<m do 
					c:=c+T[debut[j]];
					k:=k+1;
				od;

				if c<>m then 
					if AbsInt(debut[j+1])-k <>0 then				#Si on garde une partie des puissance on l'ajoute à la fin de la liste 
						Add(r,debut[j]);
						Add(r,(AbsInt(debut[j+1])-k)*SignInt(debut[j+1])*s);
						s:=s*SignInt(debut[j+1]);
						c:=c-T[debut[j]];
						n:=debut[j]-ng;
								
					else                                        #Dans tous les cas on met à jour n et s pour recommencer la boucle 
						s:=s*SignInt(debut[j+1]);
						c:=c-T[debut[j]];
						n:=debut[j]-ng;
					fi;
				else
					Add(r,debut[j]);
					Add(r,(AbsInt(debut[j+1])-k)*SignInt(debut[j+1])*s);
					s:=s*SignInt(debut[j+1]);
					c:=c-T[debut[j]];
					n:=debut[j]-ng; 
				fi;
			elif AbsInt(debut[j+1])=1 and c<>m then             #on met à jour n et s pour recommencer la boucle
				s:=s*SignInt(debut[j+1]);
				c:=c-T[debut[j]];
				n:=debut[j]-ng;
			fi;

		else 
			if s>0 then 
				j:=1;
				while c<m and j<Length(x[n]) do                   #On parcourt grossièrement la liste 
				c:=c+T[x[n][j]]*AbsInt(x[n][j+1]);
				j:=j+2;
				od;
				for k in [Length(x[n])-1,Length(x[n])-3..j] do    #On récupère la partie de la liste qui nous intéresse (à l'enver) sans prendre l'élément de travail
					Add(r,x[n][k]);
					Add(r,x[n][k+1]*s);
				od;
			elif s<0 then 
				j:=Length(x[n])-1;
				while c<m and j>0 do                              #On parcourt grossièrement la liste 
				c:=c+T[x[n][j]]*AbsInt(x[n][j+1]);
				j:=j-2;
				od;
				for k in [1,3..j] do #On récupère la partie de la liste qui nous intéresse (à l'enver) sans prendre l'élément de travail
					Add(r,x[n][k]);
					Add(r,x[n][k+1]*s);
				od;
			fi;
			if s>0 and j-2>0 then 
				j:=j-2;
			elif s<0 and j+2<Length(x[n]) then 
				j:=j+2;
			fi;
			if AbsInt(x[n][j+1])<>1 and c<>m then                #Si la puissance est différente de -1 ou 1 on affine la sélection 
				c:= c-T[x[n][j]]*AbsInt(x[n][j+1]);
				k:=0;
				while c<m do 
					c:=c+T[x[n][j]];
					k:=k+1;
				od;
				if c<>m then 
					if AbsInt(x[n][j+1])-k <>0 then				#Si on garde une partie des puissance on l'ajoute à la fin de la liste 
						Add(r,x[n][j]);
						Add(r,(AbsInt(x[n][j+1])-k)*SignInt(x[n][j+1])*s);
						s:=s*SignInt(x[n][j+1]);
						c:=c-T[x[n][j]];
						n:=x[n][j]-ng;
					else                                        #Dans tous les cas on met à jour n et s pour recommencer la boucle 
						s:=s*SignInt(x[n][j+1]);
						c:=c-T[x[n][j]];
						n:=x[n][j]-ng;
					fi;
				else
					Add(r,x[n][j]);
					Add(r,(AbsInt(x[n][j+1])-k)*SignInt(x[n][j+1])*s);
					s:=s*SignInt(x[n][j+1]);
					c:=c-T[x[n][j]];
					n:=x[n][j]-ng;
				fi;
			elif AbsInt(x[n][j+1])=1 and c<>m then             #on met à jour n et s pour recommencer la boucle
				s:=s*SignInt(x[n][j+1]);
				c:=c-T[x[n][j]];
				n:=x[n][j]-ng;
			fi;
		fi;
	od;
	
	
	if m=0 then 
		if Length(debut)>=4 then 
			if s<0 then 
				for k in [Length(debut)-1,Length(debut)-3..1] do
					Add(r,debut[k]);
					Add(r,debut[k+1]);
				od;
			else 
				for k in [1,3..Length(debut)-1] do
					Add(r,debut[k]);
					Add(r,debut[k+1]*(-1));
				od;
			fi;
		else 
		Add(r,debut[1]);
		Add(r,debut[2]*s*(-1));
		fi;
		for k in [1..Length(x)-1] do 
			Add(fin,x[k]);
		od;
		Add(fin,r);
	else 
		debut:=[];
		for k in [1,3..Length(r)-1] do
			Add(debut,r[k]);
			Add(debut,r[k+1]*(-1));
		od;
		for k in [1..Length(x)-1] do 
			Add(fin,x[k]);
		od;
		Add(fin,debut);
	fi;

	return(AssocWordBySLPRep(FamilyObj(w),fin));	
	end);
	
###################################################################
##Fonction égalité

Equality:= function(x,y,D,s)
	local x2,
		  y2,
		  x1,
		  y1,
		  e1,
		  e2,
		  n,
		  m,
		  lx,
		  ly,
		  B1,
		  B2;
		  
	#Initialisation
	n:= Length(x);
	m:=Length(y);	
	lx:=LetterRepAssocWord(x);
	ly:=LetterRepAssocWord(y);
	if n<>m then 
		return false;
	elif n=1 then
		lx:=LetterRepAssocWord(x);
		ly:=LetterRepAssocWord(y);
		AddDictionary(D,[1+s,1+s],lx[1]=ly[1]);
		return lx=ly;
	else 
		x1 := Subword(x,1,Int(n/2));
		x2 := Subword(x,Int(n/2)+1,n);
		y1 := Subword(y,1,Int(m/2));
		y2 := Subword(y,Int(m/2)+1,m);
		B1 :=LookupDictionary(D,[1+s,Int(n/2)+s]);
		B2 :=LookupDictionary(D,[Int(n/2)+s,n+s]);
		
		if B1<> fail then 
			if B2<>fail then 
				return B1 and B2;
			else 
				e2:=Equality(x2,y2,D,s+Int(n/2));
				AddDictionary(D,[Int(n/2)+1+s,n+s],e2);
				return e2 and B1;
			fi;
		else 
			e1:=Equality(x1,y1,D,s);
			AddDictionary(D,[1+s,Int(n/2)+s],e1);
			if B2<>fail then 
				return e1 and B2;
			else
				e2:=Equality(x2,y2,D,s+Int(n/2));
				AddDictionary(D,[Int(n/2)+s+1,n+s],e2);
				return e1 and e2;
			fi;
		fi;
	fi;
	end;

InstallMethod(\=, "for SLP words", IsIdenticalObj,
	[IsAssocWord and IsSLPAssocWordRep,IsAssocWord and IsSLPAssocWordRep],
	function(x,y)
    return Equality(x,y,NewDictionary([1],true),0);
end);


#################################################################################
##Prefixe 

BindGlobal("prefixe", function(w,z) 
	local n,
		  m,
		  D,
		  B,
		  a,
		  b,
		  u,
		  min,
		  max,
		  c,
		  e,
		  v;
		  
		  
	#Initialisation
	D:=NewDictionary([1,2],true);
	n:=Length(w);
	m:=Length(z);
	B:=Equality(w,z,D,0);
	
	if B then 
		return(n);
	fi;
	
	if n>m then
		max:=n;
		min:=m;
	else 
		max:=m;
		min:=n;
	fi;
	
	a:=1;
	b:=min;

	while a<>b do
			u:=Subword(w,a,b);
			v:=Subword(z,a,b);
			B:=Equality(u,v,D,0);
			if B then 
				c:=b;
				b:=b+Int((b-a)/2);
				if b>min then 
					b:=min;
				fi;
				a:=c;
			else
				b:=b-Int((b-a)/2);
			fi;
	od;
	
	u:=Subword(w,a,b);
	v:=Subword(z,a,b);
	B:=Equality(u,v,D,0);
	
	if B then 
		return(b);
	else 
		return(b-1);
	fi;
	end);

#############################################################################
## Multiplication 

InstallMethod( \*, "for two assoc. words in SLP rep", IsIdenticalObj,
    [ IsAssocWord and IsSLPAssocWordRep, 
      IsAssocWord and IsSLPAssocWordRep], 0, function(w,z)
	 
	local p,
		  u,
		  v,
		  n,
		  m,
		  d,
		  i,
		  c,
		  e,
		  r,
		  k,
		  x,
		  ng,
		  y,
		  b,
		  l,
		  t,
		  f,
		  ps,
		  s;
	 
	#Initialisation
	t:=w![1];
	r:=[];
	l:=[];
	n:=Length(t);
	ng:=FamilyObj(w)!.SLPrank;
	
	#Attention il faut prendre l'inverse....
	for k in [1..n-1] do 
		Add(r,t[k]);
	od;
	
	for k in [Length(t[n])-1,Length(t[n])-3..1] do 
		Add(l,t[n][k]);
		Add(l,-1*t[n][k+1]);
	od;
	
	Add(r,l);
	r:=AssocWordBySLPRep(FamilyObj(w),r);
	n:=Length(w);
	m:=Length(r);
	
	p:=prefixe(w,r);
	Print(p);
	u := Subword(w,1,n-p);
	v := Subword(z,p+1,m);
	d:=NewDictionary(1,true);
	e:=NewDictionary(1,true);
	r:=[];
	s:=[];
	
	x:=u![1];
	y:=v![1];
	n:=Length(x);
	m:=Length(y);
	AddDictionary(d,n+ng,true);
	
	for k in [1..ng] do 
		AddDictionary(d,k,true);
		AddDictionary(e,k,k);
	od;
	
	for k in [n..1] do
		if LookupDictionary(d,k+ng) then 
			Print("OKvrai");
			for i in [1,3..Length(x[k])-1] do 
				Print("OK");
				if LookupDictionary(d,x[k][i])=fail then 
					AddDictionary(d,x[k][i],true);
				fi;
			od;
		fi;
	od;
	
	c:=ng+1;
	for k in [1..n-1] do
		if LookupDictionary(d,k+ng) then 
			AddDictionary(e,k,c);
			c:=c+1;
			l:=[];
			for i in [1,3..Length(x[k])-1] do 
				b:=LookupDictionary(e,x[k][i]);
				if b<>fail then 
					Add(l,b);
					Add(l,x[k][i+1]);
				fi;
			od;
			Add(r,l);
		fi;
	od;
	###########Renumérotation....
	
	f:=LookupDictionary(e,x[n][1]);
	ps:=x[n][2];
	while k<Length(x[n])-1 do 
		if f=LookupDictionary(e,x[n][k]) then 
			ps:=ps+x[n][k+1];
			k:=k+2;
			Print("oooooo");
		else 
			Add(s,f);
			Add(s,ps);
			f:=LookupDictionary(e,x[n][k]);
			ps:=x[n][k+1];
			k:=k+2;
			Print("aaaaaaaaaaaaa");
		fi;
	od;
	Print(f,ps);
	d:=NewDictionary(1,true);
	e:=NewDictionary(1,true);
	
	for k in [1..ng] do 
		AddDictionary(d,k,true);
		AddDictionary(e,k,k);
	od;
	
	AddDictionary(d,n+ng,true);
	
	for k in [m..1] do
		if LookupDictionary(d,k+ng) then 
			for i in [1,3..Length(y[k])-1] do 
				if LookupDictionary(d,y[k][i])=fail then 
					AddDictionary(d,y[k][i],true);
				fi;
			od;
		fi;
	od;
	c:=1;
	for k in [1..m-1] do 
		if LookupDictionary(d,k+ng) then 
			AddDictionary(e,k+ng,c);
			c:=c+1;
			l:=[];
			for i in [1,3..Length(y[k])-1] do 
				b:=LookupDictionary(e,y[k][i]);
				if b<>fail then 
					Add(l,b);
					Add(l,y[k][i+1]);
				fi;
			od;
			Add(r,l);
		fi;
	od;
	Print(r);
	#finir de remplir intelligent
	k:=1;
	Print(f,y);
	while k<=Length(y[m])-1 do 
		if f=LookupDictionary(e,y[m][k]) then 
			Print("OKnul");
			ps:=ps+y[m][k+1];
			k:=k+2;
		else 
			Print("OKOK");
			Add(s,f);
			Add(s,ps);
			f:=LookupDictionary(e,y[n][k]);
			ps:=y[m][k+1];
			k:=k+2;
		fi;
	od;
	Print(f,ps);
	Add(s,f);
	Add(s,ps);
	Add(r,s);
	return(AssocWordBySLPRep(FamilyObj(w),r));
	end);
	
