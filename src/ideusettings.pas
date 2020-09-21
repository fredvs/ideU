unit ideusettings;

/// for custom compil, edit define.inc
{$I define.inc}

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 fpg_iniutils_ideu, mseglob, mseguiglob, msegui, mseclasses, mseforms, msestat,
 msestatfile, msesimplewidgets, msefiledialog, msestrings, msemacros,
 msedataedits,msebitmap, msedatanodes, mseedit, mseevent, msegraphutils,
 msegrids, mselistbrowser,msemenus, msesys, msetypes, msegraphics, msewidgets,
 mseactions, mseifiglob,msesplitter, mseificomp, mseificompglob, msememodialog,
 msewidgetgrid,mseapplication, msestream, SysUtils, mseact, msedragglob,
 msescrollbar, msetabs,msegraphedits, msedropdownlist, msegridsglob,mseeditglob,
 mserichstring,msetextedit, msecolordialog, projectoptionsform;

type
  settingsmacroty = (sma_fpcdir, sma_fpclibdir, sma_msedir, sma_mselibdir,
    sma_syntaxdefdir, sma_templatedir, sma_layoutdir, sma_compstoredir,
    sma_compiler, sma_debugger,
    sma_exeext, sma_target, sma_targetosdir, sma_fpguidir, sma_ideudir,
    sma_docviewdir, sma_projectdir, sma_fpgui, sma_lcldir, sma_bgrabitmapdir,sma_fpcsrcdir);

const

  statdirname = '^/.ideu';
  settingsmacronames: array[settingsmacroty] of msestring =
    ('fpcdir', 'fpclibdir', 'msedir',
    'mselibdir', 'syntaxdefdir', 'templatedir', 'layoutdir',
    'compstoredir', 'compiler', 'debugger',
    'exeext', 'target', 'targetosdir', 'fpguidir',
    'ideudir', 'docview', 'projectdir', 'fpgui', 'lcldir', 'bgrabitmapdir', 'fpcsrcdir');
 {$ifdef mswindows}
 {$ifdef CPU64}

  defaultsettingmacros: array[settingsmacroty] of msestring = (
    '', '', '', '${MSEDIR}lib\common\', '${IDEUDIR}syntaxdefs\',
    '${IDEUDIR}templates\', '${IDEUDIR}layout\',
    '${MSEDIR}apps\mse\compstore\',
    'ppcx64.exe', 'gdb.exe', '.exe', 'x86_64-win64', 'windows',
    '', '', '${IDEUDIR}docview\', '', '', '', '', '');
 {$else}

  defaultsettingmacros: array[settingsmacroty] of msestring = (
    '', '', '', '${MSEDIR}lib\common\', '${IDEUDIR}syntaxdefs\',
    '${IDEUDIR}templates\', '${IDEUDIR}layout\',
    '${MSEDIR}apps\mse\compstore\',
    'ppc386.exe', 'gdb.exe', '.exe', 'i386-win32', 'windows',
    '', '', '${IDEUDIR}docview\', '', '', '', '', '');

 {$endif}

 {$else}
  {$ifdef CPU64}

  {$ifdef linux}
  defaultsettingmacros: array[settingsmacroty] of msestring = (
    '', '', '', '${MSEDIR}lib/common/', '${IDEUDIR}syntaxdefs/',
    '${IDEUDIR}templates/', '${IDEUDIR}layout/',
    '${MSEDIR}apps/ide/compstore/',
    'ppcx64', 'gdb', '', 'x86_64-linux', 'linux', '', '', '${IDEUDIR}docview/', '',
    '', '', '', '/usr/share/fpcsrc/');
  {$endif}

  {$ifdef freebsd}
 {$ifdef polydev}
  defaultsettingmacros: array[settingsmacroty] of msestring = (
    '/usr/local/lib/fpc/3.0.0/', '/usr/local/lib/fpc/3.0.0/units/x86_64-freebsd/',
    '/usr/local/share/msegui/', '${MSEDIR}lib/common/',
    '/usr/local/share/ideu/syntaxdefs/',
    '/usr/local/share/ideu/templates/', '/usr/local/share/ideu/layout/',
    '${MSEDIR}apps/ide/compstore/',
    'ppcx64', '/usr/local/bin/gdb', '', 'x86_64-freebsd', 'linux',
    '/usr/local/share/fpgui/', '/usr/local/share/ideu/',
    '/usr/local/share/docview/', '', '', '', '','');
   {$else}
  defaultsettingmacros: array[settingsmacroty] of msestring = (
    '', '', '', '${MSEDIR}lib/common/', '${IDEUDIR}syntaxdefs/',
    '${IDEUDIR}templates/', '${IDEUDIR}layout/',
    '${MSEDIR}apps/ide/compstore/',
    'ppcx64', 'gdb', '', 'x86_64-freebsd', 'linux', '', '',
    '${IDEUDIR}docview/', '', '', '', '','');
   {$endif}

   {$endif}

  {$else}
   {$if defined(linux) and defined(cpuarm)}
  defaultsettingmacros: array[settingsmacroty] of msestring = (
    '', '', '', '${MSEDIR}lib/common/', '${IDEUDIR}syntaxdefs/',
    '${IDEUDIR}templates/', '${IDEUDIR}layout/',
    '${MSEDIR}apps/ide/compstore/',
    'ppcarm', 'gdb', '', 'arm-linux', 'linux', '', '', '${IDEUDIR}docview/', '',
    '', '', '','');
   {$endif}

    {$if defined(cpu32) and defined(linux) and not defined(cpuarm)}
  defaultsettingmacros: array[settingsmacroty] of msestring = (
    '', '', '', '${MSEDIR}lib/common/', '${IDEUDIR}syntaxdefs/',
    '${IDEUDIR}templates/', '${IDEUDIR}layout/',
    '${MSEDIR}apps/ide/compstore/',
    'ppc386', 'gdb', '', 'i386-linux', 'linux', '', '', '${IDEUDIR}docview/',
    '', '', '','', '/usr/share/fpcsrc/');
   {$endif}


    {$ifdef freebsd}
  defaultsettingmacros: array[settingsmacroty] of msestring = (
    '', '', '', '${MSEDIR}lib/common/', '${IDEUDIR}syntaxdefs/',
    '${IDEUDIR}templates/', '${IDEUDIR}layout/',
    '${MSEDIR}apps/ide/compstore/',
    'ppc386', 'gdb', '', 'i386-freebsd', 'linux', '', '',
    '${IDEUDIR}docview/', '', '', '', '','');

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
   lcldir: tfilenameedit;
   fpcsrcdir: tfilenameedit;
   macros: ttabpage;
   macrogrid: twidgetgrid;
   macrovalue: tmemodialogedit;
   macroname: tstringedit;
   other: ttabpage;
   printcomm: tstringedit;
   exeext: tstringedit;
   target: tstringedit;
   targetosdir: tstringedit;
   shortcutbu: tbutton;
   but_ok: tbutton;
   bgrabitmapdir: tfilenameedit;
    procedure epandfilenamemacro(const Sender: TObject; var avalue: msestring;
      var accept: boolean);
    procedure formoncreate(const Sender: TObject);
    procedure setvalue(const Sender: TObject; var avalue: msestring;
      var accept: boolean);
    procedure setprintcomm(const Sender: TObject; var avalue: msestring;
      var accept: boolean);
    procedure editshortcuts(const Sender: TObject);
    procedure checkdirlayout(const Sender: TObject);
  private
    fshortcutcontroller: tshortcutcontroller;
  protected
    function widgetstomacros: settingsmacrosty;
  public
    destructor Destroy; override;

  end;

var
  settings: settingsty;
  settingsfo: tsettingsfo;
  TheProjectDirectory: filenamety;

procedure updatesettings(const filer: tstatfiler);
function getsettingsmacros: macroinfoarty;
function getsyssettingsmacros: macroinfoarty;
function getprintcommand: string;
function editsettings(const acaption: msestring = '';
  const shortcuts: tshortcutcontroller = nil): boolean;

implementation

uses
  ideusettings_mfm, Classes, confideu, mclasses, msesysintf, msefileutils, mseshortcutdialog;

function getsettingsmacros1(var amacros: settingsmacrosty): macroinfoarty;
var
  ma1: settingsmacroty;
  int1: integer;
begin
  with amacros do
  begin
    result := nil;
    setlength(globmacrovalues, length(globmacronames));
    setlength(Result, Ord(high(settingsmacroty)) + 1 + length(globmacronames));
    for  ma1 := low(settingsmacroty) to high(settingsmacroty) do
    begin
      Result[Ord(ma1)].Name := settingsmacronames[ma1];
      Result[Ord(ma1)].Value := macros[ma1];
    end;
    for int1 := 0 to high(globmacronames) do
    begin
      Result[Ord(high(settingsmacroty)) + 1 + int1].Name := globmacronames[int1];
      Result[Ord(high(settingsmacroty)) + 1 + int1].Value := globmacrovalues[int1];
    end;
  end;
end;

function getsettingsmacros: macroinfoarty;
begin
  Result := getsettingsmacros1(settings.macros);
end;

function getsyssettingsmacros: macroinfoarty;
var
  int1: integer;
begin
  Result := getsettingsmacros1(settings.macros);
  for int1 := 0 to Ord(sma_debugger) do
  begin
    Result[int1].Value := tosysfilepath(Result[int1].Value);
  end;
end;

function getprintcommand: string;
begin
  Result := settings.printcommand;
end;

procedure updatesettings(const filer: tstatfiler);
var
  ma1: settingsmacroty;
begin
  with settings, macros do
  begin
    if filer.iswriter then
    begin
      for ma1 := low(settingsmacroty) to high(settingsmacroty) do
      begin
        filer.updatevalue(settingsmacronames[ma1], macros[ma1]);
      end;
    end
    else
    begin
      with tstatreader(filer) do
      begin
        for ma1 := low(settingsmacroty) to high(settingsmacroty) do
        begin
          macros[ma1] := readmsestring(settingsmacronames[ma1], defaultsettingmacros[ma1]);
        end;
      end;
      printcommand := ansistring(sys_getprintcommand);
    end;
    filer.updatevalue('printcommand', printcommand);
    filer.updatevalue('globmacronames', globmacronames);
    filer.updatevalue('globmacrovalues', globmacrovalues);
  end;

end;

function editsettings(const acaption: msestring = '';
  const shortcuts: tshortcutcontroller = nil): boolean;
   var  ratio: double;
begin
  Result := False;
  settingsfo := tsettingsfo.Create(nil);

  with settingsfo do
  begin
    try
      font.height := confideufo.fontsize.value;
      font.name := ansistring(confideufo.fontname.value);
      setting_tab.tab_size := confideufo.fontsize.value + 8;
      but_ok.height := confideufo.fontsize.value + 8;
      
      ratio := confideufo.fontsize.value / 12;
      
 width := round(ratio* 430) + 16;
 
 setting_tab.width := width - 4;
  
 path.width := width ;
  
 compiler.top := 4;
 compiler.width := round(ratio* 430);
 
 compiler.invalidate;     
      
 
  debugger.top :=  compiler.top + compiler.height + 2 ;
 debugger.width := compiler.width;
 
 fpcsrcdir.top :=  debugger.top + debugger.height + 2 ;
 fpcsrcdir.width := compiler.width;
 
 msedir.top :=  fpcsrcdir.top + compiler.height + 2 ;
 msedir.width := compiler.width;
 
 mselibdir.top :=  msedir.top + compiler.height + 2 ;
 mselibdir.width := compiler.width;
 
 compstoredir.top :=  mselibdir.top + compiler.height + 2 ;
 compstoredir.width := compiler.width;
 
 fpguidir.top :=  compstoredir.top + compiler.height + 2 ;
 fpguidir.width := compiler.width;
 
 docviewdir.top :=  fpguidir.top + compiler.height + 2 ;
 docviewdir.width := compiler.width;
 
 lcldir.top :=  docviewdir.top + compiler.height + 2 ;
 lcldir.width := compiler.width;
 
 layoutdir.top :=  lcldir.top + compiler.height + 2 ;
 layoutdir.width := compiler.width;

 templatedir.top :=  layoutdir.top + compiler.height + 2 ;
 templatedir.width := compiler.width;
 
  syntaxdefdir.top :=  templatedir.top + compiler.height + 2 ;
 syntaxdefdir.width := compiler.width;

   bgrabitmapdir.top :=  syntaxdefdir.top + compiler.height + 2 ;
 bgrabitmapdir.width := compiler.width;
 

 setting_tab.height := bgrabitmapdir.bottom + compiler.height ;
 
 height := setting_tab.height + 4;
 
 path.height := setting_tab.height ;       

  
exeext.top := 60;
 exeext.width := compiler.width;
 
 target.top :=  exeext.top + compiler.height + 30 ;
 target.width := compiler.width;
 
 printcomm.top :=  target.top + debugger.height + 30 ;
 printcomm.width := compiler.width;
 
 targetosdir.top :=  printcomm.top + compiler.height + 30 ;
 targetosdir.width := compiler.width;
 
 shortcutbu.top :=  targetosdir.top + compiler.height + 60 ;
 shortcutbu.left := (setting_tab.width - shortcutbu.width) div 2;     

      fshortcutcontroller := shortcuts;
      if shortcuts = nil then
      begin
        shortcutbu.Visible := False;
      end;
      if acaption <> '' then
      begin
        settingsfo.Caption := acaption;
      end;
      settingsfo.Caption := 'Global Settings of ideU';
      if Show(True) = mr_ok then
      begin
        Result := True;
        with settings do
        begin
          macros := widgetstomacros;
          //     expandprojectmacros;
          printcommand := ansistring(printcomm.Value);
        end;
      end;
    finally
      Free;
    end;
  end;
end;

{ tsettingsfo }

procedure tsettingsfo.formoncreate(const Sender: TObject);
begin
  with settings, macros do
  begin
    // fpcdir.value:= macros[sma_fpcdir];
    // fpclibdir.value:= macros[sma_fpclibdir];
    msedir.Value := macros[sma_msedir];
    docviewdir.Value := macros[sma_docviewdir];
    mselibdir.Value := macros[sma_mselibdir];
    syntaxdefdir.Value := macros[sma_syntaxdefdir];
    layoutdir.Value := macros[sma_layoutdir];
    templatedir.Value := macros[sma_templatedir];
    targetosdir.Value := macros[sma_targetosdir];
    compiler.Value := macros[sma_compiler];

   {$ifdef polydev}
    fpguidir.Value := gINI.ReadString('Path', 'fpgui_dir', '/usr/local/share/fpgui/');
  {$else}
    fpguidir.Value := macros[sma_fpguidir];
  {$endif}
    bgrabitmapdir.Value := macros[sma_bgrabitmapdir];
    fpcsrcdir.Value := macros[sma_fpcsrcdir];
    lcldir.Value := macros[sma_lcldir];
    compstoredir.Value := macros[sma_compstoredir];
    debugger.Value := macros[sma_debugger];
    exeext.Value := macros[sma_exeext];
    target.Value := macros[sma_target];
    printcomm.Value := UTF8Decode(printcommand);
    macroname.gridvalues := globmacronames;
    macrovalue.gridvalues := globmacrovalues;
  end;
end;

destructor tsettingsfo.Destroy;
begin
  {$ifdef polydev}
  gINI.writeString('Path', 'fpc_dir', fpcdir.Value);
  gINI.writeString('Path', 'fpclib_dir', fpclibdir.Value);
  gINI.writeString('Path', 'fpgui_dir', fpguidir.Value);
  gINI.writeString('Path', 'fpcsrcdir_dir', fpcsrcdir.Value);
  gINI.writeString('Path', 'docview_dir', docviewdir.Value);
  gINI.writeString('Path', 'mse_dir', msedir.Value);
  gINI.writeString('Path', 'mselib_dir', mselibdir.Value);
  gINI.writeString('Path', 'syntaxdef_dir', syntaxdefdir.Value);
  gINI.writeString('Path', 'template_dir', templatedir.Value);
  gINI.writeString('Path', 'layout_dir', layoutdir.Value);
  gINI.writeString('Target', 'osdir', targetosdir.Value);
  {$endif}
  inherited;
end;

function tsettingsfo.widgetstomacros: settingsmacrosty;
begin
  with Result do
  begin
    macros[sma_projectdir] := TheProjectDirectory;
    macros[sma_ideudir] := UTF8Decode(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))));
    macros[sma_lcldir] := lcldir.Value;
    macros[sma_fpguidir] := fpguidir.Value;
    macros[sma_bgrabitmapdir] := bgrabitmapdir.Value;
    macros[sma_fpcsrcdir] := fpcsrcdir.Value;
    macros[sma_lcldir] := lcldir.Value;
    macros[sma_fpgui] := macros[sma_fpguidir];
    macros[sma_docviewdir] := docviewdir.Value;
    // macros[sma_fpcdir]:= fpcdir.value;
    // macros[sma_fpclibdir]:= fpclibdir.value;
    macros[sma_msedir] := msedir.Value;
    macros[sma_mselibdir] := mselibdir.Value;
    macros[sma_syntaxdefdir] := syntaxdefdir.Value;
    macros[sma_templatedir] := templatedir.Value;
    macros[sma_layoutdir] := layoutdir.Value;
    macros[sma_compstoredir] := compstoredir.Value;
    macros[sma_compiler] := compiler.Value;
    macros[sma_debugger] := debugger.Value;
    macros[sma_exeext] := exeext.Value;
    macros[sma_target] := target.Value;
    macros[sma_targetosdir] := targetosdir.Value;
    globmacronames := macroname.gridvalues;
    globmacrovalues := macrovalue.gridvalues;
  end;
end;

procedure tsettingsfo.epandfilenamemacro(const Sender: TObject;
  var avalue: msestring; var accept: boolean);
var
  mac1: settingsmacrosty;
begin
  mac1 := widgetstomacros;
  avalue := expandmacros(avalue, getsettingsmacros1(mac1));
end;

procedure tsettingsfo.setvalue(const Sender: TObject; var avalue: msestring;
  var accept: boolean);
begin
  if avalue = '' then
  begin
    avalue := defaultsettingmacros[settingsmacroty(TComponent(Sender).tag)];
  end;
end;

procedure tsettingsfo.setprintcomm(const Sender: TObject; var avalue: msestring;
  var accept: boolean);
begin
  if avalue = '' then
  begin
    avalue := sys_getprintcommand;
  end;
end;

procedure tsettingsfo.editshortcuts(const Sender: TObject);
begin
  shortcutdialog(fshortcutcontroller);
end;

procedure tsettingsfo.checkdirlayout(const Sender: TObject);
begin
  if confideufo.universal_path.Value = False then
  begin
    compiler.controller.options := [fdo_sysfilename, fdo_savelastdir];
    debugger.controller.options := [fdo_sysfilename, fdo_savelastdir];
    msedir.controller.options := [fdo_sysfilename, fdo_directory];
    compstoredir.controller.options := [fdo_sysfilename, fdo_directory];
    fpguidir.controller.options := [fdo_sysfilename, fdo_directory];
    fpcsrcdir.controller.options := [fdo_sysfilename, fdo_directory];
     bgrabitmapdir.controller.options := [fdo_sysfilename, fdo_directory];
    lcldir.controller.options := [fdo_sysfilename, fdo_directory];
    docviewdir.controller.options := [fdo_sysfilename, fdo_directory];
    templatedir.controller.options := [fdo_sysfilename, fdo_directory];
    syntaxdefdir.controller.options := [fdo_sysfilename, fdo_directory];
    layoutdir.controller.options := [fdo_sysfilename, fdo_directory];
  end
  else
  begin
    bgrabitmapdir.controller.options := [fdo_directory];  
    compiler.controller.options := [fdo_savelastdir];
    debugger.controller.options := [fdo_savelastdir];
    msedir.controller.options := [fdo_directory];
    mselibdir.controller.options := [fdo_directory];
    compstoredir.controller.options := [fdo_directory];
    fpguidir.controller.options := [fdo_directory];
    fpcsrcdir.controller.options := [fdo_directory];
    lcldir.controller.options := [fdo_directory];
    docviewdir.controller.options := [fdo_directory];
    templatedir.controller.options := [fdo_directory];
    syntaxdefdir.controller.options := [fdo_directory];
    layoutdir.controller.options := [fdo_directory];
  end;
end;

end.
