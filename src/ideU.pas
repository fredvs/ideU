program ideU;

{$ifdef FPC}
 {$mode objfpc}{$h+}
 {$ifdef mswindows}
  {$ifdef mse_debug}{$apptype console}{$else}{$apptype gui}{$endif}
 {$endif}
{$endif}
{$ifdef mswindows}
 {$R ideu.res}
{$endif}

uses
  cmem,
 {$ifdef FPC} {$ifdef unix}
  cthreads, {$endif} {$endif}
  msestockobjects,
  mseconsts_ide,
  mseconsts_ide_ru,
  mseconsts_ide_de,
  mseconsts_ide_es,
  mseconsts_ide_fr,
  aboutform,
  confmsegui,
  confideu,
  conffpgui,
  confcompiler,
  confdebugger,
  mselibc,
  dialogfiles,
  findmessage,
  mseskindesign,
  gettext,
  msegui,
  msegraphics,
  actionsmodule,
  sourceform,
  commandorform,
  componentpaletteform,
  componentstore,
  messageform,
  watchform,
  objectinspector,
  breakpointsform,
  watchpointsform,
  stackform,
  projecttreeform,
  findinfileform,
  cpuform,
  disassform,
  memoryform,
  threadsform,
  mseguiglob,
  symbolform,
  targetconsole,
  main,
  splash,
  mseguiintf,
  {msestockobjects,}regunitgroups,
  guitemplates,
  msegraphutils,
  msefont,
  fpg_iniutils_ideu,
  stringconsts;

var
  MSELang : string = '';
  tmp : string = ''; 
  
begin

 Gettext.GetLanguageIDs(MSELang,MSEFallbackLang);
 
  tmp := gINI.ReadString('language', 'default', '');

  if tmp <> '' then
  begin
    setlangconsts(tmp);
    MSEFallbacklang := tmp;
  end
  else
  begin
   if (MSEFallbackLang = 'en') or (MSEFallbackLang = 'ru') or (MSEFallbackLang = 'fr') or (MSEFallbackLang = 'de') or (MSEFallbackLang = 'es') then
    begin
      setlangconsts(MSEFallbackLang);
    end;
  end;
 
 //if loadlangunit('.' + directoryseparator + 'languages' + directoryseparator +
//  'ideu_i18n_'+ MSEFallbackLang,true) then
 
// setlangconsts(MSEFallbackLang);
   nozorderhandling := true;

  registerfontalias('mseide_source', gui_getdefaultfontnames[stf_courier],
    fam_fixnooverwrite, 16);

   application.createdatamodule(tguitemplatesmo, guitemplatesmo);

  if application.terminated then exit;
  
     application.createform(tsplashfo, splashfo);


    application.createform(tconfideufo, confideufo);
  application.createform(tconfmseguifo, confmseguifo);
  application.createform(tconffpguifo, conffpguifo);
  application.createform(tconfcompilerfo, confcompilerfo);
  application.createform(tconfdebuggerfo, confdebuggerfo);
  conffpguifo.fpguidesigner.Value := '';

  application.createdatamodule(tstringconstsmo, s);
  application.createdatamodule(tactionsmo, actionsmo);
  application.createform(tsourcefo, sourcefo);
  sourcefo.caption := actionsmoduletext(ac_source);
  
  application.createform(tdebuggerfo, debuggerfo);
  debuggerfo.caption := stockobjects.captions[sc_commander];
  
  application.createform(tcomponentpalettefo, componentpalettefo);
  componentpalettefo.Caption :=     stockobjects.captions[sc_componentspalette];
  application.createform(tcomponentstorefo, componentstorefo);
  componentstorefo.Caption := actionsmoduletext(ac_storecomponent);
  
  application.createform(tmessagefo, messagefo);
  messagefo.Caption := stockobjects.captions[sc_messages];
    
  application.createform(twatchfo, watchfo);
  watchfo.Caption := stockobjects.captions[sc_watches];
    
  application.createform(tsymbolfo, symbolfo);
   symbolfo.Caption := stockobjects.captions[sc_symbols];
  
  application.createform(tobjectinspectorfo, objectinspectorfo);
  objectinspectorfo.Caption := actionsmoduletext(ac_objectinspector);

  application.createform(tbreakpointsfo, breakpointsfo);
   breakpointsfo.Caption := stockobjects.captions[sc_breakpoints];
    
  application.createform(twatchpointsfo, watchpointsfo);
  watchpointsfo.Caption := stockobjects.captions[sc_watchpoints];
   
  application.createform(tstackfo, stackfo);
  stackfo.Caption := stockobjects.captions[sc_stack];
    
  application.createform(tprojecttreefo, projecttreefo);
  projecttreefo.Caption := stockobjects.captions[sc_tree];
    
  application.createform(tfindinfilefo, findinfilefo);
   findinfilefo.Caption := stockobjects.captions[sc_find_infile];
   
  // application.createform(tcpufo, cpufo);
  application.createform(tdisassfo, disassfo);
   disassfo.Caption := stockobjects.captions[sc_assembler];
   
  application.createform(tmemoryfo, memoryfo);
   memoryfo.Caption := stockobjects.captions[sc_memory];
    
  application.createform(tthreadsfo, threadsfo);
  threadsfo.Caption := stockobjects.captions[sc_threads];
   
  application.createform(ttargetconsolefo, targetconsolefo);
  targetconsolefo.Caption := stockobjects.captions[sc_targetconsole];
  
  application.createform(tdialogfilesfo, dialogfilesfo);
  application.createform(tfindmessagefo, findmessagefo);
  //findmessagefo.close;
  
 // application.createform(tbeautyfo, beautyfo);
  confcompilerfo.Close;
  confdebuggerfo.Close;
 // beautyfo.Close;

  application.createform(tmainfo, mainfo);
  
  application.createform(taboutfo, aboutfo);
  aboutfo.Caption := stockobjects.captions[sc_about];
 
  createcpufo;

  mainfo.ideureadconfig;
  
  splashfo.icon := mainfo.icon;
  confideufo.icon := mainfo.icon;
  confmseguifo.icon := mainfo.icon;
  conffpguifo.icon := mainfo.icon;
  confcompilerfo.icon := mainfo.icon;
  confdebuggerfo.icon := mainfo.icon;
  sourcefo.icon := mainfo.icon;
  debuggerfo.icon := mainfo.icon;
  findinfilefo.icon := mainfo.icon;
  messagefo.icon := mainfo.icon;
  dialogfilesfo.icon := mainfo.icon;
  findmessagefo.icon := mainfo.icon;
  aboutfo.icon := mainfo.icon;

  application.run;
end.
