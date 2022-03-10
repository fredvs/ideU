unit conflang;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 msegraphics,msegraphutils,mseevent,mseclasses,msewidgets,mseforms,
 msesimplewidgets,msegraphedits,mseificomp,mseificompglob,mseifiglob,
 msescrollbar,msestatfile,mseact,msedataedits,msedragglob,msedropdownlist,
 mseedit,msegrids,msegridsglob,msestream,msewidgetgrid,SysUtils,msedispwidgets,
 mserichstring;

type
  tconflangfo = class(tmseform)
    ok: TButton;
    setasdefault: tbooleanedit;
    gridlang: twidgetgrid;
    gridlangcaption: tstringedit;
    gridlangbool: tbooleaneditradio;
    gridlangcode: tstringedit;
   bpotools: tbutton;
   lsetasdefault: tlabel;
   bousemo: tbooleanedit;
    procedure oncok(const Sender: TObject);
    procedure oncreat(const Sender: TObject);
    procedure oncellev(const Sender: TObject; var info: celleventinfoty);
   procedure ontools(const sender: TObject);
   procedure onchange(const sender: TObject);
   end;

var
  conflangloaded: shortint = 0;
  conflangfo: tconflangfo;

implementation

uses
  main,
  msestockobjects,
  confideu,
  potools,
  confcompiler,
  confdebugger,
  conflang_mfm,
  captionideu;

procedure tconflangfo.oncok(const Sender: TObject);
begin
   Close;
end;

procedure tconflangfo.oncreat(const Sender: TObject);
begin
  Visible := False;
end;

procedure tconflangfo.oncellev(const Sender: TObject; var info: celleventinfoty);
var
  x: integer;
begin
  if conflangloaded > 0 then
    if info.eventkind = cek_buttonrelease then
    begin
      MSEFallbackLang := '';
      for x           := 0 to gridlang.rowcount - 1 do
        if x = info.cell.row then
        begin
          gridlangbool[x] := True;
          MSEFallbackLang := gridlangcode[x];
       
          mainfo.setlangideu(MSEFallbackLang);
        end
        else
          gridlangbool[x] := False;
    end;
end;

procedure tconflangfo.ontools(const sender: TObject);
begin
headerfo.show(true);
end;

procedure tconflangfo.onchange(const sender: TObject);
begin
if conflangloaded > 0 then
 mainfo.setlangideu(MSEFallbackLang);
end;


end.

