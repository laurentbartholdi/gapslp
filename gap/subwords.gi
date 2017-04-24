#
# gapslp: SLP for free groups
#
# Implementations 
#
#############################################################################
##Création d'une fonction sous-mot 

InstallOtherMethod(Subword, [ IsAssocWord and IsSLPAssocWordRep, IsPosInt, IsInt ], function(w,o,l)
    local c,
          x,
          n,
          i,
          j,
          s,
          k,
          T,
          ng,
          fin,
          m,
          r,
          debut;
	
	
	#Initialisation
    c:=0;
    r:=[];
    fin:=[];
    i:=o-1;
    x:=w![1];
    n:=Length(x);
    debut:=[];
    s:=1;
    ng:= FamilyObj(w)!.SLPrank;
    T:=SubLengths(w);
    if o>l or IsOne(w) then 
        return(AssocWordBySLP(FamilyObj(w),[[]]));
    fi;
    
    #Si on commence à 0 
    if i=0 then 
        for k in [Length(x[n])-1,Length(x[n])-3..1] do
            Add(debut,x[n][k]);
            Add(debut,x[n][k+1]);
        od;
    fi;
    
    #Travail pour le debut
    while c<>i and n>0 do
        if s>0 then 
            j:=1;
            while c<i and j<Length(x[n]) do                   #On parcourt grossièrement la liste 
                c:=c+T[x[n][j]]*AbsInt(x[n][j+1]);
                j:=j+2;
            od;
            if c<l then 
                for k in [Length(x[n])-1,Length(x[n])-3..j] do    #On récupère la partie de la liste qui nous intéresse (à l'enver) sans prendre l'élément de travail
                    Add(debut,x[n][k]);
                    Add(debut,x[n][k+1]*s);
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
                    Add(debut,x[n][k+1]*s);
                od;
            fi;
        fi;
        if s>0 and j-2>0 then 
            j:=j-2;
        elif s<0 and j+2<Length(x[n]) then 
            j:=j+2;
        fi;
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
                        Add(debut,(AbsInt(x[n][j+1])-k)*SignInt(x[n][j+1])*s);
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
                    Add(debut,(AbsInt(x[n][j+1])-k)*SignInt(x[n][j+1])*s);
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

    m:=0;
    for k in [1,3..Length(debut)-1] do
        m:=m+T[debut[k]]*AbsInt(debut[k+1]);
    od;
    m:=m+i-l;


    n:=Length(x);
    c:=0;
    s:=(-1);


    while c<>m and n>0 do
        if n=Length(x) then 
            if s<0 then 
                j:=1;
                while c<m and j<Length(debut) do                   #On parcourt grossièrement la liste 
                    c:=c+T[debut[j]]*AbsInt(debut[j+1]);
                    j:=j+2;
                od;
                for k in [Length(debut)-1,Length(debut)-3..j] do    #On récupère la partie de la liste qui nous intéresse (à l'enver) sans prendre l'élément de travail
                    Add(r,debut[k]);
                    Add(r,debut[k+1]*s);
                od;

            elif s>0 then 
                j:=Length(debut)-1;
                while c<m and j>0 do                              #On parcourt grossièrement la liste 
                    c:=c+T[debut[j]]*AbsInt(debut[j+1]);
                    j:=j-2;
                od;
                for k in [1,3..j] do #On récupère la partie de la liste qui nous intéresse (à l'enver) sans prendre l'élément de travail
                    Add(r,debut[k]);
                    Add(r,debut[k+1]*s);
                od;
            fi;
            if s<0 and j-2>0 then 
                j:=j-2;
            elif s>0 and j+2<Length(debut) then 
                j:=j+2;
            fi;

            if AbsInt(debut[j+1])<>1 and c<>m then                #Si la puissance est différente de -1 ou 1 on affine la sélection 
                c:= c-T[debut[j]]*AbsInt(debut[j+1]);
                k:=0;
                while c<m do 
                    c:=c+T[debut[j]];
                    k:=k+1;
                od;

                if c<>m then 
                    if AbsInt(debut[j+1])-k <>0 then				#Si on garde une partie des puissance on l'ajoute à la fin de la liste 
                        Add(r,debut[j]);
                        Add(r,(AbsInt(debut[j+1])-k)*SignInt(debut[j+1])*s);
                        s:=s*SignInt(debut[j+1]);
                        c:=c-T[debut[j]];
                        n:=debut[j]-ng;

                    else                                        #Dans tous les cas on met à jour n et s pour recommencer la boucle 
                        s:=s*SignInt(debut[j+1]);
                        c:=c-T[debut[j]];
                        n:=debut[j]-ng;
                    fi;
                else
                    Add(r,debut[j]);
                    Add(r,(AbsInt(debut[j+1])-k)*SignInt(debut[j+1])*s);
                    s:=s*SignInt(debut[j+1]);
                    c:=c-T[debut[j]];
                    n:=debut[j]-ng; 
                fi;
            elif AbsInt(debut[j+1])=1 and c<>m then             #on met à jour n et s pour recommencer la boucle
                s:=s*SignInt(debut[j+1]);
                c:=c-T[debut[j]];
                n:=debut[j]-ng;
            fi;

        else 
            if s>0 then 
                j:=1;
                while c<m and j<Length(x[n]) do                   #On parcourt grossièrement la liste 
                    c:=c+T[x[n][j]]*AbsInt(x[n][j+1]);
                    j:=j+2;
                od;
                for k in [Length(x[n])-1,Length(x[n])-3..j] do    #On récupère la partie de la liste qui nous intéresse (à l'enver) sans prendre l'élément de travail
                    Add(r,x[n][k]);
                    Add(r,x[n][k+1]*s);
                od;
            elif s<0 then 
                j:=Length(x[n])-1;
                while c<m and j>0 do                              #On parcourt grossièrement la liste 
                    c:=c+T[x[n][j]]*AbsInt(x[n][j+1]);
                    j:=j-2;
                od;
                for k in [1,3..j] do #On récupère la partie de la liste qui nous intéresse (à l'enver) sans prendre l'élément de travail
                    Add(r,x[n][k]);
                    Add(r,x[n][k+1]*s);
                od;
            fi;
            if s>0 and j-2>0 then 
                j:=j-2;
            elif s<0 and j+2<Length(x[n]) then 
                j:=j+2;
            fi;
            if AbsInt(x[n][j+1])<>1 and c<>m then                #Si la puissance est différente de -1 ou 1 on affine la sélection 
                c:= c-T[x[n][j]]*AbsInt(x[n][j+1]);
                k:=0;
                while c<m do 
                    c:=c+T[x[n][j]];
                    k:=k+1;
                od;
                if c<>m then 
                    if AbsInt(x[n][j+1])-k <>0 then				#Si on garde une partie des puissance on l'ajoute à la fin de la liste 
                        Add(r,x[n][j]);
                        Add(r,(AbsInt(x[n][j+1])-k)*SignInt(x[n][j+1])*s);
                        s:=s*SignInt(x[n][j+1]);
                        c:=c-T[x[n][j]];
                        n:=x[n][j]-ng;
                    else                                        #Dans tous les cas on met à jour n et s pour recommencer la boucle 
                        s:=s*SignInt(x[n][j+1]);
                        c:=c-T[x[n][j]];
                        n:=x[n][j]-ng;
                    fi;
                else
                    Add(r,x[n][j]);
                    Add(r,(AbsInt(x[n][j+1])-k)*SignInt(x[n][j+1])*s);
                    s:=s*SignInt(x[n][j+1]);
                    c:=c-T[x[n][j]];
                    n:=x[n][j]-ng;
                fi;
            elif AbsInt(x[n][j+1])=1 and c<>m then             #on met à jour n et s pour recommencer la boucle
                s:=s*SignInt(x[n][j+1]);
                c:=c-T[x[n][j]];
                n:=x[n][j]-ng;
            fi;
        fi;
    od;


    if m=0 then 
        if Length(debut)>=4 then 
            if s<0 then 
                for k in [Length(debut)-1,Length(debut)-3..1] do
                    Add(r,debut[k]);
                    Add(r,debut[k+1]);
                od;
            else 
                for k in [1,3..Length(debut)-1] do
                    Add(r,debut[k]);
                    Add(r,debut[k+1]*(-1));
                od;
            fi;
        else 
            Add(r,debut[1]);
            Add(r,debut[2]*s*(-1));
        fi;
        for k in [1..Length(x)-1] do 
            Add(fin,x[k]);
        od;
        Add(fin,r);
    else 
        debut:=[];
        for k in [1,3..Length(r)-1] do
            Add(debut,r[k]);
            Add(debut,r[k+1]*(-1));
        od;
        for k in [1..Length(x)-1] do 
            Add(fin,x[k]);
        od;
        Add(fin,debut);
    fi;

    return(AssocWordBySLP(FamilyObj(w),fin));	
end);

#################################################################################
##Prefixe 

InstallMethod(LengthOfMaximalCommonPrefix, [ IsAssocWord and IsSLPAssocWordRep, IsAssocWord and IsSLPAssocWordRep ],
        function(w,z) 
    local n,
          m,
          D,
          B,
          a,
          b,
          u,
          min,
          max,
          c,
          e,
          v;


    #Initialisation
    D:=NewDictionary([1,2],true);
    n:=Length(w);
    m:=Length(z);
    B:=EQ_SLP@(w,z,D,0);
	
	if n=0 or m=0 then 
		return(0);
	fi;
	
    if B then 
        return(n);
    fi;

    if n>m then
        max:=n;
        min:=m;
    else 
        max:=m;
        min:=n;
    fi;

    a:=1;
    b:=min;

    while a<>b do
        u:=Subword(w,a,b);
        v:=Subword(z,a,b);
        B:=EQ_SLP@(u,v,D,0);
        if B then 
            c:=b;
            b:=b+Int((b-a)/2);
            if b>min then 
                b:=min;
            fi;
            a:=c;
        else
            b:=b-Int((b-a+1)/2);
        fi;
    od;

    u:=Subword(w,a,b);
    v:=Subword(z,a,b);
    B:=EQ_SLP@(u,v,D,0);
    if B then 
        return(b);
    else 
        return(b-1);
    fi;
end);
