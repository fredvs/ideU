
unit beauty;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

uses 
msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus, msegui, 
msegraphics, msegraphutils, mseevent, mseclasses, msewidgets, mseforms, 
msesimplewidgets, msegraphedits, mseificomp, mseificompglob, mseifiglob, 
msescrollbar, msedispwidgets, mserichstring;

type 
  tbeautyfo = class(tmseform)
    group_file_changed: tgroupbox;
    tbjedi: tbooleaneditradio;
    tbptop: tbooleaneditradio;
    tbutton1: tbutton;
    createbackup: tbooleanedit;
    filetoclean: tstringdisp;
    tbutton2: tbutton;
    procedure dobeauti(const sender: TObject);
    procedure oncreate(const sender: TObject);
    procedure doclose(const sender: TObject);
  end;

var 
  beautyfo: tbeautyfo;

implementation

uses 
beauty_mfm, plugmanager, commandorform;
procedure tbeautyfo.dobeauti(const sender: TObject);

var 
  x : integer;
begin
  if tbptop.value then x := 0
  else x := 1;
  DoBeautifier(debuggerfo.file_history.value, x, createbackup.value);
end;

procedure tbeautyfo.oncreate(const sender: TObject);
begin
  visible := false;
end;

procedure tbeautyfo.doclose(const sender: TObject);
begin
  close;
end;

end.
