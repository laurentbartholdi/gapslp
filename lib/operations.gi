#
# gapslp: SLP for free groups
#
# Implementations 
#
#############################################################################
##Fonction égalité

BindGlobal("EQ_SLP@", fail); # shut up warnings
MakeReadWriteGlobal("EQ_SLP@");
EQ_SLP@ := function(x,y,D,s)
    local x2,
          y2,
          x1,
          y1,
          e1,
          e2,
          n,
          m,
          lx,
          ly,
          B1,
          B2;

    #Initialisation
    n:= Length(x);
    m:=Length(y);	
    lx:=LetterRepAssocWord(x);
    ly:=LetterRepAssocWord(y);
    if n<>m then 
        return false;
    elif n=1 then
        lx:=LetterRepAssocWord(x);
        ly:=LetterRepAssocWord(y);
        AddDictionary(D,[1+s,1+s],lx[1]=ly[1]);
        return lx=ly;
    elif n=0 then 
        return(n=m);
    elif m=0 then 
        return (n=m);
    else 
        x1 := Subword(x,1,Int(n/2));
        x2 := Subword(x,Int(n/2)+1,n);
        y1 := Subword(y,1,Int(m/2));
        y2 := Subword(y,Int(m/2)+1,m);
        B1 :=LookupDictionary(D,[1+s,Int(n/2)+s]);
        B2 :=LookupDictionary(D,[Int(n/2)+s,n+s]);

        if B1<> fail then 
            if B2<>fail then 
                return B1 and B2;
            else 
                e2:=EQ_SLP@(x2,y2,D,s+Int(n/2));
                AddDictionary(D,[Int(n/2)+1+s,n+s],e2);
                return e2 and B1;
            fi;
        else 
            e1:=EQ_SLP@(x1,y1,D,s);
            AddDictionary(D,[1+s,Int(n/2)+s],e1);
            if B2<>fail then 
                return e1 and B2;
            else
                e2:=EQ_SLP@(x2,y2,D,s+Int(n/2));
                AddDictionary(D,[Int(n/2)+s+1,n+s],e2);
                return e1 and e2;
            fi;
        fi;
    fi;
end;
MakeReadOnlyGlobal("EQ_SLP@");

#############################################################################
## Multiplication 

InstallMethod( \*, "for two assoc. words in SLP rep", 
        [ IsAssocWord and IsSLPAssocWordRep, 
          IsAssocWord and IsSLPAssocWordRep], function(w,z)
    local p,
          u,
          v,
          n,
          m,
          d,
          i,
          c,
          e,
          r,
          k,
          x,
          ng,
          y,
          b,
          l,
          t,
          f,
          ps,
          s;

    #Initialisation
    t:=ShallowCopy(w![1]);
    r:=[];
    l:=[];
    n:=Length(t);
    ng:=FamilyObj(w)!.SLPrank;
    if IsOne(w) then 
        return(z);
    fi;
    if IsOne(z) then 
        return(w);
    fi;

    #On pourrait rajouter un test si les mots sont égaux 
    if z=w then 
        return (z^2);
    fi;

    #Attention il faut prendre l'inverse....
    for k in [1..n-1] do 
        Add(r,t[k]);
    od;
    for k in [Length(t[n])-1,Length(t[n])-3..1] do 
        Add(l,t[n][k]);
        Add(l,-t[n][k+1]);
    od;

    Add(r,l);
    r:=AssocWordBySLP(FamilyObj(w),r);
    n:=Length(w);
    m:=Length(z);

    if w=r then 
        return(AssocWordBySLP(FamilyObj(w),[[]]));
    fi;

    p:=LengthOfMaximalCommonPrefix(r,z);
    if p=n then 
	return (Subword(z,p+1,m));
    fi;
    if p=m then 
        return (Subword(z,p+1,m));
    fi;

    u := Subword(w,1,n-p);
    v := Subword(z,p+1,m);
    d:=NewDictionary(1,true);
    e:=NewDictionary(1,true);
    r:=[];
    s:=[];

    x:=u![1];
    y:=v![1];
    n:=Length(x);
    m:=Length(y);

    for i in [1,3..Length(x[n])-1] do 
        AddDictionary(d,x[n][i],true);
    od;

    for k in [1..ng] do 
        AddDictionary(d,k,true);
        AddDictionary(e,k,k);
    od;

    for k in [n,n-1..1] do
        if LookupDictionary(d,k+ng)<>fail then 
            for i in [1,3..Length(x[k])-1] do 
                if LookupDictionary(d,x[k][i])=fail then 
                    AddDictionary(d,x[k][i],true);
                fi;
            od;
        fi;
    od;

    c:=ng+1;
    for k in [1..n-1] do
        if LookupDictionary(d,k+ng)<>fail then 
            AddDictionary(e,k+ng,c);
            c:=c+1;
            l:=[];
            for i in [1,3..Length(x[k])-1] do 
                b:=LookupDictionary(e,x[k][i]);
                if b<>fail then 
                    Add(l,b);
                    Add(l,x[k][i+1]);
                fi;
            od;
            Add(r,l);
        fi;
    od;
    ###########Renumérotation....

    f:=LookupDictionary(e,x[n][1]);
    ps:=0;
    k:=1;
    while k<=Length(x[n])-1 do 
        if f=LookupDictionary(e,x[n][k]) then 
            ps:=ps+x[n][k+1];
            k:=k+2;
        else 
            Add(s,f);
            Add(s,ps);
            f:=LookupDictionary(e,x[n][k]);
            ps:=x[n][k+1];
            k:=k+2;
        fi;
    od;
    d:=NewDictionary(1,true);
    e:=NewDictionary(1,true);

    for k in [1..ng] do 
        AddDictionary(d,k,true);
        AddDictionary(e,k,k);
    od;

    for i in [1,3..Length(y[m])-1] do 
        AddDictionary(d,y[m][i],true);
    od;

    for k in [m,m-1..1] do
        if LookupDictionary(d,k+ng)<>fail then 
            for i in [1,3..Length(y[k])-1] do 
                if LookupDictionary(d,y[k][i])=fail then 
                    AddDictionary(d,y[k][i],true);
                fi;
            od;
        fi;
    od;
    for k in [1..m-1] do 
        if LookupDictionary(d,k+ng)<>fail then 
            AddDictionary(e,k+ng,c);
            c:=c+1;
            l:=[];
            for i in [1,3..Length(y[k])-1] do 
                b:=LookupDictionary(e,y[k][i]);
                if b<>fail then 
                    Add(l,b);
                    Add(l,y[k][i+1]);
                fi;
            od;
            Add(r,l);
        fi;
    od;
    #finir de remplir intelligent
    k:=1;
    while k<=Length(y[m])-1 do 
        if f=LookupDictionary(e,y[m][k]) then 
            ps:=ps+y[m][k+1];
            k:=k+2;
        else 
            Add(s,f);
            Add(s,ps);
            f:=LookupDictionary(e,y[m][k]);
            ps:=y[m][k+1];
            k:=k+2;
        fi;
    od;
    Add(s,f);
    Add(s,ps);
    Add(r,s);
    return(AssocWordBySLP(FamilyObj(w),r));
end);

##################################################################################
##Puissance

InstallMethod( \^, "for an assoc. word with inverse in SLP rep, and an integer",
        true,
        [ IsAssocWordWithInverse and IsSLPAssocWordRep, IsInt ], 0, function(w,a)

    local  	l,
                k,
                ng,
                u,
                x,
                v,
                z,
                p,
                n,
                m,
                r;
    #Initialisation
    r:=[];
    ng:=FamilyObj(w)!.SLPrank;
    x:=ShallowCopy(w![1]);
    n:=Length(x);

    #Si la liste est vide ATTENTION CETTE CONDITION NE SUFFIT PAS 
    if a=0 then 
        return(AssocWordBySLP(FamilyObj(w),[[]]));
    fi;

    if IsOne(w) or a=1 then 
        return(w);
    fi;

    r:=INV(w);
    if a=-1 then
        return r;
    fi;
    m:=Length(w);

    p:=LengthOfMaximalCommonPrefix(r,w);
    if p<>0 then 
        u:=Subword(w, 1+p,m-p);
        v:=Subword(w,1,p);
        z:=Subword(w,p+1,m);

        u:=ShallowCopy(u![1][Length(u![1])]);
        v:=ShallowCopy(v![1][Length(v![1])]);
        z:=ShallowCopy(z![1][Length(z![1])]);
        r:=[];
        n:=Length(x);
        for k in [1..n] do 
            Add(r,x[k]);
        od;
        Add(r,v);
        l:=[];
        for k in [1..Length(u)] do 
            Add(l,u[k]);
        od;
        Add(l,Length(r)+ng);
        Add(l,a);
        l:=[];

        for k in [1..Length(z)] do 
            Add(l,z[k]);
        od;

        Add(r,l);	
    else 
        r:=[];
        n:=Length(x);
        for k in [1..n] do 
            Add(r,x[k]);
        od;
        if Length(r[n])=2 then
            r[n] := [r[n][1],a*r[n][2]];
        else
            Add(r,[Length(r)+ng,a]);
        fi;
    fi;
    return AssocWordBySLP(FamilyObj(w),r);
end);

InstallMethod(\=, "for SLP words", IsIdenticalObj,
	[IsAssocWord and IsSLPAssocWordRep,IsAssocWord and IsSLPAssocWordRep],
	function(x,y)
    return EQ_SLP@(x,y,NewDictionary([1],true),0);
end);

InstallMethod(INV,"for a SLP word",[IsAssocWordWithInverse and IsSLPAssocWordRep],
        function(w)
    local l, ln, n, x;
    x:=ShallowCopy(w![1]);
    n:=Length(x);
    l:=ShallowCopy(x[n]);
    ln:=Length(l);
    l{[ln-1,ln-3..1]} := l{[1,3..ln-1]};
    l{[ln,ln-2..2]} := -l{[2,4..ln]};
    x[n] := l;
    return AssocWordBySLP(FamilyObj(w),x);
end);

InstallMethod(INV_MUT,"for a SLP word",[IsAssocWordWithInverse and IsSLPAssocWordRep],
        INV);

InstallMethod(One, "for a SLP word", [IsAssocWordWithInverse and IsSLPAssocWordRep],
        function(w)
    return AssocWordBySLP(FamilyObj(w),[[]]);
end);


InstallMethod(\<,"for a SLP word",[IsAssocWordWithInverse and IsSLPAssocWordRep,
        IsAssocWordWithInverse and IsSLPAssocWordRep],
        function(w,z)

    local 	n,
                m,
                a,
                b,
                p;

    #Initialisation
    n:=Length(w);
    m:=Length(z);
    if n=m then 
        p:=LengthOfMaximalCommonPrefix(w,z);
        if p<n and p<m then 
            a:=Subword(w,p+1,p+1);
            b:=Subword(z,p+1,p+1);
            a:=a![1][Length(a![1])];
            b:=b![1][Length(b![1])];
            return(a[1]<b[1] or (a[1]=b[1] and a[2]<b[2]));
        elif p=n then 
            if p<m then 
                return(true);
            else 
                return(false);
            fi;
        fi;
    elif n>m then 
        return(false);
    elif n<m then 
        return(true);
    fi;
end);

InstallMethod(CyclicallyReducedWord,"for a SLP word",[IsAssocWordWithInverse and IsSLPAssocWordRep],
        function(w)
    local r,
          n,
          p;
    r:=INV(w);
    n:=Length(w);
    p:=LengthOfMaximalCommonPrefix(w,r);
    return(Subword(w,p+1,n-p));
end);
