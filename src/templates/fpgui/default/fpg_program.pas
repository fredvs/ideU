program fpg_program;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, fpg_main, frm_main;


procedure MainProc;
var
  frm: TMainForm;
begin
  fpgApplication.Initialize;
  fpgApplication.CreateForm(TMainForm, frm);
  fpgApplication.MainForm := frm;
  try
    frm.Show;
    fpgApplication.Run;
  finally
    frm.Free;
  end;
end;

begin
  MainProc;
end.

