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

InstallMethod( PrintObj,
    "for element in SLP",
    [ IsSLPAssocWordRep ],
    function( w )
    Print( "<SLP ",w![1],">");
    end );
	
##Test 
f:=FreeGroup(IsSLPWordsFamily,2);

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


##Passage à la puissance (fonctionne)
InstallMethod( \^,
    "for an assoc. word with inverse in syllable rep, and an integer",
    true,
    [ IsAssocWordWithInverse and IsSLPAssocWordRep, IsInt ], 0, function(w,a)
    
	 #On considère qu'un SLP est une liste entre crochet
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

##Longueur d'un mot (fonctionne)
InstallMethod(Length,"assoc word in SLP rep",true,
  [IsAssocWord and IsSLPAssocWordRep],0,
  e->Length(e![1]));
	
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
	
	return(ObjByExtRep(FamilyObj(w),1,1,r));
	
	end);
#
# Reading the implementation part of the package.
#
