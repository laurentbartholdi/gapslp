#
# gapslp: SLP for free groups
#
# Implementations
#

# Cette méthode va permettre de passer de la représentation en syllabe à la représentation en SLP


BindGlobal("NewSLP", function( F, elt )
	return Objectify(F!.SLPtype,[Immutable(elt)]);
	end);
	

InstallOtherMethod( ObjByExtRep, "SLP rep family", true,
        [ IsAssocWordFamily and IsSLPWordsFamily, IsCyclotomic, IsInt, IsHomogeneousList ], 0,
        function( F, exp, maxcand, elt )
    return NewSLP(F,[elt]);
end );
    
# Prendre le controle de StoreInfoFreeMagma
CallFuncList(function()
    local sifm;
    sifm := StoreInfoFreeMagma;
    MakeReadWriteGlobal("StoreInfoFreeMagma");
    Unbind(StoreInfoFreeMagma);
    StoreInfoFreeMagma := function(F,names,req)
	sifm(F,names,req);
        if IsSLPWordsFamily(F) then
	# ajouter un type pour les SLP
	    F!.SLPtype := NewType(F,IsSLPAssocWordRep and req);
            F!.SLPrank := Length(F!.names);
	fi;
    end;
    MakeReadOnlyGlobal("StoreInfoFreeMagma");
end,[]);

################################################################
#Fonctions 

#Regarde si la liste est vide 	
EstVide:=function(w)
	local x, #liste de SLPObj
		  i, #parcourt la liste 
		  n,
		  c; #competeur
	#Initialisation
	x:=w![1];
	c:=0;
	n:=FamilyObj(w)!.SLPrank;
	
	#Test1
	if x[Length(x)]<>[] then 
			c:=1;
	fi;
	
	if c=1 then 
		return(false);
	else
		return(true);
	fi;
	
	end;
##ATTENTION ne dit pas si c'est l'identité 			

################################################################
# methodes d'impression

InstallOtherMethod( PrintString, "for an assoc. word in SLP rep", true,
    [ IsAssocWord and IsSLPAssocWordRep], 0,
	function( w )
	local s, #String résultat
		  n, #nb de générateurs 
		  l, #liste de travail
		  j, #Parcourt l
		  i, #Parcourt 
		  x; #Liste de SLP
	
	#Initialisation
	s:=""; 
	n:=FamilyObj(w)!.SLPrank;
	l:=[];
	x:=w![1];
	#Tester si la liste est vide
	if EstVide(w) then 
		return ("<identity...>");
	fi;
	
	#On s'occupe des premières listes 
	for i in [1..Length(x)-1] do
		l:=ShallowCopy(x[i]);
		s:=Concatenation(s,"_");
			s:=Concatenation(s,String(i));
			s:=Concatenation(s,":=");
		for j in [1,3..Length(l)-1] do
			
			if l[j]<=n then 
				s:=Concatenation(s,FamilyObj(w)!.names[l[j]]);
			else
				s:=Concatenation(s,"_");
				s:=Concatenation(s,String(l[j]-n));
			fi;
			if l[j+1]<>1 then 
					s:=Concatenation(s,"^");
					s:=Concatenation(s,String(l[j+1]));
			fi;
			if j<>Length(l)-1 then 
				s:=Concatenation(s,"*");
			fi;
		od;
		s:=Concatenation(s,";");
	od;
	
	#Faire une boucle qui s'occupe de la dernière liste 
	l:=x[Length(x)];
	
	for j in [1,3..Length(l)-1] do
			
			if l[j]<=n then 
				s:=Concatenation(s,FamilyObj(w)!.names[l[j]]);
			else
				s:=Concatenation(s,"_");
				s:=Concatenation(s,String(l[j]-n));
			fi;
			if l[j+1]<>1 then 
					s:=Concatenation(s,"^");
					s:=Concatenation(s,String(l[j+1]));
			fi;
			if j<>Length(l)-1 then 
				s:=Concatenation(s,"*");
			fi;
		od;
		
	return (s);
	end);
	
InstallOtherMethod( PrintObj, "for an assoc. word in SLP rep", true,
    [ IsAssocWord and IsSLPAssocWordRep], 0,
	function( w )
	Print(PrintString(w));
	end);
	
##Implémenter les méthodes ViewString et ViewObj
	
InstallOtherMethod( ViewString, "for an assoc. word in SLP rep", true,
    [ IsAssocWord and IsSLPAssocWordRep], 0,
	function( w )
	local s, #String résultat
		  n, #nb de générateurs 
		  l, #liste de travail
		  j, #Parcourt l
		  i, #Parcourt 
		  x; #Liste de SLP
	
	#Initialisation
	s:=""; 
	n:=FamilyObj(w)!.SLPrank;
	l:=[];
	x:=w![1];
	#Tester si la liste est vide
	if EstVide(w) then 
		return ("<identity...>");
	fi;
	
	#On s'occupe des premières listes 
	for i in [1..Length(x)-1] do
		l:=ShallowCopy(x[i]);
		s:=Concatenation(s,"_");
			s:=Concatenation(s,String(i));
			s:=Concatenation(s,":=");
		for j in [1,3..Length(l)-1] do
			
			if l[j]<=n then 
				s:=Concatenation(s,FamilyObj(w)!.names[l[j]]);
			else
				s:=Concatenation(s,"_");
				s:=Concatenation(s,String(l[j]-n));
			fi;
			if l[j+1]<>1 then 
					s:=Concatenation(s,"^");
					s:=Concatenation(s,String(l[j+1]));
			fi;
			if j<>Length(l)-1 then 
				s:=Concatenation(s,"*");
			fi;
		od;
		s:=Concatenation(s,";");
	od;
	
	#Faire une boucle qui s'occupe de la dernière liste 
	l:=x[Length(x)];
	
	for j in [1,3..Length(l)-1] do
			
			if l[j]<=n then 
				s:=Concatenation(s,FamilyObj(w)!.names[l[j]]);
			else
				s:=Concatenation(s,"_");
				s:=Concatenation(s,String(l[j]-n));
			fi;
			if l[j+1]<>1 then 
					s:=Concatenation(s,"^");
					s:=Concatenation(s,String(l[j+1]));
			fi;
			if j<>Length(l)-1 then 
				s:=Concatenation(s,"*");
			fi;
		od;
		
	return (s);
	end);

	
InstallOtherMethod( ViewObj, "for an assoc. word in SLP rep", true,
    [ IsAssocWord and IsSLPAssocWordRep], 0,
	function( w )
	Print(ViewString(w));
	end);
	
	
## Implémenter DisplayString et Display
InstallMethod( DisplayString,
    "for element in SLP",
    [ IsSLPAssocWordRep ],
    function( w )
	local s; #String résultat
		s:= "<SLP ";
		s:= Concatenation(s,String(w![1]));
		s:=Concatenation(s, ">");
    return(s);
    end );

InstallOtherMethod( Display, "for an assoc. word in SLP rep", true,
    [ IsAssocWord and IsSLPAssocWordRep], 0,
	function( w )
	Print(DisplayString(w));
	end);


###################################################################
##Fonctions qui simplifient un mot

SimplifieListe := function(w)
	local p, #premier
		  d, #dernier
		  ed,
		  ep,
		  t,
		  x,
		  i,
		  bool,
		  l,
		  r,
		  n;
	#Initialisation
	t:=w![1];
	l:=[];	  
	r:=[];
	bool:=true;
	
	for i in [1..Length(t)] do
	x:=t[i];
	
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
					d:=d+2;
				else
					if p-2>0 then 
						p:=p-2;
						ep:=x[p+1];
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
		Add(r,l);
	od;
	return Objectify(FamilyObj(w)!.SLPtype,[Immutable(r)]);
 
	end;
	
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

	
	#liste non vide 
	for i in [1..n] do 
		for j in [1,3..Length(x[i])-1] do 
			if x[i][j]>ng and LookupDictionary(v,x[i][j]-ng)=fail then
				AddDictionary(v,x[i][j]-ng,1);
			fi;
		od;
	od;
		
	#On supprime les listes en double
	for i in [1..n] do
		l:=[];
		Print(LookupDictionary(v,i)=1);
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
		l:=ReduceList(l);
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
	o:=ReduceList(x[nx]);	
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
	l:=ReduceList(l);
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
	
	m:=ReduceList(m);
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
	 

###########################################################
##AUTRES 

##Longueur d'un mot (à jour)

  
InstallMethod(Length,"assoc word in SLP rep",true,
  [IsAssocWord and IsSLPAssocWordRep],0,
  function(w)
	local r, #liste de stockage
		  l, #liste de travail 
		  x, #Liste SLP 
		  i, #Parcourt
		  j, #Parcourt 
		  c, #Compteur intermédiaire 
		  ng,#nb de générateurs 
		  n; #Longueur x
		  
	#Initialisation 
	x:=w![1];
	l:=[];
	n:=Length(x);
	r:=[];
	ng:= FamilyObj(w)!.SLPrank;
	
	for i in [1..n] do
		l:=ShallowCopy(x[i]);
		c:=0;
		for j in [1,3..Length(l)-1] do 
			if l[j]<=ng then 
				c:=c+AbsInt(l[j+1]);
			else 
				c:=c+r[l[j]-ng]*AbsInt(l[j+1]);
			fi;
		od;
		r[i]:=c;
	od;
	return(r[Length(r)]);
	
	end);

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
	
	r:=NewSLP(FamilyObj(w),r);
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
	
	r:=NewSLP(FamilyObj(w),r);
	return r;
 
    end);
	
#######################################################################
#Conversion en format lettre 

Convert:=function(w)
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
	return Objectify(FamilyObj(w)!.letterWordType,[f]);
	end;
	
#######################################################################
##Création du sous mot 
InstallMethod(Taille, [ IsAssocWord and IsSLPAssocWordRep],0,function(w)
	local j,
		  x,
		  l,
		  t,
		  k,
		  ng,
		  T;
	
	#Initialisation 
	x:=w![1];
	t:=0;
	ng:= FamilyObj(w)!.SLPrank;
	T:=[];
	
	for j in [1..ng] do
		Add(T,1);
	od;
	
	for j in [1..Length(x)] do 
		l:=x[j];
		t:=0;
		for k in [1,3..Length(l)-1] do
			if l[k]<=ng then 
				t:=t+AbsInt(l[k+1]);
		else 
			t:=t+T[l[k]]*AbsInt(l[k+1]);
		fi;
		od;
		Add(T,t);
	od;

	return(T);
	end);

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
	j:=j-2;	
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
			s:=r[1];
			r[2]:=(AbsInt(L[A][j+1])-k)*SignInt(L[A][j+1]);
			Add(r,e-1,1);
			Add(r,1*SignInt(L[A][j+1]),2);
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
	T:=Taille(w);
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
	
	return(NewSLP(FamilyObj(w),r));
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
		    
	#Initialisation 
	x:=w![1];
	A:=Length(x);
	ng:= FamilyObj(w)!.SLPrank;
	e:=0;
	t:=0;
	r:=[];
	T:=Taille(w);
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
	return(NewSLP(FamilyObj(w),r));
	end;
CoupeMot := function(w,i,j)
	local r,
		  f;
	r:=CoupeMotd(w,i-1);
	f:=CoupeMotf(r,j-i+1);
	return(f);
	end;
	
