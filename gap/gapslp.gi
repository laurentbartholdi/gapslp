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
##Fonction qui simplifie un mot

ReduceList := function(x)
	local p, #premier
		  d, #dernier
		  ed,
		  ep,
		  bool,
		  l,
		  n;
		  
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
	
	return l;
 
	end;
	
ReduceWord := function(w)
	local x,#Liste de SLP
		  ng,#Nb de générateurs 
		  n, #Longueur de x
		  r, #Liste résultat travail
		  l, #Liste de travail
		  d, #renumérotation
		  m, #maximum
		  k, #Liste finale
		  i,
		  bool, 
		  j; #indice qui parcourt 
			
	#Initialisation
	x:=ShallowCopy(w![1]);
	ng:=FamilyObj(w)!.SLPrank;
	r:=[];
	n:=Length(x);
	l:=[];
	d:=[];
	k:=[];
	
	#liste non vide 
	
	#On trie et on simplifie les premiers termes
	for i in [1..n-1] do
		l:=[];
		for j in [1,3..Length(x[i])-1] do 
			if x[i][j]<=ng then
				Add(l,x[i][j]);
			else 
				Add(l,d[x[i][j]-ng]);
			fi;
			Add(l,x[i][j+1]);
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
	
	#On réduit et renumérote x[n]
	l:=[];
	for j in [1,3..Length(x[n])-1] do 
		if x[n][j]<=ng then
				Add(l,x[n][j]);
			else 
				Add(l,d[x[n][j]-ng]);
		fi;
		Add(l,x[n][j+1]);
	od;
	l:=ReduceList(l);
	
	#On simplifie pour que x[n] dépende de x[n-1]
	m:=-1;
	for j in [1,3..Length(l)-1] do 
		if l[j]>m then 
			m:=l[j];
		fi;
	od;
	for i in [1..m-ng] do 
		Add(k,r[i]);
	od;
	Add(k,l);
	
	return Objectify(FamilyObj(w)!.SLPtype,[Immutable(k)]);
	
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
	Print(Length(r));
	m:=o;
	for i in [1..Length(r)] do
		if o=r[i]then 
			m:=[i,1];
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
	Print(m);
	if bool then 
		for i in [1..Length(l)] do 
			Add(m,l[i]);
		od;
	fi;
	Print(m);
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
		while Length(m)>4 do 
			Add(k,[m[1],m[2],m[3],m[4]]);
			Remove(m,1);
			Remove(m,1);
			m[1]:=Length(k)+ng;
			m[2]:=1;
		od;
		Add(k,m);
		
	else 
		k:=[[]];
	fi;
	return Objectify(FamilyObj(w)!.SLPtype,[Immutable(k)]);
	
    end);
	
	
############################################################################
#PASSER A LA PUISSANCE 	
	
InstallMethod( \^,"for an assoc. word with inverse in syllable rep, and an integer",
		true,
     [ IsAssocWordWithInverse and IsSLPAssocWordRep, IsInt ], 0, function(w,a)

    local  x,
           l,
           m,
		   ng,
           i,
           n,
           b,
           exp,
           j,
           r; #résultat
		   
       #Initialisation
       r:=[];
       ng:=FamilyObj(w)!.SLPrank;
       x:=ShallowCopy(w![1]);
       n:=Length(x);
       exp :=a;
	   
       #Si la liste est vide ATTENTION CETTE CONDITION NE SUFFIT PAS
       if EstVide(w) then
               return(w);
       fi;

       if a<0 then
       for i in [1..n] do
               m:=ShallowCopy(x[i]);
               l:=[];
               for j in [Length(m)-1,Length(m)-3..1] do
                               if m[j]<=ng then
                                       Add(l,m[j]);
                                       Add(l,-1*m[j+1]);
                               else
                                       Add(l,m[j]);
                                       Add(l,m[j+1]);
                               fi;
               od;
               Add(r,l);
               exp:=-a;
       od;
       else
               r:=ShallowCopy(x);
       fi;

       if exp>1 then
       i:=Length(r)+ng;
       Add(r,[n+ng,1,n+ng,1]);
       b:=Length(r)+ng;
       j:=b;

       if exp mod 2 =1 then
               exp:=(exp-1)/2;
       else
               exp:=exp/2;
       fi;

       while exp<>1 do
               if exp mod 2 =1 then
                       Add(r,[j,1,b,1]);
                       Add(r,[i,1,j,1]);
                       exp:=(exp-1)/2;
                       j:=j+2;
                       i:=i+2;
               else
                       exp:=exp/2;
                       Add(r,[j,1,b,1]);
                       j:=j+1;
                       if exp=1 then
                               Add(r,[i,1,j,1]);
                       fi;
               fi;
       od;
       fi;
       return Objectify(FamilyObj(w)!.SLPtype,[Immutable(r)]);
     end);

################################################################
#Fonction qui convertit un SLP en un SLP in Chomsky normal form (Thm 3.8 p 45)
#En cours de réalisation 
Chomsky := function(w)
	local x, #Liste SLP
		  e, #Permet de garder en mémoire si la liste est vide ou non
		  i,
		  j,
		  n, #Longueur de x
		  bool,
		  c,#compteur de liste supprimées 
		  r,#Résultat
		  ng,
		  l;#liste de travail
		  
		 
	#Initialisation 
	x:=ShallowCopy(w![1]);
	e:=[];
	n:= Length(x);
	r:=[];
	l:=[];
	ng:=FamilyObj(w)!.SLPrank;
	
	#Step 1 : vérifié pour les SLP tels qu'ils sont créés
	
	#Step 2 : on supprime toutes les listes vides 
		#On marque les mots vides
	
	for i in [1..n] do 
		if ReduceList(x[i])=[] then 
			e[i]:=1;
		else 
			bool:=true;
			for j in [1,3..Length(x[i])-1] do 
				if x[i][j]<=ng then
					bool:=false;
				elif e[x[i][j]-ng]<>1 then 
					bool:=false;
					fi;
			od;
			if bool then 
				e[i]:=1;
			else 
				e[i]:=0;
			fi;
		fi;
	od;
		#On enlève les mots vides
	c:=[];
	
	for i in [1..n] do
	
		if e[i]=0 then 
			l:=[];
			for j in [1,3..Length(x[i])-1] do 
				if x[i][j]<=ng then 
					Add(l,x[i][j]);
					Add(l,x[i][j+1]);
				elif e[x[i][j]-ng]=0 then 
					Add(l,c[x[i][j]-ng]);
					Add(l,x[i][j+1]);
				fi;
			od;
			Add(r,l);
			c[i]:=Length(r)+ng;
		else
			c[i]:=0;
		fi;
	od;
	
	#Step 3 : Vérif
	return(r);
	end;


	
###########################################################
##Travail sur les mots réduits (fonction en cours d'élaboration)

#Recenser paires 
RP := function(w) 
	local x, #Liste du SLP
		  n, 
		  v,
		  i,
		  j,
		  k,
		  p,
		  ext,
		  f,
		  l,
		  sf,
		  sl,
		  ng;
		  
	
	#Initialisation
	x:=w![1];
	n:= Length(x);
	v:=[];
	p:=[];
	ext:=[];
	ng:= FamilyObj(w)!.SLPrank;
	
	#On créé la liste v 
	for i in [1..n-1] do 
		v[i]:=0;
	od;
	v[n]:=1;
	
	for i in [n,n-1..1] do
		for j in [1,3..Length(x[i])-1] do 
			if x[i][j]>ng then 
				v[x[i][j]-ng]:=v[x[i][j]-ng]+v[i]*AbsInt(x[i][j+1]);
			fi;
		od;
	od;
	
	#On recense les éléments extrêmes 
	
	for i in [1..n]do 
		if x[i][2]<0 then 
			if x[i][1]<=ng then 
				f:=x[i][1];
				sf :=-1;
			else 
				f:=ext[x[i][1]-ng][3];
				sf :=ext[x[i][1]-ng][4]*(-1);
			fi;
			
		else 
			if x[i][1]<=ng then 
				f:=x[i][1];
				sf :=1;
			else 
				f:=ext[x[i][1]-ng][1];
				sf :=ext[x[i][1]-ng][2];
			fi;
			
		fi;
		if x[i][Length(x[i])]<0 then 
			if x[i][Length(x[i])-1]<=ng then 
				l:=x[i][Length(x[i])-1];
				sl:=-1; 
			else 
				l:=ext[x[i][Length(x[i])-1]-ng][1];
				sl:=-1*ext[x[i][Length(x[i])-1]-ng][2]; 
			fi;
		else 
			if x[i][Length(x[i])-1]<=ng then 
				l:=x[i][Length(x[i])-1];
				sl:=1; 
			else 
				l:=ext[x[i][Length(x[i])-1]-ng][3];
				sl:=1*ext[x[i][Length(x[i])-1]-ng][4]; 
			fi;
		fi;
		
		ext[i]:=[f,sf,l,sl];
	od;
	
	#Recense les paires 
	for i in [1..n] do 
		k:=3;
		j:=1;
		Print(x[i]);
		while k<Length(x[i]) and j<Length(x[i]) do 
			if x[i][k+1]<0 then 
				if x[i][k]<=ng then 
					f:=x[i][k];
					sf :=-1;
				else 
					f:=ext[x[i][k]-ng][3];
					sf :=ext[x[i][k]-ng][4]*(-1);
				fi;
			
			else 
				if x[i][k]<=ng then 
					f:=x[i][k];
					sf :=1;
				else 
					f:=ext[x[i][k]-ng][1];
					sf :=ext[x[i][k]-ng][2];
				fi;
			fi;
			
			if x[i][j+1]<0 then 
				if x[i][j]<=ng then 
					l:=x[i][j];
					sl :=-1;
				else 
					l:=ext[x[i][k]-ng][1];
					sl :=ext[x[i][k]-ng][2]*(-1);
				fi;
			
			else 
				if x[i][j]<=ng then 
					l:=x[i][j];
					sl :=1;
				else 
					l:=ext[x[i][k]-ng][3];
					sl :=ext[x[i][k]-ng][4];
				fi;
				
			fi;
			Print([l,sl,f,sf,v[i]]);
			Add(p,[l,sl,f,sf,v[i]]);
			k:=k+2;
			j:=j+2;
		od;
		
	od;
	return p;
	end;
	
	
	
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
	


