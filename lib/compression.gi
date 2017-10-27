#############################################################################
##
#F  SLPOfAssocWord_LZ78( <word> ) . . . . . . . . . . . . . . . . . . . . . .
#F  . . . . . . . . . . . . . .  Returns the LZ78 compression of a given word
##

InstallGlobalFunction( SLPOfAssocWord_LZ78, function( word )
    local numGen, letterRep, last, tree, current, LZ78, i, gen, signum;

    if IsOne(word)
    then
        return AssocWordBySLP(FamilyObj(word),[[]]);
    fi;
    
    numGen := Length(FamilyObj(word)!.names);
    letterRep := LetterRepAssocWord(word);
    last := Remove(letterRep);
    
    tree := [List([-numGen..numGen], i->0)];
    current := 1;
    
    LZ78 := [];
    
    for i in letterRep do
        if tree[current][i+numGen+1] = 0
        then
            Append(tree, [List([-numGen..numGen], i->0)]);
            tree[current][i+numGen+1] := Length(tree);
            if i>0
            then
                gen := i;
                signum := 1;
            else
                gen := -i;
                signum := -1;
            fi;
            if current = 1
            then
                Append(LZ78, [[gen, signum]]);
            else
                Append(LZ78, [[current+numGen-1, 1, gen, signum]]);
            fi;
            current := 1;
        else
            current := tree[current][i+numGen+1];
        fi;
    od;
    
    if last>0
    then
        gen := last;
        signum := 1;
    else
        gen := -last;
        signum := -1;
    fi;
    if current = 1
    then
        Append(LZ78, [[gen, signum]]);
    else
        Append(LZ78, [[current+numGen-1, 1, gen, signum]]);
    fi;
    
    Append(LZ78, [Flat(List([1..Length(LZ78)], i->[i+numGen,1]))]);
    
    return LZ78;
end );
