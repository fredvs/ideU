unit conffpgui;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msegui,msegraphics,
 msegraphutils,mseclasses,mseforms, mseedit,msegraphedits,msesimplewidgets,
 msestat,msestatfile,msemenus,msewidgets, msefiledialogx;
type
 tconffpguifo = class(tmseform)
   enablefpguidesigner: tbooleanedit;
   tbfpgonlyone: tbooleanedit;
   groupcommand: tgroupbox;
   edfilename: tedit;
   edclose: tedit;
   edhide: tedit;
   edshow: tedit;
   edquit: tedit;
   ifloadfile: tbooleanedit;
   ifclose: tbooleanedit;
   ifshow: tbooleanedit;
   ifhide: tbooleanedit;
   ifquit: tbooleanedit;
   edfilter: tedit;
   iffilter: tbooleanedit;
   ok: tbutton;
   fpguidesigner: tfilenameeditx;
   procedure onloop(const sender: TObject);
 end;
var
 conffpguifo: tconffpguifo;
implementation
uses
 conffpgui_mfm, confideu;
procedure tconffpguifo.onloop(const sender: TObject);
var
rect1: rectty;
begin
  application.processmessages;
  rect1 := application.screenrect();

  left := (rect1.cx - Width) div 2;
  top := (rect1.cy - height) div 2;
  
  if conffpguifo.fpguidesigner.value  = '' then
  {$ifdef widows}   
  conffpguifo.fpguidesigner.value := '${IDEUDIR}\plugin\designer_ext\designer_ext.exe';  
  {$else}
  conffpguifo.fpguidesigner.value := '${IDEUDIR}/plugin/designer_ext/designer_ext';  
  {$endif}
 
  invalidatewidget;
end;

end.
