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
t:= NewSLP(FamilyObj(f.1),[[2,1],[1,1,2,1],[3,2],[4,-3]]);
i:= NewSLP(FamilyObj(f.1),[[1,1,2,1],[1,2,3,2],[2,3],[4,1,5,1]]);
t*i;
t:= NewSLP(FamilyObj(f.1),[[1,2,1,-2]]);
h:= NewSLP(FamilyObj(f.1),[[2,2],[1,3],[1,2,1,3],[5,2,3,5],[3,1,4,1],[3,1,4,1],[1,1]]);
o:=NewSLP(FamilyObj(f.1),[[2,2],[2,1],[3,2,1,2],[1,2],[3,1,4,1],[1,2],[2,3],[3,1,4,1],[7,1,10,1]] );
x:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,1,4,1],[3,1,5,1,]]);
y:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,1,4,1],[5,-1,4,1]]);

#Test Chomsky 
t:=NewSLP(FamilyObj(f.1),[[],[],[3,1,4,1],[1,2,4,1]]);

#test fin :
y:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,-1,4,1],[5,1,4,-1]]);
x:=Convert(y);
L:= [[2,2],[1,3],[3,-13,4,1],[5,25,4,-1]];
i:=4;
A:=4;
ng:=2;
e:=0;
T:=[1,1,2,3,5,8];
debut(L,i,A,ng,e,T);

#Test Coupe mot
y:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,-13,4,1],[5,25,4,-1]]);
x:=CoupeMot(y,4,30);
Convert(y);
Convert(x);

 #test convert
t:=NewSLP(FamilyObj(f.1),[[2,2],[1,3],[3,-13,4,1],[3,-12,4,1],[6,1,5,24,4,-1]]); 
Convert(t);

#Test 01/12
i:= NewSLP(FamilyObj(f.1),[[1,1,2,1],[1,1,3,1]]);
#Test 02/12 
i:=[[1,1,2,1,4],[1,-1,1,1,6],[1,1,2,1,4]];

#Test fonction récursive:
 F:=function (t)
	if t=16 then 
		c:=1;
	if t=1 then
		return true;
	elif t<1 then 
		return false;
	else 
		return F(t/2);
	fi;
	end;
	