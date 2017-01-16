#Document de test 

f:=FreeGroup(IsSLPWordsFamily,2);

###################################################################
##Fonctions 

#EstVide 
h:= NewSLP(FamilyObj(f.1),[[2,2],[1,3],[1,2,1,3],[5,2,3,5],[3,1,4,1],[3,1,4,1],[]]);
EstVide(h);

###################################################################
##methodes d'impression 

#PrintObj
t:= NewSLP(FamilyObj(f.1),[[1,2,1,-2]]);
h:= NewSLP(FamilyObj(f.1),[[2,2],[1,3],[1,2,1,3],[5,2,3,5],[3,1,4,1],[3,1,4,1],[1,1]]);
o:=NewSLP(FamilyObj(f.1),[[2,2],[2,1],[3,2,1,2],[1,2],[3,1,4,1],[1,2],[2,3],[3,1,4,1],[7,1,10,1]] );
x:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,1,4,1],[3,1,5,1,]]);
y:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,1,4,1],[5,-1,4,1]]);

#Display
o:=NewSLP(FamilyObj(f.1),[[2,2],[2,1],[3,2,1,2],[1,2],[3,1,4,1],[1,2],[2,3],[3,1,4,1],[7,1,10,1]] );
x:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,1,4,1],[3,1,5,1,]]);
Display(o);
Display(x);

###################################################################
##Fonctions qui simplifient un mot

#SimplifieListe
l:=[3,10,3,-6,3,-4,2,3,2,-3];
SimplifieListe(l);

l:=[3,1,3,-6,3,-4,2,3,2,-3];
SimplifieListe(l);

#ReduceWord
y:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,-13,4,1],[5,25,4,-1]]);
x:=CoupeMot(y,2,2);
ReduceWord(x);


#########################################################################
##MULTIPLIER DEUX MOTS 

t:= NewSLP(FamilyObj(f.1),[[2,1],[1,1,2,1],[3,2],[4,-3]]);
i:= NewSLP(FamilyObj(f.1),[[1,1,2,1],[1,2,3,2],[2,3],[4,1,5,1]]);
Display(t*i);


############################################################################
##PASSER A LA PUISSANCE 

t:= NewSLP(FamilyObj(f.1),[[2,1],[1,1,2,1],[3,2],[4,-3]]);
i:= NewSLP(FamilyObj(f.1),[[1,1,2,1],[1,2,3,2],[2,3],[4,1,5,1]]);
Display(t^-5);
Display(i^5);
Display(t^0);

###########################################################
##AUTRES 

#Longueur d'un mot (Length)
t:= NewSLP(FamilyObj(f.1),[[2,1],[1,1,2,1],[3,2],[4,-3]]);
i:= NewSLP(FamilyObj(f.1),[[1,1,2,1],[1,2,3,2],[2,3],[4,1,5,1]]);
Length(t);
Length(i);

#Ecrit un mot à l'envers (à mettre à jour)

#Si on remplace un générateur par un autre générateur (à mettre à jour)


#######################################################################
##Conversion en format lettre 
t:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,-13,4,1],[3,-12,4,1],[6,1,5,24,4,-1]]); 
Convert(t);

#######################################################################
##Création du sous mot

#Taille 
y:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,-1,4,1],[5,1,4,-1]]);
Taille(y);

y:=NewSLP(FamilyObj(f.1),[[2,3],[1,4],[3,25,4,-1]]);
Taille(y);

y:=NewSLP(FamilyObj(f.1),[[2,3],[3,25,1,4],[4,1]]);
Taille(y);

#fin
y:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,-1,4,1],[5,1,4,-1]]);
x:=Convert(y);
L:= [[2,2],[1,3],[3,-13,4,1],[5,25,4,-1]];
i:=4;
A:=4;
ng:=2;
e:=0;
T:=[1,1,2,3,5,8];
fin(L,i,A,ng,e,T);

y:=NewSLP(FamilyObj(f.1),[[2,3],[1,4],[3,25,4,-1]] );
x:=Convert(y);
L:= [[2,3],[1,4],[3,25,4,-1]] ;
i:=79;
A:=3;
ng:=2;
e:=0;
T:=Taille(y);
fin(L,i,A,ng,e,T);


#debut
y:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,-1,4,1],[5,1,4,-1]]);
x:=Convert(y);
L:= [[2,2],[1,3],[3,-13,4,1],[5,25,4,-1]];
i:=4;
A:=4;
ng:=2;
e:=0;
T:=[1,1,2,3,5,8];
debut(L,i,A,ng,e,T);


y:=NewSLP(FamilyObj(f.1),[[2,3],[3,25,1,2],[4,1,2,-3]]);
x:=Convert(y);
L:= [[2,3],[3,25,1,2],[4,1,2,-3]];
i:=3;
A:=3;
ng:=2;
e:=0;
T:=Taille(y);
debut(L,i,A,ng,e,T);

#CoupeMotf
y:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,-13,4,1],[5,5,4,-1]]);
x:=CoupeMotf(y,2);
Convert(y);
Convert(x);

y:=NewSLP(FamilyObj(f.1),[[2,3],[3,25,1,2],[4,1,2,-3]]);
x:=CoupeMotf(y,76);
Convert(y);
Convert(x);

#CoupeMotd
y:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,-13,4,1],[5,5,4,-1]]);
x:=CoupeMotd(y,148);
Convert(y);
Convert(x);

y:=NewSLP(FamilyObj(f.1),[[2,3],[3,25,1,2],[4,1,2,-3]]);
x:=CoupeMotd(y,76);
Convert(y);
Convert(x);

#CoupeMot
y:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,-13,4,1],[5,25,4,-1]]);
x:=CoupeMot(y,2,728);
Convert(y);
Convert(x);

y:=NewSLP(FamilyObj(f.1),[[2,3],[3,25,1,2],[4,1,2,-3]]);
x:=CoupeMot(y,78,78);
Convert(y);
Convert(x);
###################################################################################################################
##Egalité 

#ReduceWordPart
y:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,-13,4,1],[5,25,4,-1]]);
x:=CoupeMot(y,2,2);
ReduceWordPart(x);

#Equality 
x:=f.1*f.2*f.2;
y:=f.1*f.2;
D:= NewDictionary([1,2],true);
Equality(x,y,D,0);

x:=NewSLP(FamilyObj(f.1),[[2,3],[1,2],[2,-3],[3,25,4,1,5,1]]);
y:=NewSLP(FamilyObj(f.1),[[2,3],[3,25,1,2],[4,1,2,-3]]);
D:= NewDictionary([1,2],true);
Equality(x,y,D,0);

x:=NewSLP(FamilyObj(f.1),[[2,3],[1,2],[2,-3],[3,25,4,-1,5,1]]);
y:=NewSLP(FamilyObj(f.1),[[2,3],[3,25,1,2],[4,1,2,-3]]);
D:= NewDictionary([1,2],true);
Equality(y,x,D,0);

x:=NewSLP(FamilyObj(f.1),[[2,3],[1,4],[3,25,4,-1]]);
y:=NewSLP(FamilyObj(f.1),[[2,3],[3,25,1,4],[4,1]]);
D:= NewDictionary([1,2],true);
Equality(y,x,D,0);

###############################################################################
##Prefixe
x:=NewSLP(FamilyObj(f.1),[[2,3],[1,2],[2,-3],[3,25,4,1,5,1]]);
y:=NewSLP(FamilyObj(f.1),[[2,3],[3,25,1,2],[4,1,2,-3]]);
prefixe(x,y);

#Ce test devrait renvoyer 80 mais renvoie 82...
x:=NewSLP(FamilyObj(f.1),[[2,3],[1,2],[2,-3],[3,25,4,1,5,12]]);
y:=NewSLP(FamilyObj(f.1),[[2,3],[3,25,1,2],[4,1,2,-3]]);
prefixe(x,y);

x:=NewSLP(FamilyObj(f.1),[[2,3],[1,2],[2,-3],[3,25,4,-1,5,1]]);
y:=NewSLP(FamilyObj(f.1),[[2,3],[3,25,1,2],[4,1,2,-3]]);
prefixe(x,y);
######################################################
##Autres tests

#Test 01/12
i:= NewSLP(FamilyObj(f.1),[[1,1,2,1],[1,1,3,1]]);

#Test 02/12 
i:=[[1,1,2,1,4],[1,-1,1,1,6],[1,1,2,1,4]];



