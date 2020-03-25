unit actionsmodule;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
{$ifdef linux}{$define unix}{$endif}

interface
uses
 classes,mseclasses,mseact,mseactions,msebitmap,msestrings,msegui,commandorform,
 dialogfiles,msefileutils,msedatamodules,mseglob,msestat,msegraphics,
 msegraphutils,mseguiglob,msemenus,msesys, msesysutils,msesimplewidgets,
 projecttreeform,msestringcontainer,targetconsole,mclasses,mseificomp,
 mseificompglob,mseifiglob;

type
 stringconsts = (
  ac_configureide, //0 Configure ideU
  ac_processid,       //1 Process ID
  ac_attachtoprocess, //2 Attach to process
  ac_unknownmodclass, //3 Unknown moduleclass for "
  ac_inheritedcomp,   //4 Inherited component "
  ac_cannotdel,       //5 " can not be deleted.
  ac_error,           //6 ERROR
  ac_makeaborted,     //7 Make aborted.
  ac_downloadaborted, //8 Download aborted.
  ac_runerrorwith,    //9 Runerror with "
  ac_errortimeout,    //10 Error: Timeout.
  ac_making,          //11 Making.
  ac_makenotrunning,  //12 Make not running.
  ac_downloading,     //13 Downloading.
  ac_downloadnotrunning, //14 Download not running.
  ac_running,         //15 " running.
  ac_script,         //16 Script
  ac_recursiveforminheritance, //17 Recursive form inheritance of "
  ac_component,      //18 Component "
  ac_exists,         //19 " exists.
  ac_ancestorfor,    //20 Ancestor for "
  ac_notfound,       //21 " not found.
  ac_module,         //22 Module "
  ac_invalidname,    //23 Invalid name "
  ac_invalidmethodname, //24 Invalid methodname
  ac_modulenotfound, //25 Module not found
  ac_methodnotfound, //26 Method not found
  ac_publishedmeth,  //27 Published (managed) method
  ac_doesnotexist,   //28 does not exist.
  ac_wishdelete,     //29 Do you wish to delete the event?
  ac_warning,        //30 WARNING
  ac_method,         //31 Method
  ac_differentparams,   //32 has different parameters.
  ac_amodule,        //33 A module "
  ac_isopen,         //34 " is already open.
  ac_unresolvedref,   //35 Unresolved reference(s) to
  ac_modules,        //36 Module(s):
  ac_cannotreadform, //37 Can not read formfile "
  ac_invalidcompname,//38 Invalid component name.
  ac_invalidexception, //39 Invalid exception
  ac_tools,           //40 T&ools
  ac_forms,           //41 Forms
  ac_source,          //42 Source
  ac_allfiles,        //43 All Files
  ac_program,         //44 Program
  ac_unit,            //45 Unit
  ac_textfile,        //46 Textfile
  ac_mainform,        //47 Mainform
  ac_simpleform,      //48 Simple Form
  ac_dockingform,     //49 Docking Form
  ac_datamodule,      //50 Datamodule
  ac_subform,         //51 Subform
  ac_scrollboxform,   //52 Scrollboxform
  ac_tabform,         //53 Tabform
  ac_dockpanel,       //54 Dockpanel
  ac_report,          //55 Report
  ac_scriptform,      //56 Scriptform
  ac_inheritedform,   //57 Inherited Form
  ac_replacesettings, //58 Do you want to replace the settings by
  ac_file,            //59 File "
  ac_wantoverwrite,   //60 Do you want to overwrite?
  ac_sr_unknown,      //61 Unknown
  ac_sr_error,        //62 Error
  ac_sr_startup,      //63 Startup
  ac_sr_exception,    //64 Exception
  ac_sr_gdbdied,      //65 GDB died
  ac_sr_breakpoint_hit,           //66 Breakpoint hit
  ac_sr_watchpointtrigger,        //67 Watchpoint triggered
  ac_sr_readwatchpointtrigger,    //68 Read Watchpoint triggered
  ac_sr_accesswatchpointtrigger,  //69 Access Watchpoint triggered
  ac_sr_end_stepping_range,       //70 End stepping range
  ac_sr_function_finished,        //71 Function finished
  ac_sr_exited_normally,          //72 Exited normally
  ac_sr_exited,                   //73 Exited
  ac_sr_detached,                 //74 Detached
  ac_sr_signal_received,          //75 Signal received
  ac_stoperror,                   //76 Stop error
  ac_cannotreadproject,           //77 Can not read project
  ac_about,                       //78 About
  ac_objectinspector,             //79 Object Inspector
  ac_storecomponent,              //80 Store Component
  ac_attachingprocess,            //81 Attaching Process
  ac_loading                      //82 Loading
 );

type
 tactionsmo = class(tmsedatamodule)
   buttonicons: timagelist;

   opensource: taction;
   saveall: taction;
   saveas: taction;
   save: taction;
   close: taction;
   closeall: taction;

   reset: taction;
   interrupt: taction;
   next: taction;
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
   delete: taction;

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
   c: tstringcontainer;
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
   procedure findinfileonexecute(const sender: tobject);

    //file
   procedure opensourceactonexecute(const sender: tobject);
   procedure saveactonexecute(const sender: tobject);
   procedure saveasactonexecute(const sender: TObject);
   procedure saveallactonexecute(const sender: tobject);
   procedure closeactonexecute(const sender: tobject);
   procedure closeallactonexecute(const sender: tobject);

   //editor
   procedure seleclallactonexecute(const sender: TObject);
   procedure pasteactonexecute(const sender: tobject);
   procedure deleteactonexecute(const sender: tobject);
   procedure selecteditpageonexecute(const sender: TObject);
   procedure undoactonexecute(const sender: tobject);
   procedure redoactonexecute(const sender: tobject);
   procedure copyactonexecute(const sender: tobject);
   procedure cutactonexecute(const sender: tobject);

   procedure indentonexecute(const sender: TObject);
   procedure unindentonexecute(const sender: TObject);
   procedure lowercaseexecute(const sender: TObject);
   procedure uppercaseexecute(const sender: TObject);
   procedure enableonselect(const sender: tcustomaction);

   procedure lineactonexecute(const sender: TObject);
   procedure findactonexecute(const sender: tobject);
   procedure repeatfindactonexecute(const sender: tobject);
   procedure replaceactonexecute(const sender: TObject);

   procedure togglebreakpointexe(const sender: TObject);
   procedure togglebkptenableactonexecute(const sender: TObject);
   procedure toggleformunitonexecute(const sender: TObject);

   //make
   procedure makeactonexecute(const sender: tobject);
   procedure abortmakeactonexecute(const sender: tobject);

   // fred
    // assistive
   procedure assistiveactonexecute(const sender: tobject);

   procedure runcustom(const sender: TObject);

   // Setup ready
   procedure setupcustom ;

   // Setup ready from menu
   procedure setupcustommenu(const sender: TObject);

   procedure initproject ;

      // custom is finish
   procedure finishcustom;

   // Project cust compile
   procedure custcompileproject(const sender: TObject);

   // Custom compile
   procedure compilecustom(const sender: TObject);

   // Custom compile
   procedure compilecustommenu(const sender: TObject);

   // Project compile
   procedure compileproject(const sender: TObject);

   procedure savecustom(const sender: tobject);

   // Graeme procedurelist
   procedure procedurelistonexecute(const sender: TObject);

   //debugger
   procedure resetactonexecute(const sender: tobject);
   procedure interruptactonexecute(const sender: tobject);
   procedure continueactonexecute(const sender: tobject);
   procedure nextactonexecute(const sender: tobject);
   procedure finishactonexecute(const sender: tobject);
   procedure stepactonexecute(const sender: tobject);
   procedure stepiactonexecute(const sender: TObject);
   procedure nextiactonexecute(const sender: TObject);
   procedure bkptsononexecute(const sender: TObject);
   procedure watchesononexecute(const sender: TObject);
   procedure bluedotsononchange(const sender: TObject);
   procedure printactonexecute(const sender: TObject);
   procedure ondetachtarget(const sender: TObject);
   procedure onattachprocess(const sender: TObject);
   procedure updateshortcuts(const sender: tshortcutcontroller);
   procedure downloadexe(const sender: TObject);
   procedure helpex(const sender: TObject);
   procedure onattachtarget(const sender: TObject);
   procedure setbmexec(const sender: TObject);
   procedure findbmexec(const sender: TObject);
   procedure instemplateactonexecute(const sender: TObject);
   procedure projectopenexe(const sender: TObject);
   procedure projectoptionsexe(const sender: TObject);
   procedure projecttreeexe(const sender: TObject);
   procedure projectsourceexe(const sender: TObject);
   procedure projectsaveexe(const sender: TObject);
   procedure projectcloeseexe(const sender: TObject);
   procedure creadstateexe(const sender: TObject);
   procedure findupdateexe(const sender: tcustomaction);
   procedure copylatexactonexecute(const sender: TObject);
   procedure findcompexe(const sender: TObject);
   procedure findcompallexe(const sender: TObject);
   procedure forcezorderexe(const sender: TObject);
   procedure commentonexecute(const sender: TObject);
   procedure uncommentonexecute(const sender: TObject);
   procedure enablecomment(const sender: tcustomaction);
   procedure enableuncomment(const sender: tcustomaction);
   procedure selectwordactiononexecute(const sender: TObject);
   procedure findbackonexecute(const sender: TObject);

  private
   function filterfindcomp(const acomponent: tcomponent): boolean;
 public
   function gettoolshortcutaction(const index: int32;
                                       out act: taction): boolean;

end;

var
 actionsmo: tactionsmo;

procedure configureide;

implementation
uses
plugmanager, confdebugger, conffpgui, main,make,actionsmodule_mfm,sourceform,sourcepage,msedesigner,msetypes,msefiledialog,
 projectoptionsform,findinfileform,breakpointsform,watchform,selecteditpageform,
 disassform,printform,msegdbutils,mseintegerenter,ideusettings, confideu, finddialogform,
 componentstore,cpuform,sysutils,msecomptree, procedurelistform;

procedure configureide;
begin
 disassfo.resetshortcuts();
 if editsettings(actionsmo.c[ord(ac_configureide)],
                                      actionsmo.shortcuts) then begin
  mainfo.mainstatfile.writestat();
  expandprojectmacros();
 end;
end;

{ tactionsmo }

procedure tactionsmo.procedurelistonexecute(const sender: TObject);
begin
if not plformcreated then doProcedureList;
end;

function tactionsmo.gettoolshortcutaction(const index: int32;
                                        out act: taction): boolean;
begin
 case index of
  0: act:= tool0;
  1: act:= tool1;
  2: act:= tool2;
  3: act:= tool3;
  4: act:= tool4;
  5: act:= tool5;
  6: act:= tool6;
  7: act:= tool7;
  8: act:= tool8;
  9:act:= tool9;
  else act:= nil;
 end;
 result:= act <> nil;
end;

procedure tactionsmo.updateshortcuts(const sender: tshortcutcontroller);
begin
 undo.shortcut:= sysshortcuts[sho_groupundo];
 undo.shortcut1:= sysshortcuts1[sho_groupundo];
 redo.shortcut:= sysshortcuts[sho_groupredo];
 redo.shortcut1:= sysshortcuts1[sho_groupredo];
 copy.shortcut:= sysshortcuts[sho_copy];
 copy.shortcut1:= sysshortcuts1[sho_copy];
 cut.shortcut:= sysshortcuts[sho_cut];
 cut.shortcut1:= sysshortcuts1[sho_cut];
 paste.shortcut:= sysshortcuts[sho_paste];
 paste.shortcut1:= sysshortcuts1[sho_paste];
 selectall.shortcut:= sysshortcuts[sho_selectall];
 selectall.shortcut1:= sysshortcuts1[sho_selectall];
 findcompact.shortcut:= find.shortcut;
 findcompact.shortcut1:= find.shortcut1;
 findcompallact.shortcut:= find.shortcut;
 findcompallact.shortcut1:= find.shortcut1;
end;

procedure tactionsmo.findbackonexecute(const sender: TObject);
begin
 if targetconsolefo.activeentered then begin
  targetconsolefo.findback;
 end
 else begin
  sourcefo.activepage.findback;
 end;
end;

//common
procedure tactionsmo.findinfileonexecute(const sender: tobject);
begin
 dofindinfile;
end;

// assistive
  procedure tactionsmo.assistiveactonexecute(const sender: tobject);
  begin
  doassistive ;
  end;

//file

procedure tactionsmo.opensourceactonexecute(const sender: tobject);
begin
 with mainfo do begin
  debuggerfo.project_history.tag := 2;
  opensource(fk_source,false);
 end;
end;


procedure tactionsmo.saveactonexecute(const sender: tobject);
begin
 with mainfo do begin
  if factivedesignmodule <> nil then begin
   designer.saveformfile(factivedesignmodule,factivedesignmodule^.filename,true);
   updatemodifiedforms;
    end
  else begin
   sourcefo.saveactivepage;
  end;
 end;
 if (thesdef <> '') and
  (thesdef <> projectoptions.e.t.syntaxdeffiles[0]) and
 (theactivepage = sourcefo.activepage.filepath +
 sourcefo.activepage.filename)
  then sdefload(thesdef);

    sourcefo.updatehinttab;
end;

procedure tactionsmo.savecustom(const sender: tobject);
var
 sysfilename : msestring;
begin
saveactonexecute(sender);
   if (conffpguifo.enablefpguidesigner.value = true) then
 begin
   sysfilename := tosysfilepath(filepath(sourcefo.activepage.filename,fk_file,true));
     LoadfpgDesigner(AnsiString(sysfilename));
 end;
 sourcefo.activate;
 sourcefo.updatehinttab;
 end;

procedure tactionsmo.saveasactonexecute(const sender: TObject);
var
 namebefore,str1: filenamety;
 po1: pmoduleinfoty;
begin
 with mainfo do begin
  if factivedesignmodule <> nil then begin
   str1:= factivedesignmodule^.filename;
   if openfile.controller.execute(str1,fdk_save) then begin
    designer.saveformfile(factivedesignmodule,str1,true);
   end;
  end
  else begin
   str1:= sourcefo.activepage.filepath;
   namebefore:= str1;
   if openfile.controller.execute(str1,fdk_save) then begin
    sourcefo.saveactivepage(str1);
    po1:= designer.modules.findmodule(designer.sourcenametoformname(namebefore));
    if po1 <> nil then begin
     str1:= designer.sourcenametoformname(str1);
     designer.saveformfile(po1,str1,true);
     po1^.filename:= str1;
     updatemodifiedforms;
    end;
   end;
  end;
 end;
end;

procedure tactionsmo.saveallactonexecute(const sender: tobject);
begin
 with mainfo do begin
  sourcefo.saveall(true);
  designer.saveall(true,true);
  componentstorefo.saveall(true);
  saveprojectoptions;
  updatemodifiedforms;
 end;
 if (thesdef <> '') and
 (thesdef <> projectoptions.e.t.syntaxdeffiles[0])
  and
 (theactivepage = sourcefo.activepage.filepath +
 sourcefo.activepage.filename)
  then sdefload(thesdef);
end;

procedure tactionsmo.closeactonexecute(const sender: tobject);
begin
 with mainfo do begin
  if factivedesignmodule <> nil then begin
   if closemodule(factivedesignmodule,true) then begin
    factivedesignmodule:= nil;
   end;
  end
  else begin
   sourcefo.closeactivepage;
  end;
 end;
end;

procedure tactionsmo.closeallactonexecute(const sender: tobject);
begin
 with mainfo do begin
  closeall(false);
 end;
end;

//editor
procedure tactionsmo.seleclallactonexecute(const sender: TObject);
begin
 sourcefo.activepage.edit.selectall();
end;

procedure tactionsmo.pasteactonexecute(const sender: tobject);
begin
 sourcefo.activepage.edit.paste;
end;

procedure tactionsmo.deleteactonexecute(const sender: tobject);
begin
 sourcefo.activepage.edit.deleteselection;
end;

procedure tactionsmo.selecteditpageonexecute(const sender: TObject);
begin
 selecteditpageform.selecteditpage;
end;

procedure tactionsmo.toggleformunitonexecute(const sender: TObject);
begin
 mainfo.toggleformunit;
end;


// fred

procedure tactionsmo.initproject ;
begin
debuggerfo.project_abort_compil.enabled := true;
end;

procedure tactionsmo.finishcustom ;
begin
  debuggerfo.project_abort_compil.enabled := false;
  debuggerfo.project_make.enabled := true;
  debuggerfo.project_reset.enabled := false;
  debuggerfo.edited_abort.enabled := false ;
  debuggerfo.project_interrupt.enabled := false;
  debuggerfo.edited_make.enabled := true;
  debuggerfo.edited_run.enabled := true;
end;

procedure tactionsmo.compileproject(const sender: TObject);
begin
debuggerfo.project_make.enabled := false;
debuggerfo.project_abort_compil.enabled := true;

case debuggerfo.project_options.value of
  'M' : begin
  domake(1) ;
   mainfo.thetag := 1;
  end;
   'B' : begin
  domake(2) ;
   mainfo.thetag := 2;
  end;
   '1' : begin
  domake(4) ;
   mainfo.thetag := 4;
  end;
    '2' : begin
  domake(8) ;
   mainfo.thetag := 8;
  end;
     '3' : begin
  domake(16) ;
   mainfo.thetag := 16;
  end;
   '4' : begin
  domake(32) ;
   mainfo.thetag := 32;
  end;
   '5' : begin
  domake(64) ;
   mainfo.thetag := 64;
  end;
    '6' : begin
  domake(128) ;
   mainfo.thetag := 128;
  end;
    '7' : begin
  domake(256) ;
   mainfo.thetag := 256;
  end;
     '8' : begin
  domake(512) ;
   mainfo.thetag := 512;
  end;
   '9' : begin
  domake(1024) ;
   mainfo.thetag := 1024;
  end;
   '0' : begin
  domake(2048) ;
   mainfo.thetag := 2048;
  end;
  end;
   mainfo.resetstartcommand;
 end;

 // Project cust compile
   procedure tactionsmo.custcompileproject(const sender: TObject);
begin
saveallactonexecute(sender);
compileproject(sender);
end;

procedure tactionsmo.setupcustom ;
begin
   debuggerfo.edited_make.enabled := false;
  debuggerfo.edited_abort.enabled := true;
  debuggerfo.edited_run.enabled := false;

    case debuggerfo.edit_compiler.value of
  'Pascal' : mainfo.settypecompiler := 1 ;
  'Java'   : mainfo.settypecompiler := 2 ;
  'C'      : mainfo.settypecompiler := 3 ;
  'Python' : mainfo.settypecompiler := 4 ;
  'Other'  : mainfo.settypecompiler := 5 ;
    end;

  mainfo.setcompiler := debuggerfo.edit_compilernum.value + 1;

   case debuggerfo.edit_options.value of
  'M' : mainfo.customoption := 1 ;
   'B' : mainfo.customoption := 2 ;
   '1' : mainfo.customoption := 4 ;
    '2' : mainfo.customoption := 8 ;
     '3' : mainfo.customoption := 16 ;
   '4' : mainfo.customoption := 32 ;
    '5' : mainfo.customoption := 64 ;
   '6' : mainfo.customoption := 128 ;
    '7' : mainfo.customoption := 256 ;
    '8' : mainfo.customoption := 512 ;
   '9' : mainfo.customoption := 1024 ;
    '0' : mainfo.customoption := 2048 ;
    'X' : mainfo.customoption := 0 ;
  end;

end;

procedure tactionsmo.compilecustom(const sender: TObject);
begin
saveactonexecute(sender);
setupcustom ;
mainfo.customcompile(sender);
end;

procedure tactionsmo.setupcustommenu(const sender: TObject) ;
begin
   debuggerfo.edited_make.enabled := false;
  debuggerfo.edited_abort.enabled := true;
  debuggerfo.edited_run.enabled := false;

     case debuggerfo.edit_compiler.value of
  'Pascal' : mainfo.settypecompiler := 1 ;
  'Java'   : mainfo.settypecompiler := 2 ;
  'C'      : mainfo.settypecompiler := 3 ;
  'Python' : mainfo.settypecompiler := 4 ;
  'Other'  : mainfo.settypecompiler := 5 ;
    end;

  mainfo.setcompiler := debuggerfo.edit_compilernum.value + 1;

   case tmenuitem(sender).tag of
  0 : mainfo.customoption := 1 ;
   1 : mainfo.customoption := 2 ;
   2 : mainfo.customoption := 4 ;
    3 : mainfo.customoption := 8 ;
     4 : mainfo.customoption := 16 ;
   5 : mainfo.customoption := 32 ;
    6 : mainfo.customoption := 64 ;
   7 : mainfo.customoption := 128 ;
    8 : mainfo.customoption := 256 ;
     9 : mainfo.customoption := 512 ;
   10 : mainfo.customoption := 1024 ;
   11 : mainfo.customoption := 2048 ;
   12 : mainfo.customoption := 0 ;
  end;

end;

procedure tactionsmo.compilecustommenu(const sender: TObject);
begin
saveactonexecute(sender);
setupcustommenu(sender) ;
mainfo.customcompile(sender);
end;

procedure tactionsmo.runcustom(const sender: TObject);
begin
 mainfo.customrun(sender) ;
end;

procedure tactionsmo.undoactonexecute(const sender: tobject);
begin
 sourcefo.activepage.doundo;
end;

procedure tactionsmo.redoactonexecute(const sender: tobject);
begin
 sourcefo.activepage.doredo;
end;

procedure tactionsmo.copyactonexecute(const sender: tobject);
begin
 sourcefo.activepage.edit.copyselection;
end;

procedure tactionsmo.copylatexactonexecute(const sender: TObject);
begin
 sourcefo.activepage.copylatex;
end;

procedure tactionsmo.cutactonexecute(const sender: tobject);
begin
 sourcefo.activepage.edit.cutselection;
end;

procedure tactionsmo.indentonexecute(const sender: TObject);
begin
if confideufo.usedefaulteditoroptions.value then
 sourcefo.activepage.edit.indent(confideufo.blockindent.value,
                                           confideufo.tabindent.value)
else
 sourcefo.activepage.edit.indent(projectoptions.e.blockindent,
                                            projectoptions.e.tabindent);
end;

procedure tactionsmo.unindentonexecute(const sender: TObject);
begin
 if confideufo.usedefaulteditoroptions.value then
 sourcefo.activepage.edit.unindent(confideufo.blockindent.value)
else
  sourcefo.activepage.edit.unindent(projectoptions.e.blockindent);
end;

procedure tactionsmo.lowercaseexecute(const sender: TObject);
begin
 sourcefo.activepage.edit.lowercase;
end;

procedure tactionsmo.uppercaseexecute(const sender: TObject);
begin
 sourcefo.activepage.edit.uppercase;
end;

procedure tactionsmo.enablecomment(const sender: tcustomaction);
begin
 enableonselect(sender);
 sender.enabled:= sender.enabled and  sourcefo.activepage.cancomment();
end;


procedure tactionsmo.selectwordactiononexecute(const sender: TObject);
begin
 sourcefo.activepage.copywordatcursor();
end;

procedure tactionsmo.enableuncomment(const sender: tcustomaction);
begin
 enableonselect(sender);
 sender.enabled:= sender.enabled and  sourcefo.activepage.canuncomment();
end;

procedure tactionsmo.commentonexecute(const sender: TObject);
begin
 sourcefo.activepage.commentselection();
end;

procedure tactionsmo.uncommentonexecute(const sender: TObject);
begin
 sourcefo.activepage.uncommentselection();
end;

procedure tactionsmo.enableonselect(const sender: tcustomaction);
begin
 sender.enabled:= (sourcefo.activepage <> nil) and
                                      sourcefo.activepage.edit.hasselection;
end;

procedure tactionsmo.lineactonexecute(const sender: TObject);

begin
if lineformcreated then linefo.bringtofront else
 integerenter(fgototheline,1, sourcefo.activepage.source_editor.rowcount,
      sourcefo.c[ord(gotoline)],sourcefo.c[ord(findline)])
// sourcefo.activepage.doline;
end;

procedure tactionsmo.findactonexecute(const sender: tobject);
begin
 if targetconsolefo.activeentered then begin
  targetconsolefo.dofind;
 end
 else begin

 if findformcreated then finddialogfo.bringtofront else
 finddialogexecute(findinfos);
  // sourcefo.activepage.dofind;
 end;
end;

procedure tactionsmo.repeatfindactonexecute(const sender: tobject);
begin
 if targetconsolefo.activeentered then begin
  targetconsolefo.repeatfind;
 end
 else begin
  sourcefo.activepage.repeatfind;
 end;
end;

procedure tactionsmo.replaceactonexecute(const sender: tobject);
begin
 sourcefo.activepage.doreplace;
end;

procedure tactionsmo.togglebreakpointexe(const sender: TObject);
begin
 sourcefo.activepage.togglebreakpoint;
end;

procedure tactionsmo.togglebkptenableactonexecute(const sender: TObject);
begin
 sourcefo.activepage.togglebreakpointenabled;
end;

procedure tactionsmo.instemplateactonexecute(const sender: TObject);
begin
 sourcefo.activepage.inserttemplate;
end;


//make

procedure tactionsmo.abortmakeactonexecute(const sender: tobject);
begin
 make.abortmake;
end;

procedure tactionsmo.makeactonexecute(const sender: tobject);
begin
 with mainfo do begin
  if sender is tmenuitem then
   begin
   domake(tmenuitem(sender).tag);
   thetag := tmenuitem(sender).tag;
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

procedure tactionsmo.resetactonexecute(const sender: tobject);
begin
 with mainfo do begin
  gdb.abort;
  killtarget; //if running
  programfinished;
  setstattext('');
  startgdb(false);
 end;
end;

procedure tactionsmo.interruptactonexecute(const sender: tobject);
begin
 with mainfo do begin
  gdb.interrupt;
 end;
end;

procedure tactionsmo.continueactonexecute(const sender: tobject);
var
str3 : msestring;
int1, int2, int3 : integer;
begin

//terminategdbserver(killserver);

if debuggerfo.debug_on.tag = 0 then str3:= '' else

begin

/// fred debugger

str3 := '' ;

case debuggerfo.project_options.value of
  'M' : mainfo.thetag := 1;
  'B' : mainfo.thetag := 2;
  '1' : mainfo.thetag := 4;
  '2' : mainfo.thetag := 8;
  '3' : mainfo.thetag := 16;
  '4' : mainfo.thetag := 32;
  '5' : mainfo.thetag := 64;
  '6' : mainfo.thetag := 128;
  '7' : mainfo.thetag := 256;
  '8' : mainfo.thetag := 512;
  '9' : mainfo.thetag := 1024;
  '0' : mainfo.thetag := 2048;
  end;

with projectoptions,o,texp do begin
for int3:= 0 to high(debuggerused) do begin
   if (mainfo.thetag and debuggerusedon[int3] <> 0) and
         (debuggerused[int3] <> '') then begin

  if (pos('Default',debuggerused[int3]) > 0) then
    str3:= 'Default Debugger' else

    if (trim(debuggerused[int3]) = 'Debugger 1')  then
    str3:= quotefilename(tosysfilepath(confdebuggerfo.debugger1.value)) else

    if (trim(debuggerused[int3]) = 'Debugger 2') then
    str3:= quotefilename(tosysfilepath(confdebuggerfo.debugger2.value)) else

    if (trim(debuggerused[int3]) = 'Debugger 3') then
    str3:= quotefilename(tosysfilepath(confdebuggerfo.debugger3.value)) else

     if (trim(debuggerused[int3]) = 'Debugger 4') then
    str3:= (quotefilename(tosysfilepath(confdebuggerfo.debugger4.value))) else
    str3:= '' ;

    if str3 = '' then str3:= 'Default Debugger';
 end;
 end;
 end;
// str3:= 'Default Debugger'
 end;

 int1 := 1;

   with projectoptions,o,texp do begin

for int2:= 0 to high(compilerused) do begin
   if (mainfo.thetag and compilerusedon[int2] <> 0)  then
    begin
 if system.pos('Default',compilerused[int2]) > 0 then int1 := 1 else
 if system.pos('Pascal',compilerused[int2]) > 0 then int1 := 1 else
 if system.pos('Java',compilerused[int2]) > 0 then int1 := 2 else
 if system.pos('C ',compilerused[int2]) > 0 then int1 := 3 else
 if system.pos('Python',compilerused[int2]) > 0 then int1 := 4;
   end;
   end;
   end;

 if (str3 <> '') and ((int1 = 1) or (int1 = 3))  then begin
  with mainfo do begin
  if checkremake(sc_continue) then begin
   cpufo.beforecontinue;
   gdb.continue;
   end;
 end;
 end else
 begin
 mainfo.runwithoutdebugger ;
 end;
end;

procedure tactionsmo.stepactonexecute(const sender: tobject);
begin
 with mainfo do begin
  if checkremake(sc_step) then begin
   gdb.step;
  end;
 end;
end;

procedure tactionsmo.stepiactonexecute(const sender: TObject);
begin
 with mainfo do begin
  if checkremake(sc_step) then begin
   gdb.stepi;
  end;
 end;
end;

procedure tactionsmo.nextactonexecute(const sender: tobject);
begin
 with mainfo do begin
  if checkremake(sc_step) then begin
   gdb.next;
  end;
 end;
end;

procedure tactionsmo.nextiactonexecute(const sender: TObject);
begin
 with mainfo do begin
  if checkremake(sc_step) then begin
   gdb.nexti;
  end;
 end;
end;

procedure tactionsmo.finishactonexecute(const sender: tobject);
begin
 with mainfo do begin
  if checkremake(sc_continue) then begin
   gdb.finish;
  end;
 end;
end;

procedure tactionsmo.bkptsononexecute(const sender: TObject);
begin
// debuggerfo.break_point.value := bkptsonact.checked;
 breakpointsfo.bkptson.value:= bkptsonact.checked;
end;

procedure tactionsmo.watchesononexecute(const sender: TObject);
begin
//debuggerfo.watches.value := watchesonact.checked;
watchfo.watcheson.value:= watchesonact.checked;
end;

procedure tactionsmo.bluedotsononchange(const sender: TObject);
begin
// debuggerfo.hints.value := bluedotsonact.checked;
mainfo.checkbluedots;
end;

procedure tactionsmo.printactonexecute(const sender: TObject);
begin
 printform.print;
end;

procedure tactionsmo.ondetachtarget(const sender: TObject);
begin
 if mainfo.checkgdberror(mainfo.gdb.detach) then begin
  mainfo.startgdb(false);
 end;
end;

procedure tactionsmo.onattachprocess(const sender: TObject);
var
 int1: integer;
 info: stopinfoty;
begin
 with mainfo do begin
  int1:= 0;
  if integerenter(int1,minint,maxint,self.c[ord(ac_processid)],
                      self.c[ord(ac_attachtoprocess)]) = mr_ok then begin
   setstattext(self.c[ord(ac_attachingprocess)]+' '+UTF8Decode(inttostr(int1)),mtk_making);
   application.processmessages;
   startgdb(false);
   gdb.attach(int1,info);
   loadexec(true,false);
   refreshstopinfo(info);
  end;
 end;
end;

procedure tactionsmo.onattachtarget(const sender: TObject);
var
 info: stopinfoty;
begin
 with mainfo do begin
  startgdb(false);
  if checkgdberror(gdb.filesymbol(gettargetfile)) and
                                startgdbconnection(true) then begin
   gdb.attachtarget(info);
   loadexec(true,false);
   refreshstopinfo(info);
  end;
 end;
end;

procedure tactionsmo.downloadexe(const sender: TObject);
begin
 mainfo.loadexec(false,true);
end;

procedure tactionsmo.helpex(const sender: TObject);
begin
 application.help(application.activewidget);
end;

procedure tactionsmo.setbmexec(const sender: TObject);
begin
 sourcefo.setbmexec(sender);
end;

procedure tactionsmo.findbmexec(const sender: TObject);
begin
 sourcefo.findbmexec(sender);
end;

procedure tactionsmo.projectopenexe(const sender: TObject);
var
 fna1: filenamety;
begin
 debuggerfo.project_history.tag := 1;
 if projectfiledialog(fna1,false) = mr_ok then begin
    mainfo.openproject(fna1);
    mainfo.activate;
    sourcefo.updatehinttab;
 end;
end;

procedure tactionsmo.projectoptionsexe(const sender: TObject);
begin
 editprojectoptions;
end;

procedure tactionsmo.projecttreeexe(const sender: TObject);
begin
 projecttreefo.activate;
end;

procedure tactionsmo.projectsourceexe(const sender: TObject);
begin
 sourcefo.openfile(projectoptions.o.texp.mainfile,true);
end;

procedure tactionsmo.projectsaveexe(const sender: TObject);
begin
 if projectoptions.projectfilename = '' then begin
  mainfo.saveprojectasonexecute(sender);
 end
 else begin
  mainfo.saveproject(projectoptions.projectfilename);
 end;
end;

procedure tactionsmo.projectcloeseexe(const sender: TObject);
begin
 mainfo.closeprojectactonexecute (sender);
end;

procedure tactionsmo.creadstateexe(const sender: TObject);
begin
 msegdbutils.localizetext;
end;

procedure tactionsmo.findupdateexe(const sender: tcustomaction);
begin
 if targetconsolefo.activeentered then begin
  find.enabled:= true;
  repeatfind.enabled:= projectoptions.targetconsolefindinfo.text <> ''
 end
 else begin
  find.enabled:= (sourcefo.activepage <> nil) ;
 // and sourcefo.activepage.activeentered;
  repeatfind.enabled:= find.enabled and
           (projectoptions.findreplaceinfo.find.text <> '');
 end;
  findback.enabled:= repeatfind.enabled;
 findcompallact.enabled:= not find.enabled;
// find.enabled:= true;
 // repeatfind.enabled:=  (projectoptions.findreplaceinfo.find.text <> '');
end;

procedure tactionsmo.findcompexe(const sender: TObject);
begin
 if mainfo.factivedesignmodule <> nil then begin
  mainfo.factivedesignmodule^.designformintf.findcompdialog();
 end;
end;

function tactionsmo.filterfindcomp(
                                 const acomponent: tcomponent): boolean;
begin
 result:= not (cssubcomponent in acomponent.componentstyle) and
          (not (acomponent is twidget) or
                (ws_iswidget in twidget(acomponent).widgetstate));
end;

procedure tactionsmo.findcompallexe(const sender: TObject);
var
 name1: msestring;
 comp1: tcomponent;
 po1: pmoduleinfoty;
begin
 name1:= '';
 with designer do begin
  if selections.count > 0 then begin
   name1:= UTF8Decode(ownernamepath(selections[0]));
  end;
  if compnamedialog(designer.getcomponentnametree(nil,true,true,nil,
                      @filterfindcomp,nil),name1,true) = mr_ok then begin
   replacechar1(name1,':','.');
   comp1:= designer.getcomponent(AnsiString(name1),po1);
   designer.showformdesigner(po1);
   designer.selectcomponent(comp1);
  end;
 end;
end;

procedure tactionsmo.forcezorderexe(const sender: TObject);
begin
 if projectoptions.o <> nil then begin
  projectoptions.o.forcezorder:= taction(sender).checked;
  projectoptionsmodified();
 end;
end;

end.
