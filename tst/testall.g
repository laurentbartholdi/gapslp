#
# gapslp: SLP for free groups
#
# This file runs package tests. It is also referenced in the package
# metadata in PackageInfo.g.
#
LoadPackage( "gapslp" );

TestDirectory(DirectoriesPackageLibrary( "gapslp", "tst" ),
  rec(exitGAP := true));

FORCE_QUIT_GAP(1); # if we ever get here, there was an error
