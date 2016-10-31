library ideuj;
{$ifdef FPC}
 {$mode objfpc}{$h+}
 {$ifdef mswindows}
  {$ifdef mse_debug}{$apptype console}{$else}{$apptype gui}{$endif}
 {$endif}
{$endif}
{$ifdef mswindows}
 {$R mseide.res}
{$endif}
uses
{$ifdef FPC}{$ifdef unix}cthreads,{$endif}{$endif}
//  mseopenglgdiinit,

  // fred
  confmsegui, conffpgui,
  
  mseskindesign,
  msegui,msegraphics,actionsmodule,sourceform,commandorform,
  componentpaletteform,componentstore,
  messageform,watchform,
  objectinspector,
  breakpointsform,watchpointsform,
  stackform,projecttreeform,findinfileform,cpuform,disassform,memoryform,
  threadsform,mseguiglob,symbolform,
  targetconsole,main,mseguiintf,{msestockobjects,}regunitgroups,guitemplates,
  msegraphutils,msefont,stringconsts;

procedure MainProc(PEnv: pointer; Obj: pointer); cdecl;
begin
 registerfontalias('mseide_source',gui_getdefaultfontnames[stf_courier],
                    fam_fixnooverwrite,16);
 application.createdatamodule(tguitemplatesmo,guitemplatesmo);
 if application.terminated then begin
  exit;
 end;
 application.createdatamodule(tstringconstsmo,s);
 application.createdatamodule(tactionsmo,actionsmo);
 application.createform(tsourcefo, sourcefo);
 application.createform(tdebuggerfo,debuggerfo);
 application.createform(tcomponentpalettefo,componentpalettefo);
 componentpalettefo.caption := 'mse Component Palette'; 
 application.createform(tcomponentstorefo,componentstorefo);
 componentstorefo.caption := 'mse ' + componentstorefo.caption ; 
 application.createform(tmessagefo,messagefo);
 application.createform(twatchfo, watchfo);
 application.createform(tsymbolfo, symbolfo);
 application.createform(tobjectinspectorfo, objectinspectorfo);
 objectinspectorfo.caption := 'mse Objects Inspector'; 
 application.createform(tbreakpointsfo, breakpointsfo);
 application.createform(twatchpointsfo, watchpointsfo);
 application.createform(tstackfo, stackfo);
 application.createform(tprojecttreefo, projecttreefo);
 application.createform(tfindinfilefo, findinfilefo);
// application.createform(tcpufo, cpufo);
 application.createform(tdisassfo, disassfo);
 application.createform(tmemoryfo, memoryfo);
 application.createform(tthreadsfo, threadsfo);
 application.createform(ttargetconsolefo,targetconsolefo);
 application.createform(tconfmseguifo,confmseguifo);
 application.createform(tconffpguifo,conffpguifo);
  application.createform(tmainfo, mainfo);
 createcpufo;
 application.run;
end;

exports
  {Here the only-one exported procedure...}
  MainProc name 'Java_ideuj_mainproc';

end.
