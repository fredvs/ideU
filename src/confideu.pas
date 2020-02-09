unit confideu;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 ideusettings,confcompiler,confdebugger, projectoptionsform, msetypes,mseglob,
 mseguiglob,mseguiintf,mseapplication,msegui,msegraphics,msegraphutils,
 mseclasses,mseforms,msegraphedits,msesimplewidgets,mseificomp,mseificompglob,
 mseifiglob,msemenus,msescrollbar,msedataedits,mseedit,msestat,msestatfile,
 msestream,msestrings,sysutils,msewidgets,msebitmap,msedatanodes,msefiledialog,
 msegrids,mselistbrowser,msesys,mseact,msedragglob,msetabs,msedropdownlist,
 msegridsglob,msewidgetgrid,msememodialog,msesplitter,msecolordialog,
 mseeditglob,mserichstring,msetextedit;
type
 tconfideufo = class(tmseform)
   but_ok: tbutton;
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
   key_accelerator: tbooleanedit;
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
   addwhiteaftercomma: tbooleanedit;
   procedure zorderhandle(const sender: TObject);
   procedure epandfilenamemacro(const sender: TObject; var avalue: msestring;
                     var accept: Boolean);
   
   procedure setvalue(const sender: TObject; var avalue: msestring;
           var accept: Boolean);

   procedure dirlayout(const sender: TObject);
   procedure autofocus(const sender: TObject);
   procedure updownacc(const sender: TObject);
 end;
var
 confideufo: tconfideufo;
implementation
uses
confideu_mfm, main;
procedure tconfideufo.zorderhandle(const sender: TObject);
begin
if nozorderenable.value = true then  nozorderhandling:= true else
 nozorderhandling:= false;
end;

procedure tconfideufo.epandfilenamemacro(const sender: TObject;
               var avalue: msestring; var accept: Boolean);

begin
settingsfo.epandfilenamemacro(sender,avalue,accept);
end;

procedure tconfideufo.setvalue(const sender: TObject; var avalue: msestring;
           var accept: Boolean);
begin
settingsfo.setvalue(sender,avalue,accept);
end;

procedure tconfideufo.dirlayout(const sender: TObject);
begin
if universal_path.value = false then
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
tesakitdir.controller.options := [fdo_sysfilename,fdo_directory];

confcompilerfo.fpccompiler.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confcompilerfo.fpccompiler2.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confcompilerfo.fpccompiler3.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confcompilerfo.fpccompiler4.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confcompilerfo.fpccompiler5.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confcompilerfo.fpccompiler6.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confcompilerfo.fpccompiler7.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confcompilerfo.fpccompiler8.controller.options := [fdo_sysfilename,fdo_savelastdir] ;

confcompilerfo.ccompiler.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confcompilerfo.ccompiler2.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confcompilerfo.ccompiler3.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confcompilerfo.ccompiler4.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confcompilerfo.ccompiler5.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confcompilerfo.ccompiler6.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confcompilerfo.ccompiler7.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confcompilerfo.ccompiler8.controller.options := [fdo_sysfilename,fdo_savelastdir] ;

confcompilerfo.javacompiler.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confcompilerfo.javacompiler2.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confcompilerfo.javacompiler3.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confcompilerfo.javacompiler4.controller.options := [fdo_sysfilename,fdo_savelastdir] ;

confcompilerfo.pythoncompiler.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confcompilerfo.pythoncompiler2.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confcompilerfo.pythoncompiler3.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confcompilerfo.pythoncompiler4.controller.options := [fdo_sysfilename,fdo_savelastdir] ;

confcompilerfo.othercompiler.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confcompilerfo.othercompiler2.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confcompilerfo.othercompiler3.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confcompilerfo.othercompiler4.controller.options := [fdo_sysfilename,fdo_savelastdir] ;

confdebuggerfo.debugger1.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confdebuggerfo.debugger2.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confdebuggerfo.debugger3.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
confdebuggerfo.debugger4.controller.options := [fdo_sysfilename,fdo_savelastdir] ;

end else
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

tesakitdir.controller.options :=[fdo_directory];

confcompilerfo.fpccompiler.controller.options := [fdo_savelastdir] ;
confcompilerfo.fpccompiler2.controller.options := [fdo_savelastdir] ;
confcompilerfo.fpccompiler3.controller.options := [fdo_savelastdir] ;
confcompilerfo.fpccompiler4.controller.options := [fdo_savelastdir] ;
confcompilerfo.fpccompiler5.controller.options := [fdo_savelastdir] ;
confcompilerfo.fpccompiler6.controller.options := [fdo_savelastdir] ;
confcompilerfo.fpccompiler7.controller.options := [fdo_savelastdir] ;
confcompilerfo.fpccompiler8.controller.options := [fdo_savelastdir] ;

confcompilerfo.ccompiler.controller.options := [fdo_savelastdir] ;
confcompilerfo.ccompiler2.controller.options := [fdo_savelastdir] ;
confcompilerfo.ccompiler3.controller.options := [fdo_savelastdir] ;
confcompilerfo.ccompiler4.controller.options := [fdo_savelastdir] ;
confcompilerfo.ccompiler5.controller.options := [fdo_savelastdir] ;
confcompilerfo.ccompiler6.controller.options := [fdo_savelastdir] ;
confcompilerfo.ccompiler7.controller.options := [fdo_savelastdir] ;
confcompilerfo.ccompiler8.controller.options := [fdo_savelastdir] ;

confcompilerfo.javacompiler.controller.options := [fdo_savelastdir] ;
confcompilerfo.javacompiler2.controller.options := [fdo_savelastdir] ;
confcompilerfo.javacompiler3.controller.options := [fdo_savelastdir] ;
confcompilerfo.javacompiler4.controller.options := [fdo_savelastdir] ;

confcompilerfo.pythoncompiler.controller.options := [fdo_savelastdir] ;
confcompilerfo.pythoncompiler2.controller.options := [fdo_savelastdir] ;
confcompilerfo.pythoncompiler3.controller.options := [fdo_savelastdir] ;
confcompilerfo.pythoncompiler4.controller.options := [fdo_savelastdir] ;

confcompilerfo.othercompiler.controller.options := [fdo_savelastdir] ;
confcompilerfo.othercompiler2.controller.options := [fdo_savelastdir] ;
confcompilerfo.othercompiler3.controller.options := [fdo_savelastdir] ;
confcompilerfo.othercompiler4.controller.options := [fdo_savelastdir] ;

confdebuggerfo.debugger1.controller.options :=   [fdo_savelastdir] ;
confdebuggerfo.debugger2.controller.options := [fdo_savelastdir] ;
confdebuggerfo.debugger3.controller.options := [fdo_savelastdir] ;
confdebuggerfo.debugger4.controller.options := [fdo_savelastdir] ;

end;
end;

procedure tconfideufo.autofocus(const sender: TObject);
begin
if autofocus_menu.value = false then 
begin
mainfo.mainmenu1.options := [mo_shortcutright,mo_updateonidle];
end else
begin
mainfo.mainmenu1.options := [mo_shortcutright,mo_activate,mo_updateonidle];
end;
end;

procedure tconfideufo.updownacc(const sender: TObject);
begin
updownaccelerator := key_accelerator.value;
end;

end.
