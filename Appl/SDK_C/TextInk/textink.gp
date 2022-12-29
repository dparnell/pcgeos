#####################################################################
#
#       Copyright (c) GeoWorks 1996 -- All Rights Reserved.
#
# PROJECT:      TextInk Sample Application
# MODULE:       Geode Parameters
# FILE:         textink.gp
#
# AUTHOR:       Andrew Wilson, June 12, 1991
#
# REVISION HISTORY:
#       Name    Date            Description
#       ----    ----            -----------
#       drew    6/12/91         Initial version
#       NF      9/23/96         Added heapspace value,
#                               Made tokenchars unique
#	RainerB	4/27/2022	Resource names adjusted for Watcom compatibility
#
# DESCRIPTION:
#       This file contains Geode definitions for the "TextInk" sample
#       application. This file is read by the GLUE linker to
#       build this application.
#
# RCS STAMP:
#       $Id: textink.gp,v 1.1 97/04/04 16:39:50 newdeal Exp $
#
#####################################################################

name     textink.app
longname "C Text/Ink Hybrid"

type   appl, process,single
class  TextInkProcessClass
appobj TextInkApp

tokenchars "TINK"
tokenid    8

heapspace 300

platform zoomer

library	geos
library	ui
library pen
library text

resource AppResource         ui-object
resource DisplayUI           ui-object
resource Interface           ui-object
resource DocGroup            object
resource DocumentResource    object read-only shared
resource InkMonikerResource  lmem data read-only
resource TextMonikerResource lmem data read-only

export TextInkProcessClass
export TextInkDocumentClass
export TextInkTextClass
export TextInkInkClass

