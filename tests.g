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

t:=AssocWordBySLPRep(FamilyObj(f.1),[[2,2],[1,3909],[3,-18300,4,1],[3,-12008,4,1],[6,199,5,24,4,-190]]);
Subword(t,1900,88888);

t:=AssocWordBySLPRep(FamilyObj(f.1),[[2,2],[3,3,2,4],[4,1,1,1],[5,3,2,14]]);
Subword(t,38,3);

x:=AssocWordBySLPRep(FamilyObj(f.1),[[2,3],[1,2],[2,-3],[3,25,4,1,5,1]]);
LetterRepAssocWord(Subword(x,1,2));

y:=AssocWordBySLPRep(FamilyObj(f.1),[[2,3],[3,25,1,2],[4,1,2,-3]]);
LetterRepAssocWord(Subword(y,1,2));

y:=AssocWordBySLPRep(FamilyObj(f.1),[ [ 2, 3 ], [ 3, 25, 1, 2 ], [ 2, 2, 3, 1, 1, 2, 2, -3 ]]);
LetterRepAssocWord(Subword(y,1,5));

#################################################################################
##Egalité

#Equality 

x:=AssocWordBySLPRep(FamilyObj(f.1),[[2,3],[1,2],[2,-3],[3,25,4,1,5,1]]);
y:=AssocWordBySLPRep(FamilyObj(f.1),[[2,3],[3,25,1,2],[4,1,2,-3]]);
D:= NewDictionary([1,2],true);
(y,n) := Equality(x,y,D,0);

x:=AssocWordBySLPRep(FamilyObj(f.1),[[2,3],[1,2],[2,-3],[3,25,4,-1,5,1]]);
y:=AssocWordBySLPRep(FamilyObj(f.1),[[2,3],[3,25,1,2],[4,1,2,-3]]);
D:= NewDictionary([1,2],true);
Equality(y,x,D,0);

x:=AssocWordBySLPRep(FamilyObj(f.1),[[2,3],[1,4],[3,25,4,-1]]);
y:=AssocWordBySLPRep(FamilyObj(f.1),[[2,3],[3,25,1,4],[4,1]]);
D:= NewDictionary([1,2],true);
Equality(y,x,D,0);