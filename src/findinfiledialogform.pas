{ MSEide Copyright (c) 1999-2016 by Martin Schreiber

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
unit findinfiledialogform;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

uses
  mseconsts,
  msestockobjects,
  captionideu,
  finddialogform,
  findinfileform,
  mseforms,
  msedataedits,
  msesimplewidgets,
  msegraphedits,
  msefiledialog,
  msetypes,
  mseglob,
  mseguiglob,
  msegui,
  msestat,
  msestatfile,
  mseevent,
  msemenus,
  msesplitter,
  msegraphics,
  msegraphutils,
  msewidgets,
  msestrings,
  mseificomp,
  mseificompglob,
  mseifiglob,
  msescrollbar,
  mseclasses;

type

  tfindinfiledialogfo = class(tmseform)
    findtext: thistoryedit;
    statfile1: tstatfile;
    dir: tfilenameedit;
    mask: thistoryedit;
    casesensitive: tbooleanedit;
    inprojectdir: tbooleaneditradio;
    indirectories: tbooleaneditradio;
    wholeword: tbooleanedit;
    inopenfiles: tbooleaneditradio;
    incurrentfile: tbooleaneditradio;
    subdirs: tbooleanedit;
    ok: TButton;
    cancel: TButton;
    procedure dironbeforeexecute(const Sender: tfiledialogcontroller; var dialogkind: filedialogkindty; var aresult: modalresultty);
    procedure dirshowhint(const Sender: TObject; var info: hintinfoty);
    procedure sourcechangeexe(const Sender: TObject);
    //   procedure chainopenfiles(const sender: TObject);
    procedure dirgetfilenameexe(const Sender: TObject; var avalue: msestring; var accept: Boolean);
    procedure dirsetval(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure opensetval(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure dirsetvalue(const Sender: TObject; var avalue: msestring; var accept: Boolean);
    procedure cereateev(const Sender: TObject);
    procedure currentsetval(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure setlangfindinfile();

   procedure onactiv(const sender: TObject);
  private
    procedure valuestoinfo(out info: findinfileinfoty);
    procedure infotovalues(const info: findinfileinfoty);
  end;

procedure findinfiledialogdotextsize;

function findinfiledialogexecute(var info: findinfileinfoty; const useinfo: Boolean): Boolean;

implementation

uses
  msebits,
  findinfiledialogform_mfm,
  projectoptionsform,
  main,
  msefileutils,
  sourceform,
  confideu;

var
  fo: tfindinfiledialogfo;


procedure findinfiledialogdotextsize;
begin
  fo.font.Height       := confideufo.fontsize.Value;
  fo.font.Name         := ansistring(confideufo.fontname.Value);
  fo.findtext.top      := 34;
  fo.casesensitive.top := fo.findtext.top + fo.findtext.Height + 2;
  fo.wholeword.top     := fo.casesensitive.top + fo.casesensitive.Height + 2;
  fo.incurrentfile.top := fo.wholeword.top + fo.wholeword.Height + 6;
  fo.inopenfiles.top   := fo.incurrentfile.top + fo.incurrentfile.Height + 2;
  fo.inprojectdir.top  := fo.inopenfiles.top + fo.inopenfiles.Height + 6;
  fo.indirectories.top := fo.inprojectdir.top + fo.inprojectdir.Height + 2;
  fo.dir.top           := fo.indirectories.top + fo.indirectories.Height + 2;
  fo.mask.top          := fo.dir.top + fo.dir.Height + 2;
  fo.subdirs.top       := fo.mask.top + fo.mask.Height + 6;

  fo.Height := fo.subdirs.top + fo.subdirs.Height + 8;
end;

function findinfiledialogexecute(var info: findinfileinfoty; const useinfo: Boolean): Boolean;
begin
  fo := tfindinfiledialogfo.Create(nil);
  try
    findinfiledialogdotextsize;
    if useinfo then
      fo.infotovalues(info);
    Result := fo.Show(True, nil) = mr_ok;
    if Result then
      fo.valuestoinfo(info);
  finally
    fo.Free;
  end;
end;

{ tfindinfiledialogfo }

procedure tfindinfiledialogfo.dironbeforeexecute(const Sender: tfiledialogcontroller; var dialogkind: filedialogkindty; var aresult: modalresultty);
begin
  Sender.filterlist.asarrayb := Mask.dropdown.valuelist.asarray;
  Sender.filter := Mask.Value;
end;

procedure tfindinfiledialogfo.valuestoinfo(out info: findinfileinfoty);
begin
{$warnings off}
  with info.findinfo do
  begin
    Text    := findtext.Value;
    history := findtext.dropdown.valuelist.asarray;
    options := encodesearchoptions(not casesensitive.Value, wholeword.Value);
  end;
  with info do
  begin
    directory := dir.Value;
    filemask  := Mask.Value;
    updatebit(
{$ifdef FPC}
      longword
{$else}byte{$endif}
      (options), Ord(fifo_subdirs), subdirs.Value);
    if inopenfiles.Value then
      Source := fs_inopenfiles
    else if indirectories.Value then
      Source := fs_indirectories
    else if incurrentfile.Value then
      Source := fs_incurrentfile
    else
      Source := fs_inprojectdir;
  end;
end;

{$warnings on}
procedure tfindinfiledialogfo.infotovalues(const info: findinfileinfoty);
begin
  with info.findinfo do
  begin
    findtext.Value      := Text;
    findtext.dropdown.valuelist.asarray := history;
    casesensitive.Value := not (so_caseinsensitive in options);
    wholeword.Value     := so_wholeword in options;
  end;
  with info do
  begin
    dir.Value     := directory;
    Mask.Value    := filemask;
    subdirs.Value := fifo_subdirs in options;
    case Source of
      fs_inopenfiles: inopenfiles.Value := True;
      fs_indirectories: indirectories.Value := True;
      fs_inprojectdir: inprojectdir.Value   := True;
      fs_incurrentfile: incurrentfile.Value := True;
    end;
  end;
end;

procedure tfindinfiledialogfo.dirshowhint(const Sender: TObject; var info: hintinfoty);
begin
  hintmacros(tcustomstringedit(Sender), info);
  info.Caption := info.Caption + lineend + 'Empty -> project directory';
end;

procedure tfindinfiledialogfo.dirgetfilenameexe(const Sender: TObject; var avalue: msestring; var accept: Boolean);
begin
  expandprmacros1(avalue);
end;

procedure tfindinfiledialogfo.sourcechangeexe(const Sender: TObject);
begin
  if indirectories.Value then
  begin
    //  inopenfiles.value:= false;
    dir.Enabled     := True;
    Mask.Enabled    := True;
    subdirs.Enabled := True;
  end
  else if inopenfiles.Value or incurrentfile.Value then
  begin
    dir.Enabled     := False;
    Mask.Enabled    := False;
    subdirs.Enabled := False;
  end
  else
  begin
    dir.Enabled     := False;
    Mask.Enabled    := True;
    subdirs.Enabled := True;
  end;
end;

procedure tfindinfiledialogfo.dirsetval(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if avalue then
  begin
    inopenfiles.Value   := False;
    incurrentfile.Value := False;
  end;
end;

procedure tfindinfiledialogfo.opensetval(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if avalue then
  begin
    inprojectdir.Value  := False;
    indirectories.Value := False;
  end;
end;

procedure tfindinfiledialogfo.currentsetval(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  if avalue then
  begin
    inprojectdir.Value  := False;
    indirectories.Value := False;
  end;
end;


procedure tfindinfiledialogfo.dirsetvalue(const Sender: TObject; var avalue: msestring; var accept: Boolean);
begin
  if avalue = '' then
    avalue := filedir(mainfo.projectname);
end;

procedure tfindinfiledialogfo.cereateev(const Sender: TObject);
begin
  if sourcefo.ActivePage = nil then
    incurrentfile.Enabled := False;
  setlangfindinfile();
end;

procedure tfindinfiledialogfo.setlangfindinfile();
begin

  Caption           := lang_xstockcaption[ord(sc_find_infile)];
  cancel.Caption        := lang_modalresult[ord(mr_cancel)];
  ok.Caption    := lang_modalresult[ord(mr_ok)];
  findtext.frame.Caption := lang_xstockcaption[ord(sc_texttofind)] ;
  casesensitive.frame.Caption := lang_xstockcaption[ord(sc_casesensitive)];
  wholeword.frame.Caption := lang_xstockcaption[ord(sc_wholeword)];
  incurrentfile.frame.Caption := lang_xstockcaption[ord(sc_searchincurrentfile)];
  inopenfiles.frame.Caption := lang_xstockcaption[ord(sc_searchinopenfiles)];
  inprojectdir.frame.Caption := lang_xstockcaption[ord(sc_searchinprojectdir)];
  indirectories.frame.Caption := lang_xstockcaption[ord(sc_searchindirectories)];
 
  dir.frame.Caption := lang_stockcaption[ord(sc_directory)];
  Mask.frame.Caption := lang_projectoptions[ord(po_filemask)];
  subdirs.frame.Caption := lang_xstockcaption[ord(sc_includesubdir)];

end;

procedure tfindinfiledialogfo.onactiv(const sender: TObject);
begin
if tag = 0 then
begin
 left := 200;
 top :=  100;
end; 
tag := 1;
end;

end.

