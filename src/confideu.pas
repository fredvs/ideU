unit confideu;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 mseconsts,msestockobjects,msetypes,mseglob,mseguiglob,mseguiintf,msefileutils,
 mseapplication,msegui,msegraphics,msegraphutils,mseclasses,mseforms,
 msegraphedits,msesimplewidgets,mseificomp,mseificompglob,mseifiglob,msemenus,
 msescrollbar,msedataedits,mseedit,msestat,msestatfile,msestream,msestrings,
 SysUtils,msewidgets,msebitmap,msedatanodes,msegrids,mselistbrowser,msesys,
 mseact,msedragglob,msetabs,msedropdownlist,msegridsglob,msewidgetgrid,
 msepointer,msememodialog,msesplitter,msecolordialog,mseeditglob,mserichstring,
 msetextedit,msefiledialogx, captionideu;

type
  tconfideufo = class(tmseform)
    but_apply: TButton;
    group_assistive: tgroupbox;
    tbassistive: tbooleanedit;
    tesakitdir: tfilenameeditx;
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
    deflayout: tfilenameeditx;
    defsynt: tfilenameeditx;
    fontsize: tintegeredit;
    fontname: tdropdownlistedit;
    closemessages: tbooleanedit;
    group_file_change: tgroupbox;
    tbfilereload: tbooleaneditradio;
    tbfilenoload: tbooleaneditradio;
    tbfileaskload: tbooleaneditradio;
    confirmdel: tbooleanedit;
    but_ok: TButton;
    tabindent: tbooleanedit;
    blinkcaret: tbooleanedit;
    brepaintcanvas: tbooleanedit;
   rectanglearea: tbooleanedit;
   addwhiteaftercomma: tbooleanedit;
   colorhint: tcoloredit;
   editfontheightsrc: tintegeredit;
   editfontnamesrc: tdropdownlistedit;
   autoheight: tbooleanedit;
   enableedited: tbooleanedit;
   runaftercompile: tbooleanedit;
    procedure zorderhandle(const Sender: TObject);
    procedure epandfilenamemacro(const Sender: TObject; var avalue: msestring; var accept: Boolean);

    procedure setvalue(const Sender: TObject; var avalue: msestring; var accept: Boolean);

    procedure dirlayout(const Sender: TObject);
    procedure autofocus(const Sender: TObject);
    procedure updownacc(const Sender: TObject);
    procedure oncloseev(const Sender: TObject);
    procedure onchangefont;
    procedure scalecommander(ratio : double);
    procedure onapply(const Sender: TObject);
    procedure onok(const Sender: TObject);
    procedure oncreated(const Sender: TObject);
    procedure setlangextrasettings();
    procedure confideuresize ;
    procedure seteditedenable();  
  end;

var
  confideufo: tconfideufo;
  hanconf : integer = -1;

implementation

uses
  confideu_mfm,
  main,
  messageform,
  conflang,
  sourceform,
  finddialogform,
  targetconsole,
  ideusettings,
  confcompiler,
  confdebugger,
  projectoptionsform,
  objectinspector,
  projecttreeform,
  commandorform,
  dialogfiles,
  conffpgui,
  confmsegui;

procedure tconfideufo.zorderhandle(const Sender: TObject);
begin
  if nozorderenable.Value = True then
    nozorderhandling := True
  else
    nozorderhandling := False;
end;

procedure tconfideufo.epandfilenamemacro(const Sender: TObject; var avalue: msestring; var accept: Boolean);
begin
  settingsfo.epandfilenamemacro(Sender, avalue, accept);
end;

procedure tconfideufo.setvalue(const Sender: TObject; var avalue: msestring; var accept: Boolean);
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

    confcompilerfo.fpccompiler.controller.options  := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.fpccompiler2.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.fpccompiler3.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.fpccompiler4.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.fpccompiler5.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.fpccompiler6.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.fpccompiler7.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.fpccompiler8.controller.options := [fdo_sysfilename, fdo_savelastdir];

    confcompilerfo.ccompiler.controller.options  := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.ccompiler2.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.ccompiler3.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.ccompiler4.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.ccompiler5.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.ccompiler6.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.ccompiler7.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.ccompiler8.controller.options := [fdo_sysfilename, fdo_savelastdir];

    confcompilerfo.javacompiler.controller.options  := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.javacompiler2.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.javacompiler3.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.javacompiler4.controller.options := [fdo_sysfilename, fdo_savelastdir];

    confcompilerfo.pythoncompiler.controller.options  := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.pythoncompiler2.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.pythoncompiler3.controller.options := [fdo_sysfilename, fdo_savelastdir];
    confcompilerfo.pythoncompiler4.controller.options := [fdo_sysfilename, fdo_savelastdir];

    confcompilerfo.othercompiler.controller.options  := [fdo_sysfilename, fdo_savelastdir];
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

    confcompilerfo.fpccompiler.controller.options  := [fdo_savelastdir];
    confcompilerfo.fpccompiler2.controller.options := [fdo_savelastdir];
    confcompilerfo.fpccompiler3.controller.options := [fdo_savelastdir];
    confcompilerfo.fpccompiler4.controller.options := [fdo_savelastdir];
    confcompilerfo.fpccompiler5.controller.options := [fdo_savelastdir];
    confcompilerfo.fpccompiler6.controller.options := [fdo_savelastdir];
    confcompilerfo.fpccompiler7.controller.options := [fdo_savelastdir];
    confcompilerfo.fpccompiler8.controller.options := [fdo_savelastdir];

    confcompilerfo.ccompiler.controller.options  := [fdo_savelastdir];
    confcompilerfo.ccompiler2.controller.options := [fdo_savelastdir];
    confcompilerfo.ccompiler3.controller.options := [fdo_savelastdir];
    confcompilerfo.ccompiler4.controller.options := [fdo_savelastdir];
    confcompilerfo.ccompiler5.controller.options := [fdo_savelastdir];
    confcompilerfo.ccompiler6.controller.options := [fdo_savelastdir];
    confcompilerfo.ccompiler7.controller.options := [fdo_savelastdir];
    confcompilerfo.ccompiler8.controller.options := [fdo_savelastdir];

    confcompilerfo.javacompiler.controller.options  := [fdo_savelastdir];
    confcompilerfo.javacompiler2.controller.options := [fdo_savelastdir];
    confcompilerfo.javacompiler3.controller.options := [fdo_savelastdir];
    confcompilerfo.javacompiler4.controller.options := [fdo_savelastdir];

    confcompilerfo.pythoncompiler.controller.options  := [fdo_savelastdir];
    confcompilerfo.pythoncompiler2.controller.options := [fdo_savelastdir];
    confcompilerfo.pythoncompiler3.controller.options := [fdo_savelastdir];
    confcompilerfo.pythoncompiler4.controller.options := [fdo_savelastdir];

    confcompilerfo.othercompiler.controller.options  := [fdo_savelastdir];
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
    mainfo.mainmenu1.options := [mo_shortcutright, mo_updateonidle]
  else
    mainfo.mainmenu1.options := [mo_shortcutright, mo_activate, mo_updateonidle];
end;

procedure tconfideufo.updownacc(const Sender: TObject);
begin
  //updownaccelerator := key_accelerator.Value;
end;

procedure tconfideufo.confideuresize ;
var
  ratio: double;
  rect1: rectty;
begin

  ratio := fontsize.Value / 12;
 // confideufo
  font.Height := fontsize.Value;
  font.Name   := ansistring(fontname.Value);

  group_file_change.Width := round(ratio * 280);
  group_system_layout.Width := round(ratio * 280);
  group_assistive.Width := round(ratio * 280);
  group_sourceeditor.Width := round(ratio * 314);
  group_sourceeditor.left := group_assistive.Width + 20;
  but_ok.Width    := round(ratio * 280) div 2;
  but_apply.Width := but_ok.Width - 1;
  but_ok.left     := but_apply.Width + but_apply.left + 1;

  group_file_change.top    := 40;
  tbfilereload.top         := tbfilereload.Height + 2;
  tbfilenoload.top         := tbfilereload.top + tbfilereload.Height + 2;
  tbfileaskload.top        := tbfilenoload.top + tbfilenoload.Height + 2;
  group_file_change.Height := tbfileaskload.top + tbfileaskload.Height + 10;

  group_system_layout.top := group_file_change.top +
    group_file_change.Height + 10;

  universal_path.top := universal_path.Height + 2;
 
  enableedited.top     := universal_path.top + universal_path.Height + 2;
 	 
  doubleclic.top     := enableedited.top + enableedited.Height + 2;
  blinkcaret.top     := doubleclic.top + doubleclic.Height + 2;

  fullpath.top       := blinkcaret.top + blinkcaret.Height + 2;
  modaldial.top      := fullpath.top + fullpath.Height + 2;
  autofocus_menu.top := modaldial.top + modaldial.Height + 2;
  nozorderenable.top := autofocus_menu.top + autofocus_menu.Height + 2;

{$ifdef mswindows}
  confirmdel.top := nozorderenable.top + nozorderenable.Height + 2;
{$else}
 brepaintcanvas.top :=  nozorderenable.top + nozorderenable.height + 2 ;
 confirmdel.top :=  brepaintcanvas.top + brepaintcanvas.height + 2 ;
{$endif}

  fontname.top := confirmdel.top + confirmdel.Height + 4;
  fontsize.top := fontname.top + fontname.Height + 2;
  
  fontname.left := 8;
  fontsize.left := 8;
   
  autoheight.left := 8;
  autoheight.top := fontsize.top + fontsize.Height + 2;

  addwhiteaftercomma.left := 6;
  addwhiteaftercomma.top := autoheight.top + autoheight.Height + 4;
  
   runaftercompile.left := 6;
  runaftercompile.top := addwhiteaftercomma.top + addwhiteaftercomma.Height + 4;



  group_system_layout.Height := runaftercompile.top + runaftercompile.Height + 10;

  
  tbassistive.top := tbassistive.Height + 2;
  tesakitdir.top  := tbassistive.top + tbassistive.Height + 2;

  group_assistive.Height := tesakitdir.top + tesakitdir.Height + 10;
  group_assistive.top    := group_system_layout.top + group_system_layout.Height + 10;

  group_sourceeditor.top := 10;

  usedefaulteditoroptions.top := usedefaulteditoroptions.Height + 2;
  backupfilecount.top         := usedefaulteditoroptions.top + usedefaulteditoroptions.Height + 2;

  stripmessageesc.top := backupfilecount.top + 10;
  closemessages.top   := backupfilecount.top + backupfilecount.Height + 6;

  trimtrailingwhitespace.top := closemessages.top + closemessages.Height + 2;
  
  editfontnamesrc.top := trimtrailingwhitespace.top + trimtrailingwhitespace.Height + 2;
 
  editfontheightsrc.top := editfontnamesrc.top;
    
  encoding.top := editfontnamesrc.top + editfontnamesrc.Height + 2;

  encoding.Width := round(ratio * 84);
  tabstops.top   := encoding.top;
  tabstops.left  := encoding.right + 40;
  spacetabs.top  := tabstops.bottom - spacetabs.Height;
  spacetabs.left := tabstops.right + 4;

  rightmarginchars.top := encoding.top + encoding.Height + 2;

  blockindent.top := rightmarginchars.top;
  tabindent.top   := blockindent.bottom - tabindent.Height;

  blockindent.left := encoding.right + 40;
  tabindent.left   := blockindent.right + 4;


  colornote.top    := rightmarginchars.top + rightmarginchars.Height + 2;
  colorwarning.top := colornote.top + colornote.Height + 2;
  colorerror.top   := colorwarning.top + colorwarning.Height + 2;
  colorhint.top   := colorerror.top + colorerror.Height + 2;


  deflayout.top := colorhint.top + colorhint.Height + 2;
  defsynt.top   := deflayout.top + deflayout.Height + 2;
   group_sourceeditor.Height := defsynt.top + defsynt.Height + 10;
  
  rectanglearea.left := group_sourceeditor.left + 10;
  
  rectanglearea.top := group_sourceeditor.bottom + 4;

  Height := group_assistive.bottom + 10;

  if findformcreated then
    finddialogdotextsize;

  rect1 := application.screenrect(window);

  fontname.left := 10;
  fontsize.left := 10;

  //group_file_changed2.width := round(ratio * 280);

  Width := group_sourceeditor.left + group_assistive.Width + round(40 * ratio);

  invalidate;

  left := (rect1.cx - Width) div 2;
  end;
  
procedure tconfideufo.seteditedenable();  
begin
 debuggerfo.edit_compiler.visible := enableedited.value;

 debuggerfo.edit_compilernum.visible := enableedited.value;

 debuggerfo.edit_options.visible := enableedited.value;

 debuggerfo.edited_make.visible := enableedited.value;

 debuggerfo.edited_abort.visible := enableedited.value;

 debuggerfo.edited_run.visible := enableedited.value;
 
 mainfo.mainmenu1.menu.itembynames(['edited']).visible := enableedited.value;
 
 if enableedited.value then 
  debuggerfo.paneledited.Width := debuggerfo.edited_run.right + 4
  else
  debuggerfo.paneledited.Width := debuggerfo.procedure_list.right + 4;

 end;

procedure tconfideufo.scalecommander(ratio : double);
begin

  debuggerfo.font.Height     := fontsize.Value;
  debuggerfo.font.Name       := ansistring(fontname.Value);
  debuggerfo.frame.grip_size := round(12 * ratio);

  debuggerfo.assistive.Height := round(ratio * 26);
  debuggerfo.assistive.Width  := debuggerfo.assistive.Height;

  debuggerfo.properties_list.Height := debuggerfo.assistive.Height;
  debuggerfo.properties_list.Width  := debuggerfo.assistive.Height;
  debuggerfo.properties_list.left   := debuggerfo.assistive.right + 2;

  debuggerfo.find_in_directory.Height := debuggerfo.assistive.Height;
  debuggerfo.find_in_directory.Width  := debuggerfo.assistive.Height;
  debuggerfo.find_in_directory.left   := debuggerfo.properties_list.right + 2;

  debuggerfo.line_number.Height := debuggerfo.assistive.Height;
  debuggerfo.line_number.Width  := debuggerfo.assistive.Height;
  debuggerfo.line_number.left   := debuggerfo.find_in_directory.right + 2;

  debuggerfo.terminal_run.Height := debuggerfo.assistive.Height;
  debuggerfo.terminal_run.Width  := debuggerfo.assistive.Height;
  debuggerfo.terminal_run.left   := debuggerfo.line_number.right + 2;

  debuggerfo.panelmain.Height := debuggerfo.assistive.Height + 2;
  debuggerfo.panelmain.Width  := debuggerfo.terminal_run.right + 4;

  debuggerfo.statdisp.font.Height := fontsize.Value;
  debuggerfo.statdisp.font.Name   := ansistring(fontname.Value);

  debuggerfo.statdisp.top := debuggerfo.assistive.Height + 4;

  ///

  debuggerfo.panelproject.Height := debuggerfo.panelmain.Height;
  debuggerfo.panelproject.left   := debuggerfo.panelmain.right + 2;

  debuggerfo.project_open.Height := debuggerfo.assistive.Height;
  debuggerfo.project_open.Width  := debuggerfo.assistive.Height;
  debuggerfo.project_open.left   := 2;

  debuggerfo.project_save.Height := debuggerfo.assistive.Height;
  debuggerfo.project_save.Width  := debuggerfo.assistive.Height;
  debuggerfo.project_save.left   := debuggerfo.project_open.right + 2;

  debuggerfo.project_history.Height := debuggerfo.assistive.Height;
  debuggerfo.project_history.Width  := round(ratio * 88);
  debuggerfo.project_history.left   := debuggerfo.project_save.right + 2;

  debuggerfo.project_option.Height := debuggerfo.assistive.Height;
  debuggerfo.project_option.Width  := debuggerfo.assistive.Height;
  ;
  debuggerfo.project_option.left   := debuggerfo.project_history.right + 2;

  debuggerfo.project_options.Height := debuggerfo.assistive.Height;
  debuggerfo.project_options.Width  := 31 + round(ratio * 3);
  debuggerfo.project_options.left   := debuggerfo.project_option.right + 2;

  //debuggerfo.panelwatch.height := debuggerfo.assistive.height;
  debuggerfo.panelwatch.top  := (debuggerfo.project_option.Height -
    debuggerfo.panelwatch.Height) div 2;
  //debuggerfo.panelwatch.width := debuggerfo.assistive.height;
  debuggerfo.panelwatch.left := debuggerfo.project_options.right + 2;

  debuggerfo.project_make.Height := debuggerfo.assistive.Height;
  debuggerfo.project_make.Width  := debuggerfo.assistive.Height;
  debuggerfo.project_make.left   := debuggerfo.panelwatch.right + 2;

  debuggerfo.project_abort_compil.Height := debuggerfo.assistive.Height;
  debuggerfo.project_abort_compil.Width  := debuggerfo.assistive.Height;
  debuggerfo.project_abort_compil.left   := debuggerfo.project_make.right + 2;

  debuggerfo.debug_on.Height := debuggerfo.assistive.Height;
  debuggerfo.debug_on.Width  := debuggerfo.assistive.Height;
  debuggerfo.debug_on.left   := debuggerfo.project_abort_compil.right + 2;

  debuggerfo.project_start.Height := debuggerfo.assistive.Height;
  debuggerfo.project_start.Width  := debuggerfo.assistive.Height;
  debuggerfo.project_start.left   := debuggerfo.debug_on.right + 2;

  debuggerfo.project_next.Height := debuggerfo.assistive.Height;
  debuggerfo.project_next.Width  := debuggerfo.assistive.Height;
  debuggerfo.project_next.left   := debuggerfo.project_start.right + 2;

  debuggerfo.project_step.Height := debuggerfo.assistive.Height;
  debuggerfo.project_step.Width  := debuggerfo.assistive.Height;
  debuggerfo.project_step.left   := debuggerfo.project_next.right + 2;

  debuggerfo.project_finish.Height := debuggerfo.assistive.Height;
  debuggerfo.project_finish.Width  := debuggerfo.assistive.Height;
  debuggerfo.project_finish.left   := debuggerfo.project_step.right + 2;

  debuggerfo.project_next_instruction.Height := debuggerfo.assistive.Height;
  debuggerfo.project_next_instruction.Width  := debuggerfo.assistive.Height;
  debuggerfo.project_next_instruction.left   := debuggerfo.project_finish.right + 2;

  debuggerfo.project_step_instruction.Height := debuggerfo.assistive.Height;
  debuggerfo.project_step_instruction.Width  := debuggerfo.assistive.Height;
  debuggerfo.project_step_instruction.left   := debuggerfo.project_next_instruction.right + 2;

  debuggerfo.project_interrupt.Height := debuggerfo.assistive.Height;
  debuggerfo.project_interrupt.Width  := debuggerfo.assistive.Height;
  debuggerfo.project_interrupt.left   := debuggerfo.project_step_instruction.right + 2;

  debuggerfo.project_reset.Height := debuggerfo.assistive.Height;
  debuggerfo.project_reset.Width  := debuggerfo.assistive.Height;
  debuggerfo.project_reset.left   := debuggerfo.project_interrupt.right + 2;

  debuggerfo.panelproject.Height := debuggerfo.panelmain.Height;
  debuggerfo.panelproject.left   := debuggerfo.panelmain.right + 2;

  debuggerfo.panelproject.Width := debuggerfo.project_reset.right + 4;

  debuggerfo.paneledited.Height := debuggerfo.panelmain.Height;
  debuggerfo.paneledited.left   := debuggerfo.panelproject.right + 2;

  debuggerfo.open_file.Height := debuggerfo.assistive.Height;
  debuggerfo.open_file.Width  := debuggerfo.assistive.Height;
  debuggerfo.open_file.left   := 2;

  debuggerfo.save_file.Height := debuggerfo.assistive.Height;
  debuggerfo.save_file.Width  := debuggerfo.assistive.Height;
  debuggerfo.save_file.left   := debuggerfo.open_file.right + 2;

  debuggerfo.find_in_edit.Height := debuggerfo.assistive.Height;
  debuggerfo.find_in_edit.Width  := debuggerfo.assistive.Height;
  debuggerfo.find_in_edit.left   := debuggerfo.save_file.right + 2;

  debuggerfo.file_history.Height := debuggerfo.assistive.Height;
  debuggerfo.file_history.Width  := round(ratio * 88);
  debuggerfo.file_history.left   := debuggerfo.find_in_edit.right + 2;

  debuggerfo.toggle_form_unit.Height := debuggerfo.assistive.Height;
  debuggerfo.toggle_form_unit.Width  := debuggerfo.assistive.Height;
  debuggerfo.toggle_form_unit.left   := debuggerfo.file_history.right + 2;

  debuggerfo.code_beauty.Height := debuggerfo.assistive.Height;
  debuggerfo.code_beauty.Width  := debuggerfo.assistive.Height;
  debuggerfo.code_beauty.left   := debuggerfo.toggle_form_unit.right + 2;

  debuggerfo.procedure_list.Height := debuggerfo.assistive.Height;
  debuggerfo.procedure_list.Width  := debuggerfo.assistive.Height;
  debuggerfo.procedure_list.left   := debuggerfo.code_beauty.right + 2;

  debuggerfo.edit_compiler.Height := debuggerfo.assistive.Height;
  debuggerfo.edit_compiler.Width  := round(ratio * 44);
  debuggerfo.edit_compiler.left   := debuggerfo.procedure_list.right + 2;

  debuggerfo.edit_compilernum.Height := debuggerfo.assistive.Height;
  debuggerfo.edit_compilernum.Width  := 31 + round(ratio * 3);
  debuggerfo.edit_compilernum.left   := debuggerfo.edit_compiler.right + 2;

  debuggerfo.edit_options.Height := debuggerfo.assistive.Height;
  debuggerfo.edit_options.Width  := 31 + round(ratio * 3);
  debuggerfo.edit_options.left   := debuggerfo.edit_compilernum.right + 2;

  debuggerfo.edited_make.Height := debuggerfo.assistive.Height;
  debuggerfo.edited_make.Width  := debuggerfo.assistive.Height;
  debuggerfo.edited_make.left   := debuggerfo.edit_options.right + 2;

  debuggerfo.edited_abort.Height := debuggerfo.assistive.Height;
  debuggerfo.edited_abort.Width  := debuggerfo.assistive.Height;
  debuggerfo.edited_abort.left   := debuggerfo.edited_make.right + 2;

  debuggerfo.edited_run.Height := debuggerfo.assistive.Height;
  debuggerfo.edited_run.Width  := debuggerfo.assistive.Height;
  debuggerfo.edited_run.left   := debuggerfo.edited_abort.right + 2;
  
  seteditedenable();
  
  debuggerfo.panelproject.Height := debuggerfo.panelmain.Height;
  debuggerfo.panelproject.left   := debuggerfo.panelmain.right + 2;

  debuggerfo.Height := debuggerfo.statdisp.bottom + 2;


end;

procedure tconfideufo.onchangefont;
var
  ratio: double;
  rect1: rectty;
begin

  ratio := fontsize.Value / 12;
  
   conflangfo.font.Height     := fontsize.Value;
   conflangfo.gridlang.font.Height     := fontsize.Value;
   conflangfo.gridlistfont.font.Height     := fontsize.Value;
   conflangfo.gridlang.font.Height     := fontsize.Value;
  
   conflangfo.width := round(570 * ratio);
   conflangfo.height := round(244 * ratio);
   
   conflangfo.gridlang.datarowheight := round(20 * ratio);  
    
   conflangfo.gridlang.width := round(286 * ratio);
   conflangfo.gridlang.height := round(142 * ratio);
   //conflangfo.gridlang.left := round(58 * ratio);
   conflangfo.gridlang.top := round(58 * ratio);
   conflangfo.gridlang.datacols[0].Width := round(228 * ratio);
   conflangfo.gridlang.datacols[1].Width := round(44 * ratio);
    
   conflangfo.gridlistfont.width := round(236 * ratio); 
   conflangfo.gridlistfont.height := round(142 * ratio);
   conflangfo.gridlistfont.left := round(320 * ratio);
   conflangfo.gridlistfont.top := round(58 * ratio);
   conflangfo.gridlistfont[0].Width :=round(220 * ratio);
   
   debuggerfo.font.Height     := fontsize.Value; 
   debuggerfo.statdisp.font.Height     := fontsize.Value; 
      
  mainfo.font.Height     := fontsize.Value;
  mainfo.font.Name       := ansistring(fontname.Value);
  mainfo.frame.grip_size := round(12 * ratio);
  mainfo.mainmenu1.menu.font.Height     := fontsize.Value;
  mainfo.mainmenu1.menu.fontactive.Height     := fontsize.Value;

  // message
  messagefontheight := fontsize.Value;
  messagefontname   := fontname.value;
  
  if Assigned(targetconsolefo) then
  begin
   targetconsolefo.Height := round((ratio) * 400);
   targetconsolefo.Width  := round((ratio) * 600);
   targetconsolefo.font.Height     := round(12 * ratio);
   targetconsolefo.grid.font.Height     := round(12 * ratio);
  end;
  
  // commandor
  scalecommander(ratio);
  
  if Assigned(objectinspectorfo) then
  begin
    objectinspectorfo.frame.grip_size    := round(12 * ratio);
    objectinspectorfo.font.Height        := fontsize.Value;
    objectinspectorfo.fontempty.Height   := fontsize.Value;
    objectinspectorfo.grid.font.Name     := ansistring(fontname.Value);
    objectinspectorfo.grid.datarowheight := round(ratio * 16);
    objectinspectorfo.grid.rowfonts.items[0].Height := fontsize.Value;
    objectinspectorfo.grid.rowfonts.items[1].Height := fontsize.Value;
    objectinspectorfo.grid.rowfonts.items[2].Height := fontsize.Value;
    objectinspectorfo.grid.rowfonts.items[3].Height := fontsize.Value;
    objectinspectorfo.grid.rowfonts.items[4].Height := fontsize.Value;
    objectinspectorfo.grid.rowfonts.items[5].Height := fontsize.Value;

    objectinspectorfo.findbu.font.Height   := fontsize.Value;
    objectinspectorfo.compedit.font.Height := fontsize.Value;

    objectinspectorfo.findbu.Height   := objectinspectorfo.compselector.Height;
    objectinspectorfo.compedit.Height := objectinspectorfo.compselector.Height;

  end;

  targetconsolefo.grid.font.Height := fontsize.Value;
  //targetconsolefo.grid.font.name := ansistring(fontname.value);

  mainfo.mainmenu1.menu.font.Height := fontsize.Value;
  sourcefo.files_tab.font.Height    := fontsize.Value;
  sourcefo.frame.grip_size          := round(12 * ratio);
  sourcefo.files_tab.tab_fontactivetab.Height := fontsize.Value;
  sourcefo.files_tab.tab_fonttab.Height := fontsize.Value;
  sourcefo.files_tab.tab_size       := round(24 * ratio);
  sourcefo.step_back.Height         := round(24 * ratio);
  sourcefo.step_forward.Height      := round(24 * ratio);

  mainfo.mainmenu1.menu.font.Name     := ansistring(fontname.Value);
  sourcefo.files_tab.font.Name        := ansistring(fontname.Value);
  sourcefo.files_tab.tab_fontactivetab.Name := ansistring(fontname.Value);
  sourcefo.files_tab.tab_fonttab.Name := ansistring(fontname.Value);

  if Assigned(sourcefo.ActivePage) then
  begin
    sourcefo.ActivePage.pathdisp.font.Height := fontsize.Value;
    sourcefo.ActivePage.linedisp.font.Height := fontsize.Value;
    sourcefo.ActivePage.pathdisp.font.Name   := ansistring(fontname.Value);
    sourcefo.ActivePage.linedisp.font.Name   := ansistring(fontname.Value);

    sourcefo.ActivePage.pathdisp.Height := round(ratio * 20);
    sourcefo.ActivePage.linedisp.Height := round(ratio * 20);

    sourcefo.ActivePage.source_editor.Height := sourcefo.ActivePage.Height -
      sourcefo.ActivePage.pathdisp.Height - 2;

    sourcefo.ActivePage.pathdisp.top := sourcefo.ActivePage.source_editor.Height + 1;
    sourcefo.ActivePage.linedisp.top := sourcefo.ActivePage.pathdisp.top;

  end;

  sourcefo.tpopupmenu1.menu.font.Height       := fontsize.Value;
  sourcefo.tpopupmenu1.menu.fontactive.Height := fontsize.Value;
  sourcefo.tpopupmenu1.menu.font.Name         := ansistring(fontname.Value);
  sourcefo.tpopupmenu1.menu.fontactive.Name   := ansistring(fontname.Value);

  if Assigned(projecttreefo) then
  begin
    projecttreefo.frame.grip_size         := round(12 * ratio);
    projecttreefo.projectedit.font.Height := fontsize.Value;
    projecttreefo.edit.font.Height        := fontsize.Value;
    projecttreefo.projectedit.font.Name   := ansistring(fontname.Value);
    projecttreefo.edit.font.Name          := ansistring(fontname.Value);
    projecttreefo.grid.datarowheight      := round(ratio * 24);
  end;

  confcompilerfo.font.Height := fontsize.Value;
  confcompilerfo.font.Name   := ansistring(fontname.Value);

  confdebuggerfo.font.Height := fontsize.Value;
  confdebuggerfo.font.Name   := ansistring(fontname.Value);

  // confmsegui
  confmseguifo.font.Height := fontsize.Value;
  confmseguifo.font.Name   := ansistring(fontname.Value);

  // conffpguifo

  conffpguifo.font.Height := fontsize.Value;
  conffpguifo.font.Name   := ansistring(fontname.Value);

  conffpguifo.fpguidesigner.top       := 40;
  conffpguifo.enablefpguidesigner.top := conffpguifo.fpguidesigner.top + conffpguifo.fpguidesigner.Height + 2;
  conffpguifo.tbfpgonlyone.top        := conffpguifo.enablefpguidesigner.top + conffpguifo.enablefpguidesigner.Height + 2;

  conffpguifo.groupcommand.top := conffpguifo.tbfpgonlyone.top + conffpguifo.tbfpgonlyone.Height + 6;

  conffpguifo.ifloadfile.top  := conffpguifo.edfilename.Height + 2;
  conffpguifo.edfilename.top  := conffpguifo.ifloadfile.top;
  conffpguifo.edfilename.left := conffpguifo.ifloadfile.right + 30;

  conffpguifo.ifclose.top  := conffpguifo.ifloadfile.top + conffpguifo.edclose.Height + 2;
  conffpguifo.edclose.top  := conffpguifo.ifclose.top;
  conffpguifo.edclose.left := conffpguifo.edfilename.left;

  conffpguifo.ifshow.top  := conffpguifo.ifclose.top + conffpguifo.edclose.Height + 2;
  conffpguifo.edshow.top  := conffpguifo.ifshow.top;
  conffpguifo.edshow.left := conffpguifo.edfilename.left;

  conffpguifo.ifhide.top  := conffpguifo.ifshow.top + conffpguifo.edclose.Height + 2;
  conffpguifo.edhide.top  := conffpguifo.ifhide.top;
  conffpguifo.edhide.left := conffpguifo.edfilename.left;

  conffpguifo.ifquit.top  := conffpguifo.ifhide.top + conffpguifo.edclose.Height + 2;
  conffpguifo.edquit.top  := conffpguifo.ifquit.top;
  conffpguifo.edquit.left := conffpguifo.edfilename.left;

  conffpguifo.edquit.Width := round(ratio * 96);

  conffpguifo.edfilename.Width := conffpguifo.edquit.Width;
  conffpguifo.edclose.Width    := conffpguifo.edquit.Width;
  conffpguifo.edshow.Width     := conffpguifo.edquit.Width;
  conffpguifo.edhide.Width     := conffpguifo.edquit.Width;

  conffpguifo.groupcommand.Height := conffpguifo.ifquit.top + conffpguifo.edclose.Height + 10;
  conffpguifo.groupcommand.Width  := conffpguifo.edfilename.right + 14;


  conffpguifo.iffilter.top := conffpguifo.groupcommand.top + conffpguifo.groupcommand.Height + 10;
  conffpguifo.edfilter.top := conffpguifo.iffilter.top + conffpguifo.iffilter.Height + 4;
  conffpguifo.Height       := conffpguifo.edfilter.top + conffpguifo.edfilter.Height + 10;

  conffpguifo.Width  := conffpguifo.groupcommand.Width + 26;
  conffpguifo.Height := conffpguifo.edfilter.bottom + 10;
  
  messagefo.Messages.font.Height := fontsize.Value;
  messagefo.frame.grip_size      := round(12 * ratio);

  messagefo.Messages.font.Name := ansistring(fontname.Value);

  debuggerfo.statdisp.font.Name := ansistring(fontname.Value);

  confideuresize;
 
end;

procedure tconfideufo.oncloseev(const Sender: TObject);
begin
  mainfo.ismodal := confideufo.modaldial.Value;
  onapply(nil);
end;

procedure tconfideufo.onapply(const Sender: TObject);
var
 str1: ttextstream;
 thedir : string;
begin

  messagefo.updateprojectoptions;
  onchangefont;
  noconfirmdelete := confirmdel.Value;
  blinkingcaret   := blinkcaret.Value;
  
  if usedefaulteditoroptions.value then
  begin
  
  
  if fileexists(deflayout.text) then begin
  thedir := tosysfilepath(deflayout.Text);
  str1:= ttextstream.create(thedir);
  debuggerfo.close;
  mainfo.loadwindowlayout(str1);
  str1.Destroy();
  end; 
  
  sourcefo.files_tab.activepageindex := 0;
  sourcefo.activepage.updatestatvalues;
   
   if fileexists(defsynt.text) then begin
  if hanconf <> -1 then sourcefo.syntaxpainter.freedeffile(hanconf);
  thedir := tosysfilepath(defsynt.Text);
  str1 := ttextstream.Create(thedir);
  hanconf := sourcefo.syntaxpainter.readdeffile(str1);
  str1.Destroy();
  end;
 
 end;
 
end;

procedure tconfideufo.onok(const Sender: TObject);
begin
  onapply(Sender);
  Close;
  application.processmessages;
end;

procedure tconfideufo.oncreated(const Sender: TObject);
begin
{$ifdef mswindows}
  brepaintcanvas.Visible := False;
{$endif}
end;

procedure tconfideufo.setlangextrasettings();
var
strz : string = '';
begin
 if MSEFallbackLang = 'zh' then strz := '             ';
  Caption := lang_xstockcaption[ord(sc_extrasettings)] + strz ;
  but_ok.Caption  := lang_modalresult[Ord(mr_ok)] + strz ;
  but_apply.Caption  := lang_settings[Ord(se_apply)] + strz ;
  group_assistive.frame.caption := lang_settings[Ord(se_groupassistive)] + strz ;
  tesakitdir.frame.caption := lang_settings[Ord(se_sakitdir)] + strz ;
  tesakitdir.controller.captiondir := lang_settings[Ord(se_sakitdir)] + strz ;
    
  tbassistive.frame.caption := lang_settings[Ord(se_enableassistive)] + strz ;
  group_system_layout.frame.caption := lang_settings[Ord(se_groupsystemlayout)] + strz ;
  universal_path.frame.caption := lang_settings[Ord(se_universalpath)] + strz ;
  nozorderenable.frame.caption := lang_settings[Ord(se_nozorder)] + strz ;
  doubleclic.frame.caption := lang_settings[Ord(se_doubleclic)] + strz ;
  autofocus_menu.frame.caption := lang_settings[Ord(se_autofocusmenu)] + strz ;
  modaldial.frame.caption := lang_settings[Ord(se_modaldial)] + strz ;
  fontsize.frame.caption := lang_settings[Ord(se_fontsize)] + strz ;
  fontname.frame.caption := lang_settings[Ord(se_fontname)] + strz ;
  confirmdel.frame.caption := lang_settings[Ord(se_confirmdel)] + strz ;
  blinkcaret.frame.caption := lang_settings[Ord(se_blinkcaret)] + strz ;
  brepaintcanvas.frame.caption := lang_settings[Ord(se_repaintcanvas)] + strz ;
  
  // todo in lang
  rectanglearea.frame.caption := 'Rectangle area for multi-select' + strz ;

  group_sourceeditor.frame.caption := lang_settings[Ord(se_groupsourceeditor)] + strz ;
  trimtrailingwhitespace.frame.caption := lang_projectoptions[Ord(po_trimtrailing)] + strz ;
  
  editfontnamesrc.frame.caption := lang_settings[Ord(se_fontname)] + strz ;
  editfontheightsrc.frame.caption := lang_settings[Ord(se_fontsize)] + strz ;
  
  rightmarginchars.frame.caption := lang_projectoptions[Ord(po_rightmarginline)] + strz ;
  encoding.frame.caption := lang_projectoptions[Ord(po_encoding)] + strz ;
  backupfilecount.frame.caption := lang_projectoptions[Ord(po_backup)] + strz ;
  tabstops.frame.caption := lang_projectoptions[Ord(po_tabstops)] + strz ;
  blockindent.frame.caption := lang_xstockcaption[Ord(sc_indent)] + strz ;
  usedefaulteditoroptions.frame.caption := lang_settings[Ord(se_usedefaulteditoroptions)] + strz ;
  spacetabs.frame.caption := lang_projectoptions[Ord(po_spacetab)] + strz ;
  colornote.frame.caption := lang_projectoptions[Ord(po_colornote)] + strz ;
  colorhint.frame.caption := lang_projectoptions[Ord(po_colorhint)] + strz ;
  colorerror.frame.caption := lang_projectoptions[Ord(po_colorerror)] + strz ;
  colorwarning.frame.caption := lang_projectoptions[Ord(po_colorwarning)] + strz ;
  stripmessageesc.frame.caption := lang_projectoptions[Ord(po_stripmessageesc)] + strz ;
  stripmessageesc.hint := lang_projectoptions[Ord(po_stripmessageeschint)] + strz ;
  
  deflayout.frame.caption := lang_xstockcaption[ord(sc_layout)] + strz ;
  defsynt.frame.caption := lang_xstockcaption[ord(sc_syntax)] + strz ;
  closemessages.frame.caption := lang_projectoptions[Ord(po_closemessages)] + strz ;
  addwhiteaftercomma.frame.caption := lang_settings[Ord(se_addwhiteaftercomma)] + strz ;
  
  group_file_change.frame.caption := lang_settings[Ord(se_groupfilechange)] + strz ;
  tbfilereload.frame.caption := lang_settings[Ord(se_filereload)] + strz ;
  fullpath.frame.caption := lang_settings[Ord(se_fullpath)] + strz ;
  tbfilenoload.frame.caption := lang_settings[Ord(se_filenoload)] + strz ;
  tbfileaskload.frame.caption := lang_settings[Ord(se_fileaskload)] + strz ;
   rectanglearea.frame.caption := lang_settings[Ord(se_rectanglearea)] + strz ;

end;


end.

