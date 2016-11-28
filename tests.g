f:=FreeGroup(IsSLPWordsFamily,2);
t:=f.1^5;
Subword(t,2,3);
EliminatedWord(t,f.1,f.2);


#Test
t:=PD(f.1,f.2);
i:=PG(f.2,t);
P(i,t);


#test 25/11
f:=FreeGroup(IsSLPWordsFamily,2);
t:= NewSLP(FamilyObj(f.1),[[1,1,2,1],[3,2],[4,-3]]);
i:= NewSLP(FamilyObj(f.1),[[1,1,2,1],[1,2,3,2],[2,3],[4,1,5,1]]);
t*i;
t:= NewSLP(FamilyObj(f.1),[]);