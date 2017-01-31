#
# gapslp: SLP for free groups
#
# Implementations 
#
#############################################################################
##Création d'une fonction sous-mot 

InstallOtherMethod(Subword, [ IsAssocWord and IsSLPAssocWordRep, IsPosInt, IsInt ],0,function(w,i,l)
	local c,
		  x,
	      n,
		  j,
		  s,
		  k,
		  T,
		  ng,
		  r,
		  debut;
		  
	#Initialisation
	c:=0;
	r:=[];
	x:=w![1];
	n:=Length(x);
	debut:=[];
	s:=1;
	ng:= FamilyObj(w)!.SLPrank;
	T:=SubLengths(w);
	
	#Travail pour le debut
	while c<>i do
	Print(x[n]);
		if s>0 then 
			j:=1;
			while c<i and j<Length(x[n]) do                   #On parcourt grossièrement la liste 
			c:=c+T[x[n][j]]*AbsInt(x[n][j+1]);
			j:=j+2;
			od;
			if c<l then 
				for k in [Length(x[n])-1,Length(x[n])-3..j] do    #On récupère la partie de la liste qui nous intéresse (à l'enver) sans prendre l'élément de travail
					Add(debut,x[n][k]);
					Add(debut,x[n][k+1]);
				od;
			fi;
		elif s<0 then 
			j:=Length(x[n])-1;
			while c<i and j>0 do                              #On parcourt grossièrement la liste 
			c:=c+T[x[n][j]]*AbsInt(x[n][j+1]);
			j:=j-2;
			od;
			if c<l then
				for k in [1,3..j] do #On récupère la partie de la liste qui nous intéresse (à l'enver) sans prendre l'élément de travail
					Add(debut,x[n][k]);
					Add(debut,x[n][k+1]);
				od;
			fi;
		fi;
		Print(",",j);
		if s>0 and j-2>0 then 
				j:=j-2;
		elif s<0 and j+2<Length(x[n]) then 
				j:=j+2;
		fi;
		Print(",",j);
		if AbsInt(x[n][j+1])<>1 and c<>i then                #Si la puissance est différente de -1 ou 1 on affine la sélection 
			c:= c-T[x[n][j]]*AbsInt(x[n][j+1]);
			k:=0;
			while c<i do 
				c:=c+T[x[n][j]];
				k:=k+1;
			od;
			if c<>i then 
				if AbsInt(x[n][j+1])-k <>0 then				#Si on garde une partie des puissance on l'ajoute à la fin de la liste 
					if c<=l then 
						Add(debut,x[n][j]);
						Add(debut,(AbsInt(x[n][j+1])-k)*SignInt(x[n][j+1]));
					fi;
					s:=s*SignInt(x[n][j+1]);
					c:=c-T[x[n][j]];
					n:=x[n][j]-ng;
								
				else                                        #Dans tous les cas on met à jour n et s pour recommencer la boucle 
					s:=s*SignInt(x[n][j+1]);
					c:=c-T[x[n][j]];
					n:=x[n][j]-ng;
				fi;
			else
				if c<=l then 
						Add(debut,x[n][j]);
						Add(debut,(AbsInt(x[n][j+1])-k)*SignInt(x[n][j+1]));
					fi;
					s:=s*SignInt(x[n][j+1]);
					c:=c-T[x[n][j]];
					n:=x[n][j]-ng;
			fi;
		elif AbsInt(x[n][j+1])=1 and c<>i then             #on met à jour n et s pour recommencer la boucle
			s:=s*SignInt(x[n][j+1]);
			c:=c-T[x[n][j]];
			n:=x[n][j]-ng;
		fi;
	od;
	return(debut);
	end);
	

	