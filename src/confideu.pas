unit confideu;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msegui,msegraphics,
 msegraphutils,mseclasses,mseforms,msegraphedits,msesimplewidgets,mseificomp,
 mseificompglob,mseifiglob,msemenus,msescrollbar,msedataedits,mseedit,msestat,
 msestatfile,msestream,msestrings,sysutils,msewidgets,msebitmap,msedatanodes,
 msefiledialog,msegrids,mselistbrowser,msesys;
type
 tconfideufo = class(tmseform)
   tbfilereload0: tbooleaneditradio;
   tbfilereload1: tbooleaneditradio;
   tbfilereload2: tbooleaneditradio;
   tlabel1: tlabel;
   ok: tbutton;
   tbassistive: tbooleanedit;
   tesakitdir: tfilenameedit;
 end;
var
 confideufo: tconfideufo;
implementation
uses
 confideu_mfm;
end.
