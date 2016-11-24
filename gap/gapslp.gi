#
# gapslp: SLP for free groups
#
# Implementations
#

# Cette méthode va permettre de passer de la représentation en syllabe à la représentation en SLP
BindGlobal("NewSLP", function( F, elt )
    return Objectify(F!.SLPtype,[Immutable(elt)]);
end );

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
		  c; #competeur
	#Initialisation
	x:=w![1];
	c:=0;
	
	#Test1
	if x<>[] then
		for i in [1..Length(x)] do 
			if x[i]<>[] then 
				c:=1;
			fi;
		od;
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
		  i, #Parcourt la liste 
		  x; #Liste de travail
	s:=""; 
	x:=w![1];
	#si la liste est non-vide 
	if x<>[] and x<>[[]] then 
		if Length(x)=1 then 
			x:=x[1];
			for i in [1,3..Length(x)-1] do
				s:=Concatenation(s,FamilyObj(w)!.names[x[i]]);
				
				if x[i+1]<>1 then 
					s:=Concatenation(s,"^");
					s:=Concatenation(s,String(x[i+1]));
				fi;
				if i<>Length(x)-1 then 
					s:=Concatenation(s,"*");
				fi;
			od;
		fi;
	#Si la liste est vide 
	else 
		s:="<identity...>";
	fi;
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
		  i, #Parcourt x
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
				s:=Concatenation(s,String(l[j]));
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
	
	#Tester si vide 
	if l=[] then 
		s:=Concatenation(s,"<Identity...>");
	fi;
	
	for j in [1,3..Length(l)-1] do
			
			if l[j]<=n then 
				s:=Concatenation(s,FamilyObj(w)!.names[l[j]]);
			else
				s:=Concatenation(s,"_");
				s:=Concatenation(s,String(l[j]));
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

################################################################
##Fonction qui simplifie un mot

RacPuis := function(w)
	local e, #Nouvel exposant
		  i, #Parcourt la liste x
		  j, #Parcourt la liste l
		  nx, #Longueur limite de la liste
		  l, # Liste de travail 
		  n, #Longueur de travail sur l 
		  r, #résultat
		  x; #Liste de SLP
	
	#Initialisation
	r:=[];
	x:=w![1];
	nx:=Length(x);
	j:=1;
	
	for i in [1..nx] do 
		l:=ShallowCopy(x[i]);
		n:=Length(l)-3;
		while j<=n do
			if j mod 2 = 1 and l[j]=l[j+2] then 
				e:=l[j+1]+l[j+3];
				Remove(l,j+3);
				Remove(l,j+2);
				if e<>0 then 
					l[j+1]:=e;
				else 
					Remove(l,j+1);
					Remove(l,j);
				fi;
			else
				j:=j+1;
			fi;
			n:=Length(l)-3;
		od;
		Add(r,l);
	od;
	return NewSLP(FamilyObj(w),r);
	end;
##ATTENTION : le mot f.1*f.2*f.2^-1*f.1^-1; ne devrait pas être parfaitement simplifié

#########################################################################
#MULTIPLIER DEUX MOTS 
 
#Fonction pour 2 mots complexes
P := function(w,z)
local  x, #Liste de SLP
		   y, #liste de SLP
		   nx,#longueur de la liste x
		   ny,#longueur de la liste y
		   ng,#nb de générateurs
		   n, #cases rajoutées
		   l, #liste de travail
		   i,
		   j,
		   r; #ce sera le résultat
	
	#Initialisation
	x:=w![1];
	y:=z![1];
	nx:=Length(x);
	ny:=Length(y);
	ng:=FamilyObj(w)!.SLPrank;
	n:=0;
	l:=[];
	r:=[];
	
	#On suppose ici que les 2 listes ne sont pas vide
	#Et qu'elle commence par les générateurs 
	r:= ShallowCopy(x);
	
	n:=nx;
	for i in [ng+1..ny] do
		l:=ShallowCopy(y[i]);
		for j in [1,3..Length(l)-1] do
			if l[j]>ng then 
				l[j]:=l[j]+n;
			fi;
		od;
		Add(r,l);
	od;
	
	n:=n+ny-ng;
	l:=[nx,1,n,1];
	Add(r,l);

	r:=NewSLP(FamilyObj(w),r);
	r:=RacPuis(r);
	return r;
 
	end;


#Multiplier à gauche par un générateur   
PG :=function(w,z)
	local  x, #Liste de SLP
		   y, #liste de SLP
		   ny,#longueur de la liste y
		   ng,#nb de générateurs
		   n, #cases rajoutées
		   i, #Parcourt les listes
		   j, #Parcourt les listes 
		   l, #liste de travail
		   r; #ce sera le résultat
	
	#Initialisation
	x:=ShallowCopy(w![1]);
	y:=ShallowCopy(z![1]);
	ny:=Length(y);
	ng:=FamilyObj(w)!.SLPrank;
	n:=0;
	l:=[];
	r:=[];
			
	#On ajoute les générateurs 
	for i in [1..ng] do
		Add(r,[i,1]);
	od;
	
	n:=ng;
	
	for i in [ng+1..ny] do
	#a terme il faudra penser à enlever les ng premiers
		l:=ShallowCopy(y[i]);
		for j in [1,3..Length(l)-1] do
			if l[j]>ng then 
				l[j]:=l[j]+n;
			fi;
		od;
		Add(r,l);
	od;
	
	n:=Length(r);
	Add(r[n],x[1][1],1);
	Add(r[n],x[1][2],2);
	r:=NewSLP(FamilyObj(w),r);
	r:=RacPuis(r);
	return r;
 
    end;

#Multiplier à droite par un générateur   
PD :=function(w,z)
	local  x, #Liste de SLP
		   y, #liste de SLP
		   ny,#longueur de la liste y
		   ng,#nb de générateurs
		   n, #cases rajoutées
		   i, #Parcourt les listes
		   l, #liste de travail
			r; #ce sera le résultat
		   
	#j'ai gardé le même code, j'ai juste échangé z et w et modifié l'insertion
	
	#Initialisation 
	x:=ShallowCopy(z![1]);
	y:=ShallowCopy(w![1]);
	ny:=Length(y);
	ng:=FamilyObj(w)!.SLPrank;
	n:=0;
	l:=[];
	r:=[];
			
	
	for i in [1..ny] do
		l:=ShallowCopy(y[i]);
		Add(r,l);
	od;
	
	n:=Length(r);
	Add(r[n],x[1][1]);
	Add(r[n],x[1][2]);
	
	r:=NewSLP(FamilyObj(w),r);
	r:=RacPuis(r);
	return r;
 
    end;

#Multiplier 2 générateurs entre eux
PP := function(w,z)
	local x,
		  y,
		  r,
		  i,
		  ng;
		  
	#Initialisation 
	x:=w![1];
	y:=z![1];
	r:=[];
	ng:=FamilyObj(w)!.SLPrank;
	
	#On ajoute les générateurs 
	for i in [1..ng] do
		Add(r,[i,1]);
	od;
	
	Add(r,[x[1][1],x[1][2],y[1][1],y[1][2]]);
	
	r:=NewSLP(FamilyObj(w),r);
	r:=RacPuis(r);
	return r;
 
    end;

## Le produit (fonctionne)

InstallMethod( \*, "for two assoc. words in SLP rep", IsIdenticalObj,
    [ IsAssocWord and IsSLPAssocWordRep, 
      IsAssocWord and IsSLPAssocWordRep], 0, function(w,z)
	 
	 #On considère qu'un SLP est une liste entre crochet

	 local x, #Liste SLP
		  y, #Liste SLP
		  r; #resultat
	
	#Initialisation 
	x:=w![1];
	y:=z![1];
	
	#Si le mot est vide 
	if EstVide(w) then 
		return(z);
	fi;
	if EstVide(z) then 
		return(w);
	fi;
	
	#Sinon 
	##Pour l'instant [i,a] est considéré comme générateur 
	if Length(x)=1 and Length(y)<>1 then 
		r := PG(w,z);
	elif Length(x)<>1 and Length(y)=1 then 
		r := PD(w,z);
	elif Length(x)<>1 and Length(y)<>1 then 
		r := P(w,z);
	elif Length(x)=1 and Length(y)=1 then 
		r:=PP(w,z);
	fi;
	
	return(r);
	end);
	
	
############################################################################
#PASSER A LA PUISSANCE 

#Si a est positif 

PuisPos := function(w,a)
	local r; #résultat 

	#Initialisation 
	r:=ShallowCopy(w![1]);
	
	Add(r,[Length(r),a]);
	
	r:=NewSLP(FamilyObj(w),r);
	r:=RacPuis(r);
	return r;
 
    end;
	
	
#si a est négatif 

PuisNeg := function(w,a)
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
		if i<>n then 
			for j in [Length(m)-1,Length(m)-3..1] do 
				Add(l,m[j]);
				Add(l,m[j+1]);
			od;
		else 
			for j in [Length(m)-1,Length(m)-3..1] do 
				Add(l,m[j]);
				Add(l,-m[j+1]);
			od;
		fi;
		Add(r,l);
	od;
	Add(r,[n,-a]);
	r:=NewSLP(FamilyObj(w),r);
	return r;
 
    end;

#si le mot est un générateur	

PuisGen := function(w,a)
	local  x, #liste SLP 
		   ng,#Nb générateurs
		   i, #parcourt les générateurs 
		   r; #résultat
	
	#Initialisation
	x:=ShallowCopy(w![1]);
	ng:= FamilyObj(w)!.SLPrank;
	r:=[];
	
	#Si les listes sont vides 
	
	#Si les listes sont des générateurs 
	for i in [1..ng] do 
		Add(r,[i,1]);
	od;
	
	if a<>0 then 
		Add(r,[x[1][1],a]);
	else
		Add(r,[]);
	fi; 
	
	r:=NewSLP(FamilyObj(w),r);
	return r;

	end;

##Fonction puissance 	
	
InstallMethod( \^,
    "for an assoc. word with inverse in syllable rep, and an integer",
    true,
    [ IsAssocWordWithInverse and IsSLPAssocWordRep, IsInt ], 0, function(w,a)
    
	local  r; #résultat
	
	#Si les listes sont vides 
	
	#Pour les générateurs 
	if Length(w![1])=1 then 
		r:=PuisGen(w,a);
	
	elif a<0 then 
		r:=PuisNeg(w,a);
	elif a>0 then 
		r:=PuisPos(w,a);
		Print("ok");
	else 
		r:=NewSLP(FamilyObj(w),[[]]); #c'est pas très propre 
	fi;
		
	return r;
 
    end);
	 

###########################################################
##AUTRES 

##Longueur d'un mot (fonctionne)

  
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
	
	if Length(x)=1 then 
		return(1);
	fi;
	
	for i in [1..ng] do 
		Add(r,1);
	od;
	
	for i in [ng+1..n] do 
		l:=ShallowCopy(x[i]);
		c:=0;
		for j in [1,3..Length(l)-1] do 
			c:=c+r[l[j]]*AbsInt(l[j+1]);
		od;
		Add(r,c);
	od;
	return(r[Length(r)]);
	
	end);

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

##Si on remplace un générateur par un autre générateur 
	
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
	ng:=FamilyObj(w)!.SLPrank;
	g:=gen![1][1];
	b:=by![1][1];
	
	for i in [1..ng] do
		Add(r,x[i]);
	od;
	for i in [ng+1..n] do 
		l:=ShallowCopy(x[i]);
		for j in [1,3..Length(l)-1] do
			if l[j]=g then 
				l[j]:=b;
			fi;
		od;
	Add(r,l);
	od;
	
	r:=NewSLP(FamilyObj(w),r);
	return r;
 
    end);
	

