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
	local r, #nouvelle liste
		  ng;#nb générateur
	
	#Initialisation 
	r:=[];
	ng:=Length(FamilyObj(w)!.names);
	for i in [1..ng] do
		Add(r,[i,1]);
	od;
	Add(r,elt);	
	return Objectify(F!.SLPtype,[Immutable(r)]);
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