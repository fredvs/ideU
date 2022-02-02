unit actionsmodule;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
{$ifdef linux}{$define unix}{$endif}

interface

uses
 mseconsts,msestockobjects,captionideu,Classes,mseclasses,mseact,msetabs,
 mseactions,msebitmap,msestrings,msegui,commandorform,dialogfiles,msefileutils,
 msedatamodules,mseglob,msestat,msegraphics,msegraphutils,mseguiglob,msemenus,
 msesys,msesysutils,msesimplewidgets,projecttreeform,msestringcontainer,
 targetconsole,mclasses,mseificomp,mseificompglob,mseifiglob, msetypes;

type
  tactionsmo = class(tmsedatamodule)
    buttonicons: timagelist;

    opensource: taction;
    saveall: taction;
    saveas: taction;
    save: taction;
    Close: taction;
    closeall: taction;

    reset: taction;
    interrupt: taction;
    Next: taction;
    step: taction;
    finish: taction;
    continue: taction;
    //   run: taction;

    line: taction;
    find: taction;
    repeatfind: taction;
    findinfile: taction;

    indent: taction;
    nexti: taction;
    stepi: taction;
    bluedotsonact: taction;
    replace: taction;
    print: taction;
    detachtarget: taction;
    attachprocess: taction;
    lowercase: taction;
    uppercase: taction;
    toggleformunit: taction;
    unindent: taction;
    undo: taction;
    redo: taction;
    cut: taction;
    copy: taction;
    paste: taction;
    Delete: taction;

    togglebkpt: taction;
    togglebkptenable: taction;
    bkptsonact: taction;
    watchesonact: taction;

    abortmakeact: taction;
    makeact: taction;
    selecteditpage: taction;

    run: taction;
    //common
    shortcuts: tshortcutcontroller;
    toggleinspector: taction;
    buildact: taction;
    make1act: taction;
    make2act: taction;
    make3act: taction;
    make4act: taction;
    download: taction;
    helpact: taction;
    attachtarget: taction;
    setbm0: taction;
    findbm0: taction;
    findbm1: taction;
    setbm1: taction;
    findbm2: taction;
    setbm2: taction;
    findbm3: taction;
    setbm3: taction;
    findbm4: taction;
    setbm4: taction;
    findbm5: taction;
    setbm5: taction;
    findbm6: taction;
    setbm6: taction;
    findbm7: taction;
    setbm7: taction;
    findbm8: taction;
    setbm8: taction;
    findbm9: taction;
    setbm9: taction;
    setbmnone: taction;
    instemplate: taction;
    projectopenact: taction;
    projectoptionsact: taction;
    projecttreeact: taction;
    projectsourceact: taction;

    projectsaveact: taction;
    projectcloseact: taction;
    copylatexact: taction;
    findcompact: taction;
    findcompallact: taction;
    forcezorderact: taction;

    tool0: taction;
    tool1: taction;
    tool2: taction;
    tool3: taction;
    tool4: taction;
    tool5: taction;
    tool6: taction;
    tool7: taction;
    tool8: taction;
    tool9: taction;

    customrun: taction;
    assistive: taction;
    customcompil: taction;
    projectcompile: taction;
    projectcustomcompile: taction;
    custmakemenu: taction;
    customsave: taction;
    comment: taction;
    uncomment: taction;
    copyword: taction;
    selectall: taction;

    savecust: taction;
    findback: taction;
    procedurelist: taction;
    deleteword: taction;
    selectword: taction;
   c: tstringcontainer;
    procedure findinfileonexecute(const Sender: TObject);

    //file
    procedure opensourceactonexecute(const Sender: TObject);
    procedure saveactonexecute(const Sender: TObject);
    procedure saveasactonexecute(const Sender: TObject);
    procedure saveallactonexecute(const Sender: TObject);
    procedure closeactonexecute(const Sender: TObject);
    procedure closeallactonexecute(const Sender: TObject);

    //editor
    procedure seleclallactonexecute(const Sender: TObject);
    procedure pasteactonexecute(const Sender: TObject);
    procedure deleteactonexecute(const Sender: TObject);
    procedure selecteditpageonexecute(const Sender: TObject);
    procedure undoactonexecute(const Sender: TObject);
    procedure redoactonexecute(const Sender: TObject);
    procedure copyactonexecute(const Sender: TObject);
    procedure cutactonexecute(const Sender: TObject);

    procedure indentonexecute(const Sender: TObject);
    procedure unindentonexecute(const Sender: TObject);
    procedure lowercaseexecute(const Sender: TObject);
    procedure uppercaseexecute(const Sender: TObject);
    procedure enableonselect(const Sender: tcustomaction);

    procedure lineactonexecute(const Sender: TObject);
    procedure findactonexecute(const Sender: TObject);
    procedure repeatfindactonexecute(const Sender: TObject);
    procedure replaceactonexecute(const Sender: TObject);

    procedure togglebreakpointexe(const Sender: TObject);
    procedure togglebkptenableactonexecute(const Sender: TObject);
    procedure toggleformunitonexecute(const Sender: TObject);

    //make
    procedure makeactonexecute(const Sender: TObject);
    procedure abortmakeactonexecute(const Sender: TObject);

    // fred
    // assistive
    procedure assistiveactonexecute(const Sender: TObject);

    procedure runcustom(const Sender: TObject);

    // Setup ready
    procedure setupcustom;

    // Setup ready from menu
    procedure setupcustommenu(const Sender: TObject);

    procedure initproject;

    // custom is finish
    procedure finishcustom;

    // Project cust compile
    procedure custcompileproject(const Sender: TObject);

    // Custom compile
    procedure compilecustom(const Sender: TObject);

    // Custom compile
    procedure compilecustommenu(const Sender: TObject);

    // Project compile
    procedure compileproject(const Sender: TObject);

    procedure savecustom(const Sender: TObject);

    // Graeme procedurelist
    procedure procedurelistonexecute(const Sender: TObject);

    //debugger
    procedure resetactonexecute(const Sender: TObject);
    procedure interruptactonexecute(const Sender: TObject);
    procedure continueactonexecute(const Sender: TObject);
    procedure nextactonexecute(const Sender: TObject);
    procedure finishactonexecute(const Sender: TObject);
    procedure stepactonexecute(const Sender: TObject);
    procedure stepiactonexecute(const Sender: TObject);
    procedure nextiactonexecute(const Sender: TObject);
    procedure bkptsononexecute(const Sender: TObject);
    procedure watchesononexecute(const Sender: TObject);
    procedure bluedotsononchange(const Sender: TObject);
    procedure printactonexecute(const Sender: TObject);
    procedure ondetachtarget(const Sender: TObject);
    procedure onattachprocess(const Sender: TObject);
    procedure updateshortcuts(const Sender: tshortcutcontroller);
    procedure downloadexe(const Sender: TObject);
    procedure helpex(const Sender: TObject);
    procedure onattachtarget(const Sender: TObject);
    procedure setbmexec(const Sender: TObject);
    procedure findbmexec(const Sender: TObject);
    procedure instemplateactonexecute(const Sender: TObject);
    procedure projectopenexe(const Sender: TObject);
    procedure projectoptionsexe(const Sender: TObject);
    procedure projecttreeexe(const Sender: TObject);
    procedure projectsourceexe(const Sender: TObject);
    procedure projectsaveexe(const Sender: TObject);
    procedure projectcloeseexe(const Sender: TObject);
    procedure creadstateexe(const Sender: TObject);
    procedure findupdateexe(const Sender: tcustomaction);
    procedure copylatexactonexecute(const Sender: TObject);
    procedure findcompexe(const Sender: TObject);
    procedure findcompallexe(const Sender: TObject);
    procedure forcezorderexe(const Sender: TObject);
    procedure commentonexecute(const Sender: TObject);
    procedure uncommentonexecute(const Sender: TObject);
    procedure enablecomment(const Sender: tcustomaction);
    procedure enableuncomment(const Sender: tcustomaction);
    procedure selectwordactiononexecute(const Sender: TObject);
    procedure findbackonexecute(const Sender: TObject);
    procedure ondeleteword(const Sender: TObject);
    procedure onselectword(const Sender: TObject);
  private
    function filterfindcomp(const acomponent: TComponent): Boolean;
  public
    function gettoolshortcutaction(const index: int32; out act: taction): Boolean;

  end;

var
  actionsmo: tactionsmo;
  iscompiling: Boolean = False;

procedure configureide;

implementation

uses
  plugmanager,
  confdebugger,
  conffpgui,
  main,
  make,
  actionsmodule_mfm,
  sourceform,
  sourcepage,
  msedesigner,
  msefiledialogx,
  projectoptionsform,
  findinfileform,
  breakpointsform,
  watchform,
  selecteditpageform,
  disassform,
  printform,
  msegdbutils,
  mseintegerenter,
  ideusettings,
  confideu,
  finddialogform,
  componentstore,
  cpuform,
  SysUtils,
  msecomptree,
  procedurelistform;

procedure configureide;
begin
  disassfo.resetshortcuts();
  if editsettings(lang_actionsmodule[ord(ac_configureideu)],
    actionsmo.shortcuts) then
  begin
    mainfo.mainstatfile.writestat();
    expandprojectmacros();
  end;
end;

{ tactionsmo }

procedure tactionsmo.procedurelistonexecute(const Sender: TObject);
begin
if (sourcefo.ActivePage <> nil)
then
begin

  if not plformcreated then
    doProcedureList;


  procedurelistfo.font.Height := confideufo.fontsize.Value;
  procedurelistfo.font.Name   := ansistring(confideufo.fontname.Value);

  procedurelistfo.edtSearch.Width      := (procedurelistfo.Width div 2) - 40;
  procedurelistfo.cbObjects.Width      := procedurelistfo.edtSearch.Width;
  procedurelistfo.cbObjects.left       := procedurelistfo.edtSearch.right + 20;
  procedurelistfo.grdProcedures.top    := procedurelistfo.cbObjects.bottom + 10;
  procedurelistfo.grdProcedures.Height := procedurelistfo.Height -
    procedurelistfo.cbObjects.bottom - 14;

  if mainfo.ismodal then
    procedurelistfo.Show(True)
  else
  begin
    procedurelistfo.Show;
    procedurelistfo.bringtofront;
  end;
 end; 
end;

function tactionsmo.gettoolshortcutaction(const index: int32; out act: taction): Boolean;
begin
  case index of
    0: act   := tool0;
    1: act   := tool1;
    2: act   := tool2;
    3: act   := tool3;
    4: act   := tool4;
    5: act   := tool5;
    6: act   := tool6;
    7: act   := tool7;
    8: act   := tool8;
    9: act   := tool9;
    else act := nil;
  end;
  Result := act <> nil;
end;

procedure tactionsmo.updateshortcuts(const Sender: tshortcutcontroller);
begin
  undo.shortcut         := sysshortcuts[sho_groupundo];
  undo.shortcut1        := sysshortcuts1[sho_groupundo];
  redo.shortcut         := sysshortcuts[sho_groupredo];
  redo.shortcut1        := sysshortcuts1[sho_groupredo];
  copy.shortcut         := sysshortcuts[sho_copy];
  copy.shortcut1        := sysshortcuts1[sho_copy];
  cut.shortcut          := sysshortcuts[sho_cut];
  cut.shortcut1         := sysshortcuts1[sho_cut];
  paste.shortcut        := sysshortcuts[sho_paste];
  paste.shortcut1       := sysshortcuts1[sho_paste];
  selectall.shortcut    := sysshortcuts[sho_selectall];
  selectall.shortcut1   := sysshortcuts1[sho_selectall];
  findcompact.shortcut  := find.shortcut;
  findcompact.shortcut1 := find.shortcut1;
  findcompallact.shortcut := find.shortcut;
  findcompallact.shortcut1 := find.shortcut1;
end;

procedure tactionsmo.findbackonexecute(const Sender: TObject);
begin
  if targetconsolefo.activeentered then
    targetconsolefo.findback
  else
    sourcefo.ActivePage.findback;
end;

//common
procedure tactionsmo.findinfileonexecute(const Sender: TObject);
begin
  dofindinfile;
end;

// assistive
procedure tactionsmo.assistiveactonexecute(const Sender: TObject);
begin
  doassistive;
end;

//file

procedure tactionsmo.opensourceactonexecute(const Sender: TObject);
begin
  with mainfo do
  begin
    debuggerfo.project_history.tag := 2;
    opensource(fk_source, False);
  end;
end;


procedure tactionsmo.saveactonexecute(const Sender: TObject);
begin
  with mainfo do
    if factivedesignmodule <> nil then
    begin
      designer.saveformfile(factivedesignmodule, factivedesignmodule^.filename, True);
      updatemodifiedforms;
    end
    else
      sourcefo.saveactivepage;
  if (thesdef <> '') and
    (thesdef <> projectoptions.e.t.syntaxdeffiles[0]) and
    (theactivepage = sourcefo.ActivePage.filepath +
    sourcefo.ActivePage.filename) then
    sdefload(thesdef);

  sourcefo.updatehinttab;
end;

procedure tactionsmo.savecustom(const Sender: TObject);
var
  sysfilename: msestring;
begin
if (sourcefo.ActivePage <> nil) then
begin
  saveactonexecute(Sender);
  if (conffpguifo.enablefpguidesigner.Value = True) then
  begin
    sysfilename := tosysfilepath(filepath(sourcefo.ActivePage.filename, fk_file, True));
    LoadfpgDesigner(ansistring(sysfilename));
  end;
  sourcefo.activate;
  sourcefo.updatehinttab;
end;  
end;

procedure tactionsmo.saveasactonexecute(const Sender: TObject);
var
  namebefore, str1: filenamety;
  po1: pmoduleinfoty;
begin
  with mainfo do
  begin
    openfile.controller.icon        := icon;
    openfile.controller.showoptions := True;

    openfile.controller.captionsave := lang_xstockcaption[ord(sc_saveas)];
   
       if factivedesignmodule <> nil then
    begin
      str1 := factivedesignmodule^.filename;
      if openfile.controller.Execute(str1, fdk_save) then
        designer.saveformfile(factivedesignmodule, str1, True);
    end
    else
    begin
      str1       := sourcefo.ActivePage.filepath;
      namebefore := str1;
      openfile.controller.showoptions := True;

      if openfile.controller.Execute(str1, fdk_save) then
      begin
        sourcefo.saveactivepage(str1);
        po1 := designer.modules.findmodule(designer.sourcenametoformname(namebefore));
        if po1 <> nil then
        begin
          str1          := designer.sourcenametoformname(str1);
          designer.saveformfile(po1, str1, True);
          po1^.filename := str1;
          updatemodifiedforms;
        end;
      end;
    end;
  end;
end;

procedure tactionsmo.saveallactonexecute(const Sender: TObject);
begin
  with mainfo do
  begin
    sourcefo.saveall(True);
    designer.saveall(True, True);
    componentstorefo.saveall(True);
    saveprojectoptions;
    updatemodifiedforms;
  end;
  if (thesdef <> '') and
    (thesdef <> projectoptions.e.t.syntaxdeffiles[0]) and
    (theactivepage = sourcefo.ActivePage.filepath +
    sourcefo.ActivePage.filename) then
    sdefload(thesdef);
end;

procedure tactionsmo.closeactonexecute(const Sender: TObject);
begin
  with mainfo do
  begin
    layoutbusy := True;
    if factivedesignmodule <> nil then
    begin
      if closemodule(factivedesignmodule, True) then
        factivedesignmodule := nil;
    end
    else
      sourcefo.closeactivepage;
    layoutbusy := False;
  end;
end;

procedure tactionsmo.closeallactonexecute(const Sender: TObject);
begin
  with mainfo do
  begin
    layoutbusy := True;
    closeall(False);
    layoutbusy := False;
  end;
end;

//editor
procedure tactionsmo.seleclallactonexecute(const Sender: TObject);
begin
  sourcefo.ActivePage.edit.selectall();
end;

procedure tactionsmo.pasteactonexecute(const Sender: TObject);
begin
  sourcefo.ActivePage.edit.paste;
end;

procedure tactionsmo.deleteactonexecute(const Sender: TObject);
begin
  sourcefo.ActivePage.edit.deleteselection;
end;

procedure tactionsmo.selecteditpageonexecute(const Sender: TObject);
begin
  selecteditpageform.selecteditpage;
end;

procedure tactionsmo.toggleformunitonexecute(const Sender: TObject);
begin
if (sourcefo.ActivePage <> nil) then
begin
  mainfo.toggleformunit;
  //tabcloser := False;
end;  
end;


// fred

procedure tactionsmo.initproject;
begin
  debuggerfo.project_abort_compil.Enabled := True;
  debuggerfo.project_abort_compil.face.image.alignment :=
    [al_stretchx, al_stretchy];

end;

procedure tactionsmo.finishcustom;
begin
  iscompiling := False;

  debuggerfo.project_abort_compil.Enabled := False;
  debuggerfo.project_abort_compil.face.image.alignment :=
    [al_grayed, al_stretchx, al_stretchy];

  //  debuggerfo.imagebut.getimage(12, debuggerfo.project_abort_compil.face.image);

  debuggerfo.project_make.Enabled := True;
  debuggerfo.project_make.face.image.alignment :=
    [al_stretchx, al_stretchy];

  //  debuggerfo.imagebut.getimage(0, debuggerfo.project_make.face.image);

  debuggerfo.project_reset.Enabled := False;

  debuggerfo.project_reset.face.image.alignment :=
    [al_grayed, al_stretchx, al_stretchy];

  debuggerfo.edited_abort.Enabled := False;


  debuggerfo.edited_abort.face.image.alignment :=
    [al_grayed, al_stretchx, al_stretchy];

  debuggerfo.project_interrupt.Enabled := False;

  debuggerfo.project_interrupt.face.image.alignment :=
    [al_grayed, al_stretchx, al_stretchy];


  debuggerfo.edited_make.Enabled := True;

  debuggerfo.edited_make.face.image.alignment :=
    [al_stretchx, al_stretchy];

  debuggerfo.edited_run.Enabled := True;

  debuggerfo.edited_run.face.image.alignment :=
    [al_stretchx, al_stretchy];
end;

procedure tactionsmo.compileproject(const Sender: TObject);
begin

  iscompiling := True;
  debuggerfo.project_make.Enabled := False;

  debuggerfo.project_make.face.image.alignment :=
    [al_grayed, al_stretchx, al_stretchy];

  //debuggerfo.imagebut.getimage(1, debuggerfo.project_make.face.image);

  debuggerfo.project_abort_compil.Enabled := True;
  //debuggerfo.imagebut.getimage(11, debuggerfo.project_abort_compil.face.image);

  debuggerfo.project_abort_compil.face.image.alignment :=
    [al_stretchx, al_stretchy];

  case debuggerfo.project_options.Value of
    'M':
    begin
      domake(1);
      mainfo.thetag := 1;
    end;
    'B':
    begin
      domake(2);
      mainfo.thetag := 2;
    end;
    '1':
    begin
      domake(4);
      mainfo.thetag := 4;
    end;
    '2':
    begin
      domake(8);
      mainfo.thetag := 8;
    end;
    '3':
    begin
      domake(16);
      mainfo.thetag := 16;
    end;
    '4':
    begin
      domake(32);
      mainfo.thetag := 32;
    end;
    '5':
    begin
      domake(64);
      mainfo.thetag := 64;
    end;
    '6':
    begin
      domake(128);
      mainfo.thetag := 128;
    end;
    '7':
    begin
      domake(256);
      mainfo.thetag := 256;
    end;
    '8':
    begin
      domake(512);
      mainfo.thetag := 512;
    end;
    '9':
    begin
      domake(1024);
      mainfo.thetag := 1024;
    end;
    '0':
    begin
      domake(2048);
      mainfo.thetag := 2048;
    end;
  end;
  mainfo.resetstartcommand;
end;

// Project cust compile
procedure tactionsmo.custcompileproject(const Sender: TObject);
begin
  if theprojectname <> '' then
begin
  saveallactonexecute(Sender);
  compileproject(Sender);
end;  
end;

procedure tactionsmo.setupcustom;
begin
  debuggerfo.edited_make.Enabled := False;

  debuggerfo.edited_make.face.image.alignment :=
    [al_grayed, al_stretchx, al_stretchy];


  debuggerfo.edited_abort.Enabled := True;

  debuggerfo.edited_abort.face.image.alignment :=
    [al_stretchx, al_stretchy];

  debuggerfo.edited_run.Enabled := False;

  debuggerfo.edited_run.face.image.alignment :=
    [al_grayed, al_stretchx, al_stretchy];

  case debuggerfo.edit_compiler.Value of
    'Pascal': mainfo.settypecompiler := 1;
    'Java': mainfo.settypecompiler   := 2;
    'C': mainfo.settypecompiler      := 3;
    'Python': mainfo.settypecompiler := 4;
    'Other': mainfo.settypecompiler  := 5;
  end;

  mainfo.setcompiler := debuggerfo.edit_compilernum.Value + 1;

  case debuggerfo.edit_options.Value of
    'M': mainfo.customoption := 1;
    'B': mainfo.customoption := 2;
    '1': mainfo.customoption := 4;
    '2': mainfo.customoption := 8;
    '3': mainfo.customoption := 16;
    '4': mainfo.customoption := 32;
    '5': mainfo.customoption := 64;
    '6': mainfo.customoption := 128;
    '7': mainfo.customoption := 256;
    '8': mainfo.customoption := 512;
    '9': mainfo.customoption := 1024;
    '0': mainfo.customoption := 2048;
    'X': mainfo.customoption := 0;
  end;

end;

procedure tactionsmo.compilecustom(const Sender: TObject);
begin
if (sourcefo.ActivePage <> nil) then
begin
  saveactonexecute(Sender);
  setupcustom;
  mainfo.customcompile(Sender);
end;  
end;

procedure tactionsmo.setupcustommenu(const Sender: TObject);
begin
  debuggerfo.edited_make.Enabled := False;

  debuggerfo.edited_make.face.image.alignment :=
    [al_grayed, al_stretchx, al_stretchy];

  debuggerfo.edited_abort.Enabled := True;
  debuggerfo.edited_run.Enabled   := False;

  debuggerfo.edited_run.face.image.alignment :=
    [al_grayed, al_stretchx, al_stretchy];

  debuggerfo.edited_abort.face.image.alignment :=
    [al_stretchx, al_stretchy];


  case debuggerfo.edit_compiler.Value of
    'Pascal': mainfo.settypecompiler := 1;
    'Java': mainfo.settypecompiler   := 2;
    'C': mainfo.settypecompiler      := 3;
    'Python': mainfo.settypecompiler := 4;
    'Other': mainfo.settypecompiler  := 5;
  end;

  mainfo.setcompiler := debuggerfo.edit_compilernum.Value + 1;

  case tmenuitem(Sender).tag of
    0: mainfo.customoption  := 1;
    1: mainfo.customoption  := 2;
    2: mainfo.customoption  := 4;
    3: mainfo.customoption  := 8;
    4: mainfo.customoption  := 16;
    5: mainfo.customoption  := 32;
    6: mainfo.customoption  := 64;
    7: mainfo.customoption  := 128;
    8: mainfo.customoption  := 256;
    9: mainfo.customoption  := 512;
    10: mainfo.customoption := 1024;
    11: mainfo.customoption := 2048;
    12: mainfo.customoption := 0;
  end;

end;

procedure tactionsmo.compilecustommenu(const Sender: TObject);
begin
  saveactonexecute(Sender);
  setupcustommenu(Sender);
  mainfo.customcompile(Sender);
end;

procedure tactionsmo.runcustom(const Sender: TObject);
begin
if (sourcefo.ActivePage <> nil) then
begin
  mainfo.customrun(Sender);
end;  
end;

procedure tactionsmo.undoactonexecute(const Sender: TObject);
begin
  sourcefo.ActivePage.doundo;
end;

procedure tactionsmo.redoactonexecute(const Sender: TObject);
begin
  sourcefo.ActivePage.doredo;
end;

procedure tactionsmo.copyactonexecute(const Sender: TObject);
begin
  sourcefo.ActivePage.edit.copyselection;
end;

procedure tactionsmo.copylatexactonexecute(const Sender: TObject);
begin
  sourcefo.ActivePage.copylatex;
end;

procedure tactionsmo.cutactonexecute(const Sender: TObject);
begin
  sourcefo.ActivePage.edit.cutselection;
end;

procedure tactionsmo.indentonexecute(const Sender: TObject);
begin
  if confideufo.usedefaulteditoroptions.Value then
    sourcefo.ActivePage.edit.indent(confideufo.blockindent.Value,
      confideufo.tabindent.Value)
  else
    sourcefo.ActivePage.edit.indent(projectoptions.e.blockindent,
      projectoptions.e.tabindent);
end;

procedure tactionsmo.unindentonexecute(const Sender: TObject);
begin
  if confideufo.usedefaulteditoroptions.Value then
    sourcefo.ActivePage.edit.unindent(confideufo.blockindent.Value)
  else
    sourcefo.ActivePage.edit.unindent(projectoptions.e.blockindent);
end;

procedure tactionsmo.lowercaseexecute(const Sender: TObject);
begin
  sourcefo.ActivePage.edit.lowercase;
end;

procedure tactionsmo.uppercaseexecute(const Sender: TObject);
begin
  sourcefo.ActivePage.edit.uppercase;
end;

procedure tactionsmo.enablecomment(const Sender: tcustomaction);
begin
  // enableonselect(sender);
  // sender.enabled:= sender.enabled and  sourcefo.activepage.cancomment();
end;

procedure tactionsmo.selectwordactiononexecute(const Sender: TObject);
begin
  sourcefo.ActivePage.copywordatcursor();
end;

procedure tactionsmo.ondeleteword(const Sender: TObject);
begin
  sourcefo.ActivePage.selectwordatcursor();
  sourcefo.ActivePage.edit.deleteselection;
end;

procedure tactionsmo.enableuncomment(const Sender: tcustomaction);
begin
  enableonselect(Sender);
  Sender.Enabled := Sender.Enabled and sourcefo.ActivePage.canuncomment();
end;

procedure tactionsmo.commentonexecute(const Sender: TObject);
begin
  sourcefo.ActivePage.commentselection();
end;

procedure tactionsmo.uncommentonexecute(const Sender: TObject);
begin
  sourcefo.ActivePage.uncommentselection();
end;

procedure tactionsmo.enableonselect(const Sender: tcustomaction);
begin
  Sender.Enabled := (sourcefo.ActivePage <> nil) and
    sourcefo.ActivePage.edit.hasselection;
end;

procedure tactionsmo.lineactonexecute(const Sender: TObject);
begin
  if lineformcreated then
    linefo.bringtofront
  else
    integerenter(fgototheline, 1, sourcefo.ActivePage.source_editor.rowcount,
      lang_sourceform[ord(sf_gotoline)], lang_sourceform[ord(sf_findline)]);
  linefo.font.Height := confideufo.fontsize.Value;
  linefo.font.Name   := ansistring(confideufo.fontname.Value);
  // sourcefo.activepage.doline;
end;

procedure tactionsmo.findactonexecute(const Sender: TObject);
begin
  if targetconsolefo.activeentered then
    targetconsolefo.dofind
  else if findformcreated then
    finddialogfo.bringtofront
  else
    finddialogexecute(findinfos)// sourcefo.activepage.dofind;
  ;
end;

procedure tactionsmo.repeatfindactonexecute(const Sender: TObject);
begin
  if targetconsolefo.activeentered then
    targetconsolefo.repeatfind
  else
    sourcefo.ActivePage.repeatfind;
end;

procedure tactionsmo.replaceactonexecute(const Sender: TObject);
begin
  sourcefo.ActivePage.doreplace;
end;

procedure tactionsmo.togglebreakpointexe(const Sender: TObject);
begin
  sourcefo.ActivePage.togglebreakpoint;
end;

procedure tactionsmo.togglebkptenableactonexecute(const Sender: TObject);
begin
   sourcefo.ActivePage.togglebreakpointenabled;
end;

procedure tactionsmo.instemplateactonexecute(const Sender: TObject);
begin
  sourcefo.ActivePage.inserttemplate;
end;


//make

procedure tactionsmo.abortmakeactonexecute(const Sender: TObject);
begin
  make.abortmake;
end;

procedure tactionsmo.makeactonexecute(const Sender: TObject);
begin
  with mainfo do
  begin
    if Sender is tmenuitem then
    begin
      domake(tmenuitem(Sender).tag);
      thetag := tmenuitem(Sender).tag;
    end
    else
    begin
      domake(0);
      thetag := 0;
    end;
    resetstartcommand;
  end;
end;

//debugger

procedure tactionsmo.resetactonexecute(const Sender: TObject);
begin
  with mainfo do
  begin
    gdb.abort;
    killtarget; //if running
    programfinished;
    setstattext('');
    startgdb(False);
  end;
end;

procedure tactionsmo.interruptactonexecute(const Sender: TObject);
begin
  with mainfo do
    gdb.interrupt;
end;

procedure tactionsmo.continueactonexecute(const Sender: TObject);
var
  str3: msestring;
  int1, int2, int3: integer;
begin
  nodebugset := False;
  str3       := gettargetfile;//to initialize
  str3       := '';
  if not fileexists(tosysfilepath(msestring(gettargetfile))) then
    mainfo.setstattext(tosysfilepath(gettargetfile) +
        ' ' + lang_actionsmodule[ord(ac_doesnotexist)] + '  ' + 
      lang_xstockcaption[ord(sc_compileitfirst)]  , mtk_error)

  else
  begin

    mainfo.terminategdbserver(True);

    if debuggerfo.debug_on.tag = 0 then
      str3 := ''
    else
    begin

      /// fred debugger

      str3 := '';

      case debuggerfo.project_options.Value of
        'M': mainfo.thetag := 1;
        'B': mainfo.thetag := 2;
        '1': mainfo.thetag := 4;
        '2': mainfo.thetag := 8;
        '3': mainfo.thetag := 16;
        '4': mainfo.thetag := 32;
        '5': mainfo.thetag := 64;
        '6': mainfo.thetag := 128;
        '7': mainfo.thetag := 256;
        '8': mainfo.thetag := 512;
        '9': mainfo.thetag := 1024;
        '0': mainfo.thetag := 2048;
      end;

      with projectoptions, o, texp do
        for int3 := 0 to high(debuggerused) do
          if (mainfo.thetag and debuggerusedon[int3] <> 0) and
            (debuggerused[int3] <> '') then
            str3 := str3 + debuggerused[int3];

      if str3 = 'None' then
      begin
        str3       := '';
        nodebugset := True;
      end;

      if (pos('Default', str3) > 0) then
        str3 := 'Default Debugger'
      else
      if (str3 = 'Debugger 1') then
        str3 := quotefilename(tosysfilepath(confdebuggerfo.debugger1.Value))
      else
      if (str3 = 'Debugger 2') then
        str3 := quotefilename(tosysfilepath(confdebuggerfo.debugger2.Value))
      else
      if (str3 = 'Debugger 3') then
        str3 := quotefilename(tosysfilepath(confdebuggerfo.debugger3.Value))
      else
      if (str3 = 'Debugger 4') then
        str3 := (quotefilename(tosysfilepath(confdebuggerfo.debugger4.Value)))
      else
        str3 := '';

    end;

    // mainfo.setstattext(str + ' = ' +str3, mtk_flat);
    // application.processmessages;
    // sleep(10000);

    int1 := 1;

    with projectoptions, o, texp do
      for int2 := 0 to high(compilerused) do
        if (mainfo.thetag and compilerusedon[int2] <> 0) then
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
      with mainfo do
        if checkremake(sc_continue) then
        begin
          cpufo.beforecontinue;
          gdb.continue;
        end;
    end
    else
      mainfo.runwithoutdebugger;
  end;
end;


procedure tactionsmo.stepactonexecute(const Sender: TObject);
begin
  gettargetfile;//to initialize

 
   if not fileexists(tosysfilepath(msestring(gettargetfile))) then
    mainfo.setstattext(tosysfilepath(gettargetfile) +
        ' ' + lang_actionsmodule[ord(ac_doesnotexist)] + ' .  ' + 
      lang_xstockcaption[ord(sc_compileitfirst)]  , mtk_error)
  
  else
    with mainfo do
      if checkremake(sc_step) then
        gdb.step;
end;

procedure tactionsmo.stepiactonexecute(const Sender: TObject);
begin
  gettargetfile;//to initializez

 if not fileexists(tosysfilepath(msestring(gettargetfile))) then
    mainfo.setstattext(tosysfilepath(gettargetfile) +
        ' ' + lang_actionsmodule[ord(ac_doesnotexist)] + '  ' + 
      lang_xstockcaption[ord(sc_compileitfirst)]  , mtk_error)

  else
    with mainfo do
      if checkremake(sc_step) then
        gdb.stepi;
end;

procedure tactionsmo.nextactonexecute(const Sender: TObject);
begin
  if not fileexists(tosysfilepath(msestring(gettargetfile))) then
    mainfo.setstattext(tosysfilepath(gettargetfile) +
        ' ' + lang_actionsmodule[ord(ac_doesnotexist)] + '  ' + 
      lang_xstockcaption[ord(sc_compileitfirst)]  , mtk_error)

  else
    with mainfo do
      if checkremake(sc_step) then
        gdb.Next;
end;

procedure tactionsmo.nextiactonexecute(const Sender: TObject);
begin
  if not fileexists(tosysfilepath(msestring(gettargetfile))) then
    mainfo.setstattext(tosysfilepath(gettargetfile) +
        ' ' + lang_actionsmodule[ord(ac_doesnotexist)] + '  ' + 
      lang_xstockcaption[ord(sc_compileitfirst)]  , mtk_error)

  else
    with mainfo do
      if checkremake(sc_step) then
        gdb.nexti;
end;

procedure tactionsmo.finishactonexecute(const Sender: TObject);
begin
  with mainfo do
    if checkremake(sc_continue) then
      gdb.finish;
end;

procedure tactionsmo.bkptsononexecute(const Sender: TObject);
begin
  // debuggerfo.break_point.value := bkptsonact.checked;
  breakpointsfo.bkptson.Value := bkptsonact.Checked;
end;

procedure tactionsmo.watchesononexecute(const Sender: TObject);
begin
  //debuggerfo.watches.value := watchesonact.checked;
  watchfo.watcheson.Value := watchesonact.Checked;
end;

procedure tactionsmo.bluedotsononchange(const Sender: TObject);
begin
  // debuggerfo.hints.value := bluedotsonact.checked;
  mainfo.checkbluedots;
end;

procedure tactionsmo.printactonexecute(const Sender: TObject);
begin
  printform.print;
end;

procedure tactionsmo.ondetachtarget(const Sender: TObject);
begin
  if mainfo.checkgdberror(mainfo.gdb.detach) then
    mainfo.startgdb(False);
end;

procedure tactionsmo.onattachprocess(const Sender: TObject);
var
  int1: integer;
  info: stopinfoty;
begin
  with mainfo do
  begin
    int1 := 0;
    if integerenter(int1, minint, maxint, lang_actionsmodule[ord(ac_processid)],
      lang_actionsmodule[ord(ac_attachtoprocess)]) = mr_ok then
    begin
      setstattext(lang_actionsmodule[ord(ac_attachingprocess)] + ' ' + UTF8Decode(IntToStr(int1)), mtk_making);
      application.ProcessMessages;
      startgdb(False);
      gdb.attach(int1, info);
      loadexec(True, False);
      refreshstopinfo(info);
    end;
  end;
end;

procedure tactionsmo.onattachtarget(const Sender: TObject);
var
  info: stopinfoty;
begin
  with mainfo do
  begin
    startgdb(False);
    if checkgdberror(gdb.filesymbol(gettargetfile)) and
      startgdbconnection(True) then
    begin
      gdb.attachtarget(info);
      loadexec(True, False);
      refreshstopinfo(info);
    end;
  end;
end;

procedure tactionsmo.downloadexe(const Sender: TObject);
begin
  mainfo.loadexec(False, True);
end;

procedure tactionsmo.helpex(const Sender: TObject);
begin
  application.help(application.activewidget);
end;

procedure tactionsmo.setbmexec(const Sender: TObject);
begin
  sourcefo.setbmexec(Sender);
end;

procedure tactionsmo.findbmexec(const Sender: TObject);
begin
  sourcefo.findbmexec(Sender);
end;

procedure tactionsmo.projectopenexe(const Sender: TObject);
var
  fna1: filenamety;
begin
  debuggerfo.project_history.tag := 1;
  if projectfiledialog(fna1, False) = mr_ok then
  begin
    mainfo.openproject(fna1);
    mainfo.activate;
    sourcefo.updatehinttab;
  end;
end;

procedure tactionsmo.projectoptionsexe(const Sender: TObject);
begin
if theprojectname <> '' then
begin
  editprojectoptions;
end;  
end;

procedure tactionsmo.projecttreeexe(const Sender: TObject);
begin
  projecttreefo.activate;
end;

procedure tactionsmo.projectsourceexe(const Sender: TObject);
begin
  sourcefo.openfile(projectoptions.o.texp.mainfile, True);
end;

procedure tactionsmo.projectsaveexe(const Sender: TObject);
begin
if theprojectname <> '' then
begin

  if projectoptions.projectfilename = '' then
    mainfo.saveprojectasonexecute(Sender)
  else
    mainfo.saveproject(projectoptions.projectfilename);
    
 end;   
end;

procedure tactionsmo.projectcloeseexe(const Sender: TObject);
begin
  mainfo.closeprojectactonexecute(Sender);
end;

procedure tactionsmo.creadstateexe(const Sender: TObject);
begin
  msegdbutils.localizetext;
end;

procedure tactionsmo.findupdateexe(const Sender: tcustomaction);
begin
  if targetconsolefo.activeentered then
  begin
    find.Enabled       := True;
    repeatfind.Enabled := projectoptions.targetconsolefindinfo.Text <> '';
  end
  else
  begin
    find.Enabled       := (sourcefo.ActivePage <> nil);
    //and sourcefo.activepage.activeentered;
    repeatfind.Enabled := find.Enabled and
      (projectoptions.findreplaceinfo.find.Text <> '');
  end;
  findback.Enabled := repeatfind.Enabled;
  findcompallact.Enabled := find.Enabled;
end;

procedure tactionsmo.findcompexe(const Sender: TObject);
begin
  if mainfo.factivedesignmodule <> nil then
    mainfo.factivedesignmodule^.designformintf.findcompdialog();
end;

function tactionsmo.filterfindcomp(const acomponent: TComponent): Boolean;
begin
  Result := not (cssubcomponent in acomponent.componentstyle) and
    (not (acomponent is twidget) or
    (ws_iswidget in twidget(acomponent).widgetstate));
end;

procedure tactionsmo.findcompallexe(const Sender: TObject);
var
  name1: msestring;
  comp1: TComponent;
  po1: pmoduleinfoty;
begin
  name1 := '';
  with designer do
  begin
    if selections.Count > 0 then
      name1 := UTF8Decode(ownernamepath(selections[0]));
    if compnamedialog(designer.getcomponentnametree(nil, True, True, nil, @filterfindcomp, nil), name1, True) = mr_ok then
    begin
      replacechar1(name1, ':', '.');
      comp1 := designer.getcomponent(ansistring(name1), po1);
      designer.showformdesigner(po1);
      designer.selectcomponent(comp1);
    end;
  end;
end;

procedure tactionsmo.forcezorderexe(const Sender: TObject);
begin
  if projectoptions.o <> nil then
  begin
    projectoptions.o.forcezorder := taction(Sender).Checked;
    projectoptionsmodified();
  end;
end;

procedure tactionsmo.onselectword(const Sender: TObject);
begin
  sourcefo.ActivePage.selectwordatcursor();
end;

end.

