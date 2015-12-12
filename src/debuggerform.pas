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
 msestream,msestrings,sysutils;

type
 tdebuggerfo = class(tdockform)
   editpanel: tdockpanel;
   edited_make3: tbutton;
   edited_make2: tbutton;
   edited_make1: tbutton;
   edited_option: tbutton;
   edited_run: tbutton;
   compiler_1: tbooleaneditradio;
   compiler_2: tbooleaneditradio;
   compiler_3: tbooleaneditradio;
   edited_abort: tbutton;
   edited_make4: tbutton;
   compiler_pascal: tbooleaneditradio;
   compiler_java: tbooleaneditradio;
   compiler_c: tbooleaneditradio;
   compiler_python: tbooleaneditradio;
   compiler_4: tbooleaneditradio;
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
   project_make2: tbutton;
   project_make1: tbutton;
   project_build: tbutton;
   project_option: tbutton;
   project_abort_compil: tbutton;
   project_make3: tbutton;
   project_make: tbutton;
   mainpanel: tdockpanel;
   open_file: tbutton;
   find_in_directory: tbutton;
   assistive: tbutton;
   toggle_form_unit: tbutton;
   save_file: tbutton;
   project_make4: tbutton;
   layprj: tbooleaneditradio;
   layedit: tbooleaneditradio;
   layall: tbooleaneditradio;
   edited_makeb: tbutton;
   edited_makem: tbutton;
   procedure watchonexecute(const sender: TObject);
   procedure breakonexecute(const sender: TObject);
   procedure hintonexecute(const sender: TObject);
   procedure layoutchange(const sender: TObject);
 end;
var
 debuggerfo: tdebuggerfo;
implementation
uses
 debuggerform_mfm, actionsmodule;
procedure tdebuggerfo.breakonexecute(const sender: TObject);
begin
actionsmo.bkptsononexecute(sender) ; 
end;

procedure tdebuggerfo.layoutchange(const sender: TObject);
begin
if layall.value = true then
begin
projectpanel.left := 250;
projectpanel.visible := true;
editpanel.left := 750;
editpanel.visible := true;
end
else
if layprj.value = true then
begin
editpanel.visible := false;
projectpanel.left := 250;
projectpanel.visible := true;
end
else
begin
projectpanel.visible := false;
editpanel.left := 250;
editpanel.visible := true;
end;

end;

procedure tdebuggerfo.watchonexecute(const sender: TObject);
begin
actionsmo.watchesononexecute(sender) ; 
end;

procedure tdebuggerfo.hintonexecute(const sender: TObject);
begin
actionsmo.bluedotsononchange(sender) ; 
end;
end.
