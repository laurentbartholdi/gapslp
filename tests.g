#Document de test 

f:=FreeGroup(IsSLPWordsFamily,2);

###################################################################
##Fonctions 

#EstVide 
h:= AssocWordBySLPRep(FamilyObj(f.1),[[2,2],[1,3],[1,2,1,3],[5,2,3,5],[3,1,4,1],[3,1,4,1],[]]);
gap> EstVide(h);
true

###################################################################
##methodes d'impression 

#PrintObj
t:= AssocWordBySLPRep(FamilyObj(f.1),[[1,2,1,-2]]);
h:= AssocWordBySLPRep(FamilyObj(f.1),[[2,2],[1,3],[1,2,1,3],[5,2,3,5],[3,1,4,1],[3,1,4,1],[1,1]]);
o:=AssocWordBySLPRep(FamilyObj(f.1),[[2,2],[2,1],[3,2,1,2],[1,2],[3,1,4,1],[1,2],[2,3],[3,1,4,1],[7,1,10,1]] );
x:=AssocWordBySLPRep(FamilyObj(f.1),[[2,2],[1,3],[3,1,4,1],[3,1,5,1,]]);
y:=AssocWordBySLPRep(FamilyObj(f.1),[[2,2],[1,3],[3,1,4,1],[5,-1,4,1]]);

#Display
o:=AssocWordBySLPRep(FamilyObj(f.1),[[2,2],[2,1],[3,2,1,2],[1,2],[3,1,4,1],[1,2],[2,3],[3,1,4,1],[7,1,10,1]] );
x:=AssocWordBySLPRep(FamilyObj(f.1),[[2,2],[1,3],[3,1,4,1],[3,1,5,1,]]);
Display(o);
Display(x);



###########################################################
##Longueur 

#Longueur d'un mot (Length)
t:= AssocWordBySLPRep(FamilyObj(f.1),[[2,1],[1,1,2,1],[3,2],[4,-3]]);
i:= AssocWordBySLPRep(FamilyObj(f.1),[[1,1,2,1],[1,2,3,2],[2,3],[4,1,5,1]]);
gap> Length(t);
6
gap> Length(i);
9

#SubLengths  
y:=AssocWordBySLPRep(FamilyObj(f.1),[[2,2],[1,3],[3,-1,4,1],[5,1,4,-1]]);
SubLengths(y);

y:=AssocWordBySLPRep(FamilyObj(f.1),[[2,3],[1,4],[3,25,4,-1]]);
SubLengths(y);

y:=AssocWordBySLPRep(FamilyObj(f.1),[[2,3],[3,25,1,4],[4,1]]);
SubLengths(y);


#######################################################################
##Conversion en format lettre 
t:=AssocWordBySLPRep(FamilyObj(f.1),[[2,2],[1,3],[3,-13,4,1],[3,-12,4,1],[6,1,5,24,4,-1]]); 
LetterRepAssocWord(t);

##########################################################################
#SubWord
##Ne marche pas !! Resoudre pb
t:=AssocWordBySLPRep(FamilyObj(f.1),[[2,2],[1,3],[3,-13,4,1],[3,-12,4,1],[6,1,5,24,4,-1]]);
Subword(t,17,18);

t:=AssocWordBySLPRep(FamilyObj(f.1),[[2,2],[3,3,2,4],[4,1,1,1],[5,3,2,14]]);
Subword(t,38,3);