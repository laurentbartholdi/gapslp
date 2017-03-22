#############################################################################
##
##
## gapslp package: SLP for free groups
##
##  Copyright 2016-2017
##    Laurent Bartholdi, Ecole Normale Supérieur d'Ulm
##    Juliette Ortholand, Mines ParisTech
##
## Licensed ????
##
#############################################################################

#! @Chapter gapslp


#! @Section ??

#! @Description
#!   The family of SLP words
DeclareCategory( "IsSLPWordsFamily", IsAssocWordFamily );

#! @Description
#!   ????
DeclareInfoClass( "InfoSLP" );

#! @Description
#!   The representation of SLP words. It is by a list of lists of integers.
#!   Each list is an instruction in the SLP, and follows the format of
#!   associative words in syllable representation.
DeclareRepresentation( "IsSLPAssocWordRep", IsAssocWord, [] );


#! @Section The LetterRepOfAssocWord() function

#! @Description
#!   This attribute allows to convert words in slp representation in letter representation. 
#!   It uses the function LetterRepAssocWord() to creat the list and then return the associate word.
#! @Returns nothing
#! @Arguments [w]
DeclareAttribute( "LetterRepOfAssocWord", IsAssocWord );

#! @Section The SLPRepOfAssocWord() function

#! @Description
#!   This attribute allows to convert words in letter or syllable representation in slp representation. 
#!   ??????????????????????????????????????????
#! @Returns nothing
#! @Arguments [w]
DeclareAttribute( "SLPRepOfAssocWord", IsAssocWord );

#! @Section The SubLengths() function

#! @Description
#!   This attribute returns a list composed of the length of each word created by the sublists. 
#! 
#! The parameters have the following meanings:
#! <List>
#!
#! <Mark><A>w</A></Mark>
#! <Item>
#!     w is the input word. It has to be an associative word in a slp representation. 
#! </Item>
#!
#! <Mark><A>x</A></Mark>
#! <Item>
#!     x is the name of the list of list associate with the word in input. 
#!     It doesn't contain the generators, and we can consider that if it a 
#!     list of empty list, the word is equal to identity. 
#! </Item>
#!
#! <Mark><A>ng</A></Mark>
#! <Item>
#!     ng is computed with FamilyObj(w)!.SLPrank and w the input word. It 
#!     an integer that corresponds to the number of generator of the group.  
#! </Item>
#!
#! <Mark><A>t</A></Mark>
#! <Item>
#!     t is an interger that allows the algorithm to for each sublist to calculate 
#!     the length of the subword. It is calculate thought the absolute value of exponent
#!     and the length of call sublists.  
#! </Item>
#!
#! <Mark><A>T</A></Mark>
#! <Item>
#!     T is the list that is constructed throught the algorithm and then returned.  
#! </Item>
#! </List>
#!
#! @Returns nothing
#! @Arguments [w]
DeclareAttribute("SubLengths",IsAssocWord and IsSLPAssocWordRep);

#! @Section The LengthOfMaximalCommonPrefix() function

#! @Description
#!   This function returns the length of the maximal common prefixe of two words in SLP representation. 
#! 
#! The parameters have the following meanings:
#! <List>
#!
#! <Mark><A>w</A></Mark>
#! <Item>
#!     w is the first input word. It has to be an associative word in a slp representation. 
#! </Item>
#!
#! <Mark><A>z</A></Mark>
#! <Item>
#!     z is the second input word. It has to be an associative word in a slp representation. 
#! </Item>
#!
#! <Mark><A>n</A></Mark>
#! <Item>
#!     n is the length of the word w. Then it corresponds to the number of element in the word.
#! </Item>
#!
#! <Mark><A>m</A></Mark>
#! <Item>
#!     m is the length of the word z. Then it corresponds to the number of element in the word.
#! </Item>
#!
#! <Mark><A>D</A></Mark>
#! <Item>
#!     D is a lookup dictionary that is mandatory to work with the function EQ_SLP"at"(). 
#!     For each call of this function it will stock the information regarding the equality 
#!     of the subword and then avoid the algorithm to do twice exaclty the same call. 
#! </Item>
#!
#! <Mark><A>B</A></Mark>
#! <Item>
#!     B is a boleen that takes the value of the fonction EQ_SLP"at" for different subword 
#!     of w and z, in order to find the prefixe of those two word.
#! </Item>
#!
#! <Mark><A>a</A></Mark>
#! <Item>
#!     a is the lower bound of the dichotomy algorithm applied to find the length of the 
#!     common prefixe. Then a tend to the length of common prefixe. 
#! </Item>
#!
#! <Mark><A>b</A></Mark>
#! <Item>
#!     b is the upper bound of the dichotomy algorithm applied to find the length of the 
#!     common prefixe. Then b tend to the length of common prefixe. 
#! </Item>
#!        
#! @Returns nothing
#! @Arguments [w,z]
DeclareOperation("LengthOfMaximalCommonPrefix",[IsAssocWord and IsSLPAssocWordRep,IsAssocWord and IsSLPAssocWordRep]);

#! @Description
#!   This function allows to test if a word is reduced or not. 
#!   A reduced word is a word without possible simplification.   
#! @Returns nothing
#! @Arguments [w]
DeclareAttribute("IsReducedWord",  IsAssocWord );

