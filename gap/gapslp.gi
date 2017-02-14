#
# gapslp: SLP for free groups
#
# Implementations
#

#Création d'un élément (Etat)
BindGlobal("AssocWordBySLPRep", function( F, elt )
    return Objectify(F!.SLPtype,[Immutable(elt)]);
end );

InstallOtherMethod( ObjByExtRep, "SLP rep family", true,
        [ IsAssocWordFamily and IsSLPWordsFamily, IsCyclotomic, IsInt, IsHomogeneousList ], 0,
        function( F, exp, maxcand, elt )
    return AssocWordBySLPRep(F,[elt]);
end );
    
# Prendre le controle de StoreInfoFreeMagma (fonctionne)
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
# methodes d'impression (fonctionne)

##Implémenter les méthodes PrintString et PrintObj (fonctionne)

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
	
##Implémenter les méthodes ViewString et ViewObj (fonctionne)
	
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
	n:=Length(FamilyObj(w)!.names);
	l:=[];
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
	
	
## Implémenter DisplayString et Display (fonctionne)

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
# comparaisons et opérations

##Fonction qui simplifie un mot (fonctionne)

BindGlobal("Simplify", function(w)
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
	return AssocWordBySLPRep(FamilyObj(w),r);
	end);

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
	
	r := AssocWordBySLPRep(FamilyObj(w),[r]);
	r:=Simplify(r); 	 
	return r;
	end);


##Passage à la puissance (fonctionne)
InstallMethod( \^,
    "for an assoc. word with inverse in syllable rep, and an integer",
    true,
    [ IsAssocWordWithInverse and IsSLPAssocWordRep, IsInt ], 0, function(w,a)
    
	 #On considère qu'un SLP est une liste entre crochet
	
	local  r, #résultat
		   x, #SLP sous forme de liste
		   i, #Permet de répéter a fois la liste 
		   j, #Parcourt la liste 
		   l; #Longeur x[1]
		   
		   
	 x:=ShallowCopy(w![1]);
	 r:=[];
	 #Test si la liste est vide 
	 if x<>[] and x<>[[]] then 
		x:=x[1]; 
		l:=Length(x);
		if a>0 then 
			for i in [1..a] do
				for j in [1..l] do 
					Add(r,x[j]);
				od;
			od;
		fi;
		if a<0 then 
			for i in [1..-a] do
				for j in [l-1,l-3..1] do 
					Add(r,x[j]);
					Add(r,-x[j+1]);
				od;
			od;
		fi;
	 fi;
	
	r:=AssocWordBySLPRep(FamilyObj(w),[r]);
	r:=Simplify(r);
	return r;
 
    end);
	 

##Longueur d'un mot (fonctionne)
InstallMethod(Length,"assoc word in SLP rep",true,
  [IsAssocWord and IsSLPAssocWordRep],0,
  function(w)
  local c, #compteur
		i, #Parcourt la liste 
		x; #Liste SLP
	c:=0;
	x:=w![1];
	if x<>[] and x<>[[]] then 
		x:=x[1];
		for i in [2,4..Length(x)] do
			c:=c+AbsInt(x[i]);
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
		  i, #Parcourt la liste 
		  l; #Longueur de x[1]
		  
	x:=w![1];
	r:=[];
	l:=Length(x[1]);
	for i in [l-1,l-3..1] do
		Add(r,x[1][i]);
		Add(r,x[1][i+1]);
	od;
	r:=[r]; 
	return(AssocWordBySLPRep(FamilyObj(w),r));
	
	end);

## Accéder à un sous mot (fonctionne)

InstallOtherMethod( Subword,"for SLP associative word and two positions",
    true, [ IsAssocWord and IsSLPAssocWordRep, IsPosInt, IsInt ], 0,
	function( w, from, to )
	local r, #liste résultat
		  x, #liste associée au SLP
		  i, #élément qui parcours la liste
		  c; #compteur d'éléments
	#Initialisation 
	i:=1;
	c:=0;
	r:=[];
	x:=w![1]; 
	
	if x<>[] and x<>[[]] then
		x:=x[1];
		if from>=1 and to<=2*Length(w) then
		
		#On parcourt pour trouver le début
			while c<from and i<Length(x) do
				c:=c+AbsInt(i+1);
				i:=i+2;
			od;
			Add(r,x[i-2]);
			if x[i-1]<0 then 
				Add(r,-(c-from+1));
			else 
				Add(r,(c-from+1));
			fi;
			
		#On récupère les éléments
			while c<to and i<Length(x) do 
				Add(r,x[i]);
				if c+AbsInt(x[i+1])>to then 
					Add(r,to-c);
					c:=to;
				else
					Add(r,x[i+1]);
					c:=c+AbsInt(x[i+1]);
				fi;
				i:=i+2;
			od;
		fi;
	else
		r:=ShallowCopy(x);
	fi;
	return (AssocWordBySLPRep(FamilyObj(w),1,1,r));
	end);
