f:=FreeGroup(IsSLPWordsFamily,2);
t:=f.1^5;
Subword(t,2,3);
EliminatedWord(t,f.1,f.2);


#Test
t:=PD(f.1,f.2);
i:=PG(f.2,t);
P(i,t);


