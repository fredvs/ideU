{ MSEide Copyright (c) 1999-2006 by Martin Schreiber
   
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
}
unit debuggerform;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface
uses
 msegui,mseclasses,mseforms,msegraphics,msegraphutils,mseguiglob,msemenus,
 msesimplewidgets,msewidgets,msedock,msedragglob,mseglob,msegraphedits,
 mseificomp,mseificompglob,mseifiglob,msescrollbar,msetypes,mseapplication,
 msedataedits,msedatanodes,mseedit,msegrids,mselistbrowser,msestat,msestatfile,
 msestream,msestrings,sysutils,mseimage;

type
 tdebuggerfo = class(tdockform)
   editpanel: tdockpanel;
   edited_run: tbutton;
   edited_abort: tbutton;
   edited_make: tbutton;
   projectpanel: tdockpanel;
   project_start: tbutton;
   project_next: tbutton;
   project_step: tbutton;
   project_finish: tbutton;
   project_reset: tbutton;
   project_interrupt: tbutton;
   project_next_instruction: tbutton;
   project_step_instruction: tbutton;
   break_point: tbooleanedit;
   watches: tbooleanedit;
   hints: tbooleanedit;
   project_abort_compil: tbutton;
   project_make: tbutton;
   mainpanel: tdockpanel;
   find_in_directory: tbutton;
   assistive: tbutton;
   toggle_form_unit: tbutton;
   project_option: tbutton;
   edit_options: tenumedit;
   project_options: tenumedit;
   edit_compiler: tenumedit;
   edit_compilernum: tenumedit;
   properties_list: tbutton;
   find_in_edit: tbutton;
   open_file: tbutton;
   open_project: tbutton;
   save_file: tbutton;
   save_project: tbutton;
   line_number: tbutton;
   timage1: timage;
   procedure watchonexecute(const sender: TObject);
   procedure breakonexecute(const sender: TObject);
   procedure hintonexecute(const sender: TObject);
   procedure layoutchange(const sender: TObject);
   procedure listonexecute(const sender: TObject);
   procedure findinpage(const sender: TObject);
   procedure shownum(const sender: TObject);

   end;
var
 debuggerfo: tdebuggerfo;
implementation
uses
 debuggerform_mfm, actionsmodule, sourceform, projectoptionsform ;
procedure tdebuggerfo.breakonexecute(const sender: TObject);
begin
actionsmo.bkptsononexecute(sender) ; 
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
actionsmo.watchesononexecute(sender) ; 
end;

procedure tdebuggerfo.hintonexecute(const sender: TObject);
begin
actionsmo.bluedotsononchange(sender) ; 
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

end.
