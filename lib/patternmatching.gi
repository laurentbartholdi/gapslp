#############################################################################
##
#F  Occurences( <text> , <pattern> ) . . . . . . . . . . . . . . . . . . . . 
#F  . . . . . . . . Returns the list of occurences of the pattern in the text
##

# This is an implementation of 
# "An improved pattern matching algorithm for strings in terms of straight-line programs"
# by Masamichi Miyazaki and Ayumi Shinohara

InstallGlobalFunction( Occurences, function( textSLP, patternSLP )
    local   Match,                  #tests text_i[start..start+len(pattern_j)-1] = pattern_j
            FirstMismatch,          #finds first Mismatch of text_i[start:] and pattern_j
            LastMismatch,           #finds last Mismatch of text_i[:start] and pattern_j
            ArithmeticUnion,        #creates one arithmetic progression from three given arithmetic progression
            CaseNumber,             #Gets the number of the case for the calculation of occL[i][j] and occR[i][j]
            CalculateOccL,          #Calculates occL[i][j]
            CalculateOccM,          #Calculates occM[i][j]
            CalculateOccR,          #Calculates occR[i][j]
            CalculateTableEntry,    #Calculates occTable[i][j]
            text, pattern,
            dSizeText,
            dSizePattern,
            lengthTableText,
            lengthTablePattern,
            occTable,
            occList,
            i, j;
            
    # Returns true if text[start..start+len(pattern)-1] = pattern
    Match := function(textIndex, patternIndex, start)
        local   progression,
                lPattern,
                lText;
        
        lText :=  lengthTableText[textIndex];
        lPattern := lengthTablePattern[patternIndex];
                
        # Check for wrong starting position
        if start <= 0 then
            return false;
        fi;
        if lText < start + lPattern - 1 then
            return false;
        fi;
        
        # if Length is 1 then Match is true iff text and pattern encode the same terminal
        if lText = 1 then
            return (text[textIndex] = pattern[patternIndex]);
        fi;
        
        if lengthTableText[text[textIndex][1]] >= start + lPattern - 1 then
            return Match(text[textIndex][1], patternIndex, start);
        elif lengthTableText[text[textIndex][1]] < start then
            return Match(text[textIndex][2], patternIndex, start-lengthTableText[text[textIndex][1]]);
        else
            progression := occTable[textIndex][patternIndex];
            if progression = [] then
                return false;
            elif start < progression[1] then
                return false;
            elif start > progression[1]+progression[2]*progression[3] then
                return false;
            elif start = progression[1] then
                return true;
            elif IsInt((start-progression[1])/progression[2]) then
                return true;
            else
                return false;
            fi;
        fi;
    end;
    
    # returns the minimum s such that X[start+s-1] != Y[s] if exists
    # and Length(Y)+1 otherwise
    FirstMismatch := function(textIndex, patternIndex, start)
        local   lPattern,
                lText;
        
        lText :=  lengthTableText[textIndex];
        lPattern := lengthTablePattern[patternIndex];
        
        if lPattern = 1 then
            if lText = 1 then
                if start > 1 then
                    return 1;
                fi;
                
                if text[textIndex] = pattern[patternIndex] then
                    return 2;
                else
                    return 1;
                fi;
            fi;
        
            if start <= lengthTableText[text[textIndex][1]] then
                return FirstMismatch(text[textIndex][1],patternIndex,start);
            else
                return FirstMismatch(text[textIndex][2],patternIndex,start-lengthTableText[text[textIndex][1]]);
            fi;
        fi;
        
        if Match(textIndex, pattern[patternIndex][1], start) then
            return lengthTablePattern[pattern[patternIndex][1]] + FirstMismatch(textIndex, pattern[patternIndex][2], start+lengthTablePattern[pattern[patternIndex][1]]);
        else
            return FirstMismatch(textIndex, pattern[patternIndex][1], start);
        fi;
    end;
    
    # returns the minimum s such that X[start-s+1] != Y[Length(Y)+1-s] if exists
    # and Length(Y)+1 otherwise
    LastMismatch := function(textIndex, patternIndex, start)
        local   lPattern,
                lText;
    
        lText :=  lengthTableText[textIndex];
        lPattern := lengthTablePattern[patternIndex];
    
        if lPattern = 1 then
            if lText = 1 then
                if start > 1 then
                    return 1;
                fi;
            
                if text[textIndex] = pattern[patternIndex] then
                    return 2;
                else
                    return 1;
                fi;
            fi;
    
            if start > lengthTableText[text[textIndex][1]] then
                return LastMismatch(text[textIndex][2], patternIndex, start-lengthTableText[text[textIndex][1]]);
            else
                return LastMismatch(text[textIndex][1], patternIndex, start);
            fi;
        fi;
    
        if Match(textIndex, pattern[patternIndex][2], start+1-lengthTablePattern[pattern[patternIndex][2]]) then
            return lengthTablePattern[pattern[patternIndex][2]] + LastMismatch(textIndex, pattern[patternIndex][1], start-lengthTablePattern[pattern[patternIndex][2]]);
        else
            return LastMismatch(textIndex, pattern[patternIndex][2], start);
        fi;
    end;
    
    # Unifies the three disjoint arithmetic progressions into one.
    # For all r in occR, m in occM and l occL r<m<l holds
    # and the union of OccR, occM and occL is guaranteed to be an arithmetic progression.
    # Also occM is guaranteed to have at most one element.
    ArithmeticUnion := function(occR, occM, occL)
        local   CountElements,
                FindSmallest,
                smallest,
                count;
                
        CountElements := function(prog)
            if prog = [] then
                return 0;
            else
                return prog[3]+1;
            fi;
        end;
        
        FindSmallest := function(prog)
            if prog = [] then
                return [];
            else
                return [prog[1], prog[1]+prog[2]];
            fi;
        end;
        
        smallest := AsSSortedList(Union(FindSmallest(occR), FindSmallest(occM), FindSmallest(occL)));
        count := CountElements(occR) + CountElements(occM) + CountElements(occL);
        
        if count = 0 then
            return [];
        elif count = 1 then
            return [smallest[1], 0, 0];
        else
            return [smallest[1], smallest[2]-smallest[1], count-1];
        fi;
        
    end;
    # END ArithmeticUnion
    
    CaseNumber := function(miss1, miss2, P, h)
        if miss1 = P+1 then
            if miss2 > P-h+1 then
                # Case 1
                return 1;
            else #miss2 <= P-h+1
                # Case 2
                return 2;
            fi;
        else
            if miss2 = P+1 then
                # Case 3
                return 3;
            elif miss2 >= miss1 then
                # Case 6
                return 6;
            elif miss2 > miss1-h+1 then
                # Case 4
                return 4;
            else #miss2 <= miss1-h+1
                # Case 5
                return 5;
            fi;
        fi;
    end;
    # END CaseNumber
    
    # Calculates occL[i][j]
    CalculateOccL := function(textIndex, patternIndex)
        local   progression,
                miss1, miss2, P, h,
                case,
                s;
                
        progression := ShallowCopy(occTable[textIndex][pattern[patternIndex][1]]);
        
        if progression = [] then
            return [];
        elif progression[3] <= 1 then
            if FirstMismatch(textIndex, patternIndex, progression[1]) > lengthTablePattern[patternIndex] then
                if FirstMismatch(textIndex, patternIndex, progression[1]+progression[2]*progression[3]) > lengthTablePattern[patternIndex] then
                    return [progression[1], progression[2], progression[3]];
                else
                    return [progression[1], 0, 0];
                fi;
            else
                if FirstMismatch(textIndex, patternIndex, progression[1]+progression[2]*progression[3]) > lengthTablePattern[patternIndex] then
                    return [progression[1]+progression[2]*progression[3],0,0];
                else
                    return [];
                fi;
            fi;
        else
            miss1 := FirstMismatch(textIndex, pattern[patternIndex][2], progression[1]+lengthTablePattern[pattern[patternIndex][1]]);
            miss2 := FirstMismatch(textIndex, pattern[patternIndex][2], progression[1]+progression[2]*progression[3]+lengthTablePattern[pattern[patternIndex][1]]);
            P := lengthTablePattern[pattern[patternIndex][2]];
            h := 1+progression[2]*progression[3];
            
            case := CaseNumber(miss1, miss2, P, h);
            
            if case = 1 then
                if Int((h+miss2-2-P)/progression[2]) = 0 then
                    return [progression[1], 0, 0];
                else
                    return [progression[1], progression[2], Int((h+miss2-2-P)/progression[2])];
                fi;
            elif case = 2 then
                return [progression[1], 0, 0];
            elif case = 3 then
                return [progression[1]+progression[2]*progression[3], 0, 0];
            elif case = 4 then
                s := h-miss1+miss2;
                
                if FirstMismatch(textIndex, pattern[patternIndex][2], s+lengthTablePattern[pattern[patternIndex][1]]+progression[1]-1) = P+1
                then
                    return [progression[1]+progression[2]*progression[3]-miss1+miss2, 0, 0];
                else
                    return [];
                fi;
            elif case = 5 then
                return [];
            else #case = 6
                return [];
            fi;  
        fi;
    end;
    # END CalculateOccL
    
    #Calculates occM[i][j]
    CalculateOccM := function(textIndex, patternIndex)
        if FirstMismatch(textIndex, patternIndex, lengthTableText[text[textIndex][1]]-lengthTablePattern[pattern[patternIndex][1]]+1) > lengthTablePattern[patternIndex] then
            return [lengthTableText[text[i][1]]-lengthTablePattern[pattern[j][1]]+1, 0, 0];
        else
            return [];
        fi;
    end;
    # END CalculateOccM
    
    #Calculates occR[i][j]
    CalculateOccR := function(textIndex, patternIndex)
        local   progression,
                miss1, miss2, P, h,
                case,
                s;
                
        progression := ShallowCopy(occTable[textIndex][pattern[patternIndex][2]]);
        
        if progression = [] then
            return [];
        elif progression[3] <= 1 then
            progression[1] := progression[1] - lengthTablePattern[pattern[patternIndex][1]];
            if FirstMismatch(textIndex, patternIndex, progression[1]) > lengthTablePattern[patternIndex] then
                if FirstMismatch(textIndex, patternIndex, progression[1]+progression[2]*progression[3]) > lengthTablePattern[patternIndex] then
                    return [progression[1], progression[2], progression[3]];
                else
                    return [progression[1], 0, 0];
                fi;
            else
                if FirstMismatch(textIndex, patternIndex, progression[1]+progression[2]*progression[3]) > lengthTablePattern[patternIndex] then
                    return [progression[1]+progression[2]*progression[3],0,0];
                else
                    return [];
                fi;
            fi;
        else
            miss1 := LastMismatch(textIndex, pattern[patternIndex][1], progression[1]+progression[2]*progression[3]-1);
            miss2 := LastMismatch(textIndex, pattern[patternIndex][1], progression[1]-1);
            P := lengthTablePattern[pattern[patternIndex][1]];
            h := 1+progression[2]*progression[3];
            
            case := CaseNumber(miss1, miss2, P, h);
            
            if case = 1 then
                if (h+miss2-2) mod progression[2] >= P mod progression[2] then
                    progression[1] := progression[1]-P;
                else
                    progression[1] := progression[1]-P+progression[2];
                fi;
                
                if Int((h+miss2-2-P)/progression[2]) = 0 then
                    return [progression[1], 0, 0];
                else
                    return [progression[1], progression[2], Int((h+miss2-2-P)/progression[2])];
                fi;
            elif case = 2 then
                return [progression[1]+progression[2]*progression[3]-P, 0, 0];
            elif case = 3 then
                return [progression[1]-P, 0, 0];
            elif case = 4 then
                s := h-miss1+miss2;
                
                if LastMismatch(textIndex, pattern[patternIndex][1],progression[1]+progression[2]*progression[3]-s) = P+1
                then
                    return [progression[1]+progression[2]*progression[3]-s+1-lengthTablePattern[pattern[patternIndex][1]], 0, 0];
                else
                    return [];
                fi;
            elif case = 5 then
                return [];
            else #case = 6
                return [];
            fi;
        fi;
    end;
    # END CalculateOccR
    
    # Calculates occTable[i][j]
    CalculateTableEntry := function(textIndex, patternIndex)
        local   occL, occM, occR;
        
        if lengthTableText[textIndex] = lengthTablePattern[patternIndex] then
            if lengthTableText[textIndex] = 1 then
                if Match(textIndex, patternIndex, 1) then
                    return [1,0,0];
                else
                    return [];
                fi;
            fi;
        else
            if lengthTableText[textIndex] = 1 then
                return [];
            fi;
            if lengthTablePattern[patternIndex] = 1 then
                return [];
            fi;
        fi;
        
        occL := CalculateOccL(textIndex, patternIndex);
        occM := CalculateOccM(textIndex, patternIndex);
        occR := CalculateOccR(textIndex, patternIndex);
        
        return ArithmeticUnion(occR,occM,occL);
        
    end;
    # END CalculateTableEntry
    
    if FamilyObj(textSLP) <> FamilyObj(patternSLP) then
        Error("The input parameters do not belong to the same group.\n");
    fi;
    
    # convert inputs to lists
    text := List([1..Length(FamilyObj(textSLP)!.names)],  i->[i]);
    for i in [1..Length(textSLP![1])] do
        if Length(textSLP![1][i]) = 2 then
            if textSLP![1][i][2]*textSLP![1][i][2] <> 1 then
                Error("Text is not in Chomsky normal form.\n");
            else
                Append(text, [[textSLP![1][i][1]*textSLP![1][i][2]]]);
            fi;
        elif Length(textSLP![1][i]) = 4 then
            if textSLP![1][i][2] <> 1 then
                Error("Text is not in Chomsky normal form.\n");
            elif textSLP![1][i][4] <> 1 then
                Error("Text is not in Chomsky normal form.\n");
            else
                Append(text, [[textSLP![1][i][1],textSLP![1][i][3]]]);
            fi;
        else
            Error("Text is not in Chomsky normal form.\n");
        fi;
    od;
    
    pattern := List([1..Length(FamilyObj(patternSLP)!.names)],  i->[i]);
    for i in [1..Length(patternSLP![1])] do
        if Length(patternSLP![1][i]) = 2 then
            if patternSLP![1][i][2]*patternSLP![1][i][2] <> 1 then
                Error("Pattern is not in Chomsky normal form.\n");
            else
                Append(pattern, [[patternSLP![1][i][1]*patternSLP![1][i][2]]]);
            fi;
        elif Length(patternSLP![1][i]) = 4 then
            if patternSLP![1][i][2] <> 1 then
                Error("Pattern is not in Chomsky normal form.\n");
            elif patternSLP![1][i][4] <> 1 then
                Error("Pattern is not in Chomsky normal form.\n");
            else
                Append(pattern, [[patternSLP![1][i][1],patternSLP![1][i][3]]]);
            fi;
        else
            Error("Pattern is not in Chomsky normal form.\n");
        fi;
    od;
    
    dSizeText := Length(text);
    dSizePattern := Length(pattern);
    
    # Get the length of the nonterminals in text
    lengthTableText := List([1..dSizeText], i->0);
    for i in [1..dSizeText] do
        if Length(text[i]) = 1
        then
            lengthTableText[i] := 1;
        else
            lengthTableText[i] := lengthTableText[text[i][1]] + lengthTableText[text[i][2]];
        fi;
    od;
    
    # Get the length of the nonterminals in pattern
    lengthTablePattern := List([1..dSizePattern], i->0);
    for i in [1..dSizePattern] do
        if Length(pattern[i]) = 1
        then
            lengthTablePattern[i] := 1;
        else
            lengthTablePattern[i] := lengthTablePattern[pattern[i][1]] + lengthTablePattern[pattern[i][2]];
        fi;
    od;
    
    # Initialize occTable
    occTable := [];
    for i in [1..dSizeText] do
        Append(occTable, [List([1..dSizePattern], i->[])]);
    od;
    
    # Calculate occTable
    for i in [1..dSizeText] do
        for j in [1..dSizePattern] do
            occTable[i][j] := CalculateTableEntry(i,j);
        od;
    od;
    
    occList := [];
    for i in [1..dSizeText] do
        if lengthTableText[i] > 1 then
            Append(occList, [occTable[i][dSizePattern]]);
        fi;
    od;
    
    return occList;
end);
