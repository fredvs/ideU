program ${%PROJECTNAME%}; 

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  SysUtils, Classes, fpg_base, fpg_main, fpg_form;

type

  TMainForm = class(TfpgForm)
  private
    {@VFD_HEAD_BEGIN: ${%PROJECTNAME%}}
    {@VFD_HEAD_END: ${%PROJECTNAME%}}
  public
    procedure AfterCreate; override;
  end;

{@VFD_NEWFORM_DECL}

{@VFD_NEWFORM_IMPL}

procedure TMainForm.AfterCreate;
begin
  {%region 'Auto-generated GUI code' -fold}
  {@VFD_BODY_BEGIN: ${%PROJECTNAME%}}
  Name := 'MainForm';
  SetPosition(574, 167, 300, 250);
  WindowTitle := 'MainForm';
  WindowPosition := wpOneThirdDown;      
  {@VFD_BODY_END: ${%PROJECTNAME%}}
  {%endregion}
end;


procedure MainProc;
var
  frm: TMainForm;
begin
  fpgApplication.Initialize;
  try
    fpgApplication.CreateForm(TMainForm, frm);
    fpgApplication.MainForm := frm;
    frm.Show;
    fpgApplication.Run;
  finally
    frm.Free;
  end;
end;

begin
  MainProc;
end.
