unit confideu;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 msetypes,mseglob,
 mseguiglob, mseguiintf, mseapplication, msegui, msegraphics,msegraphutils,
 mseclasses, mseforms, msegraphedits, msesimplewidgets,mseificomp,
 mseificompglob,mseifiglob, msemenus, msescrollbar, msedataedits,mseedit,
 msestat, msestatfile,msestream, msestrings, SysUtils, msewidgets,msebitmap,
 msedatanodes, msefiledialog,msegrids, mselistbrowser, msesys,mseact,
 msedragglob, msetabs, msedropdownlist,msegridsglob, msewidgetgrid,
 msememodialog, msesplitter, msecolordialog,mseeditglob, mserichstring,
 msetextedit;

type
  tconfideufo = class(tmseform)
    but_ok: TButton;
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
    tabindent: tbooleanedit;
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
  end;

var
  confideufo: tconfideufo;

implementation

uses
  confideu_mfm, main, messageform, sourceform, finddialogform, targetconsole,
  ideusettings, confcompiler, confdebugger, projectoptionsform, objectinspector,
  projecttreeform, commandorform, dialogfiles;

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

mainfo.font.height := fontsize.value;

ratio := fontsize.value / 12;

if Assigned(objectinspectorfo) then
    begin
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


if assigned(dialogfilesfo) then
begin
dialogfilesfo.selected_file.font.height := fontsize.value;
dialogfilesfo.selected_file.font.height := fontsize.value;

dialogfilesfo.list_files.cellwidth := round((ratio) * 262);

dialogfilesfo.selected_file.frame.font.height := fontsize.value;
dialogfilesfo.list_files.cellheight := round((ratio) * 19);
dialogfilesfo.list_files.font.height := fontsize.value;
dialogfilesfo.height := round((ratio) * 366);
dialogfilesfo.width  := round((ratio) * 336);
dialogfilesfo.list_files.cellwidth := dialogfilesfo.list_files.width - 6 ;

end;

mainfo.mainmenu1.menu.font.height := fontsize.value;
sourcefo.files_tab.font.height := fontsize.value;
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
     projecttreefo.projectedit.font.height := fontsize.value;
     projecttreefo.edit.font.height := fontsize.value;
     projecttreefo.projectedit.font.name := ansistring(fontname.value);
     projecttreefo.edit.font.name := ansistring(fontname.value);
     projecttreefo.grid.datarowheight := round(ratio * 16);
    end;

confcompilerfo.font.height :=  fontsize.value;
confdebuggerfo.font.height :=  fontsize.value;

// confideufo
font.height := fontsize.value;
group_file_change.width := round(ratio * 280);
group_system_layout.width := round(ratio * 280);
group_assistive.width := round(ratio * 280);
group_sourceeditor.width := round(ratio * 314);
group_sourceeditor.left := group_assistive.width + 20;
but_ok.width := round(ratio * 280);

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
 trimtrailingwhitespace.top :=  closemessages.top + closemessages.height + 2 ;
 encoding.top :=  trimtrailingwhitespace.top + trimtrailingwhitespace.height + 2 ;
 tabstops.top := encoding.top ;
 spacetabs.top := encoding.top ;

 rightmarginchars.top :=  spacetabs.top + encoding.height + 2 ;

 blockindent.top := rightmarginchars.top ;
 tabindent.top := rightmarginchars.top ;

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

debuggerfo.statdisp.font.height := fontsize.value;

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
end;

end.
