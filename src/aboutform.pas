unit aboutform;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 msegraphics,msegraphutils,mseevent,mseclasses,msewidgets,mseforms,mseedit,
 msestatfile,msestream,msestrings,sysutils,msesimplewidgets,mseact,msedataedits,
 mseificomp,mseificompglob,mseifiglob;
type
 taboutfo = class(tmseform)
   OK: tbutton;
   about_text: tmemoedit;
 end;
var
 aboutfo: taboutfo;
implementation
uses
 aboutform_mfm;
end.
