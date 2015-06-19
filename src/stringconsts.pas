unit stringconsts;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 mseglob,mseapplication,mseclasses,msedatamodules,msestringcontainer;

type
 tstringconstsmo = class(tmsedatamodule)
   c: tstringcontainer;
 end;
var
 s: tstringconstsmo;
 
implementation
uses
 stringconsts_mfm;
end.
