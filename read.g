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
    end
);

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

## Implémenter les méthodes PrintString et PrintObj

InstallOtherMethod( PrintString, "for an assoc. word in SLP rep", true,
    [ IsAssocWord and IsSLPAssocWordRep], 0,
	function( w )
	local s, #String résultat
		  x; #Liste de travail
	s:=""; 
	x:=w![1];
	#Tester si la liste est vide 
	
	if x<>[] and x<>[[]] then 
	#Commençons avec la méthode simple
	if Length(x)=1 then 
		x:=x[1];
		for i in [1,3..Length(x)-1] do
			s:=Concatenation(s,FamilyObj(w)!.names[x[i]]);
			s:=Concatenation(s,"^");
			s:=Concatenation(s,String(x[i+1]));
		od;
	
	fi;
	fi;
	return (s);
	end);
	
InstallOtherMethod( PrintObj, "for an assoc. word in SLP rep", true,
    [ IsAssocWord and IsSLPAssocWordRep], 0,
	function( w )
	Print(PrintString(w));
	end);
	
##Test 
f:=FreeGroup(IsSLPWordsFamily,2);


##La comparaison (fonctionne, j'ai réutilisé du code de Wordass.gi) 

InstallMethod(\<,"assoc. in SLP rep",IsIdenticalObj,
	[ IsAssocWord and IsSLPAssocWordRep, 
      IsAssocWord and IsSLPAssocWordRep],0,
	function( w, z )
	
	local x, # Liste SLP w
		  y, # liste SLP z
		  n, #divers
		  m; #divers
		  
	#Initialisation 
	
	x:=w![1][1];
	y:=z![1][1];
	n:=Sum([2,4..Length(x)],i->AbsInt(x[i]));
	m:=Sum([2,4..Length(y)],i->AbsInt(y[i]));
	
	#Le mot le plus long est le plus grand (code de syllable)
		
	if n<m then 
		return true;
	elif n>m then 
		return false;
	fi;
	
	#A taille égale on regarde l'ordre lexicographique (code de syllable)
		if n>Length(x) then
			return x<y; # x is a prefix of y. They could be same
		elif n>Length(y) then
			return false; # y is a prefix of x
		elif not IsInt(n/2) then
			# discrepancy at generator
			return x[n]<y[n];
		fi;
		# so the exponents disagree.
		if SignInt(x[n])<>SignInt(y[n]) then
			#they have different sign: The smaller wins
			return x[n]<y[n];
		fi;
		# but have the same sign. We need to compare the generators with the next
		# one
		if AbsInt(x[n])<AbsInt(y[n]) then
			# x runs out first
			if Length(x)<=n then
			return true;
			else
			return x[n+1]<y[n-1];
			fi;
		else
			# y runs out first
			if Length(y)<=n then
				return false;
			else
				return x[n-1]<y[n+1];
			fi;
		fi;

	end );
	
	
## Le produit (fonctionne)

InstallMethod( \*, "for two assoc. words in SLP rep", IsIdenticalObj,
    [ IsAssocWord and IsSLPAssocWordRep, 
      IsAssocWord and IsSLPAssocWordRep], 0, function(w,z)
	 
	 #On considère qu'un SLP est une liste entre crochet
	 	 
	local  i, #indice qui parcours y[1],
		   x, #Liste de SLP
		   y, #liste de SLP
		   r; #ce sera le résultat
	x:=w![1];
	y:=z![1];
	if x=[] or x=[[]] then  	      
		return(y);
	fi;
	
	if y=[] or y=[[]] then
		return (x);
	fi;
	 
	r:= ShallowCopy(x[1]);	
	for i in [1..Length(y[1])] do 
		Add(r,y[1][i]);
	od;
		 
	return ObjByExtRep(FamilyObj(w),1,1,r);
	 
	end);
## ATTENTION : il n'y a pas de simplification

##Passage à la puissance (fonctionne)
InstallMethod( \^,
    "for an assoc. word with inverse in syllable rep, and an integer",
    true,
    [ IsAssocWordWithInverse and IsSLPAssocWordRep, IsInt ], 0, function(w,a)
    
	 #On considère qu'un SLP est une liste entre crochet
	
	local  r, #résultat
		   x, #SLP sous forme de liste
		   l, #Longeur x[1]
	 x:=w![1];
	 r:=[];
	 #Test si la liste est vide 
	 
	 if x<>[] and x<>[[]] then 
		x:=x[1]; 
		l:=Length(x);
		for i in [1..a] do
			for j in [1..l] do 
				r:=Add(r,x[j]);
			od;
		od;
	 fi;
	 x:=x[1];
	 return(ObjByExtRep(FamilyObj(w),1,1,r));
	 
	 end);
	 
	 #C'est une fonction très rudimentaire il faudrait simplifier les termes


##Puissance de chaque éléments un par un (fonctionne) lié à une erreur ...
	if false then
	local i, #indice qui parcours 
		   r, #résultat
		   x, #SLP sous forme de liste
		   l; #Longeur x[1]
	 x:=w![1];
	 r:=[];
	 if x<>[] and x<>[[]] then 
		l:=Length(x[1]);
		
		#Cas exposant positif
		if a>0 then 
			r:=ShallowCopy(x[1]);
			for i in [1..l] do 
				if i mod 2 = 0 then 
					r[i]:=r[i]*a;
				fi;
			od;	
		fi;
	 
		#Cas exposant négatif 
		if a<0 then 
			for i in [l,l-2..2] do
				Add(r,x[1][i-1]);
				Add(r,x[1][i]*a);
			od;
		fi;
	 fi;
	 r:=[r];
	 return(ObjByExtRep(FamilyObj(w),1,1,r));
	 
	 end);
	fi;
	 
##Longueur d'un mot (fonctionne)
InstallMethod(Length,"assoc word in SLP rep",true,
  [IsAssocWord and IsSLPAssocWordRep],0,
  function(w)
  local c, #compteur
		x; #Liste SLP
	c:=0;
	x:=w![1];
	if x<>[] and x<>[[]] then 
		x:=x[1];
		for i in [2,4..Length(x)] do
			c:=c+x[i];
		od;
	fi;
	return(c);
    end);
	
## Ecrire le mot à l'envers (fonctionne)

InstallOtherMethod( ReversedOp, "for an assoc. word in SLP rep", true,
    [ IsAssocWord and IsSLPAssocWordRep], 0,
	function( w )
	local r, #mot à l'envers
		  x, #Liste SLP
		  l; #Longueur de x[1]
	x:=w![1];
	r:=[];
	l:=Length(x[1]);
	for i in [l-1,l-3..1] do
		Add(r,x[1][i]);
		Add(r,x[1][i+1]);
	od;
	r:=r; 
	return(ObjByExtRep(FamilyObj(w),1,1,r));
	
	end);


##Implémenter les méthodes ViewString et ViewObj
	
InstallOtherMethod( ViewString, "for an assoc. word in SLP rep", true,
    [ IsAssocWord and IsSLPAssocWordRep], 0,
	function(w)
	return(PrintString(w));
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

## Accéder à un sous mot

InstallOtherMethod( Subword,"for SLP associative word and two positions",
    true, [ IsAssocWord and IsSLPAssocWordRep, IsPosInt, IsInt ], 0,
	function( w, from, to )
	local r, #liste résultat
		  x, #liste associée au SLP
		  c; #compteur
	c:=0;
	r:=[];
	x:=w![1]; 
	
	if x<>[] and x<>[[]] then
		x:=x[1];
		if from>=1 and to<=Length(x)/2 then 
			while c<to do 
				Add(r,x[2*i-1]);
				Add(r,x[2*i]);
				c:=c+x[2*i];
			od;
		fi;
	else
		r:=ShallowCopy(x);
	fi;
	return (ObjByExtRep(FamilyObj(w),1,1,r));
	end);
	
Subword(t,2,3);

## On a ensuite 2 méthodes spécifiques aux Syllables : PositionWord et SubSyllables

##Remplacer un générateur par un autre (ne fonctionne pas)

InstallMethod( EliminatedWord,
  "for three associative words, SLP rep.",IsFamFamFam,
    [ IsAssocWord and IsSLPAssocWordRep, 
	IsAssocWord and IsSLPAssocWordRep, 
	IsAssocWord and IsSLPAssocWordRep ],0,
	function( w, gen, by )
	local x, #Liste SLP résultat
		  g1,#Liste ancien générateur
		  g2;#Liste nouveau générateur
	
	x:=ShallowCopy(![1][1]);
	g1:=gen![1][1];
	g2:=by![1][1];
	
	for i in [1,3..Length(x)-1] do
		if x[i]=g1[1] then 
			x[i]:=g2[1];
			x[i+1]:=x[i+1]*g2[1];
		fi;
	od;
	return (ObjByExtRep(FamilyObj(w),1,1,x));
	end);

EliminatedWord(t,f.1,f.2);

#
# Reading the implementation part of the package.
#
