unit ${%UNITNAME%};
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus, msegui,
 msegraphics, msegraphutils, mseevent, mseclasses, mseforms, msedock;

type
 t${%FORMNAME%} = class(tdockform)
 end;
var
 ${%FORMNAME%}: t${%FORMNAME%};
implementation
uses
 ${%UNITNAME%}_mfm;
end.
