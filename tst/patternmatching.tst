#############################################################################
##
#F  Occurences( <text> , <pattern> ) . . . . . . . . . . . . . . . . . . . . 
#F  . . . . . . . . Returns the list of occurences of the pattern in the text
##

#LC1-1
#RC1-1
gap> f := FreeGroup(IsSLPWordsFamily,3);;
gap> textSLP := AssocWordBySLP(FamilyObj(f.1), [[1,1,2,1],[4,1,3,1],[5,1,5,1],[6,1,6,1],[7,1,7,1],[8,1,8,1],[9,1,9,1]]);;
gap> patternSLP := AssocWordBySLP(FamilyObj(f.1), [[1,1,2,1],[4,1,3,1],[5,1,5,1],[6,1,6,1],[3,1,7,1],[7,1,1,1],[8,1,9,1]]);;
gap> Occurences(textSLP, patternSLP)[Length(Occurences(textSLP, patternSLP))] = [24,3,8];
true
gap> #LC1-1, RC1-1 with additional nonterminal encoding a single terminal.
gap> f := FreeGroup(IsSLPWordsFamily,3);;
gap> textSLP := AssocWordBySLP(FamilyObj(f.1), [[1,1],[4,1,2,1],[5,1,3,1],[6,1,6,1],[7,1,7,1],[8,1,8,1],[9,1,9,1],[10,1,10,1]]);;
gap> patternSLP := AssocWordBySLP(FamilyObj(f.1), [[1,1,2,1],[4,1,3,1],[5,1,5,1],[6,1,6,1],[3,1,7,1],[7,1,1,1],[8,1,9,1]]);;
gap> Occurences(textSLP, patternSLP)[Length(Occurences(textSLP, patternSLP))] = [24,3,8];
true
gap> #LC1-1
gap> #RC1-1
gap> f := FreeGroup(IsSLPWordsFamily,3);;
gap> textSLP := AssocWordBySLP(FamilyObj(f.1), [[1,1,2,1],[4,1,3,1],[5,1,5,1],[6,1,6,1],[7,1,7,1],[8,1,8,1],[9,1,9,1]]);;
gap> patternSLP := AssocWordBySLP(FamilyObj(f.1), [[1,1,2,1], [4,1,3,1], [5,1,5,1], [6,1,6,1], [3,1,7,1], [7,1,1,1], [8,1,9,1]]);;
gap> Occurences(textSLP, patternSLP)[Length(Occurences(textSLP, patternSLP))] = [24,3,8];
true
gap> #LC1-1
gap> f := FreeGroup(IsSLPWordsFamily,3);;
gap> textSLP := AssocWordBySLP(FamilyObj(f.1), [[1,1,2,1], [4,1,3,1], [5,1,5,1], [6,1,6,1], [7,1,7,1], [8,1,8,1], [9,1,9,1]]);;
gap> patternSLP := AssocWordBySLP(FamilyObj(f.1), [[1,1,2,1], [4,1,3,1], [5,1,5,1], [6,1,6,1], [3,1,7,1], [6,1,1,1], [9,1,2,1], [8,1,10,1]]);;
gap> Occurences(textSLP, patternSLP)[Length(Occurences(textSLP, patternSLP))] = [30,3,6];
true
gap> #LC1-2
gap> #RC1-2
gap> f := FreeGroup(IsSLPWordsFamily,3);;
gap> textSLP := AssocWordBySLP(FamilyObj(f.1), [[1,1,2,1], [4,1,3,1], [5,1,5,1], [6,1,6,1], [7,1,7,1], [8,1,8,1]]);;
gap> patternSLP := AssocWordBySLP(FamilyObj(f.1), [[1,1,2,1], [4,1,3,1], [5,1,5,1], [6,1,6,1], [3,1,7,1], [7,1,1,1], [8,1,9,1]]);;
gap> Occurences(textSLP, patternSLP)[Length(Occurences(textSLP, patternSLP))] = [3,3,6];
true
gap> #LC2
gap> f := FreeGroup(IsSLPWordsFamily,3);;
gap> textSLP := AssocWordBySLP(FamilyObj(f.1), [[1,1,2,1], [4,1,3,1], [5,1,5,1], [6,1,6,1], [7,1,3,1], [8,1,6,1], [7,1,9,1]]);;
gap> patternSLP := AssocWordBySLP(FamilyObj(f.1), [[1,1,2,1], [4,1,3,1], [5,1,5,1], [6,1,6,1], [5,1,6,1], [3,1,5,1], [8,1,9,1], [7,1,10,1]]);;
gap> Occurences(textSLP, patternSLP)[Length(Occurences(textSLP, patternSLP))] = [4,0,0];
true
gap> #RC2
gap> f := FreeGroup(IsSLPWordsFamily,3);;
gap> textSLP := AssocWordBySLP(FamilyObj(f.1), [[2,1,1,1], [3,1,4,1], [5,1,5,1], [6,1,6,1], [3,1,7,1], [6,1,8,1], [9,1,7,1]]);;
gap> patternSLP := AssocWordBySLP(FamilyObj(f.1), [[2,1,1,1], [3,1,4,1], [5,1,5,1], [6,1,6,1], [6,1,5,1], [5,1,3,1], [9,1,8,1], [10,1,7,1]]);;
gap> Occurences(textSLP, patternSLP)[Length(Occurences(textSLP, patternSLP))] = [4,0,0];
true
gap> #LC3
gap> f := FreeGroup(IsSLPWordsFamily,3);;
gap> textSLP := AssocWordBySLP(FamilyObj(f.1), [[1,1,2,1], [4,1,3,1], [5,1,5,1], [6,1,6,1], [5,1,3,1], [8,1,5,1], [7,1,9,1], [7,1,10,1]]);;
gap> patternSLP := AssocWordBySLP(FamilyObj(f.1), [[1,1,2,1], [4,1,3,1], [5,1,5,1], [6,1,6,1], [6,1,3,1], [7,1,8,1]]);;
gap> Occurences(textSLP, patternSLP)[Length(Occurences(textSLP, patternSLP))] = [10,0,0];
true
gap> #RC3
gap> f := FreeGroup(IsSLPWordsFamily,3);;
gap> textSLP := AssocWordBySLP(FamilyObj(f.1), [[2,1,1,1], [3,1,4,1], [5,1,5,1], [6,1,6,1], [3,1,5,1], [5,1,8,1], [9,1,7,1], [10,1,7,1]]);;
gap> patternSLP := AssocWordBySLP(FamilyObj(f.1), [[2,1,1,1], [3,1,4,1], [5,1,5,1], [6,1,6,1], [3,1,6,1], [8,1,7,1]]);;
gap> Occurences(textSLP, patternSLP)[Length(Occurences(textSLP, patternSLP))] = [4,0,0];
true
gap> #LC4-1
gap> f := FreeGroup(IsSLPWordsFamily,5);;
gap> textSLP := AssocWordBySLP(FamilyObj(f.1), [[1,1,2,1], [6,1,3,1], [7,1,4,1], [8,1,5,1], [9,1,9,1], [10,1,10,1], [9,1,11,1], [1,1,5,1], [11,1,13,1], [14,1,10,1], [12,1,15,1]]);;
gap> patternSLP := AssocWordBySLP(FamilyObj(f.1), [[1,1,2,1], [6,1,3,1], [7,1,4,1], [8,1,5,1], [9,1,9,1], [10,1,10,1], [1,1,5,1], [10,1,12,1], [11,1,13,1]]);;
gap> Occurences(textSLP, patternSLP)[Length(Occurences(textSLP, patternSLP))] = [16,0,0];
true
gap> #RC4-1
gap> f := FreeGroup(IsSLPWordsFamily,5);;
gap> textSLP := AssocWordBySLP(FamilyObj(f.1), [[2,1,1,1], [3,1,6,1], [4,1,7,1], [5,1,8,1], [9,1,9,1], [10,1,10,1], [11,1,9,1], [5,1,1,1], [13,1,11,1], [10,1,14,1], [15,1,12,1]]);;
gap> patternSLP := AssocWordBySLP(FamilyObj(f.1), [[2,1,1,1], [3,1,6,1], [4,1,7,1], [5,1,8,1], [9,1,9,1], [10,1,10,1], [5,1,1,1], [12,1,10,1], [13,1,11,1]]);;
gap> Occurences(textSLP, patternSLP)[Length(Occurences(textSLP, patternSLP))] = [11,0,0];
true
gap> #LC4-2
gap> f := FreeGroup(IsSLPWordsFamily,5);;
gap> textSLP := AssocWordBySLP(FamilyObj(f.1), [[1,1,2,1], [6,1,3,1], [7,1,4,1], [8,1,5,1], [9,1,9,1], [10,1,10,1], [9,1,11,1], [1,1,4,1], [11,1,13,1], [14,1,10,1], [12,1,15,1]]);;
gap> patternSLP := AssocWordBySLP(FamilyObj(f.1), [[1,1,2,1], [6,1,3,1], [7,1,4,1], [8,1,5,1], [9,1,9,1], [10,1,10,1], [1,1,5,1], [10,1,12,1], [11,1,13,1]]);;
gap> Occurences(textSLP, patternSLP)[Length(Occurences(textSLP, patternSLP))] = [];
true
gap> #RC4-2
gap> f := FreeGroup(IsSLPWordsFamily,5);;
gap> textSLP := AssocWordBySLP(FamilyObj(f.1), [[2,1,1,1], [3,1,6,1], [4,1,7,1], [5,1,8,1], [9,1,9,1], [10,1,10,1], [11,1,9,1], [4,1,1,1], [13,1,11,1], [10,1,14,1], [15,1,12,1]]);;
gap> patternSLP := AssocWordBySLP(FamilyObj(f.1), [[2,1,1,1], [3,1,6,1], [4,1,7,1], [5,1,8,1], [9,1,9,1], [10,1,10,1], [5,1,1,1], [12,1,10,1], [13,1,11,1]]);;
gap> Occurences(textSLP, patternSLP)[Length(Occurences(textSLP, patternSLP))] = [];
true
gap> #LC5
gap> #RC5
gap> f := FreeGroup(IsSLPWordsFamily,3);;
gap> textSLP := AssocWordBySLP(FamilyObj(f.1), [[1,1,2,1], [4,1,3,1], [5,1,5,1], [6,1,6,1], [7,1,7,1]]);;
gap> patternSLP := AssocWordBySLP(FamilyObj(f.1), [[1,1,2,1], [4,1,3,1], [5,1,5,1], [6,1,6,1], [3,1,7,1], [7,1,1,1], [8,1,9,1]]);;
gap> Occurences(textSLP, patternSLP)[Length(Occurences(textSLP, patternSLP))] = [];
true
gap> #LC6
gap> f := FreeGroup(IsSLPWordsFamily,3);;
gap> textSLP := AssocWordBySLP(FamilyObj(f.1), [[1,1,2,1], [4,1,3,1], [5,1,5,1], [6,1,6,1], [7,1,3,1], [8,1,6,1], [7,1,9,1]]);;
gap> patternSLP := AssocWordBySLP(FamilyObj(f.1), [[1,1,2,1], [4,1,3,1], [5,1,5,1], [6,1,6,1], [7,1,1,1], [5,1,6,1], [3,1,5,1], [9,1,10,1], [8,1,11,1]]);;
gap> Occurences(textSLP, patternSLP)[Length(Occurences(textSLP, patternSLP))] = [];
true
gap> #RC6
gap> f := FreeGroup(IsSLPWordsFamily,3);;
gap> textSLP := AssocWordBySLP(FamilyObj(f.1), [[2,1,1,1], [3,1,4,1], [5,1,5,1], [6,1,6,1], [3,1,7,1], [6,1,8,1], [9,1,7,1]]);;
gap> patternSLP := AssocWordBySLP(FamilyObj(f.1), [[2,1,1,1], [3,1,4,1], [5,1,5,1], [6,1,6,1], [1,1,7,1], [6,1,5,1], [5,1,3,1], [10,1,9,1], [11,1,8,1]]);;
gap> Occurences(textSLP, patternSLP)[Length(Occurences(textSLP, patternSLP))] = [];
true
