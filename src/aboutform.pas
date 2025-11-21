unit aboutform;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 msegraphics,msegraphutils,mseevent,mseclasses,msewidgets,mseforms,mseedit,
 msestatfile,msestream,msestrings,sysutils,msesimplewidgets,mseact,msedataedits,
 mseificomp,mseificompglob,mseifiglob;
type
 taboutfo = class(tmseform)
   about_text: tmemoedit;
   procedure onloop(const sender: TObject);
 end;
var
 aboutfo: taboutfo;
implementation
uses
 aboutform_mfm;
procedure taboutfo.onloop(const sender: TObject);
var
rect1: rectty;
begin
  application.processmessages;
  rect1 := application.screenrect();

  left := (rect1.cx - Width) div 2;
  top := (rect1.cy - height) div 2;
  invalidatewidget;
end;

end.
