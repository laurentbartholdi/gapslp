# gapslp: SLP for free groups

ReadPackage( "gapslp", "gap/gapslp.gi");
#
#
NewFilter( "IsSLPWord"); 
#POur l'instant cela ne marche pas j'ai du mal comprendre quelque chose
InstallTrueMethod( IsSLPWord, IsAssocWord and IsSLPAssocWordRep );
NewType( IsSLPWordsFamily, IsSLPWord and IsSLPAssocWordRep);

##Est ce que cela suffit pour pouvoir utiliser Objectify ?


#Pour créer la nouvelle représentation il faut implémenter :

# Cette méthode va permettre de passer de la représentation en syllabe à la représentation en SLP
 InstallMethod( ObjByExtRep, "letter rep family", true,
     [ IsAssocWordFamily and IsLetterWordsFamily, IsHomogeneousList ], 0,
   function( F, e )
	local lt,ld,lg,lp,n,K;
    lt:=ShallowCopy(LinesOfStraightLineProgram(e));
	ld:=[];
	lg:=[];
	lp:=[];
	K:=[];
	n:=NrInputsOfStraightLineProgram(e);
	
	#On "range" les générateurs dans ld et lt 
	for i in [1..n] do 
		Boite(ld,lg,[i,1]);
		Add(lp,[i,1]);
	od;
	
	#On créer un SLP à partir de lt
	While Length(lt)>5 do #le choix de 5 est arbitraire
		K:= PaireExp3(ld,lg,lt,lp);
		ld:=K[1];
		lg:=K[2];
		lt:=K[3];
		lp:=K[4];
		lt := RacPuis(lt);
	od;
    Add(lp,lt);
	return lp;
	
	#J'ai l'impression que c'est ce que doit renvoyer la fonction, mais ne comprenant
	#pas le fonctionnement de type et Objectify, et ne pouvant pas tester la fonction 
	#Etant donné que le reste ne fonctionne pas ...
	return Objectify(F!.SLPWordType,[Immutable(lt)]); #pour ça il faudrait implémenter SLPWordType

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
#Cet algorithme fonctionne
PaireSimple := function(ld,lg,lt,lp)
	local k,n, ind;
	k:=[];
	Print("OKA");
	n:=Length(lt);
	i:=1;
	while i<n do
		if (lt[i] in lg) and (lt[i+1] in ld) then
			ind :=0;
			for j in [1..Length(lp)] do 
				if lp[j] = [lt[i],lt[i+1]] then 
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
		i:=i+1;
		n:=Length(lt);
	od;
	return [ld,lg,lt,lp];
	end;
	
## Cette fonction ne permets de réunir les éléments 2 part 2, en prenant en compte qu'ils peuvent avoir des exposants 
## différents de 1
# Cet Algorithme fonctionne 
PaireExp3 := function(ld,lg,lt,lp)
	local k, ind;
	k:=[];
	n:=Length(lt)-3;
	i:=1;
	while i<=n do
		if (i mod 2 =1) and ([lt[i],lt[i+1]] in lg) and ([lt[i+2],lt[i+3]] in ld) then   
			ind :=0;
			for j in [1..Length(lp)] do 
				if lp[j] = [lt[i],1,lt[i+2],1] then 
					Add(lt,j,i+2);
					Add(lt,1,i+3);
					if lt[i+5]=1 then
						Remove(lt,i+5);
						Remove(lt,i+4);
					else
						lt[i+5]:=lt[i+5]-1;
					fi;
					if lt[i+1]=1 then
						Remove(lt,i+1);
						Remove(lt,i+1);
					else
						lt[i+1]:=lt[i+1]-1;
					fi;
					ind:=1;
				fi;
			od;
			if ind=0 then
				L:=[lt[i],1,lt[i+2],1];
				Add(lp,L);
				k:=Boite(ld,lg,L); ## J'ai fait une fonction, car peut-être qu'il faudra faire évoluer Boite, on aura pas besoin de changer tout le code comme ça
				ld:=k[1];
				lg:=k[2];
				Add(lt,Length(lp),i+2);
				Add(lt,1,i+3);
				if lt[i+5]=1 then
					Remove(lt,i+5);
					Remove(lt,i+4);
				else
					lt[i+5]:=lt[i+5]-1;
				fi;
				if lt[i+1]=1 then
					Remove(lt,i+1);
					Remove(lt,i+1);
				else
					lt[i+1]:=lt[i+1]-1;
				fi;
			fi;	
		fi;
		i:=i+1;
		n:=Length(lt);
	od;
	return lt;
	end;	
		
 ##Cette fonction doit permettre de regrouper les éléments égaux entre eux sous forme de puissance
 ##Cet algorithme fonctionne 
 RacPuis := function(lt)
	local e;
	n:=Length(lt)-3;
	i:=1;
	while i<=n do
		if i mod 2 = 1 and lt[i]=lt[i+2] then 
			e:=lt[i+1]+lt[i+3];
			Remove(lt,i+3);
			Remove(lt,i+2);
			lt[i+1]:=e;
		fi;
	i:=i+1;
	n:=Length(lt);
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
