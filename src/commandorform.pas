unit commandorform;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface
uses
 msegui,mseclasses, mclasses, mseforms,msegraphics,msegraphutils,mseguiglob,mseevent,
 msemenus,msesimplewidgets,msewidgets,msedock,msedragglob,mseglob,msegraphedits,
 mseificomp,mseificompglob,mseifiglob,msescrollbar,msetypes,mseapplication,
 msedataedits,msedatanodes,mseedit,msegrids,mselistbrowser,msestat,msestatfile,
 msestream,msestrings,sysutils,mseimage,msedispwidgets,mserichstring,mseact;

type
 tdebuggerfo = class(tdockform)
   basedock: tdockpanel;
   statdisp: tstringdisp;
   project_option: tbutton;
   toggle_form_unit: tbutton;
   line_number: tbutton;
   find_in_directory: tbutton;
   find_in_edit: tbutton;
   properties_list: tbutton;
   assistive: tbutton;
   paneledited: tdockpanel;
   edited_run: tbutton;
   edited_abort: tbutton;
   edited_make: tbutton;
   edit_options: tdropdownlistedit;
   edit_compilernum: tenumedit;
   edit_compiler: tdropdownlistedit;
   save_file: tbutton;
   open_file: tbutton;
   panelproject: tdockpanel;
   project_interrupt: tbutton;
   project_reset: tbutton;
   project_step_instruction: tbutton;
   project_next_instruction: tbutton;
   project_finish: tbutton;
   project_step: tbutton;
   project_next: tbutton;
   project_start: tbutton;
   project_abort_compil: tbutton;
   project_make: tbutton;
   project_options: tdropdownlistedit;
   project_save: tbutton;
   project_open: tbutton;
   panelwatch: tdockpanel;
   hints: tbooleanedit;
   watches: tbooleanedit;
   break_point: tbooleanedit;
   timage1: timage;
   project_history: thistoryedit;
   file_history: thistoryedit;
   procedure watchonexecute(const sender: TObject);
   procedure breakonexecute(const sender: TObject);
   procedure hintonexecute(const sender: TObject);
   procedure layoutchange(const sender: TObject);
   procedure listonexecute(const sender: TObject);
   procedure findinpage(const sender: TObject);
   procedure shownum(const sender: TObject);
   procedure onscale(const sender: TObject);
   constructor create(aowner: tcomponent); override;
   procedure paintdock(const sender: twidget; const acanvas: tcanvas);
   procedure assistiveactonexecute(const sender: TObject);
   procedure onsetvaluehis(const sender: TObject);
   procedure onsetvaluefilehis(const sender: TObject);
   procedure onbeforefilehis(const sender: TObject);
  
   procedure onbefdroppro(const sender: TObject);
   end;
var
 debuggerfo: tdebuggerfo;
implementation
uses
 commandorform_mfm, actionsmodule, breakpointsform, main, sourceform, sourcepage, projectoptionsform ;

procedure tdebuggerfo.onscale(const sender: TObject);
begin
// fred
//basedock.bounds_y:= statdisp.bottom + 1;
basedock.bounds_y:= 0;
basedock.bounds_cy:= container.paintrect.cy - basedock.bounds_y;
end;

constructor tdebuggerfo.create(aowner: tcomponent);
begin
  inherited create(aowner);
  onscale(nil);
end;

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
onscale(nil);
end;

procedure tdebuggerfo.assistiveactonexecute(const sender: TObject);
begin
  actionsmo.assistiveactonexecute(sender); 
 end;

procedure tdebuggerfo.onsetvaluehis(const sender: TObject);
begin
project_history.width := 84;
if (fileexists(project_history.value)) and (file_history.tag = 0) and 
(projectoptions.projectfilename <> project_history.value) then
mainfo.openproject(project_history.value);
end;

procedure tdebuggerfo.onsetvaluefilehis(const sender: TObject);
var
 page: tsourcepage;
begin
file_history.width := 84;
if (fileexists(file_history.value)) and (file_history.tag = 0) then
begin
page:= sourcefo.openfile(file_history.value);
 if page <> nil then  page.activate(true,true);
 end;
end;

procedure tdebuggerfo.onbeforefilehis(const sender: TObject);
begin
file_history.width := 298;
end;

procedure tdebuggerfo.onbefdroppro(const sender: TObject);
begin
project_history.width := 298;
end;



end.
