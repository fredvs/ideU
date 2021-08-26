{ MSEide Copyright (c) 1999-2006 by Martin Schreiber
   
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
}
unit commandlineform;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

uses
  mseconsts_ide,
  mseconsts_ide_ru,
  mseconsts_ide_pt,
  mseconsts_ide_de,
  mseconsts_ide_es,
  mseconsts_ide_fr,
  msestockobjects,
  msegui,
  mseclasses,
  mseforms,
  msedataedits,
  msestringcontainer,
  msestrings;

type
  stringconsts = (
    makedisabled //0 Make disabled by Default make col!
    );

  tcommandlinefo = class(tmseform)
    disp: tmemoedit;
    c: tstringcontainer;
    procedure oncreated(const Sender: TObject);
    procedure setlangcomline();

  end;

procedure showcommandline;

implementation

uses
  commandlineform_mfm,
  make,
  projectoptionsform;

procedure showcommandline;
var
  fo: tcommandlinefo;
begin
  fo := tcommandlinefo.Create(nil);
  try
    if projectoptions.defaultmake >= maxdefaultmake then
      fo.disp.Value := fo.c[Ord(makedisabled)]
    else
      fo.disp.Value := UTF8Decode(buildmakecommandline(projectoptions.defaultmake));
    fo.Show(True);
  finally
    fo.Free;
  end;
end;

procedure tcommandlinefo.setlangcomline();
begin
  Caption := projectoptionstext(po_runcommand);
end;


procedure tcommandlinefo.oncreated(const Sender: TObject);
begin
  setlangcomline();
end;

end.

