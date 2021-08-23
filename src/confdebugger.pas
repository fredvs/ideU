unit confdebugger;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  mseconsts_ide,
  mseconsts_ide_ru,
  mseconsts_ide_de,
  mseconsts_ide_es,
  mseconsts_ide_fr,
  msestockobjects,
  msetypes,
  mseglob,
  mseguiglob,
  mseguiintf,
  mseapplication,
  msestat,
  msemenus,
  msegui,
  msegraphics,
  msegraphutils,
  mseevent,
  mseclasses,
  msewidgets,
  mseforms,
  msesimplewidgets,
  msebitmap,
  msedataedits,
  msedatanodes,
  mseedit,
  msefiledialogx,
  msegrids,
  mseificomp,
  mseificompglob,
  mseifiglob,
  mselistbrowser,
  msestatfile,
  msestream,
  msestrings,
  msesys,
  SysUtils;

type
  tconfdebuggerfo = class(tmseform)
    debugger4: tfilenameeditx;
    debugger3: tfilenameeditx;
    debugger2: tfilenameeditx;
    debugger1: tfilenameeditx;
    tnClose: TButton;
    procedure setlangdebuggers();
    procedure oncreat(const Sender: TObject);
  end;

var
  confdebuggerfo: tconfdebuggerfo;

implementation

uses
  confdebugger_mfm;

procedure tconfdebuggerfo.oncreat(const Sender: TObject);
begin
  setlangdebuggers();
end;

procedure tconfdebuggerfo.setlangdebuggers();
begin
  Caption         := stockobjects.captions[sc_configdebuggers];
  tnClose.Caption := stockobjects.modalresulttext[mr_ok];
end;

end.

