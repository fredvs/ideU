
unit beauty;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

uses
  msetypes,
  mseglob,
  mseguiglob,
  SysUtils,
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
  msegraphedits,
  mseificomp,
  mseificompglob,
  mseifiglob,
  msescrollbar,
  msedispwidgets,
  mserichstring;

type
  tbeautyfo = class(tmseform)
    group_file_changed: tgroupbox;
    tbjedi: tbooleaneditradio;
    tbptop: tbooleaneditradio;
    createbackup: tbooleanedit;
    filetoclean: tstringdisp;
    tbutton2: TButton;
    procedure dobeauti(const Sender: TObject);
    procedure doclose(const Sender: TObject);
    procedure ondestroyev(const Sender: TObject);
  end;

var
  beautyfo: tbeautyfo;
  beautyformcreated: Boolean = False;

procedure doBeauty;

implementation

uses
  beauty_mfm,
  plugmanager,
  commandorform;

procedure doBeauty;
begin
  try
    application.createform(tbeautyfo, beautyfo);
    beautyfo.filetoclean.Value := ExtractFileName(debuggerfo.file_history.Value);
    beautyfo.filetoclean.hint  := debuggerfo.file_history.Value;
    beautyfo.Show(true);
   // beautyfo.bringtofront;
    beautyformcreated          := True;
  finally
  end;
end;

procedure tbeautyfo.dobeauti(const Sender: TObject);
var
  x: integer;
begin
  if tbptop.Value then
    x := 0
  else
    x := 1;
  DoBeautifier(ansistring(debuggerfo.file_history.Value), x, createbackup.Value);
end;

procedure tbeautyfo.doclose(const Sender: TObject);
begin
  Close;
end;

procedure tbeautyfo.ondestroyev(const Sender: TObject);
begin
  beautyformcreated := False;
end;

end.

