#
# gapslp: SLP for free groups
#
# Reading the declaration part of the package.
#

## On cherche a reproduire ce qui a été fait avec les Représentation SyllableFamily//LeeterFamily 

# On déclare une catégorie qui hérite de IsAssocWordFamily:
DeclareCategory( "IsSLPWordsFamily", IsAssocWordFamily );

#On déclare une représentation associée: 
DeclareRepresentation( "IsSLPAssocWordRep", IsAssocWord, [] );

#On déclare une fonction qui convertit en SLP :
DeclareOperation( "AssocWordBySLPRep",[IsAssocWord] );

ReadPackage( "gapslp", "gap/gapslp.gd");
