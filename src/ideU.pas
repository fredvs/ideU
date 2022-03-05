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
cthreads,  {$endif} {$endif}
  msestockobjects,
  mseconsts,
  captionideu,
  conflang,
  // splash,
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
  mseguiintf,
  regunitgroups,
  guitemplates,
  msegraphutils,
  msefont,
  potools,
  stringconsts;
begin
  Gettext.GetLanguageIDs(MSELang, MSEFallbackLang);

  // MSEFallbackLang := 'fr';
  //  MSELang := 'fr';

  nozorderhandling := True;

  registerfontalias('mseide_source', gui_getdefaultfontnames[stf_courier],
    fam_fixnooverwrite, 16);

  application.createdatamodule(tguitemplatesmo, guitemplatesmo);

  if application.terminated then Exit;

  // application.createform(tsplashfo, splashfo);

  application.createform(tconfideufo, confideufo);
  application.createform(tconfmseguifo, confmseguifo);
  application.createform(tconffpguifo, conffpguifo);
  application.createform(tconfcompilerfo, confcompilerfo);
  application.createform(tconfdebuggerfo, confdebuggerfo);
  conffpguifo.fpguidesigner.Value := '';
  application.createdatamodule(tstringconstsmo, s);
  application.createdatamodule(tactionsmo, actionsmo);
  application.createform(tsourcefo, sourcefo);
  application.createform(tdebuggerfo, debuggerfo);
  application.createform(tcomponentpalettefo, componentpalettefo);
  application.createform(tcomponentstorefo, componentstorefo);
  application.createform(tmessagefo, messagefo);
  application.createform(twatchfo, watchfo);
  application.createform(tsymbolfo, symbolfo);
  application.createform(tobjectinspectorfo, objectinspectorfo);
  application.createform(tbreakpointsfo, breakpointsfo);
  application.createform(twatchpointsfo, watchpointsfo);
  application.createform(tstackfo, stackfo);
  application.createform(tprojecttreefo, projecttreefo);
  application.createform(tconflangfo, conflangfo);
  application.createform(tfindinfilefo, findinfilefo);
  application.createform(tdisassfo, disassfo);
  application.createform(tmemoryfo, memoryfo);
  application.createform(tthreadsfo, threadsfo);
  application.createform(ttargetconsolefo, targetconsolefo);
  application.createform(tdialogfilesfo, dialogfilesfo);
  application.createform(tfindmessagefo, findmessagefo);
 
  confcompilerfo.Close;
  confdebuggerfo.Close;
  conffpguifo.Close;
    
  application.createform(theaderfo, headerfo);
  headerfo.Close;
 
  application.createform(tmainfo, mainfo);

  application.createform(taboutfo, aboutfo);
  
  createcpufo;

  mainfo.ideureadconfig;

  headerfo.icon := mainfo.icon;
  // splashfo.icon       := mainfo.icon;
  confideufo.icon     := mainfo.icon;
  confmseguifo.icon   := mainfo.icon;
  conffpguifo.icon    := mainfo.icon;
  confcompilerfo.icon := mainfo.icon;
  confdebuggerfo.icon := mainfo.icon;
  sourcefo.icon       := mainfo.icon;
  debuggerfo.icon     := mainfo.icon;
  findinfilefo.icon   := mainfo.icon;
  messagefo.icon      := mainfo.icon;
  dialogfilesfo.icon  := mainfo.icon;
  findmessagefo.icon  := mainfo.icon;
  aboutfo.icon        := mainfo.icon;
  conflangfo.icon     := mainfo.icon;
  confideufo.Close;

  application.run;
end.

