#############################################################################
##
#F  Occurences( <text> , <pattern> ) . . . . . . . . . . . . . . . . . . . . 
#F  . . . . . . . . Returns the list of occurences of the pattern in the text
##
##  <#GAPDoc Label="SLPOfAssocWord_LZ78">
##  <ManSection>
##  <Func Name="Occurrences" Arg="text, pattern"/>
##
##  <Description>
##  Returns the list with the property that the i-th entry is the arithmetic
##  progression of the occurences of the <A>pattern</A> in the i-th nonterminal
##  of the <A>text</A> which are not contained in either the left nor the right
##  side of the nonterminal.
##  <A>text</A> and <A>pattern</A> have to be in Chomsky normal form.
##  This is an implementation of 
##  "An improved pattern matching algorithm for strings in terms of straight-line programs"
##  by Masamichi Miyazaki and Ayumi Shinohara
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareGlobalFunction( "Occurrences" );
