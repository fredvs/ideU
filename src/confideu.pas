unit confideu;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 ideusettings, confcompiler, confdebugger, projectoptionsform, msetypes,mseglob,
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
    group_file_changed: tgroupbox;
    tbfileaskload: tbooleaneditradio;
    tbfilenoload: tbooleaneditradio;
    tbfilereload: tbooleaneditradio;
    group_assistive: tgroupbox;
    tbassistive: tbooleanedit;
    tesakitdir: tfilenameedit;
    group_system_layout: tgroupbox;
    universal_path: tbooleanedit;
    nozorderenable: tbooleanedit;
    doubleclic: tbooleanedit;
    autofocus_menu: tbooleanedit;
    fullpath: tbooleanedit;
    tgroupbox2: tgroupbox;
    trimtrailingwhitespace: tbooleanedit;
    rightmarginchars: tintegeredit;
    encoding: tenumedit;
    backupfilecount: tintegeredit;
    tabstops: tintegeredit;
    blockindent: tintegeredit;
    usedefaulteditoroptions: tbooleanedit;
    tabindent: tbooleanedit;
    spacetabs: tbooleanedit;
   closemessages: tbooleanedit;
   colorerror: tcoloredit;
   colorwarning: tcoloredit;
   colornote: tcoloredit;
   stripmessageesc: tbooleanedit;
   addwhiteaftercomma: tbooleanedit;
    procedure zorderhandle(const Sender: TObject);
    procedure epandfilenamemacro(const Sender: TObject; var avalue: msestring;
      var accept: boolean);

    procedure setvalue(const Sender: TObject; var avalue: msestring;
      var accept: boolean);

    procedure dirlayout(const Sender: TObject);
    procedure autofocus(const Sender: TObject);
    procedure updownacc(const Sender: TObject);
   procedure oncloseev(const sender: TObject);
  end;

var
  confideufo: tconfideufo;

implementation

uses
  confideu_mfm, main, messageform;

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

procedure tconfideufo.oncloseev(const sender: TObject);
begin
messagefo.updateprojectoptions;
end;

end.
