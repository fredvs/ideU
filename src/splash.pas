unit splash;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus,
  msegui,msegraphics, msegraphutils, mseevent, mseclasses, msewidgets, mseforms,
  mseimage;
type
 tsplashfo = class(tmseform)
   timage1: timage;
 end;
var
 splashfo: tsplashfo;
implementation
uses
 splash_mfm;
end.
