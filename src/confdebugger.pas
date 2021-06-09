unit confdebugger;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 msegraphics,msegraphutils,mseevent,mseclasses,msewidgets,mseforms,
 msesimplewidgets,msebitmap,msedataedits,msedatanodes,mseedit,msefiledialogx,
 msegrids,mseificomp,mseificompglob,mseifiglob,mselistbrowser,msestatfile,
 msestream,msestrings,msesys,sysutils;
type
 tconfdebuggerfo = class(tmseform)
   tlabel6: tlabel;
   debugger4: tfilenameeditx;
   debugger3: tfilenameeditx;
   debugger2: tfilenameeditx;
   debugger1: tfilenameeditx;
   tnClose: tbutton;
   procedure oncreat(const sender: TObject);
 end;
var
 confdebuggerfo: tconfdebuggerfo;
implementation
uses
 confdebugger_mfm;
procedure tconfdebuggerfo.oncreat(const sender: TObject);
begin
// icon := mainfo.icon;
end;

end.
