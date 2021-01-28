unit confideu;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 msetypes,mseglob,mseguiglob, mseguiintf, mseapplication, msegui, msegraphics,
 msegraphutils,mseclasses, mseforms, msegraphedits, msesimplewidgets,mseificomp,
 mseificompglob,mseifiglob, msemenus, msescrollbar, msedataedits,mseedit,
 msestat, msestatfile,msestream, msestrings, SysUtils, msewidgets,msebitmap,
 msedatanodes, msefiledialog,msegrids, mselistbrowser, msesys,mseact,
 msedragglob, msetabs, msedropdownlist,msegridsglob, msewidgetgrid, msepointer,
 msememodialog, msesplitter, msecolordialog,mseeditglob, mserichstring,
 msetextedit;

type
  tconfideufo = class(tmseform)
    but_apply: TButton;
    group_assistive: tgroupbox;
    tbassistive: tbooleanedit;
    tesakitdir: tfilenameedit;
    group_system_layout: tgroupbox;
    universal_path: tbooleanedit;
    nozorderenable: tbooleanedit;
    doubleclic: tbooleanedit;
    autofocus_menu: tbooleanedit;
    fullpath: tbooleanedit;
    group_sourceeditor: tgroupbox;
    trimtrailingwhitespace: tbooleanedit;
    rightmarginchars: tintegeredit;
    encoding: tenumedit;
    backupfilecount: tintegeredit;
    tabstops: tintegeredit;
    blockindent: tintegeredit;
    usedefaulteditoroptions: tbooleanedit;
    spacetabs: tbooleanedit;
   colorerror: tcoloredit;
   colorwarning: tcoloredit;
   colornote: tcoloredit;
   stripmessageesc: tbooleanedit;
   modaldial: tbooleanedit;
   deflayout: tfilenameedit;
   defsynt: tfilenameedit;
   fontsize: tintegeredit;
   fontname: tdropdownlistedit;
   closemessages: tbooleanedit;
   addwhiteaftercomma: tbooleanedit;
   group_file_change: tgroupbox;
   tbfilereload: tbooleaneditradio;
   tbfilenoload: tbooleaneditradio;
   tbfileaskload: tbooleaneditradio;
   confirmdel: tbooleanedit;
   but_ok: tbutton;
   tabindent: tbooleanedit;
   blinkcaret: tbooleanedit;
    procedure zorderhandle(const Sender: TObject);
    procedure epandfilenamemacro(const Sender: TObject; var avalue: msestring;
      var accept: boolean);

    procedure setvalue(const Sender: TObject; var avalue: msestring;
      var accept: boolean);

    procedure dirlayout(const Sender: TObject);
    procedure autofocus(const Sender: TObject);
    procedure updownacc(const Sender: TObject);
   procedure oncloseev(const sender: TObject);
   procedure onchangefont;
   procedure onapply(const sender: TObject);
   procedure onok(const sender: TObject);
  end;

var
  confideufo: tconfideufo;

implementation

uses
  confideu_mfm, main, messageform, sourceform, finddialogform, targetconsole,
  ideusettings, confcompiler, confdebugger, projectoptionsform, objectinspector,
  projecttreeform, commandorform, dialogfiles, conffpgui, confmsegui;

procedure tconfideufo.zorderhandle(const Sender: TObject);
begin
  if nozorderenable.Value = True then
    nozorderhandling := True
  else
    nozorderhandling := False;
end;

procedure tconfideufo.epandfilenamemacro(const Sender: TObject;
  var avalue: msestring; var accept: boolean);

begin
  settingsfo.epandfilenamemacro(Sender, avalue, accept);
end;

procedure tconfideufo.setvalue(const Sender: TObject; var avalue: msestring;
  var accept: boolean);
begin
  settingsfo.setvalue(Sender, avalue, accept);
end;

procedure tconfideufo.dirlayout(const Sender: TObject);
begin
  if universal_path.Value = False then
  begin
{
settingsfo.compiler.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
settingsfo.debugger.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
settingsfo.msedir.controller.options := [fdo_sysfilename,fdo_directory] ;
settingsfo.compstoredir.controller.options := [fdo_sysfilename,fdo_directory] ;
settingsfo.fpguidir.controller.options := [fdo_sysfilename,fdo_directory] ;
settingsfo.docviewdir.controller.options := [fdo_sysfilename,fdo_directory] ;
settingsfo.templatedir.controller.options := [fdo_sysfilename,fdo_directory] ;
settingsfo.syntaxdefdir.controller.options := [fdo_sysfilename,fdo_directory] ;
settingsfo.layoutdir.controller.options := [fdo_sysfilename,fdo_directory] ;
}
    tesakitdir.controller.options := [fdo_sysfilename, fdo_directory];

    confcompilerfo.fpccompiler.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.fpccompiler2.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.fpccompiler3.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.fpccompiler4.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.fpccompiler5.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.fpccompiler6.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.fpccompiler7.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.fpccompiler8.controller.options := [fdo_sysfilename, fdo_savelastdir];

    confcompilerfo.ccompiler.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.ccompiler2.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.ccompiler3.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.ccompiler4.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.ccompiler5.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.ccompiler6.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.ccompiler7.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.ccompiler8.controller.options := [fdo_sysfilename, fdo_savelastdir];

    confcompilerfo.javacompiler.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.javacompiler2.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.javacompiler3.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.javacompiler4.controller.options := [fdo_sysfilename, fdo_savelastdir];

    confcompilerfo.pythoncompiler.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.pythoncompiler2.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.pythoncompiler3.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.pythoncompiler4.controller.options := [fdo_sysfilename, fdo_savelastdir];

    confcompilerfo.othercompiler.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.othercompiler2.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.othercompiler3.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.othercompiler4.controller.options := [fdo_sysfilename, fdo_savelastdir];

    confdebuggerfo.debugger1.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confdebuggerfo.debugger2.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confdebuggerfo.debugger3.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confdebuggerfo.debugger4.controller.options := [fdo_sysfilename, fdo_savelastdir];

  end
  else
  begin
{
settingsfo.compiler.controller.options := [fdo_savelastdir];
settingsfo.debugger.controller.options := [fdo_savelastdir] ;
settingsfo.msedir.controller.options := [fdo_directory] ;
settingsfo.mselibdir.controller.options := [fdo_directory] ;
settingsfo.compstoredir.controller.options := [fdo_directory] ;
settingsfo.fpguidir.controller.options := [fdo_directory] ;
settingsfo.docviewdir.controller.options := [fdo_directory] ;
settingsfo.templatedir.controller.options := [fdo_directory] ;
settingsfo.syntaxdefdir.controller.options := [fdo_directory] ;
settingsfo.layoutdir.controller.options := [fdo_directory] ;
}

    tesakitdir.controller.options := [fdo_directory];

    confcompilerfo.fpccompiler.controller.options := [fdo_savelastdir];
    confcompilerfo.fpccompiler2.controller.options := [fdo_savelastdir];
    confcompilerfo.fpccompiler3.controller.options := [fdo_savelastdir];
    confcompilerfo.fpccompiler4.controller.options := [fdo_savelastdir];
    confcompilerfo.fpccompiler5.controller.options := [fdo_savelastdir];
    confcompilerfo.fpccompiler6.controller.options := [fdo_savelastdir];
    confcompilerfo.fpccompiler7.controller.options := [fdo_savelastdir];
    confcompilerfo.fpccompiler8.controller.options := [fdo_savelastdir];

    confcompilerfo.ccompiler.controller.options := [fdo_savelastdir];
    confcompilerfo.ccompiler2.controller.options := [fdo_savelastdir];
    confcompilerfo.ccompiler3.controller.options := [fdo_savelastdir];
    confcompilerfo.ccompiler4.controller.options := [fdo_savelastdir];
    confcompilerfo.ccompiler5.controller.options := [fdo_savelastdir];
    confcompilerfo.ccompiler6.controller.options := [fdo_savelastdir];
    confcompilerfo.ccompiler7.controller.options := [fdo_savelastdir];
    confcompilerfo.ccompiler8.controller.options := [fdo_savelastdir];

    confcompilerfo.javacompiler.controller.options := [fdo_savelastdir];
    confcompilerfo.javacompiler2.controller.options := [fdo_savelastdir];
    confcompilerfo.javacompiler3.controller.options := [fdo_savelastdir];
    confcompilerfo.javacompiler4.controller.options := [fdo_savelastdir];

    confcompilerfo.pythoncompiler.controller.options := [fdo_savelastdir];
    confcompilerfo.pythoncompiler2.controller.options := [fdo_savelastdir];
    confcompilerfo.pythoncompiler3.controller.options := [fdo_savelastdir];
    confcompilerfo.pythoncompiler4.controller.options := [fdo_savelastdir];

    confcompilerfo.othercompiler.controller.options := [fdo_savelastdir];
    confcompilerfo.othercompiler2.controller.options := [fdo_savelastdir];
    confcompilerfo.othercompiler3.controller.options := [fdo_savelastdir];
    confcompilerfo.othercompiler4.controller.options := [fdo_savelastdir];

    confdebuggerfo.debugger1.controller.options := [fdo_savelastdir];
    confdebuggerfo.debugger2.controller.options := [fdo_savelastdir];
    confdebuggerfo.debugger3.controller.options := [fdo_savelastdir];
    confdebuggerfo.debugger4.controller.options := [fdo_savelastdir];

  end;
end;

procedure tconfideufo.autofocus(const Sender: TObject);
begin
  if autofocus_menu.Value = False then
  begin
    mainfo.mainmenu1.options := [mo_shortcutright, mo_updateonidle];
  end
  else
  begin
    mainfo.mainmenu1.options := [mo_shortcutright, mo_activate, mo_updateonidle];
  end;
end;

procedure tconfideufo.updownacc(const Sender: TObject);
begin
  //updownaccelerator := key_accelerator.Value;
end;

procedure tconfideufo.onchangefont;
var
ratio : double;
rect1: rectty;
begin

ratio := fontsize.value / 12;


mainfo.font.height := fontsize.value;
mainfo.font.name := ansistring(fontname.value);
mainfo.frame.grip_size := round(12*ratio);

// message

messagefontheight := fontsize.value; 
messagefontname := UTF8Decode(fontsize.name); 

// commandor

debuggerfo.font.height := fontsize.value;
debuggerfo.font.name := ansistring(fontname.value);
debuggerfo.frame.grip_size := round(12*ratio);

debuggerfo.assistive.height := round(ratio*26);
debuggerfo.assistive.width := debuggerfo.assistive.height;

debuggerfo.properties_list.height := debuggerfo.assistive.height;
debuggerfo.properties_list.width := debuggerfo.assistive.height;
debuggerfo.properties_list.left := debuggerfo.assistive.right + 2;

debuggerfo.find_in_directory.height := debuggerfo.assistive.height;
debuggerfo.find_in_directory.width := debuggerfo.assistive.height;
debuggerfo.find_in_directory.left := debuggerfo.properties_list.right + 2;

debuggerfo.line_number.height := debuggerfo.assistive.height;
debuggerfo.line_number.width := debuggerfo.assistive.height;
debuggerfo.line_number.left := debuggerfo.find_in_directory.right + 2;

debuggerfo.terminal_run.height := debuggerfo.assistive.height;
debuggerfo.terminal_run.width := debuggerfo.assistive.height;
debuggerfo.terminal_run.left := debuggerfo.line_number.right + 2;

debuggerfo.panelmain.height := debuggerfo.assistive.height + 2;
debuggerfo.panelmain.width := debuggerfo.terminal_run.right + 4;

debuggerfo.statdisp.font.height := fontsize.value;
debuggerfo.statdisp.font.name := ansistring(fontname.value);

debuggerfo.statdisp.top := debuggerfo.assistive.height + 4;

///

debuggerfo.panelproject.height := debuggerfo.panelmain.height;
debuggerfo.panelproject.left := debuggerfo.panelmain.right + 2;

debuggerfo.project_open.height := debuggerfo.assistive.height;
debuggerfo.project_open.width := debuggerfo.assistive.height;
debuggerfo.project_open.left :=  2;

debuggerfo.project_save.height := debuggerfo.assistive.height;
debuggerfo.project_save.width := debuggerfo.assistive.height;
debuggerfo.project_save.left := debuggerfo.project_open.right + 2;

debuggerfo.project_history.height := debuggerfo.assistive.height;
debuggerfo.project_history.width := round(ratio * 88) ;
debuggerfo.project_history.left := debuggerfo.project_save.right + 2;

debuggerfo.project_option.height := debuggerfo.assistive.height;
debuggerfo.project_option.width := debuggerfo.assistive.height; ;
debuggerfo.project_option.left := debuggerfo.project_history.right + 2;

debuggerfo.project_options.height := debuggerfo.assistive.height;
debuggerfo.project_options.width := 31 + round(ratio * 3) ;
debuggerfo.project_options.left := debuggerfo.project_option.right + 2;

//debuggerfo.panelwatch.height := debuggerfo.assistive.height;
debuggerfo.panelwatch.top := (debuggerfo.project_option.height -
                             debuggerfo.panelwatch.height) div 2;
//debuggerfo.panelwatch.width := debuggerfo.assistive.height;
debuggerfo.panelwatch.left := debuggerfo.project_options.right + 2;

debuggerfo.project_make.height := debuggerfo.assistive.height;
debuggerfo.project_make.width := debuggerfo.assistive.height;
debuggerfo.project_make.left := debuggerfo.panelwatch.right + 2;
//
debuggerfo.project_abort_compil.height := debuggerfo.assistive.height;
debuggerfo.project_abort_compil.width := debuggerfo.assistive.height;
debuggerfo.project_abort_compil.left := debuggerfo.project_make.right + 2;

debuggerfo.debug_on.height := debuggerfo.assistive.height;
debuggerfo.debug_on.width := debuggerfo.assistive.height;
debuggerfo.debug_on.left := debuggerfo.project_abort_compil.right + 2;

debuggerfo.project_start.height := debuggerfo.assistive.height;
debuggerfo.project_start.width := debuggerfo.assistive.height;
debuggerfo.project_start.left := debuggerfo.debug_on.right + 2;

debuggerfo.project_next.height := debuggerfo.assistive.height;
debuggerfo.project_next.width := debuggerfo.assistive.height;
debuggerfo.project_next.left := debuggerfo.project_start.right + 2;

debuggerfo.project_step.height := debuggerfo.assistive.height;
debuggerfo.project_step.width := debuggerfo.assistive.height;
debuggerfo.project_step.left := debuggerfo.project_next.right + 2;

debuggerfo.project_finish.height := debuggerfo.assistive.height;
debuggerfo.project_finish.width := debuggerfo.assistive.height;
debuggerfo.project_finish.left := debuggerfo.project_step.right + 2;
//
debuggerfo.project_next_instruction.height := debuggerfo.assistive.height;
debuggerfo.project_next_instruction.width := debuggerfo.assistive.height;
debuggerfo.project_next_instruction.left := debuggerfo.project_finish.right + 2;

debuggerfo.project_step_instruction.height := debuggerfo.assistive.height;
debuggerfo.project_step_instruction.width := debuggerfo.assistive.height;
debuggerfo.project_step_instruction.left := debuggerfo.project_next_instruction.right + 2;

debuggerfo.project_interrupt.height := debuggerfo.assistive.height;
debuggerfo.project_interrupt.width := debuggerfo.assistive.height;
debuggerfo.project_interrupt.left := debuggerfo.project_step_instruction.right + 2;

debuggerfo.project_reset.height := debuggerfo.assistive.height;
debuggerfo.project_reset.width := debuggerfo.assistive.height;
debuggerfo.project_reset.left := debuggerfo.project_interrupt.right + 2;

debuggerfo.panelproject.height := debuggerfo.panelmain.height;
debuggerfo.panelproject.left := debuggerfo.panelmain.right + 2;

debuggerfo.panelproject.width := debuggerfo.project_reset.right + 4;

//

debuggerfo.paneledited.height := debuggerfo.panelmain.height;
debuggerfo.paneledited.left := debuggerfo.panelproject.right + 2;

debuggerfo.open_file.height := debuggerfo.assistive.height;
debuggerfo.open_file.width := debuggerfo.assistive.height;
debuggerfo.open_file.left :=  2;

debuggerfo.save_file.height := debuggerfo.assistive.height;
debuggerfo.save_file.width := debuggerfo.assistive.height;
debuggerfo.save_file.left := debuggerfo.open_file.right + 2;

debuggerfo.find_in_edit.height := debuggerfo.assistive.height;
debuggerfo.find_in_edit.width := debuggerfo.assistive.height;
debuggerfo.find_in_edit.left := debuggerfo.save_file.right + 2;

debuggerfo.file_history.height := debuggerfo.assistive.height;
debuggerfo.file_history.width := round(ratio * 88) ;
debuggerfo.file_history.left := debuggerfo.find_in_edit.right + 2;

debuggerfo.toggle_form_unit.height := debuggerfo.assistive.height;
debuggerfo.toggle_form_unit.width := debuggerfo.assistive.height;
debuggerfo.toggle_form_unit.left :=  debuggerfo.file_history.right + 2;

debuggerfo.code_beauty.height := debuggerfo.assistive.height;
debuggerfo.code_beauty.width := debuggerfo.assistive.height;
debuggerfo.code_beauty.left := debuggerfo.toggle_form_unit.right + 2;

debuggerfo.procedure_list.height := debuggerfo.assistive.height;
debuggerfo.procedure_list.width := debuggerfo.assistive.height;
debuggerfo.procedure_list.left := debuggerfo.code_beauty.right + 2;

debuggerfo.edit_compiler.height := debuggerfo.assistive.height;
debuggerfo.edit_compiler.width := round(ratio * 44) ;
debuggerfo.edit_compiler.left := debuggerfo.procedure_list.right + 2;

debuggerfo.edit_compilernum.height := debuggerfo.assistive.height;
debuggerfo.edit_compilernum.width := 31 + round(ratio * 3) ;
debuggerfo.edit_compilernum.left := debuggerfo.edit_compiler.right + 2;

debuggerfo.edit_options.height := debuggerfo.assistive.height;
debuggerfo.edit_options.width := 31 + round(ratio * 3) ;
debuggerfo.edit_options.left := debuggerfo.edit_compilernum.right + 2;

debuggerfo.edited_make.height := debuggerfo.assistive.height;
debuggerfo.edited_make.width := debuggerfo.assistive.height;
debuggerfo.edited_make.left := debuggerfo.edit_options.right + 2;

debuggerfo.edited_abort.height := debuggerfo.assistive.height;
debuggerfo.edited_abort.width := debuggerfo.assistive.height;
debuggerfo.edited_abort.left := debuggerfo.edited_make.right + 2;

debuggerfo.edited_run.height := debuggerfo.assistive.height;
debuggerfo.edited_run.width := debuggerfo.assistive.height;
debuggerfo.edited_run.left := debuggerfo.edited_abort.right + 2;

debuggerfo.panelproject.height := debuggerfo.panelmain.height;
debuggerfo.panelproject.left := debuggerfo.panelmain.right + 2;

debuggerfo.paneledited.width := debuggerfo.edited_run.right + 4;
//

debuggerfo.height := debuggerfo.statdisp.bottom + 2 ;

if Assigned(objectinspectorfo) then
    begin
     objectinspectorfo.frame.grip_size := round(12*ratio);
     objectinspectorfo.font.height := fontsize.value;
     objectinspectorfo.fontempty.height := fontsize.value;
     objectinspectorfo.grid.font.name := ansistring(fontname.value);
     objectinspectorfo.grid.datarowheight := round(ratio * 16);
     objectinspectorfo.grid.rowfonts.items[0].height := fontsize.value;
     objectinspectorfo.grid.rowfonts.items[1].height := fontsize.value;
     objectinspectorfo.grid.rowfonts.items[2].height := fontsize.value;
     objectinspectorfo.grid.rowfonts.items[3].height := fontsize.value;
     objectinspectorfo.grid.rowfonts.items[4].height := fontsize.value;
     objectinspectorfo.grid.rowfonts.items[5].height := fontsize.value;

     objectinspectorfo.findbu.font.height := fontsize.value;
     objectinspectorfo.compedit.font.height := fontsize.value;

     objectinspectorfo.findbu.height := objectinspectorfo.compselector.height;
     objectinspectorfo.compedit.height := objectinspectorfo.compselector.height;

    end;

targetconsolefo.grid.font.height := fontsize.value;
//targetconsolefo.grid.font.name := ansistring(fontname.value);

if assigned(dialogfilesfo) then
begin
dialogfilesfo.selected_file.font.height := fontsize.value;
dialogfilesfo.selected_file.font.name := ansistring(fontname.value);

dialogfilesfo.list_files.cellwidth := round((ratio) * 262);

dialogfilesfo.selected_file.frame.font.height := fontsize.value;

dialogfilesfo.selected_file.frame.font.name := ansistring(fontname.value);

dialogfilesfo.list_files.cellheight := round((ratio) * 19);
dialogfilesfo.list_files.font.height := fontsize.value;
dialogfilesfo.list_files.font.name :=  ansistring(fontname.value);

dialogfilesfo.height := round((ratio) * 366);
dialogfilesfo.width  := round((ratio) * 336);
dialogfilesfo.list_files.cellwidth := dialogfilesfo.list_files.width - 6 ;

end;

mainfo.mainmenu1.menu.font.height := fontsize.value;
sourcefo.files_tab.font.height := fontsize.value;
sourcefo.frame.grip_size := round(12*ratio);
sourcefo.files_tab.tab_fontactivetab.height := fontsize.value;
sourcefo.files_tab.tab_fonttab.height := fontsize.value;
sourcefo.files_tab.tab_size := round(24 * ratio);
sourcefo.step_back.height := round(24 * ratio);
sourcefo.step_forward.height := round(24 * ratio);

mainfo.mainmenu1.menu.font.name := ansistring(fontname.value);
sourcefo.files_tab.font.name := ansistring(fontname.value);
sourcefo.files_tab.tab_fontactivetab.name := ansistring(fontname.value);
sourcefo.files_tab.tab_fonttab.name := ansistring(fontname.value);

if Assigned(sourcefo.ActivePage) then
    begin
      sourcefo.ActivePage.pathdisp.font.height := fontsize.value;
      sourcefo.ActivePage.linedisp.font.height := fontsize.value;
      sourcefo.ActivePage.pathdisp.font.name := ansistring(fontname.value);
      sourcefo.ActivePage.linedisp.font.name := ansistring(fontname.value);

      sourcefo.ActivePage.pathdisp.height := round(ratio * 20);
      sourcefo.ActivePage.linedisp.height := round(ratio * 20);

      sourcefo.ActivePage.source_editor.height := sourcefo.ActivePage.height -
      sourcefo.ActivePage.pathdisp.height -2;

       sourcefo.ActivePage.pathdisp.top := sourcefo.ActivePage.source_editor.height + 1;
       sourcefo.ActivePage.linedisp.top := sourcefo.ActivePage.pathdisp.top;

     end;

sourcefo.tpopupmenu1.menu.font.height := fontsize.value;
sourcefo.tpopupmenu1.menu.fontactive.height := fontsize.value;
sourcefo.tpopupmenu1.menu.font.name := ansistring(fontname.value);
sourcefo.tpopupmenu1.menu.fontactive.name := ansistring(fontname.value);

if Assigned(projecttreefo) then
    begin
     projecttreefo.frame.grip_size := round(12*ratio);
     projecttreefo.projectedit.font.height := fontsize.value;
     projecttreefo.edit.font.height := fontsize.value;
     projecttreefo.projectedit.font.name := ansistring(fontname.value);
     projecttreefo.edit.font.name := ansistring(fontname.value);
     projecttreefo.grid.datarowheight := round(ratio * 16);
    end;

confcompilerfo.font.height :=  fontsize.value;
confcompilerfo.font.name := ansistring(fontname.value);

confdebuggerfo.font.height :=  fontsize.value;
confdebuggerfo.font.name := ansistring(fontname.value);


// confmsegui
confmseguifo.font.height :=  fontsize.value;
confmseguifo.font.name := ansistring(fontname.value);

// conffpguifo

conffpguifo.font.height := fontsize.value;
conffpguifo.font.name := ansistring(fontname.value);

conffpguifo.fpguidesigner.top := 40;
conffpguifo.enablefpguidesigner.top :=  conffpguifo.fpguidesigner.top + conffpguifo.fpguidesigner.height + 2 ;
conffpguifo.tbfpgonlyone.top :=  conffpguifo.enablefpguidesigner.top + conffpguifo.enablefpguidesigner.height + 2 ;

conffpguifo.groupcommand.top := conffpguifo.tbfpgonlyone.top + conffpguifo.tbfpgonlyone.height + 6 ;

conffpguifo.ifloadfile.top :=  conffpguifo.edfilename.height + 2 ;
conffpguifo.edfilename.top :=  conffpguifo.ifloadfile.top ;
conffpguifo.edfilename.left :=  conffpguifo.ifloadfile.right + 30 ;

conffpguifo.ifclose.top :=  conffpguifo.ifloadfile.top + conffpguifo.edclose.height + 2 ;
conffpguifo.edclose.top :=  conffpguifo.ifclose.top ;
conffpguifo.edclose.left :=  conffpguifo.edfilename.left;

conffpguifo.ifshow.top :=  conffpguifo.ifclose.top + conffpguifo.edclose.height + 2 ;
conffpguifo.edshow.top :=  conffpguifo.ifshow.top ;
conffpguifo.edshow.left :=  conffpguifo.edfilename.left;

conffpguifo.ifhide.top :=  conffpguifo.ifshow.top + conffpguifo.edclose.height + 2 ;
conffpguifo.edhide.top :=  conffpguifo.ifhide.top ;
conffpguifo.edhide.left :=  conffpguifo.edfilename.left ;

conffpguifo.ifquit.top :=  conffpguifo.ifhide.top + conffpguifo.edclose.height + 2 ;
conffpguifo.edquit.top :=  conffpguifo.ifquit.top ;
conffpguifo.edquit.left :=  conffpguifo.edfilename.left ;

conffpguifo.edquit.width := round(ratio * 96);

conffpguifo.edfilename.width := conffpguifo.edquit.width;
conffpguifo.edclose.width := conffpguifo.edquit.width;
conffpguifo.edshow.width := conffpguifo.edquit.width;
conffpguifo.edhide.width := conffpguifo.edquit.width;

conffpguifo.groupcommand.height := conffpguifo.ifquit.top + conffpguifo.edclose.height + 10;
conffpguifo.groupcommand.width := conffpguifo.edfilename.right + 14;

//
conffpguifo.iffilter.top := conffpguifo.groupcommand.top + conffpguifo.groupcommand.height + 10 ;
conffpguifo.edfilter.top := conffpguifo.iffilter.top + conffpguifo.iffilter.height + 4 ;
conffpguifo.height := conffpguifo.edfilter.top + conffpguifo.edfilter.height + 10;

conffpguifo.width:= conffpguifo.groupcommand.width + 26;
conffpguifo.height:= conffpguifo.edfilter.bottom + 10;

// confideufo
font.height := fontsize.value;
font.name := ansistring(fontname.value);

group_file_change.width := round(ratio * 280);
group_system_layout.width := round(ratio * 280);
group_assistive.width := round(ratio * 280);
group_sourceeditor.width := round(ratio * 314);
group_sourceeditor.left := group_assistive.width + 20;
but_ok.width := round(ratio * 280) div 2;
but_apply.width := but_ok.width - 1;
but_ok.left := but_apply.width + but_apply.left + 1 ;

 group_file_change.top := 40;
 tbfilereload.top := tbfilereload.height + 2;
 tbfilenoload.top :=  tbfilereload.top + tbfilereload.height + 2 ;
 tbfileaskload.top :=  tbfilenoload.top + tbfilenoload.height + 2 ;
 group_file_change.height := tbfileaskload.top + tbfileaskload.height + 10;

 group_system_layout.top := group_file_change.top +
 group_file_change.height + 10;

 universal_path.top := universal_path.height + 2;
 doubleclic.top :=  universal_path.top + universal_path.height + 2 ;
 fullpath.top :=  doubleclic.top + doubleclic.height + 2 ;
 modaldial.top :=  fullpath.top + fullpath.height + 2 ;
 autofocus_menu.top :=  modaldial.top + modaldial.height + 2 ;
 nozorderenable.top :=  autofocus_menu.top + autofocus_menu.height + 2 ;
 confirmdel.top :=  nozorderenable.top + nozorderenable.height + 2 ;

 fontname.top :=  confirmdel.top + confirmdel.height + 2 ;
 fontsize.top :=  fontname.top + fontname.height + 2 ;

 group_system_layout.height := fontsize.top + fontsize.height + 10;

 tbassistive.top := tbassistive.height + 2;
 tesakitdir.top :=  tbassistive.top + tbassistive.height + 2 ;

 group_assistive.height := tesakitdir.top + tesakitdir.height + 10;
 group_assistive.top :=  group_system_layout.top + group_system_layout.height + 10;

 group_sourceeditor.top := 10;

 usedefaulteditoroptions.top := usedefaulteditoroptions.height + 2;
 backupfilecount.top :=  usedefaulteditoroptions.top + usedefaulteditoroptions.height + 2 ;
 stripmessageesc.top := backupfilecount.top;
 closemessages.top :=  stripmessageesc.top + backupfilecount.height + 2 ;
 
 blinkcaret.top :=  closemessages.top + closemessages.height + 2 ;
 
 trimtrailingwhitespace.top :=  blinkcaret.top + blinkcaret.height + 2 ;
 encoding.top :=  trimtrailingwhitespace.top + trimtrailingwhitespace.height + 2 ;

 encoding.width := round(ratio*84);
 tabstops.top := encoding.top ;
 tabstops.left := encoding.right + 40 ;
 spacetabs.top := tabstops.bottom - spacetabs.height ;
 spacetabs.left := tabstops.right + 4 ;

 rightmarginchars.top :=  encoding.top + encoding.height + 2 ;

 blockindent.top := rightmarginchars.top ;
 tabindent.top := blockindent.bottom - tabindent.height  ;

 blockindent.left := encoding.right + 40 ;
 tabindent.left := blockindent.right + 4 ;


 colornote.top :=  rightmarginchars.top + rightmarginchars.height + 2 ;
 colorwarning.top :=  colornote.top + colornote.height + 2 ;
 colorerror.top :=  colorwarning.top + colorwarning.height + 2 ;

 deflayout.top :=  colorerror.top + colorerror.height + 2 ;
 defsynt.top :=  deflayout.top + deflayout.height + 2 ;
 addwhiteaftercomma.top :=  defsynt.top + defsynt.height + 2 ;

 group_sourceeditor.height := addwhiteaftercomma.top + addwhiteaftercomma.height + 10;

 height := group_sourceeditor.height + 20;

if findformcreated then finddialogdotextsize;

rect1 := application.screenrect(window);

fontname.left := 10;
fontsize.left := 10;

//group_file_changed2.width := round(ratio * 280);

width := group_sourceeditor.left + group_assistive.width + round(40 * ratio);

messagefo.Messages.font.height := fontsize.value;
messagefo.frame.grip_size := round(12*ratio);

messagefo.Messages.font.name := ansistring(fontname.value);

debuggerfo.statdisp.font.name := ansistring(fontname.value);

//dialogfilesfo.selected_file.frame.font.height := fontsize.value;
//group_file_change.width := group_sourceeditor.width;

invalidate;

left := (rect1.cx - width) div 2;


end;

procedure tconfideufo.oncloseev(const sender: TObject);
begin
mainfo.ismodal:= confideufo.modaldial.value;
onapply(nil);
end;

procedure tconfideufo.onapply(const sender: TObject);
begin
messagefo.updateprojectoptions;
onchangefont;
noconfirmdelete := confirmdel.value;
blinkingcaret :=  blinkcaret.value;

end;

procedure tconfideufo.onok(const sender: TObject);
begin
onapply(sender);
close;
end;

end.
