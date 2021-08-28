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
unit replacedialogform;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

uses
  mseconsts_ide,
  msestockobjects,
  mseguiglob,
  msegui,
  mseclasses,
  mseforms,
  msegraphedits,
  msedataedits,
  msesimplewidgets,
  msestat,
  msestatfile,
  mseglob,
  projectoptionsform,
  {$I useslang.inc};

type
  treplacedialogfo = class(tmseform)
    casesensitive: tbooleanedit;
    findtext: thistoryedit;
    replacetext: thistoryedit;
    selectedonly: tbooleanedit;
    statfile1: tstatfile;
    promptonreplace: tbooleanedit;
    tintegerbutton1: TButton;
    tintegerbutton2: TButton;
    wholeword: tbooleanedit;

   procedure oncreat(const sender: TObject);
  private
    procedure valuestoinfo(out info: replaceinfoty);
    procedure infotovalues(const info: replaceinfoty);
    procedure setlangfindreplace();
  end;

procedure replacedialogdotextsize;
function replacedialogexecute(var info: replaceinfoty): modalresultty;

implementation

uses
  replacedialogform_mfm,
  msestrings,
  main,
  confideu;

var
  fo: treplacedialogfo;

procedure replacedialogdotextsize;
begin
  fo.font.Height := confideufo.fontsize.Value;
  fo.font.Name   := ansistring(confideufo.fontname.Value);

  fo.findtext.top := 34;
  fo.replacetext.top := fo.findtext.top + fo.findtext.Height + 2;
  fo.casesensitive.top := fo.replacetext.top + fo.replacetext.Height + 2;
  fo.wholeword.top := fo.casesensitive.top + fo.casesensitive.Height + 2;
  fo.selectedonly.top := fo.wholeword.top + fo.wholeword.Height + 2;
  fo.promptonreplace.top := fo.selectedonly.top + fo.selectedonly.Height + 2;
  fo.Height := fo.promptonreplace.top + fo.promptonreplace.Height + 10;
end;

function replacedialogexecute(var info: replaceinfoty): modalresultty;
begin
  fo := treplacedialogfo.Create(nil);
  try
    replacedialogdotextsize;
    fo.infotovalues(info);
    Result := fo.Show(True, nil);
    if Result in [mr_ok, mr_all] then
      fo.valuestoinfo(info);
  finally
    fo.Free;
  end;
end;

{ treplacedialogfo }

procedure treplacedialogfo.valuestoinfo(out info: replaceinfoty);
begin
{$warnings off}
  with info.find do
  begin
    Text         := findtext.Value;
    history      := findtext.dropdown.valuelist.asarray;
    options      := encodesearchoptions(not casesensitive.Value, wholeword.Value);
    selectedonly := self.selectedonly.Value;
  end;
  info.prompt := promptonreplace.Value;
  info.replacetext := replacetext.Value;
end;

{$warnings on}

procedure treplacedialogfo.setlangfindreplace();
begin

  Caption := stockobjects.captions[sc_find_replace];
  tintegerbutton1.Caption := stockobjects.captions[sc_replace];
  tintegerbutton2.Caption := stockobjects.captions[sc_replaceall];

  findtext.frame.Caption        := stockobjects.captions[sc_texttofind];
  replacetext.frame.Caption     := stockobjects.captions[sc_replacewith];
  promptonreplace.frame.Caption := stockobjects.captions[sc_promptonreplace];

  casesensitive.frame.Caption := stockobjects.captions[sc_casesensitive];
  selectedonly.frame.Caption  := stockobjects.captions[sc_selectedonly];
  wholeword.frame.Caption     := stockobjects.captions[sc_wholeword];

end;

procedure treplacedialogfo.infotovalues(const info: replaceinfoty);
begin
  with info.find do
  begin
    findtext.Value      := Text;
    findtext.dropdown.valuelist.asarray := history;
    casesensitive.Value := not (so_caseinsensitive in options);
    wholeword.Value     := so_wholeword in options;
    //  self.selectedonly.value:= selectedonly;
  end;
end;

procedure treplacedialogfo.oncreat(const sender: TObject);
begin
setlangfindreplace();
end;

end.

