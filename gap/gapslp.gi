#
# gapslp: SLP for free groups
#
# Implementations
#
#############################################################################
##Création des SLP

BindGlobal("AssocWordBySLPRep", function( F, elt )
	return Objectify(F!.SLPtype,[Immutable(elt)]);
	end);

InstallOtherMethod( ObjByExtRep, "SLP rep family", true,
        [ IsAssocWordFamily and IsSLPWordsFamily, IsCyclotomic, IsInt, IsHomogeneousList ], 0,
        function( F, exp, maxcand, elt )
    return AssocWordBySLPRep(F,[elt]);
end );
    
# Prend le controle de StoreInfoFreeMagma
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
InstallOtherMethod(IsOne, "for an assoc. word in SLP rep", true, [ IsAssocWord and IsSLPAssocWordRep],0, function( w )
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
	
	end);
			

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
	if IsOne(w) then 
		return ("<identity ...>");
	fi;
	
	if Length(x)<>1 then 
		s:=Concatenation(s,"(");
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
	
	if Length(x)<>1 then 
		s:=Concatenation(s,")");	
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
		  i, #Parcourt 
		  x; #Liste de SLP
	
	#Initialisation
	s:=""; 
	n:=FamilyObj(w)!.SLPrank;
	l:=[];
	x:=w![1];
	#Tester si la liste est vide
	if IsOne(w) then 
		return ("<identity ...>");
	fi;
	
	if Length(x)<>1 then 
		s:=Concatenation(s,"(");
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
	if Length(x)<>1 then
		s:=Concatenation(s,")");
	fi;
	
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


###########################################################
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

##Création  
InstallMethod(SubLengths, [ IsAssocWord and IsSLPAssocWordRep],0,function(w)
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
#######################################################################
#Conversion en format lettre 

InstallMethod(LetterRepAssocWord,"for a SLP word", [IsAssocWord and IsSLPAssocWordRep],
        function(w)
	
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
	
	if IsOne(w) then 
		return([]);
	fi;
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
	return f[Length(f)];
    end);

InstallOtherMethod(AssocWordByLetterRep, "SLP words family", true,
    [ IsSLPWordsFamily, IsHomogeneousList ], 0,
	function( F, l )
	return(Objectify(F!.letterWordType,[l]));
	end);
	
	
InstallOtherMethod(LetterRepOfAssocWord,"for a SLP word", [IsAssocWord and IsSLPAssocWordRep],
            w->Objectify(FamilyObj(w)!.letterWordType,[LetterRepAssocWord(w)]));


#######################################################################
#Conversion en format syllabe 

InstallMethod(SyllableRepAssocWord,"for a SLP word", [IsAssocWord and IsSLPAssocWordRep],
        function(w)
	
	local x, #Liste SLP
		  r, #résultat 
		  f,
		  l, #liste de travail 
		  n, #longueur de x
		  i,
		  j,
		  t,
		  k,
		  a,
		  b,
		  ng;#Nb de générateurs 
		  
	#Initialisation 
	x:=w![1];
	r:=[];
	f:=[];
	n:=Length(x);
	ng:= FamilyObj(w)!.SLPrank;
	
	if IsOne(w) then 
		return(SyllableWordObjByExtRep(FamilyObj(w),[]));
	fi;
	for i in [1..n] do
		l:=x[i];
		r:=[];
		for j in [1,3..Length(l)-1] do
			if l[j]<=ng then 
				Add(r,l[j]);
				Add(r,l[j+1]);
			else 
				for t in [1..AbsInt(l[j+1])] do
					if SignInt(l[j+1])<0 then
						for k in [Length(f[l[j]-ng])-1,Length(f[l[j]-ng])-3..1] do
							Add(r,f[l[j]-ng][k]);
							Add(r,-1*f[l[j]-ng][k+1]);
						od;
					else 
						for k in [1,3..Length(f[l[j]-ng])-1] do
							Add(r,f[l[j]-ng][k]);
							Add(r,f[l[j]-ng][k+1]);
						od;
					fi;
				od;
			fi;
		od;
		Add(f,r);
	od;
	#ATTENTION IL FAUDRA REDUIRE LA LISTE 
	r:=[];
	i:=3;
	f:=f[Length(f)];
	a:=f[1];
	b:=f[2];
	while i<Length(f) do # il ne peut pas y avoir de simplification à 0
		if a=f[i] then 
			b:=b+f[i+1];
			i:=i+2;
		else 
			Add(r,a);
			Add(r,b);
			a:=f[i];
			b:=f[i+1];
			i:=i+2;
		fi;
	od;
	Add(r,a);
	Add(r,b);
	return (SyllableWordObjByExtRep(FamilyObj(w),r));
    end);

######################################################################################

InstallMethod(SLPRepOfAssocWord,"for a syllabe word", [IsAssocWord and IsSyllableAssocWordRep],
        function(w)
	
	local x,
		  t,
		  f,
		  e,
		  r,
		  i,
		  l,
		  n;
	
	#Initialisation 
	r:=[];
	l:=[];
	n:=Length(FamilyObj(w)!.names);
	x:=ExtRepOfObj(w);
	t:=FindSubstringPowers(x,n);
	for i in [1..Length(t[2])] do
		Add(r,t[2][i]);
	od;
	i:=1;
	f:=t[1][1];
	e:=1;
	while i<Length(t[1]) do 
		if t[1][i+1]=f then 
			e:=e+1;
			i:=i+1;
		else 
			Add(l,f);
			Add(l,e);
			i:=i+1;
			e:=1;
			f:=t[1][i];
		fi;
	od;
	Add(l,f);
	Add(l,e);
	Add(r,l);
	return(ObjByExtRep(FamilyObj(w),r));
	end);
	
###################################################################################
##Test d'un mot réduit 

InstallMethod(IsReducedWord,"for a SLP word", [IsAssocWord and IsSLPAssocWordRep], function(w)
	
	local x,
		  ng,
		  n,
		  i,
		  d,
		  y1,
		  y2,
		  j;
		  
	#Initialisation
	x:=w![1];
	d:=NewDictionary(1,true) ; 
	n:=Length(x);
	ng:= FamilyObj(w)!.SLPrank;
	
	#Remplir le dico [1,d]
	for i in [1..ng] do 
		AddDictionary(d,i,[i,0,i]);	
	od;
	
	for i in [1..n] do 
		j:=1;
		AddDictionary(d,i+ng,[x[i][1],0,x[i][Length(x[i])-1]]);	
		
		while j<Length(x[i])-2 do 
		y1 := LookupDictionary(d,x[i][j]);
		y2 := LookupDictionary(d,x[i][j+2]);
			if y1[2+SignInt(x[i][j+1])]=y2[2-SignInt(x[i][j+3])] then
				return(false);
			fi;
		j:=j+2;
		od;
		
	od;
	return(true);
	end);
