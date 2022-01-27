unit confmsegui;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msegui,msefiledialog,
 msegraphics,msegraphutils,mseclasses,mseforms,msesimplewidgets,msestat,
 msestatfile;
type
 tconfmseguifo = class(tmseform)
   msedir: tfilenameedit;
   mselibdir: tfilenameedit;
   tbutton1: tbutton;
 end;
var
 confmseguifo: tconfmseguifo;
implementation
uses
 confmsegui_mfm;
end.
