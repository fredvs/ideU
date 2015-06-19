unit confcompiler;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msegui,msefiledialog,
 msegraphics,msegraphutils,mseevent,mseclasses,msewidgets,mseforms,
 msesimplewidgets;
 type
 tconfcompilerfo = class(tmseform)
   fpccompiler: tfilenameedit;
   ccompiler: tfilenameedit;
   javacompiler: tfilenameedit;
   tbutton1: tbutton;
   othercompiler: tfilenameedit;
   fpccompiler2: tfilenameedit;
   fpccompiler3: tfilenameedit;
   ccompiler2: tfilenameedit;
   tlabel1: tlabel;
   tlabel3: tlabel;
   ccompiler3: tfilenameedit;
   tlabel4: tlabel;
   javacompiler2: tfilenameedit;
   javacompiler3: tfilenameedit;
   tlabel5: tlabel;
   pythoncompiler: tfilenameedit;
   tlabel6: tlabel;
   pythoncompiler2: tfilenameedit;
   pythoncompiler3: tfilenameedit;
 end;
var
 confcompilerfo: tconfcompilerfo;
implementation
uses
 confcompiler_mfm;
end.
