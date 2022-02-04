{ MSEide Copyright (c) 1999-2013 by Martin Schreiber

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
unit finddialogform;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

uses
 mseforms,msesimplewidgets,msedataedits,msegraphedits,msetextedit,msestrings,
 msetypes,msestat,msestatfile,projectoptionsform,mseglob,mseevent,msegui,
 msemenus,msesplitter,msegraphics,msegraphutils,msewidgets,mseclasses,
 mseguiglob,mseificomp,mseificompglob,mseifiglob,msescrollbar,mseact,
 mseapplication,msedropdownlist,mseedit,msestream,SysUtils;

type

  tfinddialogfo = class(tmseform)
    findtext: thistoryedit;
    statfile1: tstatfile;
    ok: TButton;
    tlayouter1: tlayouter;
    tbutton2: TButton;
    boolfind1: tbooleaneditradio;
    findtext2: thistoryedit;
    findtext3: thistoryedit;
    findtext4: thistoryedit;
    boolfind2: tbooleaneditradio;
    boolfind3: tbooleaneditradio;
    boolfind4: tbooleaneditradio;
    tbutton3: TButton;
    casesensitive: tbooleanedit;
    wholeword: tbooleanedit;
    selectedonly: tbooleanedit;
   butok: tbutton;
    procedure oncloseev(const Sender: TObject);
    procedure onok(const Sender: TObject);
    procedure onprior(const Sender: TObject);
    procedure oncre(const Sender: TObject);
    procedure setlangfind();
   procedure onbutclose(const sender: TObject);
  private
    procedure valuestoinfo(out info: findinfoty);
    procedure infotovalues(const info: findinfoty);
  end;

procedure finddialogdotextsize;
procedure updatefindvalues(const astatfiler: tstatfiler; var aoptions: findinfoty);
function finddialogexecute(var info: findinfoty): Boolean;

var
  finddialogfo: tfinddialogfo;
  findformcreated: Boolean = False;
  findinfos: findinfoty;

implementation

uses
  finddialogform_mfm,
  sourceform,
  main,
  confideu,
  mseconsts,
  msestockobjects,
  captionideu;

procedure updatefindvalues(const astatfiler: tstatfiler; var aoptions: findinfoty);
var
  int1: integer;
begin
  with astatfiler, aoptions do
  begin
    updatevalue('finddtext', Text);
    updatevalue('findhistory', history);
    int1    :=
{$ifdef FPC}
      longword
{$else}byte{$endif}
      (options);
    updatevalue('findoptions', int1);
    options := searchoptionsty(
{$ifdef FPC}
      longword
{$else}byte{$endif}
      (int1));
  end;
end;

procedure finddialogdotextsize;
begin
  finddialogfo.font.Height   := confideufo.fontsize.Value;
  finddialogfo.font.Name     := ansistring(confideufo.fontname.Value);
  finddialogfo.findtext.top  := 34;
  finddialogfo.findtext2.top := finddialogfo.findtext.top + finddialogfo.findtext.Height + 2;
  finddialogfo.findtext3.top := finddialogfo.findtext2.top + finddialogfo.findtext.Height + 2;
  finddialogfo.findtext4.top := finddialogfo.findtext3.top + finddialogfo.findtext.Height + 2;
  finddialogfo.boolfind1.top := finddialogfo.findtext.top + (finddialogfo.findtext.Height div 2);
  finddialogfo.boolfind2.top := finddialogfo.findtext2.top + (finddialogfo.findtext.Height div 2);
  finddialogfo.boolfind3.top := finddialogfo.findtext3.top + (finddialogfo.findtext.Height div 2);
  finddialogfo.boolfind4.top := finddialogfo.findtext4.top + (finddialogfo.findtext.Height div 2);

  finddialogfo.casesensitive.top := 4 + finddialogfo.findtext4.top + finddialogfo.findtext.Height + 2;
  finddialogfo.selectedonly.top := finddialogfo.casesensitive.top + finddialogfo.casesensitive.Height + 2;
  finddialogfo.wholeword.top := finddialogfo.selectedonly.top + finddialogfo.selectedonly.Height + 2;
  finddialogfo.Height := finddialogfo.wholeword.top + finddialogfo.wholeword.Height + 8;
end;

function finddialogexecute(var info: findinfoty): Boolean;
begin
  Result := True;

  finddialogfo    := tfinddialogfo.Create(nil);
  findformcreated := True;
  try
    finddialogdotextsize;
    info := projectoptions.findreplaceinfo.find;
    if not sourcefo.ActivePage.edit.hasselection then
      info.selectedonly := False;
    info.Text           := sourcefo.ActivePage.edit.selectedtext;
    finddialogfo.infotovalues(info);

    if mainfo.ismodal then
      finddialogfo.Show(True)
    else
    begin
      finddialogfo.Show;
      finddialogfo.bringtofront;
    end;

    Result := True;
    //  result:= finddialogfo.show(true,nil) = mr_ok;
    // if result then begin
    //  finddialogfo.valuestoinfo(info);
    //  end;
  finally
    //  fo.Free;
  end;

end;

{ tfinddialogfo }

procedure tfinddialogfo.valuestoinfo(out info: findinfoty);
var
  findtxt: msestring;
  histor: msestringarty;
begin
  if boolfind1.Value then
  begin
    findtxt := findtext.Value;
    histor  := findtext.dropdown.valuelist.asarray;
  end
  else if boolfind2.Value then
  begin
    findtxt := findtext2.Value;
    histor  := findtext2.dropdown.valuelist.asarray;
  end
  else if boolfind3.Value then
  begin
    findtxt := findtext3.Value;
    histor  := findtext3.dropdown.valuelist.asarray;
  end
  else if boolfind4.Value then
  begin
    findtxt := findtext4.Value;
    histor  := findtext4.dropdown.valuelist.asarray;
  end;

  with info do
  begin
    Text         := findtxt;
    history      := histor;
    options      := encodesearchoptions(not casesensitive.Value, wholeword.Value);
    selectedonly := self.selectedonly.Value;
  end;
end;

procedure tfinddialogfo.infotovalues(const info: findinfoty);
begin
  with info do
  begin
    if boolfind1.Value then
    begin
      findtext.Value := Text;
      findtext.dropdown.valuelist.asarray := history;
    end
    else if boolfind2.Value then
    begin
      findtext.Value := Text;
      findtext.dropdown.valuelist.asarray := history;
    end
    else if boolfind3.Value then
    begin
      findtext.Value := Text;
      findtext.dropdown.valuelist.asarray := history;
    end
    else if boolfind4.Value then
    begin
      findtext4.Value := Text;
      findtext4.dropdown.valuelist.asarray := history;
    end;
    casesensitive.Value := not (so_caseinsensitive in options);
    wholeword.Value := so_wholeword in options;
    //  self.selectedonly.value:= selectedonly;
  end;
end;

procedure tfinddialogfo.oncloseev(const Sender: TObject);
begin
  findformcreated := False;
end;

procedure tfinddialogfo.onok(const Sender: TObject);
begin
  finddialogfo.valuestoinfo(findinfos);
  sourcefo.ActivePage.dofind;
end;

procedure tfinddialogfo.onprior(const Sender: TObject);
begin
  finddialogfo.valuestoinfo(findinfos);
  sourcefo.ActivePage.findback;
end;

procedure tfinddialogfo.oncre(const Sender: TObject);
begin
  icon := mainfo.icon;
  setlangfind();
end;

procedure tfinddialogfo.setlangfind();
begin

  Caption          := lang_stockcaption[ord(sc_search)];
  tbutton2.Caption := lang_stockcaption[ord(sc_next)];
  tbutton3.Caption := lang_stockcaption[ord(sc_prior)];
  butok.Caption := lang_stockcaption[ord(sc_close)];

  findtext.frame.Caption  := lang_xstockcaption[ord(sc_texttofind)] + ' 1';
  findtext2.frame.Caption := lang_xstockcaption[ord(sc_texttofind)] + ' 2';
  findtext3.frame.Caption := lang_xstockcaption[ord(sc_texttofind)] + ' 3';
  findtext4.frame.Caption := lang_xstockcaption[ord(sc_texttofind)] + ' 4';
  casesensitive.frame.Caption := lang_xstockcaption[ord(sc_casesensitive)];
  selectedonly.frame.Caption  := lang_xstockcaption[ord(sc_selectedonly)];
  wholeword.frame.Caption     := lang_xstockcaption[ord(sc_wholeword)];

end;

procedure tfinddialogfo.onbutclose(const sender: TObject);
begin
close;
end;

end.

