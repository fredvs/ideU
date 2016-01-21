unit confdebugger;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 msegraphics,msegraphutils,mseevent,mseclasses,msewidgets,mseforms,
 msesimplewidgets,msebitmap,msedataedits,msedatanodes,mseedit,msefiledialog,
 msegrids,mseificomp,mseificompglob,mseifiglob,mselistbrowser,msestatfile,
 msestream,msestrings,msesys,sysutils;
type
 tconfdebuggerfo = class(tmseform)
   tlabel6: tlabel;
   debugger4: tfilenameedit;
   debugger3: tfilenameedit;
   debugger2: tfilenameedit;
   debugger1: tfilenameedit;
   tnClose: tbutton;
 end;
var
 confdebuggerfo: tconfdebuggerfo;
implementation
uses
 confdebugger_mfm;
end.
