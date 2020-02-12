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
uses  // cmem,
 {$ifdef FPC} {$ifdef unix}cthreads, {$endif} {$endif}

  aboutform,
  confmsegui,
  confideu,
  conffpgui,
  confcompiler,
  beauty,
  confdebugger,
  dialogfiles,
  mseskindesign,
  //gettext,msei18nutils,mseconsts,mseconsts_ru,mseconsts_uzcyr,
  //mseconsts_de,mseconsts_es,mseconsts_zh,mseconsts_id,mseconsts_fr,
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
  {msestockobjects,}regunitgroups,
  guitemplates,
  msegraphutils,
  msefont,
  stringconsts;

{
var
  MSELang,MSEFallbacklang:string;
}

begin
{
 Gettext.GetLanguageIDs(MSELang,MSEFallbackLang);
 // MSEFallbackLang:='ru';
if loadlangunit('.' + directoryseparator + 'languages' + directoryseparator +
  'ideu_i18n_'+ MSEFallbackLang,true) then setlangconsts(MSEFallbackLang);
}
  registerfontalias('mseide_source', gui_getdefaultfontnames[stf_courier],
    fam_fixnooverwrite, 16);
  application.createdatamodule(tguitemplatesmo, guitemplatesmo);

  if application.terminated then
  begin
    exit;
  end;

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
  componentpalettefo.Caption := 'MSE Component Palette';
  application.createform(tcomponentstorefo, componentstorefo);
  componentstorefo.Caption := 'MSE ' + componentstorefo.Caption;
  application.createform(tmessagefo, messagefo);
  application.createform(twatchfo, watchfo);
  application.createform(tsymbolfo, symbolfo);
  application.createform(tobjectinspectorfo, objectinspectorfo);
  objectinspectorfo.Caption := 'MSE Objects Inspector';
  application.createform(tbreakpointsfo, breakpointsfo);
  application.createform(twatchpointsfo, watchpointsfo);
  application.createform(tstackfo, stackfo);
  application.createform(tprojecttreefo, projecttreefo);
  application.createform(tfindinfilefo, findinfilefo);
  // application.createform(tcpufo, cpufo);
  application.createform(tdisassfo, disassfo);
  application.createform(tmemoryfo, memoryfo);
  application.createform(tthreadsfo, threadsfo);
  application.createform(ttargetconsolefo, targetconsolefo);
  application.createform(tdialogfilesfo, dialogfilesfo);
  application.createform(tbeautyfo, beautyfo);
  confcompilerfo.Close;
  confdebuggerfo.Close;
  beautyfo.Close;

  application.createform(tmainfo, mainfo);
  application.createform(taboutfo, aboutfo);

  createcpufo;

  mainfo.ideureadconfig;

  application.run;
end.
