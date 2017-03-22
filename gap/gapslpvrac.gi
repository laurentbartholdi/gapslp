#
# gapslp: SLP for free groups
#
# Implementations 
#


################################################################
SimplifieListe := function(x)
	local p, #premier
		  d, #dernier
		  ed,
		  ep,
		  bool,
		  l,
		  n;
	#Initialisation
	l:=[];	  
	bool:=true;
	

		#Supposé non vide 	  
		if x=[] then 
			return(x);
		fi;
	
		p:=1;
		d:=3;
		ep:=x[p+1];
		n:=Length(x); 
		l:=[];
	
		while 0<p and d<n do 
			ed:=x[d+1];
			bool:=true;
			if x[p]=x[d] then 
				if ep+ed<>0 then 
					ep:=ep+ed;
					Print(ep);
					d:=d+2;
				else
					if p-2>0 and l<>[] then 
						p:=p-2;
						ep:=l[Length(l)];
						d:=d+2;
						Remove(l,Length(l));
						Remove(l,Length(l));
					elif d+2<n then 
						p:=d+2;
						ep:=x[p+1];
						d:=d+4;
					else 
						d:=n;
						bool:=false;
					fi;
				fi;
			else 
				Add(l,x[p]);
				Add(l,ep);
				p:=d;
				ep:=x[d+1];
				d:=d+2;
			fi;
		od;
		if bool then 
			Add(l,x[p]);
			Add(l,ep);	
		fi;
		
	return l;
 
	end;
	
###################################################################
##Fonctions qui simplifient un mot(à supprimer)

ReduceWord := function(w)
	local x,#Liste de SLP
		  ng,#Nb de générateurs 
		  n, #Longueur de x
		  r, #Liste résultat travail
		  l, #Liste de travail
		  d, #renumérotation
		  i,
		  v,
		  bool, 
		  j; #indice qui parcourt 
			
	#Initialisation
	x:=ShallowCopy(w![1]);
	ng:=FamilyObj(w)!.SLPrank;
	r:=[];
	n:=Length(x);
	l:=[];
	d:=NewDictionary(1,true) ; 
	v:=NewDictionary(1,true) ; 
	AddDictionary(v,Length(x),1);
	
	#liste non vide 
	for i in [n,n-1..1] do
		if LookupDictionary(v,i)<>fail then
			for j in [1,3..Length(x[i])-1] do 
				if x[i][j]>ng and LookupDictionary(v,x[i][j]-ng)=fail then
					AddDictionary(v,x[i][j]-ng,1);
				fi;
			od;
		fi;
	od;
		
	#On supprime les listes en double
	for i in [1..n] do
		l:=[];
		if LookupDictionary(v,i)=1 then
			for j in [1,3..Length(x[i])-1] do 
				if x[i][j]<=ng then
					Add(l,x[i][j]);
					Add(l,x[i][j+1]);
				elif LookupDictionary(d,x[i][j]-ng)<>fail then 
					Add(l,LookupDictionary(d,x[i][j]-ng));
					Add(l,x[i][j+1]);
				fi;
			od;
			
			bool:=true;
			for j in [1..Length(r)] do
				if l=r[j] then 
					AddDictionary(d,i,j+ng);
					bool:=false;
				fi;
			od;
			if bool then 
				Add(r,l);
				AddDictionary(d,i,Length(r)+ng);
			fi;
		fi;
	od;

	return r;
	
    end;



#########################################################################
#MULTIPLIER DEUX MOTS (fonctionne)
 
InstallMethod( \*, "for two assoc. words in SLP rep", IsIdenticalObj,
    [ IsAssocWord and IsSLPAssocWordRep, 
      IsAssocWord and IsSLPAssocWordRep], 0, function(w,z)
	 
	 #On considère qu'un SLP est une liste entre crochet

	 local x, #Liste SLP
		  y, #Liste SLP
		  d, #éléments en double
		  nx,
		  ny,
		  ng,
		  i,
		  j,
		  bool,
		  m,
		  o,
		  max,
		  l,
		  k,
		  r; #resultat
	
	#Initialisation 
	x:=w![1];
	y:=z![1];
	d:=[];
	r:=[];
	k:=[];
	nx:=Length(x);
	ny:=Length(y);
	ng:=FamilyObj(w)!.SLPrank;

	
	#Si une des listes est vide  
	if EstVide(w) then 
		return(z);
	fi;
	if EstVide(z) then 
		return(w);
	fi;
	
		
	for i in [1..Length(x)-1] do 
		Add(r,x[i]);
	od;

	for i in [1..Length(y)-1] do 
		l:=ShallowCopy(y[i]);
		for j in [1,3..Length(l)-1] do 
			if l[j]>ng then 
				l[j]:=d[l[j]-ng];
			fi;
		od;
		l:=SimplifieListe(l);
		bool:=true;
		for j in [1..Length(r)] do
			if l=r[j] then 
				d[i]:=j+ng;
				bool:=false;
			fi;
		od;
		if bool then 
			Add(r,l);
			d[i]:=Length(r)+ng;
		fi;
	od;
	
#Derniers termes 
	o:=SimplifieListe(x[nx]);	
	m:=o;
	for i in [1..Length(r)] do
		if o=r[i]then 
			m:=[i,1];
		else 
			m:=o;
		fi;
	od;
	
	l:=ShallowCopy(y[ny]);
	for j in [1,3..Length(l)-1] do 
		if l[j]>ng then 
			l[j]:=d[l[j]-ng];
		fi;
	od;
	bool:=true;
	l:=SimplifieListe(l);
	for j in [1..Length(r)] do
		if l=r[j] then 
			d[ny]:=j+ng;
			bool:=false;
			Add(m,j+ng);
			Add(m,1);
		fi;
	od;
	if bool then 
		for i in [1..Length(l)] do 
			Add(m,l[i]);
		od;
	fi;
	
	m:=SimplifieListe(m);
	max:=-1;
	if m<>[] then 
		for j in [1,3..Length(m)-1] do 
			if m[j]>max then 
				max:=m[j];
			fi;
		od;
		for i in [1..max-ng] do 
			Add(k,r[i]);
		od;
		Add(k,m);
	else 
		k:=[[]];
	fi;
	return Objectify(FamilyObj(w)!.SLPtype,[Immutable(k)]);
	
    end);
	
	
############################################################################
#PASSER A LA PUISSANCE 	
	
InstallMethod( \^,
    "for an assoc. word with inverse in syllable rep, and an integer",
    true,
    [ IsAssocWordWithInverse and IsSLPAssocWordRep, IsInt ], 0, function(w,a)
    
	local  	l,
			i,
			ng,
			n,
			r; #résultat
	#Initialisation
	r:=[];
	ng:=FamilyObj(w)!.SLPrank;
	l:=ShallowCopy(w![1]);
	n:=Length(l);
	
	#Si la liste est vide ATTENTION CETTE CONDITION NE SUFFIT PAS 
	if EstVide(w) then 
		return(w);
	fi;
	
	#Pour une liste non vide 
	if a<>0 then  	
		if Length(l[n])=2 then 
			for i in [1..n-1] do 
				Add(r,l[i]);
			od;
			Add(r,[l[n][1],l[n][2]*a]);
		else 	
			r:=l;
			Add(r,[Length(r)+ng,a]);
		fi;
	fi;
	
	return Objectify(FamilyObj(w)!.SLPtype,[Immutable(r)]);
    end);
	 
###################################################"

#Ecrit un mot à l'envers (à mettre à jour)
	
InstallOtherMethod( ReversedOp, "for an assoc. word in SLP rep", true,
    [ IsAssocWord and IsSLPAssocWordRep], 0,
	function( w )
	
	local x, #Liste SLP
		  r, #Résultat 
		  l, #Liste de travail
		  m, #Liste 
		  ng,#Nb de générateurs
		  n, #Length(x)
		  i, #Parcourt x
		  j; #parcourt l
	
	#Initialisation 
	x:=w![1];
	n:= Length(x);
	ng:= FamilyObj(w)!.SLPrank;
	r:=[];
	
	#On retourne les liste intermédiaires 
	for i in [1..n] do 
		m:=ShallowCopy(x[i]);
		l:=[];
		for j in [Length(m)-1,Length(m)-3..1] do 
				Add(l,m[j]);
				Add(l,m[j+1]);
		od;
		Add(r,l);
	od;
	
	r:=AssocWordBySLPRep(FamilyObj(w),r);
	return r;
 
    end);

##Si on remplace un générateur par un autre générateur (à mettre à jour)
	
InstallMethod( EliminatedWord,
  "for three associative words, SLP rep.",IsFamFamFam,
    [ IsAssocWord and IsSLPAssocWordRep, 
	IsAssocWord and IsSLPAssocWordRep, 
	IsAssocWord and IsSLPAssocWordRep ],0,
	function( w, gen, by )
	local x, #Liste SLP
		  r, #résultat 
		  l, #liste de travail 
		  n, #longueur de x
		  i,
		  j,
		  g,
		  b,
		  ng;#Nb de générateurs 
		  
	#Initialisation 
	x:=w![1];
	r:=[];
	n:=Length(x);
	ng:= FamilyObj(w)!.SLPrank;
	g:=gen![1];
	b:=by![1];
	
	for i in [1..ng] do
		Add(r,x[i]);
	od;
	for i in [ng+1..n] do 
		l:=ShallowCopy(x[i]);
		for j in [1,3..Length(l)-1] do
			if l[j]=g[Length(g)][1] then 
				
				l[j]:=b[Length(b)][1];
			fi;
		od;
	Add(r,l);
	od;
	
	r:=AssocWordBySLPRep(FamilyObj(w),r);
	return r;
 
    end);

	
	
################################################################

fin:= function(L,i,A,ng,e,T)
	local c,
		  j,
		  r,
		  k,
		  s,
		  m,
		  l,
		  f;
		  
	#Initialisation
	j:=1;
	c:=0;
	f:=[];
	r:=[];
	l:=[];
	
	#Travail 
	while c<i and j<Length(L[A]) do 
		c:=c+T[L[A][j]]*AbsInt(L[A][j+1]);
		Add(r,L[A][j]);
		Add(r,L[A][j+1]);
		j:=j+2;
	od;
	j:=j-2;	
	if AbsInt(L[A][j+1])<>1 and c<>i then 
		c:= c-T[L[A][j]]*AbsInt(L[A][j+1]);
		k:=0;
		while c<i do 
			c:=c+T[L[A][j]];
			k:=k+1;
		od;
		if c<>i then 
			s:=r[Length(r)-1];
			r[Length(r)]:=(k-1)*SignInt(L[A][j+1]);
			Add(r,e-1);
			Add(r,1*SignInt(L[A][j+1]));
		else 
			r[Length(r)]:=k;
		fi;
	elif AbsInt(L[A][j+1])=1 and c<>i then
		s:=r[Length(r)-1];
		r[Length(r)-1]:=e-1;
	fi;
	#Sortie
	if c=i then 
		Add(f,r);
		for k in [A+1..Length(L)] do
			Add(f,L[k]);
		od;
		return(f);	
	else 
		m:=T[s]-c+i;
		for k in [1..s-ng] do 
			Add(f,L[k]);
		od;
		Add(f,r);
		for k in [A+1..Length(L)] do
			Add(f,L[k]);
		od;
		return fin(f,m,s-ng,ng,e-1,T);
	fi;
	end;
	
debut:= function(L,i,A,ng,e,T)
	local c,
		  j,
		  r,
		  k,
		  s,
		  m,
		  l,
		  f;
		  
	#Initialisation
	j:=1;
	c:=0;
	f:=[];
	r:=[];
	l:=[];
	
	#Travail 
	while c<i and j<Length(L[A]) do 
		c:=c+T[L[A][j]]*AbsInt(L[A][j+1]);
		j:=j+2;
	od;
	if c<>i then
		j:=j-2;
	fi;
	
	for k in [j,j+2..Length(L[A])-1] do
		Add(r,L[A][k]);
		Add(r,L[A][k+1]);
	od;
	if AbsInt(L[A][j+1])<>1 and c<>i then 
		c:= c-T[L[A][j]]*AbsInt(L[A][j+1]);
		k:=0;
		while c<i do 
			c:=c+T[L[A][j]];
			k:=k+1;
		od;
		if c<>i then 
			if AbsInt(L[A][j+1])-k <>0 then 
				s:=r[1];
				r[2]:=(AbsInt(L[A][j+1])-k)*SignInt(L[A][j+1]);
				Add(r,e-1,1);
				Add(r,1*SignInt(L[A][j+1]),2);
			else 
				s:=r[1];
				r[1]:= e-1;
				r[2]:=1*SignInt(L[A][j+1]);
			fi;
			
		else 
			r[2]:=(AbsInt(L[A][j+1])-k)*SignInt(L[A][j+1]);
		fi;
	elif AbsInt(L[A][j+1])=1 and c<>i then
		s:=r[1];
		r[1]:=e-1;
		fi;
	#Sortie
	if c=i then 
		Add(f,r);
		for k in [A+1..Length(L)] do
			Add(f,L[k]);
		od;
		return(f);	
	else 
		m:=T[s]-c+i;
		for k in [1..s-ng] do 
			Add(f,L[k]);
		od;
		Add(f,r);
		
		for k in [A+1..Length(L)] do
			Add(f,L[k]);
		od;
		return debut(f,m,s-ng,ng,e-1,T);
	fi;
	end;
	
CoupeMotf := function(w,i)
	local L,
		  A,
		  ng,
		  e,
		  G,
		  T,
		  x,
		  c,
		  k,
		  j,
		  t,
		  r,
		  l;
		    
	#Initialisation 
	x:=w![1];
	A:=Length(x);
	ng:= FamilyObj(w)!.SLPrank;
	e:=0;
	t:=0;
	r:=[];
	T:=SubLengths(w);
	G:=fin(x,i,A,ng,e,T);
	k:=Length(x)+Length(G)+ng;
	
	for j in [1..Length(x)] do 
		Add(r,x[j]);
	od;
	
	for j in [1..Length(G)] do 
		if G[j][Length(G[j])-1]<0 then 
			G[j][Length(G[j])-1]:= G[j][Length(G[j])-1]+k;
		fi;
		Add(r,G[j]);
	od;
	
	return(AssocWordBySLPRep(FamilyObj(w),r));
	end;
	
CoupeMotd := function(w,i)
	local L,
		  A,
		  ng,
		  e,
		  G,
		  T,
		  x,
		  c,
		  k,
		  j,
		  t,
		  r,
		  l;
	
	#Test sécurité 
	if i=0 then 
		return(w);
	elif i=Length(w) then 
		return("vide");
	fi;	    
	#Initialisation 
	x:=w![1];
	A:=Length(x);
	ng:= FamilyObj(w)!.SLPrank;
	e:=0;
	t:=0;
	r:=[];
	T:=SubLengths(w);
	G:=debut(x,i,A,ng,e,T);
	k:=Length(x)+Length(G)+ng;
	
	for j in [1..Length(x)] do 
		Add(r,x[j]);
	od;
	
	for j in [1..Length(G)] do 
		if G[j][1]<0 then 
			G[j][1]:= G[j][1]+k;
		fi;
		Add(r,G[j]);
	od;
	return(AssocWordBySLPRep(FamilyObj(w),r));
	end;
	
CoupeMot := function(w,i,j)
	local r,
		  f;
	r:=CoupeMotf(w,j);
	f:=CoupeMotd(r,i-1);
	return(f);
	end;
	
###################################################################################################################
#Egalité 

ReduceWordPart:=function(w)
local x, #Liste SLP
		  r, #résultat 
		  f,
		  l, #liste de travail 
		  n, #longueur de x
		  i,
		  j,
		  t,
		  k,
		  ng;#Nb de générateurs 
		  
	#Initialisation 
	x:=w![1];
	r:=[];
	f:=[];
	n:=Length(x);
	ng:= FamilyObj(w)!.SLPrank;
	
	for i in [1..n] do
		l:=x[i];
		r:=[];
		for j in [1,3..Length(l)-1] do
			if l[j]<=ng then 
				for k in [1..AbsInt(l[j+1])] do 
					Add(r,SignInt(l[j+1])*l[j]);
				od;
			else 
				for t in [1..AbsInt(l[j+1])] do
					if SignInt(l[j+1])<0 then
						for k in [Length(f[l[j]-ng]),Length(f[l[j]-ng])-1..1] do
							Add(r,-1*f[l[j]-ng][k]);
						od;
					else 
						for k in [1..Length(f[l[j]-ng])] do
							Add(r,f[l[j]-ng][k]);
						od;
					fi;
				od;
			fi;
		od;
		Add(f,r);
	od;
	f:=f[Length(f)];
	return f;
	end;

Equality := function(x,y,D,s)

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
	if n<>m then 
		return[false,D];
	elif n=1 then
		lx:=ReduceWordPart(x);
		ly:=ReduceWordPart(y);
		AddDictionary(D,[1+s,1+s],lx[1]=ly[1]);
		return([lx[1]=ly[1],D]);
	else 
		x1 := CoupeMot(x,1,Int(n/2));
		x2 := CoupeMot(x,Int(n/2)+1,n);
		y1 := CoupeMot(y,1,Int(m/2));
		y2 := CoupeMot(y,Int(m/2)+1,m);
		B1 :=LookupDictionary(D,[1+s,Int(n/2)+s]);
		B2 :=LookupDictionary(D,[Int(n/2)+s,n+s]);
		if B1<> fail then 
			if B2<>fail then 
				return[B1 and B2,D];
			else 
				e2:=Equality(x2,y2,D,s+Int(n/2));
				AddDictionary(e2[2],[Int(n/2)+1+s,n+s],e2[1]);
				return[e2[1] and B1,e2[2]];
			fi;
		else 
			e1:=Equality(x1,y1,D,s);
			AddDictionary(e1[2],[1+s,Int(n/2)+s],e1[1]);
			if B2<>fail then 
				return[e1[1] and B2,e1[2]];
			else
				e2:=Equality(x2,y2,e1[2],s+Int(n/2));
				AddDictionary(e2[2],[Int(n/2)+s+1,n+s],e2[1]);
				return[e2[1] and e1[1],e2[2]];
			fi;
		fi;
	fi;
	end;
	
	

	
##################################################################
## Préfixe (en cours de réalisation)


prefixe := function(w,z) 
	local n,
		  m,
		  D,
		  B,
		  l,
		  p,
		  u,
		  min,
		  max,
		  r,
		  e,
		  v;
		  
		  
	#Initialisation
	D:=NewDictionary([1,2],true);
	n:=Length(w);
	m:=Length(z);
	B:=Equality(w,z,D,0);
	D:=B[2];
	e:=0;
	B:=B[1];
	
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
	
	while 2^e<max do
		e:=e+1;
	od;
		
	
	
	l:=min;
	p:=min;
	r:=min;
	if p<>1 then 
		while p<>1 do
			u:=CoupeMot(w,1,l);
			v:=CoupeMot(z,1,l);
			B:=Equality(u,v,D,0);
			D:=B[2];
			B:=B[1];
			r:=l;
			if B then 
				p:=Int((min-p)/2);
				l:=l+p;
			else
				p:=Int((p)/2);
				l:=l-p;
			fi;
		od;
		return(l);
	else 
		return(0);
	fi;
	end;
	
	
prefixe := function(w,z) 

	local B,
		  x,
		  y,
		  n,
		  m,
		  max,
		  min,
		  i,
		  u,
		  v,
		  D,
		  e,
		  p,
		  l;
		  
	#Initialisation
		D:=NewDictionary([1,2],true);
		n:=Length(w);
		m:=Length(z);
		B:=Equality(w,z,D,0);
		D:=B[2];
		e:=0;
		B:=B[1];
		x:=[];
		y:=[];
		l:=[];

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
	
	while 2^e<max do
		e:=e+1;
	od;
	
	n:=Length(w![1]);
	m:=Length(z![1]);
	
	for i in [1..n-1] do 
		Add(x,w![1][i]);
	od;
	
	for i in [1..Length(w![1][n])] do 
		Add(l,w![1][n][i]);
	od;
	
	Add(l,1);
	Add(l,(2^e)-m);
	Add(x,l);
	
	x:=AssocWordBySLPRep(FamilyObj(w),x);
	l:=[];
	
	for i in [1..m-1] do 
		Add(y,z![1][i]);
	od;
	
	for i in [1..Length(z![1][m])] do 
		Add(l,z![1][m][i]);
	od;
	
	Add(l,1);
	Add(l,(2^e)-m);
	Add(y,l);
	
	y:=AssocWordBySLPRep(FamilyObj(z),y);
	
	l:=2^e;
	p:=2^e;
	if p<>1 then 
		while p<>1 do
			u:=CoupeMot(x,1,l);
			v:=CoupeMot(y,1,l);
			B:=Equality(u,v,D,0);
			D:=B[2];
			B:=B[1];
			if B then 
				p:=Int((min-p)/2);
				l:=l+p;
			else
				p:=Int((p)/2);
				l:=l-p;
			fi;
		od;
		if l<min then 
			return(l);
		else 
			return(min);
		fi;
	else 
		return(0);
	fi;
	end;

	
	
	
#Document de test 

f:=FreeGroup(IsSLPWordsFamily,2);

###################################################################
##Fonctions 

#EstVide 
h:= NewSLP(FamilyObj(f.1),[[2,2],[1,3],[1,2,1,3],[5,2,3,5],[3,1,4,1],[3,1,4,1],[]]);
EstVide(h);

###################################################################
##methodes d'impression 

#PrintObj
t:= NewSLP(FamilyObj(f.1),[[1,2,1,-2]]);
h:= NewSLP(FamilyObj(f.1),[[2,2],[1,3],[1,2,1,3],[5,2,3,5],[3,1,4,1],[3,1,4,1],[1,1]]);
o:=NewSLP(FamilyObj(f.1),[[2,2],[2,1],[3,2,1,2],[1,2],[3,1,4,1],[1,2],[2,3],[3,1,4,1],[7,1,10,1]] );
x:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,1,4,1],[3,1,5,1,]]);
y:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,1,4,1],[5,-1,4,1]]);

#Display
o:=NewSLP(FamilyObj(f.1),[[2,2],[2,1],[3,2,1,2],[1,2],[3,1,4,1],[1,2],[2,3],[3,1,4,1],[7,1,10,1]] );
x:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,1,4,1],[3,1,5,1,]]);
Display(o);
Display(x);


#########################################################################
##MULTIPLIER DEUX MOTS 

t:= NewSLP(FamilyObj(f.1),[[2,1],[1,1,2,1],[3,2],[4,-3]]);
i:= NewSLP(FamilyObj(f.1),[[1,1,2,1],[1,2,3,2],[2,3],[4,1,5,1]]);
Display(t*i);


############################################################################
##PASSER A LA PUISSANCE 

t:= NewSLP(FamilyObj(f.1),[[2,1],[1,1,2,1],[3,2],[4,-3]]);
i:= NewSLP(FamilyObj(f.1),[[1,1,2,1],[1,2,3,2],[2,3],[4,1,5,1]]);
Display(t^-5);
Display(i^5);
Display(t^0);

###########################################################
##AUTRES 

#Longueur d'un mot (Length)
t:= NewSLP(FamilyObj(f.1),[[2,1],[1,1,2,1],[3,2],[4,-3]]);
i:= NewSLP(FamilyObj(f.1),[[1,1,2,1],[1,2,3,2],[2,3],[4,1,5,1]]);
Length(t);
Length(i);

#Ecrit un mot à l'envers (à mettre à jour)

#Si on remplace un générateur par un autre générateur (à mettre à jour)


#######################################################################
##Conversion en format lettre 
t:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,-13,4,1],[3,-12,4,1],[6,1,5,24,4,-1]]); 
Convert(t);

#######################################################################
##Création du sous mot

#SubLengths  
y:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,-1,4,1],[5,1,4,-1]]);
SubLengths(y);

y:=NewSLP(FamilyObj(f.1),[[2,3],[1,4],[3,25,4,-1]]);
SubLengths(y);

y:=NewSLP(FamilyObj(f.1),[[2,3],[3,25,1,4],[4,1]]);
SubLengths(y);

#fin
y:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,-1,4,1],[5,1,4,-1]]);
x:=Convert(y);
L:= [[2,2],[1,3],[3,-13,4,1],[5,25,4,-1]];
i:=4;
A:=4;
ng:=2;
e:=0;
T:=[1,1,2,3,5,8];
fin(L,i,A,ng,e,T);

y:=NewSLP(FamilyObj(f.1),[[2,3],[1,4],[3,25,4,-1]] );
x:=Convert(y);
L:= [[2,3],[1,4],[3,25,4,-1]] ;
i:=79;
A:=3;
ng:=2;
e:=0;
T:=Taille(y);
fin(L,i,A,ng,e,T);


#debut
y:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,-1,4,1],[5,1,4,-1]]);
x:=Convert(y);
L:= [[2,2],[1,3],[3,-13,4,1],[5,25,4,-1]];
i:=4;
A:=4;
ng:=2;
e:=0;
T:=[1,1,2,3,5,8];
debut(L,i,A,ng,e,T);


y:=NewSLP(FamilyObj(f.1),[[2,3],[3,25,1,2],[4,1,2,-3]]);
x:=Convert(y);
L:= [[2,3],[3,25,1,2],[4,1,2,-3]];
i:=3;
A:=3;
ng:=2;
e:=0;
T:=Taille(y);
debut(L,i,A,ng,e,T);

#CoupeMotf
y:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,-13,4,1],[5,5,4,-1]]);
x:=CoupeMotf(y,2);
Convert(y);
Convert(x);

y:=NewSLP(FamilyObj(f.1),[[2,3],[3,25,1,2],[4,1,2,-3]]);
x:=CoupeMotf(y,76);
Convert(y);
Convert(x);

#CoupeMotd
y:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,-13,4,1],[5,5,4,-1]]);
x:=CoupeMotd(y,148);
Convert(y);
Convert(x);

y:=NewSLP(FamilyObj(f.1),[[2,3],[3,25,1,2],[4,1,2,-3]]);
x:=CoupeMotd(y,76);
Convert(y);
Convert(x);

#CoupeMot
y:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,-13,4,1],[5,25,4,-1]]);
x:=CoupeMot(y,2,728);
Convert(y);
Convert(x);


y:=NewSLP(FamilyObj(f.1),[[2,3],[3,25,1,2],[4,1,2,-3]]);
x:=CoupeMot(y,78,78);
Convert(y);
Convert(x);
###################################################################################################################
##Egalité 

#ReduceWordPart
y:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,-13,4,1],[5,25,4,-1]]);
x:=CoupeMot(y,2,2);
ReduceWordPart(x);

#Equality 
x:=f.1*f.2*f.2;
y:=f.1*f.2;
D:= NewDictionary([1,2],true);
Equality(x,y,D,0);

x:=NewSLP(FamilyObj(f.1),[[2,3],[1,2],[2,-3],[3,25,4,1,5,1]]);
y:=NewSLP(FamilyObj(f.1),[[2,3],[3,25,1,2],[4,1,2,-3]]);
D:= NewDictionary([1,2],true);
Equality(x,y,D,0);

x:=NewSLP(FamilyObj(f.1),[[2,3],[1,2],[2,-3],[3,25,4,-1,5,1]]);
y:=NewSLP(FamilyObj(f.1),[[2,3],[3,25,1,2],[4,1,2,-3]]);
D:= NewDictionary([1,2],true);
Equality(y,x,D,0);

x:=NewSLP(FamilyObj(f.1),[[2,3],[1,4],[3,25,4,-1]]);
y:=NewSLP(FamilyObj(f.1),[[2,3],[3,25,1,4],[4,1]]);
D:= NewDictionary([1,2],true);
Equality(y,x,D,0);

###############################################################################
##Prefixe
x:=NewSLP(FamilyObj(f.1),[[2,3],[1,2],[2,-3],[3,25,4,1,5,1]]);
y:=NewSLP(FamilyObj(f.1),[[2,3],[3,25,1,2],[4,1,2,-3]]);
prefixe(x,y);

#Ce test devrait renvoyer 80 mais renvoie 82...
x:=NewSLP(FamilyObj(f.1),[[2,3],[1,2],[2,-3],[3,25,4,1,5,12]]);
y:=NewSLP(FamilyObj(f.1),[[2,3],[3,25,1,2],[4,1,2,-3]]);
prefixe(x,y);

x:=NewSLP(FamilyObj(f.1),[[2,3],[1,2],[2,-3],[3,25,4,-1,5,1]]);
y:=NewSLP(FamilyObj(f.1),[[2,3],[3,25,1,2],[4,1,2,-3]]);
prefixe(x,y);
######################################################
##Autres tests

#Test 01/12
i:= NewSLP(FamilyObj(f.1),[[1,1,2,1],[1,1,3,1]]);

#Test 02/12 
i:=[[1,1,2,1,4],[1,-1,1,1,6],[1,1,2,1,4]];


#
# Declarations
#

## On cherche a reproduire ce qui a été fait avec les Représentation SyllableFamily//LetterFamily 

## On déclare une catégorie qui hérite de IsAssocWordFamily:

#! @Description
#!   The family of SLP words
DeclareCategory( "IsSLPWordsFamily", IsAssocWordFamily );

DeclareInfoClass( "InfoSLP" );

##On déclare une représentation associée: 
#! @Description
#!   The representation of SLP words. It is by a list of lists of integers.
#!   Each list is an instruction in the SLP, and follows the format of
#!   associative words in syllable representation.
DeclareRepresentation( "IsSLPAssocWordRep", IsAssocWord, [] );

##Déclarations des attributs 

#On déclare une fonction qui convertit en SLP :
DeclareAttribute( "LetterRepOfAssocWord", IsAssocWord );

#On déclare l'attribut qui garde la taille de toutes les listes
DeclareAttribute("SubLengths",IsAssocWord and IsSLPAssocWordRep);
DeclareOperation("LengthOfMaximalCommonPrefix",[IsAssocWord and IsSLPAssocWordRep,IsAssocWord and IsSLPAssocWordRep]);

DeclareAttribute("IsReducedWord",  IsAssocWord );


