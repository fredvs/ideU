unit paneltitle;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 msegraphics,msegraphutils,mseevent,mseclasses,msewidgets,mseforms,mseedit, panelform,
 msestatfile,msestream,sysutils,msesimplewidgets;
type
 tpaneltitlefo = class(tmseform)
   tedit1: tedit;
   tbutton1: tbutton;
   tbutton2: tbutton;
   procedure onok(const sender: TObject);
   procedure nocan(const sender: TObject);
 end;
var
 paneltitlefo: tpaneltitlefo;
implementation
uses
 paneltitle_mfm;
procedure tpaneltitlefo.onok(const sender: TObject);
begin
 newpanel(tedit1.text);
 close;
end;

procedure tpaneltitlefo.nocan(const sender: TObject);
begin
close;
end;

end.
