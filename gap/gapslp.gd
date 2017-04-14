#############################################################################
##
## gapslp package: SLP for free groups
##
##  Copyright 2016-2017
##    Laurent Bartholdi, Ecole Normale Supérieure d'Ulm
##    Juliette Ortholand, Mines ParisTech
##
##
#############################################################################

#! @Chapter GAP code

#! SLP words are represented as lists of lists of integers.
#! Each list is an instruction in the SLP, and follows the format of
#! associative words in syllable representation. The result of the SLP is the
#! last list.

#! @Section SLP declarations and operations

DeclareCategory( "IsSLPWordsFamily", IsAssocWordFamily );
DeclareRepresentation( "IsSLPAssocWordRep", IsAssocWord, [] );

#! @Description
#!   The info class, for messaging
DeclareInfoClass( "InfoSLP" );

#! @Description
#!   Convert a word from any (e.g. slp) representation to letter representation.
#! @Returns a word in letter representation
#! @Arguments [w]
DeclareAttribute( "LetterRepOfAssocWord", IsAssocWord );

#! @Description
#!   Convert a word from any (e.g. slp) representation to SLP representation. 
#! @Returns a word in SLP representation
#! @Arguments [w]
DeclareAttribute( "SLPRepOfAssocWord", IsAssocWord );

#! @Description
#!   Convert a word from any (e.g. slp) representation to syllable representation. 
#! @Returns a word in syllable representation
#! @Arguments [w]
DeclareAttribute( "SyllableRepOfAssocWord", IsAssocWord );

#! @Description
#!   Compute the lengths of every instruction in an SLP.
#! @Returns A list of integers.
#! @Arguments [w]
DeclareAttribute("SubLengths",IsAssocWord and IsSLPAssocWordRep);

#! @Description
#!   Compute the length of the maximal common prefix (initial subword) of two
#!   associative words.
#! @Returns A non-negative integer.
#! @Arguments [w,z]
DeclareOperation("LengthOfMaximalCommonPrefix",[IsAssocWord,IsAssocWord]);

# this is in FGA, we just redeclare it
if not IsBound(CyclicallyReducedWord) then
    DeclareOperation("CyclicallyReducedWord", [IsAssocWord]);
fi;

#! @EndSection
