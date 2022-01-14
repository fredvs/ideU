unit ideusettings;

/// for custom compil, edit define.inc
{$I define.inc}

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  mseconsts_ide,
  po2const,
  msestockobjects,
  fpg_iniutils_ideu,
  mseglob,
  mseguiglob,
  msegui,
  mseclasses,
  mseforms,
  msestat,
  msestatfile,
  msesimplewidgets,
  msefiledialogx,
  msestrings,
  msemacros,
  msedataedits,
  msebitmap,
  msedatanodes,
  mseedit,
  mseevent,
  msegraphutils,
  msegrids,
  mselistbrowser,
  msemenus,
  msesys,
  msetypes,
  msegraphics,
  msewidgets,
  mseactions,
  mseifiglob,
  msesplitter,
  mseificomp,
  mseificompglob,
  msememodialog,
  msewidgetgrid,
  mseapplication,
  msestream,
  SysUtils,
  mseact,
  msedragglob,
  msescrollbar,
  msetabs,
  msegraphedits,
  msedropdownlist,
  msegridsglob,
  mseeditglob,
  mserichstring,
  msetextedit,
  msecolordialog,
  projectoptionsform;

type
  settingsmacroty = (sma_fpcdir, sma_fpclibdir, sma_msedir, sma_mselibdir,
    sma_syntaxdefdir, sma_templatedir, sma_layoutdir, sma_compstoredir,
    sma_compiler, sma_debugger,
    sma_exeext, sma_target, sma_targetosdir, sma_fpguidir, sma_ideudir,
    sma_docviewdir, sma_projectdir, sma_fpgui, sma_lcldir, sma_bgrabitmapdir, sma_fpcsrcdir);

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
    layoutdir: tfilenameeditx;
    syntaxdefdir: tfilenameeditx;
    templatedir: tfilenameeditx;
    docviewdir: tfilenameeditx;
    fpguidir: tfilenameeditx;
    compstoredir: tfilenameeditx;
    mselibdir: tfilenameeditx;
    msedir: tfilenameeditx;
    debugger: tfilenameeditx;
    compiler: tfilenameeditx;
    lcldir: tfilenameeditx;
    fpcsrcdir: tfilenameeditx;
    macros: ttabpage;
    macrogrid: twidgetgrid;
    macrovalue: tmemodialogedit;
    macroname: tstringedit;
    other: ttabpage;
    printcomm: tstringedit;
    exeext: tstringedit;
    target: tstringedit;
    targetosdir: tstringedit;
    shortcutbu: TButton;
    but_ok: TButton;
    bgrabitmapdir: tfilenameeditx;
    procedure epandfilenamemacro(const Sender: TObject; var avalue: msestring; var accept: Boolean);
    procedure formoncreate(const Sender: TObject);
    procedure setvalue(const Sender: TObject; var avalue: msestring; var accept: Boolean);
    procedure setprintcomm(const Sender: TObject; var avalue: msestring; var accept: Boolean);
    procedure editshortcuts(const Sender: TObject);
    procedure checkdirlayout(const Sender: TObject);
    procedure setlangsettings();
   procedure onchange(const sender: TObject);
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
function editsettings(const acaption: msestring = ''; const shortcuts: tshortcutcontroller = nil): Boolean;

implementation

uses
  ideusettings_mfm,
  Classes,
  confideu,
  mclasses,
  msesysintf,
  msefileutils,
  mseshortcutdialog;

function getsettingsmacros1(var amacros: settingsmacrosty): macroinfoarty;
var
  ma1: settingsmacroty;
  int1: integer;
begin
  with amacros do
  begin
    Result := nil;
    setlength(globmacrovalues, length(globmacronames));
    setlength(Result, Ord(high(settingsmacroty)) + 1 + length(globmacronames));
    for  ma1 := low(settingsmacroty) to high(settingsmacroty) do
    begin
      Result[Ord(ma1)].Name  := settingsmacronames[ma1];
      Result[Ord(ma1)].Value := macros[ma1];
    end;
    for int1 := 0 to high(globmacronames) do
    begin
      Result[Ord(high(settingsmacroty)) + 1 + int1].Name  := globmacronames[int1];
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
  Result   := getsettingsmacros1(settings.macros);
  for int1 := 0 to Ord(sma_debugger) do
    Result[int1].Value := tosysfilepath(Result[int1].Value);
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
      for ma1 := low(settingsmacroty) to high(settingsmacroty) do
        filer.updatevalue(settingsmacronames[ma1], macros[ma1])
    else
    begin
      with tstatreader(filer) do
        for ma1 := low(settingsmacroty) to high(settingsmacroty) do
          macros[ma1] := readmsestring(settingsmacronames[ma1], defaultsettingmacros[ma1]);
      printcommand    := ansistring(sys_getprintcommand);
    end;
    filer.updatevalue('printcommand', printcommand);
    filer.updatevalue('globmacronames', globmacronames);
    filer.updatevalue('globmacrovalues', globmacrovalues);
  end;

end;

function editsettings(const acaption: msestring = ''; const shortcuts: tshortcutcontroller = nil): Boolean;
var
  ratio: double;
begin
  Result     := False;
  settingsfo := tsettingsfo.Create(nil);

  with settingsfo do
    try
      font.Height   := confideufo.fontsize.Value;
      font.Name     := ansistring(confideufo.fontname.Value);
      setting_tab.tab_size := confideufo.fontsize.Value + 8;
      but_ok.Height := confideufo.fontsize.Value + 8;

      ratio := confideufo.fontsize.Value / 12;

      Width := round(ratio * 430) + 16;

      setting_tab.Width := Width - 4;

      path.Width := Width;

      compiler.top   := 4;
      compiler.Width := round(ratio * 430);

      compiler.invalidate;


      debugger.top   := compiler.top + compiler.Height + 2;
      debugger.Width := compiler.Width;

      fpcsrcdir.top   := debugger.top + debugger.Height + 2;
      fpcsrcdir.Width := compiler.Width;

      msedir.top   := fpcsrcdir.top + compiler.Height + 2;
      msedir.Width := compiler.Width;

      mselibdir.top   := msedir.top + compiler.Height + 2;
      mselibdir.Width := compiler.Width;

      compstoredir.top   := mselibdir.top + compiler.Height + 2;
      compstoredir.Width := compiler.Width;

      fpguidir.top   := compstoredir.top + compiler.Height + 2;
      fpguidir.Width := compiler.Width;

      docviewdir.top   := fpguidir.top + compiler.Height + 2;
      docviewdir.Width := compiler.Width;

      lcldir.top   := docviewdir.top + compiler.Height + 2;
      lcldir.Width := compiler.Width;

      layoutdir.top   := lcldir.top + compiler.Height + 2;
      layoutdir.Width := compiler.Width;

      templatedir.top   := layoutdir.top + compiler.Height + 2;
      templatedir.Width := compiler.Width;

      syntaxdefdir.top   := templatedir.top + compiler.Height + 2;
      syntaxdefdir.Width := compiler.Width;

      bgrabitmapdir.top   := syntaxdefdir.top + compiler.Height + 2;
      bgrabitmapdir.Width := compiler.Width;


      setting_tab.Height := bgrabitmapdir.bottom + compiler.Height;

      Height := setting_tab.Height + 4;

      path.Height := setting_tab.Height;


      exeext.top   := 60;
      exeext.Width := compiler.Width;

      target.top   := exeext.top + compiler.Height + 30;
      target.Width := compiler.Width;

      printcomm.top   := target.top + debugger.Height + 30;
      printcomm.Width := compiler.Width;

      targetosdir.top   := printcomm.top + compiler.Height + 30;
      targetosdir.Width := compiler.Width;

      shortcutbu.top  := targetosdir.top + compiler.Height + 60;
      shortcutbu.left := (setting_tab.Width - shortcutbu.Width) div 2;

      fshortcutcontroller  := shortcuts;
      if shortcuts = nil then
        shortcutbu.Visible := False;

      setlangsettings();
      //  settingsfo.Caption := 'Global Settings of ideU';

      if Show(True) = mr_ok then
      begin
        Result := True;
        with settings do
        begin
          macros       := widgetstomacros;
          //     expandprojectmacros;
          printcommand := ansistring(printcomm.Value);
        end;
      end;
    finally
      Free;
    end;
end;

{ tsettingsfo }

procedure tsettingsfo.formoncreate(const Sender: TObject);
begin
  with settings, macros do
  begin
    // fpcdir.value:= macros[sma_fpcdir];
    // fpclibdir.value:= macros[sma_fpclibdir];
    msedir.Value       := macros[sma_msedir];
    docviewdir.Value   := macros[sma_docviewdir];
    mselibdir.Value    := macros[sma_mselibdir];
    syntaxdefdir.Value := macros[sma_syntaxdefdir];
    layoutdir.Value    := macros[sma_layoutdir];
    templatedir.Value  := macros[sma_templatedir];
    targetosdir.Value  := macros[sma_targetosdir];
    compiler.Value     := macros[sma_compiler];

   {$ifdef polydev}
    fpguidir.Value := gINI.ReadString('Path', 'fpgui_dir', '/usr/local/share/fpgui/');
  {$else}
    fpguidir.Value        := macros[sma_fpguidir];
  {$endif}
    bgrabitmapdir.Value   := macros[sma_bgrabitmapdir];
    fpcsrcdir.Value       := macros[sma_fpcsrcdir];
    lcldir.Value          := macros[sma_lcldir];
    compstoredir.Value    := macros[sma_compstoredir];
    debugger.Value        := macros[sma_debugger];
    exeext.Value          := macros[sma_exeext];
    target.Value          := macros[sma_target];
    printcomm.Value       := UTF8Decode(printcommand);
    macroname.gridvalues  := globmacronames;
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
    globmacronames  := macroname.gridvalues;
    globmacrovalues := macrovalue.gridvalues;
  end;
end;

procedure tsettingsfo.epandfilenamemacro(const Sender: TObject; var avalue: msestring; var accept: Boolean);
var
  mac1: settingsmacrosty;
begin
  mac1   := widgetstomacros;
  avalue := expandmacros(avalue, getsettingsmacros1(mac1));
end;

procedure tsettingsfo.setvalue(const Sender: TObject; var avalue: msestring; var accept: Boolean);
begin
  if avalue = '' then
    avalue := defaultsettingmacros[settingsmacroty(TComponent(Sender).tag)];
end;

procedure tsettingsfo.setprintcomm(const Sender: TObject; var avalue: msestring; var accept: Boolean);
begin
  if avalue = '' then
    avalue := sys_getprintcommand;
end;

procedure tsettingsfo.editshortcuts(const Sender: TObject);
begin
  shortcutdialog(fshortcutcontroller);
end;

procedure tsettingsfo.setlangsettings();
begin

  Caption := lang_stockcaption[ord(sc_generalsettings)];
  
  path.caption :=  '  ' + lang_stockcaption[ord(sc_path)] + '  ' ; 
  but_ok.Caption  := lang_modalresult[Ord(mr_ok)];
  
  layoutdir.frame.caption := '${LAYOUTDIR} ' + 
  lang_stockcaption[ord(sc_directory)] + ' / ' + lang_stockcaption[ord(sc_layout)];
   
  layoutdir.controller.captiondir := lang_stockcaption[ord(sc_directory)] + 
  ' / ' + lang_stockcaption[ord(sc_layout)];
  
  syntaxdefdir.frame.caption := '${SYNTAXDEFDIR} ' + 
  lang_stockcaption[ord(sc_directory)] + ' / ' + lang_stockcaption[ord(sc_syntax)];
   
  syntaxdefdir.controller.captiondir := lang_stockcaption[ord(sc_directory)] + 
  ' / ' + lang_stockcaption[ord(sc_syntax)];
  
  templatedir.frame.caption := '${TEMPLATEDIR} ' + 
  lang_stockcaption[ord(sc_directory)] + ' / ' +  lang_projectoptions[Ord(po_templates)];
   
  templatedir.controller.captiondir := lang_stockcaption[ord(sc_directory)] + 
  ' / ' + lang_projectoptions[Ord(po_templates)];

  docviewdir.frame.caption := '${DOCVIEWDIR} ' + 
  lang_stockcaption[ord(sc_directory)] + ' / ' +  'DocView';
   
  docviewdir.controller.captiondir := lang_stockcaption[ord(sc_directory)] + 
  ' / ' + 'DocView';
  
  fpguidir.frame.caption := '${FPGUIDIR} ' + 
  lang_stockcaption[ord(sc_directory)] + ' / ' +  'fpGUI';
   
  fpguidir.controller.captiondir := lang_stockcaption[ord(sc_directory)] + 
  ' / '  +  'fpGUI';

  compstoredir.frame.caption := '${COMPSTOREDIR} ' + 
  lang_stockcaption[ord(sc_directory)] + ' / ' +  'CompStore';
   
  compstoredir.controller.captiondir := lang_stockcaption[ord(sc_directory)] + 
  ' / '  +  'CompStore';
  
  mselibdir.frame.caption := '${MSELIBDIR} ' + 
  lang_stockcaption[ord(sc_directory)] + ' / ' +  'MSEgui/lib';
   
  mselibdir.controller.captiondir := lang_stockcaption[ord(sc_directory)] + 
  ' / '  +  'MSEgui/lib';
  
  msedir.frame.caption := '${MSEDIR} ' + 
  lang_stockcaption[ord(sc_directory)] + ' / ' +  'MSEgui';
   
  msedir.controller.captiondir := lang_stockcaption[ord(sc_directory)] + 
  ' / '  +  'MSEgui';
 
   debugger.frame.caption := '${DEBUGGER} ' + 
  lang_stockcaption[ord(sc_file)] + ' / ' +  lang_projectoptions[Ord(po_debugcommand)];
   
  debugger.controller.captiondir := lang_stockcaption[ord(sc_file)] + 
  ' / '  + lang_projectoptions[Ord(po_debugcommand)];
  
     debugger.frame.caption := '${DEBUGGER} ' + 
  lang_stockcaption[ord(sc_file)] + ' / ' +  lang_projectoptions[Ord(po_debugcommand)];
   
  debugger.controller.captionopen := lang_stockcaption[ord(sc_file)] + 
  ' / '  + lang_projectoptions[Ord(po_debugcommand)];

  compiler.frame.caption := '${COMPILER} ' + 
  lang_stockcaption[ord(sc_file)] + ' / ' +  lang_projectoptions[Ord(po_makecommand)];
   
  compiler.controller.captionopen := lang_stockcaption[ord(sc_file)] + 
  ' / '  + lang_projectoptions[Ord(po_makecommand)];
  
  lcldir.frame.caption := '${LCLDIR} ' + 
  lang_stockcaption[ord(sc_directory)] + ' / ' +  'LCL (Lazarus)';
   
  lcldir.controller.captiondir := lang_stockcaption[ord(sc_directory)] + 
  ' / '  +  'LCL (Lazarus)';

    fpcsrcdir.frame.caption := '${FPCSRCDIR} ' + 
  lang_stockcaption[ord(sc_directory)] + ' / ' +  'fpcsrc';
   
  fpcsrcdir.controller.captiondir := lang_stockcaption[ord(sc_directory)] + 
  ' / '  +  'fpcsrc';
  
   bgrabitmapdir.frame.caption := '${BGRABITMAPDIR} ' + 
  lang_stockcaption[ord(sc_directory)] + ' / ' +  'BGRABitmap';
   
  bgrabitmapdir.controller.captiondir := lang_stockcaption[ord(sc_directory)] + 
  ' / '  +  'BGRABitmap';
    
  macros.caption := '  ' + lang_projectoptions[Ord(po_macros)] + '  ' ;
  macrogrid.frame.caption := lang_projectoptions[Ord(po_macros)]; 
  
 // macrogrid.fixrows[-1].captions.Count := 2;
  macrogrid.fixrows[-1].captions[0].Caption := lang_projectoptions[Ord(po_name)];
  macrogrid.fixrows[-1].captions[1].Caption := lang_stockcaption[ord(sc_value)];
 
  other.caption := '  ' + lang_stockcaption[ord(sc_other)] + '  ' ;
  printcomm.frame.caption := lang_stockcaption[ord(sc_printcommand)];
  exeext.frame.caption := '${EXEEXT} ' + lang_projectoptions[Ord(po_exeextension)]; 
  target.frame.caption := '${TARGET} OS ' + lang_stockcaption[ord(sc_target)];
  targetosdir.frame.caption := '${TARGETMSE} OS-MSEgui ' + lang_stockcaption[ord(sc_target)];
  shortcutbu.caption := lang_stockcaption[ord(sc_shortcut)];
   
end;

procedure tsettingsfo.checkdirlayout(const Sender: TObject);
begin
  if confideufo.universal_path.Value = False then
  begin
    compiler.controller.options      := [fdo_sysfilename, fdo_savelastdir];
    debugger.controller.options      := [fdo_sysfilename, fdo_savelastdir];
    msedir.controller.options        := [fdo_sysfilename, fdo_directory];
    compstoredir.controller.options  := [fdo_sysfilename, fdo_directory];
    fpguidir.controller.options      := [fdo_sysfilename, fdo_directory];
    fpcsrcdir.controller.options     := [fdo_sysfilename, fdo_directory];
    bgrabitmapdir.controller.options := [fdo_sysfilename, fdo_directory];
    lcldir.controller.options        := [fdo_sysfilename, fdo_directory];
    docviewdir.controller.options    := [fdo_sysfilename, fdo_directory];
    templatedir.controller.options   := [fdo_sysfilename, fdo_directory];
    syntaxdefdir.controller.options  := [fdo_sysfilename, fdo_directory];
    layoutdir.controller.options     := [fdo_sysfilename, fdo_directory];
  end
  else
  begin
    bgrabitmapdir.controller.options := [fdo_directory];
    compiler.controller.options      := [fdo_savelastdir];
    debugger.controller.options      := [fdo_savelastdir];
    msedir.controller.options        := [fdo_directory];
    mselibdir.controller.options     := [fdo_directory];
    compstoredir.controller.options  := [fdo_directory];
    fpguidir.controller.options      := [fdo_directory];
    fpcsrcdir.controller.options     := [fdo_directory];
    lcldir.controller.options        := [fdo_directory];
    docviewdir.controller.options    := [fdo_directory];
    templatedir.controller.options   := [fdo_directory];
    syntaxdefdir.controller.options  := [fdo_directory];
    layoutdir.controller.options     := [fdo_directory];
  end;
end;

procedure tsettingsfo.onchange(const sender: TObject);
begin
tabcloser := false;
end;


end.

