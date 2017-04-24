# conversions

gap> g := FreeGroup(2);;
gap> a := [g.1, AsSyllableRepAssocWord(g.1), AsSLPRepAssocWord(g.1)];;
gap> b := [g.2, AsSyllableRepAssocWord(g.2), AsSLPRepAssocWord(g.2)];;
gap> c := [g.1*g.2, AsSyllableRepAssocWord(g.1*g.2), AsSLPRepAssocWord(g.1*g.2)];;
gap> List(Combinations([1..3],2),p->a[p[1]]=a[p[2]]);
[ true, true, true ]
gap> List(Tuples([1..3],2),p->a[p[1]]<b[p[2]]);
[ true, true, true, true, true, true, true, true, true ]
gap> List(Tuples([1..3],2),p->c[p[1]]<b[p[2]]);
[ false, false, false, false, false, false, false, false, false ]
gap> List(Tuples([1..3],2),p->a[p[1]]*b[p[2]]);
[ f1*f2, f1*f2, f1*f2, f1*f2, f1*f2, f1*f2, f1*f2, f1*f2, f1*f2 ]
