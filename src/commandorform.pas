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
   timagelist1: timagelist;
   templatemaindark: tfacecomp;
   templatemain: tfacecomp;
   templfiledark: tfacecomp;
   find_in_edit: tbutton;
   debug_on: tbutton;
   imagebut: timagelist;
   templhistory: tfacecomp;
   templhistorydark: tfacecomp;
   templfilehistory: tfacecomp;
   templfilehistorydark: tfacecomp;
   templnr: tfacecomp;
   templnrdark: tfacecomp;
   templlang: tfacecomp;
   templlangdark: tfacecomp;
   tfacecompnul: tfacecomp;
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
   procedure oncreat(const sender: TObject);
  end;
var
 debuggerfo: tdebuggerfo;
implementation
uses
 commandorform_mfm, targetconsole, confdebugger, actionsmodule, confideu,
 finddialogform,
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

 debuggerfo.properties_list.face.image.alignment :=  
   [al_stretchx,al_stretchy];
 end
 else
 begin
  sourcefo.thetimer.Enabled := false;
  sourcefo.hidesourcehint;
  debuggerfo.properties_list.tag := 0 ;
  debuggerfo.properties_list.face.image.alignment :=  
   [al_grayed,al_stretchx,al_stretchy];

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
//debuggerfo.line_number.face.image.alignment :=  
// [al_stretchx,al_stretchy];

 end
 else
 begin
  projectoptions.e.linenumberson := false;
debuggerfo.line_number.tag := 0;
//debuggerfo.line_number.face.image.alignment :=  
//  [al_grayed,al_stretchx,al_stretchy];

 end;
 for int1:= 0 to sourcefo.count - 1 do
    sourcefo.items[int1].updatestatvalues;
end;

procedure tdebuggerfo.findinpage(const sender: TObject);
begin
if (sourcefo.ActivePage <> nil) then
begin
  actionsmo.findactonexecute(sender);
end;
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

if (file_history.tag = 0) and
 (projectoptions.projectfilename <> project_history.value) then
begin
sleep(50);
if not fileexists(project_history.value) then

ShowMessage('Project ' + project_history.value + ' does not exist.' , 'Warning!',[mr_yes])
else mainfo.openproject(project_history.value);
mainfo.activate;
end;

project_history.value := tosysfilepath(project_history.value);
end;

procedure tdebuggerfo.onsetvaluefilehis(const sender: TObject);
var
 page: tsourcepage;
 ratio : double;
begin
file_history.value := tosysfilepath(file_history.value);
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
targetconsolefo.activate;
projectoptions.d.showconsole := true;
end;

procedure tdebuggerfo.onsetdebug(const sender: TObject);
begin
if debug_on.tag = 0 then
begin
  debug_on.tag := 1 ;
 {$if not defined(netbsd) and not defined(darwin)}
 imagebut.getimage(0, debug_on.face.image);
 {$else}
 debug_on.imagenr := 40;
 {$endif}
 end
 else
 begin
  debug_on.tag := 0;
   {$if not defined(netbsd) and not defined(darwin)}
  imagebut.getimage(1, debug_on.face.image);
  {$else}
  debug_on.imagenr := 41;
  {$endif}
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
 debug_on.tag := 0 
 else
 debug_on.tag := 1 ;

onsetdebug(nil);

  end;

procedure tdebuggerfo.onsavecust(const sender: TObject);
begin
//actionsmo.saveactonexecute(sender);
sourcefo.saveall(true);
sourcefo.updatehinttab;
end;

procedure tdebuggerfo.onbeauty(const sender: TObject);
begin
if (sourcefo.ActivePage <> nil)  then
mainfo.onbeauty(sender);
end;

procedure tdebuggerfo.procedurelistonexecute(const sender: TObject);
begin
actionsmo.procedurelistonexecute(sender);
end;

procedure tdebuggerfo.oncreat(const sender: TObject);
begin

{$if defined(netbsd) or defined(darwin)}

panelmain.face.template := tfacecompnul;
panelproject.face.template := tfacecompnul;
paneledited.face.template := tfacecompnul;

assistive.imagelist := actionsmo.buttonicons;
assistive.face.image := statdisp.face.image;

properties_list.imagelist := actionsmo.buttonicons;
properties_list.face.image := statdisp.face.image;

find_in_directory.imagelist := actionsmo.buttonicons;
find_in_directory.face.image := statdisp.face.image;

line_number.imagelist := actionsmo.buttonicons;
line_number.face.image := statdisp.face.image;

terminal_run.imagelist := actionsmo.buttonicons;
terminal_run.face.image := statdisp.face.image;

project_open.imagelist := actionsmo.buttonicons;
project_open.face.image := statdisp.face.image;

project_save.imagelist := actionsmo.buttonicons;
project_save.face.image := statdisp.face.image;

project_option.imagelist := actionsmo.buttonicons;
project_option.face.image := statdisp.face.image;

project_make.imagelist := actionsmo.buttonicons;
project_make.face.image := statdisp.face.image;

project_abort_compil.imagelist := actionsmo.buttonicons;
project_abort_compil.face.image := statdisp.face.image;

debug_on.imagelist := actionsmo.buttonicons;
debug_on.face.image := statdisp.face.image;

project_start.imagelist := actionsmo.buttonicons;
project_start.face.image := statdisp.face.image;

project_next.imagelist := actionsmo.buttonicons;
project_next.face.image := statdisp.face.image;

project_step.imagelist := actionsmo.buttonicons;
project_step.face.image := statdisp.face.image;

project_finish.imagelist := actionsmo.buttonicons;
project_finish.face.image := statdisp.face.image;

project_next_instruction.imagelist := actionsmo.buttonicons;
project_next_instruction.face.image := statdisp.face.image;

project_step_instruction.imagelist := actionsmo.buttonicons;
project_step_instruction.face.image := statdisp.face.image;

project_reset.imagelist := actionsmo.buttonicons;
project_reset.face.image := statdisp.face.image;

project_interrupt.imagelist := actionsmo.buttonicons;
project_interrupt.face.image := statdisp.face.image;

open_file.imagelist := actionsmo.buttonicons;
open_file.face.image := statdisp.face.image;

save_file.imagelist := actionsmo.buttonicons;
save_file.face.image := statdisp.face.image;

find_in_edit.imagelist := actionsmo.buttonicons;
find_in_edit.face.image := statdisp.face.image;

toggle_form_unit.imagelist := actionsmo.buttonicons;
toggle_form_unit.face.image := statdisp.face.image;

code_beauty.imagelist := actionsmo.buttonicons;
code_beauty.face.image := statdisp.face.image;

procedure_list.imagelist := actionsmo.buttonicons;
procedure_list.face.image := statdisp.face.image;

edited_make.imagelist := actionsmo.buttonicons;
edited_make.face.image := statdisp.face.image;

edited_abort.imagelist := actionsmo.buttonicons;
edited_abort.face.image := statdisp.face.image;

edited_run.imagelist := actionsmo.buttonicons;
edited_run.face.image := statdisp.face.image;

{$endif}

end;

end.
