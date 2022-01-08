unit main;

{$ifdef linux}{$define unix}{$endif}
{$ifdef FPC}
 {$mode objfpc}{$h+}
{$endif}
{$ifndef mse_no_ifi}
 {$define mse_with_ifi}
{$endif}
{$ifdef mse_no_ifi}
 {$define mse_no_db}
{$endif}

// for custom compil, edit define.inc
{$I define.inc}

interface

{$ifndef mse_allwarnings}
 {$if fpc_fullversion >= 030100}
  {$warn 5089 off}
  {$warn 5090 off}
  {$warn 5093 off}
  {$warn 6058 off}
 {$endif}
 {$if fpc_fullversion >= 030300}
  {$warn 6060 off}
  {$warn 6018 off}
  {$endif}
{$endif}

uses
 templateeditor,
 msearrayutils,aboutform,plugmanager,fpg_iniutils_ideu,msetimer,mseformatstr,
 mseconsts_ide,dialogfiles,mseforms,mseguiglob,msegui,msegdbutils,mseactions,
 sak_mse,msefileutils,msedispwidgets,msedataedits,msestat,msestatfile,msemenus,
 msestockobjects,msebitmap,msegrids,msefiledialogx,msetypes,sourcepage,
 msedesignintf,msedesigner,Classes,mclasses,mseclasses,msegraphutils,typinfo,
 msedock,SysUtils,msesysenv,msemacros,msestrings,msepostscriptprinter,
 msegraphics,mseglob,msestream,msepointer,mseprocmonitorcomp,msesystypes,
 mserttistat,msedatalist,mselistbrowser,projecttreeform,msepipestream,
 msestringcontainer,msesys,mseedit,msewidgets,{$I useslang.inc};

const
  versiontext = '2.6.7';
  idecaption  = 'ideU';
  statname    = 'ideu';

type
  TDummyThread = class(TThread)
  protected
    procedure Execute; override;
  end;

  filekindty        = (fk_none, fk_source, fk_unit);
  messagetextkindty = (mtk_warning, mtk_flat, mtk_info, mtk_making,
    mtk_finished, mtk_error, mtk_signal, mtk_notok);

  startcommandty = (sc_none, sc_step, sc_continue);
  // formkindty = (fok_main,fok_simple,fok_dock,fok_data,fok_subform,
  //               fok_report,fok_script,fok_inherited);

  tmainfo = class(tdockform, idesignnotification)
    gdb: tgdbmi;
    filedisp: tstringdisp;
    linedisp: tintegerdisp;
    projectstatfile: tstatfile;
    reasondisp: tintegerdisp;
    expr: tstringedit;
    exprdisp: tstringdisp;
    symboltype: tstringedit;
    symboltypedisp: tstringdisp;
    mainstatfile: tstatfile;
    mainmenu1: tmainmenu;
    errordisp: tstringdisp;
    basedock: tdockpanel;

    openfile: tfiledialogx;

    vievmenuicons: timagelist;

    viewmenu: tframecomp;
    runprocmon: tprocessmonitor;
    statoptions: trttistat;
    projectfiledia: tfiledialogx;
    targetpipe: tpipereadercomp;
    openform: tfiledialogx;
    formbg: tbitmapcomp;
    tfacecomp1: tfacecomp;
    tfacecomp2: tfacecomp;
    tfacecomp3: tfacecomp;
    menuitemframe: tframecomp;
    mainmenuframe: tframecomp;
    convex: tfacecomp;
    concave: tfacecomp;
    tframecomp2: tframecomp;
    tframecomp3: tframecomp;
    convexdark: tfacecomp;
    concavedark: tfacecomp;
    ttimer1: ttimer;
    procedure newfileonexecute(const Sender: TObject);
    procedure newformonexecute(const Sender: TObject);

    procedure mainfooncreate(const Sender: TObject);
    procedure mainfoondestroy(const Sender: TObject);
    procedure mainstatfileonupdatestat(const Sender: TObject; const filer: tstatfiler);
    procedure mainfoonterminate(var terminate: Boolean);
    procedure mainonloaded(const Sender: TObject);

    procedure mainmenuonupdate(const Sender: tcustommenu);
    procedure onscale(const Sender: TObject);
    procedure parametersonexecute(const Sender: TObject);
    procedure buildactonexecute(const Sender: TObject);
    procedure saveprojectasonexecute(const Sender: TObject);
    procedure newprojectonexecute(const Sender: TObject);
    procedure closeprojectactonexecute(const Sender: TObject);
    procedure exitonexecute(const Sender: TObject);
    procedure newpanelonexecute(const Sender: TObject);

    procedure viewassembleronexecute(const Sender: TObject);
    procedure viewcpuonexecute(const Sender: TObject);
    procedure viewmessagesonexecute(const Sender: TObject);
    procedure viewsourceonexecute(const Sender: TObject);
    procedure viewbreakpointsonexecute(const Sender: TObject);
    procedure viewwatchesonexecute(const Sender: TObject);
    procedure viewstackonexecute(const Sender: TObject);
    procedure viewobjectinspectoronexecute(const Sender: TObject);
    procedure toggleobjectinspectoronexecute(const Sender: TObject);
    procedure viewcomponentpaletteonexecute(const Sender: TObject);
    procedure viewcomponentstoreonexecute(const Sender: TObject);
    procedure viewdebuggertoolbaronexecute(const Sender: TObject);
    procedure viewwatchpointsonexecute(const Sender: TObject);
    procedure viewthreadsonexecute(const Sender: TObject);
    procedure viewconsoleonexecute(const Sender: TObject);
    procedure viewfindresults(const Sender: TObject);
    procedure aboutonexecute(const Sender: TObject);
    procedure aboutfpguionexecute(const Sender: TObject);
    procedure aboutideuonexecute(const Sender: TObject);
    procedure configureexecute(const Sender: TObject);

    function closeallmodule(): Boolean;

    procedure setlang(thelang: string);

    //debugger
    procedure restartgdbonexecute(const Sender: TObject);
    procedure runexec(const Sender: TObject);
    procedure gdbonevent(const Sender: tgdbmi; var eventkind: gdbeventkindty; const values: resultinfoarty; const stopinfo: stopinfoty);
    procedure expronsetvalue(const Sender: TObject; var avalue: msestring; var accept: Boolean);
    procedure symboltypeonsetvalue(const Sender: TObject; var avalue: msestring; var accept: Boolean);
    procedure openprojectcopyexecute(const Sender: TObject);
    procedure saveprojectcopyexecute(const Sender: TObject);
    procedure newprojectfromprogramexe(const Sender: TObject);
    procedure newemptyprojectexe(const Sender: TObject);
    procedure viewmemoryonexecute(const Sender: TObject);
    procedure runprocdied(const Sender: TObject; const prochandle: prochandlety; const execresult: integer; const Data: Pointer);
    procedure statbefread(const Sender: TObject);
    procedure viewsymbolsonexecute(const Sender: TObject);
    procedure loadwindowlayoutexe(const Sender: TObject);
    procedure loadwindowlayout(const areader: tstatreader);
    procedure getstatobjs(const Sender: TObject; var aobjects: objectinfoarty);
    procedure targetpipeinput(const Sender: tpipereader);
    procedure mainstatbeforewriteexe(const Sender: TObject);
    procedure statafterread(const Sender: TObject);
    procedure basedockpaintexe(const Sender: twidget; const acanvas: tcanvas);

    //fred
    procedure dothemedialog();
    procedure dotheme(typetheme: integer);
    procedure picksdef(const Sender: TObject; var avalue: msestring; var accept: Boolean);
    procedure menuwindowlayoutexe(const Sender: TObject);
    procedure viewconffpguiexecute(const Sender: TObject);
    procedure viewconfmseguiexecute(const Sender: TObject);
    procedure viewconfcompilersexecute(const Sender: TObject);
    procedure viewconfdebuggersexecute(const Sender: TObject);
    procedure viewconfideuexecute(const Sender: TObject);
    procedure viewfpguidesigneronexecute(const Sender: TObject);
    procedure resetfpguidesigneronexecute(const Sender: TObject);
    procedure customcompile(const Sender: TObject);
    procedure customrun(const Sender: TObject);
    procedure runwithoutdebugger;
    procedure ideuwriteconfig;
    procedure ideureadconfig;
    procedure loadconfigform(const Sender: TObject);
    procedure onthetimer(const Sender: TObject);
    procedure syntaxdefload(const Sender: TObject);
    procedure copywordatcur(const Sender: TObject);
    procedure onresizemain(const Sender: TObject);
    procedure closeallmod(const Sender: TObject);
    procedure manfocreated(const Sender: TObject);
    procedure onbeauty(const Sender: TObject);
    procedure onclassic(const Sender: TObject);
    procedure ondark(const Sender: TObject);
    procedure ontoggleunitform(const Sender: TObject);

    procedure ontimersplash(const Sender: TObject);
    procedure onlang(const Sender: TObject);
    procedure onactiv(const Sender: TObject);

   procedure ontemplateeditor(const sender: TObject);
  private
    fstartcommand: startcommandty;
    fnoremakecheck: Boolean;
    fcurrent: Boolean;
    flastform: tcustommseform;
    flastdesignform: tcustommseform;
    fexecstamp: integer;
    fprojectname: filenamety;
    fcheckmodulelevel: integer;
    fgdbserverprocid: integer;
    fgdbserverexitcode: integer;
    fgdbservertimeout: longword;
    ftargetfilemodified: Boolean;
    frunningprocess: prochandlety;
    flayoutloading: Boolean;
    fstopinfo: stopinfoty;
    fgdbdownloaded: Boolean;
    procedure dorun;
    function runtarget: Boolean; //true if run possible
    procedure newproject(const fromprogram, empty: Boolean);
    procedure doshowform(const Sender: TObject);
    procedure setprojectname(aname: filenamety);
    //not const because of not refcounted widestrings
    procedure dofindmodulebyname(const amodule: pmoduleinfoty; const aname: string; var action: modalresultty);
    procedure dofindmodulebytype(const atypename: string);

    //idesignnotification
    procedure ItemDeleted(const ADesigner: IDesigner; const amodule: tmsecomponent; const AItem: TComponent);
    procedure ItemInserted(const ADesigner: IDesigner; const amodule: tmsecomponent; const AItem: TComponent);
    procedure ItemsModified(const ADesigner: IDesigner; const AItem: TObject);
    procedure componentnamechanging(const adesigner: idesigner; const amodule: tmsecomponent; const aitem: TComponent; const newname: string);
    procedure moduleclassnamechanging(const adesigner: idesigner; const amodule: tmsecomponent; const newname: string);
    procedure instancevarnamechanging(const adesigner: idesigner; const amodule: tmsecomponent; const newname: string);
    procedure SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections);
    procedure moduleactivated(const adesigner: idesigner; const amodule: tmsecomponent);
    procedure moduledeactivated(const adesigner: idesigner; const amodule: tmsecomponent);
    procedure moduledestroyed(const adesigner: idesigner; const amodule: tmsecomponent);
    procedure methodcreated(const adesigner: idesigner; const amodule: tmsecomponent; const aname: string; const atype: ptypeinfo);
    procedure methodnamechanged(const adesigner: idesigner; const amodule: tmsecomponent; const newname, oldname: string; const atypeinfo: ptypeinfo);
    procedure showobjecttext(const adesigner: idesigner; const afilename: filenamety; const backupcreated: Boolean);
    procedure closeobjecttext(const adesigner: idesigner; const afilename: filenamety; var cancel: Boolean);
    procedure beforefilesave(const adesigner: idesigner; const afilename: filenamety);
    procedure beforemake(const adesigner: idesigner; const maketag: integer; var abort: Boolean);
    procedure aftermake(const adesigner: idesigner; const exitcode: integer);

    function checksave: modalresultty;
    procedure unloadexec;
    procedure cleardebugdisp;
    procedure resetdebugdisp; //called before running debuggee
    procedure createprogramfile(const aname: filenamety);
    function copynewfile(const aname, newname: filenamety; const autoincrement: Boolean; const canoverwrite: Boolean; const macronames: array of msestring; const macrovalues: array of msestring): Boolean;
    //true if ok
    procedure createform(const aname: filenamety; const namebase: string; const ancestor: string);
    procedure removemodulemenuitem(const amodule: pmoduleinfoty);
    procedure uploadexe(const Sender: tguiapplication; var again: Boolean);
    procedure uploadcancel(const Sender: TObject);
    procedure gdbserverexe(const Sender: tguiapplication; var again: Boolean);
    //  function terminategdbserver(const force: Boolean): Boolean;
    procedure gdbservercancel(const Sender: TObject);
    procedure updatetargetenvironment;
    function needsdownload: Boolean;
    function candebug: Boolean; //run command empty or process attached
    procedure startconsole();
  public

    // fred
    ismodal: Boolean;
    themenr: integer;
    customoption: integer;
    setcompiler: integer;
    settypecompiler: integer;
    thetag: integer;
    factivedesignmodule: pmoduleinfoty;
    fprojectloaded: Boolean;
    errorformfilename: filenamety;
    constructor Create(aowner: TComponent); override;
    destructor Destroy; override;

    function terminategdbserver(const force: Boolean): Boolean;

    procedure designformactivated(const Sender: tcustommseform);
    procedure startgdb(const killserver: Boolean);
    function checkgdberror(aresult: gdbresultty): Boolean;
    function startgdbconnection(const attach: Boolean): Boolean;
    function loadexec(isattach: Boolean; const forcedownload: Boolean): Boolean; //true if ok
    procedure setstattext(const atext: msestring; const akind: messagetextkindty = mtk_info);
    procedure refreshstopinfo(const astopinfo: stopinfoty);
    procedure updatemodifiedforms;
    function checkremake(startcommand: startcommandty): Boolean;
    //true if running possible
    procedure resetstartcommand;
    procedure killtarget;
    procedure domake(atag: integer);

    /// fred
    procedure customdomake(aname: filenamety; acompiler: integer; acompilertag: integer; atag: integer);

    procedure targetfilemodified;
    function checksavecancel(const aresult: modalresultty): modalresultty;
    function closeall(const nosave: Boolean): Boolean; //false in cancel
    function closemodule(const amodule: pmoduleinfoty; const achecksave: Boolean; nocheckclose: Boolean = False): Boolean;
    function openproject(const aname: filenamety; const ascopy: Boolean = False): Boolean;
    procedure saveproject(aname: filenamety; const ascopy: Boolean = False);
    procedure savewindowlayout(const astream: ttextstream);
    procedure loadwindowlayout(const astream: ttextstream);

    procedure sourcechanged(const Sender: tsourcepage);
    function opensource(const filekind: filekindty; const addtoproject: Boolean; const aactivate: Boolean = True; const currentnode: tprojectnode = nil): Boolean;
    //true if filedialog not canceled
    function openformfile(const filename: filenamety; const ashow, aactivate, showsource, createmenu, skipexisting: Boolean): pmoduleinfoty;
    procedure createmodulemenuitem(const amodule: pmoduleinfoty);
    function formmenuitemstart: integer;
    procedure loadformbysource(const sourcefilename: filenamety);
    procedure loadsourcebyform(const formfilename: filenamety; const aactivate: Boolean = False);
    procedure checkbluedots;
    procedure updatesigsettings;
    procedure runtool(const Sender: TObject);

    procedure downloaded;
    procedure programfinished;
    procedure showfirsterror;
    procedure stackframechanged(const frameno: integer);
    procedure refreshframe;
    procedure toggleformunit;
    property projectname: filenamety read fprojectname;
    property lastform: tcustommseform read flastform;
    property execstamp: integer read fexecstamp;
    property stopinfo: stopinfoty read fstopinfo;
  end;

var
  mainfo: tmainfo;
  toogletag: Boolean = False;
  layoutbusy: Boolean = True;
  thetimer: TTimer;
  vaparam: Boolean = False;
  nodebugset: Boolean = False;
  isactivated: Boolean = False;
  MSEFallbacklang: string = '';
  theprojectname : string = '';
  thefilename: string = '';


procedure doassistive;

procedure sdefload(sdeffile: msestring);

procedure handleerror(const e: Exception; const Text: string);

implementation

uses
  conflang,
  splash,
  confmsegui,
  beauty,
  conffpgui,
  confcompiler,
  confideu,
  projectoptionsform,
  regwidgets,
  regeditwidgets,
  regdialogs,
  regfiledialogx,
  regkernel,
  regprinter,
  toolhandlermodule,
{$ifndef mse_no_math}
  regmath,
  regmm,
{$endif}
{$ifndef mse_no_db}
  regdb, regreport,
{$endif}
{$ifdef mse_with_ifi}
  regifi,{$ifdef mse_with_ifirem}regifirem,{$endif}
{$endif}
{$ifdef mse_with_pascalscript}
  regpascalscript,
{$endif}
{$ifdef mse_with_zeoslib}
  {$if fpc_fullversion >= 030100}
  regzeoslib,
  {$endif}
{$endif}
  regdesignutils,
  regsysutils,
  regcrypto,
  regserialcomm,
  regexperimental,
{$ifndef mse_no_deprecated}
  regdeprecated,
{$endif}
 {$ifdef morecomponents}
  {$include regcomponents.inc}
 {$endif}

  mseparser,
  msesysintf,
  memoryform,
  msedrawtext,
  main_mfm,
  sourceform,
  watchform,
  breakpointsform,
  stackform,
  guitemplates,
  make,
  msepropertyeditors,
  skeletons,
  msedatamodules,
  mseact,
  mseformdatatools,
  mseshapes,
  mseeditglob,
  findinfileform,
  formdesigner,
  sourceupdate,
  actionsmodule,
  programparametersform,
  objectinspector,
  msesysutils,
  cpuform,
  disassform,
  panelform,
  watchpointsform,
  threadsform,
  targetconsole,
  commandorform,
  componentpaletteform,
  componentstore,
  confdebugger,
  messageform,
  ideusettings,
  mseintegerenter,
  symbolform
 {$ifdef unix},
  mselibc {$endif}, //SIGRT*
  mseprocutils
 {$ifdef mse_dumpunitgroups}, dumpunitgroups{$endif};

 {$ifndef mse_allwarnings}
 {$if fpc_fullversion >= 030100}
  {$warn 5089 off}
  {$warn 5090 off}
  {$warn 5093 off}
  {$warn 6058 off}
 {$endif}
 {$if fpc_fullversion >= 030300}
  {$warn 6060 off}
  {$warn 6018 off}
  {$endif}
{$endif}

procedure TDummyThread.Execute;
begin
  FreeOnTerminate := True;
  Terminate;
end;

procedure handleerror(const e: Exception; const Text: string);
begin
  if Text <> '' then
    writestderr(Text + ' ' + e.message, True)
  else
    writestderr(e.message, True);
end;

procedure doassistive;
var
  thedir: msestring;
begin

  if (copy(confideufo.tesakitdir.Text, 1, 10) = '${IDEUDIR}') then
    thedir := utf8decode(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)))) +
      copy(confideufo.tesakitdir.Text, 11, length(confideufo.tesakitdir.Text) - 10)
  else
    thedir := confideufo.tesakitdir.Text;

  if vaparam = False then
  begin
    if SakIsEnabled() = False then
    begin
      if (MSEFallbackLang = '') or (MSEFallbackLang = 'en') then
        SakGreeting('Welcome to ide U !')
      else if (MSEFallbackLang = 'fr') then
        SakGreeting('Bienvenue chez ide U !')
      else if (MSEFallbackLang = 'es') then
        SakGreeting('Bienvenido a ide U !')
      else if (MSEFallbackLang = 'de') then
        SakGreeting('Willkommen bei ide U !')
      else if (MSEFallbackLang = 'ru') then
        SakGreeting('Добро пожаловать в ide U !')
      else if (MSEFallbackLang = 'pt') then
        SakGreeting('Bem-vindo ao ide U !');  

      if sakloadlib(thedir) = 0 then

        debuggerfo.assistive.face.image.alignment :=
          [al_stretchx, al_stretchy]

      else
        debuggerfo.assistive.face.image.alignment :=
          [al_grayed, al_stretchx, al_stretchy];
    end
    else
    begin
      sakunloadlib;
      debuggerfo.assistive.face.image.alignment :=
        [al_grayed, al_stretchx, al_stretchy];
    end;
  end
  else
  begin
    SakGreeting('Welcome with ideU !');
    if sakloadlib(thedir) = 0 then
      debuggerfo.assistive.face.image.alignment :=
        [al_stretchx, al_stretchy]
    else
      debuggerfo.assistive.face.image.alignment :=
        [al_grayed, al_stretchx, al_stretchy];
  end;

end;


{ tmainfo }

constructor tmainfo.Create(aowner: TComponent);
begin
  frunningprocess  := invalidprochandle;
  fgdbserverprocid := invalidprochandle;
  customoption     := 0;
  setcompiler      := 1;
  settypecompiler  := 1;

  inherited Create(aowner);
end;

destructor tmainfo.Destroy;
begin
  if SakIsEnabled = True then
    sakunloadlib;
  terminategdbserver(True);
  inherited;
end;

//common

procedure tmainfo.mainfooncreate(const Sender: TObject);
begin
   
  nozorderhandling := True;
  designer.ongetmodulenamefile :=
{$ifdef FPC}
    @
{$endif}
    dofindmodulebyname;
  designer.ongetmoduletypefile :=
{$ifdef FPC}
    @
{$endif}
    dofindmodulebytype;

  designer.objformat := of_fp;
  componentpalettefo.updatecomponentpalette(True);
  designnotifications.Registernotification(idesignnotification(self));
  watchfo.gdb        := gdb;
  breakpointsfo.gdb  := gdb;
  watchpointsfo.gdb  := gdb;
  stackfo.gdb        := gdb;
  threadsfo.gdb      := gdb;
  disassfo.gdb       := gdb;
  initprojectoptions;
  sourceupdate.init(designer);
{$ifndef mse_with_pascalscript}
  mainmenu1.menu.deleteitembynames(['file', 'newmse', 'form', 'pascform']);
{$endif}

  loadconfigform(Sender);

  // sakloadlib;
end;

procedure sdefload(sdeffile: msestring);
begin

  if han <> -1 then
    sourcefo.syntaxpainter.freedeffile(han);
  han := sourcefo.syntaxpainter.readdeffile(sdeffile);
  sourcefo.ActivePage.edit.setsyntaxdef(han);
  sourcefo.ActivePage.updatestatvalues;
end;

procedure tmainfo.syntaxdefload(const Sender: TObject);
begin

  if Assigned(sourcefo.ActivePage) then
  begin
   
     if not dialogfilesformcreated then
    dodialogfiles;

    dothemedialog();

  
    dialogfilesfo.tag := 0;

    thesdef := projectoptions.e.t.syntaxdeffiles[0];

    dialogfilesfo.Caption := projectoptionstext(po_syntaxdeffile);

    // 'Load a Syntax Definition File';

    dialogfilesfo.tbutton1.Caption := stockobjects.modalresulttext[mr_ok];
    dialogfilesfo.tbutton2.Caption := stockobjects.modalresulttext[mr_cancel];


    dialogfilesfo.list_files.path    := expandprmacros('${SYNTAXDEFDIR}');
    dialogfilesfo.list_files.mask    := '*.sdef';
    dialogfilesfo.selected_file.frame.Caption := projectoptionstext(po_syntaxdeffile);
    //     'Selected Syntax Definition File';
    // + dialogfilesfo.list_files.directory ;
    dialogfilesfo.selected_file.Text := '';

    if ismodal then
      dialogfilesfo.Show(True)
    else
    begin
      dialogfilesfo.Show;
      dialogfilesfo.bringtofront;
    end;

  end;
end;

procedure tmainfo.onthetimer(const Sender: TObject);
begin
  thetimer.Enabled := False;
  componentpalettefo.Close;
  objectinspectorfo.Close;
  if gINI.ReadBool('General', 'FirstLoad', True) then
  begin
    if thetimer.tag = 0 then
    begin
      thetimer.tag      := 1;
      thetimer.interval := 1000000;
      thetimer.Enabled  := True;
      activate;
      //visible := true;
    end
    else
    begin
      thetimer.Free;
      configureexecute(Sender);
      gINI.WriteBool('General', 'FirstLoad', False);
      activate;
    end;
  end
  else
    activate// closeallmodule();
{
with settingsfo do
begin
activate;
but_ok.execute;
end;
};

{$ifdef polydev}
top := 56 ;
 {$endif}

  debuggerfo.file_history.tag := 0;

  themenr := gINI.ReadInteger('theme', 'main', 0);
  dotheme(themenr);

  setstattext('Hello!', mtk_flat);

  confideufo.onchangefont;

  objectinspectorfo.Close;

  // splashfo.close;

end;

procedure tmainfo.loadconfigform(const Sender: TObject);
begin
  thetimer          := ttimer.Create(TComponent(Sender));
  thetimer.interval := 500000;
  thetimer.ontimer  := @onthetimer;
  thetimer.tag      := 0;
  thetimer.Enabled  := True;
end;


procedure tmainfo.ideureadconfig();
var
  libpath: msestring;
begin
  {$IFDEF Windows}
  libpath := utf8decode(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) +
    'plugin\designer_ext\designer_ext.exe');
    {$endif}

     {$IFDEF linux}
  libpath := utf8decode(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) +
    'plugin/designer_ext/designer_ext');
    {$endif}

    {$IFDEF freebsd}
     {$ifdef polydev}
  libpath := utf8decode('/usr/local/share/designer_ext/designer_ext');
    {$else}
  libpath := utf8decode(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) +
    'plugin/designer_ext/designer_ext');
    {$endif}
    {$endif}

  if gINI.ReadBool('Completion', 'proplist', False) = False then
  begin
    debuggerfo.properties_list.tag := 0;
    debuggerfo.properties_list.face.image.alignment :=
      [al_grayed, al_stretchx, al_stretchy];
    sourcefo.thetimer.Enabled      := False;
    sourcefo.hidesourcehint;
  end
  else
  begin
    debuggerfo.properties_list.tag := 1;
    debuggerfo.properties_list.face.image.alignment :=
      [al_stretchx, al_stretchy];

  end;

  conffpguifo.fpguidesigner.Value := utf8decode(gINI.ReadString('Path', 'designer_fpGUI', ansistring(libpath)));

  conffpguifo.ifloadfile.Value := gINI.ReadBool('ifloadfile', 'designer_fpGUI', True);
  conffpguifo.edfilename.Text  :=
    utf8decode(gINI.ReadString('edfilename', 'designer_fpGUI', '${FILENAME}'));

  conffpguifo.ifclose.Value := gINI.ReadBool('ifclose', 'designer_fpGUI', True);
  conffpguifo.edclose.Text  := utf8decode(gINI.ReadString('edclose', 'designer_fpGUI', 'closeall'));
  conffpguifo.ifshow.Value  := gINI.ReadBool('ifshow', 'designer_fpGUI', True);
  conffpguifo.edshow.Text   := utf8decode(gINI.ReadString('edshow', 'designer_fpGUI', 'showit'));
  conffpguifo.ifhide.Value  := gINI.ReadBool('ifhide', 'designer_fpGUI', True);
  conffpguifo.edhide.Text   := utf8decode(gINI.ReadString('edhide', 'designer_fpGUI', 'hideit'));
  conffpguifo.ifquit.Value  := gINI.ReadBool('ifquit', 'designer_fpGUI', True);
  conffpguifo.edquit.Text   := utf8decode(gINI.ReadString('edquit', 'designer_fpGUI', 'quit'));

  confcompilerfo.twinep1.Value := gINI.ReadBool('fpc', 'winep1', False);
  confcompilerfo.twinep2.Value := gINI.ReadBool('fpc', 'winep2', False);
  confcompilerfo.twinep3.Value := gINI.ReadBool('fpc', 'winep3', False);
  confcompilerfo.twinep5.Value := gINI.ReadBool('fpc', 'winep5', False);
  confcompilerfo.twinep6.Value := gINI.ReadBool('fpc', 'winep6', False);
  confcompilerfo.twinep7.Value := gINI.ReadBool('fpc', 'winep7', False);
  confcompilerfo.twinep8.Value := gINI.ReadBool('fpc', 'winep8', False);

 {$ifdef polydev}
  confcompilerfo.fpccompiler.Value :=
    utf8decode(gINI.ReadString('fpc', 'compiler1', '/usr/local/lib/fpc/3.0.0/ppcx64'));
  confcompilerfo.fpccompiler2.Value :=
    utf8decode(gINI.ReadString('fpc', 'compiler2', '/usr/local/lib/fpc/3.0.0/ppc386'));
  confcompilerfo.fpccompiler3.Value :=
    utf8decode(gINI.ReadString('fpc', 'compiler3', '/usr/local/lib/fpc/3.0.0/ppcx64_linux'));
  confcompilerfo.fpccompiler4.Value :=
    utf8decode(gINI.ReadString('fpc', 'compiler4', '/usr/local/lib/fpc/3.0.0/ppc386.exe'));
  confcompilerfo.twinep4.Value := gINI.ReadBool('fpc', 'winep4', True);
  confcompilerfo.fpccompiler5.Value :=
    utf8decode(gINI.ReadString('fpc', 'compiler5', '/usr/local/lib/fpc/3.0.0/ppc386_linux'));

  {$else}
  confcompilerfo.fpccompiler.Value  := utf8decode(gINI.ReadString('fpc', 'compiler1', 'fpc'));
  confcompilerfo.fpccompiler2.Value := utf8decode(gINI.ReadString('fpc', 'compiler2', ''));
  confcompilerfo.twinep4.Value      := gINI.ReadBool('fpc', 'winep4', False);
  confcompilerfo.fpccompiler3.Value := utf8decode(gINI.ReadString('fpc', 'compiler3', ''));
  confcompilerfo.fpccompiler4.Value := utf8decode(gINI.ReadString('fpc', 'compiler4', ''));
  {$endif}

  confcompilerfo.fpccompiler5.Value := utf8decode(gINI.ReadString('fpc', 'compiler5', ''));
  confcompilerfo.fpccompiler6.Value := utf8decode(gINI.ReadString('fpc', 'compiler6', ''));
  confcompilerfo.fpccompiler7.Value := utf8decode(gINI.ReadString('fpc', 'compiler7', ''));
  confcompilerfo.fpccompiler8.Value := utf8decode(gINI.ReadString('fpc', 'compiler8', ''));

  confcompilerfo.twinej1.Value := gINI.ReadBool('java', 'winej1', False);
  confcompilerfo.twinej2.Value := gINI.ReadBool('java', 'winej2', False);
  confcompilerfo.twinej3.Value := gINI.ReadBool('java', 'winej3', False);
  confcompilerfo.twinej4.Value := gINI.ReadBool('java', 'winej4', False);

  confcompilerfo.javacompiler.Value  := utf8decode(gINI.ReadString('java', 'compiler1', 'javac'));
  confcompilerfo.javacompiler2.Value := utf8decode(gINI.ReadString('java', 'compiler2', ''));
  confcompilerfo.javacompiler3.Value := utf8decode(gINI.ReadString('java', 'compiler3', ''));
  confcompilerfo.javacompiler4.Value := utf8decode(gINI.ReadString('java', 'compiler4', ''));

  confcompilerfo.twinec1.Value := gINI.ReadBool('C', 'winec1', False);
  confcompilerfo.twinec2.Value := gINI.ReadBool('C', 'winec2', False);
  confcompilerfo.twinec3.Value := gINI.ReadBool('C', 'winec3', False);
  confcompilerfo.twinec4.Value := gINI.ReadBool('C', 'winec4', False);
  confcompilerfo.twinec5.Value := gINI.ReadBool('C', 'winec5', False);
  confcompilerfo.twinec6.Value := gINI.ReadBool('C', 'winec6', False);
  confcompilerfo.twinec7.Value := gINI.ReadBool('C', 'winec7', False);
  confcompilerfo.twinec8.Value := gINI.ReadBool('C', 'winec8', False);

  confcompilerfo.ccompiler.Value  := utf8decode(gINI.ReadString('C', 'compiler1', ''));
  confcompilerfo.ccompiler2.Value := utf8decode(gINI.ReadString('C', 'compiler2', ''));
  confcompilerfo.ccompiler3.Value := utf8decode(gINI.ReadString('C', 'compiler3', ''));
  confcompilerfo.ccompiler4.Value := utf8decode(gINI.ReadString('C', 'compiler4', ''));
  confcompilerfo.ccompiler5.Value := utf8decode(gINI.ReadString('C', 'compiler5', ''));
  confcompilerfo.ccompiler6.Value := utf8decode(gINI.ReadString('C', 'compiler6', ''));
  confcompilerfo.ccompiler7.Value := utf8decode(gINI.ReadString('C', 'compiler7', ''));
  confcompilerfo.ccompiler8.Value := utf8decode(gINI.ReadString('C', 'compiler8', ''));

  confcompilerfo.twinepy1.Value := gINI.ReadBool('python', 'winepy1', False);
  confcompilerfo.twinepy2.Value := gINI.ReadBool('python', 'winepy2', False);
  confcompilerfo.twinepy3.Value := gINI.ReadBool('python', 'winepy3', False);
  confcompilerfo.twinepy4.Value := gINI.ReadBool('python', 'winepy4', False);

  confcompilerfo.pythoncompiler.Value  := utf8decode(gINI.ReadString('python', 'compiler1', ''));
  confcompilerfo.pythoncompiler2.Value := utf8decode(gINI.ReadString('python', 'compiler2', ''));
  confcompilerfo.pythoncompiler3.Value := utf8decode(gINI.ReadString('python', 'compiler3', ''));
  confcompilerfo.pythoncompiler4.Value := utf8decode(gINI.ReadString('python', 'compiler4', ''));

  confcompilerfo.twineo1.Value := gINI.ReadBool('other', 'wineo1', False);
  confcompilerfo.twineo2.Value := gINI.ReadBool('other', 'wineo2', False);
  confcompilerfo.twineo3.Value := gINI.ReadBool('other', 'wineo3', False);
  confcompilerfo.twineo4.Value := gINI.ReadBool('other', 'wineo4', False);

  confcompilerfo.othercompiler.Value  := utf8decode(gINI.ReadString('other', 'compiler1', ''));
  confcompilerfo.othercompiler2.Value := utf8decode(gINI.ReadString('other', 'compiler2', ''));
  confcompilerfo.othercompiler3.Value := utf8decode(gINI.ReadString('other', 'compiler3', ''));
  confcompilerfo.othercompiler4.Value := utf8decode(gINI.ReadString('other', 'compiler4', ''));

  confdebuggerfo.debugger1.Value := utf8decode(gINI.ReadString('debug', 'debugger1', ''));
  confdebuggerfo.debugger2.Value := utf8decode(gINI.ReadString('debug', 'debugger2', ''));
  confdebuggerfo.debugger3.Value := utf8decode(gINI.ReadString('debug', 'debugger3', ''));
  confdebuggerfo.debugger4.Value := utf8decode(gINI.ReadString('debug', 'debugger4', ''));

  conffpguifo.enablefpguidesigner.Value :=
    gINI.Readbool('Integration', 'designer_fpGUI', True);
  conffpguifo.tbfpgonlyone.Value        :=
    gINI.Readbool('RunOnlyOnce', 'designer_fpGUI', True);

  confideufo.modaldial.Value := gINI.Readbool('modaldial', 'general', True);

  ismodal := confideufo.modaldial.Value;

  confideufo.nozorderenable.Value := gINI.Readbool('nozorder', 'general', True);

  confideufo.brepaintcanvas.Value := gINI.Readbool('repaintcanvas', 'general', False);
  //mse_repaintcanvas := confideufo.brepaintcanvas.Value ;

  noconfirmdelete := gINI.Readbool('noconfirmdel', 'general', False);
  confideufo.confirmdel.Value := noconfirmdelete;

  blinkingcaret := gINI.Readbool('blinkingcaret', 'general', True);
  confideufo.blinkcaret.Value := blinkingcaret;

  confideufo.universal_path.Value := gINI.Readbool('universaldir', 'general', False);

  confideufo.autofocus_menu.Value := gINI.Readbool('autofocusmenu', 'general', False);

  //  confideufo.key_accelerator.Value := gINI.Readbool('keyaccelerator', 'general', True);

  confideufo.fullpath.Value := gINI.Readbool('fullpath', 'general', True);

  confideufo.dirlayout(nil);

  confideufo.doubleclic.Value := gINI.ReadBool('2xclick', 'sourcepage', False);

  confideufo.addwhiteaftercomma.Value :=
    gINI.Readbool('addwhiteaftercomma', 'editor', False);

  confideufo.usedefaulteditoroptions.Value :=
    gINI.Readbool('usedefaulteditoroptions', 'editor', False);

  confideufo.blockindent.Value := gINI.ReadInteger('blockindent', 'editor', 1);

  confideufo.tabindent.Value := gINI.Readbool('tabindent', 'editor', False);

  confideufo.tabstops.Value := gINI.ReadInteger('tabstops', 'editor', 4);

  confideufo.spacetabs.Value := gINI.Readbool('spacetabs', 'editor', False);

  confideufo.fontsize.Value := gINI.ReadInteger('fontsize', 'system', 12);

  confideufo.fontname.Value := utf8decode(gINI.Readstring('fontname', 'system', 'stf_default'));

  // confideufo.onchangefont;

  confideufo.trimtrailingwhitespace.Value :=
    gINI.Readbool('trimtrailingwhitespace', 'editor', False);

  confideufo.rightmarginchars.Value :=
    gINI.ReadInteger('rightmarginchars', 'editor', 80);

  confideufo.closemessages.Value := gINI.Readbool('closemessages', 'message', False);

  confideufo.colorerror.Value :=
    gINI.ReadInt64('colorerror', 'message', 2684354579);

  confideufo.colorwarning.Value :=
    gINI.ReadInt64('colorwarning', 'message', 2684354584);

  confideufo.colornote.Value :=
    gINI.ReadInt64('colornote', 'message', 2684354580);
    
   confideufo.colorhint.Value :=
    gINI.ReadInt64('colorhint', 'message', $E6EDFF);
 
  confideufo.encoding.Value := gINI.ReadInteger('encoding', 'editor', 0);

  confideufo.backupfilecount.Value := gINI.ReadInteger('backupfilecount', 'editor', 0);

  if confideufo.nozorderenable.Value = True then
    nozorderhandling := True
  else
    nozorderhandling := False;

  // nostaticgravity:= true;

  libpath := utf8decode(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))));

  confideufo.deflayout.Text :=
    utf8decode(gINI.ReadString('Layout', 'default', ansistring(libpath) + directoryseparator +
    'layout' + directoryseparator + 'Dock_Commandor_Tree_Editor_Message.prj'));

  if not fileexists(confideufo.deflayout.Text) then
    confideufo.deflayout.Text := (libpath) + directoryseparator +
      'layout' + directoryseparator + 'Dock_Commandor_Tree_Editor_Message.prj';

  confideufo.deflayout.Value        := confideufo.deflayout.Text;
  confideufo.deflayout.valuedefault := confideufo.deflayout.Text;

  confideufo.defsynt.Text :=
    utf8decode(gINI.ReadString('Syntax', 'default', ansistring(libpath) + directoryseparator +
    'syntaxdefs' + directoryseparator + 'pascal_ideu.sdef'));
    
    

  if not fileexists(confideufo.defsynt.Text) then
    confideufo.defsynt.Text := (libpath) + directoryseparator +
      'syntaxdefs' + directoryseparator + 'pascal_ideu.sdef';

  confideufo.defsynt.Value        := confideufo.defsynt.Text;
  confideufo.defsynt.valuedefault := confideufo.defsynt.Text;

  confideufo.rectanglearea.Value := gINI.Readbool('rectanglearea', 'editor', False);


     {$ifdef windows}
  confideufo.tesakitdir.Text :=
    utf8decode(gINI.ReadString('Assistive', 'sakitdir', ansistring(libpath) + 'plugin\'));

           {$else}
         {$ifdef polydev}
  confideufo.tesakitdir.Text :=
    utf8decode(gINI.ReadString('Assistive', 'sakitdir', '/usr/local/share/'));
    {$else}
  confideufo.tesakitdir.Text := utf8decode(gINI.ReadString('Assistive', 'sakitdir', ansistring(libpath) + 'plugin/'));
       {$endif}
         {$endif}

  confideufo.tbassistive.Value := gINI.Readbool('Assistive', 'sak', False);


  if trim(ParamStr(1)) = '-va' then
  begin
    vaparam := True;
    confideufo.tbassistive.Value := True;
    debuggerfo.assistive.face.image.alignment :=
      [al_stretchx, al_stretchy];

  end;

  if confideufo.tbassistive.Value = True then
    doassistive;

  case gINI.ReadInteger('General', 'WarnChange', 2) of
    0:
    begin
      confideufo.tbfilereload.Value  := True;
      confideufo.tbfilenoload.Value  := False;
      confideufo.tbfileaskload.Value := False;
    end;
    1:
    begin
      confideufo.tbfilenoload.Value  := True;
      confideufo.tbfilereload.Value  := False;
      confideufo.tbfileaskload.Value := False;
    end;
    2:
    begin
      confideufo.tbfileaskload.Value := True;
      confideufo.tbfilereload.Value  := False;
      confideufo.tbfilenoload.Value  := False;
    end;
  end;

  {$ifdef linux}
  if conffpguifo.enablefpguidesigner.Value = True then
  begin
    CleanfpgDesigner();
    sleep(250);
  end;
   {$endif}

end;

procedure tmainfo.ideuwriteconfig();
begin
  gINI.writeString('Path', 'designer_fpGUI', ansistring(conffpguifo.fpguidesigner.Value));

  gINI.writeString('Layout', 'default', ansistring(confideufo.deflayout.Text));

  gINI.writeString('Syntax', 'default', ansistring(confideufo.defsynt.Text));
  
  
  gINI.writebool('rectanglearea', 'editor', (confideufo.rectanglearea.Value));

  gINI.writebool('Integration', 'designer_fpGUI',
    (conffpguifo.enablefpguidesigner.Value));
  gINI.writebool('RunOnlyOnce', 'designer_fpGUI', (conffpguifo.tbfpgonlyone.Value));

  gINI.writeBool('ifloadfile', 'designer_fpGUI', (conffpguifo.ifloadfile.Value));
  gINI.writeString('edfilename', 'designer_fpGUI', ansistring(conffpguifo.edfilename.Text));

  gINI.writeBool('ifclose', 'designer_fpGUI', (conffpguifo.ifclose.Value));
  gINI.writeString('edclose', 'designer_fpGUI', ansistring(conffpguifo.edclose.Text));

  gINI.writeBool('ifshow', 'designer_fpGUI', (conffpguifo.ifshow.Value));
  gINI.writeString('edshow', 'designer_fpGUI', ansistring(conffpguifo.edshow.Text));

  gINI.writeBool('2xclick', 'sourcepage', (confideufo.doubleclic.Value));

  gINI.writeBool('addwhiteaftercomma', 'editor', (confideufo.addwhiteaftercomma.Value));

  gINI.writeBool('usedefaulteditoroptions', 'editor',
    (confideufo.usedefaulteditoroptions.Value));

  gINI.WriteInteger('blockindent', 'editor', (confideufo.blockindent.Value));

  gINI.writeBool('tabindent', 'editor', (confideufo.tabindent.Value));

  gINI.WriteInteger('tabstops', 'editor', (confideufo.tabstops.Value));

  gINI.writeBool('spacetabs', 'editor', (confideufo.spacetabs.Value));

  gINI.writeBool('trimtrailingwhitespace', 'editor',
    (confideufo.trimtrailingwhitespace.Value));

  gINI.WriteInteger('rightmarginchars', 'editor', (confideufo.rightmarginchars.Value));

  gINI.writebool('closemessages', 'message', (confideufo.closemessages.Value));

  gINI.Writeint64('colorerror', 'message', (confideufo.colorerror.Value));

  gINI.WriteInteger('fontsize', 'system', (confideufo.fontsize.Value));

  gINI.writeString('fontname', 'system', ansistring(confideufo.fontname.Value));

  gINI.Writeint64('colorwarning', 'message', (confideufo.colorwarning.Value));

  gINI.Writeint64('colornote', 'message', (confideufo.colornote.Value));
  
   gINI.Writeint64('colorhint', 'message', (confideufo.colorhint.Value));

  gINI.WriteInteger('encoding', 'editor', (confideufo.encoding.Value));

  gINI.WriteInteger('backupfilecount', 'editor', (confideufo.backupfilecount.Value));

  gINI.writebool('noconfirmdel', 'general', (noconfirmdelete));

  gINI.writebool('blinkingcaret', 'general', (blinkingcaret));

  gINI.writebool('nozorder', 'general', (confideufo.nozorderenable.Value));

  gINI.writebool('repaintcanvas', 'general', (confideufo.brepaintcanvas.Value));

  gINI.writebool('modaldial', 'general', confideufo.modaldial.Value);

  if debuggerfo.properties_list.tag = 0 then
    gINI.writebool('Completion', 'proplist', False)
  else
    gINI.writebool('Completion', 'proplist', True);

  gINI.writebool('Assistive', 'sak', (confideufo.tbassistive.Value));
  gINI.writeString('Assistive', 'sakitdir', ansistring(confideufo.tesakitdir.Text));

  gINI.writebool('universaldir', 'general', (confideufo.universal_path.Value));

  //  gINI.writebool('keyaccelerator', 'general', ansistring(confideufo.key_accelerator.Value));

  gINI.writebool('addwhiteaftercomma', 'general', (confideufo.addwhiteaftercomma.Value));

  gINI.writebool('fullpath', 'general', (confideufo.fullpath.Value));

  gINI.writebool('autofocusmenu', 'general', (confideufo.autofocus_menu.Value));

  gINI.writeBool('ifhide', 'designer_fpGUI', (conffpguifo.ifhide.Value));
  gINI.writeString('edhide', 'designer_fpGUI', ansistring(conffpguifo.edhide.Text));

  gINI.writeBool('ifquit', 'designer_fpGUI', (conffpguifo.ifquit.Value));
  gINI.writeString('edquit', 'designer_fpGUI', ansistring(conffpguifo.edquit.Text));

  gINI.writeBool('fpc', 'winep1', (confcompilerfo.twinep1.Value));
  gINI.writeBool('fpc', 'winep2', (confcompilerfo.twinep2.Value));
  gINI.writeBool('fpc', 'winep3', (confcompilerfo.twinep3.Value));
  gINI.writeBool('fpc', 'winep4', (confcompilerfo.twinep4.Value));
  gINI.writeBool('fpc', 'winep5', (confcompilerfo.twinep5.Value));
  gINI.writeBool('fpc', 'winep6', (confcompilerfo.twinep6.Value));
  gINI.writeBool('fpc', 'winep7', (confcompilerfo.twinep7.Value));
  gINI.writeBool('fpc', 'winep8', (confcompilerfo.twinep8.Value));

  gINI.writeString('fpc', 'compiler1', ansistring(confcompilerfo.fpccompiler.Value));
  gINI.writeString('fpc', 'compiler2', ansistring(confcompilerfo.fpccompiler2.Value));
  gINI.writeString('fpc', 'compiler3', ansistring(confcompilerfo.fpccompiler3.Value));
  gINI.writeString('fpc', 'compiler4', ansistring(confcompilerfo.fpccompiler4.Value));
  gINI.writeString('fpc', 'compiler5', ansistring(confcompilerfo.fpccompiler5.Value));
  gINI.writeString('fpc', 'compiler6', ansistring(confcompilerfo.fpccompiler6.Value));
  gINI.writeString('fpc', 'compiler7', ansistring(confcompilerfo.fpccompiler7.Value));
  gINI.writeString('fpc', 'compiler8', ansistring(confcompilerfo.fpccompiler8.Value));

  gINI.writeBool('java', 'winej1', (confcompilerfo.twinej1.Value));
  gINI.writeBool('java', 'winej2', (confcompilerfo.twinej2.Value));
  gINI.writeBool('java', 'winej3', (confcompilerfo.twinej3.Value));
  gINI.writeBool('java', 'winej4', (confcompilerfo.twinej4.Value));

  gINI.writeString('java', 'compiler1', ansistring(confcompilerfo.javacompiler.Value));
  gINI.writeString('java', 'compiler2', ansistring(confcompilerfo.javacompiler2.Value));
  gINI.writeString('java', 'compiler3', ansistring(confcompilerfo.javacompiler3.Value));
  gINI.writeString('java', 'compiler4', ansistring(confcompilerfo.javacompiler4.Value));

  gINI.writeBool('C', 'winec1', (confcompilerfo.twinec1.Value));
  gINI.writeBool('C', 'winec2', (confcompilerfo.twinec2.Value));
  gINI.writeBool('C', 'winec3', (confcompilerfo.twinec3.Value));
  gINI.writeBool('C', 'winec4', (confcompilerfo.twinec4.Value));
  gINI.writeBool('C', 'winec5', (confcompilerfo.twinec5.Value));
  gINI.writeBool('C', 'winec6', (confcompilerfo.twinec6.Value));
  gINI.writeBool('C', 'winec7', (confcompilerfo.twinec7.Value));
  gINI.writeBool('C', 'winec8', (confcompilerfo.twinec8.Value));

  gINI.writeString('C', 'compiler1', ansistring(confcompilerfo.ccompiler.Value));
  gINI.writeString('C', 'compiler2', ansistring(confcompilerfo.ccompiler2.Value));
  gINI.writeString('C', 'compiler3', ansistring(confcompilerfo.ccompiler3.Value));
  gINI.writeString('C', 'compiler4', ansistring(confcompilerfo.ccompiler4.Value));
  gINI.writeString('C', 'compiler5', ansistring(confcompilerfo.ccompiler5.Value));
  gINI.writeString('C', 'compiler6', ansistring(confcompilerfo.ccompiler6.Value));
  gINI.writeString('C', 'compiler7', ansistring(confcompilerfo.ccompiler7.Value));
  gINI.writeString('C', 'compiler8', ansistring(confcompilerfo.ccompiler8.Value));

  gINI.writeBool('python', 'winepy1', (confcompilerfo.twinepy1.Value));
  gINI.writeBool('python', 'winepy2', (confcompilerfo.twinepy2.Value));
  gINI.writeBool('python', 'winepy3', (confcompilerfo.twinepy3.Value));
  gINI.writeBool('python', 'winepy4', (confcompilerfo.twinepy4.Value));

  gINI.writeString('python', 'compiler1', ansistring(confcompilerfo.pythoncompiler.Value));
  gINI.writeString('python', 'compiler2', ansistring(confcompilerfo.pythoncompiler2.Value));
  gINI.writeString('python', 'compiler3', ansistring(confcompilerfo.pythoncompiler3.Value));
  gINI.writeString('python', 'compiler4', ansistring(confcompilerfo.pythoncompiler4.Value));

  gINI.writeBool('other', 'wineo1', (confcompilerfo.twineo1.Value));
  gINI.writeBool('other', 'wineo2', (confcompilerfo.twineo2.Value));
  gINI.writeBool('other', 'wineo3', (confcompilerfo.twineo3.Value));
  gINI.writeBool('other', 'wineo4', (confcompilerfo.twineo4.Value));

  gINI.writeString('other', 'compiler1', ansistring(confcompilerfo.othercompiler.Value));
  gINI.writeString('other', 'compiler2', ansistring(confcompilerfo.othercompiler2.Value));
  gINI.writeString('other', 'compiler3', ansistring(confcompilerfo.othercompiler3.Value));
  gINI.writeString('other', 'compiler4', ansistring(confcompilerfo.othercompiler4.Value));

  gINI.writeString('debug', 'debugger1', ansistring(confdebuggerfo.debugger1.Value));
  gINI.writeString('debug', 'debugger2', ansistring(confdebuggerfo.debugger2.Value));
  gINI.writeString('debug', 'debugger3', ansistring(confdebuggerfo.debugger3.Value));
  gINI.writeString('debug', 'debugger4', ansistring(confdebuggerfo.debugger4.Value));

  gINI.writeInteger('theme', 'main', themenr);

  if confideufo.tbfilereload.Value = True then
    gINI.WriteInteger('General', 'WarnChange', 0)
  else if confideufo.tbfilenoload.Value = True then
    gINI.WriteInteger('General', 'WarnChange', 1)
  else
    gINI.WriteInteger('General', 'WarnChange', 2);

  if (conffpguifo.enablefpguidesigner.Value = True) and
    (conffpguifo.ifquit.Value = True) then
    LoadfpgDesigner(ansistring(conffpguifo.edquit.Text));

end;

procedure tmainfo.mainfoondestroy(const Sender: TObject);
begin
  if SakIsEnabled = True then
    sakunloadlib;
  designnotifications.unRegisternotification(idesignnotification(self));
  abortmake;
  abortdownload;
  sourceupdate.deinit(designer);
  ideuwriteconfig();
end;

procedure tmainfo.dofindmodulebyname(const amodule: pmoduleinfoty; const aname: string; var action: modalresultty);
var
  wstr2: msestring;

  function dofind(const modulenames: array of msestring; const modulefilenames: array of filenamety): Boolean;
  var
    int1: integer;
    wstr1: msestring;
    po1: pmoduleinfoty;
  begin
    Result   := False;
    for int1 := 0 to high(modulenames) do
      if modulenames[int1] = wstr2 then
      begin
        if int1 <= high(modulefilenames) then
          if findfile(modulefilenames[int1], projectoptions.d.texp.sourcedirs, wstr1) or
            findfile(filename(modulefilenames[int1]),
            projectoptions.d.texp.sourcedirs, wstr1) then
            try
              po1    := openformfile(wstr1, False, False, False, False, False);
              Result := (po1 <> nil) and (utf8decode(struppercase(po1^.instancevarname)) = (wstr2));
            except
              application.handleexception;
              Result := False;
            end;
        break;
      end;
  end;

var
  bo1: Boolean;
  int1: integer;
  mstr1: filenamety;
begin
  wstr2 := utf8decode(struppercase(aname));
  int1  := findchar(wstr2, '.');
  if int1 > 0 then
    setlength(wstr2, int1 - 1)//main name only
  ;
  with projectoptions do
    bo1    := dofind(o.modulenames, o.modulefiles);
  if not bo1 and projecttree.units.findformbyname(ansistring(wstr2), mstr1) then
    bo1    := dofind([wstr2], [mstr1]);
  if bo1 then
    action := mr_ok
  else
  begin
    action := ShowMessage(mainformtext(ma_unresreferences) + ' ' + utf8decode(amodule^.moduleclassname) + ' ' +
      mainformtext(ma_str_to) + ' ' + utf8decode(aname) +
      '.' + lineend + ' ' + mainformtext(ma_wishsearch), mainformtext(ma_warning),
      [mr_ok, mr_cancel], mr_ok);
    case action of
      mr_ok:
      begin
        wstr2 := '';
        //    openform.controller.filename:= '';
        //    openform.controller.captionopen:= c[ord(formfile)]+' '+ aname;
        openform.controller.showoptions := True;
        if openform.controller.Execute(wstr2, fdk_open,
          mainformtext(ma_formfile) + ' ' + utf8decode(aname)) then
          openformfile(wstr2, False, False, True, True, False)//    action:= filedialog(wstr2,[fdo_checkexist],c[ord(formfile)]+' '+ aname,
        //                 [c[ord(formfiles)]],['*.mfm'],'',nil,nil,nil,[fa_all],[fa_hidden]);
        //                 //defaultvalues don't work on kylix
        //    if action = mr_ok then begin
        //     openformfile(openform.controller.filename,false,false,true,true,false);
        ;
      end;
    end;
  end;
end;

procedure tmainfo.dofindmodulebytype(const atypename: string);
var
  wstr2: msestring;
  int1: integer;
  po1: pmoduleinfoty;

  procedure checkmodule(fname: filenamety);
  var
    wstr1: filenamety;
  begin
    with projectoptions do
      if findfile(fname, d.texp.sourcedirs, wstr1) or
        findfile(fname, d.texp.sourcedirs, wstr1) then
        try
          po1 := openformfile(wstr1, False, False, False, False, False);
        except
          on e: eabort do
          begin
            raise;
          end
          else
          begin
            po1 := nil;


            application.handleexception;
          end;
        end;
  end;

var
  // ar1: msestringarty;
  mstr1: filenamety;
begin
  // ar1:= nil; //compilerwarning
  if fcheckmodulelevel >= 16 then
  begin
    ShowMessage(mainformtext(ma_recursive) + utf8decode(atypename) + '"', mainformtext(ma_error));
    SysUtils.abort;
  end;
  Inc(fcheckmodulelevel);
  try
    with projectoptions do
    begin
      po1   := nil;
      wstr2 := utf8decode(struppercase(atypename));
      for int1 := 0 to high(o.moduletypes) do
        if o.moduletypes[int1] = wstr2 then
        begin
          if int1 <= high(o.modulefiles) then
            checkmodule(o.modulefiles[int1]);
          break;
        end;
    end;
    if po1 = nil then
      if projecttree.units.findformbyclass(ansistring(wstr2), mstr1) then
        checkmodule(mstr1){
   ar1:= projecttree.units.moduleclassnames;
   for int1:= 0 to high(ar1) do begin
    if ar1[int1] = wstr2 then begin
     checkmodule(projecttree.units.modulefilenames[int1]);
     break;
    end;
   end;
   };
    if (po1 = nil) or (stringicomp(po1^.moduleclassname, atypename) <> 0) then
      if ShowMessage(mainformtext(ma_str_classtype) + ' ' + utf8decode(atypename) + ' ' +
        mainformtext(ma_notfound) + lineend +
        ' ' + mainformtext(ma_wishsearch), mainformtext(ma_warning),
        [mr_yes, mr_cancel]) = mr_yes then
      begin
        wstr2 := '';
        openform.controller.showoptions := True;

        if openform.controller.Execute(wstr2, fdk_open, mainformtext(ma_formfile) + ' ' +
          msestring(atypename), [fdo_checkexist]) then
          openformfile(wstr2, False, False, False, False, False);
      end;
  finally
    Dec(fcheckmodulelevel);
  end;
end;

 //editor
 //formdesigner


procedure Tmainfo.doshowform(const Sender: TObject);
begin
  with tmenuitem(Sender) do
    designer.showformdesigner(pmoduleinfoty(tagpo));
end;

procedure tmainfo.toggleobjectinspectoronexecute(const Sender: TObject);
begin
  if (flastform = objectinspectorfo) then
  begin
    if flastdesignform <> nil then
      flastdesignform.activate(True);
  end
  else
    objectinspectorfo.activate(True)// objectinspectorfo.font.height := confideufo.fontsize.value;
  // objectinspectorfo.grid.datarowheight := round(ratio * 16);
  ;
end;

procedure tmainfo.viewobjectinspectoronexecute(const Sender: TObject);
begin

  objectinspectorfo.activate(True);
  //  objectinspectorfo.font.height := confideufo.fontsize.value;
  //  objectinspectorfo.grid.datarowheight := round(ratio * 16);
end;

//idesignnotification

procedure Tmainfo.ItemDeleted(const ADesigner: IDesigner; const amodule: tmsecomponent; const AItem: TComponent);
begin

end;

procedure Tmainfo.ItemInserted(const ADesigner: IDesigner; const amodule: tmsecomponent; const AItem: TComponent);
begin
  componentpalettefo.resetselected;
end;

procedure tmainfo.moduleactivated(const adesigner: idesigner; const amodule: tmsecomponent);
begin
  factivedesignmodule := designer.actmodulepo;
  setlinkedvar(factivedesignmodule^.designform, tmsecomponent(flastdesignform));
end;

procedure tmainfo.moduledeactivated(const adesigner: idesigner; const amodule: tmsecomponent);
begin
  // factivedesignmodule:= nil;
end;

{
procedure tmainfo.sourceformactivated;
begin
 factivedesignmodule:= nil;
end;
}
function tmainfo.checksave: modalresultty;
var
  str1: filenamety;
begin
  Result := sourcefo.saveall(False);
  if Result <> mr_cancel then
  begin
    Result := designer.saveall(Result = mr_all, True);
    if Result <> mr_cancel then
    begin
      Result := componentstorefo.saveall(False);
      if Result <> mr_cancel then
        with projectoptions, o, texp do
          if modified and not savechecked then
          begin
            with stockobjects do
              Result := ShowMessage(captions[sc_project] + ' ' + fprojectname + ' ' +
                captions[sc_is_modified_save], captions[sc_Confirmation],
                [mr_yes, mr_no, mr_cancel], mr_yes);

            if Result = mr_yes then
            begin
              if projectfilename = '' then
              begin
                Result   := projectfiledialog(str1, True);
                if Result <> mr_ok then
                  Result := mr_cancel;
              end
              else
              begin
                str1 := projectfilename;
              end;
              if Result <> mr_cancel then
                saveproject(str1);
            end
            else
            begin
              if Result <> mr_no then
                Result  := mr_cancel;
            end;
            savechecked := True;
          end
          else
            saveproject(projectfilename);
    end;
  end;

  checksavecancel(Result);
end;

procedure tmainfo.updatemodifiedforms;
var
  int1: integer;
begin
  // with mainmenu1.menu.itembyname('view') do begin
  with mainmenu1.menu.itembynames(['widgets', 'msegui', 'msemod']) do
    for int1 := itembyname('formmenuitemstart').index + 1 to Count - 1 do
      with items[int1] do
        with pmoduleinfoty(tagpo)^ do
        begin
          if modified then
            Caption := '*' + msefileutils.filename(filename)
          else
            Caption := msefileutils.filename(filename);
          if (designform is tformdesignerfo) and designform.Visible then
            tformdesignerfo(designform).updatecaption;
        end;
end;

procedure Tmainfo.ItemsModified(const ADesigner: IDesigner; const AItem: TObject);
begin
  updatemodifiedforms;
  sourcechanged(nil);
end;

procedure tmainfo.componentnamechanging(const adesigner: idesigner; const amodule: tmsecomponent; const aitem: TComponent; const newname: string);
begin
  //dummy
end;

procedure tmainfo.moduleclassnamechanging(const adesigner: idesigner; const amodule: tmsecomponent; const newname: string);
begin
  //dummy
end;

procedure tmainfo.instancevarnamechanging(const adesigner: idesigner; const amodule: tmsecomponent; const newname: string);
begin
end;

procedure Tmainfo.SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections);
begin
  if (aselection.Count > 0) and (factivedesignmodule <> nil) then
    if not objectinspectorfo.active then
      objectinspectorfo.window.stackunder(factivedesignmodule^.designform.window)//  objectinspectorfo.bringtofront;
  // objectinspectorfo.show;
  // objectinspectorfo.activate;
  ;
end;

// fred
procedure tmainfo.picksdef(const Sender: TObject; var avalue: msestring; var accept: Boolean);
begin
  sdefload(avalue);
end;

//debugger

procedure tmainfo.expronsetvalue(const Sender: TObject; var avalue: msestring; var accept: Boolean);
var
  expres: string;
begin
  gdb.evaluateexpression(ansistring(avalue), expres);
  exprdisp.Value := utf8decode(expres);
end;

procedure tmainfo.refreshframe;
var
  pc: qword;
begin
  cpufo.refresh;
  if gdb.getpc(pc) = gdb_ok then
    disassfo.refresh(pc)
  else
    disassfo.Clear;
  watchfo.refresh;
end;

procedure tmainfo.stackframechanged(const frameno: integer);
begin
  if gdb.cancommand then
  begin
    gdb.selectstackframe(frameno);
    refreshframe;
  end;
end;

procedure tmainfo.customcompile(const Sender: TObject);
var
  page1: tsourcepage;
begin
  page1 := sourcefo.ActivePage;
  if (page1 <> nil) then
  begin
    setstattext('  Compile ' + page1.filepath, mtk_info);
    customdomake(page1.filepath, settypecompiler, setcompiler, customoption);
  end;
end;

procedure tmainfo.customrun(const Sender: TObject);
var
  page1: tsourcepage;
begin
  page1 := sourcefo.ActivePage;
  if (page1 <> nil) then
    RunCustomCompiled(ansistring(page1.filepath), ansistring(debuggerfo.edit_compiler.Value));
end;

procedure tmainfo.runwithoutdebugger;
var
  int1, int2: integer;
  strwine: msestring;
begin
  if nodebugset then
    setstattext('No debugger set, please check Project-Option|Debugger|Project-debugger.  Running without debugging...', mtk_error)
  else
    setstattext('', mtk_flat);

  int1 := 1;

  with projectoptions, o, texp do
    for int2 := 0 to high(compilerused) do
      if (thetag and compilerusedon[int2] <> 0) then
        if system.pos('Default', compilerused[int2]) > 0 then
          int1 := 1
        else if system.pos('Pascal', compilerused[int2]) > 0 then
          int1 := 1
        else if system.pos('Java', compilerused[int2]) > 0 then
          int1 := 2
        else if system.pos('C ', compilerused[int2]) > 0 then
          int1 := 3
        else if system.pos('Python', compilerused[int2]) > 0 then
          int1 := 4;

  strwine   := '';
   {$ifdef linux}
  if (system.pos('.exe', gettargetfile) > 0) then
    strwine := 'wine ';
   {$endif}

  if projectoptions.d.showconsole then
  begin
    targetconsolefo.activate;
    mainfo.startconsole();
    frunningprocess := targetconsolefo.terminal.execprog(strwine + gettargetfile);
    runprocmon.listentoprocess(frunningprocess);
  end
  else
  begin
    strwine   := '';
   {$ifdef linux}
    if (system.pos('.exe', gettargetfile) > 0) then
      strwine := utf8decode(IntToStr(int1) + 'w')
    else if (int1 = 1) or (int1 = 3) then
      strwine := ''
    else
      strwine := utf8decode(IntToStr(int1));
   {$else}
    if (int1 = 1) or (int1 = 3) then
      strwine := ''
    else
      strwine := utf8decode(IntToStr(int1));
   {$endif}

    RunCustomCompiled(ansistring(gettargetfile), ansistring(strwine));

  end;
end;

procedure tmainfo.toggleformunit;
var
  po1: pmoduleinfoty;
  page1: tsourcepage;
  sysfilename: string;
  str1, str2, str3: filenamety;
begin

  if sourcefo.checkancestor(flastform) then
  begin
    page1 := sourcefo.ActivePage;
    if (page1 <> nil) then
    begin
      str2 := fileext(page1.filepath);
      str3 := page1.filepath;
      if str2 = pasfileext then
      begin  /// it is pascal
        str1 := replacefileext(page1.filepath, formfileext);
        po1  := designer.modules.findmodule(str1);
        if po1 <> nil then
        begin // mfm finded
          createmodulemenuitem(po1);
          po1^.designform.activate(True);

          setstattext('  Toggled mse form/unit...', mtk_flat);

          page1 := nil;
        end
        else
        begin

          if fileexists(str1) then
          begin
            page1 := sourcefo.findsourcepage(str1);
            if page1 = nil then
            begin //mfm not loaded in editor
              po1 := designer.loadformfile(str1, False);
              if po1 <> nil then
              begin
                setstattext('  Toggled to form...', mtk_flat);
                createmodulemenuitem(po1);
                po1^.designform.activate(True);
              end;
            end;
          end
          else
          begin

            setstattext('', mtk_flat);

            // fred
            if (conffpguifo.enablefpguidesigner.Value = True) then
              if toogletag = False then
              begin
                // if fpgfilename <> page1.filepath then
                //  begin
                setstattext('  Toggled to form...', mtk_flat);
                toogletag := True;

                sysfilename := ansistring(tosysfilepath(filepath(str3, fk_file, True)));

                LoadfpgDesigner(sysfilename);
                //  fpgfilename := page1.filepath;
                // end else
                //  LoadfpgDesigner('showit');
              end
              else
              begin
                setstattext('  Toggled to source...', mtk_flat);
                toogletag := False;
                if (conffpguifo.tbfpgonlyone.Value = True) and (conffpguifo.ifhide.Value = True) then
                  LoadfpgDesigner(ansistring(conffpguifo.edhide.Text));
              end;

{ TODO => libraries
if fpgdlib_enabled = true then
begin
 if fpgdlib_isloaded = false then
 begin
 fpgd_loadlib('/home/fred/ideu/src/plugin/linux64/libfpgdxt.so') ;
  end else
  fpgd_mainproc();

fpgd_loadfile(pchar(page1.filepath));
end;
end;
}
            // fred end

            /// ici fred

          end;
        end;
      end
      else if str2 = formfileext then
      begin
        setstattext('  Toggled to mse source...', mtk_flat);

        page1 := sourcefo.findsourcepage(
          replacefileext(page1.filepath, pasfileext));
      end;
      if page1 <> nil then
        page1.activate;
    end;
  end
  else
  begin
    po1 := designer.actmodulepo;
    if po1 <> nil then
    begin
      str1 := replacefileext(po1^.filename, pasfileext);
      if sourcefo.openfile(str1, True) = nil then
        raise Exception.Create(ansistring(mainformtext(ma_unableopen) + str1 + '".'));
    end
    else if designer.modules.Count > 0 then
      designer.modules[0]^.designform.activate(True);
  end;
end;

procedure tmainfo.setstattext(const atext: msestring; const akind: messagetextkindty = mtk_info);
var
  color0, color1, color3, colorf0, colore0, colore1, colorf1, colornf0, colornf1: longword;
begin

  if themenr = 0 then
  begin
    color0   := $CFCFCF;
    color1   := $9E9E9E;
    color3   := cl_black;
    colorf0  := $96B094;
    colorf1  := $B1CFAE;
    colornf0 := $FFB1B4;
    colornf1 := $FF6E72;
    colore1  := cl_white;
    colore0  := cl_ltred;
  end;

  if themenr = 1 then
  begin
    color0   := cl_dkgray;
    color1   := cl_black;
    color3   := cl_white;
    colorf1  := $3F6B3E;
    colorf0  := cl_black;
    colornf0 := cl_yellow;
    colornf1 := cl_dkyellow;
    colore0  := cl_dkred;
    colore1  := cl_black;
  end;

  with debuggerfo.statdisp do
  begin
    Value := removelinebreaks(atext);
    case akind of
      mtk_warning:
      begin
        face.fade_color.items[0] := $DBFFDB;
        face.fade_color.items[1] := $BEDEBE;
      end;
      mtk_finished:
      begin
        face.fade_color.items[0] := colorf0;
        face.fade_color.items[1] := colorf1;
        //  face.fade_color.items[0]:= $CFCFCF;
        //  face.fade_color.items[1]:= $9E9E9E;
      end;
      mtk_error:
      begin
        face.fade_color.items[0] := colore0;
        face.fade_color.items[1] := colore1;
      end;
      mtk_signal:
      begin
        face.fade_color.items[0] := cl_ltred;
        face.fade_color.items[1] := cl_red;
      end;
      mtk_making:
      begin
        face.fade_color.items[0] := $DEA8FF;
        face.fade_color.items[1] := $C466FF;
      end;
      mtk_notok:
      begin
        face.fade_color.items[0] := colornf0;
        face.fade_color.items[1] := colornf1;
      end
      else
      begin
        face.fade_color.items[0] := color0;
        face.fade_color.items[1] := color1;
      end;
    end;

    font.color := color3;

    //    case akind of
    //      mtk_making: font.color := cl_red;
    //      else
    //        font.color           := color3;
    //    end;

  end;

{
with mainfo do begin
  case akind of
   mtk_warning : color:= $BEDEBE;
   mtk_finished: color:= $8DE08D;
   mtk_error: color:=   $F0F097;
   mtk_signal: color:= cl_ltred;
   mtk_making: color:= $E2B4FE ;
   mtk_notok: color:= $FFB1B4 ;
   else color:= cl_parent;
  end;
  end;
 }

end;

procedure tmainfo.cleardebugdisp;
begin
  resetdebugdisp;
  stackfo.Clear;
  threadsfo.Clear;
  disassfo.Clear;
end;

procedure tmainfo.resetdebugdisp;
begin
  setstattext('', mtk_info);
  if sourcefo.gdbpage <> nil then
    sourcefo.gdbpage.hidehint;
  sourcefo.resetactiverow;
  disassfo.resetactiverow;
end;

procedure tmainfo.programfinished;
begin
  sourcefo.resetactiverow;
  watchpointsfo.Clear;
  disassfo.Clear;
  watchfo.Clear;
  stackfo.Clear;
  threadsfo.Clear;
  actionsmo.finishcustom;
end;

procedure tmainfo.refreshstopinfo(const astopinfo: stopinfoty);
begin
  fstopinfo := astopinfo;
  with astopinfo do
  begin
    case reason of
      sr_signal_received:
        setstattext(utf8decode(messagetext), mtk_signal);
      sr_error:
        setstattext(utf8decode(messagetext), mtk_error);
      sr_exception: ;
      else
        setstattext(utf8decode(messagetext), mtk_finished);
    end;
    watchfo.refresh;
    breakpointsfo.refresh;
    stackfo.refresh;
    threadsfo.refresh;
    threadsfo.stopinfo := astopinfo;
    cpufo.refresh;
    disassfo.refresh(addr);
    if (reason = sr_exception) then
    begin
      setstattext(utf8decode(messagetext) + ' ' + (stackfo.infotext(1)), mtk_signal);
      if not stackfo.showsource(1) then
        sourcefo.locate(stopinfo);
    end
    else
      sourcefo.locate(stopinfo);
    if reason in [sr_exited, sr_exited_normally, sr_detached] then
      programfinished;
    if projectoptions.d.activateonbreak then
      application.activate(){
   if application.activewindow <> nil then begin
    application.activewindow.activate;
   end
   else begin
    if flastform <> nil then begin
     flastform.activate();
    end
    else begin
     sourcefo.activate();
    end;
   end;
  };
    if projectoptions.d.raiseonbreak then
      application.packwindowzorder();
  end;
end;

procedure tmainfo.gdbonevent(const Sender: tgdbmi; var eventkind: gdbeventkindty; const values: resultinfoarty; const stopinfo: stopinfoty);
begin
  cpufo.stoptime.Value := gdb.stoptime;
  case eventkind of
    gek_stopped:
    begin
      with stopinfo do
        if (reason = sr_startup) and (fstartcommand = sc_continue) then
          gdb.continue
        else if breakpointsfo.checkbreakpointcontinue(stopinfo) then
          gdb.continue
        else if reason = sr_detached then
        begin
          cleardebugdisp;
          setstattext(utf8decode(stopinfo.messagetext), mtk_finished);
          programfinished;
          debuggerfo.project_reset.Enabled     := False;
          debuggerfo.project_interrupt.Enabled := False;
        end
        else
        begin
          gdb.debugbegin;
          refreshstopinfo(stopinfo);
        end;
      fstartcommand := sc_none;
    end;
    gek_running:
    begin
      resetdebugdisp;
      setstattext(mainformtext(ma_running), mtk_warning);
      debuggerfo.project_reset.Enabled     := True;
      debuggerfo.project_interrupt.Enabled := True;
    end;
    gek_error, gek_writeerror, gek_gdbdied:
      setstattext('GDB: ' + utf8decode(stopinfo.messagetext), mtk_error);
    gek_targetoutput:
      targetconsolefo.addtext(values[0].Value);
    gek_download:
      with stopinfo do
        if sectionsize > 0 then
          setstattext(mainformtext(ma_str_downloading) + ' ' + utf8decode(section) + ' ' +
            utf8decode(IntToStr(round(sectionsent / sectionsize * 100))) + '%', mtk_making);
    gek_done:
      if Sender.downloaded then
      begin
        downloaded;
        setstattext(mainformtext(ma_str_downloaded) + ' ' + utf8decode(formatfloat('0.00,',
          stopinfo.totalsent / 1024)) + 'kB', mtk_finished);
        //    sender.abort;
      end;
    gek_loaded:
      symbolfo.updatesymbols;
  end;
end;

procedure tmainfo.gdbserverexe(const Sender: tguiapplication; var again: Boolean);
begin
  sys_schedyield;
  if timeout(fgdbservertimeout) and
    ((getprocessexitcode(fgdbserverprocid, fgdbserverexitcode, 100000) = pee_ok) or
    projectoptions.d.nogdbserverexit) then
    Sender.terminatewait
  else
  begin
    Sender.idlesleep(100000);
    again := True;
  end;
end;


function tmainfo.terminategdbserver(const force: Boolean): Boolean;
var
  int1: integer;
begin
  Result := False;
  if (fgdbserverprocid <> invalidprochandle) and
    (not projectoptions.d.gdbserverstartonce or force) then
  begin
    Result := True;
    try
      if (getprocessexitcode(fgdbserverprocid, int1) <> pee_ok) then
        killprocesstree(fgdbserverprocid);
    except
    end;
    fgdbserverprocid := invalidprochandle;
  end;
end;

procedure tmainfo.gdbservercancel(const Sender: TObject);
begin
  terminategdbserver(True);
end;

procedure tmainfo.targetpipeinput(const Sender: tpipereader);
begin
  messagefo.Messages[0].readpipe(Sender);
end;

function tmainfo.startgdbconnection(const attach: Boolean): Boolean;
var
  mstr1: msestring;
begin
  Result := False;
  with projectoptions, d.texp do
  begin
    if attach then
      mstr1 := gdbservercommandattach
    else
      mstr1 := gdbservercommand;
    if mstr1 <> '' then
    begin
      if terminategdbserver(False) then
        //    sleep(1000);
      ;

      if d.gdbserverstartonce and gdb.tryconnect then
      begin
        Result := True;
        Exit;
      end;
      if d.gdbservertty then
        fgdbserverprocid := execmse2(syscommandline(mstr1), nil,
          targetpipe.pipereader, targetpipe.pipereader, -1, [exo_tty])
      else
        fgdbserverprocid := execmse2(syscommandline(mstr1), nil,
          nil, nil, -1, []);
      if fgdbserverprocid <> invalidprochandle then
      begin
        fgdbservertimeout := timestep(round(1000000 * d.gdbserverwait));
        if application.waitdialog(nil, mainformtext(ma_startgdbservercommand) +
          mstr1 + mainformtext(ma_running2), mainformtext(ma_startgdbserver),
              {$ifdef FPC}
          @
{$endif}
          gdbservercancel, nil,
              {$ifdef FPC}
          @
{$endif}
          gdbserverexe) then
        begin
          if (fgdbserverexitcode <> 0) and not
            (projectoptions.d.nogdbserverexit and
            (fgdbserverexitcode = -1)) then
          begin
            setstattext(mainformtext(ma_gdbserverstarterror) + ' ' +
              utf8decode(IntToStr(fgdbserverexitcode)) + '.',
              mtk_error);
            Exit;
          end;
        end
        else
        begin
          setstattext(mainformtext(ma_gdbservercanceled), mtk_error);
          Exit;
        end;
      end
      else
      begin
        setstattext(mainformtext(ma_cannotrunstartgdb), mtk_error);
        Exit;
      end;
    end;
  end;
  Result := True;
end;

function tmainfo.checkgdberror(aresult: gdbresultty): Boolean;
begin
  Result := aresult = gdb_ok;
  if not Result then
    setstattext('GDB: ' + utf8decode(gdb.geterrormessage(aresult)), mtk_error);
end;

procedure tmainfo.checkbluedots;
begin
  if (sourcefo <> nil) and (sourcefo.ActivePage <> nil) then
    if (gdb.execloaded or gdb.attached) and actionsmo.bluedotsonact.Checked then
      sourcefo.ActivePage.updatedebuglines
    else
      sourcefo.ActivePage.cleardebuglines;
end;

procedure tmainfo.updatesigsettings;
var
  int1, int2: integer;
  str1: string;
  bo1: Boolean;
begin
  if gdb.active then
  begin
    bo1 := gdb.running;
    if bo1 then
      gdb.interrupttarget;
    gdb.ignoreexceptionclasses := projectoptions.ignoreexceptionclasses;
    gdb.stoponexception := projectoptions.d.stoponexception;
    str1 := '';
  {$ifndef mswindows}
    for int1 := sigrtmin to sigrtmax do
    begin
      str1 := str1 + 'SIG' + IntToStr(int1) + ' ';
    end;
  {$endif}
    if (gdb.handle(str1, []) = gdb_ok) then
      for int1 := 0 to high(projectoptions.sigsettings) do
        with projectoptions.sigsettings[int1] do
          if num > 0 then
            for int2 := num to numto do
              gdb.handle(getsigname(int2), flags);
    if bo1 then
      gdb.restarttarget;
  end;
  gdb.newconsole := projectoptions.d.externalconsole;
 {$ifdef mswindows}
  // gdb.newconsole:= projectoptions.d.externalconsole;
 {$else}
  gdb.settty := projectoptions.d.settty;
  gdb.xtermcommand := projectoptions.d.texp.xtermcommand;
 {$endif}
end;

procedure tmainfo.startconsole();
begin
  targetconsolefo.Clear;
  if projectoptions.d.showconsole then
    targetconsolefo.activate;
end;

procedure tmainfo.uploadexe(const Sender: tguiapplication; var again: Boolean);
begin
  if not downloading then
    Sender.terminatewait
  else
  begin
    Sender.idlesleep(100000);
    again := True;
  end;
end;

procedure tmainfo.uploadcancel(const Sender: TObject);
begin
  abortdownload;
  // killprocess(fuploadprocid);
end;

function tmainfo.needsdownload: Boolean;
begin
  Result := ftargetfilemodified or projectoptions.d.downloadalways;
end;

function tmainfo.candebug: Boolean; //run command empty or process attached
begin
  Result := (projectoptions.d.texp.runcommand = '') or gdb.started;
end;

procedure tmainfo.downloaded;
begin
  ftargetfilemodified := False;
  if fgdbdownloaded then
  begin
    fgdbdownloaded := False;
    if projectoptions.d.restartgdbbeforeload then
      mainfo.startgdb(False);
  end;
end;


procedure tmainfo.updatetargetenvironment;
//todo: implement for run without gdb
var
  int1: integer;
begin
  with projectoptions, d.texp do
  begin
    gdb.progparameters   := ansistring(progparameters);
    gdb.workingdirectory := progworkingdirectory;
    gdb.clearenvvars;
    for int1 := 0 to high(envvarons) do
    begin
      if (int1 > high(envvarnames)) or (int1 > high(envvarnames)) then
        break;
      if envvarons[int1] then
        gdb.setenvvar(ansistring(envvarnames[int1]), ansistring(envvarvalues[int1]))
      else
        gdb.unsetenvvar(ansistring(envvarnames[int1]));
    end;
  end;
end;

function tmainfo.loadexec(isattach: Boolean; const forcedownload: Boolean): Boolean;
var
  str1: filenamety;
begin
  setstattext('');
  Result := False;
  if isattach then
  begin
    Inc(fexecstamp);
    breakpointsfo.updatebreakpoints;
    checkbluedots;
  end
  else if not gdb.execloaded or forcedownload then
  begin

    with projectoptions, d.texp do
    begin

      if d.restartgdbbeforeload or not gdb.active then
        startgdb(False);
      str1 := gettargetfile;

      if not d.gdbdownload and not d.gdbsimulator and (uploadcommand <> '') and
        (needsdownload or forcedownload) then
      begin
        dodownload;
        if application.waitdialog(nil, mainformtext(ma_str_uploadcommand) + uploadcommand +
          mainformtext(ma_running2), mainformtext(ma_str_downloading),
{$ifdef FPC}
          @
{$endif}
          uploadcancel, nil,
         {$ifdef FPC}
          @
{$endif}
          uploadexe) then
        begin
          if downloadresult <> 0 then
          begin
            setstattext(mainformtext(ma_downloaderror) + ' ' +
              utf8decode(IntToStr(downloadresult)) + '.', mtk_error);
            Exit;
          end
          else
          begin
            setstattext(mainformtext(ma_downloadfinished), mtk_finished);
            downloaded;
            if confideufo.usedefaulteditoroptions.Value then
            begin
              if confideufo.closemessages.Value then
                messagefo.hide;
            end
            else if projectoptions.o.closemessages then
              messagefo.hide;
          end;
        end
        else
        begin
          setstattext(mainformtext(ma_downloadcanceled), mtk_error);
          Exit;
        end;
      end;
    end;
    mainfo.setstattext(actionsmoduletext(ac_loading) + '.', mtk_error);

    debuggerfo.project_reset.Enabled     := True;
    debuggerfo.project_interrupt.Enabled := True;
    application.ProcessMessages();
    application.beginwait();
    if checkgdberror(gdb.fileexec(str1, forcedownload)) then
    begin
      Inc(fexecstamp);
      breakpointsfo.updatebreakpoints;
      mainfo.setstattext('', mtk_info);
    end;
    application.endwait();
    checkbluedots;
  end;
  Result := gdb.execloaded or gdb.attached;
  if Result then
  begin
    updatetargetenvironment;
    watchpointsfo.Clear;
    targetconsolefo.Clear;
    if projectoptions.d.showconsole then
      targetconsolefo.activate;
    if forcedownload and projectoptions.d.gdbdownload then
      if startgdbconnection(False) then
        if checkgdberror(gdb.download(False)) then
          fgdbdownloaded := True;
  end;
end;

procedure tmainfo.unloadexec;
begin
  if gdb.active then
    gdb.fileexec('')//unload exec
  ;
  resetdebugdisp;
  checkbluedots;
end;

procedure tmainfo.startgdb(const killserver: Boolean);
var
  int1, int2, int3: integer;
  str3: msestring;
begin

  terminategdbserver(killserver);

  // fred debugger
  str3 := '';

  case debuggerfo.project_options.Value of
    'M': thetag := 1;
    'B': thetag := 2;
    '1': thetag := 4;
    '2': thetag := 8;
    '3': thetag := 16;
    '4': thetag := 32;
    '5': thetag := 64;
    '6': thetag := 128;
    '7': thetag := 256;
    '8': thetag := 512;
    '9': thetag := 1024;
    '0': thetag := 2048;
  end;

  with projectoptions, o, texp do
    for int3 := 0 to high(debuggerused) do
      if (thetag and debuggerusedon[int3] <> 0) and (debuggerused[int3] <> '') then
        if system.pos('Default', debuggerused[int3]) > 0 then
          str3 := 'Default Debugger'
        else if (trim(debuggerused[int3]) = 'Debugger 1') then
          str3 := quotefilename(tosysfilepath(confdebuggerfo.debugger1.Value))
        else if (trim(debuggerused[int3]) = 'Debugger 2') then
          str3 := quotefilename(tosysfilepath(confdebuggerfo.debugger2.Value))
        else if (trim(debuggerused[int3]) = 'Debugger 3') then
          str3 := quotefilename(tosysfilepath(confdebuggerfo.debugger3.Value))
        else if (trim(debuggerused[int3]) = 'Debugger 4') then
          str3 := quotefilename(tosysfilepath(confdebuggerfo.debugger4.Value))
        else
          str3 := '';


  int1 := 1;

  with projectoptions, o, texp do
    for int2 := 0 to high(compilerused) do
      if (thetag and compilerusedon[int2] <> 0) then
        if system.pos('Default', compilerused[int2]) > 0 then
          int1 := 1
        else if system.pos('Pascal', compilerused[int2]) > 0 then
          int1 := 1
        else if system.pos('Java', compilerused[int2]) > 0 then
          int1 := 2
        else if system.pos('C ', compilerused[int2]) > 0 then
          int1 := 3
        else if system.pos('Python', compilerused[int2]) > 0 then
          int1 := 4;

  if (str3 <> '') and ((int1 = 1) or (int1 = 3)) then
  begin
    terminategdbserver(killserver);
    with projectoptions, d.texp do
    begin
      gdb.remoteconnection := remoteconnection;
      gdb.gdbdownload      := d.gdbdownload;
      gdb.simulator        := d.gdbsimulator;
      gdb.processorname    := ansistring(gdbprocessor);
      gdb.guiintf          := not d.nodebugbeginend;
      gdb.beforeconnect    := beforeconnect;
      gdb.afterconnect     := afterconnect;
      gdb.beforeload       := beforeload;
      gdb.afterload        := afterload;
      gdb.beforerun        := beforerun;
      gdb.startupbkpt      := d.startupbkpt;
      gdb.startupbkpton    := d.startupbkpton;

      if str3 = 'Default Debugger' then
        gdb.startgdb(quotefilename(debugcommand) + ' ' + debugoptions)
      else
        gdb.startgdb(quotefilename(str3) + ' ' + debugoptions);

      updatesigsettings;
      cleardebugdisp;
      checkbluedots;

    end;
  end
  else
    runwithoutdebugger;
end;


procedure tmainfo.restartgdbonexecute(const Sender: TObject);
begin
  startgdb(True);
end;

procedure tmainfo.symboltypeonsetvalue(const Sender: TObject; var avalue: msestring; var accept: Boolean);
var
  expres: string;
begin
  gdb.symboltype(ansistring(avalue), expres);
  symboltypedisp.Value := utf8decode(expres);
end;

procedure tmainfo.viewbreakpointsonexecute(const Sender: TObject);
begin
  breakpointsfo.activate;
  if breakpointsfo.Width < 50 then
  begin
    breakpointsfo.Height := 180;
    breakpointsfo.Width  := 250;
  end;
end;

procedure tmainfo.viewwatchesonexecute(const Sender: TObject);
begin
  watchfo.activate;
  if watchfo.Width < 50 then
  begin
    watchfo.Height := 180;
    watchfo.Width  := 250;
  end;
end;

procedure tmainfo.viewstackonexecute(const Sender: TObject);
begin
  stackfo.activate;
  if stackfo.Width < 50 then
  begin
    stackfo.Height := 180;
    stackfo.Width  := 250;
  end;
end;

procedure tmainfo.onscale(const Sender: TObject);
begin
  // fred
  basedock.bounds_y  := 0;
  // basedock.bounds_y:= statdisp.bottom + 1;
  basedock.bounds_cy := container.paintrect.cy;
end;

procedure tmainfo.parametersonexecute(const Sender: TObject);
begin
  editprogramparameters;
end;

procedure tmainfo.viewassembleronexecute(const Sender: TObject);
begin
  disassfo.activate;
  if breakpointsfo.Width < 50 then
  begin
    breakpointsfo.Height := 180;
    breakpointsfo.Width  := 250;
  end;
end;

procedure tmainfo.viewmemoryonexecute(const Sender: TObject);
begin
  memoryfo.activate;
  if memoryfo.Width < 50 then
  begin
    memoryfo.Height := 180;
    memoryfo.Width  := 250;
  end;
end;

procedure tmainfo.viewcpuonexecute(const Sender: TObject);
begin
  cpufo.activate;
  if cpufo.Width < 50 then
  begin
    cpufo.Height := 180;
    cpufo.Width  := 250;
  end;
end;

procedure tmainfo.viewmessagesonexecute(const Sender: TObject);
begin
  messagefo.activate;
  if messagefo.Width < 50 then
  begin
    messagefo.Height := 180;
    messagefo.Width  := 250;
  end;
end;

procedure tmainfo.viewsourceonexecute(const Sender: TObject);
begin
  sourcefo.activate;
  if sourcefo.Width < 50 then
  begin
    sourcefo.Height := 180;
    sourcefo.Width  := 250;
  end;
end;

procedure tmainfo.mainmenuonupdate(const Sender: tcustommenu);
var
  bo1, bo2: Boolean;
begin
  bo1 := False;

  if debuggerfo.debug_on.tag = 1 then
    bo2 := True
  else
    bo2 := False;

  with projectoptions, d.texp, actionsmo do
  begin
    detachtarget.Enabled  := gdb.execloaded or gdb.attached;
    download.Enabled      := not gdb.started and not gdb.downloading and
      ((uploadcommand <> '') or d.gdbdownload);
    attachprocess.Enabled := not (gdb.execloaded or gdb.attached);
    attachtarget.Enabled  := attachprocess.Enabled;
    run.Enabled           := not gdb.running and not gdb.downloading and not iscompiling;
    debuggerfo.project_start.Enabled := run.Enabled;
    debuggerfo.debug_on.Enabled := run.Enabled;

    if debuggerfo.debug_on.Enabled then
      debuggerfo.debug_on.face.image.alignment :=
        [al_stretchx, al_stretchy]
    else
      debuggerfo.debug_on.face.image.alignment :=
        [al_grayed, al_stretchx, al_stretchy];


    if debuggerfo.project_start.Enabled then
      debuggerfo.project_start.face.image.alignment :=
        [al_stretchx, al_stretchy]
    else
      debuggerfo.project_start.face.image.alignment :=
        [al_grayed, al_stretchx, al_stretchy];

    bo1          := candebug;
    step.Enabled := not gdb.running and not gdb.downloading and bo1 and bo2 and not iscompiling;
    debuggerfo.project_step.Enabled := step.Enabled;

    if debuggerfo.project_step.Enabled then
      debuggerfo.project_step.face.image.alignment :=
        [al_stretchx, al_stretchy]
    else
      debuggerfo.project_step.face.image.alignment :=
        [al_grayed, al_stretchx, al_stretchy];


    stepi.Enabled := not gdb.running and not gdb.downloading and bo1 and bo2 and not iscompiling;
    debuggerfo.project_step_instruction.Enabled := stepi.Enabled;

    if debuggerfo.project_step_instruction.Enabled then
      debuggerfo.project_step_instruction.face.image.alignment :=
        [al_stretchx, al_stretchy]
    else
      debuggerfo.project_step_instruction.face.image.alignment :=
        [al_grayed, al_stretchx, al_stretchy];

    Next.Enabled := not gdb.running and not gdb.downloading and bo1 and bo2 and not iscompiling;
    debuggerfo.project_next.Enabled := Next.Enabled;

    if debuggerfo.project_next.Enabled then
      debuggerfo.project_next.face.image.alignment :=
        [al_stretchx, al_stretchy]
    else
      debuggerfo.project_next.face.image.alignment :=
        [al_grayed, al_stretchx, al_stretchy];

    nexti.Enabled := not gdb.running and not gdb.downloading and bo1 and bo2 and not iscompiling;
    debuggerfo.project_next_instruction.Enabled := nexti.Enabled;

    if debuggerfo.project_next_instruction.Enabled then
      debuggerfo.project_next_instruction.face.image.alignment :=
        [al_stretchx, al_stretchy]
    else
      debuggerfo.project_next_instruction.face.image.alignment :=
        [al_grayed, al_stretchx, al_stretchy];

    finish.Enabled := not gdb.running and gdb.started and bo1;
    debuggerfo.project_finish.Enabled := finish.Enabled;

    if debuggerfo.project_finish.Enabled then
      debuggerfo.project_finish.face.image.alignment :=
        [al_stretchx, al_stretchy]
    else
      debuggerfo.project_finish.face.image.alignment :=
        [al_grayed, al_stretchx, al_stretchy];

    continue.Enabled  := not gdb.running and not gdb.downloading and
      (bo1 or (frunningprocess = invalidprochandle)) and not iscompiling;
    interrupt.Enabled := gdb.running and not gdb.downloading and bo1;
    debuggerfo.project_interrupt.Enabled := interrupt.Enabled;

    if debuggerfo.project_interrupt.Enabled then
      debuggerfo.project_interrupt.face.image.alignment :=
        [al_stretchx, al_stretchy]
    else
      debuggerfo.project_interrupt.face.image.alignment :=
        [al_grayed, al_stretchx, al_stretchy];

    reset.Enabled := (gdb.started or gdb.attached or gdb.downloading) or not bo1 and (frunningprocess <> invalidprochandle);
    debuggerfo.project_reset.Enabled := reset.Enabled;

    if debuggerfo.project_reset.Enabled then
      debuggerfo.project_reset.face.image.alignment :=
        [al_stretchx, al_stretchy]
    else
      debuggerfo.project_reset.face.image.alignment :=
        [al_grayed, al_stretchx, al_stretchy];

    makeact.Enabled      := not making;
    abortmakeact.Enabled := making;

    debuggerfo.project_make.Enabled := makeact.Enabled;

    if debuggerfo.project_make.Enabled then
      debuggerfo.project_make.face.image.alignment :=
        [al_stretchx, al_stretchy]
    else
      debuggerfo.project_make.face.image.alignment :=
        [al_grayed, al_stretchx, al_stretchy];

    saveall.Enabled := sourcefo.modified or designer.modified or
      projectoptions.modified;
    actionsmo.toggleformunit.Enabled := (flastform <> nil) or (designer.modules.Count > 0);
   
        if theprojectname <> '' then
      begin
      mainmenu1.menu.itembynames(['project', 'make']).enabled := true;  
      mainmenu1.menu.itembynames(['project', 'build']).enabled := true;  
      mainmenu1.menu.itembynames(['project', 'make0']).enabled := true;  
      mainmenu1.menu.itembynames(['project', 'make1']).enabled := true;  
      mainmenu1.menu.itembynames(['project', 'make2']).enabled := true;  
      mainmenu1.menu.itembynames(['project', 'make3']).enabled := true;  
      mainmenu1.menu.itembynames(['project', 'make4']).enabled := true;  
      mainmenu1.menu.itembynames(['project', 'make5']).enabled := true;  
      mainmenu1.menu.itembynames(['project', 'make6']).enabled := true;  
      mainmenu1.menu.itembynames(['project', 'make7']).enabled := true;  
      mainmenu1.menu.itembynames(['project', 'make8']).enabled := true;  
      mainmenu1.menu.itembynames(['project', 'make9']).enabled := true;  
      mainmenu1.menu.itembynames(['project', 'abortmake']).enabled := true;  
      mainmenu1.menu.itembynames(['project', 'debugrun']).enabled := true;  
      mainmenu1.menu.itembynames(['project', 'options']).enabled := true;  
      mainmenu1.menu.itembynames(['project', 'tree']).enabled := true;  
      mainmenu1.menu.itembynames(['project', 'source']).enabled := true;  
      mainmenu1.menu.itembynames(['project', 'save']).enabled := true;  
      mainmenu1.menu.itembynames(['project', 'saveas']).enabled := true;  
      mainmenu1.menu.itembynames(['project', 'saveascopy']).enabled := true;  
      mainmenu1.menu.itembynames(['project', 'close']).enabled := true;  
     end else
     begin
       mainmenu1.menu.itembynames(['project', 'make']).enabled := false;  
      mainmenu1.menu.itembynames(['project', 'build']).enabled := false;  
      mainmenu1.menu.itembynames(['project', 'make0']).enabled := false;  
      mainmenu1.menu.itembynames(['project', 'make1']).enabled := false;  
      mainmenu1.menu.itembynames(['project', 'make2']).enabled := false;  
      mainmenu1.menu.itembynames(['project', 'make3']).enabled := false;  
      mainmenu1.menu.itembynames(['project', 'make4']).enabled := false;  
      mainmenu1.menu.itembynames(['project', 'make5']).enabled := false;  
      mainmenu1.menu.itembynames(['project', 'make6']).enabled := false;  
      mainmenu1.menu.itembynames(['project', 'make7']).enabled := false;  
      mainmenu1.menu.itembynames(['project', 'make8']).enabled := false;  
      mainmenu1.menu.itembynames(['project', 'make9']).enabled := false;  
      mainmenu1.menu.itembynames(['project', 'abortmake']).enabled := false;  
      mainmenu1.menu.itembynames(['project', 'debugrun']).enabled := false;  
      mainmenu1.menu.itembynames(['project', 'options']).enabled := false;  
      mainmenu1.menu.itembynames(['project', 'tree']).enabled := false;  
      mainmenu1.menu.itembynames(['project', 'source']).enabled := false;  
      mainmenu1.menu.itembynames(['project', 'save']).enabled := false;  
      mainmenu1.menu.itembynames(['project', 'saveas']).enabled := false;  
      mainmenu1.menu.itembynames(['project', 'saveascopy']).enabled := false;  
      mainmenu1.menu.itembynames(['project', 'close']).enabled := false;  
      end;
   
   if (sourcefo.ActivePage <> nil) and
      sourcefo.ActivePage.activeentered then
    begin
      setbm0.Enabled := True;
      setbm1.Enabled := True;
      setbm2.Enabled := True;
      setbm3.Enabled := True;
      setbm4.Enabled := True;
      setbm5.Enabled := True;
      setbm6.Enabled := True;


      setbm7.Enabled    := True;
      setbm8.Enabled    := True;
      setbm8.Enabled    := True;
      setbm9.Enabled    := True;
      setbmnone.Enabled := True;
      findbm0.Enabled   := True;
      findbm1.Enabled   := True;
      findbm2.Enabled   := True;
      findbm3.Enabled   := True;
      findbm4.Enabled   := True;
      findbm5.Enabled   := True;
      findbm6.Enabled   := True;
      findbm7.Enabled   := True;
      findbm8.Enabled   := True;
      findbm9.Enabled   := True;
      print.Enabled     := True;
      //debuggerfo.save_file.enabled := modified;
      
       mainmenu1.menu.itembynames(['search', 'proclist']).enabled := true;
   //     mainmenu1.menu.itembynames(['syntax']).enabled := true;   
   //     mainmenu1.menu.itembynames(['layout']).enabled := true;  
  //    mainmenu1.menu.itembynames(['edit']).enabled := true; 
        
       mainmenu1.menu.itembynames(['edited', 'make']).enabled := true;  
      mainmenu1.menu.itembynames(['edited', 'build']).enabled := true;  
      mainmenu1.menu.itembynames(['edited', 'make0']).enabled := true;  
      mainmenu1.menu.itembynames(['edited', 'make1']).enabled := true;  
      mainmenu1.menu.itembynames(['edited', 'make2']).enabled := true;  
      mainmenu1.menu.itembynames(['edited', 'make3']).enabled := true;  
      mainmenu1.menu.itembynames(['edited', 'make4']).enabled := true;  
      mainmenu1.menu.itembynames(['edited', 'make5']).enabled := true;  
      mainmenu1.menu.itembynames(['edited', 'make6']).enabled := true;  
      mainmenu1.menu.itembynames(['edited', 'make7']).enabled := true;  
      mainmenu1.menu.itembynames(['edited', 'make8']).enabled := true;  
      mainmenu1.menu.itembynames(['edited', 'make9']).enabled := true;  
      mainmenu1.menu.itembynames(['edited', 'makeX']).enabled := true; 
      
      mainmenu1.menu.itembynames(['edited', 'abortmake']).enabled := true;  
      mainmenu1.menu.itembynames(['edited', 'run']).enabled := true;  
      mainmenu1.menu.itembynames(['edited', 'beautifier']).enabled := true;  
      mainmenu1.menu.itembynames(['edited', 'save']).enabled := true;  
      mainmenu1.menu.itembynames(['edited', 'close']).enabled := true;  
    //   mainmenu1.menu.itembynames(['edited']).enabled := true;
    
           
      with sourcefo.ActivePage do
      begin
        actionsmo.save.Enabled := modified;
        actionsmo.savecust.Enabled := modified;
        undo.Enabled         := edit.canundo;
        redo.Enabled         := edit.canredo;
        copy.Enabled         := edit.hasselection;
        copylatexact.Enabled := edit.hasselection;
        copyword.Enabled   := True;
   
        cut.Enabled          := edit.hasselection;
        paste.Enabled        := edit.canpaste;
        Delete.Enabled       := edit.hasselection;
        indent.Enabled       := True;
        unindent.Enabled     := True;
        line.Enabled         := source_editor.rowcount > 0;
        togglebkpt.Enabled   := line.Enabled;
        togglebkptenable.Enabled := togglebkpt.Enabled;
        //    find.enabled:= true;
        replace.Enabled      := True;
        copyword.Enabled     := True;
        selectall.enabled := true;
        //    actionsmo.repeatfind.enabled:= find.enabled and
        //           (projectoptions.findreplaceinfo.find.text <> '');
      end;
    end
    else
    begin
      setbm0.Enabled    := False;
      setbm1.Enabled    := False;
      setbm2.Enabled    := False;
      setbm3.Enabled    := False;
      setbm4.Enabled    := False;
      setbm5.Enabled    := False;
      setbm6.Enabled    := False;
      setbm7.Enabled    := False;
      setbm8.Enabled    := False;
      setbm8.Enabled    := False;
      setbm9.Enabled    := False;
      setbmnone.Enabled := False;
      findbm0.Enabled   := False;
      findbm1.Enabled   := False;
      findbm2.Enabled   := False;
      findbm3.Enabled   := False;
      findbm4.Enabled   := False;
      findbm5.Enabled   := False;
      findbm6.Enabled   := False;
      findbm7.Enabled   := False;
      findbm8.Enabled   := False;
      findbm9.Enabled   := False;

      print.Enabled := False;
      save.Enabled  := False;
     line.Enabled         := false;
   
      copyword.Enabled   := false;
      
       mainmenu1.menu.itembynames(['search', 'proclist']).enabled := false;
     //  mainmenu1.menu.itembynames(['syntax']).enabled := false;   
     //  mainmenu1.menu.itembynames(['layout']).enabled := false;   
      
    //  mainmenu1.menu.itembynames(['edited']).enabled := false;
     // mainmenu1.menu.itembynames(['edit']).enabled := false; 
         
      mainmenu1.menu.itembynames(['edited', 'make']).enabled := false;  
      mainmenu1.menu.itembynames(['edited', 'build']).enabled := false;  
      mainmenu1.menu.itembynames(['edited', 'make0']).enabled := false;  
      mainmenu1.menu.itembynames(['edited', 'make1']).enabled := false;  
      mainmenu1.menu.itembynames(['edited', 'make2']).enabled := false;  
      mainmenu1.menu.itembynames(['edited', 'make3']).enabled := false;  
      mainmenu1.menu.itembynames(['edited', 'make4']).enabled := false;  
      mainmenu1.menu.itembynames(['edited', 'make5']).enabled := false;  
      mainmenu1.menu.itembynames(['edited', 'make6']).enabled := false;  
      mainmenu1.menu.itembynames(['edited', 'make7']).enabled := false;  
      mainmenu1.menu.itembynames(['edited', 'make8']).enabled := false;  
      mainmenu1.menu.itembynames(['edited', 'make9']).enabled := false;  
      mainmenu1.menu.itembynames(['edited', 'makeX']).enabled := false; 
      mainmenu1.menu.itembynames(['edited', 'abortmake']).enabled := false;  
      mainmenu1.menu.itembynames(['edited', 'run']).enabled := false;  
      mainmenu1.menu.itembynames(['edited', 'beautifier']).enabled := false; 
      mainmenu1.menu.itembynames(['edited', 'save']).enabled := false;   
      mainmenu1.menu.itembynames(['edited', 'close']).enabled := false; 
     
      undo.Enabled         := False;
      redo.Enabled         := False;
      copy.Enabled         := False;
      copylatexact.Enabled := False;
      cut.Enabled          := False;
      paste.Enabled        := False;
      Delete.Enabled       := False;
      indent.Enabled       := False;
      unindent.Enabled     := False;
      togglebkpt.Enabled   := False;
      togglebkptenable.Enabled := False;

     //   actionsmo.repeatfind.enabled:= false;
      // replace.enabled:= false;
      replace.Enabled  := false;
      copyword.Enabled := false;
      selectall.enabled := false;

    end;
    if (factivedesignmodule <> nil) then
    begin
      save.Enabled  := factivedesignmodule^.modified;
      //debuggerfo.save_file.enabled := save.enabled;
      Close.Enabled := True;
    end
    else
      Close.Enabled := sourcefo.Count > 0;
    closeall.Enabled := (sourcefo.Count > 0) or (designer.modules.Count > 0);
    saveas.Enabled := (factivedesignmodule <> nil) or (sourcefo.ActivePage <> nil);
    mainmenu1.menu.itembyname('project').itembyname('close').Enabled :=
      fprojectloaded;
  end;
end;

function tmainfo.formmenuitemstart: integer;
begin
  // result:= mainmenu1.menu.itembyname('view').itembyname('formmenuitemstart').index + 1;
  Result := mainmenu1.menu.itembynames(['widgets', 'msegui', 'msemod']).itembyname(
    'formmenuitemstart').index + 1;

end;

procedure tmainfo.createmodulemenuitem(const amodule: pmoduleinfoty);
var
  int1: integer;
  item1: tmenuitem;
begin
  //with mainmenu1.menu.itembyname('view') do begin

  with mainmenu1.menu.itembynames(['widgets', 'msegui', 'msemod']) do
  begin

    for int1 := formmenuitemstart to submenu.Count - 1 do
      if submenu[int1].tagpo = amodule then
        Exit;
    amodule^.hasmenuitem := True;
    item1 := tmenuitem.Create;
    with item1 do
    begin
      if amodule^.modified then
        Caption := '*' + msefileutils.filename(amodule^.filename)
      else
        Caption := msefileutils.filename(amodule^.filename);
      onexecute :=
{$ifdef FPC}
        @
{$endif}
        doshowform;
      tagpo := amodule;
      options := options + [mao_asyncexecute];
    end;
    for int1 := formmenuitemstart to submenu.Count - 1 do
      if submenu[int1].Caption > item1.Caption then
      begin
        submenu.insert(int1, item1);
        Exit;
      end;
    submenu.insert(bigint, item1);
  end;
end;

function tmainfo.openformfile(const filename: filenamety; const ashow, aactivate, showsource, createmenu, skipexisting: Boolean): pmoduleinfoty;
var
  // item1: tmenuitem;
  wstr1, wstr2: filenamety;
  // bo1: boolean;
  // int1: integer;
begin
  Result := designer.modules.findmodule(filename);


  if Result = nil then
  begin
    wstr2   := msefileutils.filename(filename);
    if findfile(filename) then
      wstr1 := filename
    else
    begin
      wstr1 := searchfile(wstr2, projectoptions.d.texp.sourcedirs);
      if wstr1 = '' then
        wstr1 := filename//to raise exception

      else
        wstr1 := wstr1 + wstr2;
    end;
    try
      Result := designer.loadformfile(wstr1, skipexisting);
    except
      showobjecttext(nil, wstr1, False);
      errorformfilename := wstr1;
      raise;
    end;
    if Result <> nil then
      if showsource then
        loadsourcebyform(wstr1);
  end;
  if Result <> nil then
  begin
    if createmenu then
      createmodulemenuitem(Result);
    if ashow then
    begin
      Result^.designform.Show;
      if aactivate then
        Result^.designform.activate;
    end;
    if Result^.modified then
      sourcechanged(nil);
  end;
end;

procedure tmainfo.loadformbysource(const sourcefilename: filenamety);
var
  str1: filenamety;
  activebefore: pmoduleinfoty;
  sysfilename: msestring;
begin
  if fileext(sourcefilename) = pasfileext then
  begin

    if (conffpguifo.enablefpguidesigner.Value = True) then
    begin
      sysfilename := tosysfilepath(filepath(trim(sourcefilename), fk_file, True));
      LoadfpgDesigner(ansistring(sysfilename));
    end;


    str1 := replacefileext(sourcefilename, formfileext);
    if findfile(str1) then
    begin
      activebefore := factivedesignmodule;
      try
        openformfile(str1, True, False, False, True, True);
      finally
        factivedesignmodule := activebefore;
      end;
    end;
  end;
end;

procedure tmainfo.loadsourcebyform(const formfilename: filenamety; const aactivate: Boolean = False);
begin
  sourcefo.openfile(replacefileext(formfilename, pasfileext), aactivate);
end;

function tmainfo.opensource(const filekind: filekindty; const addtoproject: Boolean; const aactivate: Boolean = True; const currentnode: tprojectnode = nil): Boolean;
var
  unitnode: tunitnode;
var
  int1: integer;
  page: tsourcepage;
  str1: filenamety;
  po1: pmoduleinfoty;
begin //opensourceactonexecute
      //writeln('hello');
  with stockobjects do
    openfile.controller.captionopen := captions[sc_openfile];
  ;

  openfile.controller.showoptions := True;

  openfile.controller.icon := icon;

  openfile.controller.fontheight := font.Height; // font height of dialogfile

  openfile.controller.fontname := msestring(font.Name);       // font name of dialogfile

  openfile.controller.fontcolor := font.color;    // font color of dialogfile

  // openfile.controller.backcolor := tbackcolor.Value;    // background color of dialogfile

  Result := openfile.Execute = mr_ok;

  if Result then
  begin
    page     := nil;
    po1      := nil;
    unitnode := nil; //compilerwarning
    designer.beginskipall;
    openfile.controller.icon := icon;
    openfile.controller.showoptions := True;

    try
      with openfile.controller do
        for int1 := 0 to high(filenames) do
          if checkfileext(filenames[int1], [formfileext]) then
          begin
            page  := sourcefo.findsourcepage(filenames[int1]);
            if page = nil then
              po1 := openformfile(filenames[int1], True, False, False, True, False);
          end
          else
          begin
            page       := sourcefo.openfile(filenames[int1]);
            if addtoproject then
              unitnode := projecttree.units.addfile(currentnode, filenames[int1]);
            str1 := designer.sourcenametoformname(filenames[int1]);
            if findfile(str1) then
            begin
              po1 := openformfile(str1, True, False, False, True, False);
              if addtoproject then
                unitnode.setformfile(str1);
            end;
          end;

    finally
      designer.endskipall;
    end;
    if aactivate then
      if page <> nil then
        page.activate(True, True)
      else if po1 <> nil then
        po1^.designform.activate(True, True);
  end;
end;

procedure tmainfo.designformactivated(const Sender: tcustommseform);
begin
  setlinkedvar(Sender, tmsecomponent(flastform));
  if sourcefo = flastform then
  begin
    factivedesignmodule := nil;
    setlinkedvar(Sender, tmsecomponent(flastdesignform));
  end
  else if (designer.actmodulepo <> nil) and
    (designer.actmodulepo^.designform = flastform) then
  begin
    factivedesignmodule := designer.actmodulepo;
    setlinkedvar(Sender, tmsecomponent(flastdesignform));
  end;
end;

procedure tmainfo.viewcomponentpaletteonexecute(const Sender: TObject);
begin
  componentpalettefo.window.bringtofront;
  componentpalettefo.Caption := stockobjects.captions[sc_componentspalette];
  componentpalettefo.Show;
end;

procedure tmainfo.viewcomponentstoreonexecute(const Sender: TObject);
begin
  componentstorefo.activate;
end;

procedure tmainfo.viewfpguidesigneronexecute(const Sender: TObject);
begin

  LoadfpgDesigner(ansistring(conffpguifo.edshow.Text));

end;

procedure tmainfo.resetfpguidesigneronexecute(const Sender: TObject);
begin
  if (conffpguifo.enablefpguidesigner.Value = True) and
    (conffpguifo.ifshow.Value = True) then
  begin
    LoadfpgDesigner('hideit');
    sleep(1000);
    LoadfpgDesigner(ansistring(conffpguifo.edshow.Text));
  end;


  //CleanfpgDesigner();
end;

procedure tmainfo.viewdebuggertoolbaronexecute(const Sender: TObject);
begin
  debuggerfo.window.bringtofront;
  //debuggerfo.show;
  debuggerfo.activate;
end;

procedure tmainfo.mainonloaded(const Sender: TObject);
var
  wstr1: msestring;
begin
  try
    wstr1 := filepath(statdirname);
    if not finddir(wstr1) then
    begin
      createdir(wstr1);
    end;
    
    {$ifdef linux}
         if not fileexists(wstr1 + '/ideuli.sta') then
          Filecreate(wstr1 + '/ideuli.sta') ;
    {$endif}
 
      mainstatfile.filedir := wstr1;
  {$ifdef mswindows}
    mainstatfile.filename := statname + 'wi.sta';
  {$endif}
  {$ifdef linux}
    mainstatfile.filename := statname + 'li.sta';
  {$endif}
  {$ifdef openbsd}
    mainstatfile.filename := statname + 'obsd.sta';
  {$endif}
  {$ifdef bsd}
    mainstatfile.filename := statname + 'bsd.sta';
  {$endif}
    mainstatfile.readstat;
    expandprojectmacros;
    onscale(nil);
  finally
    mainfo.activate;
  end;
 {$ifdef mse_dumpunitgroups}
  dumpunitgr;
 {$endif}
end;

function getmodulename(const aname, suffix: string): string;
var
  int1: integer;
begin
  int1     := length(aname) - length(suffix);
  if (int1 >= 0) and (strcomp(PChar(aname) + int1, PChar(suffix)) = 0) then
    Result := copy(aname, 1, int1) + copy(suffix, 1, 2)
  else
    Result := aname + copy(suffix, 1, 2);
end;

procedure tmainfo.createform(const aname: filenamety; const namebase: string; const ancestor: string);
var
  stream1: ttextstream;
  str1, str2, str3: msestring;
  po1: pmoduleinfoty;
begin
  str2    := removefileext(filename(aname));
  str3    := str2;
  str2    := utf8decode(getmodulename(ansistring(str2), namebase));
  stream1 := ttextstream.Create(aname, fm_create);
  try
    formskeleton(stream1, ansistring(filename(str3)), ansistring(str2), ancestor);
  finally
    stream1.Free;
  end;
  sourcefo.showsourceline(aname, 0, 0, True);
  str1    := replacefileext(aname, formfileext);
  closemodule(designer.modules.findmodule(str1), False);
  stream1 := ttextstream.Create(str1, fm_create);
  try
    with stream1 do
    begin
      writeln('object ' + str2 + ': t' + str2);
      writeln('  moduleclassname = ''' + ancestor + '''');
      writeln('end');
    end;
  finally
    stream1.Free;
  end;
  po1           := openformfile(str1, True, False, True, True, False);
{
  if kind = fok_main then begin
   with tmseform(po1^.instance) do begin
    options:= options + [fo_main,fo_terminateonclose];
    optionswindow:= optionswindow + [wo_groupleader];
   end;
  end;
}
  po1^.modified := True; //initial create of ..._mfm.pas
end;

procedure tmainfo.createprogramfile(const aname: filenamety);
var
  stream1: ttextstream;
begin
  stream1 := ttextstream.Create(aname, fm_create);
  try
    programskeleton(stream1, ansistring(removefileext(filename(aname))));
  finally
    stream1.Free;
  end;
  sourcefo.showsourceline(aname, 0, 0, True);
end;

function tmainfo.copynewfile(const aname, newname: filenamety; const autoincrement: Boolean; const canoverwrite: Boolean; const macronames: array of msestring; const macrovalues: array of msestring): Boolean;
  //true if ok
var
  int1: integer;
  dir, base, ext: filenamety;
  path1, path2: filenamety;
  macrolist: tmacrolist;
  instream, outstream: ttextstream;
  Text: msestringarty;
begin
  Result := False;
  path1  := searchfile(aname);
  if path1 = '' then
    ShowMessage(mainformtext(ma_str_file) + aname + mainformtext(ma_notfound2), mainformtext(ma_warning))
  else
  begin
    path2 := filepath(newname);
    if not canoverwrite and findfile(path2) then
      if not autoincrement then
      begin
        showerror(mainformtext(ma_str_file) + newname + mainformtext(ma_exists));
        Exit;
      end
      else
      begin
        splitfilepath(filepath(aname), dir, base, ext);
        base := base + dir;
        int1 := 1;
        repeat
          path2 := base + utf8decode(IntToStr(int1)) + ext;
          Inc(int1);
        until not findfile(path2);
      end;
    splitfilepath(path2, dir, base, ext);
    macrolist := tmacrolist.Create([mao_curlybraceonly]);
    try
      macrolist.add(['%FILEPATH%', '%FILENAME%', '%FILENAMEBASE%'],
        [path2, base + ext, base], []);
      macrolist.add(macronames, macrovalues, []);
      instream    := ttextstream.Create(path1);
      try
        Text      := instream.readmsestrings;
        macrolist.expandmacros1(Text);
        outstream := ttextstream.Create(path2, fm_create);
        try
          outstream.writemsestrings(Text);
        finally
          outstream.Free;
        end;
      finally
        instream.Free;
      end;
    finally
      macrolist.Free;
    end;
    Result := True;
  end;
end;

procedure tmainfo.newfileonexecute(const Sender: TObject);
var
  str1: filenamety;
  int1: integer;
begin
  str1 := '';
  int1 := tmenuitem(Sender).tag;
  with projectoptions.o.texp do
    if newfisources[int1] = '' then
      sourcefo.newpage
    else if filedialogx(str1, [fdo_save, fdo_checkexist], mainformtext(ma_str_new) + ' ' +
      newfinames[int1], [newfinames[int1]],
      [newfifilters[int1]], newfiexts[int1]) = mr_ok then
    begin
      copynewfile(newfisources[int1], str1, False, True,
        ['%PROGRAMNAME%', '%UNITNAME%'], ['${%FILENAMEBASE%}',
        '${%FILENAMEBASE%}']);
      sourcefo.openfile(str1, True);
    end;
end;

procedure tmainfo.newformonexecute(const Sender: TObject);
var
  str1, str2, str3, str4, str5: filenamety;
  dir, base, ext: filenamety;
  po1: pmoduleinfoty;
  ancestorclass, ancestorunit: msestring;
begin
  // if formkindty(tmenuitem(sender).tag) = fok_inherited then begin
  if projectoptions.o.newinheritedforms[tmenuitem(Sender).tag] then
  begin
    po1 := selectinheritedmodule(nil, mainformtext(ma_selectancestor));
    if po1 = nil then
      Exit;
    ancestorclass := utf8decode(po1^.moduleclassname);
    ancestorunit  := filenamebase(po1^.filename);
  end
  else
  begin
    ancestorclass := '';
    ancestorunit  := '';
    po1           := nil;
  end;
  str1 := '';
  if filedialogx(str1, [fdo_save, fdo_checkexist], mainformtext(ma_newform),
    [mainformtext(ma_pascalfiles)],
    ['"*.pas" "*.pp" "*.mla"'], 'pas') = mr_ok then
  begin
    with projectoptions.o.texp do
    begin
      str4 := newfonamebases[tmenuitem(Sender).tag];
      str2 := newfosources[tmenuitem(Sender).tag];
      str3 := newfoforms[tmenuitem(Sender).tag];
    end;
    if (str2 <> '') or (str3 <> '') then
    begin
      if str2 <> '' then
        str2 := filepath(str2)//sourcesource
      ;
      if str3 <> '' then
        str3 := filepath(str3)//formsource
      ;
      splitfilepath(str1, dir, base, ext);
      str4 := UTF8Decode(getmodulename(ansistring(base), ansistring(str4)));
      str5 := replacefileext(str1, 'mfm');
      if str2 <> '' then
        copynewfile(str2, str1, False, True,
          ['%UNITNAME%', '%FORMNAME%', '%ANCESTORUNIT%', '%ANCESTORCLASS%'],
          ['${%FILENAMEBASE%}', str4, ancestorunit, ancestorclass])//source
      ;
      if str3 <> '' then
        copynewfile(str3, str5, False, True,
          ['%UNITNAME%', '%FORMNAME%', '%ANCESTORUNIT%', '%ANCESTORCLASS%'],
          ['${%FILENAMEBASE%}', str4, ancestorunit, ancestorclass])//form
      ;
      if str2 <> '' then
        sourcefo.openfile(str1, True);
      if (str3 <> '') then
      begin
        openformfile(str5, True, False, False, True, False);
        po1 := designer.modules.findmodule(str5);
        if po1 <> nil then
          po1^.modified := True//initial create of ..._mfm.pas
        ;
      end;
    end
    else
      createform(str1, 'form', 'tmseform')//   createform(str1,formkindty(tmenuitem(sender).tag));
    //default
    ;
  end;
end;

procedure tmainfo.removemodulemenuitem(const amodule: pmoduleinfoty);
var
  int1: integer;
begin
  // with mainmenu1.menu.itembyname('view') do begin
  with mainmenu1.menu.itembynames(['widgets', 'msegui', 'msemod']) do
    for int1 := itembyname('formmenuitemstart').index + 1 to Count - 1 do
      if items[int1].tagpo = amodule then
      begin
        submenu.Delete(int1);
        break;
      end;
end;

function tmainfo.closeallmodule(): Boolean;
begin
  Result := True;
  while designer.modules.Count > 0 do
    closemodule(designer.modules.itempo[designer.modules.Count - 1], False, True);
end;

function tmainfo.closemodule(const amodule: pmoduleinfoty; const achecksave: Boolean; nocheckclose: Boolean = False): Boolean;
var
  str1: string;
begin
  if amodule <> nil then
  begin
    if nocheckclose or designer.checkcanclose(amodule, str1) then
      Result := designer.closemodule(amodule, achecksave)
    else
    begin
      amodule^.designform.hide;
      Result := True;
      removemodulemenuitem(amodule);
      amodule^.hasmenuitem := False;
    end;
    if Result then
      if factivedesignmodule = amodule then
        factivedesignmodule := nil;
  end
  else
    Result := True;
end;

function tmainfo.checksavecancel(const aresult: modalresultty): modalresultty;
begin
  if aresult = mr_cancel then
  begin
    projectoptions.savechecked := False;
    sourcefo.savecanceled;
    designer.savecanceled;
  end;
  Result := aresult;
end;

function tmainfo.closeall(const nosave: Boolean): Boolean;
begin
  Result := nosave or (checksavecancel(sourcefo.saveall(False)) <> mr_cancel);
  if Result then
  begin
    Result := nosave or (checksavecancel(designer.saveall(False, True)) <>
      mr_cancel);
    if Result then
    begin
      sourcefo.closeall(True);
      while designer.modules.Count > 0 do
        closemodule(designer.modules.itempo[designer.modules.Count - 1], not nosave, True);
    end;
  end;
end;

procedure tmainfo.buildactonexecute(const Sender: TObject);
begin
  domake(2);
end;

procedure tmainfo.showfirsterror;
var
  int1: integer;
  apage: tsourcepage;
begin
  with messagefo do
    for int1 := 0 to Messages.rowcount - 1 do
      if locateerrormessage(Messages[0][int1], apage, el_error) then
      begin
        Messages.focuscell(makegridcoord(0, int1));
        setstattext(Messages[0][int1], mtk_error);
        break;
      end;
end;

{
procedure tmainfo.mainfoonclosequery(const sender: tcustommseform;
            var modalresult: modalresultty);
begin
 if checksave = mr_cancel then begin
  modalresult:= mr_none;
 end
 else begin
  sourcefo.filechangenotifyer.clear;
  mainstatfile.writestat;
 end;
end;
}
procedure tmainfo.mainfoonterminate(var terminate: Boolean);
 //var
 // modres: modalresultty;
begin
  if checksave = mr_cancel then
    terminate := False
  else
  begin
    sourcefo.filechangenotifyer.Clear;
    mainstatfile.writestat;
  end;
 {
  modres:= mr_windowclosed;
  mainfoonclosequery(nil,modres);
  if modres <> mr_windowclosed then begin
   terminate:= false;
  end;
 end;
 }
end;

procedure tmainfo.setprojectname(aname: filenamety);
begin
  fprojectname := aname;
  if aname = '' then
    Caption    := idecaption + ' v' + versiontext
  //+ ' (<' + mainformtext(ma_new2) + '>)'
  else
  begin

    if confideufo.fullpath.Value then
      Caption := idecaption + ' (' + (tosysfilepath(filepath(aname, fk_file, True))) + ')'
    else
      Caption := idecaption + ' (' + filename(aname) + ')';

    setcurrentdirmse(filedir(aname));
    openfile.controller.filename := '';
  end;
  dragdock.layoutchanged; //refresh possible dockpanel caption
end;

function tmainfo.openproject(const aname: filenamety; const ascopy: Boolean = False): Boolean;

  procedure closepro;
  begin
    gdb.abort;
    sourceupdater.Clear;
    initprojectoptions;
    projectoptions.projectfilename := '';
    setprojectname('');
    projecttreefo.Clear;
    watchfo.Clear(True);
    breakpointsfo.Clear;
    watchpointsfo.Clear(True);
    cleardebugdisp;
    designer.savecanceled(); //reset saveall flag
  end;

var
  namebefore: msestring;
  projectfilebefore: msestring;
  projectdirbefore: msestring;
  str1: ttextstream;
  thedir: msestring;
begin
  gdb.abort;
  terminategdbserver(True);
  Result := False;

  TheProjectDirectory := ExtractFilePath(ExpandFileName(aname));

  debuggerfo.project_history.Value := ExpandFileName(aname);

  theprojectname := aname;

  if Assigned(debuggerfo) then
  begin
    debuggerfo.find_in_directory.hint := stockobjects.captions[sc_searchindirectories];

    debuggerfo.line_number.hint := projectoptionstext(po_linenumbers);

    debuggerfo.terminal_run.hint := projectoptionstext(po_showconsole);

    debuggerfo.project_open.hint := stockobjects.captions[sc_openproject];
    debuggerfo.open_file.hint    := stockobjects.captions[sc_openfile];
    debuggerfo.save_file.hint    := stockobjects.captions[sc_save];

    debuggerfo.code_beauty.hint := stockobjects.captions[sc_beautifier];

    debuggerfo.procedure_list.hint := stockobjects.captions[sc_proclist];


    debuggerfo.find_in_edit.hint := stockobjects.captions[sc_searchincurrentfile];


    debuggerfo.project_save.hint := stockobjects.captions[sc_save];

    debuggerfo.project_option.hint := projectoptionstext(po_projectoptions);


    debuggerfo.project_make.hint := ' ' + mainformtext(ma_project) +
      ' : ' + stockobjects.captions[sc_make] + ' ' + ExtractFilename(aname) + ' ';

    debuggerfo.project_start.hint := ' ' + mainformtext(ma_project) +
      ' : ' + stockobjects.captions[sc_debugrun] + ' ' + ExtractFilename(aname) + ' ';

    debuggerfo.project_save.hint := ' ' + mainformtext(ma_project) +
      ' : ' + stockobjects.captions[sc_save] + ' ' + ExtractFilename(aname) + ' ';

    debuggerfo.project_interrupt.hint := ' ' + mainformtext(ma_project) +
      ' : ' + stockobjects.captions[sc_abortmake] + ' ' + ExtractFilename(aname) + ' ';

    debuggerfo.project_next.hint := ' ' + mainformtext(ma_project) +
      ' : ' + stockobjects.captions[sc_nextinstruction] + ' ' + ExtractFilename(aname) + ' ';

    debuggerfo.project_step.hint := ' ' + mainformtext(ma_project) +
      ' : ' + stockobjects.captions[sc_stepinstruction] + ' ' + ExtractFilename(aname) + ' ';

    debuggerfo.project_finish.hint := ' ' + mainformtext(ma_project) +
      ' : ' + stockobjects.captions[sc_finish] + ' ' + ExtractFilename(aname) + ' ';

    debuggerfo.project_next_instruction.hint := ' ' + mainformtext(ma_project) +
      ' : ' + stockobjects.captions[sc_nextinstruction] + ' ' +
      stockobjects.captions[sc_assembler] + ' ' +
      ExtractFilename(aname) + ' ';

    debuggerfo.project_step_instruction.hint := ' ' + mainformtext(ma_project) +
      ' : ' + stockobjects.captions[sc_stepinstruction] + ' ' +
      stockobjects.captions[sc_assembler] + ' ' +
      ExtractFilename(aname) + ' ';

    debuggerfo.project_reset.hint := ' ' + mainformtext(ma_project) +
      ' : ' + stockobjects.captions[sc_reset] + ' ' +
      ExtractFilename(aname) + ' ';

  end;

  projectfilebefore := projectoptions.projectfilename;
  projectdirbefore  := projectoptions.projectdir;
  namebefore        := fprojectname;
  if (checksave <> mr_cancel) and closeall(True) then
  begin
    closepro;
    if aname <> '' then
    begin
      try
        setcurrentdirmse(removelastpathsection(aname));
      except
        application.handleexception(nil, mainformtext(ma_cannotloadproj) + aname + '": ');
        Exit;
      end;
      if not readprojectoptions(aname) then
        closepro
      else
      begin
        fcurrent := False;
        gdb.closegdb;
        cleardebugdisp;
        if not ascopy then
          setprojectname(aname)
        else
        begin
          projectoptions.projectfilename := projectfilebefore;
          projectoptions.projectdir      := projectdirbefore;
          expandprojectmacros;
          setprojectname(namebefore);
        end;
      end;
    end;
    Result         := True;
    fprojectloaded := True;

    if projectoptions.d.showconsole = True then
    begin
      debuggerfo.terminal_run.tag := 1;
      debuggerfo.terminal_run.face.image.alignment :=
        [al_stretchx, al_stretchy];
    end
    else
    begin
      debuggerfo.terminal_run.tag := 0;
      debuggerfo.terminal_run.face.image.alignment :=
        [al_grayed, al_stretchx, al_stretchy];

    end;
    application.ProcessMessages;

    if projectoptions.o.enablesource = false then
      actionsmo.projectsourceexe(nil)
    else if sourcefo.files_tab.Count = 0 then
      actionsmo.projectsourceexe(nil);

  end;
  sourcefo.updatehinttab;
 
  if (confideufo.usedefaulteditoroptions.Value) then
  begin
    layoutbusy := True;
    if Assigned(sourcefo.ActivePage) then
    begin
      if han <> -1 then
        sourcefo.syntaxpainter.freedeffile(han);

      thedir := tosysfilepath(confideufo.defsynt.Text);

      str1 := ttextstream.Create(thedir);

      han := sourcefo.syntaxpainter.readdeffile(str1);
      sourcefo.ActivePage.edit.setsyntaxdef(han);
      sourcefo.ActivePage.updatestatvalues;
      str1.Destroy();
    end;

    thedir := tosysfilepath(confideufo.deflayout.Text);

    if fileexists(thedir) then
    begin
      sleep(10);
      str1 := ttextstream.Create(thedir);
      debuggerfo.Close;
      loadwindowlayout(str1);


      if (tabind < 0) and (sourcefo.files_tab.Count > 0) then
        sourcefo.files_tab.activepageindex := 0;

      if (tabind > -1) and (sourcefo.files_tab.Count > 0) then
        sourcefo.files_tab.activepageindex := tabind;

      str1.Destroy();
    end;
    
    sourcefo.files_tab.activepageindex := 0;
    sourcefo.ActivePage.setfocus;

    layoutbusy := False;

  end;

  //}
end;

procedure tmainfo.saveproject(aname: filenamety; const ascopy: Boolean = False);
begin
  if aname <> '' then
    try
      saveprojectoptions(aname);
      if not ascopy then
      begin
        setprojectname(aname);
        expandprojectmacros;
      end;
    except
    end;
end;

procedure tmainfo.newproject(const fromprogram, empty: Boolean);
var
  aname: filenamety;
  mstr1, mstr2: msestring;
  i1: integer;
  curdir, Source, dest: filenamety;
  macrolist: tmacrolist;
  copiedfiles: filenamearty;
  bo1: Boolean;
label
  endlab;
begin
  mstr2 := projecttemplatedir; //use macros of current project
  if fromprogram then
  begin
    if (checksave() = mr_cancel) or not closeall(False) then
      Exit;
    setprojectname('');
  end;
  if fromprogram or openproject('') then
  begin
    gdb.closegdb;
    cleardebugdisp;
    sourcechanged(nil);
    mstr1 := '';
    if not fromprogram then
    begin
      if not empty then
      begin
        aname := mstr2 + 'default.prj';
        if filedialogx(aname, [fdo_checkexist], mainformtext(ma_selecttemplate),
          [mainformtext(ma_projectfiles), mainformtext(ma_str_allfiles)],
          ['*.prj', '*'], 'prj') = mr_ok then
          readprojectoptions(aname);
      end;
      aname := '';
    end
    else
    begin
      aname := '';
      if filedialogx(aname, [fdo_checkexist], mainformtext(ma_selectprogramfile),
        [mainformtext(ma_pascalprogfiles), mainformtext(ma_cfiles), mainformtext(ma_str_allfiles)],
        ['"*.pas" "*.pp" "*.mla" "*.dpr" "*.lpr"', '"*.c" "*.cc" "*.cpp"', '*'],
        'pas') = mr_ok then
      begin
        setcurrentdirmse(filedir(aname));
        with projectoptions do
        begin
          with o.t do
          begin
            mainfile   := filename(aname);
            aname      := removefileext(mainfile);
            targetfile := aname + '${EXEEXT}';
          end;
          expandprojectmacros;
        end;
        if not directoryexists(filepath(aname) + directoryseparator + 'units') then
          msefileutils.createdir(filepath(aname) + directoryseparator + 'units');
        aname := aname + '.prj';
      end
      else
        goto endlab;
    end;
    if filedialogx(aname, [fdo_save, fdo_checkexist], mainformtext(ma_str_newproject),
      [mainformtext(ma_projectfiles), mainformtext(ma_str_allfiles)],
      ['*.prj', '*'], 'prj') = mr_ok then
    begin
      curdir := filedir(aname);
      if not directoryexists(curdir + directoryseparator + 'units') then
        msefileutils.createdir(curdir + directoryseparator + 'units');

      setcurrentdirmse(curdir);
      insertitem(projecthistory, 0, aname);
      i1 := 1;
      while i1 <= high(projecthistory) do
      begin
        if projecthistory[i1] = aname then
          deleteitem(projecthistory, i1);
        Inc(i1);
      end;
      if high(projecthistory) >=
        projectfiledia.controller.historymaxcount then
        setlength(projecthistory, projectfiledia.controller.historymaxcount);
      if not fromprogram then
      begin
        mstr1 := removefileext(filename(aname));
        with projectoptions, o do
        begin
          projectfilename := aname;
          projectdir      := curdir;
          expandprojectmacros;
          with o.texp do
          begin
            setlength(copiedfiles, length(newprojectfiles));
            macrolist := tmacrolist.Create([mao_curlybraceonly]);
            try
              macrolist.add(['%PROJECTNAME%', '%PROJECTDIR%'], [mstr1, curdir], []);
              if runscript(scriptbeforecopy, True, False) then
              begin
                for i1 := 0 to high(newprojectfiles) do
                begin
                  Source := filepath(newprojectfiles[i1]);
                  if i1 <= high(newprojectfilesdest) then
                    dest := newprojectfilesdest[i1]
                  else
                    dest := '';
                  if dest <> '' then
                  begin
                    macrolist.expandmacros1(dest);
                    if Source = '' then
                      createdirpath(dest)
                    else
                    begin
                      createdirpath(filedir(dest));
                    end;
                  end
                  else
                    dest          := filename(Source);
                  copiedfiles[i1] := dest;
                  if newprojectfiles[i1] <> '' then
                    if (i1 <= high(o.expandprojectfilemacros)) and
                      o.expandprojectfilemacros[i1] then
                      copynewfile(Source, dest, False, False, ['%PROJECTNAME%', '%PROJECTDIR%'],
                        [mstr1, curdir])
                    else
                      try
                        if not copyfile(Source, dest, False) then
                          showerror(mainformtext(ma_str_file) + dest + mainformtext(ma_exists));
                      except
                        application.handleexception(nil);
                      end;
                end;
                runscript(scriptaftercopy, False, False);
              end;
            finally
              macrolist.Free;
            end;
          end;
          saveproject(aname);
          bo1    := True;
          for i1 := 0 to high(copiedfiles) do
          begin
            if i1 > high(o.loadprojectfile) then
              break;
            if o.loadprojectfile[i1] then
              if checkfileext(copiedfiles[i1], [formfileext]) then
                openformfile(copiedfiles[i1], True, False, False, True, False)
              else
              begin
                sourcefo.openfile(copiedfiles[i1], bo1);
                bo1 := False;
              end;
          end;
        end;
      end
      else
      begin
        if not directoryexists(filedir(aname) + directoryseparator + 'units') then
          msefileutils.createdir(filedir(aname) + directoryseparator + 'units');


        saveproject(aname);
        sourcefo.openfile(projectoptions.o.texp.mainfile, True);
      end;
    end
    else
    begin
      endlab:
        projectoptions.projectfilename := '';
      projectoptions.modified          := True;
    end;
  end;
end;

procedure tmainfo.newprojectonexecute(const Sender: TObject);
begin
  newproject(False, False);
end;

procedure tmainfo.newprojectfromprogramexe(const Sender: TObject);
begin
  newproject(True, False);
end;

procedure tmainfo.newemptyprojectexe(const Sender: TObject);
begin
  newproject(False, True);
end;

procedure tmainfo.openprojectcopyexecute(const Sender: TObject);
var
  str1: filenamety;
begin
  if projectfiledialog(str1, False) = mr_ok then
    openproject(str1, True);
end;

procedure tmainfo.saveprojectasonexecute(const Sender: TObject);
var
  str1: filenamety;
begin
  if projectfiledialog(str1, True) = mr_ok then
    saveproject(str1);
end;

procedure tmainfo.saveprojectcopyexecute(const Sender: TObject);
var
  str1: filenamety;
begin
  if projectfiledialog(str1, True) = mr_ok then
    saveproject(str1, True);
end;

procedure tmainfo.mainstatfileonupdatestat(const Sender: TObject; const filer: tstatfiler);
var
  mstr1: filenamety;
  ar1: msestringarty;
  int1: integer;
begin
  ar1 := nil; //compiler warning
  updatesettings(filer);

  mstr1 := projectoptions.projectfilename;
  filer.updatevalue('projectname', mstr1);
  filer.updatevalue('projecthistory', projecthistory);
  filer.updatevalue('windowlayoutfile', windowlayoutfile);
  filer.updatevalue('windowlayouthistory', windowlayouthistory);

  if not filer.iswriter then
    if guitemplatesmo.sysenv.defined[Ord(env_filename)] then
    begin
      ar1     := guitemplatesmo.sysenv.values[Ord(env_filename)];
      if (high(ar1) = 0) and (fileext(ar1[0]) = 'prj') then
        mstr1 := filepath(ar1[0])
      else
      begin
        if high(ar1) >= 0 then
          for int1 := 0 to high(ar1) do
            sourcefo.openfile(ar1[int1], int1 = 0);
        Exit;
      end;
    end;
  if not filer.iswriter and (mstr1 <> '') and not
    guitemplatesmo.sysenv.defined[Ord(env_np)] then
    openproject(mstr1);
end;

procedure tmainfo.targetfilemodified;
begin
  ftargetfilemodified := True;
end;

procedure tmainfo.domake(atag: integer);
begin
  unloadexec;
  if designer.beforemake and (checksavecancel(sourcefo.saveall(True)) <>
    mr_cancel) and (checksavecancel(designer.saveall(True, True)) <> mr_cancel) then
  begin
    updatemodifiedforms;
    ftargetfilemodified := False;
    //make.domake(atag);
    actionsmo.custcompileproject(nil);
  end;
end;

procedure tmainfo.customdomake(aname: filenamety; acompiler: integer; acompilertag: integer; atag: integer);
begin
  unloadexec;
  if designer.beforemake and (checksavecancel(sourcefo.saveall(True)) <>
    mr_cancel) and (checksavecancel(designer.saveall(True, True)) <> mr_cancel) then
  begin
    updatemodifiedforms;
    ftargetfilemodified := False;
    make.customdomake(aname, acompiler, acompilertag, atag);
  end;
end;

procedure tmainfo.dorun;
var
  mstr1: msestring;
  pwdbefore: msestring;
begin
  if projectoptions.d.texp.runcommand = '' then
  begin
    if not projectoptions.d.gdbsimulator then
    begin
      if startgdbconnection(False) then
      begin
        gdb.gdbdownload := projectoptions.d.gdbdownload and needsdownload;
        checkgdberror(gdb.run);
      end;
    end
    else
    begin
      checkgdberror(gdb.run);
    end;
  end
  else
  begin
    with projectoptions, d.texp do
    begin
      mstr1       := runcommand;
      if progparameters <> '' then
        mstr1     := mstr1 + ' ' + progparameters;
      if progworkingdirectory <> '' then
        pwdbefore := setcurrentdirmse(progworkingdirectory);
      try
        if projectoptions.d.externalconsole then
          frunningprocess := execmse4(mstr1, [exo_newconsole])
        else
        begin
          startconsole();
          frunningprocess := targetconsolefo.terminal.execprog(mstr1);
        end;
        if frunningprocess = invalidprochandle then
        begin
          setstattext(mainformtext(ma_cannotstartprocess), mtk_error);
          Exit;
        end;
        runprocmon.listentoprocess(frunningprocess);
      finally
        if progworkingdirectory <> '' then
          setcurrentdirmse(pwdbefore);
      end;
    end;
    setstattext('*** ' + mainformtext(ma_process) + ' ' + inttostrmse(frunningprocess) + ' ' +
      mainformtext(ma_running3) + ' ***', mtk_making);
    debuggerfo.project_reset.Enabled     := True;
    debuggerfo.project_interrupt.Enabled := True;
  end;
end;

procedure tmainfo.runprocdied(const Sender: TObject; const prochandle: prochandlety; const execresult: integer; const Data: Pointer);
begin

  if prochandle = frunningprocess then
  begin
    frunningprocess := invalidprochandle;
    if execresult <> 0 then
      setstattext(mainformtext(ma_processterminated) + ' ' + UTF8Decode(IntToStr(execresult)) + '.',
        mtk_error)
    else
      setstattext(mainformtext(ma_proctermnormally), mtk_finished);
  end;

  debuggerfo.project_reset.Enabled     := False;
  debuggerfo.project_interrupt.Enabled := False;
end;

function tmainfo.runtarget: Boolean;
  //true if run possible
begin
  Result := True;
  if not gdb.attached then
    if projectoptions.d.texp.runcommand = '' then
    begin
      if not gdb.started then
        if loadexec(False, False) then
        begin
          Result := False;
          dorun;
        end;
    end
    else
    begin
      Result := False;
      dorun;
    end;
end;

function tmainfo.checkremake(startcommand: startcommandty): Boolean;
  //true if running possible
begin
  if not objectinspectorfo.canclose(nil) then
  begin
    Result := False;
    Exit;
  end;
  Result        := True;
  fstartcommand := startcommand;
  if not gdb.active then
    startgdb(False);
  if not gdb.attached then
  begin
    if (not gdb.started or not fnoremakecheck) and not fcurrent then
    begin
      if (projectoptions.defaultmake <= maxdefaultmake) and
        (not gdb.started or askconfirmation(mainformtext(ma_str_sourcechanged))) then
      begin
        Result := False;
        watchpointsfo.Clear;
        // domake(projectoptions.defaultmake);
        actionsmo.custcompileproject(nil);
      end;
      fnoremakecheck := True;
    end;
    if Result then
      Result := runtarget;
  end
  else if not gdb.started then
  begin
    Result := False;
    dorun;
  end;
end;

procedure tmainfo.runexec(const Sender: TObject);
begin
  if checkremake(sc_continue) then
    dorun;
end;

procedure tmainfo.aftermake(const adesigner: idesigner; const exitcode: integer);
var
  str3: msestring;
  int3: integer;
begin
  actionsmo.finishcustom;

  if exitcode <> 0 then
  begin
    setstattext(mainformtext(ma_makeerror) + ' ' + UTF8Decode(IntToStr(exitcode)) + '.', mtk_error);
    showfirsterror;
  end
  else
  begin

    setstattext(mainformtext(ma_makeok), mtk_finished);
    fcurrent       := True;
    fnoremakecheck := False;
    messagefo.Messages.lastrow;

    if confideufo.usedefaulteditoroptions.Value then
    begin
      if confideufo.closemessages.Value then
        messagefo.hide;
    end
    else if projectoptions.o.closemessages then
      messagefo.hide;
    ;

    /// fred debugger

    str3 := '';

    case debuggerfo.project_options.Value of
      'M': thetag := 1;
      'B': thetag := 2;
      '1': thetag := 4;
      '2': thetag := 8;
      '3': thetag := 16;
      '4': thetag := 32;
      '5': thetag := 64;
      '6': thetag := 128;
      '7': thetag := 256;
      '8': thetag := 512;
      '9': thetag := 1024;
      '0': thetag := 2048;
    end;

    with projectoptions, o, texp do
      for int3 := 0 to high(debuggerused) do
        if (thetag and debuggerusedon[int3] <> 0) and (debuggerused[int3] <> '') then
          if system.pos('Default', debuggerused[int3]) > 0 then
            str3 := 'Default Debugger'
          else if (trim(debuggerused[int3]) = 'Debugger 1') then
            str3 := quotefilename(tosysfilepath(confdebuggerfo.debugger1.Value))
          else if (trim(debuggerused[int3]) = 'Debugger 2') then
            str3 := quotefilename(tosysfilepath(confdebuggerfo.debugger2.Value))
          else if (trim(debuggerused[int3]) = 'Debugger 3') then
            str3 := quotefilename(tosysfilepath(confdebuggerfo.debugger3.Value))
          else if (trim(debuggerused[int3]) = 'Debugger 4') then
            str3 := (quotefilename(tosysfilepath(confdebuggerfo.debugger4.Value)))
          else
            str3 := '';

    if str3 <> '' then
    else if fstartcommand <> sc_none then
      runtarget;

  end;
end;


procedure Tmainfo.resetstartcommand;
begin
  fstartcommand := sc_none;
end;

procedure tmainfo.killtarget;
begin
  actionsmo.finishcustom;

  if frunningprocess <> invalidprochandle then
  begin
    killprocess(frunningprocess);
    frunningprocess := invalidprochandle;
  end;
end;

procedure tmainfo.sourcechanged(const Sender: tsourcepage);
begin
  fnoremakecheck := False;
  fcurrent       := False;
  if Sender = nil then
    updatemodifiedforms;
end;

procedure tmainfo.exitonexecute(const Sender: TObject);
begin
  window.Close;
end;

procedure tmainfo.moduledestroyed(const adesigner: idesigner; const amodule: tmsecomponent);
var
  po1: pmoduleinfoty;
begin
  po1 := designer.modules.findmodulebyinstance(amodule);
  removemodulemenuitem(po1);
  if po1 = factivedesignmodule then
    factivedesignmodule := nil;
end;

procedure tmainfo.methodcreated(const adesigner: idesigner; const amodule: tmsecomponent; const aname: string; const atype: ptypeinfo);
begin
  //dummy
end;

procedure tmainfo.methodnamechanged(const adesigner: idesigner; const amodule: tmsecomponent; const newname, oldname: string; const atypeinfo: ptypeinfo);
begin
  //dummy
end;

procedure tmainfo.showobjecttext(const adesigner: idesigner; const afilename: filenamety; const backupcreated: Boolean);
var
  page: tsourcepage;
begin
  page := sourcefo.openfile(afilename, True);
  if page <> nil then
  begin
    page.ismoduletext := True;
    if backupcreated then
      page.setbackupcreated;
  end;
end;

procedure tmainfo.closeobjecttext(const adesigner: idesigner; const afilename: filenamety; var cancel: Boolean);
begin
  cancel := not sourcefo.closepage(afilename);
end;

procedure tmainfo.newpanelonexecute(const Sender: TObject);
begin
  newpanel.activate;
  //paneltitlefo.show(true);
end;

procedure tmainfo.viewwatchpointsonexecute(const Sender: TObject);
begin
  watchpointsfo.activate;
end;

  //fred
procedure tmainfo.viewconfmseguiexecute(const Sender: TObject);
begin
  // confmseguifo.activate;
  confmseguifo.Show(True);
end;

procedure tmainfo.viewconfcompilersexecute(const Sender: TObject);
begin
  // confcompilerfo.activate;
  confcompilerfo.Show(True);
end;

procedure tmainfo.viewconfdebuggersexecute(const Sender: TObject);
begin
  //confdebuggerfo.activate;
  confdebuggerfo.Show(True);
end;

procedure tmainfo.viewconfideuexecute(const Sender: TObject);
begin
  //confideufo.activate;
  confideufo.Show(True);
end;

procedure tmainfo.viewconffpguiexecute(const Sender: TObject);
begin
  // conffpguifo.activate;
  conffpguifo.Show(True);
end;

procedure tmainfo.viewsymbolsonexecute(const Sender: TObject);
begin
  symbolfo.activate;
end;

procedure tmainfo.viewthreadsonexecute(const Sender: TObject);
begin

  threadsfo.activate;
  if threadsfo.Width < 50 then
  begin
    threadsfo.Height := 180;
    threadsfo.Width  := 250;
  end;
end;

procedure tmainfo.viewconsoleonexecute(const Sender: TObject);
begin
  targetconsolefo.activate;
end;

procedure tmainfo.viewfindresults(const Sender: TObject);
begin
  findinfilefo.activate;

end;

procedure tmainfo.aboutonexecute(const Sender: TObject);
begin
  aboutfo.font.Height := confideufo.fontsize.Value;
  aboutfo.Caption     := stockobjects.captions[sc_about] + ' MSEgui';

  aboutfo.about_text.frame.colorclient := $B2F4FF;

  aboutfo.about_text.Value :=
    c_linefeed + 'MSEgui v' + mseguiversiontext +
    c_linefeed + c_linefeed + c_linefeed +
    stockobjects.captions[sc_host] +': ' + platformtext +
    c_linefeed +  c_linefeed + c_linefeed +
    ' Martin Schreiber' + 
     c_linefeed + 
     stockobjects.captions[sc_copyright] + ' 1999-2021' +
      c_linefeed +
    'https://github.com/mse-org/mseide-msegui';

  aboutfo.about_text.Height := 15 * confideufo.fontsize.Value;
  aboutfo.Height := aboutfo.about_text.Height + 16;


  aboutfo.Show(True);

end;

procedure tmainfo.aboutfpguionexecute(const Sender: TObject);
begin
  aboutfo.font.Height := confideufo.fontsize.Value;
  aboutfo.Caption := stockobjects.captions[sc_about] + ' fpGUI';
  aboutfo.about_text.frame.colorclient := $FFF5B2;
  aboutfo.about_text.Value :=
    c_linefeed + 'fpGUI v1.4' +
    c_linefeed + c_linefeed + c_linefeed +
    stockobjects.captions[sc_host] + ': ' + platformtext +
    c_linefeed + c_linefeed + 
    ' Graeme Geldenhuys' + 
    c_linefeed + 
    '<graemeg@gmail.com>' +
    c_linefeed +
    stockobjects.captions[sc_copyright] + ' 1999-2021';
   
   aboutfo.about_text.Height := 13 * confideufo.fontsize.Value;
  aboutfo.Height := aboutfo.about_text.Height + 16;

  aboutfo.Show(True);
end;

procedure tmainfo.aboutideuonexecute(const Sender: TObject);
begin
  aboutfo.font.Height      := confideufo.fontsize.Value;
  aboutfo.Caption          := stockobjects.captions[sc_about] + ' ideU';
  aboutfo.about_text.frame.colorclient := $DFFFB2;
  aboutfo.about_text.Value :=
    c_linefeed + 'ideU v' + versiontext +
    c_linefeed + c_linefeed + c_linefeed +
    stockobjects.captions[sc_host] + ': ' +  platformtext +
    c_linefeed +  c_linefeed + c_linefeed +
    'Fred van Stappen' +
    c_linefeed + 
    '<fiens@hotmail.com>'  + c_linefeed +
    stockobjects.captions[sc_copyright] + ' 1999-2021';

  aboutfo.about_text.Height := 15 * confideufo.fontsize.Value;
  aboutfo.Height := aboutfo.about_text.Height + 16;

  aboutfo.Show(True);
end;


procedure tmainfo.configureexecute(const Sender: TObject);
begin
  configureide;
end;

procedure tmainfo.beforemake(const adesigner: idesigner; const maketag: integer; var abort: Boolean);
begin
  //dummy
end;


procedure tmainfo.beforefilesave(const adesigner: idesigner; const afilename: filenamety);
begin
  //dummy
end;

procedure tmainfo.runtool(const Sender: TObject);
var
  str1: msestring;
  mstr1: msestring;
  macrolist: tmacrolist;
  // gridcoord1: gridcoordty;
  cursourcefile, curmodulefile, cursselection, cursword, cursdefinition: msestring;
  curcomponentclass, curproperty: msestring;
  spos1: sourceposty;
  ar1: componentarty;
  propit: tpropertyitem;
  opt1: execoptionsty;
begin
  with tmenuitem(Sender), projectoptions, o, texp do
  begin
    str1 := tosysfilepath(toolfiles[index]);
    if str1 <> '' then
    begin
      if (index <= high(toolfiles)) and (toolparams[index] <> '') then
      begin
        if (index <= high(toolsave)) and toolsave[index] then
          actionsmo.saveallactonexecute(nil);
        if sourcefo.ActivePage <> nil then
        begin
          with sourcefo.ActivePage do
          begin
            cursourcefile := tosysfilepath(sourcefo.currentfilename);
            cursselection := sourcefo.currentselection;//edit.selectedtext;
            cursword      := sourcefo.currentwordatcursor;
            //getpascalvarname(edit,edit.editpos,gridcoord1);
            if (index <= high(toolparse)) and toolparse[index] then
            begin
              spos1.pos      := edit.editpos;
              spos1.filename := designer.designfiles.find(edit.filename);
              application.beginwait;
              try
                findlinkdest(edit, spos1, cursdefinition);
              finally
                application.endwait;
              end;
            end;
          end;
        end
        else
        begin
          cursourcefile  := '';
          cursselection  := '';
          cursword       := '';
          cursdefinition := '';
        end;
        curcomponentclass := '';
        curproperty := '';
        if factivedesignmodule <> nil then
        begin
          curmodulefile := tosysfilepath(factivedesignmodule^.filename);
          ar1           := designer.selectedcomponents;
          if high(ar1) = 0 then
          begin
            with gettypedata(ar1[0].classinfo)^ do
              curcomponentclass := UTF8Decode(uppercase(unitname + '.' + ar1[0].ClassName));
            propit := tpropertyitem(objectinspectorfo.props.item);
            if propit <> nil then
              curproperty := curcomponentclass + '.' + uppercase(propit.rootpath);
          end;
        end
        else
          curmodulefile := '';
        mstr1           := toolparams[index];
        if mstr1 <> '' then
        begin
          macrolist := tmacrolist.Create([mao_caseinsensitive]);
          macrolist.add(getprojectmacros);
          macrolist.add(['CURSOURCEFILE', 'CURMODULEFILE',
            'CURSSELECTION', 'CURSWORD', 'CURSDEFINITION',
            'CURCOMPONENTCLASS', 'CURPROPERTY'],
            [cursourcefile, curmodulefile,
            cursselection, cursword, cursdefinition,
            curcomponentclass, curproperty], []);
          macrolist.expandmacros1(mstr1);
          macrolist.Free;
          str1 := ((str1) + ' ' + mstr1);
        end;
      end;
      opt1 := [exo_nostdhandle];
      if not ((index > high(toolhide)) or toolhide[index]) then
        include(opt1, exo_inactive);
      if (index <= high(toolmessages)) and toolmessages[index] then
        ttoolhandlermo.Create(self, (str1), opt1)
      else
        execmse((str1), opt1{not((index > high(toolhide)) or toolhide[index]),true});
    end;
  end;
end;

procedure tmainfo.statbefread(const Sender: TObject);
begin
  createcpufo;
end;

procedure tmainfo.getstatobjs(const Sender: TObject; var aobjects: objectinfoarty);
begin
  with projectoptions do
  begin
    addobjectinfoitem(aobjects, o);
    if not (sg_editor in disabled) then
      addobjectinfoitem(aobjects, e);
    if not (sg_debugger in disabled) then
      addobjectinfoitem(aobjects, d);
  end;
end;

procedure tmainfo.savewindowlayout(const astream: ttextstream);
var
  statwriter: tstatwriter;
begin
  statwriter := tstatwriter.Create(astream, ce_utf8);
  try
    statwriter.setsection('breakpoints');
    beginpanelplacement();
    try
      panelform.updatestat(statwriter);
      statwriter.setsection('layout');
      mainfo.projectstatfile.updatestat('windowlayout', statwriter);
    finally
      endpanelplacement();
    end;
  finally
    statwriter.Free;
  end;
end;

procedure tmainfo.loadwindowlayout(const areader: tstatreader);
begin
  beginpanelplacement();
  try
    areader.setsection('breakpoints');
    panelform.updatestat(areader);
    areader.setsection('layout');
    projectstatfile.options := projectstatfile.options +
      [sfo_nodata, sfo_nooptions];
    flayoutloading          := True;
    projectstatfile.readstat('windowlayout', areader);
  finally
    flayoutloading          := False;
    projectstatfile.options := projectstatfile.options -
      [sfo_nodata, sfo_nooptions];
    endpanelplacement();
  end;
end;

procedure tmainfo.loadwindowlayout(const astream: ttextstream);
var
  statreader: tstatreader;
begin
  statreader := tstatreader.Create(astream, ce_utf8);
  try
    loadwindowlayout(statreader);
  finally
    statreader.Free;
  end;
end;


procedure tmainfo.loadwindowlayoutexe(const Sender: TObject);
var
  str1: ttextstream;
begin
  if filedialogx(windowlayoutfile, [fdo_checkexist], mainformtext(ma_str_loadwindowlayout),
    [mainformtext(ma_projectfiles), mainformtext(ma_str_allfiles)], ['*.prj', '*'], 'prj',
    nil, nil, nil, [fa_all], [fa_hidden], @windowlayouthistory) = mr_ok then
  begin
    str1 := ttextstream.Create(windowlayoutfile);
    try
      loadwindowlayout(str1);
    finally
      str1.Destroy();
    end;
  end;
end;

// fred layout
procedure tmainfo.menuwindowlayoutexe(const Sender: TObject);
begin
if Assigned(sourcefo.ActivePage) then
  begin
 

  if not dialogfilesformcreated then
    dodialogfiles;

  //  writeln('ok dodialogfiles'); 

  dothemedialog();

  //  writeln('ok dothemedialog'); 

  dialogfilesfo.tag := 1;

  dialogfilesfo.Caption := mainformtext(ma_str_loadwindowlayout);
  //'Load a Layout File';

  // dialogfilesfo.list_files.cellwidth := 437;
  dialogfilesfo.list_files.mask := '*.prj';
  dialogfilesfo.list_files.path := expandprmacros('${LAYOUTDIR}');

  //    writeln('ok macros'); 

  tabind := sourcefo.files_tab.activepageindex;

  //  writeln('ok tabind'); 

  dialogfilesfo.selected_file.frame.Caption := stockcaptions(sc_file);

  //'Selected Layout File';
  // from ' + dialogfilesfo.list_files.directory ;
  dialogfilesfo.selected_file.Text := '';
  //dialogfilesfo.activate;

  //  writeln('ok selected_file'); 

  if ismodal then
    dialogfilesfo.Show(True)
  else
  begin
    dialogfilesfo.Show;
    dialogfilesfo.bringtofront;
  end;
  
end;  

end;

procedure tmainfo.closeprojectactonexecute(const Sender: TObject);
var
  str1: ttextstream;
  str2: msestring;
begin
  if mainfo.openproject('') then
  begin
    Caption        := idecaption;
    fprojectloaded := False;
    str2           := expandprmacros('${LAYOUTDIR}') + 'Menu_Only.prj';
    if fileexists(str2) then
    begin
      str1 := ttextstream.Create(str2);
      try
        debuggerfo.Close;
        mainfo.loadwindowlayout(str1);
      finally
        str1.Destroy();
      end;
    end;
  
  end;
  
  theprojectname := '';
end;

procedure tmainfo.mainstatbeforewriteexe(const Sender: TObject);
begin
  disassfo.resetshortcuts();
end;

procedure tmainfo.statafterread(const Sender: TObject);
begin
  actionsmo.forcezorderact.Checked := projectoptions.o.forcezorder;
end;

procedure tmainfo.basedockpaintexe(const Sender: twidget; const acanvas: tcanvas);
begin
  paintdockingareacaption(acanvas, Sender, mainformtext(ma_dockingarea));
end;

procedure tmainfo.copywordatcur(const Sender: TObject);
begin
  sourcefo.ActivePage.copywordatcursor();
end;

procedure tmainfo.onresizemain(const Sender: TObject);
var
  screen: rectty;
begin
  screen   := application.workarea();
  if Height > screen.y + screen.cy then
    Height := screen.y + screen.cy - 30;

  if Width > screen.x + screen.cx then
    Width := screen.x + screen.cx;
end;

procedure tmainfo.closeallmod(const Sender: TObject);
begin
  closeallmodule();
end;

procedure tmainfo.setlang(thelang: string);
var
  item1: tmenuitem;
  x: shortint;
  stca : stockcaptionty;
begin

  setlangconsts(thelang);

  with stockobjects do
  begin
    mainmenu1.menu.itembynames(['file', 'quit']).Caption  := actionsmoduletext(ac_configureideu);
    mainmenu1.menu.itembynames(['file']).Caption          := '&' + captions[sc_file];
    mainmenu1.menu.itembynames(['file', 'new']).Caption   := captions[sc_newfile];
    mainmenu1.menu.itembynames(['file', 'open']).Caption  := captions[sc_open];
    mainmenu1.menu.itembynames(['file', 'save']).Caption  := captions[sc_save];
    mainmenu1.menu.itembynames(['file', 'saveas']).Caption := captions[sc_saveas];
    mainmenu1.menu.itembynames(['file', 'saveall']).Caption := captions[sc_saveall];
    mainmenu1.menu.itembynames(['file', 'close']).Caption := captions[sc_close];
    mainmenu1.menu.itembynames(['file', 'closeall']).Caption := captions[sc_closeall];
    mainmenu1.menu.itembynames(['file', 'print']).Caption := captions[sc_print];
    mainmenu1.menu.itembynames(['file', 'quit']).Caption  := captions[sc_quit];
    mainmenu1.menu.itembynames(['search']).Caption        := '&' + captions[sc_search];
    mainmenu1.menu.itembynames(['search', 'line']).Caption := captions[sc_line];
    mainmenu1.menu.itembynames(['search', 'find']).Caption := captions[sc_search];
    mainmenu1.menu.itembynames(['search', 'searchagain']).Caption := captions[sc_search_again];
    mainmenu1.menu.itembynames(['search', 'searchback']).Caption := captions[sc_search_back];
    mainmenu1.menu.itembynames(['search', 'findreplace']).Caption := captions[sc_find_replace];
    mainmenu1.menu.itembynames(['search', 'findinfile']).Caption := captions[sc_find_infile];
    mainmenu1.menu.itembynames(['search', 'proclist']).Caption := captions[sc_proclist];
    mainmenu1.menu.itembynames(['edit']).Caption          := '&' + captions[sc_edit];
    mainmenu1.menu.itembynames(['edit', 'undo']).Caption  := captions[sc_Undohk];
    mainmenu1.menu.itembynames(['edit', 'redo']).Caption  := captions[sc_Redohk];
    mainmenu1.menu.itembynames(['edit', 'copy']).Caption  := captions[sc_Copyhk];
    mainmenu1.menu.itembynames(['edit', 'cut']).Caption   := captions[sc_Cuthk];
    mainmenu1.menu.itembynames(['edit', 'paste']).Caption := captions[sc_pastehk];
    mainmenu1.menu.itembynames(['edit', 'delete']).Caption := captions[sc_delete];
    mainmenu1.menu.itembynames(['edit', 'selectall']).Caption := captions[sc_Select_allhk];
    mainmenu1.menu.itembynames(['edit', 'selecteditpage']).Caption := captions[sc_select_edit_Page];
    mainmenu1.menu.itembynames(['edit', 'copyatcursor']).Caption := captions[sc_Copy_word_cursor];
    mainmenu1.menu.itembynames(['edit', 'copylatex']).Caption := captions[sc_copy_latex];
    mainmenu1.menu.itembynames(['edit', 'indent']).Caption := captions[sc_indent];
    mainmenu1.menu.itembynames(['edit', 'unindent']).Caption := captions[sc_unindent];
    mainmenu1.menu.itembynames(['target']).Caption        := captions[sc_target];
    mainmenu1.menu.itembynames(['target', 'environment']).Caption := captions[sc_environment];
    mainmenu1.menu.itembynames(['target', 'attachprocess']).Caption := captions[sc_attachprocess];
    mainmenu1.menu.itembynames(['target', 'attachtarget']).Caption := captions[sc_attachtarget];
    mainmenu1.menu.itembynames(['target', 'detachtarget']).Caption := captions[sc_detachtarget];
    mainmenu1.menu.itembynames(['target', 'download']).Caption := captions[sc_download];

    item1 := mainmenu1.menu.itembynames(['tools']);
    if item1 <> nil then
      mainmenu1.menu.itembynames(['tools']).Caption := captions[sc_tools];

    mainmenu1.menu.itembynames(['view']).Caption := captions[sc_view];
    mainmenu1.menu.itembynames(['view', 'panels']).Caption := captions[sc_panels];
    mainmenu1.menu.itembynames(['view', 'forcezorder']).Caption := captions[sc_forcezorder];
    mainmenu1.menu.itembynames(['view', 'source']).Caption := captions[sc_source];
    mainmenu1.menu.itembynames(['view', 'treelist']).Caption := captions[sc_treelist];
    mainmenu1.menu.itembynames(['view', 'messages']).Caption := captions[sc_messages];
    mainmenu1.menu.itembynames(['view', 'findresult']).Caption := captions[sc_findresult];
    mainmenu1.menu.itembynames(['view', 'commander']).Caption := captions[sc_commander];
    mainmenu1.menu.itembynames(['view', 'symbols']).Caption := captions[sc_symbols];
    mainmenu1.menu.itembynames(['view', 'watches']).Caption := captions[sc_watches];
    mainmenu1.menu.itembynames(['view', 'stack']).Caption := captions[sc_stack];
    mainmenu1.menu.itembynames(['view', 'threads']).Caption := captions[sc_threads];
    mainmenu1.menu.itembynames(['view', 'cpu']).Caption := captions[sc_cpu];
    mainmenu1.menu.itembynames(['view', 'assembler']).Caption := captions[sc_assembler];
    mainmenu1.menu.itembynames(['view', 'memory']).Caption := captions[sc_memory];
    mainmenu1.menu.itembynames(['view', 'targetconsole']).Caption := captions[sc_targetconsole];
    mainmenu1.menu.itembynames(['view', 'breakpoints']).Caption := captions[sc_breakpoints];
    mainmenu1.menu.itembynames(['view', 'watchpoints']).Caption := captions[sc_watchpoints];
    mainmenu1.menu.itembynames(['view', 'toggleformunit']).Caption := captions[sc_toggleformunit];
    mainmenu1.menu.itembynames(['layout']).Caption := captions[sc_layout];
    mainmenu1.menu.itembynames(['syntax']).Caption := captions[sc_syntax];
    mainmenu1.menu.itembynames(['project']).Caption := captions[sc_project];
    mainmenu1.menu.itembynames(['project', 'make']).Caption := captions[sc_make];
    mainmenu1.menu.itembynames(['project', 'build']).Caption := captions[sc_build];
    x := 0;

    Inc(x);
    mainmenu1.menu.itembynames(['project', 'make' + IntToStr(x)]).Caption :=
      captions[sc_make] + ' &' + IntToStr(x);
    Inc(x);
    mainmenu1.menu.itembynames(['project', 'make' + IntToStr(x)]).Caption :=
      captions[sc_make] + ' &' + IntToStr(x);
    Inc(x);
    mainmenu1.menu.itembynames(['project', 'make' + IntToStr(x)]).Caption :=
      captions[sc_make] + ' &' + IntToStr(x);
    Inc(x);
    mainmenu1.menu.itembynames(['project', 'make' + IntToStr(x)]).Caption :=
      captions[sc_make] + ' &' + IntToStr(x);
    Inc(x);
    mainmenu1.menu.itembynames(['project', 'make' + IntToStr(x)]).Caption :=
      captions[sc_make] + ' &' + IntToStr(x);
    Inc(x);
    mainmenu1.menu.itembynames(['project', 'make' + IntToStr(x)]).Caption :=
      captions[sc_make] + ' &' + IntToStr(x);
    Inc(x);
    mainmenu1.menu.itembynames(['project', 'make' + IntToStr(x)]).Caption :=
      captions[sc_make] + ' &' + IntToStr(x);
    Inc(x);
    mainmenu1.menu.itembynames(['project', 'make' + IntToStr(x)]).Caption :=
      captions[sc_make] + ' &' + IntToStr(x);
    Inc(x);
    mainmenu1.menu.itembynames(['project', 'make' + IntToStr(x)]).Caption :=
      captions[sc_make] + ' &' + IntToStr(x);

    mainmenu1.menu.itembynames(['project', 'make0']).Caption :=
      captions[sc_make] + ' &0';

    mainmenu1.menu.itembynames(['project', 'abortmake']).Caption := captions[sc_abortmake];
    mainmenu1.menu.itembynames(['project', 'debugrun']).Caption  := captions[sc_debugrun];

    mainmenu1.menu.itembynames(['project', 'debugrun', 'continue']).Caption :=
      modalresulttext[mr_continue];

    mainmenu1.menu.itembynames(['project', 'debugrun', 'interrupt']).Caption :=
      projectoptionscontext(c_SIGINT);

    mainmenu1.menu.itembynames(['project', 'debugrun', 'next']).Caption :=
      captions[sc_next];

    mainmenu1.menu.itembynames(['project', 'debugrun', 'reset']).Caption := captions[sc_reset];

    mainmenu1.menu.itembynames(['project', 'debugrun', 'step']).Caption := captions[sc_cstep];

    mainmenu1.menu.itembynames(['project', 'debugrun', 'stepinstruction']).Caption := captions[sc_stepinstruction];

    mainmenu1.menu.itembynames(['project', 'debugrun', 'nextinstruction']).Caption := captions[sc_nextinstruction];

    mainmenu1.menu.itembynames(['project', 'debugrun', 'restartdebugger']).Caption := captions[sc_restartdebugger];

    mainmenu1.menu.itembynames(['project', 'debugrun', 'togglebreakpoint']).Caption :=
      captions[sc_togglebreakpoint];

    mainmenu1.menu.itembynames(['project', 'debugrun', 'tooglebreakpointenable']).Caption :=
      captions[sc_tooglebreakpointenable];

    mainmenu1.menu.itembynames(['project', 'debugrun', 'finish']).Caption :=
      captions[sc_finish];

    mainmenu1.menu.itembynames(['project', 'debugrun', 'finish']).Caption :=
      projectoptionscontext(c_SIGABRT);

    mainmenu1.menu.itembynames(['project', 'debugrun', 'breakpointson']).Caption :=
      captions[sc_breakpoints] + ' ' + captions[sc_on];

    mainmenu1.menu.itembynames(['project', 'debugrun', 'watcheson']).Caption :=
      captions[sc_watches] + ' ' + captions[sc_on];

    mainmenu1.menu.itembynames(['project', 'debugrun', 'execlinehinton']).Caption :=
      captions[sc_execlinehinton];

    mainmenu1.menu.itembynames(['project', 'options']).Caption := captions[sc_options];
    mainmenu1.menu.itembynames(['project', 'tree']).Caption := captions[sc_tree];
    mainmenu1.menu.itembynames(['project', 'source']).Caption := captions[sc_source];
    mainmenu1.menu.itembynames(['project', 'opencopy']).Caption := captions[sc_opencopy];
    mainmenu1.menu.itembynames(['project', 'saveascopy']).Caption := captions[sc_saveascopy];
    mainmenu1.menu.itembynames(['project', 'new']).Caption := captions[sc_newfile];
    mainmenu1.menu.itembynames(['project', 'open']).Caption := captions[sc_open];
    mainmenu1.menu.itembynames(['project', 'save']).Caption := captions[sc_save];
    mainmenu1.menu.itembynames(['project', 'saveas']).Caption := captions[sc_saveas];
    mainmenu1.menu.itembynames(['project', 'close']).Caption := captions[sc_close];
    mainmenu1.menu.itembynames(['edited']).Caption        := captions[sc_edited];
    mainmenu1.menu.itembynames(['edited', 'make']).Caption := captions[sc_make];
    mainmenu1.menu.itembynames(['edited', 'build']).Caption := captions[sc_build];
    mainmenu1.menu.itembynames(['edited', 'abortmake']).Caption := captions[sc_abortmake];
    mainmenu1.menu.itembynames(['edited', 'run']).Caption := captions[sc_debugrun];
    mainmenu1.menu.itembynames(['edited', 'beautifier']).Caption := captions[sc_beautifier];

    x := 0;

    Inc(x);
    mainmenu1.menu.itembynames(['edited', 'make' + IntToStr(x)]).Caption :=
      captions[sc_make] + ' ' + IntToStr(x);
    Inc(x);
    mainmenu1.menu.itembynames(['edited', 'make' + IntToStr(x)]).Caption :=
      captions[sc_make] + ' ' + IntToStr(x);
    Inc(x);
    mainmenu1.menu.itembynames(['edited', 'make' + IntToStr(x)]).Caption :=
      captions[sc_make] + ' ' + IntToStr(x);
    Inc(x);
    mainmenu1.menu.itembynames(['edited', 'make' + IntToStr(x)]).Caption :=
      captions[sc_make] + ' ' + IntToStr(x);

    Inc(x);
    mainmenu1.menu.itembynames(['edited', 'make' + IntToStr(x)]).Caption :=
      captions[sc_make] + ' ' + IntToStr(x);
    Inc(x);
    mainmenu1.menu.itembynames(['edited', 'make' + IntToStr(x)]).Caption :=
      captions[sc_make] + ' ' + IntToStr(x);
    Inc(x);
    mainmenu1.menu.itembynames(['edited', 'make' + IntToStr(x)]).Caption :=

      captions[sc_make] + ' ' + IntToStr(x);

    Inc(x);
    mainmenu1.menu.itembynames(['edited', 'make' + IntToStr(x)]).Caption :=
      captions[sc_make] + ' ' + IntToStr(x);

    Inc(x);
    mainmenu1.menu.itembynames(['edited', 'make' + IntToStr(x)]).Caption :=
      captions[sc_make] + ' ' + IntToStr(x);

    mainmenu1.menu.itembynames(['edited', 'make0']).Caption :=
      captions[sc_make] + ' 0';

    mainmenu1.menu.itembynames(['edited', 'makeX']).Caption :=
      captions[sc_make] + ' X';

    mainmenu1.menu.itembynames(['edited', 'open']).Caption := captions[sc_open];
    mainmenu1.menu.itembynames(['edited', 'save']).Caption := captions[sc_save];
    mainmenu1.menu.itembynames(['edited', 'close']).Caption := captions[sc_close];

    mainmenu1.menu.itembynames(['widgets']).Caption := captions[sc_widgets];
    mainmenu1.menu.itembynames(['widgets', 'msegui', 'msemod']).Caption := captions[sc_msemod];
    mainmenu1.menu.itembynames(['widgets', 'msegui', 'closeallmsemod']).Caption := captions[sc_closeallmsemod];

    mainmenu1.menu.itembynames(['widgets', 'msegui', 'componentspalette']).Caption :=
      captions[sc_componentspalette];

    mainmenu1.menu.itembynames(['widgets', 'msegui', 'componentsstore']).Caption :=
      actionsmoduletext(ac_storecomponent);

    mainmenu1.menu.itembynames(['widgets', 'msegui', 'objectinspector']).Caption :=
      actionsmoduletext(ac_objectinspector);

    mainmenu1.menu.itembynames(['widgets', 'msegui', 'toggleformunit']).Caption :=
      captions[sc_toggleformunit];

    mainmenu1.menu.itembynames(['widgets', 'msegui', 'findcomponent']).Caption :=
      captions[sc_findcomponent];

    mainmenu1.menu.itembynames(['settings']).Caption := captions[sc_settings];
    mainmenu1.menu.itembynames(['settings', 'generalsettings']).Caption := captions[sc_generalsettings];
    mainmenu1.menu.itembynames(['settings', 'extrasettings']).Caption := captions[sc_extrasettings];
    mainmenu1.menu.itembynames(['settings', 'lang']).Caption := captions[sc_lang] + '     (Lang)';
    mainmenu1.menu.itembynames(['settings', 'configwidgets']).Caption := captions[sc_configwidgets];
    mainmenu1.menu.itembynames(['settings', 'configcompilers']).Caption := captions[sc_configcompilers];
    mainmenu1.menu.itembynames(['settings', 'configdebuggers']).Caption := captions[sc_configdebuggers];
    mainmenu1.menu.itembynames(['settings', 'themes']).Caption := captions[sc_themes];

    mainmenu1.menu.itembynames(['about']).Caption := captions[sc_about];

    if Assigned(debuggerfo) then
    begin
      debuggerfo.find_in_directory.hint := stockobjects.captions[sc_searchindirectories];
      debuggerfo.line_number.hint       := projectoptionstext(po_linenumbers);
      debuggerfo.terminal_run.hint      := projectoptionstext(po_showconsole);
      debuggerfo.project_open.hint      := stockobjects.captions[sc_openproject];
      debuggerfo.open_file.hint         := stockobjects.captions[sc_openfile];
      debuggerfo.save_file.hint         := stockobjects.captions[sc_save];
      debuggerfo.code_beauty.hint       := stockobjects.captions[sc_beautifier];
      debuggerfo.procedure_list.hint    := stockobjects.captions[sc_proclist];
      debuggerfo.find_in_edit.hint      := stockobjects.captions[sc_searchincurrentfile];
      debuggerfo.project_save.hint      := stockobjects.captions[sc_save];
      debuggerfo.project_option.hint    := projectoptionstext(po_projectoptions);
      debuggerfo.project_make.hint      := ' ' + mainformtext(ma_project) +
        ' : ' + stockobjects.captions[sc_make] + ' ' + ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_start.hint     := ' ' + mainformtext(ma_project) +
        ' : ' + stockobjects.captions[sc_debugrun] + ' ' + ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_save.hint      := ' ' + mainformtext(ma_project) +
        ' : ' + stockobjects.captions[sc_save] + ' ' + ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_interrupt.hint := ' ' + mainformtext(ma_project) +
        ' : ' + stockobjects.captions[sc_abortmake] + ' ' + ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_next.hint      := ' ' + mainformtext(ma_project) +
        ' : ' + stockobjects.captions[sc_nextinstruction] + ' ' + ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_step.hint      := ' ' + mainformtext(ma_project) +
        ' : ' + stockobjects.captions[sc_stepinstruction] + ' ' + ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_finish.hint    := ' ' + mainformtext(ma_project) +
        ' : ' + stockobjects.captions[sc_finish] + ' ' + ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_next_instruction.hint := ' ' + mainformtext(ma_project) +
        ' : ' + stockobjects.captions[sc_nextinstruction] + ' ' +
        stockobjects.captions[sc_assembler] + ' ' +
        ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_step_instruction.hint := ' ' + mainformtext(ma_project) +
        ' : ' + stockobjects.captions[sc_stepinstruction] + ' ' +
        stockobjects.captions[sc_assembler] + ' ' +
        ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_reset.hint     := ' ' + mainformtext(ma_project) +
        ' : ' + stockobjects.captions[sc_reset] + ' ' +
        ExtractFilename(theprojectname) + ' ';
      debuggerfo.edited_make.hint       := ' ' + stockobjects.captions[sc_edited] +
        ' : ' + stockobjects.captions[sc_make] + ' ' + thefilename + ' ';
      debuggerfo.edited_run.hint        := ' ' + stockobjects.captions[sc_edited] +
        ' : ' + stockobjects.captions[sc_debugrun] + ' ' + thefilename + ' ';
      debuggerfo.toggle_form_unit.hint  := ' ' + stockobjects.captions[sc_edited] +
        ' : ' + stockobjects.captions[sc_toggleformunit] + ' ' + thefilename + ' ';

    end;
    
    conflangfo.gridlang.rowcount := length(langnamesreg) ;
    
  //  {
     for x := 0 to length(langnamesreg) -1 do
   begin
 //  writeln(inttostr(x) + ' 1');
   conflangfo.gridlangcaption[x] := langnamestext(x)+ 
     '   (' + langnamesreg[x] + ')';
  //    writeln(inttostr(x) + ' 2');
    conflangfo.gridlangcode[x] := langnamesreg[x] ;
    
   end; 
 //    }
     
    conflangfo.setasdefault.frame.caption := stockobjects.captions[sc_setasdefault];
    conflangfo.ok.caption := stockobjects.modalresulttext[mr_ok]; 
    conflangfo.caption := stockobjects.captions[sc_lang];    
   
  end;
end;

procedure tmainfo.manfocreated(const Sender: TObject);
begin
   TDummyThread.Create(False);
end;

procedure tmainfo.onbeauty(const Sender: TObject);
var
  ratio: double;
begin
  ratio := confideufo.fontsize.Value / 12;

  if not beautyformcreated then
    doBeauty;

  beautyfo.font.Height := confideufo.fontsize.Value;
  beautyfo.font.Name   := ansistring(confideufo.fontname.Value);

  beautyfo.group_file_changed.top := beautyfo.filetoclean.bottom + 4;
  beautyfo.tbjedi.top := beautyfo.tbptop.bottom + 4;
  beautyfo.group_file_changed.Height := beautyfo.tbjedi.bottom + 8;

  beautyfo.group_file_changed.Width := round(ratio * 194);
  beautyfo.filetoclean.Width        := beautyfo.group_file_changed.Width;

  beautyfo.createbackup.top := beautyfo.group_file_changed.bottom + 4;

  beautyfo.butdobeauty.top   := beautyfo.createbackup.bottom + 4;
  beautyfo.butdobeauty.Width := beautyfo.group_file_changed.Width;

  beautyfo.Width := beautyfo.group_file_changed.Width + 8;

  beautyfo.Height := beautyfo.butdobeauty.bottom + 4;

  beautyfo.filetoclean.Value := extractfilename(debuggerfo.file_history.Value);

  if ismodal then
    beautyfo.Show(True)
  else
  begin
    beautyfo.Show;
    beautyfo.bringtofront;
  end;
end;

procedure tmainfo.dothemedialog();
var
  ratio: double;
begin

  ratio := confideufo.fontsize.Value / 12;

  dialogfilesfo.selected_file.font.Height       := confideufo.fontsize.Value;
  dialogfilesfo.selected_file.font.Name         := ansistring(confideufo.fontname.Value);
  dialogfilesfo.selected_file.frame.font.Height := confideufo.fontsize.Value;
  dialogfilesfo.selected_file.frame.font.Name   := ansistring(confideufo.fontname.Value);

  dialogfilesfo.list_files.cellheight  := round((ratio) * 19);
  dialogfilesfo.list_files.font.Height := confideufo.fontsize.Value;
  dialogfilesfo.list_files.font.Name   := ansistring(confideufo.fontname.Value);

  dialogfilesfo.Height := round((ratio) * 366);
  dialogfilesfo.Width  := round((ratio) * 336);
  //dialogfilesfo.list_files.cellwidth := dialogfilesfo.list_files.width - 6 ;

  if themenr = 0 then
  begin
    dialogfilesfo.tstringdisp1.frame.colorclient := cl_ltgray;
    dialogfilesfo.container.color := cl_ltgray;
    dialogfilesfo.color           := cl_ltgray;
    dialogfilesfo.selected_file.frame.font.color := cl_black;
  end;

  if themenr = 1 then
  begin
    dialogfilesfo.tstringdisp1.frame.colorclient := cl_dkgray;
    dialogfilesfo.selected_file.frame.font.color := cl_white;
    dialogfilesfo.color           := cl_dkgray;
    dialogfilesfo.container.color := cl_dkgray;
  end;

end;

procedure tmainfo.dotheme(typetheme: integer);
var
  color0, color1, color2, color3: longword;
begin

  setstattext(mainformtext(ma_makeok), mtk_finished);

  if typetheme = 0 then
  begin
    color0 := cl_white;
    color1 := cl_dkgray;
    color2 := cl_black;
    color3 := cl_white;

    basedock.face.template := convex;
    basedock.dragdock.splitter_color := cl_ltgray; 
    
    debuggerfo.color := cl_gray ;  
    debuggerfo.basedock.color := cl_gray ; 
    
    color := cl_gray ;
    basedock.color := cl_gray ;   

    frame.grip_face.template           := tfacecomp3;
    frame.grip_faceactive.template     := tfacecomp3;
    sourcefo.frame.grip_face.template  := tfacecomp3;
    messagefo.frame.grip_face.template := tfacecomp3;
    debuggerfo.frame.grip_face.template := tfacecomp3;
    projecttreefo.frame.grip_face.template := tfacecomp3;

    frame.grip_colorglyph           := cl_black;
    frame.grip_colorglyphactive     := cl_black;
    sourcefo.frame.grip_colorglyph  := cl_black;
    sourcefo.frame.grip_colorglyphactive := cl_black;
    debuggerfo.frame.grip_colorglyph := cl_black;
    debuggerfo.frame.grip_colorglyphactive := cl_black;
    projecttreefo.frame.grip_colorglyph := cl_black;
    projecttreefo.frame.grip_colorglyphactive := cl_black;
    messagefo.frame.grip_colorglyph := cl_black;
    messagefo.frame.grip_colorglyphactive := cl_black;

    messagefo.color := cl_ltgray;
    messagefo.Messages.color := cl_ltgray;
    basedock.color := cl_ltgray;
    color := cl_ltgray;
    basedock.dragdock.splitter_color := cl_ltgray;

    mainmenu1.facetemplate           := convex;
    mainmenu1.itemfacetemplate       := convex;
    mainmenu1.itemfacetemplateactive := concave;
    mainmenu1.popupitemfacetemplate  := concave;
    mainmenu1.popupitemfacetemplateactive := convex;
    debuggerfo.panelproject.face.template := debuggerfo.templproject;
    debuggerfo.panelwatch.face.template := debuggerfo.templproject;
    debuggerfo.project_open.face.template := debuggerfo.templproject;
    debuggerfo.project_option.face.template := debuggerfo.templproject;
    debuggerfo.project_save.face.template := debuggerfo.templproject;
    debuggerfo.project_make.face.template := debuggerfo.templproject;
    debuggerfo.project_abort_compil.face.template := debuggerfo.templproject;
    debuggerfo.project_start.face.template := debuggerfo.templproject;
    debuggerfo.project_next.face.template := debuggerfo.templproject;

    if Assigned(debuggerfo) then
    begin
      debuggerfo.container.color := color0;
      debuggerfo.color           := color0;

      debuggerfo.container.frame.sbhorz.facebutton.fade_color.items[1] := color0;
      debuggerfo.container.frame.sbhorz.facebutton.fade_color.items[0] := color1;
      debuggerfo.container.frame.sbhorz.face.fade_color.items[0] := color0;
      debuggerfo.container.frame.sbhorz.face.fade_color.items[1] := color1;
      debuggerfo.container.frame.sbhorz.face1.fade_color.items[0] := color0;
      debuggerfo.container.frame.sbhorz.face1.fade_color.items[1] := color1;
      debuggerfo.container.frame.sbhorz.face2.fade_color.items[0] := color0;
      debuggerfo.container.frame.sbhorz.face2.fade_color.items[1] := color1;
      debuggerfo.container.frame.sbhorz.faceendbutton.fade_color.items[0] := color0;
      debuggerfo.container.frame.sbhorz.faceendbutton.fade_color.items[1] := color1;
      debuggerfo.container.frame.sbhorz.colorglyph := color2;

      debuggerfo.container.frame.sbvert.facebutton.fade_color.items[1] := color0;
      debuggerfo.container.frame.sbvert.facebutton.fade_color.items[0] := color1;
      debuggerfo.container.frame.sbvert.face.fade_color.items[0] := color0;
      debuggerfo.container.frame.sbvert.face.fade_color.items[1] := color1;
      debuggerfo.container.frame.sbvert.face1.fade_color.items[0] := color0;
      debuggerfo.container.frame.sbvert.face1.fade_color.items[1] := color1;
      debuggerfo.container.frame.sbvert.face2.fade_color.items[0] := color0;
      debuggerfo.container.frame.sbvert.face2.fade_color.items[1] := color1;
      debuggerfo.container.frame.sbvert.faceendbutton.fade_color.items[0] := color0;
      debuggerfo.container.frame.sbvert.faceendbutton.fade_color.items[1] := color1;
      debuggerfo.container.frame.sbvert.colorglyph := color2;
    end;

    debuggerfo.panelmain.face.template         := debuggerfo.templatemain;
    debuggerfo.assistive.face.template         := debuggerfo.templatemain;
    debuggerfo.properties_list.face.template   := debuggerfo.templatemain;
    debuggerfo.find_in_directory.face.template := debuggerfo.templatemain;
    debuggerfo.line_number.face.template       := debuggerfo.templatemain;
    debuggerfo.terminal_run.face.template      := debuggerfo.templatemain;

    debuggerfo.debug_on.face.template          := debuggerfo.templproject;
    debuggerfo.project_step.face.template      := debuggerfo.templproject;
    debuggerfo.project_finish.face.template    := debuggerfo.templproject;
    debuggerfo.project_next_instruction.face.template := debuggerfo.templproject;
    debuggerfo.project_step_instruction.face.template := debuggerfo.templproject;
    debuggerfo.project_reset.face.template     := debuggerfo.templproject;
    debuggerfo.project_interrupt.face.template := debuggerfo.templproject;
    debuggerfo.tstringdisp2.face.template      := debuggerfo.templatemain;
    debuggerfo.timagelist1.getimage(0, debuggerfo.eyesimage.bitmap, 0);

    debuggerfo.paneledited.face.template      := debuggerfo.templfile;
    debuggerfo.toggle_form_unit.face.template := debuggerfo.templfile;
    debuggerfo.code_beauty.face.template      := debuggerfo.templfile;
    debuggerfo.find_in_edit.face.template     := debuggerfo.templfile;
    debuggerfo.procedure_list.face.template   := debuggerfo.templfile;
    debuggerfo.open_file.face.template        := debuggerfo.templfile;
    debuggerfo.save_file.face.template        := debuggerfo.templfile;
    debuggerfo.edited_make.face.template      := debuggerfo.templfile;
    debuggerfo.edited_abort.face.template     := debuggerfo.templfile;
    debuggerfo.edited_run.face.template       := debuggerfo.templfile;

    if Assigned(sourcefo.ActivePage) then
    begin
      sourcefo.ActivePage.pathdisp.face.template := debuggerfo.templatemain;
      sourcefo.ActivePage.pathdisp.font.color := cl_black;
      sourcefo.ActivePage.linedisp.face.template := debuggerfo.templatemain;
      sourcefo.ActivePage.linedisp.font.color := cl_black;
      sourcefo.ActivePage.color           := cl_ltgray;
      sourcefo.ActivePage.container.color := cl_ltgray;
    end;

    sourcefo.tpopupmenu1.menu.font.color        := cl_black;
    sourcefo.tpopupmenu1.menu.fontactive.color  := cl_black;
    sourcefo.tpopupmenu1.facetemplate           := convex;
    sourcefo.tpopupmenu1.itemfacetemplate       := sourcefo.tfacecomp2horz;
    sourcefo.tpopupmenu1.itemfacetemplateactive := sourcefo.tfacecomp1;

    sourcefo.files_tab.color         := cl_ltgray;
    sourcefo.files_tab.tab_frame.buttonface.template := mainfo.convex;
    sourcefo.files_tab.tab_facetab.template := sourcefo.tfacecomp1;
    sourcefo.step_back.face.template := mainfo.convex;
    sourcefo.step_forward.face.template := mainfo.convex;

    sourcefo.step_forward.face.template        := mainfo.convex;
    sourcefo.files_tab.tab_frame.colorglyph    := cl_black;
    sourcefo.files_tab.tab_faceactivetab.template := sourcefo.tfacecomp2;
    sourcefo.files_tab.tab_face.template       := sourcefo.tfacecomp1;
    sourcefo.files_tab.tab_font.color          := cl_black;
    sourcefo.files_tab.tab_fontactivetab.color := cl_black;
    sourcefo.files_tab.tab_fonttab.color       := cl_black;

    projecttreefo.projectedit.face.template       := projecttreefo.templatemain;
    projecttreefo.projectedit.font.color          := cl_black;
    projecttreefo.projectedit.itemlist.colorline  := cl_black;
    projecttreefo.projectedit.itemlist.colorglyph := cl_black;
    projecttreefo.projectedit.itemlist.colorglyphactive := cl_black;
    projecttreefo.projectedit.itemlist.colorlineactive := cl_black;

    projecttreefo.edit.font.color    := cl_black;
    projecttreefo.edit.face.template := projecttreefo.templatemain;
    projecttreefo.grid.face.template := projecttreefo.templatemain;

  end;

  if typetheme = 1 then
  begin
    color0 := cl_black;
    color1 := cl_dkgray;
    color2 := cl_white;
    color3 := cl_black;

    basedock.face.template := convexdark;
    
    basedock.dragdock.splitter_color := cl_black;
    
    debuggerfo.color := cl_dkgray ;
    debuggerfo.basedock.color := cl_dkgray ;  
    
    color := cl_dkgray ;
    basedock.color := cl_dkgray ;  

    frame.grip_face.template           := sourcefo.tfacecomp2dark;
    frame.grip_faceactive.template     := sourcefo.tfacecomp2dark;
    sourcefo.frame.grip_face.template  := sourcefo.tfacecomp2dark;
    messagefo.frame.grip_face.template := sourcefo.tfacecomp2dark;
    debuggerfo.frame.grip_face.template := sourcefo.tfacecomp2dark;
    projecttreefo.frame.grip_face.template := sourcefo.tfacecomp2dark;

    frame.grip_colorglyph := cl_white;
    frame.grip_colorglyphactive := cl_white;
    sourcefo.frame.grip_colorglyph := cl_white;
    sourcefo.frame.grip_colorglyphactive := cl_white;
    debuggerfo.frame.grip_colorglyph := cl_white;
    debuggerfo.frame.grip_colorglyphactive := cl_white;
    projecttreefo.frame.grip_colorglyph := cl_white;
    projecttreefo.frame.grip_colorglyphactive := cl_white;
    messagefo.frame.grip_colorglyph := cl_white;
    messagefo.frame.grip_colorglyphactive := cl_white;
    messagefo.Messages.color := cl_black;
    messagefo.color := cl_black;
    basedock.color  := cl_black;
    color           := cl_black;
    basedock.dragdock.splitter_color := cl_black;
    mainmenu1.facetemplate := convexdark;
    mainmenu1.itemfacetemplate := convexdark;
    mainmenu1.itemfacetemplateactive := concavedark;
    mainmenu1.popupitemfacetemplate := concavedark;
    mainmenu1.popupitemfacetemplateactive := convexdark;

    debuggerfo.panelmain.face.template         := debuggerfo.templatemaindark;
    debuggerfo.assistive.face.template         := debuggerfo.templatemaindark;
    debuggerfo.properties_list.face.template   := debuggerfo.templatemaindark;
    debuggerfo.find_in_directory.face.template := debuggerfo.templatemaindark;
    debuggerfo.line_number.face.template       := debuggerfo.templatemaindark;
    debuggerfo.terminal_run.face.template      := debuggerfo.templatemaindark;
    debuggerfo.debug_on.face.template          := debuggerfo.templateprojectdark;

    if Assigned(sourcefo.ActivePage) then
    begin
      sourcefo.ActivePage.pathdisp.face.template := debuggerfo.templatemaindark;
      sourcefo.ActivePage.pathdisp.font.color := cl_white;
      sourcefo.ActivePage.linedisp.face.template := debuggerfo.templatemaindark;
      sourcefo.ActivePage.linedisp.font.color := cl_white;
      sourcefo.ActivePage.color           := cl_black;
      sourcefo.ActivePage.container.color := cl_black;
    end;

    sourcefo.tpopupmenu1.menu.font.color        := cl_white;
    sourcefo.tpopupmenu1.menu.fontactive.color  := $FFD6B0;
    sourcefo.tpopupmenu1.facetemplate           := convexdark;
    sourcefo.tpopupmenu1.itemfacetemplate       := sourcefo.tfacecomp2horzdark;
    sourcefo.tpopupmenu1.itemfacetemplateactive := sourcefo.tfacecomp1dark;


    sourcefo.files_tab.tab_facetab.template := sourcefo.tfacecomp1dark;
    sourcefo.files_tab.tab_font.color := cl_white;
    sourcefo.files_tab.tab_fontactivetab.color := cl_white;
    sourcefo.files_tab.tab_fonttab.color := cl_white;
    sourcefo.files_tab.tab_faceactivetab.template := sourcefo.tfacecomp2dark;
    sourcefo.files_tab.tab_face.template := sourcefo.tfacecomp1dark;
    sourcefo.files_tab.color         := cl_black;
    sourcefo.files_tab.tab_frame.buttonface.template := mainfo.convexdark;
    sourcefo.files_tab.tab_frame.colorglyph := cl_white;
    sourcefo.step_back.face.template := mainfo.convexdark;
    sourcefo.step_forward.face.template := mainfo.convexdark;

    projecttreefo.projectedit.font.color := cl_white;
    projecttreefo.edit.font.color        := cl_white;

    projecttreefo.projectedit.face.template := projecttreefo.templatemaindark;
    projecttreefo.projectedit.itemlist.colorline := cl_white;
    projecttreefo.grid.face.template := projecttreefo.templatemaindark;
    projecttreefo.edit.face.template := projecttreefo.templatemaindark;
    projecttreefo.projectedit.itemlist.colorglyph := cl_white;
    projecttreefo.projectedit.itemlist.colorglyphactive := cl_white;
    projecttreefo.projectedit.itemlist.colorlineactive := cl_white;


    debuggerfo.panelwatch.face.template           := debuggerfo.templateprojectdark;
    debuggerfo.panelproject.face.template         := debuggerfo.templateprojectdark;
    debuggerfo.project_open.face.template         := debuggerfo.templateprojectdark;
    debuggerfo.project_option.face.template       := debuggerfo.templateprojectdark;
    debuggerfo.project_save.face.template         := debuggerfo.templateprojectdark;
    debuggerfo.project_make.face.template         := debuggerfo.templateprojectdark;
    debuggerfo.project_abort_compil.face.template := debuggerfo.templateprojectdark;
    debuggerfo.project_start.face.template        := debuggerfo.templateprojectdark;
    debuggerfo.project_next.face.template         := debuggerfo.templateprojectdark;
    debuggerfo.project_step.face.template         := debuggerfo.templateprojectdark;
    debuggerfo.project_finish.face.template       := debuggerfo.templateprojectdark;
    debuggerfo.project_next_instruction.face.template := debuggerfo.templateprojectdark;
    debuggerfo.project_step_instruction.face.template := debuggerfo.templateprojectdark;
    debuggerfo.project_reset.face.template        := debuggerfo.templateprojectdark;
    debuggerfo.project_interrupt.face.template    := debuggerfo.templateprojectdark;
    debuggerfo.tstringdisp2.face.template         := debuggerfo.templatemaindark;

    debuggerfo.timagelist1.getimage(1, debuggerfo.eyesimage.bitmap, 0);
    //{   
    if Assigned(debuggerfo) then
    begin
      debuggerfo.container.color := color0;
      debuggerfo.color           := color0;

      debuggerfo.container.frame.sbhorz.facebutton.fade_color.items[1] := color0;
      debuggerfo.container.frame.sbhorz.facebutton.fade_color.items[0] := color1;
      debuggerfo.container.frame.sbhorz.face.fade_color.items[0] := color0;
      debuggerfo.container.frame.sbhorz.face.fade_color.items[1] := color1;
      debuggerfo.container.frame.sbhorz.face1.fade_color.items[0] := color0;
      debuggerfo.container.frame.sbhorz.face1.fade_color.items[1] := color1;
      debuggerfo.container.frame.sbhorz.face2.fade_color.items[0] := color0;
      debuggerfo.container.frame.sbhorz.face2.fade_color.items[1] := color1;
      debuggerfo.container.frame.sbhorz.faceendbutton.fade_color.items[0] := color0;
      debuggerfo.container.frame.sbhorz.faceendbutton.fade_color.items[1] := color1;
      debuggerfo.container.frame.sbhorz.colorglyph := color2;

      debuggerfo.container.frame.sbvert.facebutton.fade_color.items[1] := color0;
      debuggerfo.container.frame.sbvert.facebutton.fade_color.items[0] := color1;
      debuggerfo.container.frame.sbvert.face.fade_color.items[0] := color0;
      debuggerfo.container.frame.sbvert.face.fade_color.items[1] := color1;
      debuggerfo.container.frame.sbvert.face1.fade_color.items[0] := color0;
      debuggerfo.container.frame.sbvert.face1.fade_color.items[1] := color1;
      debuggerfo.container.frame.sbvert.face2.fade_color.items[0] := color0;
      debuggerfo.container.frame.sbvert.face2.fade_color.items[1] := color1;
      debuggerfo.container.frame.sbvert.faceendbutton.fade_color.items[0] := color0;
      debuggerfo.container.frame.sbvert.faceendbutton.fade_color.items[1] := color1;
      debuggerfo.container.frame.sbvert.colorglyph := color2;

    end;
    //}
    debuggerfo.paneledited.face.template      := debuggerfo.templfiledark;
    debuggerfo.toggle_form_unit.face.template := debuggerfo.templfiledark;
    debuggerfo.code_beauty.face.template      := debuggerfo.templfiledark;
    debuggerfo.procedure_list.face.template   := debuggerfo.templfiledark;
    debuggerfo.find_in_edit.face.template     := debuggerfo.templfiledark;
    debuggerfo.open_file.face.template        := debuggerfo.templfiledark;
    debuggerfo.save_file.face.template        := debuggerfo.templfiledark;
    debuggerfo.edited_make.face.template      := debuggerfo.templfiledark;
    debuggerfo.edited_abort.face.template     := debuggerfo.templfiledark;
    debuggerfo.edited_run.face.template       := debuggerfo.templfiledark;

  end;

  mainmenu1.menu.font.color := color2;

  mainfo.container.color := color0;
  mainfo.color           := color0;

  debuggerfo.container.color := color0;

  debuggerfo.color := color0;

  if Assigned(projecttreefo) then
  begin

    projecttreefo.grid.frame.sbhorz.facebutton.fade_color.items[1] := color0;
    projecttreefo.grid.frame.sbhorz.facebutton.fade_color.items[0] := color1;
    projecttreefo.grid.frame.sbhorz.face.fade_color.items[0] := color0;
    projecttreefo.grid.frame.sbhorz.face.fade_color.items[1] := color1;
    projecttreefo.grid.frame.sbhorz.face1.fade_color.items[0] := color0;
    projecttreefo.grid.frame.sbhorz.face1.fade_color.items[1] := color1;
    projecttreefo.grid.frame.sbhorz.face2.fade_color.items[0] := color0;
    projecttreefo.grid.frame.sbhorz.face2.fade_color.items[1] := color1;
    projecttreefo.grid.frame.sbhorz.faceendbutton.fade_color.items[0] := color0;
    projecttreefo.grid.frame.sbhorz.faceendbutton.fade_color.items[1] := color1;
    projecttreefo.grid.frame.sbhorz.colorglyph := color2;

    projecttreefo.grid.frame.sbvert.facebutton.fade_color.items[1] := color0;
    projecttreefo.grid.frame.sbvert.facebutton.fade_color.items[0] := color1;
    projecttreefo.grid.frame.sbvert.face.fade_color.items[0] := color0;
    projecttreefo.grid.frame.sbvert.face.fade_color.items[1] := color1;
    projecttreefo.grid.frame.sbvert.face1.fade_color.items[0] := color0;
    projecttreefo.grid.frame.sbvert.face1.fade_color.items[1] := color1;
    projecttreefo.grid.frame.sbvert.face2.fade_color.items[0] := color0;
    projecttreefo.grid.frame.sbvert.face2.fade_color.items[1] := color1;
    projecttreefo.grid.frame.sbvert.faceendbutton.fade_color.items[0] := color0;
    projecttreefo.grid.frame.sbvert.faceendbutton.fade_color.items[1] := color1;
    projecttreefo.grid.frame.sbvert.colorglyph := color2;
  end;

  messagefo.Messages.datacols.color := color3;

  messagefo.Messages.font.color           := color2;
  messagefo.Messages.font.colorbackground := cl_none;

  messagefo.Messages.face.fade_color.items[0] := color0;
  messagefo.Messages.face.fade_color.items[1] := color1;
  messagefo.Messages.frame.sbhorz.facebutton.fade_color.items[1] := color0;
  messagefo.Messages.frame.sbhorz.facebutton.fade_color.items[0] := color1;
  messagefo.Messages.frame.sbhorz.face.fade_color.items[0] := color0;
  messagefo.Messages.frame.sbhorz.face.fade_color.items[1] := color1;
  messagefo.Messages.frame.sbhorz.face1.fade_color.items[0] := color0;
  messagefo.Messages.frame.sbhorz.face1.fade_color.items[1] := color1;
  messagefo.Messages.frame.sbhorz.face2.fade_color.items[0] := color0;
  messagefo.Messages.frame.sbhorz.face2.fade_color.items[1] := color1;
  messagefo.Messages.frame.sbhorz.faceendbutton.fade_color.items[1] := color0;
  messagefo.Messages.frame.sbhorz.faceendbutton.fade_color.items[0] := color1;
  messagefo.Messages.frame.sbhorz.colorglyph  := color2;

  messagefo.Messages.frame.sbvert.facebutton.fade_color.items[1] := color0;
  messagefo.Messages.frame.sbvert.facebutton.fade_color.items[0] := color1;
  messagefo.Messages.frame.sbvert.face.fade_color.items[1] := color0;
  messagefo.Messages.frame.sbvert.face.fade_color.items[0] := color1;
  messagefo.Messages.frame.sbvert.face1.fade_color.items[1] := color0;
  messagefo.Messages.frame.sbvert.face1.fade_color.items[0] := color1;
  messagefo.Messages.frame.sbvert.face2.fade_color.items[1] := color0;
  messagefo.Messages.frame.sbvert.face2.fade_color.items[0] := color1;
  messagefo.Messages.frame.sbvert.faceendbutton.fade_color.items[0] := color0;
  messagefo.Messages.frame.sbvert.faceendbutton.fade_color.items[1] := color1;
  messagefo.Messages.frame.sbvert.colorglyph := color2;

  debuggerfo.statdisp.font.color := color2;

  if typetheme = 0 then
    debuggerfo.container.color := cl_ltgray;

  if typetheme = 1 then
    debuggerfo.container.color := cl_black;

  if Assigned(sourcefo.ActivePage) then
  begin
    if typetheme = 0 then
      sourcefo.ActivePage.container.color := cl_ltgray;
    if typetheme = 1 then
      sourcefo.ActivePage.container.color := cl_black;
    sourcefo.ActivePage.source_editor.frame.sbhorz.facebutton.fade_color.items[1] := color0;
    sourcefo.ActivePage.source_editor.frame.sbhorz.facebutton.fade_color.items[0] := color1;
    sourcefo.ActivePage.source_editor.frame.sbhorz.face.fade_color.items[0] := color0;
    sourcefo.ActivePage.source_editor.frame.sbhorz.face.fade_color.items[1] := color1;
    sourcefo.ActivePage.source_editor.frame.sbhorz.face1.fade_color.items[0] := color0;
    sourcefo.ActivePage.source_editor.frame.sbhorz.face1.fade_color.items[1] := color1;
    sourcefo.ActivePage.source_editor.frame.sbhorz.face2.fade_color.items[0] := color0;
    sourcefo.ActivePage.source_editor.frame.sbhorz.face2.fade_color.items[1] := color1;
    sourcefo.ActivePage.source_editor.frame.sbhorz.faceendbutton.fade_color.items[0] := color0;
    sourcefo.ActivePage.source_editor.frame.sbhorz.faceendbutton.fade_color.items[1] := color1;
    sourcefo.ActivePage.source_editor.frame.sbhorz.colorglyph := color2;

    sourcefo.ActivePage.source_editor.frame.sbvert.facebutton.fade_color.items[0] := color0;
    sourcefo.ActivePage.source_editor.frame.sbvert.facebutton.fade_color.items[1] := color1;
    sourcefo.ActivePage.source_editor.frame.sbvert.face.fade_color.items[1] := color0;
    sourcefo.ActivePage.source_editor.frame.sbvert.face.fade_color.items[0] := color1;
    sourcefo.ActivePage.source_editor.frame.sbvert.face1.fade_color.items[1] := color0;
    sourcefo.ActivePage.source_editor.frame.sbvert.face1.fade_color.items[0] := color1;
    sourcefo.ActivePage.source_editor.frame.sbvert.face2.fade_color.items[1] := color0;
    sourcefo.ActivePage.source_editor.frame.sbvert.face2.fade_color.items[0] := color1;
    sourcefo.ActivePage.source_editor.frame.sbvert.faceendbutton.fade_color.items[0] := color0;
    sourcefo.ActivePage.source_editor.frame.sbvert.faceendbutton.fade_color.items[1] := color1;
    sourcefo.ActivePage.source_editor.frame.sbvert.colorglyph := color2;

  end;

end;

procedure tmainfo.onclassic(const Sender: TObject);
begin
  themenr := 0;
  dotheme(0);
  setstattext('Light theme is set.', mtk_flat);
end;

procedure tmainfo.ondark(const Sender: TObject);
begin
  themenr := 1;
  dotheme(1);
  setstattext('Dark theme is set.', mtk_flat);
end;

procedure tmainfo.ontoggleunitform(const Sender: TObject);
begin
  actionsmo.toggleformunitonexecute(Sender);
end;

procedure tmainfo.ontimersplash(const Sender: TObject);
begin
  splashfo.windowopacity := splashfo.windowopacity - 0.1;
  if splashfo.windowopacity <= 0 then
  begin
    ttimer1.Enabled := False;
    splashfo.Close;
    onactiv(sender);
  end;

end;

procedure tmainfo.onlang(const Sender: TObject);
var
x : integer;
begin
 
 for x := 0 to conflangfo.gridlang.rowcount - 1 do
 if MSEFallbackLang = conflangfo.gridlangcode[x] then
 conflangfo.gridlangbool[x] := true else
 conflangfo.gridlangbool[x] := false;
 
   conflangloaded     := 1;   

   if ismodal then
      conflangfo.Show(True)
    else
    begin
      conflangfo.Show;
      conflangfo.bringtofront;
    end;
end;

procedure tmainfo.onactiv(const Sender: TObject);
var
  x : integer;
  isinside : boolean = false;
begin

  if isactivated = False then
  begin
    isactivated := True;
    conflangfo.visible:= false;

    if conflangfo.setasdefault.Value = True then
     begin
     
     for x := 0 to conflangfo.gridlang.rowcount -1 do
       if conflangfo.gridlangbool[x] = True then
        MSEFallbackLang := conflangfo.gridlangcode[x];
     
        setlang(MSEFallbackLang);
    end
    else 
    begin
    
    if MSEFallbackLang = '' then setlang(MSEFallbackLang)
       else
       begin
          for x := 0 to length(langnamesreg)-1 do
        if MSEFallbackLang = langnamesreg[x] then isinside := true;
      if isinside then setlang(MSEFallbackLang);
      end;
    end;    
  end;
end;

procedure tmainfo.ontemplateeditor(const sender: TObject);
begin
  application.createform(ttemplateeditorfo, templateeditorfo);
  templateeditorfo.show;
end;


end.

