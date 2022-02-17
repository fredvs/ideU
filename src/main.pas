
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
templateeditor, po2arrays, msearrayutils, aboutform, plugmanager, 
msetimer, mseformatstr, mseconsts, dialogfiles, mseforms, mseguiglob, msegui, 
msegdbutils, mseactions, sak_mse, msefileutils, msedispwidgets, msedataedits, 
msestat, msestatfile, msemenus, msestockobjects,  captionideu, msebitmap, msegrids, 
msefiledialogx, msetypes, sourcepage, msedesignintf, msedesigner, Classes, mclasses, 
mseclasses, msegraphutils, typinfo, msedock, SysUtils, msesysenv, msemacros, 
msestrings, msepostscriptprinter, msegraphics, mseglob, msestream, msepointer, 
mseprocmonitorcomp, msesystypes, mserttistat, msedatalist, mselistbrowser, 
projecttreeform, msepipestream, msestringcontainer, msesys, mseedit, msewidgets, 
msegraphedits, mseificomp, mseificompglob, mseifiglob, msescrollbar;


const 
  versiontext = '2.8.2';
  idecaption  = 'ideU';
  statname    = 'ideu';

type 
  TDummyThread = class(TThread)
    protected 
      procedure Execute;
      override;
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
    bFirstLoad: tbooleanedit;
    themenum: tintegeredit;
    bCompletion: tbooleanedit;
    posx: tintegeredit;
    posy: tintegeredit;
    poscx: tintegeredit;
    poscy: tintegeredit;
    procedure newfileonexecute(Const Sender: TObject);
    procedure newformonexecute(Const Sender: TObject);

    procedure mainfooncreate(Const Sender: TObject);
    procedure mainfoondestroy(Const Sender: TObject);
    procedure mainstatfileonupdatestat(Const Sender: TObject; Const filer: tstatfiler);
    procedure mainfoonterminate(Var terminate: Boolean);
    procedure mainonloaded(Const Sender: TObject);

    procedure mainmenuonupdate(Const Sender: tcustommenu);
    procedure onscale(Const Sender: TObject);
    procedure parametersonexecute(Const Sender: TObject);
    procedure buildactonexecute(Const Sender: TObject);
    procedure saveprojectasonexecute(Const Sender: TObject);
    procedure newprojectonexecute(Const Sender: TObject);
    procedure closeprojectactonexecute(Const Sender: TObject);
    procedure exitonexecute(Const Sender: TObject);
    procedure newpanelonexecute(Const Sender: TObject);

    procedure viewassembleronexecute(Const Sender: TObject);
    procedure viewcpuonexecute(Const Sender: TObject);
    procedure viewmessagesonexecute(Const Sender: TObject);
    procedure viewsourceonexecute(Const Sender: TObject);
    procedure viewbreakpointsonexecute(Const Sender: TObject);
    procedure viewwatchesonexecute(Const Sender: TObject);
    procedure viewstackonexecute(Const Sender: TObject);
    procedure viewobjectinspectoronexecute(Const Sender: TObject);
    procedure toggleobjectinspectoronexecute(Const Sender: TObject);
    procedure viewcomponentpaletteonexecute(Const Sender: TObject);
    procedure viewcomponentstoreonexecute(Const Sender: TObject);
    procedure viewdebuggertoolbaronexecute(Const Sender: TObject);
    procedure viewwatchpointsonexecute(Const Sender: TObject);
    procedure viewthreadsonexecute(Const Sender: TObject);
    procedure viewconsoleonexecute(Const Sender: TObject);
    procedure viewfindresults(Const Sender: TObject);
    procedure aboutonexecute(Const Sender: TObject);
    procedure aboutfpguionexecute(Const Sender: TObject);
    procedure aboutideuonexecute(Const Sender: TObject);
    procedure configureexecute(Const Sender: TObject);

    function closeallmodule(): Boolean;

    procedure setlangideu(thelang: String);

    //debugger
    procedure restartgdbonexecute(Const Sender: TObject);
    procedure runexec(Const Sender: TObject);
    procedure gdbonevent(Const Sender: tgdbmi; Var eventkind: gdbeventkindty; Const values:
                         resultinfoarty; Const stopinfo: stopinfoty);
    procedure expronsetvalue(Const Sender: TObject; Var avalue: msestring; Var accept: Boolean);
    procedure symboltypeonsetvalue(Const Sender: TObject; Var avalue: msestring; Var accept: Boolean
    );
    procedure openprojectcopyexecute(Const Sender: TObject);
    procedure saveprojectcopyexecute(Const Sender: TObject);
    procedure newprojectfromprogramexe(Const Sender: TObject);
    procedure newemptyprojectexe(Const Sender: TObject);
    procedure viewmemoryonexecute(Const Sender: TObject);
    procedure runprocdied(Const Sender: TObject; Const prochandle: prochandlety; Const execresult:
                          integer; Const Data: Pointer);
    procedure statbefread(Const Sender: TObject);
    procedure viewsymbolsonexecute(Const Sender: TObject);
    procedure loadwindowlayoutexe(Const Sender: TObject);
    procedure loadwindowlayout(Const areader: tstatreader);
    procedure getstatobjs(Const Sender: TObject; Var aobjects: objectinfoarty);
    procedure targetpipeinput(Const Sender: tpipereader);
    procedure mainstatbeforewriteexe(Const Sender: TObject);
    procedure statafterread(Const Sender: TObject);
    procedure basedockpaintexe(Const Sender: twidget; Const acanvas: tcanvas);

    //fred
    procedure dothemedialog();
    procedure dotheme(typetheme: integer);
    procedure picksdef(Const Sender: TObject; Var avalue: msestring; Var accept: Boolean);
    procedure menuwindowlayoutexe(Const Sender: TObject);
    procedure viewconffpguiexecute(Const Sender: TObject);
    procedure viewconfmseguiexecute(Const Sender: TObject);
    procedure viewconfcompilersexecute(Const Sender: TObject);
    procedure viewconfdebuggersexecute(Const Sender: TObject);
    procedure viewconfideuexecute(Const Sender: TObject);
    procedure viewfpguidesigneronexecute(Const Sender: TObject);
    procedure resetfpguidesigneronexecute(Const Sender: TObject);
    procedure customcompile(Const Sender: TObject);
    procedure customrun(Const Sender: TObject);
    procedure runwithoutdebugger;
    procedure ideuwriteconfig;
    procedure ideureadconfig;
    procedure loadconfigform(Const Sender: TObject);
    procedure onthetimer(Const Sender: TObject);
    procedure syntaxdefload(Const Sender: TObject);
    procedure copywordatcur(Const Sender: TObject);
    procedure onresizemain(Const Sender: TObject);
    procedure closeallmod(Const Sender: TObject);
    procedure manfocreated(Const Sender: TObject);
    procedure onbeauty(Const Sender: TObject);
    procedure onclassic(Const Sender: TObject);
    procedure ondark(Const Sender: TObject);
    procedure ontoggleunitform(Const Sender: TObject);
    procedure onlang(Const Sender: TObject);
    procedure onactiv(Const Sender: TObject);

    procedure ontemplateeditor(Const Sender: TObject);
    procedure runtimer(Const sender: TObject);
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
      function runtarget: Boolean;
      //true if run possible
      procedure newproject(Const fromprogram, empty: Boolean);
      procedure doshowform(Const Sender: TObject);
      procedure setprojectname(aname: filenamety);
      //not const because of not refcounted widestrings
      procedure dofindmodulebyname(Const amodule: pmoduleinfoty; Const aname: String; Var action:
                                   modalresultty);
      procedure dofindmodulebytype(Const atypename: String);

      //idesignnotification
      procedure ItemDeleted(Const ADesigner: IDesigner; Const amodule: tmsecomponent; Const AItem:
                            TComponent);
      procedure ItemInserted(Const ADesigner: IDesigner; Const amodule: tmsecomponent; Const AItem:
                             TComponent);
      procedure ItemsModified(Const ADesigner: IDesigner; Const AItem: TObject);
      procedure componentnamechanging(Const adesigner: idesigner; Const amodule: tmsecomponent;
                                      Const aitem: TComponent; Const newname: String);
      procedure moduleclassnamechanging(Const adesigner: idesigner; Const amodule: tmsecomponent;
                                        Const newname: String);
      procedure instancevarnamechanging(Const adesigner: idesigner; Const amodule: tmsecomponent;
                                        Const newname: String);
      procedure SelectionChanged(Const ADesigner: IDesigner; Const ASelection: IDesignerSelections);
      procedure moduleactivated(Const adesigner: idesigner; Const amodule: tmsecomponent);
      procedure moduledeactivated(Const adesigner: idesigner; Const amodule: tmsecomponent);
      procedure moduledestroyed(Const adesigner: idesigner; Const amodule: tmsecomponent);
      procedure methodcreated(Const adesigner: idesigner; Const amodule: tmsecomponent; Const aname:
                              String; Const atype: ptypeinfo);
      procedure methodnamechanged(Const adesigner: idesigner; Const amodule: tmsecomponent; Const
                                  newname, oldname: String; Const atypeinfo: ptypeinfo);
      procedure showobjecttext(Const adesigner: idesigner; Const afilename: filenamety; Const
                               backupcreated: Boolean);
      procedure closeobjecttext(Const adesigner: idesigner; Const afilename: filenamety; Var cancel:
                                Boolean);
      procedure beforefilesave(Const adesigner: idesigner; Const afilename: filenamety);
      procedure beforemake(Const adesigner: idesigner; Const maketag: integer; Var abort: Boolean);
      procedure aftermake(Const adesigner: idesigner; Const exitcode: integer);

      function checksave: modalresultty;
      procedure unloadexec;
      procedure cleardebugdisp;
      procedure resetdebugdisp;
      //called before running debuggee
      procedure createprogramfile(Const aname: filenamety);
      function copynewfile(Const aname, newname: filenamety; Const autoincrement: Boolean; Const
                           canoverwrite: Boolean; Const macronames: Array Of msestring; Const
                           macrovalues: Array Of msestring): Boolean;
      //true if ok
      procedure createform(Const aname: filenamety; Const namebase: String; Const ancestor: String);
      procedure removemodulemenuitem(Const amodule: pmoduleinfoty);
      procedure uploadexe(Const Sender: tguiapplication; Var again: Boolean);
      procedure uploadcancel(Const Sender: TObject);
      procedure gdbserverexe(Const Sender: tguiapplication; Var again: Boolean);
      //  function terminategdbserver(const force: Boolean): Boolean;
      procedure gdbservercancel(Const Sender: TObject);
      procedure updatetargetenvironment;
      function needsdownload: Boolean;
      function candebug: Boolean;
      //run command empty or process attached
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

      constructor Create(aowner: TComponent);
      override;

      destructor Destroy;
      override;

      function terminategdbserver(Const force: Boolean): Boolean;

      procedure designformactivated(Const Sender: tcustommseform);
      procedure startgdb(Const killserver: Boolean);
      function checkgdberror(aresult: gdbresultty): Boolean;
      function startgdbconnection(Const attach: Boolean): Boolean;
      function loadexec(isattach: Boolean; Const forcedownload: Boolean): Boolean;
      //true if ok
      procedure setstattext(Const atext: msestring; Const akind: messagetextkindty = mtk_info);
      procedure refreshstopinfo(Const astopinfo: stopinfoty);
      procedure updatemodifiedforms;
      function checkremake(startcommand: startcommandty): Boolean;
      //true if running possible
      procedure resetstartcommand;
      procedure killtarget;
      procedure domake(atag: integer);

      /// fred
      procedure customdomake(aname: filenamety; acompiler: integer; acompilertag: integer; atag:
                             integer);

      procedure targetfilemodified;
      function checksavecancel(Const aresult: modalresultty): modalresultty;
      function closeall(Const nosave: Boolean): Boolean;
      //false in cancel
      function closemodule(Const amodule: pmoduleinfoty; Const achecksave: Boolean; nocheckclose:
                           Boolean = False): Boolean;
      function openproject(Const aname: filenamety; Const ascopy: Boolean = False): Boolean;
      procedure saveproject(aname: filenamety; Const ascopy: Boolean = False);
      procedure savewindowlayout(Const astream: ttextstream);
      procedure loadwindowlayout(Const astream: ttextstream);

      procedure sourcechanged(Const Sender: tsourcepage);
      function opensource(Const filekind: filekindty; Const addtoproject: Boolean; Const aactivate:
                          Boolean = True; Const currentnode: tprojectnode = Nil): Boolean;
      //true if filedialog not canceled
      function openformfile(Const filename: filenamety; Const ashow, aactivate, showsource,
                            createmenu, skipexisting: Boolean): pmoduleinfoty;
      procedure createmodulemenuitem(Const amodule: pmoduleinfoty);
      function formmenuitemstart: integer;
      procedure loadformbysource(Const sourcefilename: filenamety);
      procedure loadsourcebyform(Const formfilename: filenamety; Const aactivate: Boolean = False);
      procedure checkbluedots;
      procedure updatesigsettings;
      procedure runtool(Const Sender: TObject);

      procedure downloaded;
      procedure programfinished;
      procedure showfirsterror;
      procedure stackframechanged(Const frameno: integer);
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
  theprojectname: string = '';
  thefilename: string = '';


procedure doassistive;

procedure sdefload(sdeffile: msestring);

procedure handleerror(Const e: Exception; Const Text: String);

implementation

uses 
conflang, 
//splash, 
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
regifi, {$ifdef mse_with_ifirem}regifirem, {$endif}
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

procedure handleerror(Const e: Exception; Const Text: String);
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

procedure tmainfo.mainfooncreate(Const Sender: TObject);
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
end;

procedure sdefload(sdeffile: msestring);
begin

  if han <> -1 then
    sourcefo.syntaxpainter.freedeffile(han);
  han := sourcefo.syntaxpainter.readdeffile(sdeffile);
  sourcefo.ActivePage.edit.setsyntaxdef(han);
  sourcefo.ActivePage.updatestatvalues;
end;

procedure tmainfo.syntaxdefload(Const Sender: TObject);
begin

  if Assigned(sourcefo.ActivePage) then
    begin

      if not dialogfilesformcreated then
        dodialogfiles;

      dothemedialog();


      dialogfilesfo.tag := 0;

      thesdef := projectoptions.e.t.syntaxdeffiles[0];

      dialogfilesfo.Caption := lang_projectoptions[Ord(po_syntaxdeffile)];

      // 'Load a Syntax Definition File';

      dialogfilesfo.tbutton1.Caption := lang_modalresult[Ord(mr_ok)];
      dialogfilesfo.tbutton2.Caption := lang_modalresult[Ord(mr_cancel)];


      dialogfilesfo.list_files.path    := expandprmacros('${SYNTAXDEFDIR}');
      dialogfilesfo.list_files.mask    := '*.sdef';
      dialogfilesfo.selected_file.frame.Caption := lang_projectoptions[Ord(po_syntaxdeffile)];
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

procedure tmainfo.onthetimer(Const Sender: TObject);
begin
  thetimer.Enabled := False;
  componentpalettefo.Close;
  objectinspectorfo.Close;
  if bFirstLoad.value = true then
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
          bFirstLoad.value := false;
          activate;
        end;
    end
  else
    activate;

  debuggerfo.file_history.tag := 0;
  themenr := themenum.value;
  if themenr <> 0 then
    dotheme(themenr);
  // setstattext('Hello!', mtk_flat);
  if confideufo.fontsize.value <> 12 then
    confideufo.onchangefont;
  objectinspectorfo.Close;
  application.processmessages;
  ideureadconfig();
  //confideufo.close;
  onactiv(Sender);
end;

procedure tmainfo.loadconfigform(Const Sender: TObject);
begin
  thetimer          := ttimer.Create(TComponent(Sender));
  thetimer.interval := 1000000;
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

  {$IFDEF unix}
  libpath := utf8decode(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) +
             'plugin/designer_ext/designer_ext');
  {$endif}

  if bCompletion.value = false then
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

  blinkingcaret := confideufo.blinkcaret.Value;

  noconfirmdelete := confideufo.confirmdel.Value;

  if confideufo.nozorderenable.Value = True then
    nozorderhandling := True
  else
    nozorderhandling := False;

  confideufo.dirlayout(Nil);
  
  ismodal := confideufo.modaldial.Value;

  nostaticgravity := true;
 
  libpath := utf8decode(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))));

  if not fileexists(confideufo.deflayout.Text) then
    confideufo.deflayout.Text := (libpath) + directoryseparator +
                                 'layout' + directoryseparator +
                                 'Dock_Commandor_Tree_Editor_Message.prj';

  confideufo.deflayout.Value        := confideufo.deflayout.Text;
  confideufo.deflayout.valuedefault := confideufo.deflayout.Text;

  if not fileexists(confideufo.defsynt.Text) then
    confideufo.defsynt.Text := (libpath) + directoryseparator +
                               'syntaxdefs' + directoryseparator + 'pascal_ideu.sdef';

  confideufo.defsynt.Value        := confideufo.defsynt.Text;
  confideufo.defsynt.valuedefault := confideufo.defsynt.Text;

  if trim(ParamStr(1)) = '-va' then
    begin
      vaparam := True;
      confideufo.tbassistive.Value := True;
      debuggerfo.assistive.face.image.alignment := 
                                                   [al_stretchx, al_stretchy];
    end;

  if confideufo.tbassistive.Value = True then
    doassistive;

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
  if debuggerfo.properties_list.tag = 0 then
    bCompletion.value := false
  else
    bCompletion.value := true;
end;

procedure tmainfo.mainfoondestroy(Const Sender: TObject);
begin
  if SakIsEnabled = True then
    sakunloadlib;
  designnotifications.unRegisternotification(idesignnotification(self));
  abortmake;
  abortdownload;
  sourceupdate.deinit(designer);
  ideuwriteconfig();
end;

procedure tmainfo.dofindmodulebyname(Const amodule: pmoduleinfoty; Const aname: String; Var action:
                                     modalresultty);
var 
  wstr2: msestring;

function dofind(Const modulenames: Array Of msestring; Const modulefilenames: Array Of filenamety):

                                                                                             Boolean
;
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
              Result := (po1 <> Nil) And (utf8decode(struppercase(po1^.instancevarname)) = (wstr2));
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
      if length(lang_mainform) > 0 then
        action := ShowMessage(lang_mainform[Ord(ma_unresreferences)] + ' ' + utf8decode(amodule^.
                  moduleclassname) + ' ' +
                  lang_mainform[Ord(ma_str_to)] + ' ' + utf8decode(aname) +
                  '.' + lineend + ' ' + lang_mainform[Ord(ma_wishsearch)],
                  lang_stockcaption[Ord(sc_warningupper)],
                  [mr_ok, mr_cancel], mr_ok)
      else

        action := ShowMessage(lang_mainform[ord(ma_unresreferences)] + ' '
                  + utf8decode(amodule^.moduleclassname) + ' ' +
                  lang_mainform[ord(ma_str_to)] + ' ' + utf8decode(aname) +
                  '.' + lineend + ' ' + lang_mainform[ord(ma_wishsearch)], lang_stockcaption[Ord(
                  sc_warningupper)],
                  [mr_ok, mr_cancel], mr_ok);

      case action of 
        mr_ok:
               begin
                 wstr2 := '';
                 //    openform.controller.filename:= '';
                 //    openform.controller.captionopen:= c[ord(formfile)]+' '+ aname;
                 openform.controller.showoptions := True;
                 if openform.controller.Execute(wstr2, fdk_open,
                    lang_mainform[Ord(ma_formfile)] + ' ' + utf8decode(aname)) then
                   openformfile(wstr2, False, False, True, True, False)
                   //    action:= filedialog(wstr2,[fdo_checkexist],c[ord(formfile)]+' '+ aname,


              //                 [c[ord(formfiles)]],['*.mfm'],'',nil,nil,nil,[fa_all],[fa_hidden]);
                   //                 //defaultvalues don't work on kylix
                   //    if action = mr_ok then begin
                   //     openformfile(openform.controller.filename,false,false,true,true,false);
                 ;
               end;
      end;
    end;
end;

procedure tmainfo.dofindmodulebytype(Const atypename: String);
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
                  po1 := Nil;


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
      ShowMessage(lang_mainform[Ord(ma_recursive)] + ' ' + utf8decode(atypename) + '"', 
      uppercase(lang_stockcaption[ord(sc_Error)]));
      SysUtils.abort;
    end;
  Inc(fcheckmodulelevel);
  try
    with projectoptions do
      begin
        po1   := Nil;
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
        checkmodule(mstr1)

{
   ar1:= projecttree.units.moduleclassnames;
   for int1:= 0 to high(ar1) do begin
    if ar1[int1] = wstr2 then begin
     checkmodule(projecttree.units.modulefilenames[int1]);
     break;
    end;
   end;
   }
    ;
    if (po1 = nil) or (stringicomp(po1^.moduleclassname, atypename) <> 0) then
      if ShowMessage(lang_mainform[Ord(ma_str_classtype)] + ' ' +
         utf8decode(atypename) + ' ' +
         lang_actionsmodule[ord(ac_notfound)] + lineend +
         ' ' + lang_mainform[Ord(ma_wishsearch)], lang_stockcaption[Ord(sc_warningupper)],
         [mr_yes, mr_cancel]) = mr_yes then
        begin
          wstr2 := '';
          openform.controller.showoptions := True;

          if openform.controller.Execute(wstr2, fdk_open, lang_mainform[Ord(ma_formfile)] + ' ' +
             msestring(atypename), [fdo_checkexist]) then
            openformfile(wstr2, False, False, False, False, False);
        end;
  finally
    Dec(fcheckmodulelevel);
end;
end;

//editor
//formdesigner


procedure Tmainfo.doshowform(Const Sender: TObject);
begin
  with tmenuitem(Sender) do
    designer.showformdesigner(pmoduleinfoty(tagpo));
end;

procedure tmainfo.toggleobjectinspectoronexecute(Const Sender: TObject);
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

procedure tmainfo.viewobjectinspectoronexecute(Const Sender: TObject);
begin

  objectinspectorfo.activate(True);
  //  objectinspectorfo.font.height := confideufo.fontsize.value;
  //  objectinspectorfo.grid.datarowheight := round(ratio * 16);
end;

//idesignnotification

procedure Tmainfo.ItemDeleted(Const ADesigner: IDesigner; Const amodule: tmsecomponent; Const AItem:
                              TComponent);
begin

end;

procedure Tmainfo.ItemInserted(Const ADesigner: IDesigner; Const amodule: tmsecomponent; Const AItem
                               : TComponent);
begin
  componentpalettefo.resetselected;
end;

procedure tmainfo.moduleactivated(Const adesigner: idesigner; Const amodule: tmsecomponent);
begin
  factivedesignmodule := designer.actmodulepo;
  setlinkedvar(factivedesignmodule^.designform, tmsecomponent(flastdesignform));
end;

procedure tmainfo.moduledeactivated(Const adesigner: idesigner; Const amodule: tmsecomponent);
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
                  Result := ShowMessage(lang_xstockcaption[ord(sc_project)] + ' ' + fprojectname +
                            ' '
                            + lang_stockcaption[ord(sc_is_modified_save)],lang_stockcaption[ord(
                            sc_Confirmation)],
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

procedure Tmainfo.ItemsModified(Const ADesigner: IDesigner; Const AItem: TObject);
begin
  updatemodifiedforms;
  sourcechanged(Nil);
end;

procedure tmainfo.componentnamechanging(Const adesigner: idesigner; Const amodule: tmsecomponent;
                                        Const aitem: TComponent; Const newname: String);
begin
  //dummy
end;

procedure tmainfo.moduleclassnamechanging(Const adesigner: idesigner; Const amodule: tmsecomponent;
                                          Const newname: String);
begin
  //dummy
end;

procedure tmainfo.instancevarnamechanging(Const adesigner: idesigner; Const amodule: tmsecomponent;
                                          Const newname: String);
begin
end;

procedure Tmainfo.SelectionChanged(Const ADesigner: IDesigner; Const ASelection: IDesignerSelections
);
begin
  if (aselection.Count > 0) and (factivedesignmodule <> nil) then
    if not objectinspectorfo.active then
      objectinspectorfo.window.stackunder(factivedesignmodule^.designform.window)
      //  objectinspectorfo.bringtofront;
      // objectinspectorfo.show;
      // objectinspectorfo.activate;
  ;
end;

// fred
procedure tmainfo.picksdef(Const Sender: TObject; Var avalue: msestring; Var accept: Boolean);
begin
  sdefload(avalue);
end;

//debugger

procedure tmainfo.expronsetvalue(Const Sender: TObject; Var avalue: msestring; Var accept: Boolean);
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

procedure tmainfo.stackframechanged(Const frameno: integer);
begin
  if gdb.cancommand then
    begin
      gdb.selectstackframe(frameno);
      refreshframe;
    end;
end;

procedure tmainfo.customcompile(Const Sender: TObject);
var 
  page1: tsourcepage;
begin
  page1 := sourcefo.ActivePage;
  if (page1 <> nil) then
    begin
      setstattext( lang_actionsmodule[Ord(ac_making)] +
      ' ' + page1.filepath, mtk_info);
      customdomake(page1.filepath, settypecompiler, setcompiler, customoption);
    end;
end;

procedure tmainfo.customrun(Const Sender: TObject);
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
    setstattext(

'No debugger set, please check Project-Option|Debugger|Project-debugger.  Running without debugging...'
                , mtk_error)
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
            begin
              /// it is pascal
              str1 := replacefileext(page1.filepath, formfileext);
              po1  := designer.modules.findmodule(str1);
              if po1 <> nil then
                begin
                  // mfm finded
                  createmodulemenuitem(po1);
                  po1^.designform.activate(True);

                  setstattext(lang_xstockcaption[Ord(sc_toggleformunit)], mtk_flat);

                  page1 := Nil;
                end
              else
                begin

                  if fileexists(str1) then
                    begin
                      page1 := sourcefo.findsourcepage(str1);
                      if page1 = nil then
                        begin
                          //mfm not loaded in editor
                          po1 := designer.loadformfile(str1, False);
                          if po1 <> nil then
                            begin
                              setstattext(lang_xstockcaption[Ord(sc_toggleformunit)], mtk_flat);
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
                            setstattext(lang_xstockcaption[Ord(sc_toggleformunit)], mtk_flat);
                            toogletag := True;

                            sysfilename := ansistring(tosysfilepath(filepath(str3, fk_file, True)));

                            LoadfpgDesigner(sysfilename);
                            //  fpgfilename := page1.filepath;
                            // end else
                            //  LoadfpgDesigner('showit');
                          end
                      else
                        begin
                          setstattext(lang_xstockcaption[Ord(sc_toggleformunit)], mtk_flat);
                          toogletag := False;
                          if (conffpguifo.tbfpgonlyone.Value = True) and (conffpguifo.ifhide.Value =
                             True) then
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
                   setstattext(lang_xstockcaption[Ord(sc_toggleformunit)], mtk_flat);

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
            raise Exception.Create(ansistring(lang_mainform[Ord(ma_unableopen)] + ' "' + str1 + '".'
            ));
        end
      else if designer.modules.Count > 0 then
             designer.modules[0]^.designform.activate(True);
    end;
end;

procedure tmainfo.setstattext(Const atext: msestring; Const akind: messagetextkindty = mtk_info);
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

procedure tmainfo.refreshstopinfo(Const astopinfo: stopinfoty);
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
        application.activate()

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
      ;
      if projectoptions.d.raiseonbreak then
        application.packwindowzorder();
    end;
end;

procedure tmainfo.gdbonevent(Const Sender: tgdbmi; Var eventkind: gdbeventkindty; Const values:
                             resultinfoarty; Const stopinfo: stopinfoty);
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
                   setstattext(lang_mainform[Ord(ma_running)], mtk_warning);
                   debuggerfo.project_reset.Enabled     := True;
                   debuggerfo.project_interrupt.Enabled := True;
                 end;
    gek_error, gek_writeerror, gek_gdbdied:
                                            setstattext('GDB: ' + utf8decode(stopinfo.messagetext), 
                                            mtk_error);
    gek_targetoutput:
                      targetconsolefo.addtext(values[0].Value);
    gek_download:
                  with stopinfo do
                    if sectionsize > 0 then
                      setstattext(lang_mainform[Ord(ma_str_downloading)] + ' ' + utf8decode(section)
                      + ' ' +
                      utf8decode(IntToStr(round(sectionsent / sectionsize * 100))) + '%', mtk_making
                      );
    gek_done:
              if Sender.downloaded then
                begin
                  downloaded;
                  setstattext(lang_mainform[Ord(ma_str_downloaded)] + ' ' + utf8decode(formatfloat(
                                                                                       '0.00,',
                                                                                       stopinfo.
                                                                                       totalsent /
                                                                                       1024)) + 'kB'
                  , mtk_finished);
                  //    sender.abort;
                end;
    gek_loaded:
                symbolfo.updatesymbols;
  end;
end;

procedure tmainfo.gdbserverexe(Const Sender: tguiapplication; Var again: Boolean);
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


function tmainfo.terminategdbserver(Const force: Boolean): Boolean;
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

procedure tmainfo.gdbservercancel(Const Sender: TObject);
begin
  terminategdbserver(True);
end;

procedure tmainfo.targetpipeinput(Const Sender: tpipereader);
begin
  messagefo.Messages[0].readpipe(Sender);
end;

function tmainfo.startgdbconnection(Const attach: Boolean): Boolean;
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
            fgdbserverprocid := execmse2(syscommandline(mstr1), Nil,
                                targetpipe.pipereader, targetpipe.pipereader, -1, [exo_tty])
          else
            fgdbserverprocid := execmse2(syscommandline(mstr1), Nil,
                                Nil, Nil, -1, []);
          if fgdbserverprocid <> invalidprochandle then
            begin
              fgdbservertimeout := timestep(round(1000000 * d.gdbserverwait));
              if application.waitdialog(nil, lang_mainform[Ord(ma_startgdbservercommand)] + ' ' +
                 mstr1 + ' ' + lang_actionsmodule[Ord(ac_running)], lang_mainform[Ord(
                 ma_startgdbserver)],
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
                      setstattext(lang_mainform[Ord(ma_gdbserverstarterror)] + ' ' +
                      utf8decode(IntToStr(fgdbserverexitcode)) + '.', 
                      mtk_error);
                      Exit;
                    end;
                end
              else
                begin
                  setstattext(lang_mainform[Ord(ma_gdbservercanceled)], mtk_error);
                  Exit;
                end;
            end
          else
            begin
              setstattext(lang_mainform[Ord(ma_cannotrunstartgdb)], mtk_error);
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

procedure tmainfo.uploadexe(Const Sender: tguiapplication; Var again: Boolean);
begin
  if not downloading then
    Sender.terminatewait
  else
    begin
      Sender.idlesleep(100000);
      again := True;
    end;
end;

procedure tmainfo.uploadcancel(Const Sender: TObject);
begin
  abortdownload;
  // killprocess(fuploadprocid);
end;

function tmainfo.needsdownload: Boolean;
begin
  Result := ftargetfilemodified Or projectoptions.d.downloadalways;
end;

function tmainfo.candebug: Boolean;
//run command empty or process attached
begin
  Result := (projectoptions.d.texp.runcommand = '') Or gdb.started;
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

function tmainfo.loadexec(isattach: Boolean; Const forcedownload: Boolean): Boolean;
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
                   if application.waitdialog(nil, lang_mainform[Ord(ma_str_uploadcommand)] + ' ' +
                      uploadcommand + ' ' +
                      lang_actionsmodule[Ord(ac_running)], lang_mainform[Ord(ma_str_downloading)],
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
                           setstattext(lang_mainform[Ord(ma_downloaderror)] + ' ' +
                           utf8decode(IntToStr(downloadresult)) + '.', mtk_error);
                           Exit;
                         end
                       else
                         begin
                           setstattext(lang_mainform[Ord(ma_downloadfinished)], mtk_finished);
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
                       setstattext(lang_mainform[Ord(ma_downloadcanceled)], mtk_error);
                       Exit;
                     end;
                 end;
             end;
           mainfo.setstattext(lang_actionsmodule[Ord(ac_loading)] + '.', mtk_error);

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
  Result := gdb.execloaded Or gdb.attached;
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

procedure tmainfo.startgdb(Const killserver: Boolean);
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
          gdb.guiintf          := Not d.nodebugbeginend;
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


procedure tmainfo.restartgdbonexecute(Const Sender: TObject);
begin
  startgdb(True);
end;

procedure tmainfo.symboltypeonsetvalue(Const Sender: TObject; Var avalue: msestring; Var accept:
                                       Boolean);
var 
  expres: string;
begin
  gdb.symboltype(ansistring(avalue), expres);
  symboltypedisp.Value := utf8decode(expres);
end;

procedure tmainfo.viewbreakpointsonexecute(Const Sender: TObject);
begin
  breakpointsfo.activate;
  if breakpointsfo.Width < 50 then
    begin
      breakpointsfo.Height := 180;
      breakpointsfo.Width  := 250;
    end;
end;

procedure tmainfo.viewwatchesonexecute(Const Sender: TObject);
begin
  watchfo.activate;
  if watchfo.Width < 50 then
    begin
      watchfo.Height := 180;
      watchfo.Width  := 250;
    end;
end;

procedure tmainfo.viewstackonexecute(Const Sender: TObject);
begin
  stackfo.activate;
  if stackfo.Width < 50 then
    begin
      stackfo.Height := 180;
      stackfo.Width  := 250;
    end;
end;

procedure tmainfo.onscale(Const Sender: TObject);
begin
  // fred
  basedock.bounds_y  := 0;
  // basedock.bounds_y:= statdisp.bottom + 1;
  basedock.bounds_cy := container.paintrect.cy;
end;

procedure tmainfo.parametersonexecute(Const Sender: TObject);
begin
  editprogramparameters;
end;

procedure tmainfo.viewassembleronexecute(Const Sender: TObject);
begin
  disassfo.activate;
  if breakpointsfo.Width < 50 then
    begin
      breakpointsfo.Height := 180;
      breakpointsfo.Width  := 250;
    end;
end;

procedure tmainfo.viewmemoryonexecute(Const Sender: TObject);
begin
  memoryfo.activate;
  if memoryfo.Width < 50 then
    begin
      memoryfo.Height := 180;
      memoryfo.Width  := 250;
    end;
end;

procedure tmainfo.viewcpuonexecute(Const Sender: TObject);
begin
  cpufo.activate;
  if cpufo.Width < 50 then
    begin
      cpufo.Height := 180;
      cpufo.Width  := 250;
    end;
end;

procedure tmainfo.viewmessagesonexecute(Const Sender: TObject);
begin
  messagefo.activate;
  if messagefo.Width < 50 then
    begin
      messagefo.Height := 180;
      messagefo.Width  := 250;
    end;
end;

procedure tmainfo.viewsourceonexecute(Const Sender: TObject);
begin
  sourcefo.activate;
  if sourcefo.Width < 50 then
    begin
      sourcefo.Height := 180;
      sourcefo.Width  := 250;
    end;
end;

procedure tmainfo.mainmenuonupdate(Const Sender: tcustommenu);
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
      detachtarget.Enabled  := gdb.execloaded Or gdb.attached;
      download.Enabled      := Not gdb.started And Not gdb.downloading And
                               ((uploadcommand <> '') Or d.gdbdownload);
      attachprocess.Enabled := Not (gdb.execloaded Or gdb.attached);
      attachtarget.Enabled  := attachprocess.Enabled;
      run.Enabled           := Not gdb.running And Not gdb.downloading And Not iscompiling;
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
      step.Enabled := Not gdb.running And Not gdb.downloading And bo1 And bo2 And Not iscompiling;
      debuggerfo.project_step.Enabled := step.Enabled;

      if debuggerfo.project_step.Enabled then
        debuggerfo.project_step.face.image.alignment := 
                                                        [al_stretchx, al_stretchy]
      else
        debuggerfo.project_step.face.image.alignment := 
                                                        [al_grayed, al_stretchx, al_stretchy];


      stepi.Enabled := Not gdb.running And Not gdb.downloading And bo1 And bo2 And Not iscompiling;
      debuggerfo.project_step_instruction.Enabled := stepi.Enabled;

      if debuggerfo.project_step_instruction.Enabled then
        debuggerfo.project_step_instruction.face.image.alignment := 
                                                                    [al_stretchx, al_stretchy]
      else
        debuggerfo.project_step_instruction.face.image.alignment := 
                                                                    [al_grayed, al_stretchx,
                                                                    al_stretchy];

      Next.Enabled := Not gdb.running And Not gdb.downloading And bo1 And bo2 And Not iscompiling;
      debuggerfo.project_next.Enabled := Next.Enabled;

      if debuggerfo.project_next.Enabled then
        debuggerfo.project_next.face.image.alignment := 
                                                        [al_stretchx, al_stretchy]
      else
        debuggerfo.project_next.face.image.alignment := 
                                                        [al_grayed, al_stretchx, al_stretchy];

      nexti.Enabled := Not gdb.running And Not gdb.downloading And bo1 And bo2 And Not iscompiling;
      debuggerfo.project_next_instruction.Enabled := nexti.Enabled;

      if debuggerfo.project_next_instruction.Enabled then
        debuggerfo.project_next_instruction.face.image.alignment := 
                                                                    [al_stretchx, al_stretchy]
      else
        debuggerfo.project_next_instruction.face.image.alignment := 
                                                                    [al_grayed, al_stretchx,
                                                                    al_stretchy];

      finish.Enabled := Not gdb.running And gdb.started And bo1;
      debuggerfo.project_finish.Enabled := finish.Enabled;

      if debuggerfo.project_finish.Enabled then
        debuggerfo.project_finish.face.image.alignment := 
                                                          [al_stretchx, al_stretchy]
      else
        debuggerfo.project_finish.face.image.alignment := 
                                                          [al_grayed, al_stretchx, al_stretchy];

      continue.Enabled  := Not gdb.running And Not gdb.downloading And
                           (bo1 Or (frunningprocess = invalidprochandle)) And Not iscompiling;
      interrupt.Enabled := gdb.running And Not gdb.downloading And bo1;
      debuggerfo.project_interrupt.Enabled := interrupt.Enabled;

      if debuggerfo.project_interrupt.Enabled then
        debuggerfo.project_interrupt.face.image.alignment := 
                                                             [al_stretchx, al_stretchy]
      else
        debuggerfo.project_interrupt.face.image.alignment := 
                                                             [al_grayed, al_stretchx, al_stretchy];

      reset.Enabled := (gdb.started Or gdb.attached Or gdb.downloading) Or Not bo1 And (
                       frunningprocess <> invalidprochandle);
      debuggerfo.project_reset.Enabled := reset.Enabled;

      if debuggerfo.project_reset.Enabled then
        debuggerfo.project_reset.face.image.alignment := 
                                                         [al_stretchx, al_stretchy]
      else
        debuggerfo.project_reset.face.image.alignment := 
                                                         [al_grayed, al_stretchx, al_stretchy];

      makeact.Enabled      := Not making;
      abortmakeact.Enabled := making;

      debuggerfo.project_make.Enabled := makeact.Enabled;

      if debuggerfo.project_make.Enabled then
        debuggerfo.project_make.face.image.alignment := 
                                                        [al_stretchx, al_stretchy]
      else
        debuggerfo.project_make.face.image.alignment := 
                                                        [al_grayed, al_stretchx, al_stretchy];

      saveall.Enabled := sourcefo.modified Or designer.modified Or
                         projectoptions.modified;
      actionsmo.toggleformunit.Enabled := (flastform <> Nil) Or (designer.modules.Count > 0);

      if theprojectname <> '' then
        begin
          mainmenu1.menu.itembynames(['project', 'make']).Enabled := True;
          mainmenu1.menu.itembynames(['project', 'build']).Enabled := True;
          mainmenu1.menu.itembynames(['project', 'make0']).Enabled := True;
          mainmenu1.menu.itembynames(['project', 'make1']).Enabled := True;
          mainmenu1.menu.itembynames(['project', 'make2']).Enabled := True;
          mainmenu1.menu.itembynames(['project', 'make3']).Enabled := True;
          mainmenu1.menu.itembynames(['project', 'make4']).Enabled := True;
          mainmenu1.menu.itembynames(['project', 'make5']).Enabled := True;
          mainmenu1.menu.itembynames(['project', 'make6']).Enabled := True;
          mainmenu1.menu.itembynames(['project', 'make7']).Enabled := True;
          mainmenu1.menu.itembynames(['project', 'make8']).Enabled := True;
          mainmenu1.menu.itembynames(['project', 'make9']).Enabled := True;
          mainmenu1.menu.itembynames(['project', 'abortmake']).Enabled := True;
          mainmenu1.menu.itembynames(['project', 'debugrun']).Enabled := True;
          mainmenu1.menu.itembynames(['project', 'options']).Enabled := True;
          mainmenu1.menu.itembynames(['project', 'tree']).Enabled := True;
          mainmenu1.menu.itembynames(['project', 'source']).Enabled := True;
          mainmenu1.menu.itembynames(['project', 'save']).Enabled := True;
          mainmenu1.menu.itembynames(['project', 'saveas']).Enabled := True;
          mainmenu1.menu.itembynames(['project', 'saveascopy']).Enabled := True;
          mainmenu1.menu.itembynames(['project', 'close']).Enabled := True;
        end
      else
        begin
          mainmenu1.menu.itembynames(['project', 'make']).Enabled := False;
          mainmenu1.menu.itembynames(['project', 'build']).Enabled := False;
          mainmenu1.menu.itembynames(['project', 'make0']).Enabled := False;
          mainmenu1.menu.itembynames(['project', 'make1']).Enabled := False;
          mainmenu1.menu.itembynames(['project', 'make2']).Enabled := False;
          mainmenu1.menu.itembynames(['project', 'make3']).Enabled := False;
          mainmenu1.menu.itembynames(['project', 'make4']).Enabled := False;
          mainmenu1.menu.itembynames(['project', 'make5']).Enabled := False;
          mainmenu1.menu.itembynames(['project', 'make6']).Enabled := False;
          mainmenu1.menu.itembynames(['project', 'make7']).Enabled := False;
          mainmenu1.menu.itembynames(['project', 'make8']).Enabled := False;
          mainmenu1.menu.itembynames(['project', 'make9']).Enabled := False;
          mainmenu1.menu.itembynames(['project', 'abortmake']).Enabled := False;
          mainmenu1.menu.itembynames(['project', 'debugrun']).Enabled := False;
          mainmenu1.menu.itembynames(['project', 'options']).Enabled := False;
          mainmenu1.menu.itembynames(['project', 'tree']).Enabled := False;
          mainmenu1.menu.itembynames(['project', 'source']).Enabled := False;
          mainmenu1.menu.itembynames(['project', 'save']).Enabled := False;
          mainmenu1.menu.itembynames(['project', 'saveas']).Enabled := False;
          mainmenu1.menu.itembynames(['project', 'saveascopy']).Enabled := False;
          mainmenu1.menu.itembynames(['project', 'close']).Enabled := False;
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

          mainmenu1.menu.itembynames(['search', 'proclist']).Enabled := True;
          //     mainmenu1.menu.itembynames(['syntax']).enabled := true;   
          //     mainmenu1.menu.itembynames(['layout']).enabled := true;  
          //    mainmenu1.menu.itembynames(['edit']).enabled := true; 

          mainmenu1.menu.itembynames(['edited', 'make']).Enabled := True;
          mainmenu1.menu.itembynames(['edited', 'build']).Enabled := True;
          mainmenu1.menu.itembynames(['edited', 'make0']).Enabled := True;
          mainmenu1.menu.itembynames(['edited', 'make1']).Enabled := True;
          mainmenu1.menu.itembynames(['edited', 'make2']).Enabled := True;
          mainmenu1.menu.itembynames(['edited', 'make3']).Enabled := True;
          mainmenu1.menu.itembynames(['edited', 'make4']).Enabled := True;
          mainmenu1.menu.itembynames(['edited', 'make5']).Enabled := True;
          mainmenu1.menu.itembynames(['edited', 'make6']).Enabled := True;
          mainmenu1.menu.itembynames(['edited', 'make7']).Enabled := True;
          mainmenu1.menu.itembynames(['edited', 'make8']).Enabled := True;
          mainmenu1.menu.itembynames(['edited', 'make9']).Enabled := True;
          mainmenu1.menu.itembynames(['edited', 'makeX']).Enabled := True;

          mainmenu1.menu.itembynames(['edited', 'abortmake']).Enabled := True;
          mainmenu1.menu.itembynames(['edited', 'run']).Enabled       := True;
          mainmenu1.menu.itembynames(['edited', 'beautifier']).Enabled := True;
          mainmenu1.menu.itembynames(['edited', 'save']).Enabled      := True;
          mainmenu1.menu.itembynames(['edited', 'close']).Enabled     := True;
          //   mainmenu1.menu.itembynames(['edited']).enabled := true;


          with sourcefo.ActivePage do
            begin
              actionsmo.save.Enabled := modified;
              actionsmo.savecust.Enabled := modified;
              undo.Enabled         := edit.canundo;
              redo.Enabled         := edit.canredo;
              copy.Enabled         := edit.hasselection;
              copylatexact.Enabled := edit.hasselection;
              copyword.Enabled     := True;

              cut.Enabled        := edit.hasselection;
              paste.Enabled      := edit.canpaste;
              Delete.Enabled     := edit.hasselection;
              indent.Enabled     := True;
              unindent.Enabled   := True;
              line.Enabled       := source_editor.rowcount > 0;
              togglebkpt.Enabled := line.Enabled;
              togglebkptenable.Enabled := togglebkpt.Enabled;
              //    find.enabled:= true;
              replace.Enabled    := True;
              copyword.Enabled   := True;
              selectall.Enabled  := True;
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
          line.Enabled  := False;

          copyword.Enabled := False;

          mainmenu1.menu.itembynames(['search', 'proclist']).Enabled := False;
          //  mainmenu1.menu.itembynames(['syntax']).enabled := false;   
          //  mainmenu1.menu.itembynames(['layout']).enabled := false;   

          //  mainmenu1.menu.itembynames(['edited']).enabled := false;
          // mainmenu1.menu.itembynames(['edit']).enabled := false; 

          mainmenu1.menu.itembynames(['edited', 'make']).Enabled := False;
          mainmenu1.menu.itembynames(['edited', 'build']).Enabled := False;
          mainmenu1.menu.itembynames(['edited', 'make0']).Enabled := False;
          mainmenu1.menu.itembynames(['edited', 'make1']).Enabled := False;
          mainmenu1.menu.itembynames(['edited', 'make2']).Enabled := False;
          mainmenu1.menu.itembynames(['edited', 'make3']).Enabled := False;
          mainmenu1.menu.itembynames(['edited', 'make4']).Enabled := False;
          mainmenu1.menu.itembynames(['edited', 'make5']).Enabled := False;
          mainmenu1.menu.itembynames(['edited', 'make6']).Enabled := False;
          mainmenu1.menu.itembynames(['edited', 'make7']).Enabled := False;
          mainmenu1.menu.itembynames(['edited', 'make8']).Enabled := False;
          mainmenu1.menu.itembynames(['edited', 'make9']).Enabled := False;
          mainmenu1.menu.itembynames(['edited', 'makeX']).Enabled := False;
          mainmenu1.menu.itembynames(['edited', 'abortmake']).Enabled := False;
          mainmenu1.menu.itembynames(['edited', 'run']).Enabled  := False;
          mainmenu1.menu.itembynames(['edited', 'beautifier']).Enabled := False;
          mainmenu1.menu.itembynames(['edited', 'save']).Enabled := False;
          mainmenu1.menu.itembynames(['edited', 'close']).Enabled := False;

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
          replace.Enabled   := False;
          copyword.Enabled  := False;
          selectall.Enabled := False;

        end;
      if (factivedesignmodule <> nil) then
        begin
          save.Enabled  := factivedesignmodule^.modified;
          //debuggerfo.save_file.enabled := save.enabled;
          Close.Enabled := True;
        end
      else
        Close.Enabled := sourcefo.Count > 0;
      closeall.Enabled := (sourcefo.Count > 0) Or (designer.modules.Count > 0);
      saveas.Enabled := (factivedesignmodule <> Nil) Or (sourcefo.ActivePage <> Nil);
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

procedure tmainfo.createmodulemenuitem(Const amodule: pmoduleinfoty);
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

function tmainfo.openformfile(Const filename: filenamety; Const ashow, aactivate, showsource,
                              createmenu, skipexisting: Boolean): pmoduleinfoty;
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
        showobjecttext(Nil, wstr1, False);
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
      sourcechanged(Nil);
  end;
end;

procedure tmainfo.loadformbysource(Const sourcefilename: filenamety);
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

procedure tmainfo.loadsourcebyform(Const formfilename: filenamety; Const aactivate: Boolean = False)
;
begin
  sourcefo.openfile(replacefileext(formfilename, pasfileext), aactivate);
end;

function tmainfo.opensource(Const filekind: filekindty; Const addtoproject: Boolean; Const aactivate
                            : Boolean = True; Const currentnode: tprojectnode = Nil): Boolean;
var 
  unitnode: tunitnode;
var 
  int1: integer;
  page: tsourcepage;
  str1: filenamety;
  po1: pmoduleinfoty;
begin
  //opensourceactonexecute
  //writeln('hello');
  openfile.controller.captionopen := lang_xstockcaption[ord(sc_openfile)];

  openfile.controller.showoptions := True;

  openfile.controller.icon := icon;

  openfile.controller.fontheight := font.Height;
  // font height of dialogfile

  openfile.controller.fontname := msestring(font.Name);
  // font name of dialogfile

  openfile.controller.fontcolor := font.color;
  // font color of dialogfile

  // openfile.controller.backcolor := tbackcolor.Value;    // background color of dialogfile

  Result := openfile.Execute = mr_ok;

  if Result then
    begin
      page     := Nil;
      po1      := Nil;
      unitnode := Nil;
      //compilerwarning
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

procedure tmainfo.designformactivated(Const Sender: tcustommseform);
begin
  setlinkedvar(Sender, tmsecomponent(flastform));
  if sourcefo = flastform then
    begin
      factivedesignmodule := Nil;
      setlinkedvar(Sender, tmsecomponent(flastdesignform));
    end
  else if (designer.actmodulepo <> nil) and
          (designer.actmodulepo^.designform = flastform) then
         begin
           factivedesignmodule := designer.actmodulepo;
           setlinkedvar(Sender, tmsecomponent(flastdesignform));
         end;
end;

procedure tmainfo.viewcomponentpaletteonexecute(Const Sender: TObject);
begin
  componentpalettefo.window.bringtofront;
  componentpalettefo.Caption := lang_xstockcaption[Ord(sc_componentspalette)];
  componentpalettefo.Show;
end;

procedure tmainfo.viewcomponentstoreonexecute(Const Sender: TObject);
begin
  componentstorefo.activate;
end;

procedure tmainfo.viewfpguidesigneronexecute(Const Sender: TObject);
begin

  LoadfpgDesigner(ansistring(conffpguifo.edshow.Text));

end;

procedure tmainfo.resetfpguidesigneronexecute(Const Sender: TObject);
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

procedure tmainfo.viewdebuggertoolbaronexecute(Const Sender: TObject);
begin
  debuggerfo.window.bringtofront;
  //debuggerfo.show;
  debuggerfo.activate;
end;

procedure tmainfo.mainonloaded(Const Sender: TObject);
var 
  wstr1: msestring;
begin
  try
    wstr1 := filepath(statdirname);
    if not finddir(wstr1) then
      createdir(wstr1);

    {$ifdef linux}
    if not fileexists(wstr1 + '/ideuli.sta') then
      Filecreate(wstr1 + '/ideuli.sta');
    {$endif}

    mainstatfile.filedir  := wstr1;
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

    if (poscy.value <> 100) and (poscx.value <> 800) then
      begin
        top :=  posy.value;
        left := posx.value;
        height := poscy.value;
        width := poscx.value;
      end;

    expandprojectmacros;
    onscale(Nil);
  finally
    mainfo.activate;
end;
 {$ifdef mse_dumpunitgroups}
dumpunitgr;
 {$endif}
end;

function getmodulename(Const aname, suffix: String): string;
var 
  int1: integer;
begin
  int1     := length(aname) - length(suffix);
  if (int1 >= 0) and (strcomp(PChar(aname) + int1, PChar(suffix)) = 0) then
    Result := copy(aname, 1, int1) + copy(suffix, 1, 2)
  else
    Result := aname + copy(suffix, 1, 2);
end;

procedure tmainfo.createform(Const aname: filenamety; Const namebase: String; Const ancestor: String
);
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
po1^.modified := True;
//initial create of ..._mfm.pas
end;

procedure tmainfo.createprogramfile(Const aname: filenamety);
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

function tmainfo.copynewfile(Const aname, newname: filenamety; Const autoincrement: Boolean; Const
                             canoverwrite: Boolean; Const macronames: Array Of msestring; Const
                             macrovalues: Array Of msestring): Boolean;
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
    ShowMessage(lang_stockcaption[ord(sc_file)] + ' ' + aname + ' '
    + lang_actionsmodule[ord(ac_notfound)], 
    lang_stockcaption[Ord(sc_warningupper)])
  else
    begin
      path2 := filepath(newname);
      if not canoverwrite and findfile(path2) then
        if not autoincrement then
          begin
            showerror(lang_stockcaption[ord(sc_file)] + ' ' + newname +
            ' ' + lang_actionsmodule[ord(ac_exists)]);

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

procedure tmainfo.newfileonexecute(Const Sender: TObject);
var 
  str1: filenamety;
  int1: integer;
begin
  str1 := '';
  int1 := tmenuitem(Sender).tag;
  with projectoptions.o.texp do
    if newfisources[int1] = '' then
      sourcefo.newpage
    else if filedialogx(str1, [fdo_save, fdo_checkexist], lang_stockcaption[Ord(sc_newfile)] + ' ' +
            newfinames[int1], [newfinames[int1]],
            [newfifilters[int1]], newfiexts[int1]) = mr_ok then
           begin
             copynewfile(newfisources[int1], str1, False, True,
                         ['%PROGRAMNAME%', '%UNITNAME%'], ['${%FILENAMEBASE%}',
                         '${%FILENAMEBASE%}']);
             sourcefo.openfile(str1, True);
           end;
end;

procedure tmainfo.newformonexecute(Const Sender: TObject);
var 
  str1, str2, str3, str4, str5: filenamety;
  dir, base, ext: filenamety;
  po1: pmoduleinfoty;
  ancestorclass, ancestorunit: msestring;
begin
  // if formkindty(tmenuitem(sender).tag) = fok_inherited then begin
  if projectoptions.o.newinheritedforms[tmenuitem(Sender).tag] then
    begin
      po1 := selectinheritedmodule(Nil, lang_mainform[Ord(ma_selectancestor)]);
      if po1 = nil then
        Exit;
      ancestorclass := utf8decode(po1^.moduleclassname);
      ancestorunit  := filenamebase(po1^.filename);
    end
  else
    begin
      ancestorclass := '';
      ancestorunit  := '';
      po1           := Nil;
    end;
  str1 := '';
  if filedialogx(str1, [fdo_save, fdo_checkexist], lang_mainform[Ord(ma_newform)],
     [lang_mainform[Ord(ma_pascalfiles)]],
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

procedure tmainfo.removemodulemenuitem(Const amodule: pmoduleinfoty);
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

function tmainfo.closemodule(Const amodule: pmoduleinfoty; Const achecksave: Boolean; nocheckclose:
                             Boolean = False): Boolean;
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
          factivedesignmodule := Nil;
    end
  else
    Result := True;
end;

function tmainfo.checksavecancel(Const aresult: modalresultty): modalresultty;
begin
  if aresult = mr_cancel then
    begin
      projectoptions.savechecked := False;
      sourcefo.savecanceled;
      designer.savecanceled;
    end;
  Result := aresult;
end;

function tmainfo.closeall(Const nosave: Boolean): Boolean;
begin
  Result := nosave Or (checksavecancel(sourcefo.saveall(False)) <> mr_cancel);
  if Result then
    begin
      Result := nosave Or (checksavecancel(designer.saveall(False, True)) <>
                mr_cancel);
      if Result then
        begin
          sourcefo.closeall(True);
          while designer.modules.Count > 0 do
            closemodule(designer.modules.itempo[designer.modules.Count - 1], Not nosave, True);
        end;
    end;
end;

procedure tmainfo.buildactonexecute(Const Sender: TObject);
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
procedure tmainfo.mainfoonterminate(Var terminate: Boolean);
//var
// modres: modalresultty;
begin

  posy.value := top;
  posx.value := left;
  poscy.value := height;
  poscx.value := width;

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
                  //+ ' (<' + lang_mainform[ord(ma_new2) + '>)'
  else
    begin

      if confideufo.fullpath.Value then
        Caption := idecaption + ' (' + (tosysfilepath(filepath(aname, fk_file, True))) + ')'
      else
        Caption := idecaption + ' (' + filename(aname) + ')';

      setcurrentdirmse(filedir(aname));
      openfile.controller.filename := '';
    end;
  dragdock.layoutchanged;
  //refresh possible dockpanel caption
end;

function tmainfo.openproject(Const aname: filenamety; Const ascopy: Boolean = False): Boolean;

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
  designer.savecanceled();
  //reset saveall flag
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

  if Assigned(debuggerfo) and (length(lang_mainform) > 0) and
     (length(lang_stockcaption) > 0) then
    begin
      debuggerfo.project_make.hint      := ' ' + lang_xstockcaption[Ord(sc_project)] +
                                           ' : ' + lang_xstockcaption[Ord(sc_make)] + ' ' +
                                           ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_start.hint     := ' ' + lang_xstockcaption[Ord(sc_project)] +
                                           ' : ' + lang_xstockcaption[Ord(sc_debugrun)] + ' ' +
                                           ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_save.hint      := ' ' + lang_xstockcaption[Ord(sc_project)] +
                                           ' : ' + lang_stockcaption[Ord(sc_save)] + ' ' +
                                           ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_interrupt.hint := ' ' + lang_xstockcaption[Ord(sc_project)] +
                                           ' : ' + lang_xstockcaption[Ord(sc_abortmake)] + ' ' +
                                           ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_next.hint      := ' ' + lang_xstockcaption[Ord(sc_project)] +
                                           ' : ' + lang_xstockcaption[Ord(sc_nextinstruction)] + ' '
                                           + ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_step.hint      := ' ' + lang_xstockcaption[Ord(sc_project)] +
                                           ' : ' + lang_xstockcaption[Ord(sc_stepinstruction)] + ' '
                                           + ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_finish.hint    := ' ' + lang_xstockcaption[Ord(sc_project)] +
                                           ' : ' + lang_xstockcaption[Ord(sc_finish)] + ' ' +
                                           ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_next_instruction.hint := ' ' + lang_xstockcaption[Ord(sc_project)] +
                                                  ' : ' + lang_xstockcaption[Ord(sc_nextinstruction)
                                                  ]
                                                  + ' ' +
                                                  lang_xstockcaption[Ord(sc_assembler)] + ' ' +
                                                  ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_step_instruction.hint := ' ' + lang_xstockcaption[Ord(sc_project)] +
                                                  ' : ' + lang_xstockcaption[Ord(sc_stepinstruction)
                                                  ]
                                                  + ' ' +
                                                  lang_xstockcaption[Ord(sc_assembler)] + ' ' +
                                                  ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_reset.hint     := ' ' + lang_xstockcaption[Ord(sc_project)] +
                                           ' : ' + lang_xstockcaption[Ord(sc_reset)] + ' ' +
                                           ExtractFilename(theprojectname) + ' ';
      debuggerfo.edited_make.hint       := ' ' + lang_xstockcaption[Ord(sc_edited)] +
                                           ' : ' + lang_xstockcaption[Ord(sc_make)] + ' ' +
                                           thefilename + ' ';
      debuggerfo.edited_run.hint        := ' ' + lang_xstockcaption[Ord(sc_edited)] +
                                           ' : ' + lang_xstockcaption[Ord(sc_debugrun)] + ' ' +
                                           thefilename + ' ';
      debuggerfo.toggle_form_unit.hint  := ' ' + lang_xstockcaption[Ord(sc_edited)] +
                                           ' : ' + lang_xstockcaption[Ord(sc_toggleformunit)] + ' '
                                           +
                                           thefilename + ' ';

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
            application.handleexception(Nil, lang_mainform[Ord(ma_cannotloadproj)] + ' "' + aname +
            '": ');
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

  if projectoptions.o.enablesource = False then
    actionsmo.projectsourceexe(Nil)
  else if sourcefo.files_tab.Count = 0 then
         actionsmo.projectsourceexe(Nil);

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
    sourcefo.ActivePage.SetFocus;

    layoutbusy := False;

  end;

//}
end;

procedure tmainfo.saveproject(aname: filenamety; Const ascopy: Boolean = False);
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

///////////////
procedure tmainfo.newproject(const fromprogram,empty: boolean);
var
 aname: filenamety;
 mstr1,mstr2: msestring;
 i1: integer;
 isfromtemplate: boolean = false;
 curdir,source,dest: filenamety;
 macrolist: tmacrolist;
 copiedfiles: filenamearty;
 bo1: boolean;
label
 endlab;
begin
 mstr2:= projecttemplatedir; //use macros of current project
 if fromprogram then begin
  if (checksave() = mr_cancel) or not closeall(false) then begin
   exit;
  end;
  setprojectname('');
 end;
 if fromprogram or openproject('') then begin
  gdb.closegdb;
  cleardebugdisp;
  sourcechanged(nil);
  mstr1:= '';
  if not fromprogram then begin
   if not empty then begin
    aname:= mstr2 + 'default.prj';
     if filedialogx(aname, [fdo_checkexist], lang_mainform[Ord(ma_selecttemplate)],
                 [lang_mainform[Ord(ma_projectfiles)], lang_mainform[Ord(ma_str_allfiles)]],
                 ['*.prj', '*'], 'prj') = mr_ok then begin
                 isfromtemplate := true;
                readprojectoptions(aname);
                 
   end;
   end;
   aname:= '';
  end
  else begin
   aname:= '';
    if filedialogx(aname, [fdo_checkexist], lang_mainform[Ord(ma_selectprogramfile)],
             [lang_mainform[Ord(ma_pascalprogfiles)], lang_mainform[Ord(ma_cfiles)],
             lang_mainform[Ord(ma_str_allfiles)]],
             ['"*.pas" "*.pp" "*.mla" "*.dpr" "*.lpr"', '"*.c" "*.cc" "*.cpp"', '*'],
             'pas') = mr_ok then
            begin
            
    //  writeln(filedir(aname));     
     setcurrentdirmse(filedir(aname));
    with projectoptions do begin
     with o.t do begin
      mainfile:= filename(aname);
      aname:= removefileext(mainfile);
      targetfile:= aname+'${EXEEXT}'
     end;
     expandprojectmacros;
    end;
     aname:= aname + '.prj';
   end
   else begin
    goto endlab;
   end;
  end;
  if filedialogx(aname, [fdo_save, fdo_checkexist], lang_mainform[Ord(ma_str_newproject)],
         [lang_mainform[Ord(ma_projectfiles)], lang_mainform[Ord(ma_str_allfiles)]],
         ['*.prj', '*'], 'prj') = mr_ok then
        begin
    curdir:= filedir(aname);
   setcurrentdirmse(curdir);
    if not directoryexists(curdir + directoryseparator + 'units') then
            msefileutils.createdir(curdir + directoryseparator + 'units');
   insertitem(projecthistory,0,aname);
   i1:= 1;
   while i1 <= high(projecthistory) do begin
    if projecthistory[i1] = aname then begin
     deleteitem(projecthistory,i1);
    end;
    inc(i1);
   end;
   if high(projecthistory) >=
             projectfiledia.controller.historymaxcount then begin
    setlength(projecthistory,projectfiledia.controller.historymaxcount);
   end;
   if not fromprogram then begin
    mstr1:= removefileext(filename(aname));
    with projectoptions,o do begin
     projectfilename:= aname;
     projectdir:= curdir;
     expandprojectmacros;
     with o.texp do begin
      setlength(copiedfiles,length(newprojectfiles));
      macrolist:= tmacrolist.create([mao_curlybraceonly]);
      try
       macrolist.add(['%PROJECTNAME%','%PROJECTDIR%'],[mstr1,curdir],[]);
       if runscript(scriptbeforecopy,true,false) then begin
        for i1:= 0 to high(newprojectfiles) do begin
         source:= filepath(newprojectfiles[i1]);
         if i1 <= high(newprojectfilesdest) then begin
          dest:= newprojectfilesdest[i1];
         end
         else begin
          dest:= '';
         end;
         if dest <> '' then begin
          macrolist.expandmacros1(dest);
          if source = '' then begin
           createdirpath(dest);
          end
          else begin
           createdirpath(filedir(dest));
          end;
         end
         else begin
          dest:= filename(source);
         end;
         copiedfiles[i1]:= dest;
         if newprojectfiles[i1] <> '' then begin
          if (i1 <= high(o.expandprojectfilemacros)) and
                             o.expandprojectfilemacros[i1] then begin
           copynewfile(source,dest,false,false,['%PROJECTNAME%','%PROJECTDIR%'],
                                       [mstr1,curdir]);
          end
          else begin
           try
            if not copyfile(source,dest,false) then begin
                   showerror(lang_stockcaption[ord(sc_file)] + ' ' + dest +
                                      ' ' + lang_actionsmodule[ord(ac_exists)]);
                       
            end;
           except
            application.handleexception(nil);
           end;
          end;
         end;
        end;
        runscript(scriptaftercopy,false,false);
       end;
      finally
       macrolist.free;
      end;
     end;
     saveproject(aname);
     bo1:= true;
     for i1:= 0 to high(copiedfiles) do begin
      if i1 > high(o.loadprojectfile) then begin
       break;
      end;
      if o.loadprojectfile[i1] then begin
       if checkfileext(copiedfiles[i1],[formfileext])then begin
        openformfile(copiedfiles[i1],true,false,false,true,false);
       end
       else begin
        sourcefo.openfile(copiedfiles[i1],bo1);
        bo1:= false;
       end;
      end;
     end;
    end;
    if isfromtemplate then openproject(aname);
   end
   else begin
      if not directoryexists(filedir(aname) + directoryseparator + 'units') then
      msefileutils.createdir(filedir(aname) + directoryseparator + 'units');
    saveproject(aname);
    sourcefo.openfile(projectoptions.o.texp.mainfile,true);
   end;
  end
  else begin
 endlab:
   projectoptions.projectfilename:= '';
   projectoptions.modified:= true;
  end;
 end;
end;

procedure tmainfo.newprojectonexecute(Const Sender: TObject);
begin
  newproject(False, False);
end;

procedure tmainfo.newprojectfromprogramexe(Const Sender: TObject);
begin
  newproject(True, False);
end;

procedure tmainfo.newemptyprojectexe(Const Sender: TObject);
begin
  newproject(False, True);
end;

procedure tmainfo.openprojectcopyexecute(Const Sender: TObject);
var 
  str1: filenamety;
begin
  if projectfiledialog(str1, False) = mr_ok then
    openproject(str1, True);
end;

procedure tmainfo.saveprojectasonexecute(Const Sender: TObject);
var 
  str1: filenamety;
begin
  if projectfiledialog(str1, True) = mr_ok then
    saveproject(str1);
end;

procedure tmainfo.saveprojectcopyexecute(Const Sender: TObject);
var 
  str1: filenamety;
begin
  if projectfiledialog(str1, True) = mr_ok then
    saveproject(str1, True);
end;

procedure tmainfo.mainstatfileonupdatestat(Const Sender: TObject; Const filer: tstatfiler);
var 
  mstr1: filenamety;
  ar1: msestringarty;
  int1: integer;
begin
  ar1 := Nil;
  //compiler warning
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
      actionsmo.custcompileproject(Nil);
    end;
end;

procedure tmainfo.customdomake(aname: filenamety; acompiler: integer; acompilertag: integer; atag:
                               integer);
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
              gdb.gdbdownload := projectoptions.d.gdbdownload And needsdownload;
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
                setstattext(lang_mainform[Ord(ma_cannotstartprocess)], mtk_error);
                Exit;
              end;
            runprocmon.listentoprocess(frunningprocess);
          finally
            if progworkingdirectory <> '' then
              setcurrentdirmse(pwdbefore);
        end;
    end;
  setstattext('*** ' + lang_mainform[Ord(ma_process)] + ' ' + inttostrmse(frunningprocess) + ' ' +
  trim(lang_actionsmodule[Ord(ac_running)]) + ' ***', mtk_making);
  debuggerfo.project_reset.Enabled     := True;
  debuggerfo.project_interrupt.Enabled := True;
end;
end;

procedure tmainfo.runprocdied(Const Sender: TObject; Const prochandle: prochandlety; Const
                              execresult: integer; Const Data: Pointer);
begin

  if prochandle = frunningprocess then
    begin
      frunningprocess := invalidprochandle;
      if execresult <> 0 then
        setstattext(lang_mainform[Ord(ma_processterminated)] + ' ' + UTF8Decode(IntToStr(execresult)
        ) + '.', 
        mtk_error)
      else
        setstattext(lang_mainform[Ord(ma_proctermnormally)], mtk_finished);
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
             (not gdb.started or askconfirmation(lang_mainform[Ord(ma_str_sourcechanged)])) then
            begin
              Result := False;
              watchpointsfo.Clear;
              // domake(projectoptions.defaultmake);
              actionsmo.custcompileproject(Nil);
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

procedure tmainfo.runexec(Const Sender: TObject);
begin
  if checkremake(sc_continue) then
    dorun;
end;

procedure tmainfo.aftermake(Const adesigner: idesigner; Const exitcode: integer);
var 
  str3: msestring;
  int3: integer;
begin
  actionsmo.finishcustom;

  if exitcode <> 0 then
    begin
      setstattext(lang_mainform[Ord(ma_makeerror)] + ' ' + UTF8Decode(IntToStr(exitcode)) + '.', 
      mtk_error);
      showfirsterror;
    end
  else
    begin

      setstattext(lang_mainform[Ord(ma_makeok)], mtk_finished);
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

procedure tmainfo.sourcechanged(Const Sender: tsourcepage);
begin
  fnoremakecheck := False;
  fcurrent       := False;
  if Sender = nil then
    updatemodifiedforms;
end;

procedure tmainfo.exitonexecute(Const Sender: TObject);
begin
  window.Close;
end;

procedure tmainfo.moduledestroyed(Const adesigner: idesigner; Const amodule: tmsecomponent);
var 
  po1: pmoduleinfoty;
begin
  po1 := designer.modules.findmodulebyinstance(amodule);
  removemodulemenuitem(po1);
  if po1 = factivedesignmodule then
    factivedesignmodule := Nil;
end;

procedure tmainfo.methodcreated(Const adesigner: idesigner; Const amodule: tmsecomponent; Const
                                aname: String; Const atype: ptypeinfo);
begin
  //dummy
end;

procedure tmainfo.methodnamechanged(Const adesigner: idesigner; Const amodule: tmsecomponent; Const
                                    newname, oldname: String; Const atypeinfo: ptypeinfo);
begin
  //dummy
end;

procedure tmainfo.showobjecttext(Const adesigner: idesigner; Const afilename: filenamety; Const
                                 backupcreated: Boolean);
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

procedure tmainfo.closeobjecttext(Const adesigner: idesigner; Const afilename: filenamety; Var
                                  cancel: Boolean);
begin
  cancel := Not sourcefo.closepage(afilename);
end;

procedure tmainfo.newpanelonexecute(Const Sender: TObject);
begin
  newpanel.activate;
  //paneltitlefo.show(true);
end;

procedure tmainfo.viewwatchpointsonexecute(Const Sender: TObject);
begin
  watchpointsfo.activate;
end;

//fred
procedure tmainfo.viewconfmseguiexecute(Const Sender: TObject);
begin
  // confmseguifo.activate;
  confmseguifo.Show(True);
end;

procedure tmainfo.viewconfcompilersexecute(Const Sender: TObject);
begin
  // confcompilerfo.activate;
  confcompilerfo.Show(True);
end;

procedure tmainfo.viewconfdebuggersexecute(Const Sender: TObject);
begin
  //confdebuggerfo.activate;
  confdebuggerfo.Show(True);
end;

procedure tmainfo.viewconfideuexecute(Const Sender: TObject);
begin
  //confideufo.activate;
  confideufo.Show(True);
end;

procedure tmainfo.viewconffpguiexecute(Const Sender: TObject);
begin
  // conffpguifo.activate;
  conffpguifo.Show(True);
end;

procedure tmainfo.viewsymbolsonexecute(Const Sender: TObject);
begin
  symbolfo.activate;
end;

procedure tmainfo.viewthreadsonexecute(Const Sender: TObject);
begin

  threadsfo.activate;
  if threadsfo.Width < 50 then
    begin
      threadsfo.Height := 180;
      threadsfo.Width  := 250;
    end;
end;

procedure tmainfo.viewconsoleonexecute(Const Sender: TObject);
begin
  targetconsolefo.activate;
end;

procedure tmainfo.viewfindresults(Const Sender: TObject);
begin
  findinfilefo.activate;

end;

procedure tmainfo.aboutonexecute(Const Sender: TObject);
begin
  aboutfo.font.Height := confideufo.fontsize.Value;
  aboutfo.Caption     := lang_xstockcaption[Ord(sc_about)] + ' MSEgui';

  aboutfo.about_text.frame.colorclient := $B2F4FF;

  aboutfo.about_text.Value := 
                              c_linefeed + 'MSEgui v' + mseguiversiontext +
                              c_linefeed + c_linefeed + c_linefeed +
                              lang_xstockcaption[Ord(sc_host)] + ': ' + platformtext +
                              c_linefeed + c_linefeed + c_linefeed +
                              ' Martin Schreiber' +
                              c_linefeed +
                              lang_xstockcaption[Ord(sc_copyright)] + ' 1999-2022' +
                              c_linefeed +
                              'https://github.com/mse-org/mseide-msegui';

  aboutfo.about_text.Height := 15 * confideufo.fontsize.Value;
  aboutfo.Height := aboutfo.about_text.Height + 16;


  aboutfo.Show(True);

end;

procedure tmainfo.aboutfpguionexecute(Const Sender: TObject);
begin
  aboutfo.font.Height      := confideufo.fontsize.Value;
  aboutfo.Caption          := lang_xstockcaption[Ord(sc_about)] + ' fpGUI';
  aboutfo.about_text.frame.colorclient := $FFF5B2;
  aboutfo.about_text.Value := 
                              c_linefeed + 'fpGUI v1.4' +
                              c_linefeed + c_linefeed + c_linefeed +
                              lang_xstockcaption[Ord(sc_host)] + ': ' + platformtext +
                              c_linefeed + c_linefeed +
                              ' Graeme Geldenhuys' +
                              c_linefeed +
                              '<graemeg@gmail.com>' +
                              c_linefeed +
                              lang_xstockcaption[Ord(sc_copyright)] + ' 1999-2022';

  aboutfo.about_text.Height := 13 * confideufo.fontsize.Value;
  aboutfo.Height := aboutfo.about_text.Height + 16;

  aboutfo.Show(True);
end;

procedure tmainfo.aboutideuonexecute(Const Sender: TObject);
begin
  aboutfo.font.Height      := confideufo.fontsize.Value;
  aboutfo.Caption          := lang_xstockcaption[Ord(sc_about)] + ' ideU';
  aboutfo.about_text.frame.colorclient := $DFFFB2;
  aboutfo.about_text.Value := 
                              c_linefeed + 'ideU v' + versiontext +
                              c_linefeed + c_linefeed + c_linefeed +
                              lang_xstockcaption[Ord(sc_host)] + ': ' + platformtext +
                              c_linefeed + c_linefeed + c_linefeed +
                              'Fred van Stappen' +
                              c_linefeed +
                              '<fiens@hotmail.com>' + c_linefeed +
                              lang_xstockcaption[Ord(sc_copyright)] + ' 1999-2022';

  aboutfo.about_text.Height := 15 * confideufo.fontsize.Value;
  aboutfo.Height := aboutfo.about_text.Height + 16;

  aboutfo.Show(True);
end;


procedure tmainfo.configureexecute(Const Sender: TObject);
begin
  configureide;
end;

procedure tmainfo.beforemake(Const adesigner: idesigner; Const maketag: integer; Var abort: Boolean)
;
begin
  //dummy
end;


procedure tmainfo.beforefilesave(Const adesigner: idesigner; Const afilename: filenamety);
begin
  //dummy
end;

procedure tmainfo.runtool(Const Sender: TObject);
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
                actionsmo.saveallactonexecute(Nil);
              if sourcefo.ActivePage <> nil then
                begin
                  with sourcefo.ActivePage do
                    begin
                      cursourcefile := tosysfilepath(sourcefo.currentfilename);
                      cursselection := sourcefo.currentselection;
                      //edit.selectedtext;
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

procedure tmainfo.statbefread(Const Sender: TObject);
begin
  createcpufo;
end;

procedure tmainfo.getstatobjs(Const Sender: TObject; Var aobjects: objectinfoarty);
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

procedure tmainfo.savewindowlayout(Const astream: ttextstream);
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

procedure tmainfo.loadwindowlayout(Const areader: tstatreader);
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

procedure tmainfo.loadwindowlayout(Const astream: ttextstream);
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


procedure tmainfo.loadwindowlayoutexe(Const Sender: TObject);
var 
  str1: ttextstream;
begin
  if filedialogx(windowlayoutfile, [fdo_checkexist], lang_mainform[Ord(ma_str_loadwindowlayout)],
     [lang_mainform[Ord(ma_projectfiles)], lang_mainform[Ord(ma_str_allfiles)]], ['*.prj', '*'],
     'prj',
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
procedure tmainfo.menuwindowlayoutexe(Const Sender: TObject);
begin
  if Assigned(sourcefo.ActivePage) then
    begin

      if not dialogfilesformcreated then
        dodialogfiles;

      //  writeln('ok dodialogfiles'); 

      dothemedialog();

      //  writeln('ok dothemedialog'); 

      dialogfilesfo.tag := 1;

      dialogfilesfo.Caption := lang_mainform[Ord(ma_str_loadwindowlayout)];
      //'Load a Layout File';

      // dialogfilesfo.list_files.cellwidth := 437;
      dialogfilesfo.list_files.mask := '*.prj';
      dialogfilesfo.list_files.path := expandprmacros('${LAYOUTDIR}');

      //    writeln('ok macros'); 

      tabind := sourcefo.files_tab.activepageindex;

      //  writeln('ok tabind'); 
      dialogfilesfo.selected_file.frame.Caption := lang_stockcaption[ord(sc_file)];

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

procedure tmainfo.closeprojectactonexecute(Const Sender: TObject);
var 
  str1: ttextstream;
  str2: msestring;
begin
  if mainfo.openproject('') then
    begin
      Caption        := idecaption;
      fprojectloaded := False;
      str2           := expandprmacros('${LAYOUTDIR}') + 'AfterClose.prj';
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

procedure tmainfo.mainstatbeforewriteexe(Const Sender: TObject);
begin
  disassfo.resetshortcuts();
end;

procedure tmainfo.statafterread(Const Sender: TObject);
begin
  actionsmo.forcezorderact.Checked := projectoptions.o.forcezorder;
end;

procedure tmainfo.basedockpaintexe(Const Sender: twidget; Const acanvas: tcanvas);
begin
  if length(lang_mainform) > 0 then
    paintdockingareacaption(acanvas, Sender, lang_mainform[Ord(ma_dockingarea)])
  else
    paintdockingareacaption(acanvas, Sender, '');
  ;
end;

procedure tmainfo.copywordatcur(Const Sender: TObject);
begin
  sourcefo.ActivePage.copywordatcursor();
end;

procedure tmainfo.onresizemain(Const Sender: TObject);
var 
  screen: rectty;
begin
  screen   := application.workarea();
  if Height > screen.y + screen.cy then
    Height := screen.y + screen.cy - 30;

  if Width > screen.x + screen.cx then
    Width := screen.x + screen.cx;
end;

procedure tmainfo.closeallmod(Const Sender: TObject);
begin
  closeallmodule();
end;

procedure tmainfo.setlangideu(thelang: String);
var 
  item1: tmenuitem;
  x: shortint;
  stca: stockcaptionty;
  str : string;
begin
  createnewlang(thelang);

  if thelang = 'zh' then
    begin
      mainmenu1.menu.itembynames(['file', 'menuwidth']).visible := true;
      mainmenu1.menu.itembynames(['search', 'menuwidth']).visible := true;
      mainmenu1.menu.itembynames(['edit', 'menuwidth']).visible := true;
      mainmenu1.menu.itembynames(['target', 'menuwidth']).visible := true;
      mainmenu1.menu.itembynames(['view', 'menuwidth']).visible := true;
      mainmenu1.menu.itembynames(['project', 'menuwidth']).visible := true;
      mainmenu1.menu.itembynames(['edited', 'menuwidth']).visible := true;
      mainmenu1.menu.itembynames(['settings', 'menuwidth']).visible := true;
      mainmenu1.menu.itembynames(['menuwidth']).visible := true;
      mainmenu1.options := [mo_shortcutright,mo_commonwidth,mo_activate,mo_updateonidle];
    end
  else
    begin
      mainmenu1.menu.itembynames(['file', 'menuwidth']).visible := false;

      mainmenu1.menu.itembynames(['search', 'menuwidth']).visible := false;
      mainmenu1.menu.itembynames(['edit', 'menuwidth']).visible := false;
      mainmenu1.menu.itembynames(['target', 'menuwidth']).visible := false;
      mainmenu1.menu.itembynames(['view', 'menuwidth']).visible := false;
      mainmenu1.menu.itembynames(['project', 'menuwidth']).visible := false;
      mainmenu1.menu.itembynames(['edited', 'menuwidth']).visible := false;
      mainmenu1.menu.itembynames(['settings', 'menuwidth']).visible := false;
      mainmenu1.menu.itembynames(['menuwidth']).visible := false;
      mainmenu1.options := [mo_shortcutright,mo_activate,mo_updateonidle];
    end;

  application.ProcessMessages;

  mainmenu1.menu.itembynames(['file']).Caption         := 
                                                          '&' + lang_stockcaption[ord(sc_file)];

  mainmenu1.menu.itembynames(['file', 'new']).Caption   := lang_stockcaption[Ord(sc_newfile)];
  mainmenu1.menu.itembynames(['file', 'open']).Caption  := lang_stockcaption[Ord(sc_open)];
  mainmenu1.menu.itembynames(['file', 'save']).Caption  := lang_stockcaption[Ord(sc_save)];
  mainmenu1.menu.itembynames(['file', 'saveas']).Caption := lang_xstockcaption[Ord(sc_saveas)];
  mainmenu1.menu.itembynames(['file', 'saveall']).Caption := lang_xstockcaption[Ord(sc_saveall)];
  mainmenu1.menu.itembynames(['file', 'close']).Caption := lang_stockcaption[Ord(sc_close)];
  mainmenu1.menu.itembynames(['file', 'closeall']).Caption := lang_xstockcaption[Ord(sc_closeall)
                                                              ];
  mainmenu1.menu.itembynames(['file', 'print']).Caption := lang_xstockcaption[Ord(sc_print)];
  mainmenu1.menu.itembynames(['file', 'quit']).Caption  := lang_mainform[Ord(ma_exit)];
  mainmenu1.menu.itembynames(['search']).Caption        := '&' + lang_stockcaption[Ord(sc_search
                                                           )];
  mainmenu1.menu.itembynames(['search', 'line']).Caption := lang_xstockcaption[Ord(sc_line)];
  mainmenu1.menu.itembynames(['search', 'find']).Caption := lang_stockcaption[Ord(sc_search)];
  mainmenu1.menu.itembynames(['search', 'searchagain']).Caption := lang_xstockcaption[Ord(
                                                                   sc_search_again)];
  mainmenu1.menu.itembynames(['search', 'searchback']).Caption := lang_xstockcaption[Ord(
                                                                  sc_search_back)];
  mainmenu1.menu.itembynames(['search', 'findreplace']).Caption := lang_xstockcaption[Ord(
                                                                   sc_find_replace)];
  mainmenu1.menu.itembynames(['search', 'findinfile']).Caption := lang_xstockcaption[Ord(
                                                                  sc_find_infile)];
  mainmenu1.menu.itembynames(['search', 'proclist']).Caption := lang_xstockcaption[Ord(
                                                                sc_proclist)];
  mainmenu1.menu.itembynames(['edit']).Caption          := '&' + lang_stockcaption[Ord(sc_edit)]
  ;
  mainmenu1.menu.itembynames(['edit', 'undo']).Caption  := lang_stockcaption[Ord(sc_Undohk)];
  mainmenu1.menu.itembynames(['edit', 'redo']).Caption  := lang_stockcaption[Ord(sc_Redohk)];
  mainmenu1.menu.itembynames(['edit', 'copy']).Caption  := lang_stockcaption[Ord(sc_Copyhk)];
  mainmenu1.menu.itembynames(['edit', 'cut']).Caption   := lang_stockcaption[Ord(sc_Cuthk)];
  mainmenu1.menu.itembynames(['edit', 'paste']).Caption := lang_stockcaption[Ord(sc_pastehk)];
  mainmenu1.menu.itembynames(['edit', 'delete']).Caption := lang_stockcaption[Ord(sc_delete)];
  mainmenu1.menu.itembynames(['edit', 'selectall']).Caption := lang_stockcaption[Ord(
                                                               sc_Select_allhk)];
  mainmenu1.menu.itembynames(['edit', 'selecteditpage']).Caption := lang_xstockcaption[Ord(
                                                                    sc_select_edit_Page)];
  mainmenu1.menu.itembynames(['edit', 'copyatcursor']).Caption := lang_xstockcaption[Ord(
                                                                  sc_Copy_word_cursor)];
  mainmenu1.menu.itembynames(['edit', 'copylatex']).Caption := lang_xstockcaption[Ord(
                                                               sc_copy_latex)];
  mainmenu1.menu.itembynames(['edit', 'indent']).Caption := lang_xstockcaption[Ord(sc_indent)];
  mainmenu1.menu.itembynames(['edit', 'unindent']).Caption := lang_xstockcaption[Ord(sc_unindent)
                                                              ];
  mainmenu1.menu.itembynames(['target']).Caption        := lang_xstockcaption[Ord(sc_target)];
  mainmenu1.menu.itembynames(['target', 'environment']).Caption := lang_xstockcaption[Ord(
                                                                   sc_environment)];
  mainmenu1.menu.itembynames(['target', 'attachprocess']).Caption := lang_xstockcaption[Ord(
                                                                     sc_attachprocess)];
  mainmenu1.menu.itembynames(['target', 'attachtarget']).Caption := lang_xstockcaption[Ord(
                                                                    sc_attachtarget)];
  mainmenu1.menu.itembynames(['target', 'detachtarget']).Caption := lang_xstockcaption[Ord(
                                                                    sc_detachtarget)];
  mainmenu1.menu.itembynames(['target', 'download']).Caption := lang_xstockcaption[Ord(
                                                                sc_download)];

  item1 := mainmenu1.menu.itembynames(['tools']);
  if item1 <> nil then
    mainmenu1.menu.itembynames(['tools']).Caption := lang_stockcaption[Ord(sc_tools)];

  mainmenu1.menu.itembynames(['view']).Caption := lang_xstockcaption[Ord(sc_view)];
  mainmenu1.menu.itembynames(['view', 'panels']).Caption := lang_xstockcaption[Ord(sc_panels)];
  mainmenu1.menu.itembynames(['view', 'forcezorder']).Caption := lang_xstockcaption[Ord(
                                                                 sc_forcezorder)];
  mainmenu1.menu.itembynames(['view', 'source']).Caption := lang_xstockcaption[Ord(sc_source)];
  mainmenu1.menu.itembynames(['view', 'treelist']).Caption := lang_xstockcaption[Ord(sc_treelist)
                                                              ];
  mainmenu1.menu.itembynames(['view', 'messages']).Caption := lang_xstockcaption[Ord(sc_messages)
                                                              ];
  mainmenu1.menu.itembynames(['view', 'findresult']).Caption := lang_xstockcaption[Ord(
                                                                sc_findresult)];
  mainmenu1.menu.itembynames(['view', 'commander']).Caption := lang_xstockcaption[Ord(
                                                               sc_commander)];
  mainmenu1.menu.itembynames(['view', 'symbols']).Caption := lang_xstockcaption[Ord(sc_symbols)];
  mainmenu1.menu.itembynames(['view', 'watches']).Caption := lang_xstockcaption[Ord(sc_watches)];
  mainmenu1.menu.itembynames(['view', 'stack']).Caption := lang_xstockcaption[Ord(sc_stack)];
  mainmenu1.menu.itembynames(['view', 'threads']).Caption := lang_xstockcaption[Ord(sc_threads)];
  mainmenu1.menu.itembynames(['view', 'cpu']).Caption := lang_xstockcaption[Ord(sc_cpu)];
  mainmenu1.menu.itembynames(['view', 'assembler']).Caption := lang_xstockcaption[Ord(
                                                               sc_assembler)];
  mainmenu1.menu.itembynames(['view', 'memory']).Caption := lang_xstockcaption[Ord(sc_memory)];
  mainmenu1.menu.itembynames(['view', 'targetconsole']).Caption := lang_xstockcaption[Ord(
                                                                   sc_targetconsole)];
  mainmenu1.menu.itembynames(['view', 'breakpoints']).Caption := lang_xstockcaption[Ord(
                                                                 sc_breakpoints)];
  mainmenu1.menu.itembynames(['view', 'watchpoints']).Caption := lang_xstockcaption[Ord(
                                                                 sc_watchpoints)];
  mainmenu1.menu.itembynames(['view', 'toggleformunit']).Caption := lang_xstockcaption[Ord(
                                                                    sc_toggleformunit)];
  mainmenu1.menu.itembynames(['layout']).Caption := lang_xstockcaption[Ord(sc_layout)];
  mainmenu1.menu.itembynames(['syntax']).Caption := lang_xstockcaption[Ord(sc_syntax)];
  mainmenu1.menu.itembynames(['project']).Caption := lang_xstockcaption[Ord(sc_project)];
  mainmenu1.menu.itembynames(['project', 'make']).Caption := lang_xstockcaption[Ord(sc_make)];
  mainmenu1.menu.itembynames(['project', 'build']).Caption := lang_xstockcaption[Ord(sc_build)];
  x := 0;

  Inc(x);
  mainmenu1.menu.itembynames(['project', 'make' + IntToStr(x)]).Caption := 
                                                                           lang_xstockcaption[Ord
                                                                           (sc_make)] + ' &' +
                                                                           IntToStr(x);
  Inc(x);
  mainmenu1.menu.itembynames(['project', 'make' + IntToStr(x)]).Caption := 
                                                                           lang_xstockcaption[Ord
                                                                           (sc_make)] + ' &' +
                                                                           IntToStr(x);
  Inc(x);
  mainmenu1.menu.itembynames(['project', 'make' + IntToStr(x)]).Caption := 
                                                                           lang_xstockcaption[Ord
                                                                           (sc_make)] + ' &' +
                                                                           IntToStr(x);
  Inc(x);
  mainmenu1.menu.itembynames(['project', 'make' + IntToStr(x)]).Caption := 
                                                                           lang_xstockcaption[Ord
                                                                           (sc_make)] + ' &' +
                                                                           IntToStr(x);
  Inc(x);
  mainmenu1.menu.itembynames(['project', 'make' + IntToStr(x)]).Caption := 
                                                                           lang_xstockcaption[Ord
                                                                           (sc_make)] + ' &' +
                                                                           IntToStr(x);
  Inc(x);
  mainmenu1.menu.itembynames(['project', 'make' + IntToStr(x)]).Caption := 
                                                                           lang_xstockcaption[Ord
                                                                           (sc_make)] + ' &' +
                                                                           IntToStr(x);
  Inc(x);
  mainmenu1.menu.itembynames(['project', 'make' + IntToStr(x)]).Caption := 
                                                                           lang_xstockcaption[Ord
                                                                           (sc_make)] + ' &' +
                                                                           IntToStr(x);
  Inc(x);
  mainmenu1.menu.itembynames(['project', 'make' + IntToStr(x)]).Caption := 
                                                                           lang_xstockcaption[Ord
                                                                           (sc_make)] + ' &' +
                                                                           IntToStr(x);
  Inc(x);
  mainmenu1.menu.itembynames(['project', 'make' + IntToStr(x)]).Caption := 
                                                                           lang_xstockcaption[Ord
                                                                           (sc_make)] + ' &' +
                                                                           IntToStr(x);

  mainmenu1.menu.itembynames(['project', 'make0']).Caption := 
                                                              lang_xstockcaption[Ord(sc_make)] +
                                                              ' &0';

  mainmenu1.menu.itembynames(['project', 'abortmake']).Caption := lang_xstockcaption[Ord(
                                                                  sc_abortmake)];
  mainmenu1.menu.itembynames(['project', 'debugrun']).Caption  := lang_xstockcaption[Ord(
                                                                  sc_debugrun)];

  mainmenu1.menu.itembynames(['project', 'debugrun', 'continue']).Caption := 
                                                                             lang_modalresult[
                                                                             Ord(mr_continue)];

  mainmenu1.menu.itembynames(['project', 'debugrun', 'interrupt']).Caption := 

                                                                              lang_projectoptionscon
                                                                              [Ord(c_SIGINT)];

  mainmenu1.menu.itembynames(['project', 'debugrun', 'next']).Caption := 
                                                                         lang_xstockcaption[Ord(
                                                                         sc_next)];

  mainmenu1.menu.itembynames(['project', 'debugrun', 'reset']).Caption := lang_xstockcaption[Ord(
                                                                          sc_reset)];

  mainmenu1.menu.itembynames(['project', 'debugrun', 'step']).Caption := lang_xstockcaption[Ord(
                                                                         sc_cstep)];

  mainmenu1.menu.itembynames(['project', 'debugrun', 'stepinstruction']).Caption := 


                                                                                  lang_xstockcaption
                                                                                    [Ord(

                                                                                  sc_stepinstruction
                                                                                    )];

  mainmenu1.menu.itembynames(['project', 'debugrun', 'nextinstruction']).Caption := 


                                                                                  lang_xstockcaption
                                                                                    [Ord(

                                                                                  sc_nextinstruction
                                                                                    )];

  mainmenu1.menu.itembynames(['project', 'debugrun', 'restartdebugger']).Caption := 


                                                                                  lang_xstockcaption
                                                                                    [Ord(

                                                                                  sc_restartdebugger
                                                                                    )];

  mainmenu1.menu.itembynames(['project', 'debugrun', 'togglebreakpoint']).Caption := 


                                                                                  lang_xstockcaption
                                                                                     [Ord(

                                                                                 sc_togglebreakpoint
                                                                                     )];

  mainmenu1.menu.itembynames(['project', 'debugrun', 'tooglebreakpointenable']).Caption := 


                                                                                  lang_xstockcaption
                                                                                           [Ord(

                                                                           sc_tooglebreakpointenable
                                                                                           )];

  mainmenu1.menu.itembynames(['project', 'debugrun', 'finish']).Caption := 
                                                                           lang_xstockcaption[Ord
                                                                           (sc_finish)];

  mainmenu1.menu.itembynames(['project', 'debugrun', 'finish']).Caption := 
                                                                           lang_projectoptionscon[
                                                                           Ord(c_SIGABRT)];


  mainmenu1.menu.itembynames(['project', 'debugrun', 'breakpointson']).Caption := 

                                                                                  lang_xstockcaption
                                                                                  [Ord(
                                                                                  sc_breakpoints
                                                                                  )] + ' ' +
                                                                                  lang_stockcaption
                                                                                  [Ord(sc_on)];

  mainmenu1.menu.itembynames(['project', 'debugrun', 'watcheson']).Caption := 
                                                                              lang_xstockcaption[
                                                                              Ord(sc_watches)] +
                                                                              ' ' +
                                                                              lang_stockcaption[
                                                                              Ord(sc_on)];

  mainmenu1.menu.itembynames(['project', 'debugrun', 'execlinehinton']).Caption := 


                                                                                  lang_xstockcaption
                                                                                   [Ord(
                                                                                   sc_execlinehinton
                                                                                   )];

  mainmenu1.menu.itembynames(['project', 'options']).Caption := lang_xstockcaption[Ord(sc_options
                                                                )];
  mainmenu1.menu.itembynames(['project', 'tree']).Caption := lang_xstockcaption[Ord(sc_tree)];
  mainmenu1.menu.itembynames(['project', 'source']).Caption := lang_xstockcaption[Ord(sc_source)]
  ;
  mainmenu1.menu.itembynames(['project', 'opencopy']).Caption := lang_xstockcaption[Ord(
                                                                 sc_opencopy)];
  mainmenu1.menu.itembynames(['project', 'saveascopy']).Caption := lang_xstockcaption[Ord(
                                                                   sc_saveascopy)];
  mainmenu1.menu.itembynames(['project', 'new']).Caption := lang_stockcaption[Ord(sc_newfile)];
  mainmenu1.menu.itembynames(['project', 'open']).Caption := lang_stockcaption[Ord(sc_open)];
  mainmenu1.menu.itembynames(['project', 'save']).Caption := lang_stockcaption[Ord(sc_save)];
  mainmenu1.menu.itembynames(['project', 'saveas']).Caption := lang_xstockcaption[Ord(sc_saveas)]
  ;
  mainmenu1.menu.itembynames(['project', 'close']).Caption := lang_stockcaption[Ord(sc_close)];
  mainmenu1.menu.itembynames(['edited']).Caption        := lang_xstockcaption[Ord(sc_edited)];
  mainmenu1.menu.itembynames(['edited', 'make']).Caption := lang_xstockcaption[Ord(sc_make)];
  mainmenu1.menu.itembynames(['edited', 'build']).Caption := lang_xstockcaption[Ord(sc_build)];
  mainmenu1.menu.itembynames(['edited', 'abortmake']).Caption := lang_xstockcaption[Ord(
                                                                 sc_abortmake)];
  mainmenu1.menu.itembynames(['edited', 'run']).Caption := lang_xstockcaption[Ord(sc_debugrun)];
  mainmenu1.menu.itembynames(['edited', 'beautifier']).Caption := lang_xstockcaption[Ord(
                                                                  sc_beautifier)];

  x := 0;

  Inc(x);
  mainmenu1.menu.itembynames(['edited', 'make' + IntToStr(x)]).Caption := 
                                                                          lang_xstockcaption[Ord(
                                                                          sc_make)] + ' ' +
                                                                          IntToStr(x);
  Inc(x);
  mainmenu1.menu.itembynames(['edited', 'make' + IntToStr(x)]).Caption := 
                                                                          lang_xstockcaption[Ord(
                                                                          sc_make)] + ' ' +
                                                                          IntToStr(x);
  Inc(x);
  mainmenu1.menu.itembynames(['edited', 'make' + IntToStr(x)]).Caption := 
                                                                          lang_xstockcaption[Ord(
                                                                          sc_make)] + ' ' +
                                                                          IntToStr(x);
  Inc(x);
  mainmenu1.menu.itembynames(['edited', 'make' + IntToStr(x)]).Caption := 
                                                                          lang_xstockcaption[Ord(
                                                                          sc_make)] + ' ' +
                                                                          IntToStr(x);

  Inc(x);
  mainmenu1.menu.itembynames(['edited', 'make' + IntToStr(x)]).Caption := 
                                                                          lang_xstockcaption[Ord(
                                                                          sc_make)] + ' ' +
                                                                          IntToStr(x);
  Inc(x);
  mainmenu1.menu.itembynames(['edited', 'make' + IntToStr(x)]).Caption := 
                                                                          lang_xstockcaption[Ord(
                                                                          sc_make)] + ' ' +
                                                                          IntToStr(x);
  Inc(x);
  mainmenu1.menu.itembynames(['edited', 'make' + IntToStr(x)]).Caption := 

                                                                          lang_xstockcaption[Ord(
                                                                          sc_make)] + ' ' +
                                                                          IntToStr(x);

  Inc(x);
  mainmenu1.menu.itembynames(['edited', 'make' + IntToStr(x)]).Caption := 
                                                                          lang_xstockcaption[Ord(
                                                                          sc_make)] + ' ' +
                                                                          IntToStr(x);

  Inc(x);
  mainmenu1.menu.itembynames(['edited', 'make' + IntToStr(x)]).Caption := 
                                                                          lang_xstockcaption[Ord(
                                                                          sc_make)] + ' ' +
                                                                          IntToStr(x);

  mainmenu1.menu.itembynames(['edited', 'make0']).Caption := 
                                                             lang_xstockcaption[Ord(sc_make)] +
                                                             ' 0';

  mainmenu1.menu.itembynames(['edited', 'makeX']).Caption := 
                                                             lang_xstockcaption[Ord(sc_make)] +
                                                             ' X';

  mainmenu1.menu.itembynames(['edited', 'open']).Caption := lang_stockcaption[Ord(sc_open)];
  mainmenu1.menu.itembynames(['edited', 'save']).Caption := lang_stockcaption[Ord(sc_save)];
  mainmenu1.menu.itembynames(['edited', 'close']).Caption := lang_stockcaption[Ord(sc_close)];

  mainmenu1.menu.itembynames(['widgets']).Caption := lang_xstockcaption[Ord(sc_widgets)];

  mainmenu1.menu.itembynames(['widgets', 'fpgui', 'reset']).Caption := lang_xstockcaption[Ord(
                                                                       sc_reset)];

  mainmenu1.menu.itembynames(['widgets', 'fpgui', 'formdesigner']).Caption := 
                                                                              lang_mainform[Ord(
                                                                              ma_formdesigner)];

  mainmenu1.menu.itembynames(['widgets', 'msegui', 'msemod']).Caption := lang_xstockcaption[Ord(
                                                                         sc_msemod)];
  mainmenu1.menu.itembynames(['widgets', 'msegui', 'closeallmsemod']).Caption := 
                                                                                 lang_xstockcaption
                                                                                 [Ord(
                                                                                 sc_closeallmsemod
                                                                                 )];

  mainmenu1.menu.itembynames(['widgets', 'msegui', 'componentspalette']).Caption := 


                                                                                  lang_xstockcaption
                                                                                    [Ord(

                                                                                sc_componentspalette
                                                                                    )];

  mainmenu1.menu.itembynames(['widgets', 'msegui', 'componentsstore']).Caption := 

                                                                                  lang_actionsmodule
                                                                                  [Ord(
                                                                                  ac_storecomponent
                                                                                  )];

  mainmenu1.menu.itembynames(['widgets', 'msegui', 'objectinspector']).Caption := 

                                                                                  lang_actionsmodule
                                                                                  [Ord(
                                                                                  ac_objectinspector
                                                                                  )];

  mainmenu1.menu.itembynames(['widgets', 'msegui', 'toggleformunit']).Caption := 

                                                                                 lang_xstockcaption
                                                                                 [Ord(
                                                                                 sc_toggleformunit
                                                                                 )];

  mainmenu1.menu.itembynames(['widgets', 'msegui', 'findcomponent']).Caption := 

                                                                                lang_xstockcaption
                                                                                [Ord(
                                                                                sc_findcomponent
                                                                                )];

  mainmenu1.menu.itembynames(['settings']).Caption := lang_xstockcaption[Ord(sc_settings)];
  mainmenu1.menu.itembynames(['settings', 'generalsettings']).Caption := lang_xstockcaption[Ord(
                                                                         sc_generalsettings)];
  mainmenu1.menu.itembynames(['settings', 'extrasettings']).Caption := lang_xstockcaption[Ord(
                                                                       sc_extrasettings)];
  mainmenu1.menu.itembynames(['settings', 'lang']).Caption := lang_stockcaption[Ord(sc_lang)] +
                                                              '     (Lang)';
  mainmenu1.menu.itembynames(['settings', 'configwidgets']).Caption := 
                                                                       lang_xstockcaption[Ord(
                                                                       sc_configwidgets)];
  mainmenu1.menu.itembynames(['settings', 'configcompilers']).Caption := lang_xstockcaption[Ord(
                                                                         sc_configcompilers)];
  mainmenu1.menu.itembynames(['settings', 'configdebuggers']).Caption := lang_xstockcaption[Ord(
                                                                         sc_configdebuggers)];
  mainmenu1.menu.itembynames(['settings', 'themes']).Caption := lang_xstockcaption[Ord(sc_themes)
                                                                ];

  mainmenu1.menu.itembynames(['about']).Caption := lang_xstockcaption[Ord(sc_about)];

  if assigned(objectinspectorfo) then objectinspectorfo.caption := 
                                                                   lang_actionsmodule[Ord(
                                                                   ac_objectinspector)];

  if assigned(projecttreefo) then
    with projecttreefo do
      begin
        addunitfileact.Caption := lang_xstockcaption[Ord(sc_addunit)];
        removeunitfileact.Caption := lang_xstockcaption[Ord(sc_removeunit)];
        addfileact.Caption := lang_xstockcaption[Ord(sc_addfile)];
        removefileact.Caption := lang_xstockcaption[Ord(sc_removefile)];
        removecmoduleact.Caption := lang_xstockcaption[Ord(sc_removecmodule)];
        addcmoduleact.Caption := lang_xstockcaption[Ord(sc_addcmodule)];
        adddiract.Caption := lang_xstockcaption[Ord(sc_adddir)];
        removediract.Caption := lang_xstockcaption[Ord(sc_removedir)];
        editdiract.Caption := lang_xstockcaption[Ord(sc_editdir)];
      end;

  symbolfo.caption := lang_xstockcaption[Ord(sc_symbols)];
  symbolfo.tpopupmenu1.menu.itembynames(['deleteall']).Caption := 
                                                                  lang_xstockcaption[Ord(
                                                                  sc_deleteall)] ;
  
  stackfo.caption := lang_xstockcaption[Ord(sc_stack)];
   threadsfo.caption := lang_xstockcaption[Ord(sc_threads)];                                                                
 
  stackfo.tpopupmenu1.menu.itembynames(['copy']).Caption := 
                                                                  lang_stockcaption[Ord(
                                                                  sc_copy)] ;
 
  
  threadsfo.caption := lang_xstockcaption[Ord(sc_threads)];                                                                
  
  threadsfo.tpopupmenu1.menu.itembynames(['copy']).Caption := 
                                                                  lang_stockcaption[Ord(
                                                                  sc_copy)] ;
                                                                
  targetconsolefo.caption :=  lang_xstockcaption[Ord(sc_targetconsole)];
  //actionsmo.find.caption :=  lang_stockcaption[Ord(sc_search)];
  //actionsmo.repeatfind.caption :=  lang_stockcaption[Ord(sc_next)];
  //actionsmo.findback.caption :=  lang_stockcaption[Ord(sc_prior)];

  targetconsolefo.popupmen.menu.itembynames(['clear']).Caption := 
                                                                  lang_xstockcaption[Ord(sc_clear)]
  ;

  targetconsolefo.popupmen.menu.itembynames(['find']).Caption := 
                                                                 lang_stockcaption[Ord(sc_search)];

  targetconsolefo.popupmen.menu.itembynames(['findrepeat']).Caption := 
                                                                       lang_stockcaption[Ord(sc_next
                                                                       )];

  targetconsolefo.popupmen.menu.itembynames(['findback']).Caption := 
                                                                     lang_stockcaption[Ord(sc_prior)
                                                                     ];

  if assigned(messagefo) then
    with messagefo do
      begin
        tpopupmenu1.menu.itembynames(['copyall']).Caption := lang_xstockcaption[Ord(sc_copyall)];
        tpopupmenu1.menu.itembynames(['copyselected']).Caption := lang_xstockcaption[Ord(
                                                                  sc_copyselected)];
        tpopupmenu1.menu.itembynames(['copyline']).Caption := lang_xstockcaption[Ord(sc_copyline)];
        tpopupmenu1.menu.itembynames(['findinmessages']).Caption := lang_xstockcaption[Ord(
                                                                    sc_findinmessages)];
      end;

  if assigned(sourcefo) then
    with sourcefo do
      begin
        caption := lang_settings[Ord(se_groupsourceeditor)];
        tpopupmenu1.menu.itembynames(['selectpage']).Caption := 
                                                                lang_xstockcaption[Ord(
                                                                sc_select_edit_Page)];
        tpopupmenu1.menu.itembynames(['openfile']).Caption  := lang_stockcaption[Ord(sc_open)];
        tpopupmenu1.menu.itembynames(['savefile']).Caption  := lang_stockcaption[Ord(sc_save)];
        tpopupmenu1.menu.itembynames(['closefile']).Caption := lang_stockcaption[Ord(sc_close)];
        tpopupmenu1.menu.itembynames(['saveas']).Caption := lang_xstockcaption[Ord(sc_saveas)];
        tpopupmenu1.menu.itembynames(['showasform']).Caption := lang_xstockcaption[Ord(sc_showasform
                                                                )];
        tpopupmenu1.menu.itembynames(['delete']).Caption := lang_stockcaption[Ord(sc_delete)];
        tpopupmenu1.menu.itembynames(['undo']).Caption  := lang_stockcaption[Ord(sc_Undohk)];
        tpopupmenu1.menu.itembynames(['redo']).Caption  := lang_stockcaption[Ord(sc_Redohk)];
        tpopupmenu1.menu.itembynames(['copy']).Caption  := lang_stockcaption[Ord(sc_Copyhk)];
        tpopupmenu1.menu.itembynames(['cut']).Caption   := lang_stockcaption[Ord(sc_Cuthk)];
        tpopupmenu1.menu.itembynames(['paste']).Caption := lang_stockcaption[Ord(sc_pastehk)];
        tpopupmenu1.menu.itembynames(['selectall']).Caption := lang_stockcaption[Ord(
                                                               sc_Select_allhk)];
        tpopupmenu1.menu.itembynames(['copycursor']).Caption := lang_xstockcaption[Ord(
                                                                sc_Copy_word_cursor)];
        tpopupmenu1.menu.itembynames(['deleteword']).Caption   := lang_xstockcaption[Ord(
                                                                  sc_deletewordatcursor)];

        tpopupmenu1.menu.itembynames(['copylatex']).Caption := lang_xstockcaption[Ord(
                                                               sc_copy_latex)];
        tpopupmenu1.menu.itembynames(['indent']).Caption := lang_xstockcaption[Ord(sc_indent)];
        tpopupmenu1.menu.itembynames(['unindent']).Caption := lang_xstockcaption[Ord(sc_unindent)];

        tpopupmenu1.menu.itembynames(['lowercase']).Caption := lang_xstockcaption[Ord(sc_lowercase)]
        ;
        tpopupmenu1.menu.itembynames(['uppercase']).Caption := lang_xstockcaption[Ord(sc_uppercase)]
        ;

        tpopupmenu1.menu.itembynames(['comment']).Caption := lang_xstockcaption[Ord(sc_comment)];
        tpopupmenu1.menu.itembynames(['uncomment']).Caption := lang_xstockcaption[Ord(sc_uncomment)]
        ;

        tpopupmenu1.menu.itembynames(['convpas']).Caption := lang_xstockcaption[Ord(sc_convpas)];
        tpopupmenu1.menu.itembynames(['togglebreak']).Caption := lang_xstockcaption[Ord(
                                                                 sc_togglebreakpoint)];

        tpopupmenu1.menu.itembynames(['togglebkptend']).Caption := lang_xstockcaption[Ord(
                                                                   sc_tooglebreakpointenable)];

        tpopupmenu1.menu.itembynames(['editbreakpoint']).Caption := lang_xstockcaption[Ord(
                                                                    sc_editbreakpoint)];

        tpopupmenu1.menu.itembynames(['addwatch']).Caption := lang_xstockcaption[Ord(sc_addwatch)];
        tpopupmenu1.menu.itembynames(['editbreakpoint']).Caption := lang_xstockcaption[Ord(
                                                                    sc_editbreakpoint)];

        tpopupmenu1.menu.itembynames(['setbm']).Caption := lang_xstockcaption[Ord(sc_setbookmark)];
        tpopupmenu1.menu.itembynames(['findbookmark']).Caption := lang_xstockcaption[Ord(
                                                                  sc_findbookmark)];

        tpopupmenu1.menu.itembynames(['insgui']).Caption := lang_xstockcaption[Ord(sc_insgui)];
        tpopupmenu1.menu.itembynames(['insuid']).Caption := lang_xstockcaption[Ord(sc_insuid)];
        tpopupmenu1.menu.itembynames(['instempl']).Caption := lang_xstockcaption[Ord(sc_instempl)];
        tpopupmenu1.menu.itembynames(['completeclass']).Caption := lang_xstockcaption[Ord(
                                                                   sc_completeclass)];
      end;

  if Assigned(debuggerfo) then
    begin
      debuggerfo.find_in_directory.hint := lang_xstockcaption[Ord(sc_searchindirectories)];
      debuggerfo.line_number.hint       := lang_projectoptions[Ord(po_linenumbers)];
      debuggerfo.terminal_run.hint      := lang_projectoptions[Ord(po_showconsole)];
      debuggerfo.project_open.hint      := lang_xstockcaption[Ord(sc_openproject)];
      debuggerfo.open_file.hint         := lang_stockcaption[Ord(sc_openfile)];
      debuggerfo.save_file.hint         := lang_stockcaption[Ord(sc_save)];
      debuggerfo.code_beauty.hint       := lang_xstockcaption[Ord(sc_beautifier)];
      debuggerfo.procedure_list.hint    := lang_xstockcaption[Ord(sc_proclist)];
      debuggerfo.find_in_edit.hint      := lang_xstockcaption[Ord(sc_searchincurrentfile)];
      debuggerfo.project_save.hint      := lang_stockcaption[Ord(sc_save)];
      debuggerfo.project_option.hint    := lang_projectoptions[Ord(po_projectoptions)];
      debuggerfo.project_make.hint      := ' ' + lang_xstockcaption[Ord(sc_project)] +
                                           ' : ' + lang_xstockcaption[Ord(sc_make)] + ' ' +
                                           ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_start.hint     := ' ' + lang_xstockcaption[Ord(sc_project)] +
                                           ' : ' + lang_xstockcaption[Ord(sc_debugrun)] + ' ' +
                                           ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_save.hint      := ' ' + lang_xstockcaption[Ord(sc_project)] +
                                           ' : ' + lang_stockcaption[Ord(sc_save)] + ' ' +
                                           ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_interrupt.hint := ' ' + lang_xstockcaption[Ord(sc_project)] +
                                           ' : ' + lang_xstockcaption[Ord(sc_abortmake)] + ' ' +
                                           ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_next.hint      := ' ' + lang_xstockcaption[Ord(sc_project)] +
                                           ' : ' + lang_xstockcaption[Ord(sc_nextinstruction)] +
                                           ' ' + ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_step.hint      := ' ' + lang_xstockcaption[Ord(sc_project)] +
                                           ' : ' + lang_xstockcaption[Ord(sc_stepinstruction)] +
                                           ' ' + ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_finish.hint    := ' ' + lang_xstockcaption[Ord(sc_project)] +
                                           ' : ' + lang_xstockcaption[Ord(sc_finish)] + ' ' +
                                           ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_next_instruction.hint := ' ' + lang_xstockcaption[Ord(sc_project)] +
                                                  ' : ' + lang_xstockcaption[Ord(
                                                  sc_nextinstruction)] + ' ' +
                                                  lang_xstockcaption[Ord(sc_assembler)] + ' ' +
                                                  ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_step_instruction.hint := ' ' + lang_xstockcaption[Ord(sc_project)] +
                                                  ' : ' + lang_stockcaption[Ord(
                                                  sc_stepinstruction)] + ' ' +
                                                  lang_xstockcaption[Ord(sc_assembler)] + ' ' +
                                                  ExtractFilename(theprojectname) + ' ';
      debuggerfo.project_reset.hint     := ' ' + lang_xstockcaption[Ord(sc_project)] +
                                           ' : ' + lang_xstockcaption[Ord(sc_reset)] + ' ' +
                                           ExtractFilename(theprojectname) + ' ';
      debuggerfo.edited_make.hint       := ' ' + lang_xstockcaption[Ord(sc_edited)] +
                                           ' : ' + lang_xstockcaption[Ord(sc_make)] + ' ' +
                                           thefilename + ' ';
      debuggerfo.edited_run.hint        := ' ' + lang_xstockcaption[Ord(sc_edited)] +
                                           ' : ' + lang_xstockcaption[Ord(sc_debugrun)] + ' ' +
                                           thefilename + ' ';
      debuggerfo.toggle_form_unit.hint  := ' ' + lang_xstockcaption[Ord(sc_edited)] +
                                           ' : ' + lang_xstockcaption[Ord(sc_toggleformunit)] +
                                           ' ' + thefilename + ' ';

    end;

  conflangfo.gridlang.rowcount := length(lang_langnames);

  for x := 0 to length(lang_langnames) - 1 do
    begin
      conflangfo.gridlangcaption[x] := lang_langnames[x] ;
      str := trim(copy(lang_langnames[x], system.pos('[',lang_langnames[x]), 10));
      str :=  StringReplace(str, '[', '', [rfReplaceAll]);
      str :=  StringReplace(str, ']', '', [rfReplaceAll]);
      conflangfo.gridlangcode[x]    := str;
    end;

  if thelang = 'zh' then
    begin
      conflangfo.lsetasdefault.visible := true;
      conflangfo.lsetasdefault.Caption := lang_xstockcaption[Ord(sc_setasdefault)];
      conflangfo.setasdefault.frame.Caption := '';
    end
  else
    begin
      conflangfo.lsetasdefault.visible := false;
      conflangfo.lsetasdefault.Caption := '';
      conflangfo.setasdefault.frame.Caption := lang_xstockcaption[Ord(sc_setasdefault)];
    end;

  conflangfo.ok.Caption := lang_modalresult[Ord(mr_ok)];

  conflangfo.bpotools.Caption    := 'Po ' + lang_stockcaption[Ord(sc_tools)];

  conflangfo.Caption    := lang_stockcaption[Ord(sc_lang)];

  application.processmessages;

end;

procedure tmainfo.manfocreated(Const Sender: TObject);
begin
  TDummyThread.Create(False);
end;

procedure tmainfo.onbeauty(Const Sender: TObject);
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

  // setstattext(lang_mainform[ord(ma_makeok)], mtk_finished);

  if typetheme = 0 then
    begin
      color0 := cl_white;
      color1 := cl_dkgray;
      color2 := cl_black;
      color3 := cl_white;

      basedock.face.template           := convex;
      basedock.dragdock.splitter_color := cl_ltgray;

      debuggerfo.color          := cl_gray;
      debuggerfo.basedock.color := cl_gray;

      color          := cl_gray;
      basedock.color := cl_gray;

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

      debuggerfo.color          := cl_dkgray;
      debuggerfo.basedock.color := cl_dkgray;

      color          := cl_dkgray;
      basedock.color := cl_dkgray;

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

procedure tmainfo.onclassic(Const Sender: TObject);
begin
  themenr := 0;
  dotheme(0);
  // setstattext('Light theme is set.', mtk_flat);
end;

procedure tmainfo.ondark(Const Sender: TObject);
begin
  themenr := 1;
  dotheme(1);
  // setstattext('Dark theme is set.', mtk_flat);
end;

procedure tmainfo.ontoggleunitform(Const Sender: TObject);
begin
  actionsmo.toggleformunitonexecute(Sender);
end;

procedure tmainfo.onlang(Const Sender: TObject);
var 
  x: integer;
begin

  for x := 0 to conflangfo.gridlang.rowcount - 1 do
    if MSEFallbackLang = conflangfo.gridlangcode[x] then
      conflangfo.gridlangbool[x] := True
    else
      conflangfo.gridlangbool[x] := False;

  conflangloaded := 1;

  if ismodal then
    conflangfo.Show(True)
  else
    begin
      conflangfo.Show;
      conflangfo.bringtofront;
    end;
end;

procedure tmainfo.onactiv(Const Sender: TObject);
var 
  x: integer;
  oldlang : msestring;
begin
  if isactivated = False then
    begin
      isactivated        := True;
      conflangfo.Visible := False;
      oldlang := MSEFallbackLang;

      if conflangfo.setasdefault.Value = True then
        begin
          for x := 0 to conflangfo.gridlang.rowcount - 1 do
            if conflangfo.gridlangbool[x] = True then
              MSEFallbackLang := conflangfo.gridlangcode[x];

          if oldlang <> MSEFallbackLang then setlangideu(MSEFallbackLang);
        end
      else setlangideu(MSEFallbackLang);
    end;
end;

procedure tmainfo.ontemplateeditor(Const Sender: TObject);
begin
  application.createform(ttemplateeditorfo, templateeditorfo);
  templateeditorfo.Show;
end;

procedure tmainfo.runtimer(Const sender: TObject);
begin
  if isactivated = False then
    loadconfigform(Sender);
end;


end.
