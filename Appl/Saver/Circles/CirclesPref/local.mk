# $Id: local.mk,v 1.1 97/04/04 16:44:31 newdeal Exp $

PROTOCONST	= PREF_MODULE

LINKFLAGS	+= -N "Circles"
ASMFLAGS	+= -DGPC_VERSION
UICFLAGS	+= -DGPC_VERSION
LINKFLAGS	+= -DGPC_VERSION

#include    <$(SYSMAKEFILE)>
