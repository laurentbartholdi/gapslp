# gapslp: SLP for free groups

ReadPackage( "gapslp", "gap/gapslp.gi");

#
NewFilter( "IsSLPWord"); 
InstallTrueMethod( IsSLPWord, IsAssocWord );
NewType( IsSLPWordsFamily, IsSLPWord and IsSLPAssocWordRep);
##Est ce que cela suffit pour pouvoir utiliser Objectify ?


Pour créer la nouvelle représentation il faut implémenter :

# Cette méthode va permettre de passer de la représentation en syllabe à la représentation en SLP
 InstallMethod( ObjByExtRep, "letter rep family", true,
     [ IsAssocWordFamily and IsLetterWordsFamily, IsHomogeneousList ], 10000,
   function( F, e )
    
# Cela ressemble à coder l'algorithm 4 : CompressPairs page 61 de Lohrey

    return Objectify(F!.SLPWordType,[Immutable(l)]); #pour ça il faudrait implémenter SLPWordType
    end);
#Boite est une fonction qui mets dans la liste la plus courte le nouvel éléments,

Boite := function(ld,lg,L)
	if Length(ld)>Length(lg) then 
		Add(lg,L);
	else 
		Add(ld,L);
	fi;
	
	return [ld,lg];
	end;

#Dans une représentation en lettre (sans exposant), transforme en partie en SLP
#Il faudrait le répéter plusieur fois pour avoir une vrai liste pour SLP

PaireSimple := function(ld,lg,lt,lp)
	local k, ind;
	k:=[];
	for i in [1..Length(lt)-1] do
		if (lt[i] in lg) and (lt[i+1] in ld) then
			ind :=0;
			Print("OK1");
			for j in [1..Length(lp)] do 
				Print("OK2");
				if lp[j] = [lt[i],lt[i+1]] then #Le code plante à cause de cette ligne...
					Remove(lt,i);
					Remove(lt,i);
					Add(lt,j,i);
					ind:=1;
				fi;
			od;
			if ind=0 then
				L:=[lt[i],lt[i+1]];
				Add(lp,L);
				k:=Boite(ld,lg,L); ## J'ai fait une fonction, car peut-être qu'il faudra faire évoluer Boite, on aura pas besoin de changer tout le code comme ça
				
				ld:=k[1];
				lg:=k[2];
				Remove(lt,i);
				Remove(lt,i);
				Add(lt,Length(lp),i);	
			fi;
		fi;
	od;
	return ld;
	end;
 ##Cette fonction doit permettre de regrouper les éléments égaux entre eux sous forme de puissance
 RacPuis := function(lt)
	local e;
	for i in [1..Length(lt)-2] do
		if i mod 2 = 1 and lt[i]=lt[i+2] then #j'ai le même problème que plus haut
			e:=lt[i+1]+lt[i+3];
			Remove(lt,i+3);
			Remove(lt,i+2);
			lt[i+1]:=e;
		fi;
	od;
	return lt;
	end;
    
#Cette méthode va permettre de passer d'une représentation SLP à une représentation en syllabe
#J'ai fait des test mais il reste des erreurs
 InstallMethod(ExtRepOfObj,"assoc word in letter rep",true,
 [IsAssocWord and IsLetterAssocWordRep],0,function(v)
  #il faudrait interdire la réécriture
  local n,w,l,r,k,lg;
  r:=[];
  l:=[];
  k:=[];
  j:=0;
  w:=LinesOfStraightLineProgram(v);
  n:=NrInputsOfStraightLineProgram(v);
  lg:=Length(w)-1;
##On modifie petit à petit toutes les sous liste en injectant les générateurs 
 for i in [1..lg] do
    if IsList(w[i][1]) then
        l:=w[i][1];
    else
        l:=w[i];
    fi;
        while j in [1..Length(l)] do
            if (j mod 2 = 1) and (l[j]>n) then
                r:=w[l[j]];
                for k in [1..Length(r)] do 
                    if k mod 2 = 0 then
                        r[k]:=r[k]*l[j+1]; #on actualise les exposants
                    fi;    
                od;
                remove(l,j);
                remove(l,j);
                add(l,r,j);
            fi;
			j:=j+Length(r)-1;
        od;
    w[i]:=l; 
            
 od;
 
## Ici le programme regarde le dernier élément de la liste qui peut être une liste de liste 
   k:=w[Length(w)];
   if IsList(k[1]) then 
        l:=k[1]; 
   elif IsList(k[Length(k)]) then 
         l:=w[Length(w)];
   fi;
   while j in [1..Length(l)] do
            if (j mod 2 = 1) and (l[j]>n) then
                r:=w[l[j]];
                for k in [1..Length(r)] do 
                    if k mod 2 = 0 then
                        r[k]:=r[k]*l[j+1]; #on actualise les exposants
                    fi;    
                od;
                remove(l,j);
                remove(l,j);
                add(l,r,j);
            fi;
        j:=j+Length(r)-1;
    od;
  return l;
  end);



##d'après la documentation de GAP pour créer une nouvelle représentation il faut aussi implémenter PrintObj et ViewObj, on verra ça dans un second temps.
#InstallMethod( \*, 
#InstallMethod( \^,
#InstallMethod( InverseOp


#
# Reading the implementation part of the package.
#
