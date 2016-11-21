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

##POur le moment on utilise cette fonction print pour tester le produit qui permettra
## de tester ViewString, qui remplacera à terme PrintString 

InstallMethod( PrintObj,
    "for element in SLP",
    [ IsSLPAssocWordRep ],
    function( w )
    Print( "<SLP ",w![1],">");
    end );


## On va supposé dans ce fichier que les slp sont des listes de liste, 
## pas de réécriture possibl et un seul résultat affiché. 


## Implémenter les méthodes PrintString et PrintObj

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
		for j in [1,3..Length(l)-1] do
			s:=Concatenation(s,"_");
			s:=Concatenation(s,String(l[j]));
			s:=Concatenation(s,":=");
			if l[j]<=n then 
				s:=Concatenation(s,FamilyObj(w)!.names[l[j]]);
			else
				s:=Concatenation(s,"_");
				s:=Concatenation(s,String(l[j]));
			fi;
			s:=Concatenation(s,"^");
			s:=Concatenation(s,String(l[j+1]));
			s:=Concatenation(s,";");
		od;
	od;
	
	#Faire une boucle qui s'occupe de la dernière liste 
	
	return (s);
	end);
	
InstallOtherMethod( ViewObj, "for an assoc. word in SLP rep", true,
    [ IsAssocWord and IsSLPAssocWordRep], 0,
	function( w )
	Print(PrintString(w));
	end);
	
##Test 
f:=FreeGroup(IsSLPWordsFamily,2);

## Je initialiser le produit pour pouvoir tester la fonction ViewString



#
# Reading the implementation part of the package.
#
