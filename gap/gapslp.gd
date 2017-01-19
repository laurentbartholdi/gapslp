#
# gapslp: SLP for free groups
#
# Declarations
#

## On cherche a reproduire ce qui a été fait avec les Représentation SyllableFamily//LeeterFamily 

# On déclare une catégorie qui hérite de IsAssocWordFamily:

#! @Description
#!   The family of SLP words
DeclareCategory( "IsSLPWordsFamily", IsAssocWordFamily );

#On déclare une représentation associée: 
#! @Description
#!   The representation of SLP words. It is by a list of lists of integers.
#!   Each list is an instruction in the SLP, and follows the format of
#!   associative words in syllable representation.
DeclareRepresentation( "IsSLPAssocWordRep", IsAssocWord, [] );

#On déclare une fonction qui convertit en SLP : entrée = famille d'un élément SLP et liste de listes
DeclareOperation( "AssocWordBySLPRep", [IsFamily,IsList] );

#On déclare une fonction qui convertit en SLP :
DeclareAttribute( "LetterRepOfAssocWord", IsAssocWord );

#On déclare l'attribut qui garde la taille de toutes les listes
DeclareAttribute("Taille",IsAssocWord and IsSLPAssocWordRep);
