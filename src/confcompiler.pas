unit confcompiler;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msegui,msefiledialog,
 msegraphics,msegraphutils,mseevent,mseclasses,msewidgets,mseforms,
 msesimplewidgets,msebitmap,msedataedits,msedatanodes,mseedit,msegrids,
 mseificomp,mseificompglob,mseifiglob,mselistbrowser,msemenus,msestat,
 msestatfile,msestream,msestrings,msesys,sysutils,msegraphedits,msescrollbar;
 type
 tconfcompilerfo = class(tmseform)
   fpccompiler: tfilenameedit;
   ccompiler: tfilenameedit;
   javacompiler: tfilenameedit;
   othercompiler: tfilenameedit;
   fpccompiler2: tfilenameedit;
   fpccompiler3: tfilenameedit;
   ccompiler2: tfilenameedit;
   tlabel1: tlabel;
   tlabel3: tlabel;
   ccompiler3: tfilenameedit;
   tlabel4: tlabel;
   javacompiler2: tfilenameedit;
   tlabel5: tlabel;
   pythoncompiler: tfilenameedit;
   tlabel6: tlabel;
   pythoncompiler2: tfilenameedit;
   pythoncompiler3: tfilenameedit;
   ccompiler4: tfilenameedit;
   fpccompiler4: tfilenameedit;
   pythoncompiler4: tfilenameedit;
   javacompiler4: tfilenameedit;
   othercompiler2: tfilenameedit;
   othercompiler4: tfilenameedit;
   othercompiler3: tfilenameedit;
   tstatfile1: tstatfile;
   tnClose: tbutton;
   nozorderenable: tbooleanedit;
   winep1: tbooleanedit;
   tlabel2: tlabel;
   winep2: tbooleanedit;
   winep3: tbooleanedit;
   winep4: tbooleanedit;
   twinec1: tbooleanedit;
   twinec4: tbooleanedit;
   twinec3: tbooleanedit;
   twinec2: tbooleanedit;
   twinej4: tbooleanedit;
   twinej3: tbooleanedit;
   twinej2: tbooleanedit;
   twineo4: tbooleanedit;
   javacompiler3: tfilenameedit;
   twinep4: tbooleanedit;
   twinep3: tbooleanedit;
   twinep2: tbooleanedit;
   twinep1: tbooleanedit;
   twinepy4: tbooleanedit;
   twinepy3: tbooleanedit;
   twinepy2: tbooleanedit;
   twinepy1: tbooleanedit;
   twineo1: tbooleanedit;
   twineo2: tbooleanedit;
   twinej1: tbooleanedit;
   twineo3: tbooleanedit;
   tlabel7: tlabel;
   fpccompiler8: tfilenameedit;
   twinep8: tbooleanedit;
   fpccompiler7: tfilenameedit;
   twinep7: tbooleanedit;
   fpccompiler6: tfilenameedit;
   twinep6: tbooleanedit;
   fpccompiler5: tfilenameedit;
   twinep5: tbooleanedit;
   ccompiler7: tfilenameedit;
   ccompiler8: tfilenameedit;
   twinec8: tbooleanedit;
   twinec7: tbooleanedit;
   twinec6: tbooleanedit;
   twinec5: tbooleanedit;
   ccompiler5: tfilenameedit;
   ccompiler6: tfilenameedit;
 end;
var
 confcompilerfo: tconfcompilerfo;
implementation
uses
 confcompiler_mfm;
end.
