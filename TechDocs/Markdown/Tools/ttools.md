## 10 Using Tools

This chapter gives a reference of the tools included in this development kit. 
This chapter is not intended to teach you how to use the tools; it provides a 
reference only. To learn how to use most of the tools, see the Tutorial included 
in the development kit and the First Steps chapter in the Concepts book.

### 10.1 Tools Summary

The tools provided in this kit are listed below. Each is described in full in the 
following sections.

**pmake**  
"Make" utility which has knowledge of Goc. The **pmake** tool manages 
geode compilation and linking, making appropriate calls to Goc and Glue.

**Goc**  
C preprocessor which is aware of programming constructs specific to 
GEOS programming. The Goc tool looks for special keywords (such as 
@class and @object) and creates the proper GEOS data structures so that 
the geode will work correctly after being compiled and linked. Chances 
are you won't call Goc directly but will instead use **pmake**, which will 
call Goc in turn.

**Esp**  
Assembler with awareness of GEOS programming constructs. Also 
includes support for creating enumerated types, complicated records, 
and more. Chances are you won't call Esp directly but will instead use 
**pmake**, which will call Esp in turn.

**Glue**  
GEOS linker. This determines how the program's resources should be set 
up and how those resources can be relocated. It determines file offsets 
and how to access library functions. As with Goc, you probably won't call 
Glue directly but will instead use it through **pmake**.

**grev**  
Revision number generator. This is a handy utility for generating 
revision numbers for geodes, which may be used to keep track of library 
protocols. The **pmake** program uses grev to keep track of incremental 
changes; if you make large changes to a geode at some point, you can use 
grev to modify your geode's revision file to reflect your changes.

**mkmf**    Makefile maker. Creates a MAKEFILE which will in turn be used by 
**pmake** to determine how to create the geode's files.

**pccom**  
Communication manager. Sets up communication over serial lines. This 
manages data transfer and protocols when sending files between 
machines or debugging.

**pcs**  
Geode downloader. Sends geodes from the development machine to their 
proper directory on the target machine.

**pcsend**  
File downloader. Sends an arbitrary file from the development machine 
to an arbitrary directory on the target machine.

**pcget**  
File uploader. Retrieves an arbitrary file on the target machine, 
transferring it to any directory on the development machine.

**Swat**  
GEOS debugger. This program runs on the development machine, 
monitoring GEOS programs running on the target machine.

### 10.2 Typical Development Session

The Tutorial shows in detail how to write, compile, download, and debug an 
application. As a quick guide, however, the following list recaps the steps in 
a typical development session:

1. On the development machine, use a text editor (perhaps the one that 
came with your compiler) to write or edit the source (.c and .goc files, 
perhaps .asm or .ui files if you have the Esp assembler), header (.h and 
.goh files, perhaps .def files if you have the Esp assembler), and Glue 
parameters (.gp files) for your geode.The source files for the geode should 
be arranged within your development directory.

2. If you have never compiled the geode before or have added or included 
new files since the last compilation, you must run **mkmf** to create or 
update the MAKEFILE.

3. If you have added or included new files since the last compilation, you 
should execute **pmake depend** so that the compiler will know which 
files need to be remade if one is altered.

4. Run **pmake**. This compiles and links the geode's source files, using 
directions provided by the MAKEFILE.

5. Now you must download the compiled geode to the target machine. Use 
**pcs** to send the geode to the proper directory on the target machine (or 
**pcsend** if you have a particular destination directory in mind).

6. To test the geode, either run it on the target machine or run swat from 
the development machine to debug it.

### 10.3 File Types

You may be curious to know what sorts of files you'll be working with. If you 
have to work with someone else's code, then being able to find your away 
around their files (knowing which are sources, which are objects, and which 
are chaff) can be very useful.

***.goc** - These are Goc source files. You will write these files. They 
contain both standard C code and GEOS constructs (such as 
objects and messages).

***.goh** - These are Goc header files. You will write these files and 
include others. They provide definitions used by your .goc files 
(in the same relation as between standard C source and header 
files). Unlike standard C header files, these are included using 
the @include Goc keyword.

***.poh**, ***.ph** - These are files generated to optimize the @inclusion of .goh 
files. Goc will automatically generate these when they don't 
already exist.

***.doh**, ***.dh** - These are files generated to optimize the @inclusion of .goh 
files. They contain dependency information.

***.c** - These are standard C source files. You may write these as 
source files, using only standard ANSI C constructions. The Goc 
preprocessor will create .c files from .goc files. Thus, if you see 
two files with the same prefix, but one has the .c suffix and the 
other has the .goc suffix, then you know that the first was 
created from the second.

Note that Goc will create the generated .c file in the directory 
where it is invoked. Thus if your development tree contains 
files PROG\DIR1\CODE.GOC and PROG\DIR2\CODE.GOC, 
then if you convert these using Goc from the PROG directory, 
then one of the generated .c files will overwrite the other. Thus, 
you should never give .goc files the same prefix, even if they are 
in different directories.

***.h** - These are standard C header files. You may write these and 
include them using the ANSI C #include directive.

***.asm** - These are standard GEOS assembly source files, which may be 
assembled with the Esp assembler, if you have it. They may 
contain both standard assembly and Esp constructs.

***.def** - These are standard GEOS assembly header files, which you 
may write or include if you have access to the Esp assembler.

***.mk**, **makefile** - These are "makefiles," files which contain scripts which the 
**pmake** tool will interpret and use to automatically compile and 
link your geode. In a source directory there will be a file called 
MAKEFILE (created with the mkmf tool) and probably a file 
called DEPENDS.MK (created by calling **pmake depend**). If 
you wish to customize how your geode is made, you will 
probably write a file called LOCAL.MK, containing your custom 
makefile script. The INCLUDE directory contains several .mk 
files, which will be #included by other makefiles.

***.gp** - These are "Glue parameter" or "geode parameter" files, which 
will give the Glue linker information necessary when linking a 
geode. You will write this file. The **pmake** program assumes 
that a geode's .gp file will have name geode.GP, where geode is 
taken from the name of the directory containing the geode's 
source (e.g. in the example above, **pmake** would expect the .gp 
file to be named PROG.GP).

***.ldf** - These are library definition files. Glue uses these files when 
linking your geode; they determine how your calls to a GEOS 
library will be encoded. If you are writing a library, then you 
will create one of these files by means of a **pmake lib**. The 
**pmake** program looks for .ldf files in the INCLUDE\LDF 
directory.

***.rev** - This is a revision file, used to keep track of a program's revision 
and protocol levels (useful for tracking compatibility). The 
**pmake** tool will look for a file with name geode.REV, where 
geode is taken from the name of the directory containing the 
geode's source (e.g. in the example above, **pmake** would expect 
the .rev file to be named PROG.REV). The **pmake** program uses 
**grev** to create and maintain the .rev file; you should use grev 
yourself when you need to signal a major revision.

***.rsc** - Localization resource file. This file contains information which 
will be used by the ResEdit localization tool.

***.obj** - These are object files. These are files created by a C compiler or 
Esp which may be linked to form an executable. The **pmake** 
program uses Glue to link the object files.

***.ebj** - These are error-checking object files. GEOS supports the notion 
of "error-checking code." When you write your programs, you 
can mark some commands as "error checking commands." 
These commands might make sure that a routine is passed 
valid arguments or perhaps purposefully destroy some 
information which was not guaranteed preserved by a routine. 
Such commands may prove time-consuming but are useful for 
making sure that an application is robust. The **pmake** 
program will create two versions of your application-one 
which includes the EC (Error Checking) code, and one which 
doesn't. Run the EC program to check for correctness, but use 
the non-EC version when the program should be fast (i.e. this 
is the version you should give to your customers).

The .obj files will be linked to form a non-EC executable; .ebj 
files to form an EC executable.

***.geo** - This is a Geode, a GEOS executable (either an application, 
library, or driver), the end result of your efforts. These are the 
files containing the code for GEOS programs which the user will 
interact with. They are created by linking together a number of 
.obj files, with additional information provided by a .gp file. You 
will place these files in your GEOS testing directory on your 
target machine (along with *ec.geo files, described below).

***ec.geo** - This is an error checking geode. (See above for quick 
descriptions of error checking code and geodes.) They are 
created by linking together a number of .obj and .ebj files, with 
additional information provided by a .gp file.

***.sym** - This is a symbol file, containing symbolic debugging 
information which the Swat debugger can use to access the 
geode's data structures.

***ec.sym** - This is the symbol file of the error checking version of a geode.

**tmp**\*.* - These are temporary files which **pmake** will create and destroy 
while making your executable. The **pmake** program uses these 
files to pass arguments to the other tools. Thus, if you see a file 
of this name in your directory and you didn't create it, you can 
assume that **pmake** was interrupted in a recent make and was 
unable to erase the file (and thus it is safe for you to erase it).

**.tcl, .tlc** - These are Tcl files, files containing Tool Command Language 
source code, used by the Swat debugging tool. The .tcl files 
contain Tcl source code, the .tlc files contain compiled Tcl code. 
The source code may be edited by any text editor and Swat will 
interpret it; compiled code runs more quickly, but can only be 
changed by editing the source code and re-compiling.

If you are writing a GEOS C application, you will write the following types of 
files:

+ Source files: .goc files, optional .c files.

+ Glue parameters file: *geode*.GP.

+ Optional header files: .goh files, .h files.

+ Optional custom make file: LOCAL.MK.

After you have made your geode the first time (creating a makefile with 
**mkmf**, a dependencies file with **pmake depend**, and the geode itself with 
**pmake**), your directory should contain the following additional file types:

+ Intermediary C files: .c files (made by transforming .goc files).

+ Makefile: MAKEFILE 

+ Dependencies file: DEPEND.MK 

+ Revision file: *geode*.REV. 

+ Object files: .obj and .ebj files.

+ Symbol files: .sym files

+ Geodes: .geo files.

### 10.4 Esp

Esp (pronounced "esp") is the GEOS assembler. It creates object files from Esp 
code - said code using a superset of MASM syntax. These object files may then 
be linked by means of the Glue tool.

Most users will never call Esp directly, instead going through **pmake**, which 
will make the proper calls to Esp for the most common cases.

Esp takes the following options:

**-2** - Code produced should be DBCS-characters will be two bytes instead of 
one.

**-I** ***directory*** - Specifies an additional directory in which to look for included files.

**-o** ***filename*** - Name to give to created object file.

**-w** ***warntype*** 

**-W** ***warntype*** - Turn warnings off or on

+ **unref** - Warn if a symbol that can only be used during this assembly 
isn't.

+ **field** - Warn if structure field used with . operator when lhs isn't of the 
type that contains the field    

+ **shadow** - Warn if a local variable or procedure overrides a definition in a 
larger scope

+ **private** - Warn if a private method or instance variable is used outside a 
method handler or friend function related to the class that 
defined the thing

+ **unreach** - Warn about code that cannot be reached. This is very simplistic
unknown Warn if a far call is made to a routine whose segment 
is unknown

+ **record** - Warn if a record initializer doesn't contain all the fields of the 
record

+ **fall_thru** - Warn if a function falls into another one without a .fall_thru 
directive

+ **inline_data** - Warn if a variable is defined where execution can reach

+ **unref_local** - Warn if a local label isn't ever referenced 

+ **jmp** - Warn if out-of-range jumps are transformed into short jumps 
around near jumps

+ **assume** - Warn when override is generated based on segment 
assumptions

+ **all** - Used to turn all warnings on or off.

**-M** - This assembly is just for the purpose of determining what the source file's 
dependencies is. Instead of creating an object file, Esp will create a 
temporary file which the dependencies maker will use to determine the 
dependencies.

**-d** - Activate's Esp debugging mode. Useful only when trying to track down a 
bug in Esp.

### 10.5 Glue

Glue is the GEOS linker. It creates GEOS or DOS executables from object files. 
(It can also create GEOS VM and font files, if you have the appropriate tools.) 
These object files may have been created by a C compiler, or by the Esp 
assembler. To create the executables, Glue must create a combined file, 
resolve external declarations, determine how to call libraries, and apportion 
the code and data into resources. Glue will also create a .sym file - a file 
containing symbolic debugging information which the Swat debugger will 
use for viewing the geode's data.

Most users will never call Glue directly, instead going through **pmake**, which 
will make the proper calls to Glue for the most common cases.

The Glue application takes the following arguments:

    glue @file
    glue <flags> <objFile>+ [-l<objFile>]*

**@file** - The Glue linker should take its arguments from the file *file* in addition to 
those on the command line. This may come in handy if you often use the 
same long string of options. Since you may need to pass Glue more 
arguments than may be input on the command line, sometimes this 
option is necessary.

Note that if you use this option, then all arguments must be included in 
the file-there should be no others on the command line itself.

The **pmake** program uses this option to pass arguments to Glue.

**-L** ***path*** - Specifies where Glue looks for .ldf (library definition) files. These files are 
placed in a standard directory by the system makefiles on a "**pmake** lib¨.

**-N** ***string*** - Specify a copyright notice.

**-Oe** - Creating DOS executable (".exe") file. Of course, this option is not valid if 
the object files contain GEOS directives which will not work outside 
GEOS.

**-Oc** - Creating DOS command (".com") file. Of course, this option is not valid if 
the object files contains GEOS directives which will not work outside of 
GEOS.

**-Og** ***file*** - Creating GEOS executable (".geo") file. You must provide the name of the 
geode's Glue parameters file (the .GP file). For information about setting 
up a parameter file, see "First Steps: Hello World," Chapter 4 of the 
Concepts Book.

 When creating a .geo file, you may pass any of the following options:

+ **-E** - Link Error checking version of geode.

+ **-R** ***number*** - Specify release number of geode (e.g. 3.2.1.0).

+ **-P** ***number*** - Specify protocol number of geode (e.g. 1.0).

+ **-T** ***number*** - File type.

+ **-l** - Creating a library; Glue should create .ldf file.

**-Ov** - Creating GEOS Virtual Memory (.vm) file. Using this option, you may 
create .vm storage files as set up by the Esp assembler. You may pass the 
following options when creating .vm files (if you don't know the meaning 
of some of these terms, see "Virtual Memory," Chapter 18 of the Concepts 
Book):

+ **-A** ***number*** - VMAttributes to use for the file.

+ **-C** ***number*** - Compaction threshold.

+ **-M** ***string*** - Map block segment name.

+ **-P** ***number*** - Protocol number (e.g. 2.5.0.3).

+ **-R** ***number*** - Release number (e.g. 12.3).

+ **-i** ***name*** - A .geo file from which to get the table of imported libraries. This 
allows the VM file to be opened by that geode and objects in the 
file to be used.

+ **-t** ***token*** - File token

+ **-c** ***token*** - Creator's manufacturer token.

+ **-l** ***string*** - File's long name.

+ **-u** ***notes*** - File's user notes.

**-N** ***string*** - Copyright notice which will be embedded in header of .GEO or .VM files.

**-G** ***number*** - You should never have to use this option. This specifies a non-standard 
GEOS release number (e.g. 1.3); if this release used a different VM header 
than GEOS 2.0, Glue will still construct the proper header as long as this 
option is passed. Since the default release number is 2, developers for 2.X 
do not need this option.

**-Wall** - Requests that Glue output all optional warnings.

**-Wunref** - Requests that Glue output optional unreferenced global symbol 
warnings.

**-d** - Dump memory. Normally used only when debugging Glue.

**-m** - Provide memory map in output. This information gives information 
about the sizes of various parts of the geode. This information proves 
especially helpful when making geodes work with small devices.

**-nll** - Disables the output of line numbers for local memory segments for any 
application with 163 resources or more.

**-o** ***file*** - Specify name of output file (e.g. WOROPRO.GEO).

**-q** - Leave the symbolic information behind even if an error was encountered. 
Normally, this flag is used only when debugging Glue.

**-r** - Maps segment relocations to non-shared resources to resource IDs. This 
is normally used only by multi-launchable C applications. When running 
more than one instance of a multi-launchable application, the system 
only uses one copy of the read-only portion of the application. The system 
makes separate copies of the writable data for each instance of the 
application. This can lead to conflict when the relocation instructions for 
the read-only data uses the handle or segment of a writable resource; 
which copy should be responsible for providing these addresses? If you 
don't pass this flag and Glue detects the above situation, Glue will simply 
refuse to make the application multi-launchable. This flag instructs Glue 
to instead use the resource ID of the writable resource where it would 
normally use the segment or handle of that resource.

If you use this option, make sure that if you use the address of a variable 
in a resource other than dgroup that you use GeodeGetOptrNS() and 
lock down or dereference the handle of the returned optr.

**-s** ***file*** - Specify name of symbol file (the .SYM file).

**-z** - Output localization information.

### 10.6 Goc

Goc is the GEOS C preprocessor, which will turn your .goc file into something 
a regular C compiler can understand. It will traverse the .goc file, detect Goc 
keywords (e.g. @class, @object), turn these keywords into appropriate pieces 
of code, and write the resulting file out to a .c file. Note that Goc acts as a 
simple filter, and will only make changes where it detects Goc constructs; it 
won't touch your regular C code at all.

Under normal circumstances, you will not invoke Goc directly. Instead, 
**pmake** will make calls to Goc when compiling .goc files.

If for some reason you do need to invoke Goc directly, you may wish to know 
about its command line arguments:

    goc @file
    goc [args] <file>

**@file** - Command-line arguments are stored in a file-Goc will read 
this file and treat the contents as its arguments. If you use this 
option, then all the arguments must be in the file-no others 
may appear on the command line itself.

Redirect output to standard out.

**-D*****macro*** - Set variable macro to one (e.g. "-D__GEOS__")

**-D*****macro=value*** - Set variable macro to value.

**-I** ***dir*** - Specify additional include directory

**-I-** - Turn off relative inclusion.

**-L** ***name*** - Specify name of library being compiled. Must match argument 
to @deflib Goc keyword in library's .goh file, if it has one.

**-M** - Help **pmake** generate dependency information.

**-cb** - Generate information for Borland compiler.

**-d** - Turn on all debugging information.

**-dd** - Output @default debugging information. (See "GEOS 
Programming," Chapter 5 of the Concepts Book to find out 
what @default means).

**-dl** - Output lexical analyzer debugging information.

**-dm** - Output message parameter definition debugging information.

**-ds** - Output symbolic debugging information.

**-du** - Output Goc-specific debugging information.

**-dy** - Output parser debugging information.

**-l** - Do localization work.

**-o** - file   Specify name of output file.

**-p** - For Geoworks use only.

### 10.7 Grev

GEOS supports two version numbers for each geode. The first of these is the 
release number, used to uniquely identify the release of the geode. The 
protocol number tracks the external interface of the file. This is used to 
determine what versions of related geodes can be used together. The kernel 
will use these numbers to prevent loading of incompatible executable files.

The grev utility generates proper revision numbers. Normally, it is called 
automatically by **pmake**, so if you are just making a small change to a file, 
you need not call it directly. However, you may wish to. When using grev, you 
must think about how major a change you are making; a large change means 
that you should change an earlier number of the release number. A change 
from 1.2.3.4 to 2.0.0.0 should signal a larger step than a change to 1.2.3.5.

The **pmake** program uses grev to automatically create revision numbers for 
geodes; it passes these values to Glue, which in turn places the protocol and 
revision numbers in the .geo and .sym files.

There are three widely used methods for incrementing release numbers with 
respect to public releases (for which a specific release number is desired for 
marketing, say "2.0.0"). The problem comes because it is not known until 
after a release has been built whether it will be the release or not (since bugs 
may be found).

The first method is to keep separate public release numbers and internal 
release numbers. This is awkward and confusing and is generally done when 
it is too late to do anything else.

The second method is to number successive revisions "1.14.0.12", "1.14.0.13", 
"1.14.0.14" and so on until the final revision is made which is numbered 
"2.0.0.0". The problem with this is that one never quite knows whether or not 
a revision is the final one (since bugs may be found).

The third method is to number successive revisions "2.0.0.12", "2.0.0.13", 
"2.0.0.14" and so on. The released "2.0.0" revision is then the last engineering 
revision starting with "2.0.0.X". The disadvantage of this method is that it 
can seem non-obvious at first and requires a little bookkeeping to know the 
engineering number of the released version.

The protocol number is changed whenever the external interface for the file 
changes. For the kernel and for libraries the protocol reflects the order as well 
as the parameters and behavior of external entry points. For applications the 
protocol reflects the object names, types and attributes. Changes that do not 
affect the external interface (changing the implementation of a routine, 
changing the moniker or hints of an object) do not change the protocol 
number.

The major protocol number reflects incompatible changes in interface, such 
as rearranging the order of entry points. The minor protocol number reflects 
upwardly compatible changes in the protocol (such as adding an entry point 
at the end of a jump table or using a bit formerly marked as "reserved").

Each executable file contains protocol compatibility information (a protocol 
number) for all other executable files on which it depends. For example, a 
simple application might be compatible with kernel protocol "34.2" and UI 
protocol "19.7". Thus the application is compatible with kernels "34.2" 
through "34.65535" and with UIs "19.7" through "19.65535".

A protocol number is also stored with each state file to determine if the state 
can be recovered by the currently running application.

The grev tool uses a file (normally marked with a .rev suffix) in the geode's 
development directory to keep track of the revision number. The file is 
organized chronologically, with later entries at the beginning of the file. It 
contains

+ one line for each compilation, denoting the revision number (which is 
incremented on each compilation), optional user name, the date, and an 
optional comment. By default, **pmake** will only change the last part of 
the release number.

+ one line for each protocol change, denoting the protocol number, optional 
user name, the date, and an optional comment.

The grev utility takes the following arguments:

**grev command** ***file*** **[-P|-R|-s] [-B branch]** **[rev] ["comment"]**

- ***file*** is the name of the revision file (ending in .REV)
- **rev** is only used for the newrev command, see below.
- The **-P** option causes grev to give minimal output, printing only the protocol number. 
- The **-R** option causes grev to print only the revision number. 
- The **-s** option **MUST** be given to save changes to file. If this flag is not 
       passed, the change will only be displayed to the screen.
- The **-B** option causes grev to use branch rather than the trunk.
- These options are referred to as ***[flags]*** in the list below.

Possible commands are:

**new** ***file*** ***[flags]*** **["comment"]**   
Create a new revision record, listing comment as an initial revision for 
the base (0.0.0.0 release, 0.0 protocol). This command may only be 
executed in the geode's development directory. [flags] can be given, but 
will have no effect.

**info** ***file*** ***[flags]***   
Print the current release and protocol from the revision file.

**getproto** ***file*** ***[flags]***   
Print only the current protocol from the revision file.
The **-P** option works as stated above.

**newprotomajor** ***file*** ***[flags]*** **["comment"]**   
**NPM** ***file*** ***[flags]*** **["comment"]**   
Increase the major protocol number by one, setting the minor number to 
zero. The comment argument is listed as the reason for the change in the 
file. You must give the **-s** option to save changes to file. The **-P** option 
works as stated above.

**newprotominor** ***file*** ***[flags]*** **["comment"]**   
**npm** ***file*** ***[flags]*** **["comment"]**   
Increase the minor protocol number by one. The comment string is listed 
as the reason for the change in the file. You must give the **-s** option to 
save changes to file. The **-P** option works as stated above.

**newrev** ***file*** ***[flags]*** **A.B.C ["comment"]**   
Update release number to A.B.C.0 The comment is listed as the reason for 
the change. You must give the **-s** option to save changes to file.

**newchange** ***file*** ***[flags]*** **["comment"]**   
Up release number from A.B.**C.D** to A.B.**C+1.0**. The comment is listed as 
the reason for the change. You must give the **-s** option to save changes 
to file. The **-R** option works as stated above.

**neweng** ***file*** ***[flags]*** **["comment"]**   
**ne** ***file*** ***[flags]*** **["comment"]**   
Increase release number from A.B.C.**D** to A.B.C.**D+1**. The comment is 
listed as the reason for the change. You must give the **-s** option to save
changes to file. The **-R** option works as stated above.

**help**   
Print out a detailed help.
 
### 10.8 mkmf

The mkmf tool exists to create a file named MAKEFILE. The **pmake** program 
will use this file as a sort of script, using it to determine how to compile and 
link the geode. However, makefiles can get rather complicated, so it is best to 
create them using mkmf instead of by hand.

For information about customizing this boilerplate makefile, see section 
10.13.

The mkmf tool uses the following rules to build the makefile:

+ The geode name is taken from the name of the directory in which you run 
mkmf. Among other things, this means that if you change the name of 
your development directory, you should also run mkmf again.

+ Any file in the current directory or its subdirectories will be considered a 
source file if it has one of the following suffixes: .asm, .def, .ui, .c, .h, .goc, 
or .goh (except that .c files which are generated from .goc files will not be 
considered sources).

+ For each .asm, .c, or .goc file, an .obj file with corresponding name will be 
added to the makefile variable OBJS.

+ If there are subdirectories, then each subdirectory is considered to hold 
the source for a *module* of the program, and **mkmf** will work with the 
files in this subdirectory as a unit. The module's name will be added to 
the CMODULES variable if it contains .c or .goc files; if it contains .asm 
files, then it will be added to the MODULES list. When using **pmake**, each 
module will be considered something that can be made, a sort of 
intermediate step towards making the whole geode.  If you do not wish 
the files in a subdirectory to be incorporated in the program, create a file 
in the directory called NO_MKMF. This file need have no contents.

### 10.9 pccom

The pccom tool manages communication between the development and 
target machines. It assumes that the machines are connected by a single 
serial line. All I/O is interrupt-driven with XON/XOFF flow control active on 
the development machine and obeyed on the target machine.

Note that it is possible to use some features of pccom from within GEOS. For 
more information about this, see "PCCom Library," Chapter 22 of the 
Concepts Book.

#### 10.9.1 PCCOM Background

PCCOM is used in two primary situations. First, it is used by GEOS software 
developers when transferring files or when debugging an application. In this 
situation, the developer runs PCCOM on the target machine and then runs 
PCS, PCSEND, or PCGET, on the host machine. All of these programs know 
how to interact with PCCOM.

Second, it is used by DOS programs when transferring files to and from 
Zoomer devices or other devices that require remote file manipulation. In this 
case, the host machine runs a program which copies escape character 
sequences to the appropriate serial port, prompting PCCOM to act.

#### 10.9.2 Running PCCOM on the Target

PCCOM is a DOS program that monitors the serial port and responds to 
commands received on the line. All I/O is interrupt driven with XON/XOFF 
flow control active on the host machine and obeyed on the target machine.

PCCOM uses the PTTY environment variable of DOS, if it exists. This variable 
contains communications settings detailing baud rate, COM port, and 
communications interrupt level. You can override the PTTY settings with 
command-line options to PCCOM when running it. The following 
command-line options are allowed:

**/b:baud** - Specify the baud used for file transfer and serial 
communications. The baud parameter may be one of the 
following values: 300, 1200, 2400, 9600, 19200, or 38400. 
Unambiguous abbreviations may be used (e.g. 9 for 9600 baud 
or 38 for 38400 baud). The default baud rate is 19200 bps.

**/c:port** - Specify the COM port used for serial communications. The 
parameter may be one of 1, 2, 3, or 4. The COM ports for Zoomer 
are:  
COM 1 - the built-in serial port (this is the default).  
COM 2 - the infrared transceiver.

**/i:interrupt** - Specify interrupts that should be ignored by PCCOM. This is 
useful if peripherals share an interrupt number that may 
confuse PCCOM. The interrupt parameter is one or more 
numbers of the interrupt(s) to be ignored, in hexadecimal.

**/I:irq** - Specify the IRQ level for serial line communications. This 
parameter is rarely required. The irq parameter is the number 
of the IRQ level to be used.

##### 10.9.2.1 Quitting PCCOM

PCCOM may be quit either directly or remotely. To quit PCCOM directly, 
simply hit the Enter key (or the q key) on the machine on which PCCOM is 
running. If it does not quit on the first keystroke, hit the key again.

To quit PCCOM remotely, issue the quit escape sequence <Esc>EX through 
the serial line from the host machine. See below for a description of the 
commands that can be issued remotely.

##### 10.9.2.2 Remote PCCOM Commands

PCCOM doesn't care what machine originates a remote command; its sole 
purpose is to evaluate and execute commands received through the serial 
port it's monitoring. Thus, a command sent by one Zoomer to another will 
exact the same response as a command sent by a development host machine 
to a target development machine.

On most computers, commands are copied from DOS to the serial port using 
the "echo" command. (If the computer executing remote commands has a 
different BIOS, you may need to access the serial port differently; in this case, 
you must make sure that the characters sent to the serial port in the end are 
the same as those shown in the table below.) For example, to send the "quit" 
command to the remote machine, you could use the DOS command

`C:>echo EscEX > com1`

where *Esc* (in italics) represents the Escape character (0x1B).

No matter what method you use to send the character sequences to the serial 
port, the following commands may be executed remotely. Sending and 
receiving files remotely is more involved and is therefore discussed in the 
next section; it is not complicated, however.

All arguments to PCCOM remote commands must end with an exclamation 
point. Although this character is normally an acceptable character within 
DOS file names, PCCOM will treat it as the argument delineator character. 
Because of this, file operation commands will not work on files with 
exclamation points in their names.

    Command         Sequence            Description

    Send File       <Esc>XF1            Send a file from the host to the remote machine using the PCCOM file transfer protocol (see below).

    Get File        <Esc>XF2            Retrieve a file from the remote machine using the PCCOM file transfer protocol (see below).

    Copy File       <Esc>CPsrc!dest!    Copy the file named in the src argument to the file named in the dest argument. File name arguments may be full or relative paths with or without drive letters. This is equivalent to the DOS COPY command.

    Move File       <Esc>MVsrc!dest!    Move the file named in the src argument to the file named in the dest argument. File name arguments may be full or relative paths with or without drive letters. This is equivalent to the DOS MOVE command.

    Delete File     <Esc>RFfile!        Remove the named file; the file argument may be a full path or a file in the current directory. This is equivalent to the DOS DEL command.

    Change Drive    <Esc>CDdrive:!      Change the working volume to the drive named in the drive argument. This is equivalent to changing the drive in DOS by typing the drive letter followed by a colon (e.g. C:).

    Change Directory    <Esc>CDdir!     Change the working directory to that named. The dir argument may be a full or relative path; this is the equivalent of the DOS CD command.

    Show Current Path   <Esc>CD!        Print the current directory's path. This is equivalent to the DOS CD command with no arguments passed.  

    List Files in Dir   <Esc>LS         List files in the current working directory. This is equivalent to the DOS DIR command with no arguments.

    Create Directory    <Esc>MDdir!     Create a new directory according to the dir argument. The dir argument may be a full or relative path. This is the equivalent of the DOS MKDIR command.

    Delete Directory    <Esc>RDdir!     Remove the directory named in the dir argument. The dir argument may be a full or relative path; this is equivalent to the DOS RMDIR and RD commands.

    Clear Screen    <Esc>cl             Clear the screen. This is equivalent to the DOS CLS command.

    Exit PCCOM      <Esc>EX             Exit PCCOM on the remote machine.

##### 10.9.2.3 Sending and Receiving Files

If you are using the GEOS SDK, you will do most of your file sending and 
receiving using the programs PCS, PCSEND, and PCGET. These programs 
send commands to the serial port, and then follow them by either providing 
or receiving packaged file data. These three programs are detailed below; 
following them is a section of the file transfer protocol of PCCOM if you are 
writing your own remote-access program(s).

##### PCGET

If PCCOM is running on the target machine, the PCGET program can be 
executed on the host to retrieve a file from the target. This simple program 
merely retrieves the file and copies it into the host's working directory under 
the same name.

PCGET takes the following arguments; only the file name is required. The 
other arguments are optional and may be used to override the settings in the 
host machine's PTTY environment variable (see above, under "Running 
PCCOM on the Target (or on the Zoomer)").

`pcget [/b:baud][/c:port][/I:irq] file`

**/b:baud** - Specify the baud used for file transfer. The baud parameter 
may be one of the following values: 300, 1200, 2400, 9600, 
19200, or 38400. Unambiguous abbreviations may be used (e.g. 
9 for 9600 baud or 38 for 38400 baud). The default baud rate is 
19200 bps.

**/c:port** - Specify the COM port used. The port parameter may be one of 
1, 2, 3, or 4. The COM ports for Zoomer are:  
COM 1 - the built-in serial port (this is the default),  
COM 2 - the infrared transceiver.

**/I:irq** - Specify the IRQ level for the transfer. This parameter is rarely 
required. The irq parameter is the number of the IRQ level to 
be used.

**file** - Specify the file to be retrieved. The file parameter may be a full 
or a relative path or a simple file name. The file will be copied 
from the target to the host into the host's current working 
directory, with the same name.

##### PCSEND

If PCCOM is running on the target (remote) machine, PCSEND may be 
executed on the host machine to download a file to the target. PCSEND will 
only send a single file, though it may send the file to any directory on the 
target. To send multiple files, or to download specific geodes to their proper 
locations in the GEOS 2.0 directory tree, use the PCS program instead.

The command line options of PCSEND are shown below. Only the file to be 
sent is required; if no other argument is passed, the file will be sent to the 
target's current working directory.

`pcsend [/b:baud][/c:port][/I:irq] file [/d:dest]`

**/b:baud** - Specify the baud used for file transfer. The baud parameter 
may be one of the following values: 300, 1200, 2400, 9600, 
19200, or 38400. Unambiguous abbreviations may be used (e.g. 
9 for 9600 baud or 38 for 38400 baud). The default baud rate is 
19200 bps.

**/c:port** - Specify the COM port used. The port parameter may be one of 
1, 2, 3, or 4. The COM ports for Zoomer are:  
COM 1 - the built-in serial port (this is the default),  
COM 2 - the infrared transceiver.

**/I:irq** - Specify the IRQ level for the transfer. This parameter is rarely 
required. The irq parameter is the number of the IRQ level to 
be used.

**file** - Specify the file to be sent. The file parameter may be a full or a 
relative path or a simple file name. The file will be downloaded 
to the target machine's current working directory, unless the /d 
parameter is also passed (see below).

**/d:dest** - Specify a full or relative destination path for the file and/or a 
new destination file name.

##### PCS

If PCCOM is running on the target machine, PCS may be executed on the host 
machine to send multiple files to predetermined directories on the target. 
PCS is most often used by GEOS developers using the GEOS development kit, 
when they are downloading their recently-compiled geodes to the target for 
debugging.

The PCS program makes use of a list of constraints - tokens and their source 
and destination files and directories - located in the files 
ROOT_DIR\INCLUDE\PCS.PAT and ROOT_DIR\INCLUDE\SEND on the SDK 
host machine. (ROOT_DIR is a DOS environment variable set up by the SDK 
installation program indicating the top directory into which the SDK files 
were installed.) The format of these two files is described at the end of this 
section.

The command-line parameters of PCS are shown below. Note that a file name 
is not used by PCS; instead, if no token or directory is given, PCS will 
download all appropriate files in the current working directory. As with 
PCSEND and PCGET, the baud, COM port, and IRQ level arguments are all 
optional and may be used to override the settings in the PTTY environment 
variable.

`pcs [/n][/Sf][/t][/b:b][/c:p][/I:i][dir|file|token]`

**/n** - If /n is specified, PCS will send non-EC geodes only. Without this 
argument, PCS will send only EC geodes.

**/Sf** - Specify a file containing a list of files to be sent. The file 
argument is the name of the file.

**/t** - If the /t argument is used anywhere on the command line, file 
names specified at the end of the command (see the last 
argument) will be interpreted as tokens. A token may equate to 
numerous files as defined in the SEND file.

**/b:b** - Specify the baud used for file transfer. The baud parameter 
may be one of the following values: 300, 1200, 2400, 9600, 
19200, or 38400. Unambiguous abbreviations may be used (e.g. 
9 for 9600 baud or 38 for 38400 baud). The default baud rate is 
19200 bps.

**/c:p** - Specify the COM port used. The port parameter may be one of 
1, 2, 3, or 4. The COM ports for Zoomer are:  
COM 1 - the built-in serial port (this is the default),  
COM 2 - the infrared transceiver.

**/I:i** - Specify the IRQ level for the transfer. This parameter is rarely 
required. The irq parameter is the number of the IRQ level to 
be used.

**dir|file|token** - Specify a directory containing the geodes to be downloaded, the 
files to be downloaded, or tokens to be interpreted. If no 
directory, file, or token is specified, PCS will download the 
appropriate files in the current working directory. If a directory 
is specified, PCS will download all the appropriate files in that 
directory. If file names are specified (multiple files and/or 
directories may be specified), all affected files will be send.

If the /t argument appears anywhere in the command line (see above), this 
set of arguments will be interpreted as tokens. See directly below for token 
use and interpretation.

When using a token, PCS looks in the ROOT_DIR\INCLUDE\SEND file for the 
token to determine which files should be sent. Generally, all executables 
associated with an application, library, or mechanism are sent when the 
appropriate token is passed. Look in the SEND file to find out what the 
accepted tokens are and what they send.

For example, if the SEND file contained the lines

    PC      DRIVER/VIDEO/DUMB/HGC/HGC               GEO

    PCB     DRIVER/VIDEO/DUMB/HGC/HGC               GEO

    PCB     DRIVER/MOUSE/LOGIBUS/LOGIBUS            GEO

then typing

`pcs /t pc`

would send just the HGCEC.GEO file to the proper directory on the target. 
Typing

`pcs /t pcb`

would download both HGCEC.GEO and LOGIBUSE.GEO to their proper 
directories. A listing of all the supported tokens can be found in the SEND file.

#### 10.9.3 File Transfer Protocol of PCCOM

If you need to create your own file transfer program or module, you can use 
the basic PCCOM commands and a special transfer protocol to send or receive 
files over the serial link. This is useful, for example, if you have an existing 
Windows or DOS program to which you would like the to add the ability to 
transfer files to or from the Zoomer (or another unit running PCCOM).

##### 10.9.3.1 Sending a File to the Remote Machine

Sending a file to the remote machine involves the steps below. A file may be 
sent by any program that can access the serial port.

**1** - Notify PCCOM that a file is on its way.  
Send the Send File escape character sequence to the serial port, notifying 
PCCOM that a file is about to be sent to it. The escape sequence is 
`<Esc>XF1`.

**2** - Send the destination file name.  
Send the name PCCOM should use for the file when saving it. The name 
is a string of sequential characters ending with a null byte. If sending the 
file to the target machine's target directory, this will just be the file's 
name; if sending to a different directory, this string should instead be the 
full pathname. Thus, to do the equivalent of "pcsend yuyuhack.sho 
/d:b:\geoworks\document", this string would consist of 
"b:\geoworks\document\yuyuhack.sho".

**3** - Wait for acknowledgment of the name transfer.  
PCCOM will send a 0xFF character or a SYNC byte to acknowledge 
acceptance of the file name. If you do not receive this character, an error 
has likely occurred.

**4** - Send the file size.  
The file size should be encoded as a dword value. Send the low byte first.

**5** - Send a packet.  
Once you have received the SYNC or 0xFF byte, you can safely begin 
sending packets of data to PCCOM. A packet has the following format 
(sequence of bytes, with the first listed being the first sent):  
`BLOCK_START                ( = 1 )`  
`data`  
`BLOCK_END              ( = 2 )`  
`CRC                ( checksum value )`  
The data between BLOCK_START and the checksum value (CRC) may be 
up to 1 K. In order to avoid PCCOM confusion between a normal data byte 
and a BLOCK_START or BLOCK_END, a third 
element - BLOCK_QUOTE - is used.

Any time you have a data byte equal to 1, 2, or 3, you must quote it by 
inserting a BLOCK_QUOTE byte before it and then adding three to its 
value. Thus, if you had a data sequence consisting of the following

`100, 42, 2, 3, 16`

you would send the following sequence of bytes to transfer the data:

    <Esc>FX1                    ( alert PCCOM a
                      file is coming )
    <null-terminated file name>
    <wait for SYNC byte>
    BLOCK_START                 ( = 1 )
    100
    42
    BLOCK_QUOTE                 ( = 3 )
    5                   ( = 2 + 3 )
    BLOCK_QUOTE                 ( = 3 )
    6                   ( = 3 + 3 )
    16
    BLOCK_END                   ( = 2 )
    CRC                 ( checksum value )

The CRC word is two bytes of checksum value as calculated using the 
table and code shown in "Calculating Checksum Values," below. The CRC 
value is based upon the data bytes only. The low byte is transmitted first. 
You should use this code to ensure that your checksums will match 
PCCOM's.

**6** - Optionally, the first packet may contain the filename.  
In the first (and only the first) packet, it is possible to send a data block 
containing the file's name. If such a block is received by pccom or the 
PCCom library, then this filename will take precedence over the filename 
that was sent before the packets. Since the first filename may have been 
corrupted by noise, this provides a surer backup. 

This data block should have the following data:

    "!PCCom File Transfer Filename Block! "
        <no NULL><null-terminated file name>

The CRC for this block should be one higher than it would normally 
be - this signals that this block is of this special format.

**7** - Wait for a SYNC byte acknowledgment.  
After each packet, you must make sure PCCOM responds positively with 
another SYNC byte. If the SYNC is not received, the packet likely failed. 
If the packet succeeded, continue sending packets as above (waiting for a 
SYNC after each) until done transferring the data.

If, instead of receiving a SYNC value, you receive a NAK_QUIT value, the 
target machine has aborted to an unrecoverable error, and there is little 
point in continuing to send data over the serial line.

When sending an optional filename packet, as described in step six, 
normally one does not re-send the packet it if it fails to send.

**8** - Repeat steps five and seven as many times as necessary to transfer the 
entire file.

**9** - Send two zero bytes.  
To make it absolutely clear that the file transfer has finished, send two 
zero bytes.

##### 10.9.3.2 Retrieving a File Remotely

Retrieving a file from a machine running PCCOM is straightforward and uses 
the same file transfer protocol shown above for sending a file. The sequence 
of commands is different, however, and is listed below.

**1** - Notify PCCOM that you're getting a file.  
Send the Get File escape character sequence to the serial port, notifying 
PCCOM that it should get ready to send a file. The escape sequence is 
`<Esc>XF2`.

**2** - Send the source file name.  
Send the name of the file to be retrieved. The name is a string of 
sequential characters ending with a null byte. It may contain standard 
DOS wildcard characters.

**3** - Wait for SYNC byte signifying acknowledgment of the name transfer.  
PCCOM will send a 0xFF character or a SYNC byte to acknowledge 
acceptance of the file name. If you do not receive this character, an error 
has likely occurred (e.g. the file does not exist).

**4** - Wait for another SYNC byte signifying file found.  
PCCOM will send a SYNC byte to acknowledge that the desired file was 
found.

**5** - Receive destination file name.  
This null-terminated string contains the place to write the file on the host 
machine.

**6** - Send a SYNC byte to acknowledge receipt of the destination file name.  
By sending a SYNC byte, the host acknowledges that it has received the 
destination file name and is ready to continue the transfer.

**7** - Receive the file size.  
The next data received will be the file's size, expressed as a dword, with 
the low byte sent first.

**8** - Receive packets.  
After you receive thefile size from PCCOM, you will begin receiving data 
packets. Each packet you receive will follow the same format as described 
above for sending a file. Be aware of the BLOCK_QUOTE requirements 
when receiving the data (described in sending a file).

You will receive a checksum word at the end of each block's data. If the 
sent checksum matches the one you calculate from the received data, 
send a SYNC byte to the serial port (0xFF); otherwise send a NAK value. 
Calculate all your checksum values with the table and code presented in 
"Calculating Checksum Values," below. 

When retrieving files, there will never be a file name packet such as 
described in step six of the file-sending procedure. Thus, you need not 
check to see whether a block whose CRC is off by one in fact contains a 
file name; you should not acknowledge this block.

**9** - Receive two zero bytes.  
These make it clear that the file transfer has been completed.

**10** - Send an ACK byte.  
This acknowledges the end of the file transfer.

##### 10.9.3.3 Calculating Checksum Values

The CRC word that accompanies each block of transferred data must be 
calculated using the same code as PCCOM or you will probably have only 
unsuccessful transmissions. The code used by PCCOM is shown on the next 
page, and you may include it in your own file transfer program. PCSEND, 
PCGET, and PCS also use the same checksum calculation code. This checksum 
should be based only on the data itself; do not include the BLOCK_START, 
BLOCK_QUOTE, or BLOCK_END characters in your calculations.

----------

**Code Display 10-1 PCCOM Checksums**

    /**********************************************************************
     *      CalcCRC                     *
    **********************************************************************
     * SUMMARY:     Calculate the CRC on a block of data.
     * PASS:        char *buf       Pointer to the data buffer
     *      short size              Size of the data buffer
     *      short checksum      Previous checksum (0 at first)
     * RETURN:      CRC value (2 bytes)
    **********************************************************************/

    short   crcTable[] = { 
    0x0000, 0x1021, 0x2042, 0x3063, 0x4084, 0x50a5, 0x60c6, 0x70e7,
    0x8108, 0x9129, 0xa14a, 0xb16b, 0xc18c, 0xd1ad, 0xe1ce, 0xf1ef,
    0x1231, 0x0210, 0x3273, 0x2252, 0x52b5, 0x4294, 0x72f7, 0x62d6,
    0x9339, 0x8318, 0xb37b, 0xa35a, 0xd3bd, 0xc39c, 0xf3ff, 0xe3de,
    0x2462, 0x3443, 0x0420, 0x1401, 0x64e6, 0x74c7, 0x44a4, 0x5485,
    0xa56a, 0xb54b, 0x8528, 0x9509, 0xe5ee, 0xf5cf, 0xc5ac, 0xd58d,
    0x3653, 0x2672, 0x1611, 0x0630, 0x76d7, 0x66f6, 0x5695, 0x46b4,
    0xb75b, 0xa77a, 0x9719, 0x8738, 0xf7df, 0xe7fe, 0xd79d, 0xc7bc,
    0x48c4, 0x58e5, 0x6886, 0x78a7, 0x0840, 0x1861, 0x2802, 0x3823,
    0xc9cc, 0xd9ed, 0xe98e, 0xf9af, 0x8948, 0x9969, 0xa90a, 0xb92b,
    0x5af5, 0x4ad4, 0x7ab7, 0x6a96, 0x1a71, 0x0a50, 0x3a33, 0x2a12,
    0xdbfd, 0xcbdc, 0xfbbf, 0xeb9e, 0x9b79, 0x8b58, 0xbb3b, 0xab1a,
    0x6ca6, 0x7c87, 0x4ce4, 0x5cc5, 0x2c22, 0x3c03, 0x0c60, 0x1c41,
    0xedae, 0xfd8f, 0xcdec, 0xddcd, 0xad2a, 0xbd0b, 0x8d68, 0x9d49,
    0x7e97, 0x6eb6, 0x5ed5, 0x4ef4, 0x3e13, 0x2e32, 0x1e51, 0x0e70,
    0xff9f, 0xefbe, 0xdfdd, 0xcffc, 0xbf1b, 0xaf3a, 0x9f59, 0x8f78,
    0x9188, 0x81a9, 0xb1ca, 0xa1eb, 0xd10c, 0xc12d, 0xf14e, 0xe16f,
    0x1080, 0x00a1, 0x30c2, 0x20e3, 0x5004, 0x4025, 0x7046, 0x6067,
    0x83b9, 0x9398, 0xa3fb, 0xb3da, 0xc33d, 0xd31c, 0xe37f, 0xf35e,
    0x02b1, 0x1290, 0x22f3, 0x32d2, 0x4235, 0x5214, 0x6277, 0x7256,
    0xb5ea, 0xa5cb, 0x95a8, 0x8589, 0xf56e, 0xe54f, 0xd52c, 0xc50d,
    0x34e2, 0x24c3, 0x14a0, 0x0481, 0x7466, 0x6447, 0x5424, 0x4405,
    0xa7db, 0xb7fa, 0x8799, 0x97b8, 0xe75f, 0xf77e, 0xc71d, 0xd73c,
    0x26d3, 0x36f2, 0x0691, 0x16b0, 0x6657, 0x7676, 0x4615, 0x5634,
    0xd94c, 0xc96d, 0xf90e, 0xe92f, 0x99c8, 0x89e9, 0xb98a, 0xa9ab,
    0x5844, 0x4865, 0x7806, 0x6827, 0x18c0, 0x08e1, 0x3882, 0x28a3,
    0xcb7d, 0xdb5c, 0xeb3f, 0xfb1e, 0x8bf9, 0x9bd8, 0xabbb, 0xbb9a,
    0x4a75, 0x5a54, 0x6a37, 0x7a16, 0x0af1, 0x1ad0, 0x2ab3, 0x3a92,
    0xfd2e, 0xed0f, 0xdd6c, 0xcd4d, 0xbdaa, 0xad8b, 0x9de8, 0x8dc9,
    0x7c26, 0x6c07, 0x5c64, 0x4c45, 0x3ca2, 0x2c83, 0x1ce0, 0x0cc1,
    0xef1f, 0xff3e, 0xcf5d, 0xdf7c, 0xaf9b, 0xbfba, 0x8fd9, 0x9ff8,
    0x6e17, 0x7e36, 0x4e55, 0x5e74, 0x2e93, 0x3eb2, 0x0ed1, 0x1ef0
    };

    unsigned short      IncCRC(unsigned short crc, char c){
        return ((crc << 8) ^ crcTable[((crc >> 8) ^ c) & 0xff]);
    }

    short       CalcCRC(char *buf, short size, short checksum){
    /* The CRC is for the data part of the packet only. 
     * The CRC value is passed low byte first. */
        for (;size > 0; size--){
            checksum = IncCRC(checksum, *buf++);
        }
        return checksum;
    }

----------



### 10.10 pcget

Once you have pccom running on the target machine, you can invoke **pcget** 
on the development machine to yank a file from the target machine to the 
development machine.

Normally you would just type

`pcget goemon.gif`

to retrieve a file from the target machine's current directory or 

`pcget ..\clipart\jigen.gif`

to retrieve it from another directory. To use different speed settings than the 
**pccom** tool would normally use (the **pccom** tool's settings are normally 
determined by the PTTY environment variable), you may pass /b, /c, and /I 
flags, as you did when invoking the **pccom** tool. The /b flag sets the baud rate 
(e.g. "/b:19400"); the /c: flag sets the com port (e.g. "/c:3"), and the /I flag sets 
the IRQ level (e.g. "/I:3"). Note that these flags may be indicated with "-" 
instead of "/").

### 10.11 pcs

Once you have pccom running on the target machine, invoke **pcs** on the 
development machine to send your geode's executable to the proper place on 
the target machine. The pcs tool figures out which files to send (and which 
directory to send them to) via a number of rules set up in the 
ROOT_DIR\INCLUDE\PCS.PAT file (see Table 10-1 for these 
rules). Thus it knows to send applications (files that end in .GEO) to the 
target machine's WORLD directory. (Note that the "/" and "-" characters in the 
flags below are interchangeable-hyphens are used with the n, S, and t flags 
by tradition.)

**/I:IRQ** - Communicate at a different interrupt level than pccom is 
presently using (this is a dangerous option).

**-S file** - Send all files mentioned in the file file.

**/b:baudRate** - Communicate at a different speed than pccom is presently 
using (this is a dangerous option).

**/c:portNum** - Communicate via a different COM port than pccom is 
presently using (this is a dangerous option).

**-h** - Get help.

**-n** - Send non-Error Checking version instead of EC.

**-t token** - Send all files associated with the named token (see below).

When using a token, pcs looks up the token in the INCLUDE\SEND file to 
determine which files should be sent. Generally all executables associated 
with an application, library, or mechanism are sent when the appropriate 
token is passed. Look in the SEND file to find out what the accepted tokens 
are and what they send. Suppose your send file consisted of the following 
lines:

    PC      DRIVER/VIDEO/DUMB/HGC/HGC               GEO
    HGCAT   DRIVER/VIDEO/DUMB/HGC/HGC               GEO
    PCB     DRIVER/VIDEO/DUMB/HGC/HGC               GEO
    PCB     DRIVER/MOUSE/LOGIBUS/LOGIBUS            GEO
    PCS     DRIVER/VIDEO/DUMB/HGC/HGC               GEO
    PCS     DRIVER/MOUSE/LOGISER/LOGISER            GEO

Typing 

`pcs -t pc`

would send the file DRIVER\VIDEO\DUMB\HGC\HGCEC.GEO (HGC.GEO if 
sending non-EC). Typing "pcs -S pcb" would send that file, and also 
DRIVER\MOUSE\LOGIBUS\LOGIBUSE.GEO (or LOGIBUS.GEO). 

**Table 10-1** Destination of Files Sent by Pcs

    Development Directory               Suffix      Target Directory

    *\LIBRARY\HWR\DATA\                 *       PRIVDATA\HWR
    *\LIBRARY\SPELL\DICTS\*             *       USERDATA\DICTS
    *\LIBRARY\SAVER\                    GEO     WORLD
    *\LIBRARY\SAVER\*\                  GEO     SYSTEM\SAVERS
    *\LIBRARY\PREF\*                    GEO     SYSTEM\PREF
    *\LIBRARY\TRANSLAT\GRAPHICS\*\*\    GEO     SYSTEM
    *\LIBRARY\TRANSLAT\TEXT\MSMFILE\    GEO     SYSTEM
    *\LIBRARY\TRANSLAT\*                GEO     SYSTEM\IMPEX
    *\LIBRARY\FMTOOLS\*                 GEO     SYSTEM\FILEMGR
    *\LIBRARY\NET\*                     GEO     SYSTEM\SYSAPPL
    *\LIBRARY\*                         GEO     SYSTEM
    *\DRIVER\IFS\*                      GEO     SYSTEM\FS
    *\DRIVER\COMM\*                     GEO     SYSTEM
    *\DRIVER\NET\*                      GEO     SYSTEM\NET
    *\DRIVER\FAX\*                      GEO     SYSTEM\FAX
    *\DRIVER\TASK\*                     GEO     SYSTEM\TASK
    *\DRIVER\FONT\*                     GEO     SYSTEM\FONT
    *\DRIVER\KEYBOARD\*                 GEO     SYSTEM\KBD
    *\DRIVER\MOUSE\*                    GEO     SYSTEM\MOUSE
    *\DRIVER\PRINTER\*                  GEO     SYSTEM\PRINTER
    *\DRIVER\SWAP\*                     GEO     SYSTEM\SWAP
    *\DRIVER\VIDEO\*                    GEO     SYSTEM\VIDEO
    *\DRIVER\STREAM\*                   GEO     SYSTEM
    *\DRIVER\POWER\*                    GEO     SYSTEM\POWER
    *\DRIVER\SOUND\*                    GEO     SYSTEM\SOUND
    *\APPL\LAUNCHER\*                   GEO     PRIVDATA
    *\APPL\WELCOME\*                    GEO     SYSTEM\SYSAPPL
    *\APPL\PREFEREN\SETUP\*             GEO     SYSTEM\SYSAPPL
    *\APPL\SDK_C\*                      GEO     WORLD\C
    *\APPL\SDK_ASM\*                    GEO     WORLD\ASM
    *\APPL\*                            GEO     WORLD
    *\FONTDATA\*                        FNT     USERDATA\FONT
    *\DOCUMENT\*                        *       DOCUMENT
    *\DOSAPPL\*                         *       .

### 10.12 pcsend

The **pcsend** tool sends files from the development machine to the target 
machine (assuming that the target machine is running pccom). Normally you 
use pcs to send geodes between machines, as that tool has knowledge of 
where geodes belong; pcsend is for those cases where the pcs tool's automatic 
behavior is undesirable. With pcsend, you can specify source and destination 
explicitly.

Normally you will invoke pcsend by typing something like:

`pcsend zenigata.pcx`

or (to send to a directory other than the target PC's current directory):

`pcsend zenigata.pcx /d:..\clipart`

In addition to the /d option, you may also pass /b, /c, or  /I options to override 
the speed, port, and/or IRQ values in the PTTY environment variable. (You 
may use "-" instead of "/" when passing these flags.)

`pcsend sendslow.com /b:2400`

### 10.13 pmake

The **pmake** program is a make utility. This means that it takes a directory 
of sources and a makefile which contains knowledge of how to turn these 
sources into geodes. If there were no **pmake**, then you would have to type 
goc, bcc, and glue each time.

The **pmake** program will work correctly if you have set up your files 
correctly. This means that you must have a makefile. You should run **mkmf** 
to generate a makefile that knows how to generate geodes. If you are an 
experienced C programmer, you may have come up with some customizations 
that you use with your make utility. We still suggest that you work from a 
standard makefile (which knows about Goc and Glue), but include your 
customizations in a **local.mk** file (see section 10.13.2 of chapter 10).

When you have just added or removed source files from a geode, you will have 
to generate new dependency information, which **pmake** will use when doing 
other makes. You can use **pmake** to generate this information (it will make 
an appropriate call to the **makedpnd** program; it will store the result in 
**depends.mk**):

`pmake depend`

Once you have created your source and make files, all you need to do to 
invoke **pmake** is type

`pmake`

The **pmake** tool can be used to construct a specific target. Thus, if you need 
to generate an .OBJ file but do not need the rest of the geode, you may type 
something like:

`pmake sdtrk.obj`

The system makefiles have been set up with knowledge of some special 
targets. If you are making a library and wish to install it in the proper 
directory so that all applications may use it, then signal this to **pmake**:

`pmake lib`

The **pmake** program does have command-line arguments, but these are used 
only rarely; they are detailed below.

#### 10.13.1 Copyright Notice and Acknowledgment

The **pmake** tool comes under the following copyright notice:

Copyright© 1988, 1989 by the Regents of the University of California  
Copyright© 1988, 1989 by Adam de Boor  
Copyright© 1989 by Berkeley Softworks

Permission to use, copy, modify, and distribute this software (**pmake**) and its 
documentation for any non-commercial purpose and without fee is hereby 
granted, provided that the above copyright notice appears in all copies. The 
University of California, Berkeley Softworks, and Adam de Boor make no 
representations about the suitability of this software for any purpose. It is 
provided "as is" without express or implied warranty.

The **pmake** program for the PC uses the SPAWNO routines by Ralf Brown to 
minimize memory use while shelling to DOS and running other programs.

#### 10.13.2 How to Customize pmake

For most applications, executing **mkmf** will generate a perfect makefile. 
However, you may be creating an unusual geode or have some makefile 
definitions which you want to include. Fortunately, there are ways to 
customize your make environment without having to build a MAKEFILE from 
scratch.

Makefiles can #include other makefiles. If you have a file named LOCAL.MK 
in your make directory, then the standard makefile generated by mkmf will 
include it; if you wish to customize your makes, you can create a LOCAL.MK 
file and fill it with appropriate make directives.

Depending on how much customization you need to do, you may wish to read 
on to find out about makefile syntax. However, there are several simple 
things you can do without learning too much about makefiles.

    # Pass extra flags to Goc:
    GOCFLAGS        += flag1 flag2

    # Pass extra flags to your C compiler:
    CCOMFLAGS       += flag1 flag2

    # Pass extra flags to the Esp assembler (if you have
    # that tool):
    ASMFLAGS        += flag1 flag2

    # Pass extra flags to the Glue linker:
    LINKFLAGS       += flag1 flag2

    # Look somewhere special for .GOC files
    # (This pattern applies to any suffix):
    .PATH.GOC       : $(ROOT_DIR)\DIR1 \DIR2

    # Specify geode name:
    GEODE       = NAME

    # Set NO_EC variable (which signals that we don't
    # want to make an Error Checking version):
    NO_EC       = 1

    # If your preprocessor is not reachable via the 
    # Path environment variable:
    CPP         = vol:\path\name

    # If your C compiler is not reachable via the Path
    # environment variable:
    CCOM        = vol:\path\name

    # Include some other make file
    #include "OTHERMF.MK"
    # Include the standard makefile directives
    # This will include INCLUDE\GEODE.MK:
    #include <$(SYSMAKEFILE)>

----------

**Code Display 10-2 Sample local.mk Files**

    ---FINGER\LOCAL.MK
    # Local Makefile for FPaint
    #  FPaint is stored in a directory called FINGER. This would normally confuse
    #  pmake, which expects the geode name to be the same as the directory name.
    #  Let us, therefore, alert pmake to the geode's real name:
    GEODE       = FPAINT
    # This was the only thing we wanted to change, so include standard definitions:
    #include <$(SYSMAKEFILE)>

    ---PROMO\LOCAL.MK
    # Local Makefile for Promo
    #  Promo uses some clip art that isn't in or below its source directory, so we
    #  tell pmake where to look for it:
    .PATH.GOH   : $(CSOURCE_PATHS) $(CINCLUDE_DIR) $(ROOT_DIR)\LOGOART
    # This program contains no Error Checking code (See 
    # "GEOS Programming," Chapter 5 of the Concepts Book for information
    # about EC code. So we tell pmake not to bother making an Error Checking
    # version:
    NO_EC = 1
    # Include the standard system makefile:
    #include <$(SYSMAKEFILE)>

----------

#### 10.13.3 Command Line Arguments

The **pmake** program comes with a wide variety of flags to choose from. They 
must be passed in the following order: flags (if any), variable assignments (if 
any), target (if any).

`pmake [flags] [variables] [target]`

The flags are as follows:

**-d info** - This causes **pmake** to print out debugging information that may prove 
useful to you. The info parameter is a string of single characters that tell 
**pmake** what aspects you are interested in. Most of these options will 
make little sense to you unless you've dealt with Make before. Just 
remember where this table is and come back to it as you read on. The 
characters and the information they produce are as follows:

    *   All debugging information.  
    c   Conditional evaluation.  
    d   The searching and caching of directories.  
    m   The making of each target: what target is being examined; 
        when it was last modified; whether it is out-of-date; etc.  
    p   Makefile parsing.  
    r   Remote execution.  
    s   The application of suffix-transformation rules.  
    t   The maintenance of the list of targets.  
    v   Variable assignment. 
    Of these, the "m" and "s" flags will be most useful.

**-f file** - Specify a makefile to read different from the default (MAKEFILE). If file 
is "-", **pmake** uses the standard input. This is useful for making "quick 
and dirty" makefiles.

**-h** - Prints out a summary of the various flags **pmake** accepts. It can also be 
used to find out what level of concurrence was compiled into the version 
of **pmake** you are using (look at -J and -L) and various other information 
on how **pmake** is configured.

**-i** - If you give this flag, **pmake** will ignore non-zero status returned by any 
of its shells. It's like placing a "-" before all the commands in the makefile.

**-k** - This is similar to -i in that it allows **pmake** to continue when it sees an 
error, but unlike -i where **pmake** continues blithely as if nothing went 
wrong, -k causes it to recognize the error and only continue work on those 
things that don't depend on the target, either directly or indirectly 
(through depending on something that depends on it), whose creation 
returned the error. (The "k" is for "keep going".)

**-n** - This flag tells **pmake** not to execute the commands needed to update the 
out-of-date targets in the makefile. Rather, **pmake** will simply print the 
commands it would have executed and exit. This is particularly useful for 
checking the correctness of a makefile. If **pmake** doesn't do what you 
expect it to, it's a good chance the makefile is wrong.

**-p number** - You should never have to use this option; it is used for debugging **pmake**. 
This causes **pmake** to print its input in a reasonable form, though not 
necessarily one that would make immediate sense to anyone but a 
**pmake** expert. The *number* is a bitwise-or of 1 and 2 where 1 means it 
should print the input before doing any processing and 2 says it should 
print it after everything has been re-created. Thus "-p 3"would print it 
twice-once before processing and once after (you might find the 
difference between the two interesting). 

**-q** - If you give **pmake** this flag, it will not try to re-create anything. It will 
just query to see if anything is out-of-date and exit non-zero if so.

**-s** - This silences **pmake**, preventing it from printing commands before 
they're executed. It is the equivalent of putting an "@" before every 
command in the makefile.

**-t** - Rather than try to re-create a target, **pmake** will simply "touch" it so as 
to make it appear up-to-date. If the target didn't exist before, it will when 
**pmake** finishes, but if the target did exist, it will appear to have been 
updated.

**-D var** - Allows you to define a variable to have 1 as its value. The variable is a 
global variable, not a command-line variable. This is useful mostly for 
people who are used to the C compiler arguments and those using 
conditionals, which are described in section 10.13.5.2 below.

**-I directory** - Tells **pmake** another place to search for included makefiles.

**-W** - Suppresses **pmake**'s warnings. Note that tools which **pmake** invokes 
(Goc, Glue, etc.) may still print out warnings of their own.

#### 10.13.4 Contents of a Makefile

The **pmake** program takes as input a file that tells

+ which files depend on which other files and 

+ what to do about files that are "out-of-date." 

This file is known as a "makefile" and is usually kept in the top-most 
directory of the system to be built. While you can call the makefile anything 
you want, **pmake** will look for MAKEFILE in the current directory if you don't 
tell it otherwise. To specify a different makefile, use the -f flag (e.g. 
"pmake -f program.mk").

A makefile has four different types of lines in it:

+ File dependency specifications

+ Creation commands

+ Variable assignments

+ Comments, include statements and conditional directives

Any line may be continued over multiple lines by ending it with a backslash 
("\"). The backslash, following newline and any initial whitespace on the 
following line are compressed into a single space before the input line is 
examined by pmake.

##### 10.13.4.1 Dependency Lines

In any system, there are dependencies between the files that make up the 
system. For instance, in a program made up of several C source files and one 
header file, the C files will need to be re-compiled should the header file be 
changed. For a document of several chapters and one macro file, the chapters 
will need to be reprocessed if any of the macros changes. These are 
dependencies and are specified by means of dependency lines in the makefile.

On a dependency line, there are *targets* and *sources*, separated by a one- or 
two-character operator. The targets "depend" on the sources and are usually 
created from them. Any number of targets and sources may be specified on a 
dependency line. All the targets in the line are made to depend on all the 
sources. Targets and sources need not be actual files, but every source must 
be either an actual file or another target in the makefile. If you run out of 
room, use a backslash at the end of the line to continue onto the next one.

Any file may be a target and any file may be a source, but the relationship 
between the two (or however many) is determined by the "operator" that 
separates them. Three types of operators exist: one specifies that the 
datedness of a target is determined by the state of its sources, while another 
specifies other files (the sources) that need to be dealt with before the target 
can be re-created. The third operator is very similar to the first, with the 
additional condition that the target is out-of-date if it has no sources. These 
operations are represented by the colon, the exclamation point and the 
double-colon, respectively, and are mutually exclusive (to represent a colon in 
a target, you must precede it with a backslash: "\\:"). Their exact semantics 
are as follows:

**\:** - If a colon is used, a target on the line is considered to be "out-of-date" (and 
in need of creation) if 

+ the target doesn't exist or 

+ any of the sources has been modified more recently than the target.

    Under this operator, steps will be taken to re-create the target only if it 
is found to be out-of-date by using these two rules.

**!** - If an exclamation point is used, the target will always be re-created, but 
this will not happen until all of its sources have been examined and 
re-created, if necessary.

**::** - If a double-colon is used, a target is out-of-date if

+ the target has no sources, 

+ any of the sources has been modified more recently than the target, or

+ the target doesn't exist.

    If the target is out-of-date according to these rules, it will be re-created. 
This operator also does something else to the targets, as described in 
section 10.13.4.2).

    Suppose there are three C files (**a.c**, **b.c** and **c.c**) each of which includes the 
file **defs.h**. The dependencies between the files could then be expressed as 
follows:

    PROGRAM.EXE         : A.OBJ B.OBJ C.OBJ  
    A.OBJ B.OBJ C.OBJ   : DEFS.H  
    A.OBJ               : A.C  
    B.OBJ               : B.C  
    C.OBJ               : C.C  

You may be wondering at this point, where A.OBJ, B.OBJ and C.OBJ came in 
and why they depend on defs.h and the C files don't. The reason is quite 
simple: PROGRAM.EXE cannot be made by linking together .c files-it must 
be made from .obj files. Likewise, if you change DEFS.H, it isn't the .c files 
that need to be re-created, it's the .obj files. If you think of dependencies in 
these terms-which files (targets) need to be created from which files 
(sources)- you should have no problems.

An important thing to notice about the above example is that all the .obj files 
appear as targets on more than one line. This is perfectly all right: the target 
is made to depend on all the sources mentioned on all the dependency lines. 
For example, A.OBJ depends on both DEFS.H and A.C.

**The order of the dependency lines in the makefile is important**: the first 
target on the first dependency line in the makefile will be the one that gets 
made if you don't say otherwise. That's why PROGRAM.EXE comes first in the 
example makefile, above.

Both targets and sources may contain the standard C-Shell wildcard 
characters ({, }, *, ?, [, and ]), but the square braces may only appear in the 
final component (the file portion) of the target or source. The characters mean 
the following things:

**{ }** - These enclose a comma-separated list of options and cause the pattern to 
be expanded once for each element of the list. Each expansion contains a 
different element. For example, 

`SRC\{WHIFFLE,BEEP,FISH}.C`

expands to the three words "SRC\WHIFFLE.C", "SRC\BEEP.C", and 
"SRC\FISH.C". These braces may be nested and, unlike the other 
wildcard characters, the resulting words need not be actual files. All 
other wildcard characters are expanded using the files that exist when 
**pmake** is started.

**\*** - This matches zero or more characters of any sort. 

`SRC\*.C`

will expand to the same three words as above as long as src contains 
those three files (and no other files that end in .c).

**?** - Matches any single character.

**[ ]** - This is known as a character class and contains either a list of single 
characters, or a series of character ranges ([a-z], for example means all 
characters between a and z), or both. It matches any single character 
contained in the list. E.g. [A-Za-z] will match all letters, while 
[0123456789] will match all numbers.

##### 10.13.4.2 Shell Commands

At this point, you may be wondering how files are re-created. The re-creation 
is accomplished by commands you place in the makefile. These commands 
are passed to the shell to be executed and are expected to do what's necessary 
to update the target file. (The **pmake** program doesn't actually check to see 
if the target was created. It just assumes it's there.)

Shell commands in a makefile look a lot like shell commands you would type, 
with one important exception: each command in a makefile must be preceded 
by at least one tab.

Each target has associated with it a shell script made up of one or more of 
these shell commands. The creation script for a target should immediately 
follow the dependency line for that target. While any given target may 
appear on more than one dependency line, only one of these dependency lines 
may be followed by a creation script, unless the "::" operator was used on the 
dependency line.

If the double-colon was used, each dependency line for the target may be 
followed by a shell script. That script will only be executed if the target on the 
associated dependency line is out-of-date with respect to the sources on that 
line, according to the rules given earlier. 

To expand on the earlier makefile, you might add commands as follows:

    PROGRAM.EXE : A.OBJ B.OBJ C.OBJ
        BCC A.OBJ B.OBJ C.OBJ -o PROGRAM.EXE
    A.OBJ B.OBJ C.OBJ : DEFS.H
    A.OBJ : A.C
        bcc -c A.C
    B.OBJ : B.C
        bcc -c B.C
    C.OBJ : C.C
        bcc -c C.C

Something you should remember when writing a makefile is that the 
commands will be executed if the target on the dependency line is out-of-date, 
not the sources. In this example, the command "bcc -c a.c" will be executed if 
**a.obj** is out-of-date. Because of the ":" operator, this means that should a.c or 
**defs.h** have been modified more recently than **a.obj**, the command will be 
executed (**a.obj** will be considered out-of-date).

There is another way in which makefile commands differ from regular shell 
commands. The first two characters after the initial whitespace are treated 
specially. If they are any combination of "@" and "-", they cause **pmake** to do 
things differently.

In most cases, shell commands are printed before they're actually executed. 
This is to keep you informed of what's going on. If an "@" appears, however, 
this echoing is suppressed. In the case of an echo command, perhaps 
"echo Linking index" it would be rather messy to output 

    echo Linking index
    Linking index

The other special character is the dash ("-"). Shell commands finish with a 
certain "exit status." This status is made available by the operating system 
to whatever program invoked the command. Normally this status will be zero 
if everything went ok and non-zero if something went wrong. For this reason, 
**pmake** will consider an error to have occurred if one of the shells it invokes 
returns a non-zero status. When it detects an error, pmake's usual action is 
to abort whatever it's doing and exit with a non-zero status itself. This 
behavior can be altered, however, by placing a "-" at the front of a command 
(e.g. "-copy index index.old") . In such a case, the non-zero status is simply 
ignored and **pmake** keeps going.

If the system call should be made through the DOS COMMAND.COM, precede 
the shell command with a backquote (`).

##### 10.13.4.3 Variables

The **pmake** program has the ability to save text in variables to be recalled 
later at your convenience. Variables in **pmake** are used much like variables 
in the shell and, by tradition, consist of all upper-case letters. Variables are 
assigned using lines of the form

    VARIABLE = value

append using lines of the form

    VARIABLE += value

conditionally assigned (if the variable isn't already defined) by using lines of 
the form

    VARIABLE ?= value

and assigned with expansion (i.e. the value is expanded (see below) before 
being assigned to the variable-useful for placing a value at the beginning of 
a variable, or other things) by using lines of the form

    VARIABLE := value

Any whitespace before value is stripped off. When appending, a space is 
placed between the old value and the values being appended.

The final way a variable may be assigned is using lines of the form

    VARIABLE != shell-command

or, if the shell command requires the use of the command.com interpreter, 

    VARIABLE != `shell-command

In this case, shell-command has all its variables expanded (see below) and is 
passed off to a shell to execute. The output of the shell is then placed in the 
variable. Any newlines (other than the final one) are replaced by spaces 
before the assignment is made. This is typically used to find the current 
directory via a line like:

    CURRENT_DIR != `cd

The value of a variable may be retrieved by enclosing the variable name in 
parentheses or curly braces and preceding the whole thing with a dollar sign. 
For example, to set the variable CFLAGS to the string 
"-I\NIHON\LIB\LIBC -O", you would place a line

    CFLAGS = -I\NIHON\LIB\LIBC -O

in the makefile and use the expression

    $(CFLAGS)

 wherever you would like the string "-I\NIHON\LIB\LIBC -O" to appear. This 
is called variable expansion.

There are two different times at which variable expansion occurs: When 
parsing a dependency line, the expansion occurs immediately upon reading 
the line. Variables in shell commands are expanded when the command is 
executed. Variables used inside another variable are expanded whenever the 
outer variable is expanded (the expansion of an inner variable has no effect 
on the outer variable. That is, if the outer variable is used on a dependency 
line and in a shell command, and the inner variable changes value between 
when the dependency line is read and the shell command is executed, two 
different values will be substituted for the outer variable).

Variables come in four flavors, though they are all expanded the same and all 
look about the same. They are (in order of expanding scope)

+ local variables.

+ command-line variables.

+ global variables.

+ environment variables.

The classification of variables doesn't matter much, except that the classes 
are searched from the top (local) to the bottom (environment) when looking 
up a variable. The first one found wins.

##### Local Variables

Each target can have as many as seven local variables. These are variables 
that are only "visible" within that target's shell script and contain such 
things as the target's name, all of its sources (from all its dependency lines), 
those sources that were out-of-date, etc. Four local variables are defined for 
all targets. They are

**.TARGET** - The name of the target.

**.OODATE** - The list of the sources for the target that were considered out-of-date. The 
order in the list is not guaranteed to be the same as the order in which 
the dependencies were given.

**.ALLSRC** - The list of all sources for this target in the order in which they were given.

**.PREFIX** - The target without its suffix and without any leading path. For example, 
for the target ..\..\LIB\FSREAD.C, this variable would contain FSREAD.

One other local variable, .IMPSRC, is set only for certain targets under special 
circumstances. It is discussed below.

Two of these variables may be used in sources as well as in shell scripts. 
These are .TARGET and .PREFIX. The variables in the sources are expanded 
once for each target on the dependency line, providing what is known as a 
"dynamic source," allowing you to specify several dependency lines at once. 
For example,

    $(OBJS) : $(.PREFIX).c

will create a dependency between each object file and its corresponding C 
source file.

##### Command-line Variables

Command-line variables are set when pmake is first invoked by giving a 
variable assignment as one of the arguments. For example,

    pmake "CFLAGS = -I\NIHON\LIB\LIBC -O"

would make CFLAGS be a command-line variable with the given value. Any 
assignments to CFLAGS in the makefile will have no effect, because once it is 
set, there is (almost) nothing you can do to change a command-line variable. 
Command-line variables may be set using any of the four assignment 
operators, though only = and ?= behave as you would expect them to, mostly 
because assignments to command-line variables are performed before the 
makefile is read, thus the values set in the makefile are unavailable at the 
time. += is the same as = because the old value of the variable is sought only 
in the scope in which the assignment is taking place. The := and ?= operators 
will work if the only variables used are in the environment. 

##### Global Variables

Global variables are those set or appended in the makefile. There are two 
classes of global variables: those you set and those **pmake** sets. The ones you 
set can have any name you want them to have, except they may not contain 
a colon or an exclamation point. The variables **pmake** sets (almost) always 
begin with a period and contain only upper-case letters. The variables are as 
follows:

**.PMAKE** - The name by which **pmake** was invoked is stored in this variable. For 
compatibility, the name is also stored in the MAKE variable.

**.MAKEFLAGS** - All the relevant flags with which **pmake** was invoked. This does not 
include such things as "-f" or variable assignments. Again for 
compatibility, this value is stored in the MFLAGS variable as well.

Two other variables, .INCLUDES and .LIBS, are covered in the section on 
special targets (See section 10.13.4.9 of chapter 10).

Global variables may be deleted using lines of the form:

    #undef variable

The "#" must be the first character on the line. Note that this may only be 
done to global variables.

##### Environment Variables

Environment variables are passed by the shell that invoked **pmake** and are 
given by **pmake** to each shell it invokes. They are expanded like any other 
variable, but they cannot be altered in any way.

One special environment variable, PMAKE, is examined by **pmake** for 
command-line flags, variable assignments, etc. that it should always use. 
This variable is examined before the actual arguments to **pmake** are. In 
addition, all flags given to **pmake**, either through the PMAKE variable or on 
the command line, are placed in this environment variable and exported to 
each shell **pmake** executes. Thus recursive invocations of **pmake** 
automatically receive the same flags as the top-most one.

Many other standard environment variables are defined and described in the 
Include\GEOS.MK included Makefile.

Using all these variables, you can compress the sample makefile even more:

    OBJS = A.OBJ B.OBJ C.OBJ
    PROGRAM.EXE : $(OBJS)
        BCC $(.ALLSRC) -o $(.TARGET)
    $(OBJS) : DEFS.H
    A.OBJ : A.C
        BCC -c A.C
    B.OBJ : B.C
        BCC -c B.C
    C.OBJ : C.C
        BCC -c C.C

In addition to variables which **pmake** will use, you can set environment 
variables which shell commands may use using the pmake_set directive.

    .C.EBJ :
    pmake_set CL = $(CCOMFLAGS) /Fo$(.TARGET)
    $(CCOM) $(.IMPSRC)

You might use the above sequence to set up an argument list in the CL 
environment variable if your compiler (invoked with CCOM) needed its 
arguments in such a variable and was unable to take arguments in a file.

##### 10.13.4.4 Comments

Comments in a makefile start with a "#" character and extend to the end of 
the line. They may appear anywhere you want them, except where they 
might be misinterpreted as a shell command.

##### 10.13.4.5 Transformation Rules

As you know, a file's name consists of two parts: a base name, which gives 
some hint as to the contents of the file, and a suffix, which usually indicates 
the format of the file. Over the years, as DOS has developed, naming 
conventions, with regard to suffixes, have also developed that have become 
almost incontrovertible. For example, a file ending in .C is assumed to 
contain C source code; one with a .OBJ suffix is assumed to be a compiled, 
relocatable object file that may be linked into any program. One of the best 
aspects of **pmake** comes from its understanding of how the suffix of a file 
pertains to its contents and their ability to do things with a file based solely 
on its suffix. This ability comes from something known as a transformation 
rule. A transformation rule specifies how to change a file with one suffix into 
a file with another suffix.

A transformation rule looks much like a dependency line, except the target is 
made of two known suffixes stuck together. Suffixes are made known to 
**pmake** by placing them as sources on a dependency line whose target is the 
special target .SUFFIXES. For example:

    .SUFFIXES           : .obj .c
    .c.obj          :
        $(CCOM) $(CFLAGS) -c $(.IMPSRC)

The creation script attached to the target is used to transform a file with the 
first suffix (in this case, .c) into a file with the second suffix (here, .obj). In 
addition, the target inherits whatever attributes have been applied to the 
transformation rule. The simple rule above says that to transform a C source 
file into an object file, you compile it using your C compiler with the -c flag.

This rule is taken straight from the system makefile. Many transformation 
rules (and suffixes) are defined there; you should look there for more 
examples (type "pmake -h" to find out where it is).

There are some things to note about the transformation rule given above:

1. The .IMPSRC variable. This variable is set to the "implied source" (the file 
from which the target is being created; the one with the first suffix), 
which, in this case, is the .c file.

2. The CFLAGS variable. Almost all of the transformation rules in the 
system makefile are set up using variables that you can alter in your 
makefile to tailor the rule to your needs. In this case, if you want all your 
C files to be compiled with the -g flag, to provide information for Swat or 
CodeView, you would set the CFLAGS variable to contain -g ("CFLAGS = 
-g") and **pmake** would take care of the rest.

To give you a quick example, the makefile could be changed to this:

    OBJS = A.OBJ B.OBJ C.OBJ
    PROGRAM .EXE        : $(OBJS)
        $(CCOM) -o $(.TARGET) $(.ALLSRC)
    $(OBJS)             : DEFS.H

The transformation rule given above takes the place of the 6 lines.

    A.OBJ : A.C
        BCC -c A.C
    B.OBJ : B.C
        BCC -c B.C
    C.OBJ : C.C
        BCC -c C.C

Now you may be wondering about the dependency between the .obj and .c 
files-it's not mentioned anywhere in the new makefile. This is because it 
isn't needed: one of the effects of applying a transformation rule is the target 
comes to depend on the implied source (hence the name).

For a more detailed example, Suppose you have a makefile like this:

    A.EXE           : A.OBJ B.OBJ
        $(CCOM) $(.ALLSRC)

and a directory set up like this:

    total 4

    MAKEFILE          34    09-07-89        12:43a
    A        C       119    10-03-89         7:39p
    A        OBJ     201    09-07-89        12:43a
    B        C        69    09-07-89        12:43a

While just typing "**pmake**" will do the right thing, it's much more 
informative to type "**pmake -ds**" This will show you what **pmake** is up to as 
it processes the files. In this case, **pmake** prints the following:

    Suff_FindDeps (A.EXE)
        using existing source A.OBJ
        applying .OBJ -> .EXE to "A.OBJ"
    Suff_FindDeps (A.OBJ)
        trying A.C...got it
        applying .C -> .OBJ to "A.C"
    Suff_FindDeps (B.OBJ)
        trying B.C...got it
        applying .C -> .OBJ to "B.C"
    Suff_FindDeps (A.C)
        trying A.Y...not there
        trying A.L...not there
        trying A.C,V...not there
        trying A.Y,V...not there
        trying A.L,V...not there
    Suff_FindDeps (B.C)
        trying B.Y...not there
        trying B.L...not there
        trying B.C,V...not there
        trying B.Y,V...not there
        trying B.L,V...not there
    --- A.OBJ ---
    bcc -c A.C
    --- B.OBJ ---
    bcc -c B.C
    --- A.EXE ---
    bcc A.OBJ B.OBJ

*Suff_FindDeps* is the name of a function in **pmake** that is called to check for 
implied sources for a target using transformation rules. The transformations 
it tries are, naturally enough, limited to the ones that have been defined (a 
transformation may be defined multiple times, by the way, but only the most 
recent one will be used). You will notice, however, that there is a definite 
order to the suffixes that are tried. This order is set by the relative positions 
of the suffixes on the .SUFFIXES line-the earlier a suffix appears, the earlier 
it is checked as the source of a transformation. Once a suffix has been defined, 
the only way to change its position is to remove all the suffixes (by having a 
.SUFFIXES dependency line with no sources) and redefine them in the order 
you want. (Previously-defined transformation rules will be automatically 
redefined as the suffixes they involve are re-entered.) 

Another way to affect the search order is to make the dependency explicit. In 
the above example, a.exe depends on a.obj and b.obj. Since a transformation 
exists from .obj to .exe, **pmake** uses that, as indicated by the "using existing 
source a.obj" message.

The search for a transformation starts from the suffix of the target and 
continues through all the defined transformations, in the order dictated by 
the suffix ranking, until an existing file with the same base (the target name 
minus the suffix and any leading directories) is found. At that point, one or 
more transformation rules will have been found to change the one existing 
file into the target. 

For example, ignoring what's in the system makefile for now, say you have a 
makefile like this:

    .SUFFIXES : .EXE .OBJ .C .Y .L
    .L.C :
        LEX $(.IMPSRC)
        MOVE LEX.YY.C $(.TARGET)
    .Y.C :
        YACC $(.IMPSRC)
        MOVE Y.TAB.C $(.TARGET)
    .C.OBJ :
    BCC -L $(.IMPSRC)
    .OBJ.EXE :
        BCC -o $(.TARGET) $(.IMPSRC)

and the single file jive.l. If you were to type **pmake -rd ms jive.exe**, you 
would get the following output for jive.exe:

    Suff_FindDeps (JIVE.EXE)
    trying JIVE.OBJ...not there
    trying JIVE.C...not there
    trying JIVE.Y...not there
    trying JIVE.L...got it
    applying .L -> .C to "JIVE.L"
    applying .C -> .OBJ to "JIVE.C"
    applying .OBJ -> .EXE to "JIVE.OBJ"

The **pmake** tool starts with the target jive.exe, figures out its suffix (.exe) 
and looks for things it can transform to a .exe file. In this case, it only finds 
.obj, so it looks for the file JIVE.OBJ.

It fails to find it, so it looks for transformations into a .obj file. Again it has 
only one choice: .c. So it looks for JIVE.C and fails to find it. At this point it 
can create the .c file from either a .y file or a .l file. Since .y came first on the 
.SUFFIXES line, it checks for jive.y first, but can't find it, so it looks for jive.l. 
At this point, it has defined a transformation path as follows: .l->.c-> .obj-> 
.exe and applies the transformation rules accordingly. For completeness, and 
to give you a better idea of what **pmake** actually did with this three-step 
transformation, this is what **pmake** printed for the rest of the process:

    Suff_FindDeps (JIVE.OBJ)
    using existing source JIVE.C
    applying .C -> .OBJ to "JIVE.C"
    Suff_FindDeps (JIVE.C)
    using existing source JIVE.L
    applying .L -> .C to "JIVE.L"
    Suff_FindDeps (JIVE.L)
    Examining JIVE.L...modified 17:16:01 Oct 4,
     1987...up-to-date
    Examining JIVE.C...non-existent...out-of-date
    --- JIVE.C ---
    LEX JIVE.L
    -meaningless lex output deleted-
    MV LEX.YY.C JIVE.C
    Examining JIVE.OBJ...non-existent...out-of-date
    --- JIVE.OBJ ---
    bcc -c JIVE.C
    Examining JIVE.EXE...non-existent...out-of-date
    --- JIVE.EXE ---
    bcc -o JIVE.EXE JIVE.OBJ

##### 10.13.4.6 Including Other Makefiles

Just as for programs, it is often useful to extract certain parts of a makefile 
into another file and just include it in other makefiles somehow. Many 
compilers allow you to use something like

    #include "defs.h"

to include the contents of defs.h in the source file. The **pmake** program 
allows you to do the same thing for makefiles, with the added ability to use 
variables in the filenames. An include directive in a makefile looks either like 
this

    #include <file>

or like this

    #include "file"

The difference between the two is where **pmake** searches for the file: the first 
way, **pmake** will look for the file only in the system makefile directory (to find 
out what that directory is, give **pmake** the -h flag).

For files in double-quotes, the search is more complex; **pmake** will look in the 
following places in the given order:

1. The directory of the makefile that's including the file.

2. The current directory (the one in which you invoked **pmake**).

3. The directories given by you using -I flags, in the order in which you gave 
them.

4. Directories given by .PATH dependency lines.

5. The system makefile directory.

You are free to use **pmake** variables in the filename - **pmake** will expand 
them before searching for the file. You must specify the searching method 
with either angle brackets or double-quotes outside of a variable expansion. 
That is, the following

    SYSTEM= <command.mk>
    #include $(SYSTEM)

won't work; instead use the following:

    SYSTEM= command.mk
    #include <$(SYSTEM)>

##### 10.13.4.7 Saving Commands

There may come a time when you will want to save certain commands to be 
executed when everything else is done, by inserting an ellipsis "-" in the 
Makefile. Commands saved in this manner are only executed if **pmake** 
manages to re-create everything without an error.

##### 10.13.4.8 Target Attributes

The **pmake** tool allows you to give attributes to targets by means of special 
sources. Like everything else **pmake** uses, these sources begin with a period 
and are made up of all upper-case letters. By placing one (or more) of these 
as a source on a dependency line, you are "marking" the target(s) with that 
attribute.

Any attributes given as sources for a transformation rule are applied to the 
target of the transformation rule when the rule is applied.

**.DONTCARE** - If a target is marked with this attribute and **pmake** can't figure out how 
to create it, it will ignore this fact and assume the file isn't really needed 
or actually exists and **pmake** just can't find it. This may prove wrong, but 
the error will be noted later on, not when **pmake** tries to create the 
target so marked. This attribute also prevents **pmake** from attempting 
to touch the target if given the "-t" flag.

**.EXEC** - This attribute causes its shell script to be executed while having no effect 
on targets that depend on it. This makes the target into a sort of 
subroutine. EXEC sources don't appear in the local variables of targets 
that depend on them (nor are they touched if **pmake** is given the -t flag).

**.IGNORE** - Giving a target the .IGNORE attribute causes **pmake** to ignore errors 
from any of the target's commands, as if they all had "-" before them.

**.MAKE** - The .MAKE attribute marks its target as being a recursive invocation of 
**pmake**. This forces **pmake** to execute the script associated with the 
target (if it's out-of-date) even if you gave the -n or -t flag. By doing this, 
you can start at the top of a system and type

    pmake -n

and have it descend the directory tree (if your makefiles are set up 
correctly), printing what it would have executed if you hadn't included 
the -n flag.

**.NOTMAIN** - Normally, if you do not specify a target to make in any other way, **pmake** 
will take the first target on the first dependency line of a makefile as the 
target to create. That target is known as the "Main Target" and is labeled 
as such if you print the dependencies out using the -p flag. Giving a 
target, this attribute tells **pmake** that the target is definitely not the 
Main Target. This allows you to place targets in an included makefile and 
have **pmake** create something else by default.

**.PRECIOUS** - When pmake is interrupted (by someone typing control-C at the 
keyboard), it will attempt to clean up after itself by removing any 
half-made targets. If a target has the .PRECIOUS attribute, however, 
**pmake** will leave it alone. A side effect of the "::" operator is to mark the 
targets as .PRECIOUS.

**.SILENT** - Marking a target with this attribute keeps its commands from being 
printed when they're executed, just as if they had an "@" in front of them.

**.USE** - By giving a target this attribute, you turn it into **pmake**'s equivalent of 
a macro. When the target is used as a source for another target, the other 
target acquires the commands, sources and attributes (except .USE) of 
the source. If the target already has commands, the .USE target's 
commands are added to the end. If more than one .USE-marked source is 
given to a target, the rules are applied sequentially.

The typical .USE rule will use the sources of the target to which it is 
applied (as stored in the .ALLSRC variable for the target) as its 
"arguments." Several system makefiles (not to be confused with the 
system makefile) make use of these .USE rules to make developing easier 
(they're in the default, system makefile directory).

##### 10.13.4.9 Special Targets

There are certain targets that have special meaning to **pmake**. When you 
use one on a dependency line, it is the only target that may appear on the 
left-hand-side of the operator. As for the attributes and variables, all the 
special targets begin with a period and consist of upper-case letters only. The 
targets are as follows:

**.BEGIN** - Any commands attached to this target are executed before anything else 
is done. You can use it for any initialization that needs doing.

**.DEFAULT** - This is sort of a .USE rule for any target (that was used only as a source) 
that **pmake** can't figure out any other way to create. It's only "sort of" a 
.USE rule because only the shell script attached to the .DEFAULT target 
is used. The .IMPSRC variable of a target that inherits .DEFAULT's 
commands is set to the target's own name.

**.END** - This serves a function similar to .BEGIN, in that commands attached to 
it are executed once everything has been re-created (so long as no errors 
occurred). It also serves the extra function of being a place on which 
**pmake** can hang commands you put off to the end. Thus the script for 
this target will be executed before any of the commands you save with the 
ellipsis marker.

**.IGNORE** - This target marks each of its sources with the .IGNORE attribute. If you 
don't give it any sources, then it is like giving the -i flag when you invoke 
**pmake** - errors are ignored for all commands.

**.INCLUDES** - The sources for this target are taken to be suffixes that indicate a file that 
can be included in a program source file. The suffix must already be 
declared with .SUFFIXES. Any suffix so marked will have the directories 
on its search path (see .PATH, below) placed in the .INCLUDES variable, 
each preceded by a "-I" flag. This variable can then be used as an 
argument for the compiler in the normal fashion. The ".h" suffix is 
already marked in this way in the system makefile. For example, if you 
have 

    .SUFFIXES           : .PCX
    .PATH.PCX           : \CLIPART
    .INCLUDES           : .PCX

**pmake** places "-I\CLIPART" in the .INCLUDES variable and you can say 

    bcc $(.INCLUDES) -c xprogram.c

(Note: the .INCLUDES variable is not actually filled in until the entire 
makefile has been read.)

**.INTERRUPT** - When **pmake** is interrupted, it will execute the commands in the script 
for this target, if it exists.

**.LIBS** - This does for libraries what .INCLUDES does for include files, except the 
flag used is "-L", as required by those linkers that allow you to tell them 
where to find libraries. The variable used is .LIBS.

**.MAIN** - If you didn't give a target (or targets) to create when you invoked **pmake**, 
it will take the sources of this target as the targets to create.

**.MAKEFLAGS** - This target provides a way for you to always specify flags for **pmake** 
when the makefile is used. The flags are just as they would be typed to 
the shell (except you can't use shell variables unless they're in the 
environment), though the -f and -r flags have no effect.

**.PATH** - If you give sources for this target, **pmake** will take them as directories 
in which to search for files it cannot find in the current directory. If you 
give no sources, it will clear out any directories added to the search path 
before. 

**.PATHsuffix** - This does a similar thing to .PATH, but it does it only for files with the 
given suffix. The suffix must have been defined already. Look at section 
10.13.5.1 for more information.

**.PRECIOUS** - Similar to .IGNORE, this gives the .PRECIOUS attribute to each source on 
the dependency line, unless there are no sources, in which case the 
.PRECIOUS attribute is given to every target in the file.

**.RECURSIVE** - This target applies the .MAKE attribute to all its sources. It does nothing 
if you don't give it any sources.

**.SILENT** - When you use .SILENT as a target, it applies the .SILENT attribute to 
each of its sources. If there are no sources on the dependency line, then it 
is as if you gave **pmake** the -s flag and no commands will be echoed.

**.SUFFIXES** - This is used to give new file suffixes for **pmake** to handle. Each source is 
a suffix **pmake** should recognize. If you give a .SUFFIXES dependency 
line with no sources, **pmake** will forget about all the suffixes it knew.

In addition to these targets, a line of the form

    attribute : sources

applies the attribute to all the targets listed as sources .

##### 10.13.4.10 Modifying Variable Expansion

Variables need not always be expanded verbatim. The **pmake** program 
defines several modifiers that may be applied to a variable's value before it is 
expanded. You apply a modifier by placing it after the variable name with a 
colon between the two, like so:

    ${VARIABLE:modifier}

Each modifier is a single character followed by something specific to the 
modifier itself. You may apply as many modifiers as you want - each one is 
applied to the result of the previous and is separated from the previous by 
another colon.

There are several ways to modify a variable's expansion:

**:Mpattern** - This is used to select only those words (a word is a series of 
characters that are neither spaces nor tabs) that match the 
given pattern. The pattern is a wildcard pattern like that used 
by the shell, where * means zero or more characters of any sort; 
? is any single character; [abcd] matches any single character 
that is one of "a", "b", "c" or "d" (there may be any number of 
characters between the brackets); [0-9] matches any single 
character that is between "0" and "9" (i.e. any digit. This form 
may be freely mixed with the other bracket form), and `\\' is 
used to escape any of the characters "*", "?", "[" or ":", leaving 
them as regular characters to match themselves in a word. 

Remember that the pattern matcher requires you to prefix 
certain characters with a backslash, including backslash itself. 
this can lead to some impressive search strings, because 
**pmake** also requires that backslashes be preceded with 
backslashes:

    #if !empty(CURRENT_DIR:M*\\\\APPL\\\\*)

The above line checks to see if the current directory matches 
the form `*\APPL\*`. (The pattern matcher is passed the 
string `*\\APPL\\*`.)

**:Npattern** - This is identical to :M except it substitutes all words that don't 
match the given pattern. 

**:Xpattern** - This is like :M except that it returns only part of the matching 
string. You mark which part of the string you are interested in 
by enclosing it within backslashed square brackets (`\[` and 
`\]`) (however, due to the backslash rules, you must actually 
use `\\[` and `\\]`.)

        DEVEL_DIR   := \
         $(CURRENT_DIR:X\\[*\\\\$(ROOT_DIR:T)\\\\*\\]\\\\*)

The above line returns part of the CURRENT_DIR string, 
specifically the directory just under the root directory. Free of 
backslashes, it's searching for `[*\$(ROOT_DIR:T)\*]\*`. If there 
is a subdirectory below the development directory, then this 
will strip off the lower layers.

**:S/search-string/replacement-string/[g]** - This causes the first occurrence of *search-string* in the variable 
to be replaced by *replacement-string*, unless the "g" flag is given 
at the end, in which case all occurrences of the string are 
replaced. The substitution is performed on each word in the 
variable in turn. If search-string begins with a caret ("^"), the 
string must match starting at the beginning of the word. If 
search-string ends with a dollar sign ("$"), the string must 
match to the end of the word (these two may be combined to 
force an exact match). If a backslash precedes these two 
characters, however, they lose their special meaning. Variable 
expansion also occurs in the normal fashion inside both the 
search-string and the replacement-string, except that a 
backslash is used to prevent the expansion of a "$", not another 
dollar sign, as is usual. Note that search-string is just a string, 
not a pattern, so none of the usual regular-expression/wildcard 
characters have any special meaning save "^" and "$". In the 
replacement string, the "&" character is replaced by the 
search-string unless it is preceded by a backslash. Thus, 
":S/[A-D]/&&/" will automatically cause any of the characters 
between "A" and "D" to be repeated. You are allowed to use any 
character except colon or exclamation point to separate the two 
strings. This so-called delimiter character may be placed in 
either string by preceding it with a backslash.

**:T** - Replaces each word in the variable expansion by its last 
component (its "tail"). For example, given

        OBJS = ..\LIB\A.OBJ B \USR\LIB\LIBM.A
        TAILS = $(OBJS:T)

the variable TAILS would expand to "a.obj b libm.a" .

**:H** - This is similar to :T, except that every word is replaced by 
everything but the tail (the "head"). Using the same definition 
of OBJS, the string "$(OBJS:H)" would expand to 
"..\LIB \USR\LIB" Note that the final slash on the heads is 
removed and anything without a head is replaced by a single 
period.

**:E** - This replaces each word with its suffix ("extension"), so 
"$(OBJS:E)" would give you ".OBJ .A" .

**:R** - This replaces each word with everything but the suffix (thus 
returning the "root" of the word). "$(OBJS:R)" expands to 
"..\LIB\A B \USR\LIB\LIBM".

In addition, another style of substitution is also supported. This looks like:

    $(VARIABLE:search-string=replacement)

It must be the last modifier in the chain. The search is anchored at the end 
of each word, so only suffixes or whole words may be replaced.

#### 10.13.5 Advanced pmake Techniques

This section is devoted to those facilities in **pmake** that allow you to do a 
great deal in a makefile with very little work, as well as do some things you 
couldn't do in make without a great deal of work (and perhaps the use of other 
programs). The problem with these features is that they must be handled 
with care, or you will end up with a mess.

##### 10.13.5.1 Search Paths

The **pmake** tool supports the dispersal of files into multiple directories by 
allowing you to specify places to look for sources with .PATH targets in the 
makefile. The directories you give as sources for these targets make up a 
"search path." Only those files used exclusively as sources are actually sought 
on a search path, the assumption being that anything listed as a target in the 
makefile can be created by the makefile and thus should be in the current 
directory.

There are two types of search paths in **pmake**: one is used for all types of files 
(including included makefiles) and is specified with a plain .PATH target (e.g. 
".PATH : RCS"), while the other is specific to a certain type of file, as indicated 
by the file's suffix. A specific search path is indicated by immediately 
following the .PATH with the suffix of the file. For instance

    .PATH.H : \GEOSDEV\DEVEL\APPL\WORPRO \GEOSDEV\DEVEL

would tell **pmake** to look in the directories 
\GEOSDEV\DEVEL\APPL\WORPRO and \GEOSDEV\DEVEL for any files 
whose suffix is .H.

The current directory is always consulted first to see if a file exists. Only if it 
cannot be found are the directories in the specific search path, followed by 
those in the general search path, consulted.

A search path is also used when expanding wildcard characters. If the 
pattern has a recognizable suffix on it, the path for that suffix will be used for 
the expansion. Otherwise the default search path is employed.

When a file is found in some directory other than the current one, all local 
variables that would have contained the target's name (.ALLSRC and 
.IMPSRC) will instead contain the path to the file, as found by pmake. Thus 
if you have a file ..\LIB\MUMBLE.C and a makefile

    .PATH.c : ..\LIB
    MUMBLE.EXE          : MUMBLE.C
        $(CCOM) -o $(.TARGET) $(.ALLSRC)

the command executed to create MUMBLE.EXE would be  
"bcc -o MUMBLE ..\LIB\MUMBLE.C"

If a file exists in two directories on the same search path, the file in the first 
directory on the path will be the one **pmake** uses. So if you have a large 
system spread over many directories, it would behoove you to follow a 
naming convention that avoids such conflicts.

Something you should know about the way search paths are implemented is 
that each directory is read, and its contents cached, exactly once - when it is 
first encountered-so any changes to the directories while **pmake** is running 
will not be noted when searching for implicit sources, nor will they be found 
when **pmake** attempts to discover when the file was last modified, unless the 
file was created in the current directory. 

##### 10.13.5.2 Conditional Statements

Like a C compiler, **pmake** allows you to configure the makefile using 
conditional statements. A conditional looks like this:

    #if <Boolean expression>
    <lines>
    #elif <another Boolean expression>
    <more lines>
    #else
    <still more lines>
    #endif

They may be nested to a depth of 30 and may occur anywhere (except in a 
comment, of course). The "#" must be the very first character on the line.

Each Boolean expression is made up of terms that look like function calls, the 
standard C Boolean operators &&, ||, and !, and the standard relational 
operators ==, !=, >, >=, <, and <=, with == and != being overloaded to allow 
string comparisons as well. The && operator represents logical AND; || is 
logical OR and ! is logical NOT. The arithmetic and string operators take 
precedence over all three of these operators, while NOT takes precedence over 
AND, which takes precedence over OR. This precedence may be overridden 
with parentheses, and an expression may be parenthesized to any level. Each 
Boolean term looks like a call on one of four functions:

**make** - The syntax is make(*target*) where *target* is a target in the 
makefile. This is *true* if the given target was specified on the 
command line or as the source for a .MAIN target (note that the 
sources for .MAIN are only used if no targets were given on the 
command line).

**defined** - The syntax is defined(*variable*) and is true if *variable* is 
defined. Certain variables are defined in the system makefile 
that identify the system on which **pmake** is being run.

**exists** - The syntax is exists(file) and is true if the file can be found on 
the global search path (i.e. that defined by .PATH targets, not 
by .PATH*suffix* targets).

**empty** - This syntax is much like the others, except the string inside the 
parentheses is of the same form as you would put between 
parentheses when expanding a variable, complete with 
modifiers. The function returns true if the resulting string is 
empty. (Note: an undefined variable in this context will cause 
at the very least a warning message about a malformed 
conditional, and at the worst will cause the process to stop once 
it has read the makefile. If you want to check for a variable 
being defined or empty, use the expression 

    !defined(var) || empty(var)

as the definition of || will prevent the empty() from being 
evaluated and causing an error, if the variable is undefined). 
This can be used to see if a variable contains a given word, for 
example:

    #if !empty(var:Mword)

The arithmetic and string operators may only be used to test the value of a 
variable. The left-hand side must contain the variable expansion, while the 
right-hand side contains either a string, enclosed in double-quotes, or a 
number. The standard C numeric conventions (except for specifying an octal 
number) apply to both sides. For example, 

    #if $(OS) == 4.3
    #if $(MACHINE) == "sun3"
    #if $(LOAD_ADDR) < 0xc000

are all valid conditionals. In addition, the numeric value of a variable can be 
tested as a Boolean as follows:

    #if $(LOAD)

would see if LOAD contains a non-zero value and

    #if !$(LOAD)

would test if LOAD contains a zero value.

In addition to the bare #if, there are other forms that apply one of the first 
two functions to each term. They are as follows:

    ifdef       defined
    ifndef      !defined
    ifmake      make
    ifnmake     !make

There are also the "else if" forms: elif, elifdef, elifndef, elifmake, and 
elifnmake.

#### 10.13.6 The Way Things Work

When **pmake** reads the makefile, it parses sources and targets into nodes in 
a graph. The graph is directed only in the sense that **pmake** knows which 
way is up. Each node contains not only links to all its parents and children 
(the nodes that depend on it and those on which it depends, respectively), but 
also a count of the number of its children that have already been processed.

The most important thing to know about how **pmake** uses this graph is that 
the traversal is breadth-first and occurs in two passes.

After **pmake** has parsed the makefile, it begins with the nodes the user has 
told it to make (either on the command line, or via a .MAIN target, or by the 
target being the first in the file not labeled with the .NOTMAIN attribute) 
placed in a queue. It continues to take the node off the front of the queue, 
mark it as something that needs to be made, pass the node to 
Suff_FindDeps() (mentioned earlier) to find any implicit sources for the node, 
and place all the node's children that have yet to be marked at the end of the 
queue. If any of the children is a .USE rule, its attributes are applied to the 
parent, then its commands are appended to the parent's list of commands and 
its children are linked to its parent. The parent's unmade-children counter is 
then decremented (since the .USE node has been processed). This allows a 
.USE node to have children that are .USE nodes, and the rules will be applied 
in sequence. If the node has no children, it is placed at the end of another 
queue to be examined in the second pass. This process continues until the 
first queue is empty.

At this point, all the leaves of the graph are in the examination queue; 
**pmake** removes the node at the head of the queue and sees if it is out-of-date. 
If it is, it is passed to a function that will execute the commands for the node 
asynchronously. When the commands have completed, all the node's parents 
have their unmade-children counter decremented and, if the counter is then 
zero, they are placed on the examination queue. Only those parents that were 
marked on the downward pass are processed in this way. Thus **pmake** 
traverses the graph back up to the nodes the user instructed it to create. 
When the examination queue is empty and no shells are running to create a 
target, **pmake** is finished.

Once all targets have been processed, **pmake** executes the commands 
attached to the .END target, either explicitly or through the use of an ellipsis 
in a shell script. If there were no errors during the entire process but there 
are still some targets unmade (**pmake** keeps a running count of how many 
targets are left to be made), there is a cycle in the graph. The **pmake** 
program does a depth-first traversal of the graph to find all the targets that 
weren't made and prints them out one by one.

### 10.14 Swat Stub

The swat stub runs on the target machine, passing information between a 
running GEOS session and Swat on the host machine. It has one flag:

**/H:hardware** - Specify special hardware for sending signals. The only possible 
argument is P for sending via a serial port in a PCMCIA card.


[The INI File](tini.md) <-- &nbsp;&nbsp; [Table of Contents](../tools.md)