#
# gapslp: SLP for free groups
#
# Implementations 
#
#############################################################################
##Création d'une fonction sous-mot 

InstallMethod(SubLengths, [ IsAssocWord and IsSLPAssocWordRep],0,function(w,i,l)
	local c,
		  x,
	      n,
		  j,
		  s,
		  k,
		  T,
		  debut;
		  
	#Initialisation
	c:=0;
	x:=w![1];
	n:=Length(n);
	s:=1;
	T:=SubLengths(w);
	#Travail pour le debut
	while c<>i do
		if s>0 then 
			j:=1;
			while c<i and j<Length(x[n]) do                   #On parcourt grossièrement la liste 
			c:=c+T[x[n][j]]*AbsInt(x[n][j+1]);
			j:=j+2;
			od;
			
			for k in [Length(x[n])-1,Length(x[n])-3..j] do    #On récupère la partie de la liste qui nous intéresse (à l'enver) sans prendre l'élément de travail
				Add(debut,x[n][k]);
				Add(debut,x[n][k+1]);
			od;
			
		elif s<0 then 
			j:=Length(x[n])-1;
			while c<i and j>0 do                              #On parcourt grossièrement la liste 
			c:=c+T[x[n][j]]*AbsInt(x[n][j+1]);
			j:=j-2;
			od;
			
			for k in [1,3..j] do                              #On récupère la partie de la liste qui nous intéresse (à l'enver) sans prendre l'élément de travail
				Add(debut,x[n][k]);
				Add(debut,x[n][k+1]);
			od;
		fi;
		
		if AbsInt(x[n][j+1])<>1 and c<>i then                #Si la puissance est différente de -1 ou 1 on affine la sélection 
			if s>0 then 
				j:=j-2;
			elif s<0 then 
				j:=j+2;
			fi;
		
			c:= c-T[x[n][j]]*AbsInt(x[n][j+1]);
			k:=0;
			while c<i do 
				c:=c+T[x[n][j]];
				k:=k+1;
			od;
		
			if c<>i then 
				if AbsInt(x[n][j+1])-k <>0 then             #Si on garde une partie des puissance on l'ajoute à la fin de la liste 
					Add(debut,j);
					Add(debut,(AbsInt(x[n][j+1])-k)*SignInt(x[n][j+1]));
					n:=j-ng;
					s:=s*SignInt(x[n][j+1]);
				else                                        #Dans tous les cas on met à jour n et s pour recommencer la boucle 
					n:=j-ng;
					s:=s*SignInt(x[n][j+1]);
				fi;
			else 
				Add(debut,j);
				Add(debut,AbsInt(x[n][j+1])-k)*SignInt(x[n][j+1]);
			fi;
		elif AbsInt(x[n][j+1])=1 and c<>i then             #on met à jour n et s pour recommencer la boucle
			n:=j-ng;
			s:=s*SignInt(x[n][j+1]);
		fi;
	od;
	
	return(debut);
	end);
	

	