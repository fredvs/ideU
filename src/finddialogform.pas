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
 mseguiglob, mseificomp, mseificompglob, mseifiglob, msescrollbar, mseact,
 mseapplication, msedropdownlist, mseedit, msestream, sysutils;

type

 tfinddialogfo = class(tmseform)
   findtext: thistoryedit;
   statfile1: tstatfile;
   ok: tbutton;
   tlayouter1: tlayouter;
   tlayouter2: tlayouter;
   selectedonly: tbooleanedit;
   wholeword: tbooleanedit;
   casesensitive: tbooleanedit;
   tbutton2: tbutton;
   boolfind1: tbooleaneditradio;
   findtext2: thistoryedit;
   findtext3: thistoryedit;
   findtext4: thistoryedit;
   boolfind2: tbooleaneditradio;
   boolfind3: tbooleaneditradio;
   boolfind4: tbooleaneditradio;
   tbutton3: tbutton;
   procedure oncloseev(const sender: TObject);
   procedure onok(const sender: TObject);
   procedure onprior(const sender: TObject);
  private
   procedure valuestoinfo(out info: findinfoty);
   procedure infotovalues(const info: findinfoty);
 end;

procedure updatefindvalues(const astatfiler: tstatfiler;
                                          var aoptions: findinfoty);
function finddialogexecute(var info: findinfoty): boolean;

var
  finddialogfo: tfinddialogfo;
  findformcreated: boolean = false;
  findinfos: findinfoty;

implementation
uses
 finddialogform_mfm, sourceform, main;

procedure updatefindvalues(const astatfiler: tstatfiler;
                                          var aoptions: findinfoty);
var
 int1: integer;
begin
 with astatfiler,aoptions do begin
  updatevalue('finddtext',text);
  updatevalue('findhistory',history);
  int1:= {$ifdef FPC}longword{$else}byte{$endif}(options);
  updatevalue('findoptions',int1);
  options:= searchoptionsty({$ifdef FPC}longword{$else}byte{$endif}(int1));
 end;
end;

function finddialogexecute(var info: findinfoty): boolean;
begin
 result := true;

 finddialogfo:= tfinddialogfo.create(nil);
 findformcreated:= true;
 try

  info:= projectoptions.findreplaceinfo.find;
 if not sourcefo.activepage.edit.hasselection then begin
 info.selectedonly:= false;
 end;
  info.text:=  sourcefo.activepage.edit.selectedtext;
  finddialogfo.infotovalues(info);

   if mainfo.ismodal then
    finddialogfo.Show(true) else
    begin
    finddialogfo.Show;
    finddialogfo.bringtofront;
    end;

  result:= true;
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
findtxt : msestring;
histor : msestringarty;
begin
if boolfind1.value then
begin
findtxt := findtext.value;
histor := findtext.dropdown.valuelist.asarray;
end  else
if boolfind2.value then
begin
findtxt := findtext2.value;
histor := findtext2.dropdown.valuelist.asarray;
end else
if boolfind3.value then
begin 
findtxt := findtext3.value;
histor := findtext3.dropdown.valuelist.asarray;
end else
if boolfind4.value then
begin
findtxt := findtext4.value;
histor := findtext4.dropdown.valuelist.asarray;
end;

 with info do begin
  text:= findtxt;
  history:= histor;
  options:= encodesearchoptions(not casesensitive.value,wholeword.value);
  selectedonly:= self.selectedonly.value;
 end;
end;

procedure tfinddialogfo.infotovalues(const info: findinfoty);
begin
 with info do begin
  if boolfind1.value then
  begin
  findtext.value:= text;
  findtext.dropdown.valuelist.asarray:= history;
  end else
  if boolfind2.value then
  begin
  findtext.value:= text;
  findtext.dropdown.valuelist.asarray:= history;
  end else
  if boolfind3.value then
  begin
  findtext.value:= text;
  findtext.dropdown.valuelist.asarray:= history;
  end else
  if boolfind4.value then
  begin
  findtext4.value:= text;
  findtext4.dropdown.valuelist.asarray:= history;
  end;
  casesensitive.value:= not (so_caseinsensitive in options);
  wholeword.value:= so_wholeword in options;
//  self.selectedonly.value:= selectedonly;
 end;
end;

procedure tfinddialogfo.oncloseev(const sender: TObject);
begin
 findformcreated := false;
end;

procedure tfinddialogfo.onok(const sender: TObject);
begin
  finddialogfo.valuestoinfo(findinfos);
  sourcefo.activepage.dofind;
end;

procedure tfinddialogfo.onprior(const sender: TObject);
begin
 finddialogfo.valuestoinfo(findinfos);
  sourcefo.activepage.findback;
end;

end.
