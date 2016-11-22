# gapslp: SLP for free groups

ReadPackage( "gapslp", "gap/gapslp.gi");
#
#
InstallGlobalFunction(SLPObj, function(F,e)
Error("test");
 	return Objectify(NewType(F, IsSLPWordsFamily and IsSLPAssocWordRep),[e]);
	end);

#Pour créer la nouvelle représentation il faut implémenter :

# Cette méthode va permettre de passer de la représentation en syllabe à la représentation en SLP
InstallOtherMethod( ObjByExtRep, "SLP rep family", true,
    [ IsAssocWordFamily and IsSLPWordsFamily, IsCyclotomic, IsInt, IsHomogeneousList ], 0,
    function( F, exp, maxcand, elt )
	return Objectify(F!.SLPtype,[Immutable([elt])]);
	end);

InstallOtherMethod( ObjByExtRep, "SLP rep family", true,
    [ IsAssocWordFamily and IsSLPWordsFamily, IsCyclotomic, IsInt, IsTable ], 0,
    function( F, exp, maxcand, elt )
	return Objectify(F!.SLPtype,[Immutable(elt)]);
	end);	
	
	
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
	fi;
    end;
    MakeReadOnlyGlobal("StoreInfoFreeMagma");
end,[]);

##POur le moment on utilise cette fonction print pour tester le produit qui permettra
## de tester ViewString, qui remplacera à terme PrintString 

InstallMethod( PrintObj,
    "for element in SLP",
    [ IsSLPAssocWordRep ],
    function( w )
    Print( "<SLP ",w![1],">");
    end );

##Test 
f:=FreeGroup(IsSLPWordsFamily,2);
	
## On va supposé dans ce fichier que les slp sont des listes de liste, 
## pas de réécriture possible et un seul résultat affiché. 

##Test 
f:=FreeGroup(IsSLPWordsFamily,2);

##Regarde si le SLP est vide 

IsEmpty2:=function(w)
	local x, #liste de SLPObj
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
			
##ATTENTION CETTE FONCTION N'INDIQUE PAS L'IDENTITE

## Le produit (fonctionne)

InstallMethod( \*, "for two assoc. words in SLP rep", IsIdenticalObj,
    [ IsAssocWord and IsSLPAssocWordRep, 
      IsAssocWord and IsSLPAssocWordRep], 0, function(w,z)
	  	 
	local  x, #Liste de SLP
		   y, #liste de SLP
		   nx,#longueur de la liste x
		   ny,#longueur de la liste y
		   ng,#nb de générateurs
		   n, #cases rajoutées
		   l, #liste de travail
		   r; #ce sera le résultat
	
	#Initialisation
	x:=w![1];
	y:=z![1];
	nx:=Length(x);
	ny:=Length(y);
	ng:=Length(FamilyObj(w)!.names);
	n:=0;
	l:=[];
	r:=[];
	
	#Si une des listes est vide
	if IsEmpty2(w)then 
		return(z);
	fi;
	if IsEmpty2(z) then 
		return(w);
	fi;
	
	#On ajoute les générateurs 
	for i in [1..ng] do
		Add(r,[i,1]);
	od;
	n:=ng;
	
	#Si les deux listes ne sont pas vides
		for i in [1..nx] do
			l:=ShallowCopy(x[i]);
			for j in [1,3..Length(l)-1] do
				if l[j]>ng then 
					l[j]:=l[j]+n;
				fi;
			od;
			Add(r,l);
		od;
		n:=n+nx;
		for i in [1..ny] do
			l:=ShallowCopy(y[i]);
			for j in [1,3..Length(l)-1] do
				if l[j]>ng then 
					l[j]:=l[j]+n;
				fi;
			od;
			Add(r,l);
		od;
		n:=n+ny;
		l:=[nx+ng,1,n,1];
		Add(r,l);
	return ObjByExtRep(FamilyObj(w),1,1,r);
	 
	end);
##ATTENTION PAS DE SIMPLIFICATION DES GENERATEURS

##Passage à la puissance (fonctionne pour les puissances positives)
InstallMethod( \^,
    "for an assoc. word with inverse in syllable rep, and an integer",
    true,
    [ IsAssocWordWithInverse and IsSLPAssocWordRep, IsInt ], 0, function(w,a)
    
	local r, #liste résultat
		  x, #Liste de SLP
		  nx,#Longueur de x
		  ng,#nb de générateurs
		   l;#liste de travail
	
	#Initialisation
	r:=[];
	x:=ShallowCopy(w![1]);
	nx:=Length(x);
	ng:=Length(FamilyObj(w)!.names);
	l:=[];
	
	#On ajoute les générateurs 
	for i in [1..ng] do
		Add(r,[i,1]);
	od;
	n:=ng;
	Print(ng);
	#On mets à jour les éléments 
		for i in [1..nx] do
		Print("OKA");
			l:=ShallowCopy(x[i]);
			for j in [1,3..Length(l)-1] do
				if l[j]>ng then 
					
					l[j]:=l[j]+ng;
				fi;
			od;
			Add(r,l);
		od;
	
	#On élève à la puissance
	Add(r,[Length(r),a]);
	
	return ObjByExtRep(FamilyObj(w),1,1,r);
	 
	end);
	
	f.1^2;
		

## Implémenter les méthodes ViewString et ViewObj

InstallOtherMethod( ViewString, "for an assoc. word in SLP rep", true,
    [ IsAssocWord and IsSLPAssocWordRep], 0,
	function( w )
	local s, #String résultat
		  n, #nb de générateurs 
		  l, #liste de travail
		  x; #Liste de SLP
	
	#Initialisation
	s:=""; 
	n:=Length(FamilyObj(w)!.names);
	l:=[];
	g:=[];
	x:=w![1];
	#Tester si la liste est vide 
	
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
			s:=Concatenation(s,"^");
			s:=Concatenation(s,String(l[j+1]));
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
				s:=Concatenation(s,String(l[j]));
			fi;
			s:=Concatenation(s,"^");
			s:=Concatenation(s,String(l[j+1]));
		od;
		
	return (s);
	end);
	
	ViewString(f.1*f.2);

InstallOtherMethod( ViewObj, "for an assoc. word in SLP rep", true,
    [ IsAssocWord and IsSLPAssocWordRep], 0,
	function( w )
	Print(PrintString(w));
	end);
		
	
#
# Reading the implementation part of the package.
#
