#############################################################################
##
#F  SLPOfAssocWord_LZ78( <word> ) . . . . . . . . . . . . . . . . . . . . . .
#F  . . . . . . . . . . . . . .  Returns the LZ78 compression of a given word
##
##  <#GAPDoc Label="SLPOfAssocWord_LZ78">
##  <ManSection>
##  <Func Name="SLPOfAssocWord_LZ78" Arg="word"/>
##
##  <Description>
##  Returns the LZ78 compression of a <A>word</A>.
##  The algorithm takes linear time with respect to the letter representation
##  of the given <A>word</A>.
##  The approximation ratio of LZ78 is proved to be
##  O((n/log n)^(2/3)) and Theta((n^(2/3))/(log n)).
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareGlobalFunction( "SLPOfAssocWord_LZ78" );
