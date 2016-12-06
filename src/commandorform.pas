unit commandorform;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface
uses
 msegui,mseclasses,mseforms,msegraphics,msegraphutils,mseguiglob,msemenus,
 msesimplewidgets,msewidgets,msedock,msedragglob,mseglob,msegraphedits,
 mseificomp,mseificompglob,mseifiglob,msescrollbar,msetypes,mseapplication,
 msedataedits,msedatanodes,mseedit,msegrids,mselistbrowser,msestat,msestatfile,
 msestream,msestrings,sysutils,mseimage,msedispwidgets,mserichstring,mseact;

type
 tdebuggerfo = class(tdockform)
   basedock: tdockpanel;
   statdisp: tstringdisp;
   edited_run: tbutton;
   edited_abort: tbutton;
   edited_make: tbutton;
   edit_options: tdropdownlistedit;
   edit_compilernum: tenumedit;
   edit_compiler: tdropdownlistedit;
   save_file: tbutton;
   open_file: tbutton;
   project_interrupt: tbutton;
   project_reset: tbutton;
   project_step_instruction: tbutton;
   project_next_instruction: tbutton;
   project_finish: tbutton;
   project_step: tbutton;
   project_next: tbutton;
   project_start: tbutton;
   hints: tbooleanedit;
   watches: tbooleanedit;
   timage1: timage;
   break_point: tbooleanedit;
   project_abort_compil: tbutton;
   project_make: tbutton;
   project_options: tdropdownlistedit;
   save_project: tbutton;
   open_project: tbutton;
   project_option: tbutton;
   toggle_form_unit: tbutton;
   line_number: tbutton;
   find_in_directory: tbutton;
   find_in_edit: tbutton;
   properties_list: tbutton;
   assistive: tbutton;
   procedure watchonexecute(const sender: TObject);
   procedure breakonexecute(const sender: TObject);
   procedure hintonexecute(const sender: TObject);
   procedure layoutchange(const sender: TObject);
   procedure listonexecute(const sender: TObject);
   procedure findinpage(const sender: TObject);
   procedure shownum(const sender: TObject);

   procedure paintdock(const sender: twidget; const acanvas: tcanvas);
   procedure assistiveactonexecute(const sender: TObject);
   end;
var
 debuggerfo: tdebuggerfo;
implementation
uses
 commandorform_mfm, actionsmodule, breakpointsform, main, sourceform, projectoptionsform ;


procedure tdebuggerfo.breakonexecute(const sender: TObject);
begin
actionsmo.bkptsonact.checked := debuggerfo.break_point.value;
// breakpointsfo.bkptson.value:= actionsmo.bkptsonact.checked;
end;

procedure tdebuggerfo.layoutchange(const sender: TObject);
begin
{
 case debuggerfo.compile_what.value of
  0 : begin
editpanel.visible := true;
editpanel.left := 649;
projectpanel.visible := true;
end;
   1 : begin
editpanel.visible := false;
projectpanel.visible := true;
end;
   2 : begin
editpanel.visible := true;
editpanel.left := 256;
projectpanel.visible := false;
end;
    3 : begin
editpanel.visible := false;
projectpanel.visible := false;
end;
  end;
}
end;

procedure tdebuggerfo.watchonexecute(const sender: TObject);
begin
actionsmo.watchesonact.checked := debuggerfo.watches.value;
//tchfo.watcheson.value:= actionsmo.watchesonact.checked; 
end;

procedure tdebuggerfo.hintonexecute(const sender: TObject);
begin
actionsmo.bluedotsonact.tag := 1;
actionsmo.bluedotsonact.checked := debuggerfo.hints.value;
//mainfo.checkbluedots;
end;

procedure tdebuggerfo.listonexecute(const sender: TObject);
begin
if debuggerfo.properties_list.tag = 0 then
begin
debuggerfo.properties_list.tag := 1 ;
debuggerfo.properties_list.imagenr := 21 ;
 end 
 else
 begin
  sourcefo.thetimer.Enabled := false;
  sourcefo.hidesourcehint; 
  debuggerfo.properties_list.tag := 0 ;
  debuggerfo.properties_list.imagenr := 20 ;
 end;
 end;
 
 procedure tdebuggerfo.shownum(const sender: TObject);
 var 
 int1 : integer;
begin
if debuggerfo.line_number.tag = 0 then
begin
projectoptions.e.linenumberson := true;
debuggerfo.line_number.tag := 1 ;
debuggerfo.line_number.imagenr := 26 ;
 end 
 else
 begin
  projectoptions.e.linenumberson := false;
debuggerfo.line_number.tag := 0;
  debuggerfo.line_number.imagenr := 25 ;
 end;
 for int1:= 0 to sourcefo.count - 1 do
    sourcefo.items[int1].updatestatvalues; 
end;

procedure tdebuggerfo.findinpage(const sender: TObject);
begin
 sourcefo.activepage.dofind;
end;

procedure tdebuggerfo.paintdock(const sender: twidget; const acanvas: tcanvas);
begin
// paintdockingareacaption(acanvas,sender,mainfo.c[ord(dockingarea)]);
end;

procedure tdebuggerfo.assistiveactonexecute(const sender: TObject);
begin
  actionsmo.assistiveactonexecute(sender); 
 end;

end.
