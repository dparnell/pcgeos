##############################################################################
#
#	Copyright (c) NewDeal 1999 -- All Rights Reserved
#
# PROJECT:	GeoSafar Builder
#
# AUTHOR:	Gene Anderson
#
# RCS STAMP:
#	$Id$
#
##############################################################################

name safbuild.app

longname "GeoExplorer Builder"

type	appl, process, single

class	SafBuildProcessClass

appobj	SafBuildApp

# jh - lets bump these up
# Heapspace:
heapspace 8000
# process stack space (default is 2000):
stack 6000

tokenchars "GEBL"
tokenid 16431

library	geos
library	ui
library safari
library ansic
library wav

resource AppResource ui-object
resource Interface ui-object
resource DocumentUI object
resource Strings lmem shared read-only
resource AppIcons data object

export SafBuildAppClass
export SafBuildDocumentClass
export SBDocumentControlClass
export QuizDialogClass
export QuestionDialogClass
export SBIndicatorClass
export SBGameCardClass
export SBFileChooseClass
