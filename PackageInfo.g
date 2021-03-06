#
# gapslp: SLP for free groups
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "gapslp",
Subtitle := "SLP for free groups",
Version := "0.2",
Date := "05/03/2018", # dd/mm/yyyy format

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Laurent",
    LastName := "Bartholdi",
    WWWHome := "http://www.uni-math.gwdg.de/laurent",
    Email := "laurent.bartholdi@gmail.com",
    PostalAddress := Concatenation(
               "Mathematisches Institut\n",
               "Bunsenstraße 3-5\n",
               "D-37073 Göttingen\n",
               "Germany" ),
    Place := "Göttingen",
    Institution := "Georg-August Universität zu Göttingen",
  ),
  rec(
    IsAuthor := true,
    IsMaintainer := false,
    FirstNames := "Juliette",
    LastName := "Ortholand",
    Institution := "Mines Paristech",
  ),
  rec(
    IsAuthor := true,
    IsMaintainer := false,
    FirstNames := "Julian",
    LastName := "Pape-Lange",
    Institution := "Georg-August Universität Göttingen",
  ),
],

SourceRepository := rec(
    Type := "git",
    URL := Concatenation( "https://github.com/laurentbartholdi/", ~.PackageName ),
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
#SupportEmail   := "TODO",
PackageWWWHome  := "https://laurentbartholdi.github.io/gapslp/",
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
README_URL      := Concatenation( ~.PackageWWWHome, "README.md" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", ~.PackageName, "-", ~.Version ),

ArchiveFormats := ".tar.gz",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "gapslp",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "SLP for free groups",
),

Dependencies := rec(
  GAP := ">= 4.8",
  NeededOtherPackages := [ [ "GAPDoc", ">= 1.5" ] ],
  SuggestedOtherPackages := [ [ "FGA", ">= 1.0" ] ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
        return true;
    end,

TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));


