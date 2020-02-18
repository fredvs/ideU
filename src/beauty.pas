
unit beauty;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

uses
 msetypes, mseglob, mseguiglob, sysutils, mseguiintf, mseapplication, msestat, msemenus,
 msegui,msegraphics, msegraphutils, mseevent, mseclasses, msewidgets, mseforms,
 msesimplewidgets, msegraphedits, mseificomp, mseificompglob, mseifiglob,
 msescrollbar, msedispwidgets, mserichstring;

type 
  tbeautyfo = class(tmseform)
    group_file_changed: tgroupbox;
    tbjedi: tbooleaneditradio;
    tbptop: tbooleaneditradio;
    createbackup: tbooleanedit;
    filetoclean: tstringdisp;
   tbutton2: tbutton;
    procedure dobeauti(const sender: TObject);
    procedure doclose(const sender: TObject);
   procedure ondestroyev(const sender: TObject);
  end;

var 
  beautyfo: tbeautyfo;
  beautyformcreated: boolean = false;
  
procedure doBeauty;  

implementation

uses 
beauty_mfm, plugmanager, commandorform;

procedure doBeauty;
begin
try
application.createform(tbeautyfo, beautyfo);
beautyfo.filetoclean.value :=  ExtractFileName(debuggerfo.file_history.value);
beautyfo.filetoclean.hint := debuggerfo.file_history.value;
    beautyfo.show;
    beautyfo.bringtofront;
    beautyformcreated:= true;
  finally  
   end;
end;

procedure tbeautyfo.dobeauti(const sender: TObject);
var 
  x : integer;
begin
  if tbptop.value then x := 0
  else x := 1;
  DoBeautifier(debuggerfo.file_history.value, x, createbackup.value);
end;

procedure tbeautyfo.doclose(const sender: TObject);
begin
  close;
end;

procedure tbeautyfo.ondestroyev(const sender: TObject);
begin
beautyformcreated:= false;
end;

end.
