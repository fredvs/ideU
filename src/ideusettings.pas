unit ideusettings;

/// for custom compil, edit define.inc
{$I define.inc}

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 fpg_iniutils_ideu,mseglob,mseguiglob,msegui,mseclasses,mseforms,msestat,
 msestatfile,msesimplewidgets,msefiledialog,msestrings,msemacros,msedataedits,
 msebitmap,msedatanodes,mseedit,mseevent,msegraphutils,msegrids,mselistbrowser,
 msemenus,msesys,msetypes,msegraphics,msewidgets,mseactions,mseifiglob,
 msesplitter,mseificomp,mseificompglob,msememodialog,msewidgetgrid,
 mseapplication,msestream,sysutils,mseact,msedragglob,msescrollbar,msetabs,
 msegraphedits,msedropdownlist;

type
 settingsmacroty = (sma_fpcdir,sma_fpclibdir,sma_msedir,sma_mselibdir,
                   sma_syntaxdefdir,sma_templatedir, sma_layoutdir,sma_compstoredir,
                   sma_compiler,sma_debugger,
                   sma_exeext,sma_target,sma_targetosdir, sma_fpguidir, sma_ideudir, 
                   sma_docviewdir, sma_projectdir, sma_fpgui, sma_lcldir, sma_fpcsrcdir);
const

 statdirname = '^/.ideu';
 settingsmacronames: array[settingsmacroty] of msestring = ('fpcdir','fpclibdir','msedir',
                      'mselibdir','syntaxdefdir','templatedir','layoutdir','compstoredir','compiler','debugger',
                     'exeext','target','targetosdir','fpguidir', 'ideudir', 'docview', 'projectdir', 'fpgui', 'lcldir', 'fpcsrcdir');
 {$ifdef mswindows}
 {$ifdef CPU64}
 
 defaultsettingmacros: array[settingsmacroty] of msestring = (
                '','','','${MSEDIR}lib\common\','${IDEUDIR}syntaxdefs\',
                '${IDEUDIR}templates\','${IDEUDIR}layout\','${MSEDIR}apps\mse\compstore\',
                'ppcx64.exe','gdb.exe','.exe','x86_64-win64','windows','','','${IDEUDIR}docview\','','', '', '');
 {$else}
 
 defaultsettingmacros: array[settingsmacroty] of msestring = (
                '','','','${MSEDIR}lib\common\','${IDEUDIR}syntaxdefs\',
                '${IDEUDIR}templates\','${IDEUDIR}layout\','${MSEDIR}apps\mse\compstore\',
                'ppc386.exe','gdb.exe','.exe','i386-win32','windows','','','${IDEUDIR}docview\','','', '', '');
 
 {$endif}
  
 {$else}
  {$ifdef CPU64}
  
  {$ifdef linux}
  defaultsettingmacros: array[settingsmacroty] of msestring = (
                 '','','','${MSEDIR}lib/common/','${IDEUDIR}syntaxdefs/',
                '${IDEUDIR}templates/','${IDEUDIR}layout/','${MSEDIR}apps/ide/compstore/',
                 'ppcx64','gdb','','x86_64-linux','linux','','','${IDEUDIR}docview/','', '', '', '/usr/share/fpcsrc/');
  {$endif}
 
  {$ifdef freebsd}
 {$ifdef polydev}
 defaultsettingmacros: array[settingsmacroty] of msestring = (
                 '/usr/local/lib/fpc/3.0.0/','/usr/local/lib/fpc/3.0.0/units/x86_64-freebsd/',
                 '/usr/local/share/msegui/','${MSEDIR}lib/common/','/usr/local/share/ideu/syntaxdefs/',
                '/usr/local/share/ideu/templates/','/usr/local/share/ideu/layout/','${MSEDIR}apps/ide/compstore/',
               'ppcx64','/usr/local/bin/gdb','','x86_64-freebsd','linux',
               '/usr/local/share/fpgui/','/usr/local/share/ideu/','/usr/local/share/docview/','', '', '', ''));
   {$else}
  defaultsettingmacros: array[settingsmacroty] of msestring = (
                 '','','','${MSEDIR}lib/common/','${IDEUDIR}syntaxdefs/',
                '${IDEUDIR}templates/','${IDEUDIR}layout/','${MSEDIR}apps/ide/compstore/',
                 'ppcx64','gdb','','x86_64-freebsd','linux','','','${IDEUDIR}docview/','', '', '', ''));
   {$endif}
  
   {$endif}
    
  {$else}
   {$if defined(linux) and defined(cpuarm)}  
  defaultsettingmacros: array[settingsmacroty] of msestring = (
                 '','','','${MSEDIR}lib/common/','${IDEUDIR}syntaxdefs/',
                '${IDEUDIR}templates/','${IDEUDIR}layout/','${MSEDIR}apps/ide/compstore/',
                 'ppcarm','gdb','','arm-linux','linux','','','${IDEUDIR}docview/','', '', '', ''));
   {$endif}
   
    {$if defined(cpu32) and defined(linux) and not defined(cpuarm)}  
  defaultsettingmacros: array[settingsmacroty] of msestring = (
                 '','','','${MSEDIR}lib/common/','${IDEUDIR}syntaxdefs/',
                '${IDEUDIR}templates/','${IDEUDIR}layout/','${MSEDIR}apps/ide/compstore/',
                 'ppc386','gdb','','i386-linux','linux','','','${IDEUDIR}docview/','', '', '', '/usr/share/fpcsrc'));
   {$endif}
   
    {$ifdef freebsd}
  defaultsettingmacros: array[settingsmacroty] of msestring = (
                 '','','','${MSEDIR}lib/common/','${IDEUDIR}syntaxdefs/',
                '${IDEUDIR}templates/','${IDEUDIR}layout/','${MSEDIR}apps/ide/compstore/',
                   'ppc386','gdb','','i386-freebsd','linux','','','${IDEUDIR}docview/','', '', '', ''));
  
    {$endif}
  
  
  {$endif}
 {$endif}
                
type
 settingsmacroarty = array[settingsmacroty] of filenamety;
 settingsmacrosty = record
  macros: settingsmacroarty;
  globmacronames: msestringarty;
  globmacrovalues: msestringarty;
 end;
 settingsty = record
  macros: settingsmacrosty;
  printcommand: string;
 end;
  
 tsettingsfo = class(tmseform)
   tstatfile1: tstatfile;
   setting_tab: ttabwidget;
   path: ttabpage;
   macros: ttabpage;
   shortcut: ttabpage;
   other: ttabpage;
   but_ok: tbutton;
   layoutdir: tfilenameedit;
   syntaxdefdir: tfilenameedit;
   templatedir: tfilenameedit;
   docviewdir: tfilenameedit;
   fpguidir: tfilenameedit;
   compstoredir: tfilenameedit;
   mselibdir: tfilenameedit;
   msedir: tfilenameedit;
   debugger: tfilenameedit;
   compiler: tfilenameedit;
   macrogrid: twidgetgrid;
   macrovalue: tmemodialogedit;
   macroname: tstringedit;
   shortcutbu: tbutton;
   printcomm: tstringedit;
   target: tstringedit;
   exeext: tstringedit;
   targetosdir: tstringedit;
   lcldir: tfilenameedit;
   fpcsrcdir: tfilenameedit;
   procedure epandfilenamemacro(const sender: TObject; var avalue: msestring;
                     var accept: Boolean);
   procedure formoncreate(const sender: TObject);
   procedure setvalue(const sender: TObject; var avalue: msestring;
             var accept: Boolean);
   procedure setprintcomm(const sender: TObject; var avalue: msestring;
                             var accept: Boolean);
   procedure editshortcuts(const sender: TObject);
   procedure setfocus(const sender: TObject);
   procedure checkdirlayout(const sender: TObject);
  private
   fshortcutcontroller: tshortcutcontroller;
  protected
   function widgetstomacros: settingsmacrosty;
   public
     destructor destroy; override;

 end;

var
 settings: settingsty;
 settingsfo: tsettingsfo;
  TheProjectDirectory : filenamety;

procedure updatesettings(const filer: tstatfiler);
function getsettingsmacros: macroinfoarty;
function getsyssettingsmacros: macroinfoarty;
function getprintcommand: string;
function editsettings(const acaption: msestring = '';
                           const shortcuts: tshortcutcontroller = nil): boolean;
 
implementation
uses
ideusettings_mfm,classes,confideu,mclasses,msesysintf,msefileutils,mseshortcutdialog;
 
function getsettingsmacros1(var amacros: settingsmacrosty): macroinfoarty;
var
 ma1: settingsmacroty;
 int1: integer;
begin
 with amacros do begin
  setlength(globmacrovalues,length(globmacronames));
  setlength(result,ord(high(settingsmacroty))+1+length(globmacronames));
  for  ma1:= low(settingsmacroty) to high(settingsmacroty) do begin
   result[ord(ma1)].name:= settingsmacronames[ma1]; 
   result[ord(ma1)].value:= macros[ma1];
  end;
  for int1:= 0 to high(globmacronames) do begin
   result[ord(high(settingsmacroty))+1+int1].name:= globmacronames[int1]; 
   result[ord(high(settingsmacroty))+1+int1].value:= globmacrovalues[int1]; 
  end;
 end;
end;

function getsettingsmacros: macroinfoarty;
begin
 result:= getsettingsmacros1(settings.macros);
end;

function getsyssettingsmacros: macroinfoarty;
var
 int1: integer;
begin
 result:= getsettingsmacros1(settings.macros);
 for int1:= 0 to ord(sma_debugger) do begin
  result[int1].value:= tosysfilepath(result[int1].value);
 end;
end;
 
function getprintcommand: string;
begin
 result:= settings.printcommand;
end;

procedure updatesettings(const filer: tstatfiler);
var
 ma1: settingsmacroty;
begin
 with settings,macros do begin
  if filer.iswriter then begin
   for ma1:= low(settingsmacroty) to high(settingsmacroty) do begin
    filer.updatevalue(settingsmacronames[ma1],macros[ma1]);
   end;
  end
  else begin
   with tstatreader(filer) do begin
    for ma1:= low(settingsmacroty) to high(settingsmacroty) do begin
     macros[ma1]:= readmsestring(settingsmacronames[ma1],defaultsettingmacros[ma1]);
    end;
   end;
   printcommand:= sys_getprintcommand;
  end;
  filer.updatevalue('printcommand',printcommand);
  filer.updatevalue('globmacronames',globmacronames); 
  filer.updatevalue('globmacrovalues',globmacrovalues); 
 end;
  
end;

function editsettings(const acaption: msestring = '';
                  const shortcuts: tshortcutcontroller = nil): boolean;
// var
// settingsfo: tsettingsfo;
begin
 result:= false;
 settingsfo:= tsettingsfo.create(nil);
 with settingsfo do begin
  try
   fshortcutcontroller:= shortcuts;
   if shortcuts = nil then begin
    shortcutbu.visible:= false;
   end;
   if acaption <> '' then begin
    settingsfo.caption:= acaption;
   end;
    settingsfo.caption := 'Global Settings of ideU';
   if show(true) = mr_ok then begin
    result:= true;
    with settings do begin
     macros:= widgetstomacros;
//     expandprojectmacros;
     printcommand:= printcomm.value;
    end;
   end;
  finally
   free;
  end;
 end;
end;

{ tsettingsfo }

procedure tsettingsfo.formoncreate(const sender: TObject);
begin
 with settings,macros do begin
  // fpcdir.value:= macros[sma_fpcdir];
  // fpclibdir.value:= macros[sma_fpclibdir];
  msedir.value:= macros[sma_msedir];
  docviewdir.value := macros[sma_docviewdir]; 
  mselibdir.value:= macros[sma_mselibdir];
  syntaxdefdir.value:= macros[sma_syntaxdefdir];
  layoutdir.value:= macros[sma_layoutdir];
  templatedir.value:= macros[sma_templatedir];
  targetosdir.value:= macros[sma_targetosdir];
   compiler.value:= macros[sma_compiler];
    
   {$ifdef polydev}
    fpguidir.value := gINI.ReadString('Path', 'fpgui_dir', '/usr/local/share/fpgui/');
  {$else}
   fpguidir.value:= macros[sma_fpguidir];  
  {$endif}
  
  fpcsrcdir.value:= macros[sma_fpcsrcdir];
  lcldir.value:= macros[sma_lcldir];  
  compstoredir.value:= macros[sma_compstoredir]; 
  debugger.value:= macros[sma_debugger];
  exeext.value:= macros[sma_exeext];
  target.value:= macros[sma_target];
  printcomm.value:= printcommand;
  macroname.gridvalues:= globmacronames;
  macrovalue.gridvalues:= globmacrovalues;
 end;
end;

destructor tsettingsfo.destroy;
begin
  {$ifdef polydev}
    gINI.writeString('Path', 'fpc_dir', fpcdir.value);
    gINI.writeString('Path', 'fpclib_dir', fpclibdir.value);
    gINI.writeString('Path', 'fpgui_dir',fpguidir.value);
     gINI.writeString('Path', 'fpcsrcdir_dir',fpcsrcdir.value);
    gINI.writeString('Path', 'docview_dir',docviewdir.value);
    gINI.writeString('Path', 'mse_dir', msedir.value);
    gINI.writeString('Path', 'mselib_dir', mselibdir.value);
    gINI.writeString('Path', 'syntaxdef_dir',syntaxdefdir.value);
    gINI.writeString('Path', 'template_dir',templatedir.value);
    gINI.writeString('Path', 'layout_dir',layoutdir.value);
    gINI.writeString('Target', 'osdir', targetosdir.value);  
  {$endif}
 inherited;
end;

function tsettingsfo.widgetstomacros: settingsmacrosty;
begin
 with result do begin
  macros[sma_projectdir]:= TheProjectDirectory;     
  macros[sma_ideudir]:= IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) ;
  macros[sma_lcldir] := lcldir.value;  
  macros[sma_fpguidir] := fpguidir.value;
   macros[sma_fpcsrcdir] := fpcsrcdir.value;
  macros[sma_lcldir] := lcldir.value;
  macros[sma_fpgui] := macros[sma_fpguidir];
  macros[sma_docviewdir] := docviewdir.value;
  // macros[sma_fpcdir]:= fpcdir.value;
  // macros[sma_fpclibdir]:= fpclibdir.value;
  macros[sma_msedir]:= msedir.value;
  macros[sma_mselibdir]:= mselibdir.value;
  macros[sma_syntaxdefdir]:= syntaxdefdir.value;
  macros[sma_templatedir]:= templatedir.value;
  macros[sma_layoutdir]:= layoutdir.value;
  macros[sma_compstoredir]:= compstoredir.value;
  macros[sma_compiler]:= compiler.value;
  macros[sma_debugger]:= debugger.value;
  macros[sma_exeext]:= exeext.value;
  macros[sma_target]:= target.value;
  macros[sma_targetosdir]:= targetosdir.value;
  globmacronames:= macroname.gridvalues;
  globmacrovalues:= macrovalue.gridvalues;
 end;
end;

procedure tsettingsfo.epandfilenamemacro(const sender: TObject;
               var avalue: msestring; var accept: Boolean);
var
 mac1: settingsmacrosty;
begin
 mac1:= widgetstomacros;
 avalue:= expandmacros(avalue,getsettingsmacros1(mac1));
end;

procedure tsettingsfo.setvalue(const sender: TObject; var avalue: msestring;
           var accept: Boolean);
begin
 if avalue = '' then begin
  avalue:= defaultsettingmacros[settingsmacroty(tcomponent(sender).tag)];
 end;
end;

procedure tsettingsfo.setprintcomm(const sender: TObject; var avalue: msestring;
                    var accept: Boolean);
begin
 if avalue = '' then begin
  avalue:= sys_getprintcommand;
 end;
end;

procedure tsettingsfo.editshortcuts(const sender: TObject);
begin
 shortcutdialog(fshortcutcontroller);
end;

procedure tsettingsfo.setfocus(const sender: TObject);
begin
{
case tab_setting.activepageindex of
0 : compiler.setfocus;
1 : macrogrid.setfocus;
2 : shortcutbu.setfocus;
3 : exeext.setfocus;
end;
}


end;

procedure tsettingsfo.checkdirlayout(const sender: TObject);
begin
if confideufo.universal_path.value = false then
begin
compiler.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
debugger.controller.options := [fdo_sysfilename,fdo_savelastdir] ;
msedir.controller.options := [fdo_sysfilename,fdo_directory] ;
compstoredir.controller.options := [fdo_sysfilename,fdo_directory] ;
fpguidir.controller.options := [fdo_sysfilename,fdo_directory] ;
fpcsrcdir.controller.options := [fdo_sysfilename,fdo_directory] ;
lcldir.controller.options := [fdo_sysfilename,fdo_directory] ;
docviewdir.controller.options := [fdo_sysfilename,fdo_directory] ;
templatedir.controller.options := [fdo_sysfilename,fdo_directory] ;
syntaxdefdir.controller.options := [fdo_sysfilename,fdo_directory] ;
layoutdir.controller.options := [fdo_sysfilename,fdo_directory] ;
end else
begin
compiler.controller.options := [fdo_savelastdir];
debugger.controller.options := [fdo_savelastdir] ;
msedir.controller.options := [fdo_directory] ;
mselibdir.controller.options := [fdo_directory] ;
compstoredir.controller.options := [fdo_directory] ;
fpguidir.controller.options := [fdo_directory] ;
fpcsrcdir.controller.options := [fdo_directory] ;
lcldir.controller.options := [fdo_directory] ;
docviewdir.controller.options := [fdo_directory] ;
templatedir.controller.options := [fdo_directory] ;
syntaxdefdir.controller.options := [fdo_directory] ;
layoutdir.controller.options := [fdo_directory] ;
end;
end;

end.
