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

/// for custom compil, edit define.inc
{$I define.inc}

interface

uses
  aboutform, plugmanager, fpg_iniutils_ideu, msetimer, mseformatstr, dialogfiles,
  mseforms, mseguiglob, msegui, msegdbutils, mseactions, sak_mse, msefileutils,
  msedispwidgets, msedataedits, msestat, msestatfile, msemenus, msebitmap, msegrids,
  msefiledialog, msetypes, sourcepage, msedesignintf, msedesigner, Classes, mclasses,
  mseclasses, msegraphutils, typinfo, msedock, SysUtils, msesysenv, msemacros,
  msestrings, msepostscriptprinter, msegraphics, mseglob, msestream,
  mseprocmonitorcomp, msesystypes, mserttistat, msedatalist, mselistbrowser,
  projecttreeform, msepipestream, msestringcontainer, msesys, msewidgets;

const
  versiontext = '1.9.7';
  idecaption = 'ideU';
  statname = 'ideu';

type
  TDummyThread = class(TThread)
  protected
    procedure Execute; override;
  end;

type
  stringconsts = (
    unresreferences,    //0 Unresolved references in
    str_to,             //1 to
    wishsearch,         //2 Do you wish to search the formfile?
    warning,            //3 WARNING
    formfile,           //4 Formfile for
    formfiles,          //5 Formfiles
    recursive,          //6 Recursive form hierarchy for "
    error,              //7 ERROR
    str_classtype,      //8 Classtype
    notfound,           //9 not found.
    project,            //10 Project
    ismodified,         //11 is modified. Save?
    confirmation,       //12 Confirmation
    unableopen,         //13 Unable to open file "
    running,            //14 *** Running ***
    str_downloading,        //15 Downloading
    str_downloaded,         //16 Downloaded
    startgdbservercommand, //17 Start gdb server command "
    running2,           //18 " running.
    startgdbserver,     //19 Start gdb Server
    gdbserverstarterror,//20 gdb server start error
    gdbservercanceled,  //21 gdb server start canceled.
    cannotrunstartgdb,  //22 Can not run start gdb command.
    str_uploadcommand,  //23 Uploadcommand "
    downloaderror,      //24 Download ***ERROR***
    downloadfinished,   //25 Download finished.
    downloadcanceled,   //26 Download canceled.
    str_file,           //27 File "
    notfound2,          //28 " not found.
    exists,             //29 " exists.
    str_new,            //30 New
    selectancestor,     //31 Select ancestor
    newform,            //32 New form
    pascalfiles,        //33 Pascal Files
    new2,               //34 new
    cannotloadproj,     //35 Can not load Project "
    selecttemplate,     //36 Select project template
    projectfiles,       //37 Project files
    str_allfiles,       //38 All files
    selectprogramfile,  //39 Select program file
    pascalprogfiles,    //40 Pascal program files
    cfiles,             //41 C program files
    str_newproject,     //42 New Project
    cannotstartprocess, //43 Can not start process
    process,            //44 Process
    running3,           //45 running.
    processterminated,  //46 Process terminated.
    proctermnormally,   //47 Process terminated normally.
    makeerror,          //48 Make ***ERROR***
    makeok,             //49 Make OK.
    str_sourcechanged,  //50 Source has changed, do you wish to remake project?
    str_loadwindowlayout,   //51 Load Window Layout
    dockingarea         //52 Docking Area
    );

  filekindty = (fk_none, fk_source, fk_unit);
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

    openfile: tfiledialog;

    vievmenuicons: timagelist;

    viewmenu: tframecomp;
    runprocmon: tprocessmonitor;
    statoptions: trttistat;
    projectfiledia: tfiledialog;
    targetpipe: tpipereadercomp;
    c: tstringcontainer;
    openform: tfiledialog;
    formbg: tbitmapcomp;
    tfacecomp1: tfacecomp;
    tfacecomp2: tfacecomp;
    tfacecomp3: tfacecomp;
    menuitemframe: tframecomp;
    mainmenuframe: tframecomp;
    convex: tfacecomp;
    concave: tfacecomp;
    tframecomp2: tframecomp;
    timagelist3: timagelist;
    tframecomp3: tframecomp;
    procedure newfileonexecute(const Sender: TObject);
    procedure newformonexecute(const Sender: TObject);

    procedure mainfooncreate(const Sender: TObject);
    procedure mainfoondestroy(const Sender: TObject);
    procedure mainstatfileonupdatestat(const Sender: TObject; const filer: tstatfiler);
    procedure mainfoonterminate(var terminate: boolean);
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

    function closeallmodule(): boolean;

    //debugger
    procedure restartgdbonexecute(const Sender: TObject);
    procedure runexec(const Sender: TObject);
    procedure gdbonevent(const Sender: tgdbmi; var eventkind: gdbeventkindty;
      const values: resultinfoarty; const stopinfo: stopinfoty);
    procedure expronsetvalue(const Sender: TObject; var avalue: msestring;
      var accept: boolean);
    procedure symboltypeonsetvalue(const Sender: TObject; var avalue: msestring;
      var accept: boolean);
    procedure openprojectcopyexecute(const Sender: TObject);
    procedure saveprojectcopyexecute(const Sender: TObject);
    procedure newprojectfromprogramexe(const Sender: TObject);
    procedure newemptyprojectexe(const Sender: TObject);
    procedure viewmemoryonexecute(const Sender: TObject);
    procedure runprocdied(const Sender: TObject; const prochandle: prochandlety;
      const execresult: integer; const Data: Pointer);
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
    procedure picksdef(const Sender: TObject; var avalue: msestring; var accept: boolean);
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
  private
    fstartcommand: startcommandty;
    fnoremakecheck: boolean;
    fcurrent: boolean;
    flastform: tcustommseform;
    flastdesignform: tcustommseform;
    fexecstamp: integer;
    fprojectname: filenamety;
    fcheckmodulelevel: integer;
    fgdbserverprocid: integer;
    fgdbserverexitcode: integer;
    fgdbservertimeout: longword;
    ftargetfilemodified: boolean;
    frunningprocess: prochandlety;
    flayoutloading: boolean;
    fstopinfo: stopinfoty;
    fgdbdownloaded: boolean;
    procedure dorun;
    function runtarget: boolean; //true if run possible
    procedure newproject(const fromprogram, empty: boolean);
    procedure doshowform(const Sender: TObject);
    procedure setprojectname(aname: filenamety);
    //not const because of not refcounted widestrings
    procedure dofindmodulebyname(const amodule: pmoduleinfoty;
      const aname: string; var action: modalresultty);
    procedure dofindmodulebytype(const atypename: string);

    //idesignnotification
    procedure ItemDeleted(const ADesigner: IDesigner;
      const amodule: tmsecomponent; const AItem: TComponent);
    procedure ItemInserted(const ADesigner: IDesigner;
      const amodule: tmsecomponent; const AItem: TComponent);
    procedure ItemsModified(const ADesigner: IDesigner; const AItem: TObject);
    procedure componentnamechanging(const adesigner: idesigner;
      const amodule: tmsecomponent; const aitem: TComponent;
      const newname: string);
    procedure moduleclassnamechanging(const adesigner: idesigner;
      const amodule: tmsecomponent; const newname: string);
    procedure instancevarnamechanging(const adesigner: idesigner;
      const amodule: tmsecomponent; const newname: string);
    procedure SelectionChanged(const ADesigner: IDesigner;
      const ASelection: IDesignerSelections);
    procedure moduleactivated(const adesigner: idesigner; const amodule: tmsecomponent);
    procedure moduledeactivated(const adesigner: idesigner; const amodule: tmsecomponent);
    procedure moduledestroyed(const adesigner: idesigner; const amodule: tmsecomponent);
    procedure methodcreated(const adesigner: idesigner;
      const amodule: tmsecomponent;
      const aname: string; const atype: ptypeinfo);
    procedure methodnamechanged(const adesigner: idesigner;
      const amodule: tmsecomponent;
      const newname, oldname: string; const atypeinfo: ptypeinfo);
    procedure showobjecttext(const adesigner: idesigner;
      const afilename: filenamety; const backupcreated: boolean);
    procedure closeobjecttext(const adesigner: idesigner;
      const afilename: filenamety; var cancel: boolean);
    procedure beforefilesave(const adesigner: idesigner;
      const afilename: filenamety);
    procedure beforemake(const adesigner: idesigner; const maketag: integer;
      var abort: boolean);
    procedure aftermake(const adesigner: idesigner; const exitcode: integer);

    function checksave: modalresultty;
    procedure unloadexec;
    procedure cleardebugdisp;
    procedure resetdebugdisp; //called before running debuggee
    procedure createprogramfile(const aname: filenamety);
    function copynewfile(const aname, newname: filenamety;
      const autoincrement: boolean;
      const canoverwrite: boolean;
      const macronames: array of msestring;
      const macrovalues: array of msestring): boolean;
    //true if ok
    procedure createform(const aname: filenamety; const namebase: string;
      const ancestor: string);
    procedure removemodulemenuitem(const amodule: pmoduleinfoty);
    procedure uploadexe(const Sender: tguiapplication; var again: boolean);
    procedure uploadcancel(const Sender: TObject);
    procedure gdbserverexe(const Sender: tguiapplication; var again: boolean);
    function terminategdbserver(const force: boolean): boolean;
    procedure gdbservercancel(const Sender: TObject);
    procedure updatetargetenvironment;
    function needsdownload: boolean;
    function candebug: boolean; //run command empty or process attached
    procedure startconsole();
  public

    // fred
    customoption: integer;
    setcompiler: integer;
    settypecompiler: integer;
    thetag: integer;
    factivedesignmodule: pmoduleinfoty;
    fprojectloaded: boolean;
    errorformfilename: filenamety;
    constructor Create(aowner: TComponent); override;
    destructor Destroy; override;

    procedure designformactivated(const Sender: tcustommseform);
    procedure startgdb(const killserver: boolean);
    function checkgdberror(aresult: gdbresultty): boolean;
    function startgdbconnection(const attach: boolean): boolean;
    function loadexec(isattach: boolean;
      const forcedownload: boolean): boolean; //true if ok
    procedure setstattext(const atext: msestring;
      const akind: messagetextkindty = mtk_info);
    procedure refreshstopinfo(const astopinfo: stopinfoty);
    procedure updatemodifiedforms;
    function checkremake(startcommand: startcommandty): boolean;
    //true if running possible
    procedure resetstartcommand;
    procedure killtarget;
    procedure domake(atag: integer);

    /// fred
    procedure customdomake(aname: filenamety; acompiler: integer;
      acompilertag: integer; atag: integer);

    procedure targetfilemodified;
    function checksavecancel(const aresult: modalresultty): modalresultty;
    function closeall(const nosave: boolean): boolean; //false in cancel
    function closemodule(const amodule: pmoduleinfoty;
      const achecksave: boolean;
      nocheckclose: boolean = False): boolean;
    function openproject(const aname: filenamety;
      const ascopy: boolean = False): boolean;
    procedure saveproject(aname: filenamety; const ascopy: boolean = False);
    procedure savewindowlayout(const astream: ttextstream);
    procedure loadwindowlayout(const astream: ttextstream);

    procedure sourcechanged(const Sender: tsourcepage);
    function opensource(const filekind: filekindty; const addtoproject: boolean;
      const aactivate: boolean = True;
      const currentnode: tprojectnode = nil): boolean;
    //true if filedialog not canceled
    function openformfile(const filename: filenamety;
      const ashow, aactivate, showsource, createmenu,
      skipexisting: boolean): pmoduleinfoty;
    procedure createmodulemenuitem(const amodule: pmoduleinfoty);
    function formmenuitemstart: integer;
    procedure loadformbysource(const sourcefilename: filenamety);
    procedure loadsourcebyform(const formfilename: filenamety;
      const aactivate: boolean = False);
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
  toogletag: boolean = False;

  // fred
  thetimer: TTimer;
  vaparam: boolean = False;

procedure doassistive;

procedure sdefload(sdeffile: msestring);


procedure handleerror(const e: Exception; const Text: string);

implementation

uses
  // fred
  confmsegui, conffpgui, confcompiler, confideu, projectoptionsform,
  regwidgets, regeditwidgets, regdialogs, regkernel, regprinter,
  toolhandlermodule,
{$ifndef mse_no_math}
  regmath, regmm,
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
  regzeoslib,
{$endif}
  regdesignutils, regsysutils, regcrypto, regserialcomm, regexperimental,
{$ifndef mse_no_deprecated}
  regdeprecated,
{$endif}
 {$ifdef morecomponents}
  {$include regcomponents.inc}
 {$endif}

  mseparser, msesysintf, memoryform, msedrawtext,
  main_mfm, sourceform, watchform, breakpointsform, stackform,
  guitemplates, make, msepropertyeditors,
  skeletons, msedatamodules, mseact,
  mseformdatatools, mseshapes, mseeditglob,
  findinfileform, formdesigner, sourceupdate, actionsmodule, programparametersform,
  objectinspector, msesysutils, cpuform, disassform,
  panelform, watchpointsform, threadsform, targetconsole,
  commandorform, componentpaletteform, componentstore, confdebugger,
  messageform, ideusettings, mseintegerenter, symbolform
 {$ifdef unix}, mselibc {$endif}, //SIGRT*
  mseprocutils
 {$ifdef mse_dumpunitgroups}, dumpunitgroups{$endif};

procedure TDummyThread.Execute;
begin
  FreeOnTerminate := True;
  Terminate;
end;

procedure handleerror(const e: Exception; const Text: string);
begin
  if Text <> '' then
  begin
    writestderr(Text + ' ' + e.message, True);
  end
  else
  begin
    writestderr(e.message, True);
  end;
end;

procedure doassistive;
var
  thedir: msestring;
begin

  if (copy(confideufo.tesakitdir.Text, 1, 10) = '${IDEUDIR}') then
    thedir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) +
      copy(confideufo.tesakitdir.Text, 11, length(confideufo.tesakitdir.Text) - 10)
  else
    thedir := confideufo.tesakitdir.Text;

  if vaparam = False then
  begin
    if SakIsEnabled() = False then
    begin
      SakGreeting('Welcome with ideU !');
      if sakloadlib(thedir) = 0 then
        debuggerfo.assistive.imagenr := 19
      else
        debuggerfo.assistive.imagenr := 18;
    end
    else
    begin
      sakunloadlib;
      debuggerfo.assistive.imagenr := 18;
    end;
  end
  else
  begin
    SakGreeting('Welcome with ideU !');
    if sakloadlib(thedir) = 0 then
      debuggerfo.assistive.imagenr := 19
    else
      debuggerfo.assistive.imagenr := 18;
  end;

end;


{ tmainfo }

constructor tmainfo.Create(aowner: TComponent);
begin
  frunningprocess := invalidprochandle;
  fgdbserverprocid := invalidprochandle;
  customoption := 0;
  setcompiler := 1;
  settypecompiler := 1;

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
  watchfo.gdb := gdb;
  breakpointsfo.gdb := gdb;
  watchpointsfo.gdb := gdb;
  stackfo.gdb := gdb;
  threadsfo.gdb := gdb;
  disassfo.gdb := gdb;
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
  if assigned(sourcefo.ActivePage) then
  begin
    dialogfilesfo.tag := 0;

    dialogfilesfo.list_files.cellwidth := 437;

    thesdef := projectoptions.e.t.syntaxdeffiles[0];

    dialogfilesfo.Caption := 'Load a Syntax Definition File';

    dialogfilesfo.list_files.path := expandprmacros('${SYNTAXDEFDIR}');
    dialogfilesfo.list_files.mask := '*.sdef';
    dialogfilesfo.selected_file.frame.Caption := 'Selected Syntax Definition File';
    // + dialogfilesfo.list_files.directory ;
    dialogfilesfo.selected_file.Text := '';
    dialogfilesfo.Show(True);
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
      thetimer.tag := 1;
      thetimer.interval := 1000000;
      thetimer.Enabled := True;
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
  begin
    activate;
    // closeallmodule();

{
with settingsfo do
begin
activate;
but_ok.execute;
end;
}

  end;

{$ifdef polydev}
  top := 56;
 {$endif}

  debuggerfo.file_history.tag := 0;

end;

procedure tmainfo.loadconfigform(const Sender: TObject);
begin
  thetimer := ttimer.Create(TComponent(Sender));
  thetimer.interval := 500000;
  thetimer.ontimer := @onthetimer;
  thetimer.tag := 0;
  thetimer.Enabled := True;
end;

procedure tmainfo.ideureadconfig();
var
  libpath: msestring;
begin
  {$IFDEF Windows}
  libpath := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) +
    'plugin\designer_ext\designer_ext.exe';
    {$endif}

     {$IFDEF linux}
  libpath := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) +
    'plugin/designer_ext/designer_ext';
    {$endif}

    {$IFDEF freebsd}
     {$ifdef polydev}
  libpath := '/usr/local/share/designer_ext/designer_ext';
    {$else}
  libpath := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) +
    'plugin/designer_ext/designer_ext';
    {$endif}
    {$endif}

  if gINI.ReadBool('Completion', 'proplist', False) = False then
  begin
    debuggerfo.properties_list.tag := 0;
    debuggerfo.properties_list.imagenr := 20;
    sourcefo.thetimer.Enabled := False;
    sourcefo.hidesourcehint;
  end
  else
  begin
    debuggerfo.properties_list.tag := 1;
    debuggerfo.properties_list.imagenr := 21;
  end;


  conffpguifo.fpguidesigner.Value := gINI.ReadString('Path', 'designer_fpGUI', libpath);

  conffpguifo.ifloadfile.Value := gINI.ReadBool('ifloadfile', 'designer_fpGUI', True);
  conffpguifo.edfilename.Text :=
    gINI.ReadString('edfilename', 'designer_fpGUI', '${FILENAME}');

  conffpguifo.ifclose.Value := gINI.ReadBool('ifclose', 'designer_fpGUI', True);
  conffpguifo.edclose.Text := gINI.ReadString('edclose', 'designer_fpGUI', 'closeall');
  conffpguifo.ifshow.Value := gINI.ReadBool('ifshow', 'designer_fpGUI', True);
  conffpguifo.edshow.Text := gINI.ReadString('edshow', 'designer_fpGUI', 'showit');
  conffpguifo.ifhide.Value := gINI.ReadBool('ifhide', 'designer_fpGUI', True);
  conffpguifo.edhide.Text := gINI.ReadString('edhide', 'designer_fpGUI', 'hideit');
  conffpguifo.ifquit.Value := gINI.ReadBool('ifquit', 'designer_fpGUI', True);
  conffpguifo.edquit.Text := gINI.ReadString('edquit', 'designer_fpGUI', 'quit');

  confcompilerfo.twinep1.Value := gINI.ReadBool('fpc', 'winep1', False);
  confcompilerfo.twinep2.Value := gINI.ReadBool('fpc', 'winep2', False);
  confcompilerfo.twinep3.Value := gINI.ReadBool('fpc', 'winep3', False);
  confcompilerfo.twinep5.Value := gINI.ReadBool('fpc', 'winep5', False);
  confcompilerfo.twinep6.Value := gINI.ReadBool('fpc', 'winep6', False);
  confcompilerfo.twinep7.Value := gINI.ReadBool('fpc', 'winep7', False);
  confcompilerfo.twinep8.Value := gINI.ReadBool('fpc', 'winep8', False);


 {$ifdef polydev}
  confcompilerfo.fpccompiler.Value :=
    gINI.ReadString('fpc', 'compiler1', '/usr/local/lib/fpc/3.0.0/ppcx64');
  confcompilerfo.fpccompiler2.Value :=
    gINI.ReadString('fpc', 'compiler2', '/usr/local/lib/fpc/3.0.0/ppc386');
  confcompilerfo.fpccompiler3.Value :=
    gINI.ReadString('fpc', 'compiler3', '/usr/local/lib/fpc/3.0.0/ppcx64_linux');
  confcompilerfo.fpccompiler4.Value :=
    gINI.ReadString('fpc', 'compiler4', '/usr/local/lib/fpc/3.0.0/ppc386.exe');
  confcompilerfo.twinep4.Value := gINI.ReadBool('fpc', 'winep4', True);
  confcompilerfo.fpccompiler5.Value :=
    gINI.ReadString('fpc', 'compiler5', '/usr/local/lib/fpc/3.0.0/ppc386_linux');

  {$else}
  confcompilerfo.fpccompiler.Value := gINI.ReadString('fpc', 'compiler1', 'fpc');
  confcompilerfo.fpccompiler2.Value := gINI.ReadString('fpc', 'compiler2', '');
  confcompilerfo.twinep4.Value := gINI.ReadBool('fpc', 'winep4', False);
  confcompilerfo.fpccompiler3.Value := gINI.ReadString('fpc', 'compiler3', '');
  confcompilerfo.fpccompiler4.Value := gINI.ReadString('fpc', 'compiler4', '');
  {$endif}

  confcompilerfo.fpccompiler5.Value := gINI.ReadString('fpc', 'compiler5', '');
  confcompilerfo.fpccompiler6.Value := gINI.ReadString('fpc', 'compiler6', '');
  confcompilerfo.fpccompiler7.Value := gINI.ReadString('fpc', 'compiler7', '');
  confcompilerfo.fpccompiler8.Value := gINI.ReadString('fpc', 'compiler8', '');

  confcompilerfo.twinej1.Value := gINI.ReadBool('java', 'winej1', False);
  confcompilerfo.twinej2.Value := gINI.ReadBool('java', 'winej2', False);
  confcompilerfo.twinej3.Value := gINI.ReadBool('java', 'winej3', False);
  confcompilerfo.twinej4.Value := gINI.ReadBool('java', 'winej4', False);

  confcompilerfo.javacompiler.Value := gINI.ReadString('java', 'compiler1', 'javac');
  confcompilerfo.javacompiler2.Value := gINI.ReadString('java', 'compiler2', '');
  confcompilerfo.javacompiler3.Value := gINI.ReadString('java', 'compiler3', '');
  confcompilerfo.javacompiler4.Value := gINI.ReadString('java', 'compiler4', '');

  confcompilerfo.twinec1.Value := gINI.ReadBool('C', 'winec1', False);
  confcompilerfo.twinec2.Value := gINI.ReadBool('C', 'winec2', False);
  confcompilerfo.twinec3.Value := gINI.ReadBool('C', 'winec3', False);
  confcompilerfo.twinec4.Value := gINI.ReadBool('C', 'winec4', False);
  confcompilerfo.twinec5.Value := gINI.ReadBool('C', 'winec5', False);
  confcompilerfo.twinec6.Value := gINI.ReadBool('C', 'winec6', False);
  confcompilerfo.twinec7.Value := gINI.ReadBool('C', 'winec7', False);
  confcompilerfo.twinec8.Value := gINI.ReadBool('C', 'winec8', False);

  confcompilerfo.ccompiler.Value := gINI.ReadString('C', 'compiler1', '');
  confcompilerfo.ccompiler2.Value := gINI.ReadString('C', 'compiler2', '');
  confcompilerfo.ccompiler3.Value := gINI.ReadString('C', 'compiler3', '');
  confcompilerfo.ccompiler4.Value := gINI.ReadString('C', 'compiler4', '');
  confcompilerfo.ccompiler5.Value := gINI.ReadString('C', 'compiler5', '');
  confcompilerfo.ccompiler6.Value := gINI.ReadString('C', 'compiler6', '');
  confcompilerfo.ccompiler7.Value := gINI.ReadString('C', 'compiler7', '');
  confcompilerfo.ccompiler8.Value := gINI.ReadString('C', 'compiler8', '');

  confcompilerfo.twinepy1.Value := gINI.ReadBool('python', 'winepy1', False);
  confcompilerfo.twinepy2.Value := gINI.ReadBool('python', 'winepy2', False);
  confcompilerfo.twinepy3.Value := gINI.ReadBool('python', 'winepy3', False);
  confcompilerfo.twinepy4.Value := gINI.ReadBool('python', 'winepy4', False);

  confcompilerfo.pythoncompiler.Value := gINI.ReadString('python', 'compiler1', '');
  confcompilerfo.pythoncompiler2.Value := gINI.ReadString('python', 'compiler2', '');
  confcompilerfo.pythoncompiler3.Value := gINI.ReadString('python', 'compiler3', '');
  confcompilerfo.pythoncompiler4.Value := gINI.ReadString('python', 'compiler4', '');

  confcompilerfo.twineo1.Value := gINI.ReadBool('other', 'wineo1', False);
  confcompilerfo.twineo2.Value := gINI.ReadBool('other', 'wineo2', False);
  confcompilerfo.twineo3.Value := gINI.ReadBool('other', 'wineo3', False);
  confcompilerfo.twineo4.Value := gINI.ReadBool('other', 'wineo4', False);

  confcompilerfo.othercompiler.Value := gINI.ReadString('other', 'compiler1', '');
  confcompilerfo.othercompiler2.Value := gINI.ReadString('other', 'compiler2', '');
  confcompilerfo.othercompiler3.Value := gINI.ReadString('other', 'compiler3', '');
  confcompilerfo.othercompiler4.Value := gINI.ReadString('other', 'compiler4', '');

  confdebuggerfo.debugger1.Value := gINI.ReadString('debug', 'debugger1', '');
  confdebuggerfo.debugger2.Value := gINI.ReadString('debug', 'debugger2', '');
  confdebuggerfo.debugger3.Value := gINI.ReadString('debug', 'debugger3', '');
  confdebuggerfo.debugger4.Value := gINI.ReadString('debug', 'debugger4', '');

  conffpguifo.enablefpguidesigner.Value :=
    gINI.Readbool('Integration', 'designer_fpGUI', True);
  conffpguifo.tbfpgonlyone.Value :=
    gINI.Readbool('RunOnlyOnce', 'designer_fpGUI', True);

  confideufo.nozorderenable.Value := gINI.Readbool('nozorder', 'general', True);

  confideufo.universal_path.Value := gINI.Readbool('universaldir', 'general', False);

  confideufo.autofocus_menu.Value := gINI.Readbool('autofocusmenu', 'general', False);

  confideufo.key_accelerator.Value := gINI.Readbool('keyaccelerator', 'general', True);

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

  confideufo.trimtrailingwhitespace.Value :=
    gINI.Readbool('trimtrailingwhitespace', 'editor', False);

  confideufo.rightmarginchars.Value :=
    gINI.ReadInteger('rightmarginchars', 'editor', 80);

  confideufo.encoding.Value := gINI.ReadInteger('encoding', 'editor', 0);

  confideufo.backupfilecount.Value := gINI.ReadInteger('backupfilecount', 'editor', 0);

  if confideufo.nozorderenable.Value = True then
    nozorderhandling := True
  else
    nozorderhandling := False;

  libpath := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));

     {$ifdef windows}
  confideufo.tesakitdir.Text :=
    gINI.ReadString('Assistive', 'sakitdir', libpath + 'plugin\');
         {$else}
         {$ifdef polydev}
  confideufo.tesakitdir.Text :=
    gINI.ReadString('Assistive', 'sakitdir', '/usr/local/share/');
    {$else}
  confideufo.tesakitdir.Text :=
    gINI.ReadString('Assistive', 'sakitdir', libpath + 'plugin/');
       {$endif}
         {$endif}

  confideufo.tbassistive.Value := gINI.Readbool('Assistive', 'sak', False);


  if trim(ParamStr(1)) = '-va' then
  begin
    vaparam := True;
    confideufo.tbassistive.Value := True;
    debuggerfo.assistive.imagenr := 19;
  end;

  if confideufo.tbassistive.Value = True then
    doassistive;

  case gINI.ReadInteger('General', 'WarnChange', 2) of
    0:
    begin
      confideufo.tbfilereload.Value := True;
      confideufo.tbfilenoload.Value := False;
      confideufo.tbfileaskload.Value := False;
    end;
    1:
    begin
      confideufo.tbfilenoload.Value := True;
      confideufo.tbfilereload.Value := False;
      confideufo.tbfileaskload.Value := False;
    end;
    2:
    begin
      confideufo.tbfileaskload.Value := True;
      confideufo.tbfilereload.Value := False;
      confideufo.tbfilenoload.Value := False;
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
  // fred
  gINI.writeString('Path', 'designer_fpGUI', conffpguifo.fpguidesigner.Value);
  gINI.writebool('Integration', 'designer_fpGUI',
    conffpguifo.enablefpguidesigner.Value);
  gINI.writebool('RunOnlyOnce', 'designer_fpGUI', conffpguifo.tbfpgonlyone.Value);

  gINI.writeBool('ifloadfile', 'designer_fpGUI', conffpguifo.ifloadfile.Value);
  gINI.writeString('edfilename', 'designer_fpGUI', conffpguifo.edfilename.Text);

  gINI.writeBool('ifclose', 'designer_fpGUI', conffpguifo.ifclose.Value);
  gINI.writeString('edclose', 'designer_fpGUI', conffpguifo.edclose.Text);

  gINI.writeBool('ifshow', 'designer_fpGUI', conffpguifo.ifshow.Value);
  gINI.writeString('edshow', 'designer_fpGUI', conffpguifo.edshow.Text);

  gINI.writeBool('2xclick', 'sourcepage', confideufo.doubleclic.Value);

  gINI.writeBool('addwhiteaftercomma', 'editor', confideufo.addwhiteaftercomma.Value);

  gINI.writeBool('usedefaulteditoroptions', 'editor',
    confideufo.usedefaulteditoroptions.Value);

  gINI.WriteInteger('blockindent', 'editor', confideufo.blockindent.Value);

  gINI.writeBool('tabindent', 'editor', confideufo.tabindent.Value);

  gINI.WriteInteger('tabstops', 'editor', confideufo.tabstops.Value);

  gINI.writeBool('spacetabs', 'editor', confideufo.spacetabs.Value);

  gINI.writeBool('trimtrailingwhitespace', 'editor',
    confideufo.trimtrailingwhitespace.Value);

  gINI.WriteInteger('rightmarginchars', 'editor', confideufo.rightmarginchars.Value);

  gINI.WriteInteger('encoding', 'editor', confideufo.encoding.Value);

  gINI.WriteInteger('backupfilecount', 'editor', confideufo.backupfilecount.Value);

  gINI.writebool('nozorder', 'general', confideufo.nozorderenable.Value);

  if debuggerfo.properties_list.tag = 0 then
    gINI.writebool('Completion', 'proplist', False)
  else
    gINI.writebool('Completion', 'proplist', True);

  gINI.writebool('Assistive', 'sak', confideufo.tbassistive.Value);
  gINI.writeString('Assistive', 'sakitdir', confideufo.tesakitdir.Text);

  gINI.writebool('universaldir', 'general', confideufo.universal_path.Value);

  gINI.writebool('keyaccelerator', 'general', confideufo.key_accelerator.Value);

  gINI.writebool('addwhiteaftercomma', 'general', confideufo.addwhiteaftercomma.Value);

  gINI.writebool('fullpath', 'general', confideufo.fullpath.Value);

  gINI.writebool('autofocusmenu', 'general', confideufo.autofocus_menu.Value);

  gINI.writeBool('ifhide', 'designer_fpGUI', conffpguifo.ifhide.Value);
  gINI.writeString('edhide', 'designer_fpGUI', conffpguifo.edhide.Text);

  gINI.writeBool('ifquit', 'designer_fpGUI', conffpguifo.ifquit.Value);
  gINI.writeString('edquit', 'designer_fpGUI', conffpguifo.edquit.Text);

  gINI.writeBool('fpc', 'winep1', confcompilerfo.twinep1.Value);
  gINI.writeBool('fpc', 'winep2', confcompilerfo.twinep2.Value);
  gINI.writeBool('fpc', 'winep3', confcompilerfo.twinep3.Value);
  gINI.writeBool('fpc', 'winep4', confcompilerfo.twinep4.Value);
  gINI.writeBool('fpc', 'winep5', confcompilerfo.twinep5.Value);
  gINI.writeBool('fpc', 'winep6', confcompilerfo.twinep6.Value);
  gINI.writeBool('fpc', 'winep7', confcompilerfo.twinep7.Value);
  gINI.writeBool('fpc', 'winep8', confcompilerfo.twinep8.Value);

  gINI.writeString('fpc', 'compiler1', confcompilerfo.fpccompiler.Value);
  gINI.writeString('fpc', 'compiler2', confcompilerfo.fpccompiler2.Value);
  gINI.writeString('fpc', 'compiler3', confcompilerfo.fpccompiler3.Value);
  gINI.writeString('fpc', 'compiler4', confcompilerfo.fpccompiler4.Value);
  gINI.writeString('fpc', 'compiler5', confcompilerfo.fpccompiler5.Value);
  gINI.writeString('fpc', 'compiler6', confcompilerfo.fpccompiler6.Value);
  gINI.writeString('fpc', 'compiler7', confcompilerfo.fpccompiler7.Value);
  gINI.writeString('fpc', 'compiler8', confcompilerfo.fpccompiler8.Value);

  gINI.writeBool('java', 'winej1', confcompilerfo.twinej1.Value);
  gINI.writeBool('java', 'winej2', confcompilerfo.twinej2.Value);
  gINI.writeBool('java', 'winej3', confcompilerfo.twinej3.Value);
  gINI.writeBool('java', 'winej4', confcompilerfo.twinej4.Value);

  gINI.writeString('java', 'compiler1', confcompilerfo.javacompiler.Value);
  gINI.writeString('java', 'compiler2', confcompilerfo.javacompiler2.Value);
  gINI.writeString('java', 'compiler3', confcompilerfo.javacompiler3.Value);
  gINI.writeString('java', 'compiler4', confcompilerfo.javacompiler4.Value);

  gINI.writeBool('C', 'winec1', confcompilerfo.twinec1.Value);
  gINI.writeBool('C', 'winec2', confcompilerfo.twinec2.Value);
  gINI.writeBool('C', 'winec3', confcompilerfo.twinec3.Value);
  gINI.writeBool('C', 'winec4', confcompilerfo.twinec4.Value);
  gINI.writeBool('C', 'winec5', confcompilerfo.twinec5.Value);
  gINI.writeBool('C', 'winec6', confcompilerfo.twinec6.Value);
  gINI.writeBool('C', 'winec7', confcompilerfo.twinec7.Value);
  gINI.writeBool('C', 'winec8', confcompilerfo.twinec8.Value);

  gINI.writeString('C', 'compiler1', confcompilerfo.ccompiler.Value);
  gINI.writeString('C', 'compiler2', confcompilerfo.ccompiler2.Value);
  gINI.writeString('C', 'compiler3', confcompilerfo.ccompiler3.Value);
  gINI.writeString('C', 'compiler4', confcompilerfo.ccompiler4.Value);
  gINI.writeString('C', 'compiler5', confcompilerfo.ccompiler5.Value);
  gINI.writeString('C', 'compiler6', confcompilerfo.ccompiler6.Value);
  gINI.writeString('C', 'compiler7', confcompilerfo.ccompiler7.Value);
  gINI.writeString('C', 'compiler8', confcompilerfo.ccompiler8.Value);

  gINI.writeBool('python', 'winepy1', confcompilerfo.twinepy1.Value);
  gINI.writeBool('python', 'winepy2', confcompilerfo.twinepy2.Value);
  gINI.writeBool('python', 'winepy3', confcompilerfo.twinepy3.Value);
  gINI.writeBool('python', 'winepy4', confcompilerfo.twinepy4.Value);

  gINI.writeString('python', 'compiler1', confcompilerfo.pythoncompiler.Value);
  gINI.writeString('python', 'compiler2', confcompilerfo.pythoncompiler2.Value);
  gINI.writeString('python', 'compiler3', confcompilerfo.pythoncompiler3.Value);
  gINI.writeString('python', 'compiler4', confcompilerfo.pythoncompiler4.Value);

  gINI.writeBool('other', 'wineo1', confcompilerfo.twineo1.Value);
  gINI.writeBool('other', 'wineo2', confcompilerfo.twineo2.Value);
  gINI.writeBool('other', 'wineo3', confcompilerfo.twineo3.Value);
  gINI.writeBool('other', 'wineo4', confcompilerfo.twineo4.Value);

  gINI.writeString('other', 'compiler1', confcompilerfo.othercompiler.Value);
  gINI.writeString('other', 'compiler2', confcompilerfo.othercompiler2.Value);
  gINI.writeString('other', 'compiler3', confcompilerfo.othercompiler3.Value);
  gINI.writeString('other', 'compiler4', confcompilerfo.othercompiler4.Value);

  gINI.writeString('debug', 'debugger1', confdebuggerfo.debugger1.Value);
  gINI.writeString('debug', 'debugger2', confdebuggerfo.debugger2.Value);
  gINI.writeString('debug', 'debugger3', confdebuggerfo.debugger3.Value);
  gINI.writeString('debug', 'debugger4', confdebuggerfo.debugger4.Value);

  if confideufo.tbfilereload.Value = True then
    gINI.WriteInteger('General', 'WarnChange', 0)
  else
  if confideufo.tbfilenoload.Value = True then
    gINI.WriteInteger('General', 'WarnChange', 1)
  else
    gINI.WriteInteger('General', 'WarnChange', 2);

  if (conffpguifo.enablefpguidesigner.Value = True) and
    (conffpguifo.ifquit.Value = True) then
    LoadfpgDesigner(conffpguifo.edquit.Text);

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

procedure tmainfo.dofindmodulebyname(const amodule: pmoduleinfoty;
  const aname: string; var action: modalresultty);
var
  wstr2: msestring;

  function dofind(const modulenames: array of msestring;
  const modulefilenames: array of filenamety): boolean;
  var
    int1: integer;
    wstr1: msestring;
    po1: pmoduleinfoty;
  begin
    Result := False;
    for int1 := 0 to high(modulenames) do
    begin
      if modulenames[int1] = wstr2 then
      begin
        if int1 <= high(modulefilenames) then
        begin
          if findfile(modulefilenames[int1], projectoptions.d.texp.sourcedirs, wstr1) or
            findfile(filename(modulefilenames[int1]),
            projectoptions.d.texp.sourcedirs, wstr1) then
          begin
            try
              po1 := openformfile(wstr1, False, False, False, False, False);
              Result := (po1 <> nil) and (struppercase(po1^.instancevarname) = wstr2);
            except
              application.handleexception;
              Result := False;
            end;
          end;
        end;
        break;
      end;
    end;
  end;

var
  bo1: boolean;
  int1: integer;
  mstr1: filenamety;

begin
  wstr2 := struppercase(aname);
  int1 := findchar(wstr2, '.');
  if int1 > 0 then
  begin
    setlength(wstr2, int1 - 1); //main name only
  end;
  with projectoptions do
  begin
    bo1 := dofind(o.modulenames, o.modulefiles);
  end;
  if not bo1 and projecttree.units.findformbyname(wstr2, mstr1) then
  begin
    bo1 := dofind([wstr2], [mstr1]);
  end;
  if bo1 then
  begin
    action := mr_ok;
  end
  else
  begin
    action := ShowMessage(c[Ord(unresreferences)] + ' ' + amodule^.moduleclassname + ' ' +
      c[Ord(str_to)] + ' ' + aname +
      '.' + lineend + ' ' + c[Ord(wishsearch)], c[Ord(warning)],
      [mr_ok, mr_cancel], mr_ok);
    case action of
      mr_ok:
      begin
        wstr2 := '';
        //    openform.controller.filename:= '';
        //    openform.controller.captionopen:= c[ord(formfile)]+' '+ aname;
        if openform.controller.Execute(wstr2, fdk_open,
          c[Ord(formfile)] + ' ' + aname) then
        begin
          //    action:= filedialog(wstr2,[fdo_checkexist],c[ord(formfile)]+' '+ aname,
          //                 [c[ord(formfiles)]],['*.mfm'],'',nil,nil,nil,[fa_all],[fa_hidden]);
          //                 //defaultvalues don't work on kylix
          //    if action = mr_ok then begin
          //     openformfile(openform.controller.filename,false,false,true,true,false);
          openformfile(wstr2, False, False, True, True, False);
        end;
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
    begin
      if findfile(fname, d.texp.sourcedirs, wstr1) or
        findfile(fname, d.texp.sourcedirs, wstr1) then
      begin
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
    end;
  end;

var
  // ar1: msestringarty;
  mstr1: filenamety;

begin
  // ar1:= nil; //compilerwarning
  if fcheckmodulelevel >= 16 then
  begin
    ShowMessage(c[Ord(recursive)] + atypename + '"', c[Ord(error)]);
    SysUtils.abort;
  end;
  Inc(fcheckmodulelevel);
  try
    with projectoptions do
    begin
      po1 := nil;
      wstr2 := struppercase(atypename);
      for int1 := 0 to high(o.moduletypes) do
      begin
        if o.moduletypes[int1] = wstr2 then
        begin
          if int1 <= high(o.modulefiles) then
          begin
            checkmodule(o.modulefiles[int1]);
          end;
          break;
        end;
      end;
    end;
    if po1 = nil then
    begin
      if projecttree.units.findformbyclass(wstr2, mstr1) then
      begin
        checkmodule(mstr1);
      end;
  {
   ar1:= projecttree.units.moduleclassnames;
   for int1:= 0 to high(ar1) do begin
    if ar1[int1] = wstr2 then begin
     checkmodule(projecttree.units.modulefilenames[int1]);
     break;
    end;
   end;
   }
    end;
    if (po1 = nil) or (stringicomp(po1^.moduleclassname, atypename) <> 0) then
    begin
      if ShowMessage(c[Ord(str_classtype)] + ' ' + atypename + ' ' + c[Ord(notfound)] + lineend +
        ' ' + c[Ord(wishsearch)], c[Ord(warning)],
        [mr_yes, mr_cancel]) = mr_yes then
      begin
        wstr2 := '';
        if openform.controller.Execute(wstr2, fdk_open, c[Ord(formfile)] + ' ' +
          msestring(atypename), [fdo_checkexist]) then
        begin
          openformfile(wstr2, False, False, False, False, False);
        end;
      end;
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
  begin
    designer.showformdesigner(pmoduleinfoty(tagpo));
  end;
end;

procedure tmainfo.toggleobjectinspectoronexecute(const Sender: TObject);
begin
  if (flastform = objectinspectorfo) then
  begin
    if flastdesignform <> nil then
    begin
      flastdesignform.activate(True);
    end;
  end
  else
  begin
    objectinspectorfo.activate(True);
  end;
end;

procedure tmainfo.viewobjectinspectoronexecute(const Sender: TObject);
begin
  objectinspectorfo.activate(True);
end;

//idesignnotification

procedure Tmainfo.ItemDeleted(const ADesigner: IDesigner;
  const amodule: tmsecomponent; const AItem: TComponent);
begin

end;

procedure Tmainfo.ItemInserted(const ADesigner: IDesigner;
  const amodule: tmsecomponent; const AItem: TComponent);
begin
  componentpalettefo.resetselected;
end;

procedure tmainfo.moduleactivated(const adesigner: idesigner;
  const amodule: tmsecomponent);
begin
  factivedesignmodule := designer.actmodulepo;
  setlinkedvar(factivedesignmodule^.designform, tmsecomponent(flastdesignform));
end;

procedure tmainfo.moduledeactivated(const adesigner: idesigner;
  const amodule: tmsecomponent);
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
      begin
        with projectoptions, o, texp do
        begin
          if modified and not savechecked then
          begin
            Result := ShowMessage(c[Ord(project)] + ' ' + fprojectname + ' ' +
              c[Ord(ismodified)], c[Ord(confirmation)],
              [mr_yes, mr_no, mr_cancel], mr_yes);
            if Result = mr_yes then
            begin
              if projectfilename = '' then
              begin
                Result := projectfiledialog(str1, True);
                if Result <> mr_ok then
                begin
                  Result := mr_cancel;
                end;
              end
              else
              begin
                str1 := projectfilename;
              end;
              if Result <> mr_cancel then
              begin
                saveproject(str1);
              end;
            end
            else
            begin
              if Result <> mr_no then
              begin
                Result := mr_cancel;
              end;
            end;
            savechecked := True;
          end
          else
          begin
            saveproject(projectfilename);
          end;
        end;
      end;
    end;
  end;

  checksavecancel(Result);
end;

procedure tmainfo.updatemodifiedforms;
var
  int1: integer;
begin
  // with mainmenu1.menu.itembyname('view') do begin
  with mainmenu1.menu.itembynames(['forms', 'msemod']) do
  begin
    for int1 := itembyname('formmenuitemstart').index + 1 to Count - 1 do
    begin
      with items[int1] do
      begin
        with pmoduleinfoty(tagpo)^ do
        begin
          if modified then
          begin
            Caption := '*' + msefileutils.filename(filename);
          end
          else
          begin
            Caption := msefileutils.filename(filename);
          end;
          if (designform is tformdesignerfo) and designform.Visible then
          begin
            tformdesignerfo(designform).updatecaption;
          end;
        end;
      end;
    end;
  end;
end;

procedure Tmainfo.ItemsModified(const ADesigner: IDesigner; const AItem: TObject);
begin
  updatemodifiedforms;
  sourcechanged(nil);
end;

procedure tmainfo.componentnamechanging(const adesigner: idesigner;
  const amodule: tmsecomponent; const aitem: TComponent;
  const newname: string);
begin
  //dummy
end;

procedure tmainfo.moduleclassnamechanging(const adesigner: idesigner;
  const amodule: tmsecomponent; const newname: string);
begin
  //dummy
end;

procedure tmainfo.instancevarnamechanging(const adesigner: idesigner;
  const amodule: tmsecomponent; const newname: string);
begin
end;

procedure Tmainfo.SelectionChanged(const ADesigner: IDesigner;
  const ASelection: IDesignerSelections);
begin
  if (aselection.Count > 0) and (factivedesignmodule <> nil) then
  begin
    //  objectinspectorfo.bringtofront;
    // objectinspectorfo.show;
    // objectinspectorfo.activate;
    if not objectinspectorfo.active then
    begin
      objectinspectorfo.window.stackunder(factivedesignmodule^.designform.window);
    end;
  end;
end;

// fred
procedure tmainfo.picksdef(const Sender: TObject; var avalue: msestring;
  var accept: boolean);
begin
  sdefload(avalue);
end;

//debugger

procedure tmainfo.expronsetvalue(const Sender: TObject; var avalue: msestring;
  var accept: boolean);
var
  expres: string;
begin
  gdb.evaluateexpression(avalue, expres);
  exprdisp.Value := expres;
end;

procedure tmainfo.refreshframe;
var
  pc: qword;
begin
  cpufo.refresh;
  if gdb.getpc(pc) = gdb_ok then
  begin
    disassfo.refresh(pc);
  end
  else
  begin
    disassfo.Clear;
  end;
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
  begin
    RunCustomCompiled(page1.filepath, debuggerfo.edit_compiler.Value);
  end;
end;

procedure tmainfo.runwithoutdebugger;
var
  int1, int2: integer;
  strwine: string;

begin

  setstattext('', mtk_flat);

  int1 := 1;

  with projectoptions, o, texp do
  begin

    for int2 := 0 to high(compilerused) do
    begin
      if (thetag and compilerusedon[int2] <> 0) then
      begin
        if system.pos('Default', compilerused[int2]) > 0 then
          int1 := 1
        else
        if system.pos('Pascal', compilerused[int2]) > 0 then
          int1 := 1
        else
        if system.pos('Java', compilerused[int2]) > 0 then
          int1 := 2
        else
        if system.pos('C ', compilerused[int2]) > 0 then
          int1 := 3
        else
        if system.pos('Python', compilerused[int2]) > 0 then
          int1 := 4;

      end;
    end;
  end;

  strwine := '';
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
    strwine := '';
   {$ifdef linux}
    if (system.pos('.exe', gettargetfile) > 0) then
      strwine := IntToStr(int1) + 'w'
    else
    begin
      if (int1 = 1) or (int1 = 3) then
        strwine := ''
      else
        strwine := IntToStr(int1);
    end;
   {$else}
    if (int1 = 1) or (int1 = 3) then
      strwine := ''
    else
      strwine := IntToStr(int1);
   {$endif}

    RunCustomCompiled(gettargetfile, strwine);

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
        po1 := designer.modules.findmodule(str1);
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
            begin
              if toogletag = False then
              begin
                // if fpgfilename <> page1.filepath then
                //  begin
                setstattext('  Toggled to form...', mtk_flat);
                toogletag := True;

                sysfilename := tosysfilepath(filepath(str3, fk_file, True));

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
                  LoadfpgDesigner(conffpguifo.edhide.Text);
              end;
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
      else
      begin
        if str2 = formfileext then
        begin
          setstattext('  Toggled to mse source...', mtk_flat);

          page1 := sourcefo.findsourcepage(
            replacefileext(page1.filepath, pasfileext));
        end;
      end;
      if page1 <> nil then
      begin
        page1.activate;
      end;
    end;
  end
  else
  begin
    po1 := designer.actmodulepo;
    if po1 <> nil then
    begin
      str1 := replacefileext(po1^.filename, pasfileext);
      if sourcefo.openfile(str1, True) = nil then
      begin
        raise Exception.Create(ansistring(c[Ord(unableopen)] + str1 + '".'));
      end;
    end
    else
    begin
      if designer.modules.Count > 0 then
      begin
        designer.modules[0]^.designform.activate(True);
      end;
    end;
  end;
end;

procedure tmainfo.setstattext(const atext: msestring;
  const akind: messagetextkindty = mtk_info);
begin

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
        face.fade_color.items[1] := $B1CFAE;
        face.fade_color.items[0] := $96B094;
        //  face.fade_color.items[0]:= $CFCFCF;
        //  face.fade_color.items[1]:= $9E9E9E;
      end;
      mtk_error:
      begin
        face.fade_color.items[0] := $FFFFD4;
        face.fade_color.items[1] := $F0F097;
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
        face.fade_color.items[0] := $FFB1B4;
        face.fade_color.items[1] := $FF6E72;
      end
      else
      begin
        face.fade_color.items[0] := $CFCFCF;
        face.fade_color.items[1] := $9E9E9E;
      end;
    end;


    case akind of
      mtk_making: font.color := cl_red;
      else
        font.color := cl_black;
    end;
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
  begin
    sourcefo.gdbpage.hidehint;
  end;
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
      begin
        setstattext(messagetext, mtk_signal);
      end;
      sr_error:
      begin
        setstattext(messagetext, mtk_error);
      end;
      sr_exception:
      begin
      end;
      else
      begin
        setstattext(messagetext, mtk_finished);
      end;
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
      setstattext(messagetext + ' ' + stackfo.infotext(1), mtk_signal);
      if not stackfo.showsource(1) then
      begin
        sourcefo.locate(stopinfo);
      end;
    end
    else
    begin
      sourcefo.locate(stopinfo);
    end;
    if reason in [sr_exited, sr_exited_normally, sr_detached] then
    begin
      programfinished;
    end;
    if projectoptions.d.activateonbreak then
    begin
      application.activate();
  {
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
  }
    end;
    if projectoptions.d.raiseonbreak then
    begin
      application.packwindowzorder();
    end;
  end;
end;

procedure tmainfo.gdbonevent(const Sender: tgdbmi;
  var eventkind: gdbeventkindty; const values: resultinfoarty;
  const stopinfo: stopinfoty);
begin
  cpufo.stoptime.Value := gdb.stoptime;
  case eventkind of
    gek_stopped:
    begin
      with stopinfo do
      begin
        if (reason = sr_startup) and (fstartcommand = sc_continue) then
        begin
          gdb.continue;
        end
        else
        begin
          if breakpointsfo.checkbreakpointcontinue(stopinfo) then
          begin
            gdb.continue;
          end
          else
          begin
            if reason = sr_detached then
            begin
              cleardebugdisp;
              setstattext(stopinfo.messagetext, mtk_finished);
              programfinished;
              debuggerfo.project_reset.Enabled := False;
              debuggerfo.project_interrupt.Enabled := False;
            end
            else
            begin
              gdb.debugbegin;
              refreshstopinfo(stopinfo);
            end;
          end;
        end;
      end;
      fstartcommand := sc_none;
    end;
    gek_running:
    begin
      resetdebugdisp;
      setstattext(c[Ord(running)], mtk_warning);
      debuggerfo.project_reset.Enabled := True;
      debuggerfo.project_interrupt.Enabled := True;
    end;
    gek_error, gek_writeerror, gek_gdbdied:
    begin
      setstattext('GDB: ' + stopinfo.messagetext, mtk_error);
    end;
    gek_targetoutput:
    begin
      targetconsolefo.addtext(values[0].Value);
    end;
    gek_download:
    begin
      with stopinfo do
      begin
        if sectionsize > 0 then
        begin
          setstattext(c[Ord(str_downloading)] + ' ' + section + ' ' +
            IntToStr(round(sectionsent / sectionsize * 100)) + '%', mtk_making);
        end;
      end;
    end;
    gek_done:
    begin
      if Sender.downloaded then
      begin
        downloaded;
        setstattext(c[Ord(str_downloaded)] + ' ' + formatfloat('0.00,',
          stopinfo.totalsent / 1024) + 'kB', mtk_finished);
        //    sender.abort;
      end;
    end;
    gek_loaded:
    begin
      symbolfo.updatesymbols;
    end;
  end;
end;

procedure tmainfo.gdbserverexe(const Sender: tguiapplication;
  var again: boolean);
begin
  sys_schedyield;
  if timeout(fgdbservertimeout) and
    ((getprocessexitcode(fgdbserverprocid, fgdbserverexitcode, 100000) = pee_ok) or
    projectoptions.d.nogdbserverexit) then
  begin
    Sender.terminatewait;
  end
  else
  begin
    Sender.idlesleep(100000);
    again := True;
  end;
end;


function tmainfo.terminategdbserver(const force: boolean): boolean;
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
      begin
        killprocesstree(fgdbserverprocid);

      end;
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

function tmainfo.startgdbconnection(const attach: boolean): boolean;
var
  mstr1: msestring;
begin
  Result := False;
  with projectoptions, d.texp do
  begin
    if attach then
    begin
      mstr1 := gdbservercommandattach;
    end
    else
    begin
      mstr1 := gdbservercommand;
    end;
    if mstr1 <> '' then
    begin
      if terminategdbserver(False) then
      begin
        //    sleep(1000);
      end;

      if d.gdbserverstartonce and gdb.tryconnect then
      begin
        Result := True;
        exit;
      end;
      if d.gdbservertty then
      begin
        fgdbserverprocid := execmse2(syscommandline(mstr1), nil,
          targetpipe.pipereader, targetpipe.pipereader, -1, [exo_tty]);
      end
      else
      begin
        fgdbserverprocid := execmse2(syscommandline(mstr1), nil,
          nil, nil, -1, []);
      end;
      if fgdbserverprocid <> invalidprochandle then
      begin
        fgdbservertimeout := timestep(round(1000000 * d.gdbserverwait));
        if application.waitdialog(nil, c[Ord(startgdbservercommand)] +
          mstr1 + c[Ord(running2)], c[Ord(startgdbserver)],
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
            setstattext(c[Ord(gdbserverstarterror)] + ' ' + IntToStr(fgdbserverexitcode) + '.',
              mtk_error);
            exit;
          end;
        end
        else
        begin
          setstattext(c[Ord(gdbservercanceled)], mtk_error);
          exit;
        end;
      end
      else
      begin
        setstattext(c[Ord(cannotrunstartgdb)], mtk_error);
        exit;
      end;
    end;
  end;
  Result := True;
end;

function tmainfo.checkgdberror(aresult: gdbresultty): boolean;
begin
  Result := aresult = gdb_ok;
  if not Result then
  begin
    setstattext('GDB: ' + gdb.geterrormessage(aresult), mtk_error);
  end;
end;

procedure tmainfo.checkbluedots;
begin
  if (sourcefo <> nil) and (sourcefo.ActivePage <> nil) then
  begin
    if (gdb.execloaded or gdb.attached) and actionsmo.bluedotsonact.Checked then
    begin
      sourcefo.ActivePage.updatedebuglines;
    end
    else
    begin
      sourcefo.ActivePage.cleardebuglines;
    end;
  end;
end;

procedure tmainfo.updatesigsettings;
var
  int1, int2: integer;
  str1: string;
  bo1: boolean;
begin
  if gdb.active then
  begin
    bo1 := gdb.running;
    if bo1 then
    begin
      gdb.interrupttarget;
    end;
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
    begin
      for int1 := 0 to high(projectoptions.sigsettings) do
      begin
        with projectoptions.sigsettings[int1] do
        begin
          if num > 0 then
          begin
            for int2 := num to numto do
            begin
              gdb.handle(getsigname(int2), flags);
            end;
          end;
        end;
      end;
    end;
    if bo1 then
    begin
      gdb.restarttarget;
    end;
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
  begin
    targetconsolefo.activate;
  end;
end;

procedure tmainfo.uploadexe(const Sender: tguiapplication; var again: boolean);
begin
  if not downloading then
  begin
    Sender.terminatewait;
  end
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

function tmainfo.needsdownload: boolean;
begin
  Result := ftargetfilemodified or projectoptions.d.downloadalways;
end;

function tmainfo.candebug: boolean; //run command empty or process attached
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
    begin
      mainfo.startgdb(False);
    end;
  end;
end;


procedure tmainfo.updatetargetenvironment;
//todo: implement for run without gdb
var
  int1: integer;
begin
  with projectoptions, d.texp do
  begin
    gdb.progparameters := progparameters;
    gdb.workingdirectory := progworkingdirectory;
    gdb.clearenvvars;
    for int1 := 0 to high(envvarons) do
    begin
      if (int1 > high(envvarnames)) or (int1 > high(envvarnames)) then
      begin
        break;
      end;
      if envvarons[int1] then
      begin
        gdb.setenvvar(envvarnames[int1], envvarvalues[int1]);
      end
      else
      begin
        gdb.unsetenvvar(envvarnames[int1]);
      end;
    end;
  end;
end;

function tmainfo.loadexec(isattach: boolean;
  const forcedownload: boolean): boolean;
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
  else
  begin
    if not gdb.execloaded or forcedownload then
    begin

      with projectoptions, d.texp do
      begin

        if d.restartgdbbeforeload or not gdb.active then
        begin
          startgdb(False);
        end;
        str1 := gettargetfile;

        if not d.gdbdownload and not d.gdbsimulator and (uploadcommand <> '') and
          (needsdownload or forcedownload) then
        begin
          dodownload;
          if application.waitdialog(nil, c[Ord(str_uploadcommand)] + uploadcommand +
            c[Ord(running2)], c[Ord(str_downloading)],
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
              setstattext(c[Ord(downloaderror)] + ' ' +
                IntToStr(downloadresult) + '.', mtk_error);
              exit;
            end
            else
            begin
              setstattext(c[Ord(downloadfinished)], mtk_finished);
              downloaded;
              if projectoptions.o.closemessages then
              begin
                messagefo.hide;
              end;
            end;
          end
          else
          begin
            setstattext(c[Ord(downloadcanceled)], mtk_error);
            exit;
          end;
        end;
      end;
      mainfo.setstattext(actionsmo.c[Ord(ac_loading)] + '.', mtk_error);

      debuggerfo.project_reset.Enabled := True;
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
  end;
  Result := gdb.execloaded or gdb.attached;
  if Result then
  begin
    updatetargetenvironment;
    watchpointsfo.Clear;
    targetconsolefo.Clear;
    if projectoptions.d.showconsole then
    begin
      targetconsolefo.activate;
    end;
    if forcedownload and projectoptions.d.gdbdownload then
    begin
      if startgdbconnection(False) then
      begin
        if checkgdberror(gdb.download(False)) then
        begin
          fgdbdownloaded := True;
        end;

      end;
    end;
  end;
end;

procedure tmainfo.unloadexec;
begin
  if gdb.active then
  begin
    gdb.fileexec('');   //unload exec
  end;
  resetdebugdisp;
  checkbluedots;
end;

procedure tmainfo.startgdb(const killserver: boolean);
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
  begin
    for int3 := 0 to high(debuggerused) do
    begin
      if (thetag and debuggerusedon[int3] <> 0) and (debuggerused[int3] <> '') then
      begin

        if system.pos('Default', debuggerused[int3]) > 0 then
          str3 := 'Default Debugger'
        else

        if (trim(debuggerused[int3]) = 'Debugger 1') then
          str3 := quotefilename(tosysfilepath(confdebuggerfo.debugger1.Value))
        else

        if (trim(debuggerused[int3]) = 'Debugger 2') then
          str3 := quotefilename(tosysfilepath(confdebuggerfo.debugger2.Value))
        else

        if (trim(debuggerused[int3]) = 'Debugger 3') then
          str3 := quotefilename(tosysfilepath(confdebuggerfo.debugger3.Value))
        else

        if (trim(debuggerused[int3]) = 'Debugger 4') then
          str3 := quotefilename(tosysfilepath(confdebuggerfo.debugger4.Value))
        else
          str3 := '';

      end;
    end;
  end;


  int1 := 1;

  with projectoptions, o, texp do
  begin

    for int2 := 0 to high(compilerused) do
    begin
      if (thetag and compilerusedon[int2] <> 0) then
      begin
        if system.pos('Default', compilerused[int2]) > 0 then
          int1 := 1
        else
        if system.pos('Pascal', compilerused[int2]) > 0 then
          int1 := 1
        else
        if system.pos('Java', compilerused[int2]) > 0 then
          int1 := 2
        else
        if system.pos('C ', compilerused[int2]) > 0 then
          int1 := 3
        else
        if system.pos('Python', compilerused[int2]) > 0 then
          int1 := 4;
      end;
    end;
  end;

  if (str3 <> '') and ((int1 = 1) or (int1 = 3)) then
  begin
    terminategdbserver(killserver);
    with projectoptions, d.texp do
    begin
      gdb.remoteconnection := remoteconnection;
      gdb.gdbdownload := d.gdbdownload;
      gdb.simulator := d.gdbsimulator;
      gdb.processorname := gdbprocessor;
      gdb.guiintf := not d.nodebugbeginend;
      gdb.beforeconnect := beforeconnect;
      gdb.afterconnect := afterconnect;
      gdb.beforeload := beforeload;
      gdb.afterload := afterload;
      gdb.beforerun := beforerun;
      gdb.startupbkpt := d.startupbkpt;
      gdb.startupbkpton := d.startupbkpton;

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

procedure tmainfo.symboltypeonsetvalue(const Sender: TObject;
  var avalue: msestring; var accept: boolean);
var
  expres: string;
begin
  gdb.symboltype(avalue, expres);
  symboltypedisp.Value := expres;
end;

procedure tmainfo.viewbreakpointsonexecute(const Sender: TObject);
begin
  breakpointsfo.activate;
  if breakpointsfo.Width < 50 then
  begin
    breakpointsfo.Height := 180;
    breakpointsfo.Width := 250;
  end;
end;

procedure tmainfo.viewwatchesonexecute(const Sender: TObject);
begin
  watchfo.activate;
  if watchfo.Width < 50 then
  begin
    watchfo.Height := 180;
    watchfo.Width := 250;
  end;
end;

procedure tmainfo.viewstackonexecute(const Sender: TObject);
begin
  stackfo.activate;
  if stackfo.Width < 50 then
  begin
    stackfo.Height := 180;
    stackfo.Width := 250;
  end;
end;

procedure tmainfo.onscale(const Sender: TObject);
begin
  // fred
  basedock.bounds_y := 0;
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
    breakpointsfo.Width := 250;
  end;
end;

procedure tmainfo.viewmemoryonexecute(const Sender: TObject);
begin
  memoryfo.activate;
  if memoryfo.Width < 50 then
  begin
    memoryfo.Height := 180;
    memoryfo.Width := 250;
  end;
end;

procedure tmainfo.viewcpuonexecute(const Sender: TObject);
begin
  cpufo.activate;
  if cpufo.Width < 50 then
  begin
    cpufo.Height := 180;
    cpufo.Width := 250;
  end;
end;

procedure tmainfo.viewmessagesonexecute(const Sender: TObject);
begin
  messagefo.activate;
  if messagefo.Width < 50 then
  begin
    messagefo.Height := 180;
    messagefo.Width := 250;
  end;
end;

procedure tmainfo.viewsourceonexecute(const Sender: TObject);
begin
  sourcefo.activate;
  if sourcefo.Width < 50 then
  begin
    sourcefo.Height := 180;
    sourcefo.Width := 250;
  end;
end;

procedure tmainfo.mainmenuonupdate(const Sender: tcustommenu);
var
  bo1: boolean;
begin
  with debuggerfo do
  begin
    project_start.Enabled := not gdb.running and not gdb.downloading;
    project_next.Enabled := not gdb.running and not gdb.downloading and bo1;
    project_next_instruction.Enabled := project_next.Enabled;
    project_step.Enabled := project_next.Enabled;
    project_step_instruction.Enabled := project_next.Enabled;
    // project_interrupt.enabled := project_next.enabled;
    // project_finish.enabled:= not gdb.running and gdb.started and bo1;
    // project_reset.enabled:= (gdb.started or gdb.attached or gdb.downloading) or
    //                    not bo1 and (frunningprocess <> invalidprochandle);
  end;

  with projectoptions, d.texp, actionsmo do
  begin
    detachtarget.Enabled := gdb.execloaded or gdb.attached;

    download.Enabled := not gdb.started and not gdb.downloading and
      ((uploadcommand <> '') or d.gdbdownload);
    attachprocess.Enabled := not (gdb.execloaded or gdb.attached);
    attachtarget.Enabled := attachprocess.Enabled;
    run.Enabled := not gdb.running and not gdb.downloading;
    bo1 := candebug;
    step.Enabled := not gdb.running and not gdb.downloading and bo1;
    stepi.Enabled := not gdb.running and not gdb.downloading and bo1;
    Next.Enabled := not gdb.running and not gdb.downloading and bo1;
    nexti.Enabled := not gdb.running and not gdb.downloading and bo1;
    finish.Enabled := not gdb.running and gdb.started and bo1;
    continue.Enabled := not gdb.running and not gdb.downloading and
      (bo1 or (frunningprocess = invalidprochandle));
    interrupt.Enabled := gdb.running and not gdb.downloading and bo1;
    reset.Enabled := (gdb.started or gdb.attached or gdb.downloading) or
      not bo1 and (frunningprocess <> invalidprochandle);
    makeact.Enabled := not making;
    abortmakeact.Enabled := making;
    saveall.Enabled := sourcefo.modified or designer.modified or
      projectoptions.modified;
    actionsmo.toggleformunit.Enabled := (flastform <> nil) or (designer.modules.Count > 0);
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


      setbm7.Enabled := True;
      setbm8.Enabled := True;
      setbm8.Enabled := True;
      setbm9.Enabled := True;
      setbmnone.Enabled := True;
      findbm0.Enabled := True;
      findbm1.Enabled := True;
      findbm2.Enabled := True;
      findbm3.Enabled := True;
      findbm4.Enabled := True;
      findbm5.Enabled := True;
      findbm6.Enabled := True;
      findbm7.Enabled := True;
      findbm8.Enabled := True;
      findbm9.Enabled := True;
      print.Enabled := True;
      //debuggerfo.save_file.enabled := modified;

      with sourcefo.ActivePage do
      begin
        actionsmo.save.Enabled := modified;
        actionsmo.savecust.Enabled := modified;
        undo.Enabled := edit.canundo;
        redo.Enabled := edit.canredo;
        copy.Enabled := edit.hasselection;
        copylatexact.Enabled := edit.hasselection;
        cut.Enabled := edit.hasselection;
        paste.Enabled := edit.canpaste;
        Delete.Enabled := edit.hasselection;
        indent.Enabled := True;
        unindent.Enabled := True;
        line.Enabled := source_editor.rowcount > 0;
        togglebkpt.Enabled := line.Enabled;
        togglebkptenable.Enabled := togglebkpt.Enabled;
        //    find.enabled:= true;
        replace.Enabled := True;
        copyword.Enabled := True;
        //    actionsmo.repeatfind.enabled:= find.enabled and
        //           (projectoptions.findreplaceinfo.find.text <> '');
      end;
    end
    else
    begin
      setbm0.Enabled := False;
      setbm1.Enabled := False;
      setbm2.Enabled := False;
      setbm3.Enabled := False;
      setbm4.Enabled := False;
      setbm5.Enabled := False;
      setbm6.Enabled := False;
      setbm7.Enabled := False;
      setbm8.Enabled := False;
      setbm8.Enabled := False;
      setbm9.Enabled := False;
      setbmnone.Enabled := False;
      findbm0.Enabled := False;
      findbm1.Enabled := False;
      findbm2.Enabled := False;
      findbm3.Enabled := False;
      findbm4.Enabled := False;
      findbm5.Enabled := False;
      findbm6.Enabled := False;
      findbm7.Enabled := False;
      findbm8.Enabled := False;
      findbm9.Enabled := False;

      print.Enabled := False;
      save.Enabled := False;

      undo.Enabled := False;
      redo.Enabled := False;
      copy.Enabled := False;
      copylatexact.Enabled := False;
      cut.Enabled := False;
      paste.Enabled := False;
      Delete.Enabled := False;
      indent.Enabled := False;
      unindent.Enabled := False;
      line.Enabled := True;
      togglebkpt.Enabled := False;
      togglebkptenable.Enabled := False;

      //   actionsmo.repeatfind.enabled:= false;
      // replace.enabled:= false;
      replace.Enabled := True;
      copyword.Enabled := True;

    end;
    if (factivedesignmodule <> nil) then
    begin
      save.Enabled := factivedesignmodule^.modified;
      //debuggerfo.save_file.enabled := save.enabled;
      Close.Enabled := True;
    end
    else
    begin
      Close.Enabled := sourcefo.Count > 0;
    end;
    closeall.Enabled := (sourcefo.Count > 0) or (designer.modules.Count > 0);
    saveas.Enabled := (factivedesignmodule <> nil) or (sourcefo.ActivePage <> nil);
    mainmenu1.menu.itembyname('project').itembyname('close').Enabled :=
      fprojectloaded;
  end;
end;

function tmainfo.formmenuitemstart: integer;
begin
  // result:= mainmenu1.menu.itembyname('view').itembyname('formmenuitemstart').index + 1;
  Result := mainmenu1.menu.itembynames(['forms', 'msemod']).itembyname(
    'formmenuitemstart').index + 1;

end;

procedure tmainfo.createmodulemenuitem(const amodule: pmoduleinfoty);
var
  int1: integer;
  item1: tmenuitem;
begin
  //with mainmenu1.menu.itembyname('view') do begin

  with mainmenu1.menu.itembynames(['forms', 'msemod']) do
  begin

    for int1 := formmenuitemstart to submenu.Count - 1 do
    begin
      if submenu[int1].tagpo = amodule then
      begin
        exit;
      end;
    end;
    amodule^.hasmenuitem := True;
    item1 := tmenuitem.Create;
    with item1 do
    begin
      if amodule^.modified then
      begin
        Caption := '*' + msefileutils.filename(amodule^.filename);
      end
      else
      begin
        Caption := msefileutils.filename(amodule^.filename);
      end;
      onexecute :=
{$ifdef FPC}
        @
{$endif}
        doshowform;
      tagpo := amodule;
      options := options + [mao_asyncexecute];
    end;
    for int1 := formmenuitemstart to submenu.Count - 1 do
    begin
      if submenu[int1].Caption > item1.Caption then
      begin
        submenu.insert(int1, item1);
        exit;
      end;
    end;
    submenu.insert(bigint, item1);
  end;
end;

function tmainfo.openformfile(const filename: filenamety;
  const ashow, aactivate, showsource, createmenu,
  skipexisting: boolean): pmoduleinfoty;
var
  // item1: tmenuitem;
  wstr1, wstr2: filenamety;
  // bo1: boolean;
  // int1: integer;
begin
  Result := designer.modules.findmodule(filename);


  if Result = nil then
  begin
    wstr2 := msefileutils.filename(filename);
    if findfile(filename) then
    begin
      wstr1 := filename;
    end
    else
    begin
      wstr1 := searchfile(wstr2, projectoptions.d.texp.sourcedirs);
      if wstr1 = '' then
      begin
        wstr1 := filename; //to raise exception
      end
      else
      begin
        wstr1 := wstr1 + wstr2;
      end;
    end;
    try
      Result := designer.loadformfile(wstr1, skipexisting);
    except
      showobjecttext(nil, wstr1, False);
      errorformfilename := wstr1;
      raise;
    end;
    if Result <> nil then
    begin
      if showsource then
      begin
        loadsourcebyform(wstr1);
      end;
    end;
  end;
  if Result <> nil then
  begin
    if createmenu then
    begin
      createmodulemenuitem(Result);
    end;
    if ashow then
    begin
      Result^.designform.Show;
      if aactivate then
      begin
        Result^.designform.activate;
      end;
    end;
    if Result^.modified then
    begin
      sourcechanged(nil);
    end;
  end;
end;

procedure tmainfo.loadformbysource(const sourcefilename: filenamety);
var
  str1: filenamety;
  activebefore: pmoduleinfoty;
  sysfilename: string;
begin
  if fileext(sourcefilename) = pasfileext then
  begin

    if (conffpguifo.enablefpguidesigner.Value = True) then
    begin
      sysfilename := tosysfilepath(filepath(trim(sourcefilename), fk_file, True));
      LoadfpgDesigner(sysfilename);
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

procedure tmainfo.loadsourcebyform(const formfilename: filenamety;
  const aactivate: boolean = False);
begin
  sourcefo.openfile(replacefileext(formfilename, pasfileext), aactivate);
end;

function tmainfo.opensource(const filekind: filekindty; const addtoproject: boolean;
  const aactivate: boolean = True;
  const currentnode: tprojectnode = nil): boolean;

var
  unitnode: tunitnode;

var
  int1: integer;
  page: tsourcepage;
  str1: filenamety;
  po1: pmoduleinfoty;

begin //opensourceactonexecute
  Result := openfile.Execute = mr_ok;
  if Result then
  begin
    page := nil;
    po1 := nil;
    unitnode := nil; //compilerwarning
    designer.beginskipall;
    try
      with openfile.controller do
      begin
        for int1 := 0 to high(filenames) do
        begin
          if checkfileext(filenames[int1], [formfileext]) then
          begin
            page := sourcefo.findsourcepage(filenames[int1]);
            if page = nil then
            begin
              po1 := openformfile(filenames[int1], True, False, False, True, False);
            end;
          end
          else
          begin
            page := sourcefo.openfile(filenames[int1]);
            if addtoproject then
            begin
              unitnode := projecttree.units.addfile(currentnode, filenames[int1]);
            end;
            str1 := designer.sourcenametoformname(filenames[int1]);
            if findfile(str1) then
            begin
              po1 := openformfile(str1, True, False, False, True, False);
              if addtoproject then
              begin
                unitnode.setformfile(str1);
              end;
            end;
          end;
        end;
      end;
    finally
      designer.endskipall;
    end;
    if aactivate then
    begin
      if page <> nil then
      begin
        page.activate(True, True);
      end
      else
      begin
        if po1 <> nil then
        begin
          po1^.designform.activate(True, True);
        end;
      end;
    end;
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
  else
  begin
    if (designer.actmodulepo <> nil) and
      (designer.actmodulepo^.designform = flastform) then
    begin
      factivedesignmodule := designer.actmodulepo;
      setlinkedvar(Sender, tmsecomponent(flastdesignform));
    end;
  end;
end;

procedure tmainfo.viewcomponentpaletteonexecute(const Sender: TObject);
begin
  componentpalettefo.window.bringtofront;
  componentpalettefo.Caption := 'MSE Component Palette';
  componentpalettefo.Show;
end;

procedure tmainfo.viewcomponentstoreonexecute(const Sender: TObject);
begin
  componentstorefo.activate;
end;

procedure tmainfo.viewfpguidesigneronexecute(const Sender: TObject);
begin

  LoadfpgDesigner(conffpguifo.edshow.Text);

end;

procedure tmainfo.resetfpguidesigneronexecute(const Sender: TObject);
begin
  if (conffpguifo.enablefpguidesigner.Value = True) and
    (conffpguifo.ifshow.Value = True) then
  begin
    LoadfpgDesigner('hideit');
    sleep(1000);
    LoadfpgDesigner(conffpguifo.edshow.Text);
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
  int1 := length(aname) - length(suffix);
  if (int1 >= 0) and (strcomp(PChar(aname) + int1, PChar(suffix)) = 0) then
  begin
    Result := copy(aname, 1, int1) + copy(suffix, 1, 2);
  end
  else
  begin
    Result := aname + copy(suffix, 1, 2);
  end;
end;

procedure tmainfo.createform(const aname: filenamety; const namebase: string;
  const ancestor: string);
var
  stream1: ttextstream;
  str1, str2, str3: string;
  po1: pmoduleinfoty;
begin
  str2 := removefileext(filename(aname));
  str3 := str2;
  str2 := getmodulename(str2, namebase);
  stream1 := ttextstream.Create(aname, fm_create);
  try
    formskeleton(stream1, filename(str3), str2, ancestor);
  finally
    stream1.Free;
  end;
  sourcefo.showsourceline(aname, 0, 0, True);
  str1 := replacefileext(aname, formfileext);
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
  po1 := openformfile(str1, True, False, True, True, False);
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
    programskeleton(stream1, removefileext(filename(aname)));
  finally
    stream1.Free;
  end;
  sourcefo.showsourceline(aname, 0, 0, True);
end;

function tmainfo.copynewfile(const aname, newname: filenamety;
  const autoincrement: boolean;
  const canoverwrite: boolean;
  const macronames: array of msestring;
  const macrovalues: array of msestring): boolean;
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
  path1 := searchfile(aname);
  if path1 = '' then
  begin
    ShowMessage(c[Ord(str_file)] + aname + c[Ord(notfound2)], c[Ord(warning)]);
  end
  else
  begin
    path2 := filepath(newname);
    if not canoverwrite and findfile(path2) then
    begin
      if not autoincrement then
      begin
        showerror(c[Ord(str_file)] + newname + c[Ord(exists)]);
        exit;
      end
      else
      begin
        splitfilepath(filepath(aname), dir, base, ext);
        base := base + dir;
        int1 := 1;
        repeat
          path2 := base + IntToStr(int1) + ext;
          Inc(int1);
        until not findfile(path2);
      end;
    end;
    splitfilepath(path2, dir, base, ext);
    macrolist := tmacrolist.Create([mao_curlybraceonly]);
    try
      macrolist.add(['%FILEPATH%', '%FILENAME%', '%FILENAMEBASE%'],
        [path2, base + ext, base], []);
      macrolist.add(macronames, macrovalues, []);
      instream := ttextstream.Create(path1);
      try
        Text := instream.readmsestrings;
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
  begin
    if newfisources[int1] = '' then
    begin
      sourcefo.newpage;
    end
    else
    begin
      if filedialog(str1, [fdo_save, fdo_checkexist], c[Ord(str_new)] + ' ' +
        newfinames[int1], [newfinames[int1]],
        [newfifilters[int1]], newfiexts[int1]) = mr_ok then
      begin
        copynewfile(newfisources[int1], str1, False, True,
          ['%PROGRAMNAME%', '%UNITNAME%'], ['${%FILENAMEBASE%}',
          '${%FILENAMEBASE%}']);
        sourcefo.openfile(str1, True);
      end;
    end;
  end;
end;

procedure tmainfo.newformonexecute(const Sender: TObject);
var
  str1, str2, str3, str4, str5: filenamety;
  dir, base, ext: filenamety;
  po1: pmoduleinfoty;
  ancestorclass, ancestorunit: string;

begin
  // if formkindty(tmenuitem(sender).tag) = fok_inherited then begin
  if projectoptions.o.newinheritedforms[tmenuitem(Sender).tag] then
  begin
    po1 := selectinheritedmodule(nil, c[Ord(selectancestor)]);
    if po1 = nil then
    begin
      exit;
    end;
    ancestorclass := po1^.moduleclassname;
    ancestorunit := filenamebase(po1^.filename);
  end
  else
  begin
    ancestorclass := '';
    ancestorunit := '';
    po1 := nil;
  end;
  str1 := '';
  if filedialog(str1, [fdo_save, fdo_checkexist], c[Ord(newform)],
    [c[Ord(pascalfiles)]],
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
      begin
        str2 := filepath(str2); //sourcesource
      end;
      if str3 <> '' then
      begin
        str3 := filepath(str3); //formsource
      end;
      splitfilepath(str1, dir, base, ext);
      str4 := getmodulename(base, str4);
      str5 := replacefileext(str1, 'mfm');
      if str2 <> '' then
      begin
        copynewfile(str2, str1, False, True,
          ['%UNITNAME%', '%FORMNAME%', '%ANCESTORUNIT%', '%ANCESTORCLASS%'],
          ['${%FILENAMEBASE%}', str4, ancestorunit, ancestorclass]); //source
      end;
      if str3 <> '' then
      begin
        copynewfile(str3, str5, False, True,
          ['%UNITNAME%', '%FORMNAME%', '%ANCESTORUNIT%', '%ANCESTORCLASS%'],
          ['${%FILENAMEBASE%}', str4, ancestorunit, ancestorclass]); //form
      end;
      if str2 <> '' then
      begin
        sourcefo.openfile(str1, True);
      end;
      if (str3 <> '') then
      begin
        openformfile(str5, True, False, False, True, False);
        po1 := designer.modules.findmodule(str5);
        if po1 <> nil then
        begin
          po1^.modified := True; //initial create of ..._mfm.pas
        end;
      end;
    end
    else
    begin
      //   createform(str1,formkindty(tmenuitem(sender).tag));
      createform(str1, 'form', 'tmseform'); //default
    end;
  end;
end;

procedure tmainfo.removemodulemenuitem(const amodule: pmoduleinfoty);
var
  int1: integer;
begin
  // with mainmenu1.menu.itembyname('view') do begin
  with mainmenu1.menu.itembynames(['forms', 'msemod']) do
  begin

    for int1 := itembyname('formmenuitemstart').index + 1 to Count - 1 do
    begin
      if items[int1].tagpo = amodule then
      begin
        submenu.Delete(int1);
        break;
      end;
    end;
  end;
end;

function tmainfo.closeallmodule(): boolean;
var
  int1: integer;
begin
  while designer.modules.Count > 0 do
  begin
    closemodule(designer.modules.itempo[designer.modules.Count - 1], False, True);
  end;
end;

function tmainfo.closemodule(const amodule: pmoduleinfoty;
  const achecksave: boolean;
  nocheckclose: boolean = False): boolean;
var
  str1: string;
begin
  if amodule <> nil then
  begin
    if nocheckclose or designer.checkcanclose(amodule, str1) then
    begin
      Result := designer.closemodule(amodule, achecksave);
    end
    else
    begin
      amodule^.designform.hide;
      Result := True;
      removemodulemenuitem(amodule);
      amodule^.hasmenuitem := False;
    end;
    if Result then
    begin
      if factivedesignmodule = amodule then
      begin
        factivedesignmodule := nil;
      end;
    end;
  end
  else
  begin
    Result := True;
  end;
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

function tmainfo.closeall(const nosave: boolean): boolean;
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
      begin
        closemodule(designer.modules.itempo[designer.modules.Count - 1], not nosave, True);
      end;
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
  begin
    for int1 := 0 to Messages.rowcount - 1 do
    begin
      if locateerrormessage(Messages[0][int1], apage, el_error) then
      begin
        Messages.focuscell(makegridcoord(0, int1));
        setstattext(Messages[0][int1], mtk_error);
        break;
      end;
    end;
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
procedure tmainfo.mainfoonterminate(var terminate: boolean);
//var
// modres: modalresultty;
begin
  if checksave = mr_cancel then
  begin
    terminate := False;
  end
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
  begin
    Caption := idecaption + ' (<' + c[Ord(new2)] + '>)';
  end
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

function tmainfo.openproject(const aname: filenamety;
  const ascopy: boolean = False): boolean;

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

begin
  gdb.abort;
  terminategdbserver(True);
  Result := False;

  TheProjectDirectory := ExtractFilePath(ExpandFileName(aname));

  debuggerfo.project_history.Value := ExpandFileName(aname);

  if assigned(debuggerfo) then
  begin
    debuggerfo.project_make.hint := ' Compile project ' + ExtractFilename(aname) + ' ';
    debuggerfo.project_start.hint := ' Start project ' + ExtractFilename(aname) + ' ';
    debuggerfo.project_save.hint := ' Save project ' + ExtractFilename(aname) + ' ';
    debuggerfo.project_abort_compil.hint :=
      ' Abort compile project ' + ExtractFilename(aname) + ' ';
    debuggerfo.project_next.hint := ' Next in project ' + ExtractFilename(aname) + ' ';
    debuggerfo.project_step.hint := ' Step in project ' + ExtractFilename(aname) + ' ';
    debuggerfo.project_finish.hint := ' Finish project ' + ExtractFilename(aname) + ' ';
    debuggerfo.project_next_instruction.hint :=
      ' Next instruction in project ' + ExtractFilename(aname) + ' ';
    debuggerfo.project_step_instruction.hint :=
      ' Step instruction in project ' + ExtractFilename(aname) + ' ';
    debuggerfo.project_reset.hint := ' Reset project ' + ExtractFilename(aname) + ' ';
    debuggerfo.project_interrupt.hint :=
      ' Interrupt project ' + ExtractFilename(aname) + ' ';
    debuggerfo.project_options.hint :=
      ' Option Number for project ' + ExtractFilename(aname) + ' ';
    debuggerfo.project_option.hint :=
      ' Options for project ' + ExtractFilename(aname) + ' ';
  end;

  projectfilebefore := projectoptions.projectfilename;
  projectdirbefore := projectoptions.projectdir;
  namebefore := fprojectname;
  if (checksave <> mr_cancel) and closeall(True) then
  begin
    closepro;
    if aname <> '' then
    begin
      try
        setcurrentdirmse(removelastpathsection(aname));
      except
        application.handleexception(nil, c[Ord(cannotloadproj)] + aname + '": ');
        exit;
      end;
      if not readprojectoptions(aname) then
      begin
        closepro;
      end
      else
      begin
        fcurrent := False;
        gdb.closegdb;
        cleardebugdisp;
        if not ascopy then
        begin
          setprojectname(aname);
        end
        else
        begin
          projectoptions.projectfilename := projectfilebefore;
          projectoptions.projectdir := projectdirbefore;
          expandprojectmacros;
          setprojectname(namebefore);
        end;
      end;
    end;
    Result := True;
    fprojectloaded := True;

    if projectoptions.d.showconsole = True then
    begin
      debuggerfo.terminal_run.tag := 1;
      debuggerfo.terminal_run.imagenr := 34;
    end
    else
    begin
      debuggerfo.terminal_run.tag := 0;
      debuggerfo.terminal_run.imagenr := 33;
    end;
    application.ProcessMessages;

    if projectoptions.o.enablesource = True then
      actionsmo.projectsourceexe(nil)
    else
    if sourcefo.files_tab.Count = 0 then
      actionsmo.projectsourceexe(nil);

  end;
  sourcefo.updatehinttab;
end;

procedure tmainfo.saveproject(aname: filenamety;
  const ascopy: boolean = False);
begin
  if aname <> '' then
  begin
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
end;

procedure tmainfo.newproject(const fromprogram, empty: boolean);
var
  aname: filenamety;
  mstr1, mstr2: msestring;
  int1: integer;
  curdir, Source, dest: filenamety;
  macrolist: tmacrolist;
  copiedfiles: filenamearty;
  bo1: boolean;

begin
  mstr2 := projecttemplatedir; //use macros of current project
  if openproject('') then
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
        if filedialog(aname, [fdo_checkexist], c[Ord(selecttemplate)],
          [c[Ord(projectfiles)], c[Ord(str_allfiles)]],
          ['*.prj', '*'], 'prj') = mr_ok then
        begin
          readprojectoptions(aname);
        end;
      end;
      aname := '';
    end
    else
    begin
      aname := '';
      if filedialog(aname, [fdo_checkexist], c[Ord(selectprogramfile)],
        [c[Ord(pascalprogfiles)], c[Ord(cfiles)], c[Ord(str_allfiles)]],
        ['"*.pas" "*.pp" "*.mla" "*.dpr" "*.lpr"', '"*.c" "*.cc" "*.cpp"', '*'],
        'pas') = mr_ok then
      begin
        setcurrentdirmse(filedir(aname));
        with projectoptions do
        begin
          with o.t do
          begin
            // orimainfile :=  mainfile ;
            mainfile := filename(aname);
            aname := removefileext(mainfile);
            targetfile := aname;
          end;
          expandprojectmacros;
        end;
        aname := aname + '.prj';
      end;
    end;
    if filedialog(aname, [fdo_save, fdo_checkexist], c[Ord(str_newproject)],
      [c[Ord(projectfiles)], c[Ord(str_allfiles)]],
      ['*.prj', '*'], 'prj') = mr_ok then
    begin
      curdir := filedir(aname);
      setcurrentdirmse(curdir);
      if not fromprogram then
      begin
        mstr1 := removefileext(filename(aname));
        with projectoptions, o do
        begin
          projectfilename := aname;
          projectdir := curdir;
          expandprojectmacros;
          with texp do
          begin
            setlength(copiedfiles, length(newprojectfiles));
            macrolist := tmacrolist.Create([mao_curlybraceonly]);
            try
              macrolist.add(['%PROJECTNAME%', '%PROJECTDIR%'], [mstr1, curdir], []);
              if runscript(scriptbeforecopy, True, False) then
              begin
                for int1 := 0 to high(newprojectfiles) do
                begin
                  Source := filepath(newprojectfiles[int1]);
                  if int1 <= high(newprojectfilesdest) then
                  begin
                    dest := newprojectfilesdest[int1];
                  end
                  else
                  begin
                    dest := '';
                  end;
                  if dest <> '' then
                  begin
                    macrolist.expandmacros1(dest);
                    if Source = '' then
                    begin
                      createdirpath(dest);
                    end
                    else
                    begin
                      createdirpath(filedir(dest));
                    end;
                  end
                  else
                  begin
                    dest := filename(Source);
                  end;
                  copiedfiles[int1] := dest;
                  if newprojectfiles[int1] <> '' then
                  begin
                    if (int1 <= high(expandprojectfilemacros)) and
                      expandprojectfilemacros[int1] then
                    begin
                      copynewfile(Source, dest, False, False, ['%PROJECTNAME%', '%PROJECTDIR%'],
                        [mstr1, curdir]);
                    end
                    else
                    begin
                      try
                        if not copyfile(Source, dest, False) then
                        begin
                          showerror(c[Ord(str_file)] + dest + c[Ord(exists)]);
                        end;
                      except
                        application.handleexception(nil);
                      end;
                    end;
                  end;
                end;
                runscript(scriptaftercopy, False, False);
              end;
            finally
              macrolist.Free;
            end;
          end;
          saveproject(aname);
          bo1 := True;
          for int1 := 0 to high(copiedfiles) do
          begin
            if int1 > high(loadprojectfile) then
            begin
              break;
            end;
            if loadprojectfile[int1] then
            begin
              if checkfileext(copiedfiles[int1], [formfileext]) then
              begin
                openformfile(copiedfiles[int1], True, False, False, True, False);
              end
              else
              begin
                sourcefo.openfile(copiedfiles[int1], bo1);
                bo1 := False;
              end;
            end;
          end;
        end;
      end
      else
      begin
        saveproject(aname);
        sourcefo.openfile(projectoptions.o.texp.mainfile, True);
      end;
    end
    else
    begin
      projectoptions.projectfilename := '';
      projectoptions.modified := True;
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
  begin
    openproject(str1, True);
  end;
end;

procedure tmainfo.saveprojectasonexecute(const Sender: TObject);
var
  str1: filenamety;
begin
  if projectfiledialog(str1, True) = mr_ok then
  begin
    saveproject(str1);
  end;
end;

procedure tmainfo.saveprojectcopyexecute(const Sender: TObject);
var
  str1: filenamety;
begin
  if projectfiledialog(str1, True) = mr_ok then
  begin
    saveproject(str1, True);
  end;
end;

procedure tmainfo.mainstatfileonupdatestat(const Sender: TObject;
  const filer: tstatfiler);
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
  begin
    if guitemplatesmo.sysenv.defined[Ord(env_filename)] then
    begin
      ar1 := guitemplatesmo.sysenv.values[Ord(env_filename)];
      if (high(ar1) = 0) and (fileext(ar1[0]) = 'prj') then
      begin
        mstr1 := filepath(ar1[0]);
      end
      else
      begin
        if high(ar1) >= 0 then
        begin
          for int1 := 0 to high(ar1) do
          begin
            sourcefo.openfile(ar1[int1], int1 = 0);
          end;
        end;
        exit;
      end;
    end;
  end;
  if not filer.iswriter and (mstr1 <> '') and not
    guitemplatesmo.sysenv.defined[Ord(env_np)] then
  begin
    openproject(mstr1);
  end;
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
    make.domake(atag);
  end;
end;

procedure tmainfo.customdomake(aname: filenamety; acompiler: integer;
  acompilertag: integer; atag: integer);
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
      mstr1 := runcommand;
      if progparameters <> '' then
      begin
        mstr1 := mstr1 + ' ' + progparameters;
      end;
      if progworkingdirectory <> '' then
      begin
        pwdbefore := setcurrentdirmse(progworkingdirectory);
      end;
      try
        if projectoptions.d.externalconsole then
        begin
          frunningprocess := execmse4(mstr1, [exo_newconsole]);
        end
        else
        begin
          startconsole();
          frunningprocess := targetconsolefo.terminal.execprog(mstr1);
        end;
        if frunningprocess = invalidprochandle then
        begin
          setstattext(c[Ord(cannotstartprocess)], mtk_error);
          exit;
        end;
        runprocmon.listentoprocess(frunningprocess);
      finally
        if progworkingdirectory <> '' then
        begin
          setcurrentdirmse(pwdbefore);
        end;
      end;
    end;
    setstattext('*** ' + c[Ord(process)] + ' ' + inttostrmse(frunningprocess) + ' ' +
      c[Ord(running3)] + ' ***', mtk_making);
    debuggerfo.project_reset.Enabled := True;
    debuggerfo.project_interrupt.Enabled := True;
  end;
end;

procedure tmainfo.runprocdied(const Sender: TObject;
  const prochandle: prochandlety;
  const execresult: integer; const Data: Pointer);
begin

  if prochandle = frunningprocess then
  begin
    frunningprocess := invalidprochandle;
    if execresult <> 0 then
    begin
      setstattext(c[Ord(processterminated)] + ' ' + IntToStr(execresult) + '.',
        mtk_error);
    end
    else
    begin
      setstattext(c[Ord(proctermnormally)], mtk_finished);
    end;
  end;

  debuggerfo.project_reset.Enabled := False;
  debuggerfo.project_interrupt.Enabled := False;
end;

function tmainfo.runtarget: boolean;
  //true if run possible
begin
  Result := True;
  if not gdb.attached then
  begin
    if projectoptions.d.texp.runcommand = '' then
    begin
      if not gdb.started then
      begin
        if loadexec(False, False) then
        begin
          Result := False;
          dorun;
        end;
      end;
    end
    else
    begin
      Result := False;
      dorun;
    end;
  end;
end;

function tmainfo.checkremake(startcommand: startcommandty): boolean;
  //true if running possible
begin
  if not objectinspectorfo.canclose(nil) then
  begin
    Result := False;
    exit;
  end;
  Result := True;
  fstartcommand := startcommand;
  if not gdb.active then
  begin
    startgdb(False);
  end;
  if not gdb.attached then
  begin
    if (not gdb.started or not fnoremakecheck) and not fcurrent then
    begin
      if (projectoptions.defaultmake <= maxdefaultmake) and
        (not gdb.started or askconfirmation(c[Ord(str_sourcechanged)])) then
      begin
        Result := False;
        watchpointsfo.Clear;
        domake(projectoptions.defaultmake);
      end;
      fnoremakecheck := True;
    end;
    if Result then
    begin
      Result := runtarget;
    end;
  end
  else
  begin
    if not gdb.started then
    begin
      Result := False;
      dorun;
    end;
  end;
end;

procedure tmainfo.runexec(const Sender: TObject);
begin
  if checkremake(sc_continue) then
  begin
    dorun;
  end;
end;

procedure tmainfo.aftermake(const adesigner: idesigner;
  const exitcode: integer);
var
  str3: string;
  int3: integer;
begin
  actionsmo.finishcustom;

  if exitcode <> 0 then
  begin
    setstattext(c[Ord(makeerror)] + ' ' + IntToStr(exitcode) + '.', mtk_error);
    showfirsterror;
  end
  else
  begin

    setstattext(c[Ord(makeok)], mtk_finished);
    fcurrent := True;
    fnoremakecheck := False;
    messagefo.Messages.lastrow;
    if projectoptions.o.closemessages then
    begin
      // messagefo.hide;
      messagefo.Close;
    end;

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
    begin
      for int3 := 0 to high(debuggerused) do
      begin
        if (thetag and debuggerusedon[int3] <> 0) and (debuggerused[int3] <> '') then
        begin

          if system.pos('Default', debuggerused[int3]) > 0 then
            str3 := 'Default Debugger'
          else

          if (trim(debuggerused[int3]) = 'Debugger 1') then
            str3 := quotefilename(tosysfilepath(confdebuggerfo.debugger1.Value))
          else

          if (trim(debuggerused[int3]) = 'Debugger 2') then
            str3 := quotefilename(tosysfilepath(confdebuggerfo.debugger2.Value))
          else

          if (trim(debuggerused[int3]) = 'Debugger 3') then
            str3 := quotefilename(tosysfilepath(confdebuggerfo.debugger3.Value))
          else

          if (trim(debuggerused[int3]) = 'Debugger 4') then
            str3 := quotefilename(tosysfilepath(confdebuggerfo.debugger4.Value))
          else
            str3 := '';
        end;
      end;
    end;

    if str3 <> '' then
    else
    if fstartcommand <> sc_none then
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
  fcurrent := False;
  if Sender = nil then
  begin
    updatemodifiedforms;
  end;
end;

procedure tmainfo.exitonexecute(const Sender: TObject);
begin
  window.Close;
end;

procedure tmainfo.moduledestroyed(const adesigner: idesigner;
  const amodule: tmsecomponent);
var
  po1: pmoduleinfoty;
begin
  po1 := designer.modules.findmodulebyinstance(amodule);
  removemodulemenuitem(po1);
  if po1 = factivedesignmodule then
  begin
    factivedesignmodule := nil;
  end;
end;

procedure tmainfo.methodcreated(const adesigner: idesigner;
  const amodule: tmsecomponent; const aname: string; const atype: ptypeinfo);
begin
  //dummy
end;

procedure tmainfo.methodnamechanged(const adesigner: idesigner;
  const amodule: tmsecomponent; const newname, oldname: string;
  const atypeinfo: ptypeinfo);
begin
  //dummy
end;

procedure tmainfo.showobjecttext(const adesigner: idesigner;
  const afilename: filenamety; const backupcreated: boolean);
var
  page: tsourcepage;
begin
  page := sourcefo.openfile(afilename, True);
  if page <> nil then
  begin
    page.ismoduletext := True;
    if backupcreated then
    begin
      page.setbackupcreated;
    end;
  end;
end;

procedure tmainfo.closeobjecttext(const adesigner: idesigner;
  const afilename: filenamety; var cancel: boolean);
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
    threadsfo.Width := 250;
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
  aboutfo.Caption := 'About MSEgui';
  aboutfo.about_text.frame.colorclient := $B2F4FF;

  aboutfo.about_text.Value :=
    c_linefeed + c_linefeed + 'MSEgui version: ' + mseguiversiontext + c_linefeed +
    c_linefeed + c_linefeed + 'Host: ' + platformtext + c_linefeed +
    c_linefeed + c_linefeed +
    'by Martin Schreiber. Copyright 1999-2018' + c_linefeed +
    'https://github.com/mse-org/mseide-msegui';
  aboutfo.Show(True);

end;

procedure tmainfo.aboutfpguionexecute(const Sender: TObject);
begin
  aboutfo.Caption := 'About fpGUI';
  aboutfo.about_text.frame.colorclient := $FFF5B2;
  aboutfo.about_text.Value :=
    c_linefeed + c_linefeed + 'fpGUI version: 1.4' + c_linefeed +
    'Host: ' + platformtext + c_linefeed + c_linefeed +
    c_linefeed + 'Copyright 1999-2019' + c_linefeed + c_linefeed +
    ' by Graeme Geldenhuys' + c_linefeed + 'graemeg@gmail.com';
  aboutfo.Show(True);
end;

procedure tmainfo.aboutideuonexecute(const Sender: TObject);
begin
  aboutfo.Caption := 'About ideU';
  aboutfo.about_text.frame.colorclient := $DFFFB2;
  aboutfo.about_text.Value :=
    c_linefeed + 'ideU version: ' + versiontext + c_linefeed + 'Host: ' +
    platformtext + c_linefeed + c_linefeed +
    'Based on MSEide' + c_linefeed +
    'by Martin Schreiber' + c_linefeed + c_linefeed +
    'Copyright 1999-2019' + c_linefeed + c_linefeed +
    'Fred van Stappen' + c_linefeed + 'fiens@hotmail.com';
  aboutfo.Show(True);
end;


procedure tmainfo.configureexecute(const Sender: TObject);
begin
  configureide;
end;

procedure tmainfo.beforemake(const adesigner: idesigner;
  const maketag: integer; var abort: boolean);
begin
  //dummy
end;


procedure tmainfo.beforefilesave(const adesigner: idesigner;
  const afilename: filenamety);
begin
  //dummy
end;

procedure tmainfo.runtool(const Sender: TObject);
var
  str1: ansistring;
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
        begin
          actionsmo.saveallactonexecute(nil);
        end;
        if sourcefo.ActivePage <> nil then
        begin
          with sourcefo.ActivePage do
          begin
            cursourcefile := tosysfilepath(sourcefo.currentfilename);
            cursselection := sourcefo.currentselection;//edit.selectedtext;
            cursword := sourcefo.currentwordatcursor;
            //getpascalvarname(edit,edit.editpos,gridcoord1);
            if (index <= high(toolparse)) and toolparse[index] then
            begin
              spos1.pos := edit.editpos;
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
          cursourcefile := '';
          cursselection := '';
          cursword := '';
          cursdefinition := '';
        end;
        curcomponentclass := '';
        curproperty := '';
        if factivedesignmodule <> nil then
        begin
          curmodulefile := tosysfilepath(factivedesignmodule^.filename);
          ar1 := designer.selectedcomponents;
          if high(ar1) = 0 then
          begin
            with gettypedata(ar1[0].classinfo)^ do
            begin
              curcomponentclass := uppercase(unitname + '.' + ar1[0].ClassName);
            end;
            propit := tpropertyitem(objectinspectorfo.props.item);
            if propit <> nil then
            begin
              curproperty := curcomponentclass + '.' + uppercase(propit.rootpath);
            end;
          end;
        end
        else
        begin
          curmodulefile := '';
        end;
        mstr1 := toolparams[index];
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
          str1 := str1 + ' ' + mstr1;
        end;
      end;
      opt1 := [exo_nostdhandle];
      if not ((index > high(toolhide)) or toolhide[index]) then
      begin
        include(opt1, exo_inactive);
      end;
      if (index <= high(toolmessages)) and toolmessages[index] then
      begin
        ttoolhandlermo.Create(self, str1, opt1);
      end
      else
      begin
        execmse(str1, opt1{not((index > high(toolhide)) or toolhide[index]),true});
      end;
    end;
  end;
end;

procedure tmainfo.statbefread(const Sender: TObject);
begin
  createcpufo;
end;

procedure tmainfo.getstatobjs(const Sender: TObject;
  var aobjects: objectinfoarty);
begin
  with projectoptions do
  begin
    addobjectinfoitem(aobjects, o);
    if not (sg_editor in disabled) then
    begin
      addobjectinfoitem(aobjects, e);
    end;
    if not (sg_debugger in disabled) then
    begin
      addobjectinfoitem(aobjects, d);
    end;
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
    flayoutloading := True;
    projectstatfile.readstat('windowlayout', areader);
  finally
    flayoutloading := False;
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
  if filedialog(windowlayoutfile, [fdo_checkexist], c[Ord(str_loadwindowlayout)],
    [c[Ord(projectfiles)], c[Ord(str_allfiles)]], ['*.prj', '*'], 'prj',
    nil, nil, nil, [fa_all], [fa_hidden],
    @windowlayouthistory) = mr_ok then
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

  dialogfilesfo.tag := 1;

  dialogfilesfo.Caption := 'Load a Layout File';

  dialogfilesfo.list_files.cellwidth := 437;
  dialogfilesfo.list_files.mask := '*.prj';
  dialogfilesfo.list_files.path := expandprmacros('${LAYOUTDIR}');

  tabind := sourcefo.files_tab.activepageindex;

  dialogfilesfo.selected_file.frame.Caption := 'Selected Layout File';
  // from ' + dialogfilesfo.list_files.directory ;
  dialogfilesfo.selected_file.Text := '';
  //dialogfilesfo.activate;
  dialogfilesfo.Show(True);

end;

procedure tmainfo.closeprojectactonexecute(const Sender: TObject);
var
  str1: ttextstream;
  str2: msestring;

begin
  if mainfo.openproject('') then
  begin
    Caption := idecaption;
    fprojectloaded := False;
    str2 := expandprmacros('${LAYOUTDIR}') + 'Menu_Only.prj';
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
end;

procedure tmainfo.mainstatbeforewriteexe(const Sender: TObject);
begin
  disassfo.resetshortcuts();
end;

procedure tmainfo.statafterread(const Sender: TObject);
begin
  actionsmo.forcezorderact.Checked := projectoptions.o.forcezorder;
end;

procedure tmainfo.basedockpaintexe(const Sender: twidget;
  const acanvas: tcanvas);
begin
  paintdockingareacaption(acanvas, Sender, mainfo.c[Ord(dockingarea)]);
end;

procedure tmainfo.copywordatcur(const Sender: TObject);
begin
  sourcefo.ActivePage.copywordatcursor();
end;

procedure tmainfo.onresizemain(const Sender: TObject);
var
  screen: rectty;
begin

  screen := application.workarea();
  if Height > screen.y + screen.cy then
    Height := screen.y + screen.cy - 30;

  if Width > screen.x + screen.cx then
    Width := screen.x + screen.cx;
end;

procedure tmainfo.closeallmod(const Sender: TObject);
begin
  closeallmodule();
end;

procedure tmainfo.manfocreated(const Sender: TObject);
begin
  TDummyThread.Create(False);
end;


end.
