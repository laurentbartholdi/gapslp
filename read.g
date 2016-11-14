
#
# gapslp: SLP for free groups

ReadPackage( "gapslp", "gap/gapslp.gi");

#Pour créer la nouvelle représentation il faut implémenter :


# Cette méthode va permettre de passer de la représentation en syllabe à la représentation en SLP
InstallMethod( ObjByExtRep, "letter rep family", true,
    [ IsAssocWordFamily and IsLetterWordsFamily, IsHomogeneousList ], 0,
    function( F, e )
    
# Cela reviendrai à coder l'algorithm 4 : CompressPairs page 61 de Lohrey

    return Objectify(F!.SLPWordType,[Immutable(l)]); #pour ça il faudrait implémenter SLPWordType
    end);

#Cette méthode va permettre de passer d'une représentation SLP à une représentation en syllabe

InstallMethod(ExtRepOfObj,"assoc word in letter rep",true,
  [IsAssocWord and IsLetterAssocWordRep],0,
  
#Il me semble que cette fonction correspond à l'algorithme 1 page 56 d Lohrey 

  end);



















##d'après la documentation de GAP pour créer une nouvelle représentation il faut aussi implémenter PrintObj et ViewObj, on verra ça dans un second temps.
#InstallMethod( \*, 
#InstallMethod( \^,
#InstallMethod( InverseOp


##Il faut réécrire l'initialisation de la fonction FreeGroup pour qu'elle prenne en compte les SLP, soit modifié le code déjà implémenter 
## en rajoutant la zone qui conserne les SLP, pour l'instant j'essaie de comprendre et de modifier un peu le code :

InstallGlobalFunction( FreeGroup, function ( arg )
    local names,      # list of generators names
          zarg,
          lesy,       # filter for letter or syllable words family or SLP
          F,          # family of free group element objects
          G;          # free group, result

    if ValueOption("FreeGroupFamilyType")="syllable" then
          lesy:=IsSyllableWordsFamily; # optional -- used in PQ
    if ValueOption("FreeGroupFamilyType")="letter" then
          lesy:=IsLetterWordsFamily;  
    else 
#il va falloir trouver comment accéder à la ValueOption("FreeGroupFamilyType") pour pouvoir mettre SLP
          lesy:=IsSLPWordsFamily;
    fi;
 
    if IsFilter(arg[1]) then
      lesy:=arg[1];
      zarg:=arg{[2..Length(arg)]};
    else
      zarg:=arg;
    fi;

    # Get and check the argument list, and construct names if necessary. (pas de changement si SLP)
    if   Length( zarg ) = 1 and zarg[1] = infinity then
      names:= InfiniteListOfNames( "f" );
    elif Length( zarg ) = 2 and zarg[1] = infinity then
      names:= InfiniteListOfNames( zarg[2] );
    elif Length( zarg ) = 3 and zarg[1] = infinity then
      names:= InfiniteListOfNames( zarg[2], zarg[3] );
    elif Length( zarg ) = 1 and IsInt( zarg[1] ) and 0 <= zarg[1] then
      names:= List( [ 1 .. zarg[1] ],
                    i -> Concatenation( "f", String(i) ) );
      MakeImmutable( names );
    elif Length( zarg ) = 2 and IsInt( zarg[1] ) and 0 <= zarg[1] then
      names:= List( [ 1 .. zarg[1] ],
                    i -> Concatenation( zarg[2], String(i) ) );
      MakeImmutable( names );
    elif Length( zarg ) = 1 and IsList( zarg[1] ) and IsEmpty( zarg[1] ) then
      names:= zarg[1];
    elif 1 <= Length( zarg ) and ForAll( zarg, IsString ) then
      names:= zarg;
    elif Length( zarg ) = 1 and IsList( zarg[1] )
                            and ForAll( zarg[1], IsString ) then
      names:= zarg[1];
    else
      Error("usage: FreeGroup(<name1>,<name2>..) or FreeGroup(<rank>)");
    fi;

    # deal with letter words family types
    if lesy=IsLetterWordsFamily then
      if Length(names)>127 then
        lesy:=IsWLetterWordsFamily;
      else
        lesy:=IsBLetterWordsFamily;
      fi;
    elif lesy=IsBLetterWordsFamily and Length(names)>127 then
      lesy:=IsWLetterWordsFamily;
    fi;

    # Construct the family of element objects of our group.
    F:= NewFamily( "FreeGroupElementsFamily", IsAssocWordWithInverse
                                              and IsElementOfFreeGroup,
  			  CanEasilySortElements, # the free group can.
  			  CanEasilySortElements # the free group can.
  			  and lesy); ##SLP 

    # Install the data (names, no. of bits available for exponents, types).
    StoreInfoFreeMagma( F, names, IsAssocWordWithInverse
                                  and IsElementOfFreeGroup );

    # Make the group.
    if IsEmpty( names ) then
      G:= GroupByGenerators( [], One( F ) );
    elif IsFinite( names ) then
      G:= GroupByGenerators( List( [ 1 .. Length( names ) ],
                                   i -> ObjByExtRep( F, 1, 1, [ i, 1 ] ) ) );
    else
      G:= GroupByGenerators( InfiniteListOfGenerators( F ) );
      SetIsFinitelyGeneratedGroup( G, false );
    fi;

    SetIsWholeFamily( G, true );

    # Store whether the group is trivial.
    SetIsTrivial( G, Length( names ) = 0 );

    # Store the whole group in the family.
    FamilyObj(G)!.wholeGroup := G;
    F!.freeGroup:=G;
    SetFilterObj(G,IsGroupOfFamily);

    # Return the free group.
    return G;
end );

#
# Reading the implementation part of the package.
#
