unit commandorform;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface
uses
 msegui,mseclasses, msefileutils, mclasses, mseforms,msegraphics,msegraphutils,
 mseguiglob,mseevent,msemenus,msesimplewidgets,msewidgets,msedock,msedragglob,
 mseglob,msegraphedits,mseificomp,mseificompglob,mseifiglob,msescrollbar,
 msetypes,mseapplication,msedataedits,msedatanodes,mseedit,msegrids,
 mselistbrowser,msestat,msestatfile,msestream,msestrings,sysutils,mseimage,
 msedispwidgets,mserichstring,mseact, msebitmap;

type
 tdebuggerfo = class(tdockform)
   basedock: tdockpanel;
   statdisp: tstringdisp;
   paneledited: tdockpanel;
   edited_run: tbutton;
   edited_abort: tbutton;
   edited_make: tbutton;
   edit_options: tdropdownlistedit;
   edit_compilernum: tenumedit;
   edit_compiler: tdropdownlistedit;
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
   eyesimage: timage;
   project_history: thistoryedit;
   file_history: thistoryedit;
   toggle_form_unit: tbutton;
   project_option: tbutton;
   templproject: tfacecomp;
   templfile: tfacecomp;
   panelmain: tdockpanel;
   line_number: tbutton;
   find_in_directory: tbutton;
   properties_list: tbutton;
   assistive: tbutton;
   terminal_run: tbutton;
   save_file: tbutton;

   code_beauty: tbutton;
   procedure_list: tbutton;
   templateprojectdark: tfacecomp;
   tstringdisp2: tstringdisp;
   timagelist1: timagelist;
   templatemaindark: tfacecomp;
   templatemain: tfacecomp;
   templfiledark: tfacecomp;
   find_in_edit: tbutton;
   debug_on: tbutton;
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
   procedure onterminalon(const sender: TObject);
   procedure onsetdebug(const sender: TObject);
   procedure onchangeproject(const sender: TObject);
   procedure onsavecust(const sender: TObject);
   procedure onbeauty(const sender: TObject);
   procedure procedurelistonexecute(const sender: TObject);
   end;
var
 debuggerfo: tdebuggerfo;
implementation
uses
 commandorform_mfm, targetconsole, confdebugger, actionsmodule, confideu,
 plugmanager, breakpointsform, main, sourceform, sourcepage, projectoptionsform ;

procedure tdebuggerfo.onscale(const sender: TObject);
begin
// fred
//basedock.bounds_y:= statdisp.bottom + 1;
// basedock.bounds_y:= 0;
// basedock.bounds_cy:= container.paintrect.cy - statdisp.bottom + 1;
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
  actionsmo.findactonexecute(sender);
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
var
ratio : double;
begin

ratio := confideufo.fontsize.value / 12;

project_history.width := round(ratio * 88);
//if (fileexists(project_history.value)) and
if (file_history.tag = 0) and
 (projectoptions.projectfilename <> project_history.value) then
begin
sleep(50);
mainfo.openproject(project_history.value);
mainfo.activate;
end;
end;

procedure tdebuggerfo.onsetvaluefilehis(const sender: TObject);
var
 page: tsourcepage;
 ratio : double;
begin

ratio := confideufo.fontsize.value / 12;
file_history.width := round(ratio * 88);

//if (fileexists(file_history.value)) and
if (file_history.tag = 0) then
begin
sleep(50);
page:= sourcefo.openfile(file_history.value);
 if page <> nil then  page.activate(true,true);
 end;
end;

procedure tdebuggerfo.onbeforefilehis(const sender: TObject);
begin
file_history.width := 500;
end;

procedure tdebuggerfo.onbefdroppro(const sender: TObject);
begin
project_history.width := 500;
end;

procedure tdebuggerfo.onterminalon(const sender: TObject);
begin
if terminal_run.tag = 0 then
begin
targetconsolefo.activate;
projectoptions.d.showconsole := true;
terminal_run.tag := 1 ;
terminal_run.imagenr := 42 ;
 end
 else
 begin
  targetconsolefo.visible := false;
  projectoptions.d.showconsole := false;
  terminal_run.tag := 0;
  terminal_run.imagenr := 43 ;
 end;

end;

procedure tdebuggerfo.onsetdebug(const sender: TObject);
begin
if debug_on.tag = 0 then
begin
debug_on.tag := 1 ;
debug_on.imagenr := 40 ;
 end
 else
 begin
  debug_on.tag := 0;
  debug_on.imagenr := 41 ;
 end;
end;

procedure tdebuggerfo.onchangeproject(const sender: TObject);
var
str3 : string;
int3, thetag : integer;
begin

str3 := '' ;

case debuggerfo.project_options.value of
  'M' : thetag := 1;
  'B' : thetag := 2;
  '1' : thetag := 4;
  '2' : thetag := 8;
  '3' : thetag := 16;
  '4' : thetag := 32;
  '5' : thetag := 64;
  '6' : thetag := 128;
  '7' : thetag := 256;
  '8' : thetag := 512;
  '9' : thetag := 1024;
  '0' : thetag := 2048;
  end;

with projectoptions,o,texp do begin
for int3:= 0 to high(debuggerused) do begin
   if (thetag and debuggerusedon[int3] <> 0) and
         (debuggerused[int3] <> '') then begin

if system.pos('Default',debuggerused[int3]) > 0 then
   str3:= 'Default Debugger' else

    if (trim(debuggerused[int3]) = 'Debugger 1')  then
    str3:= ansistring(quotefilename(tosysfilepath(confdebuggerfo.debugger1.value))) else

    if (trim(debuggerused[int3]) = 'Debugger 2') then
    str3:= ansistring(quotefilename(tosysfilepath(confdebuggerfo.debugger2.value))) else

    if (trim(debuggerused[int3]) = 'Debugger 3') then
    str3:= ansistring(quotefilename(tosysfilepath(confdebuggerfo.debugger3.value))) else

     if (trim(debuggerused[int3]) = 'Debugger 4') then
    str3:= ansistring(quotefilename(tosysfilepath(confdebuggerfo.debugger4.value))) else
    str3:= '' ;
 end;
 end;
 end;


 if str3 <> '' then
 begin
 debug_on.tag := 1 ;
 debug_on.imagenr := 40 ;
 end else
 begin
 debug_on.tag := 0 ;
 debug_on.imagenr := 41
 end;

  end;

procedure tdebuggerfo.onsavecust(const sender: TObject);
begin
//actionsmo.saveactonexecute(sender);
sourcefo.saveall(true);
sourcefo.updatehinttab;
end;

procedure tdebuggerfo.onbeauty(const sender: TObject);
begin
mainfo.onbeauty(sender);
end;

procedure tdebuggerfo.procedurelistonexecute(const sender: TObject);
begin
actionsmo.procedurelistonexecute(sender);
end;

end.
