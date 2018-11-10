Here how to create a project from .lpi Lazarus-Ultibo projects:

- In ideU menu |Setting|General Setting| ---> tab |Macros|
- Add those 3 macros according your system: 
 
      Value                            Name
-  /the/directoryof/ultibo          ULTIBODIR       // directory of Ultibo
-  /the/directoryof/fpc             ULTIBOCOMP      // full filename of fpc-ultibo compiler
-  /the/directoryof/fpGUI-ultibo    FPGULTIBODIR    // directory of fpGUI-ultibo if using fpgui

1) Copy ultibo.prj or ultibo_fpgui.prj and paste it in same directory of your lpi project.
(example myproject.lpi).
2) Rename it with the same name as the name of main program (usually name of the .lpi).
   Example: myproject.prj for myproject.lpi
3) Load it with ideU, compile it, run it.
