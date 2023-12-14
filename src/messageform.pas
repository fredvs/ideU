{ MSEide Copyright (c) 1999-2014 by Martin Schreiber

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
unit messageform;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface
{$ifndef mse_allwarnings}
 {$if fpc_fullversion >= 030100}
  {$warn 5089 off}
  {$warn 5090 off}
  {$warn 5093 off}
  {$warn 6058 off}
 {$endif}
 {$if fpc_fullversion >= 030300}
  {$warn 6060 off}
  {$warn 6018 off}
  {$endif}
{$endif}
uses
 msetypes,msegui,mseclasses, sysutils, mseforms,msegrids,msemenus,msedataedits,
 msesimplewidgets,classes,mclasses, mseact, mseapplication, msedragglob,
  msedropdownlist, mseedit, mseglob, msegraphics, msegraphutils, msegridsglob,
  mseguiglob, mseificomp, mseificompglob, mseifiglob, msestat, msestatfile,
  msestream, msewidgetgrid;

type
 tmessagefo = class(tdockform)
   messages: tstringgrid;
   tpopupmenu1: tpopupmenu;
   procedure messagesoncellevent(const sender: tobject;
                                                   var info: celleventinfoty);
   procedure copyexe(const sender: TObject);
   procedure copyline(const sender: TObject);
   procedure copyselected(const sender: TObject);
   procedure findmessage(const sender: TObject);
   procedure oncreated(const sender: TObject);
   procedure onrowcountchanged(const sender: tcustomgrid);
  private
   fcolorrow: integer;
  public
   constructor create(aowner: tcomponent); override;
   procedure addtext(const atext: string);
   procedure updateprojectoptions;
 end;

var
 messagefo: tmessagefo;

implementation
uses
 actionsmodule, finddialogform, findmessage, main,
 messageform_mfm,sourcepage, confideu,projectoptionsform,
 sourceform,msewidgets,msestrings,msedatalist;

{$ifndef mse_allwarnings}
 {$if fpc_fullversion >= 030100}
  {$warn 5089 off}
  {$warn 5090 off}
  {$warn 5093 off}
  {$warn 6058 off}
 {$endif}
 {$if fpc_fullversion >= 030300}
  {$warn 6060 off}
  {$warn 6018 off}
  {$endif}
{$endif}

constructor tmessagefo.create(aowner: tcomponent);
begin
 fcolorrow:= -1;
 inherited create(aowner);
end;

procedure tmessagefo.messagesoncellevent(const sender: tobject;
  var info: celleventinfoty);
var
 page: tsourcepage;
begin
 if (info.cell.row >= 0) and iscellclick(info,[ccr_dblclick]) then begin
  locateerrormessage(
    messagefo.messages[0].datalist.getparagraph(info.cell.row),page);
 end;
end;

procedure tmessagefo.copyexe(const sender: TObject);
begin
 copytoclipboard(messages.datacols[0].datalist.concatstring('',lineend));
end;

procedure tmessagefo.addtext(const atext: string);
var
 int1,int2: integer;
 lev1: errorlevelty;
 col1,row1: integer;
 fn1: filenamety;
 strcol1: tstringcol;
 rowhigh1: integer;
 atext2: string;

 procedure setrowcolor(const arowcolor: rowstatenumty);
 var
  int2: integer;
 begin
  messages.rowcolorstate[int1]:= arowcolor;
  for int2:= int1 + 1 to rowhigh1 do begin
   if strcol1.noparagraph[int2] then begin
    messages.rowcolorstate[int2]:= arowcolor;
   end
   else begin
    break;
   end;
  end;
 end; //setrowcolor

var
 opt1: addcharoptionsty;

begin

atext2 := atext;

while system.pos('?25h', atext2) > 0 do
        system.delete(atext2, system.pos('?25h', atext2)-2, 6);

while system.pos('?25l', atext2) > 0 do
        system.delete(atext2, system.pos('?25l', atext2)-2, 6);

while system.pos('31m', atext2) > 0 do
        system.delete(atext2, system.pos('31m', atext2)-2, 5);

while system.pos('35m', atext2) > 0 do
        system.delete(atext2, system.pos('35m', atext2)-2, 5);
        
while system.pos('1m', atext2) > 0 do
        system.delete(atext2, system.pos('1m', atext2)-2, 4);

while system.pos('0m', atext2) > 0 do
        system.delete(atext2, system.pos('0m', atext2)-2, 4);
        
 with messages do begin
  opt1:= [aco_processeditchars];
  if projectoptions.o.stripmessageesc then begin
   include(opt1,aco_stripescsequence);
  end;
  int1:= datacols[0].readpipe(atext2,opt1,120);
  rowhigh1:= rowhigh;
  int2:= rowhigh1-int1;
  if int2 < 0 then begin
   int2:= 0;
  end;
  strcol1:= messages[0];
  with strcol1 do begin
   for int1:= rowhigh downto int2 do begin
    if not noparagraph[int1] and
             checkerrormessage(datalist.getparagraph(int1),
                                           lev1,fn1,col1,row1) then begin
     case lev1 of
      el_error: begin
      if mainfo.themenr = 0 then
       setrowcolor(0) else setrowcolor(5) ;
      end;
      el_warning: begin
        if mainfo.themenr = 0 then
       setrowcolor(1) else setrowcolor(4) ;
      end;
      el_note: begin
        if mainfo.themenr = 0 then
       setrowcolor(2) else setrowcolor(6) ;
      end;
      el_hint: begin
        if mainfo.themenr = 0 then
       setrowcolor(3) else setrowcolor(7) ;
      end;
     end;
    end;
   end;
  end;
  showlastrow;
 end;
end;

procedure tmessagefo.updateprojectoptions;
begin
if confideufo.usedefaulteditoroptions.value then
begin
with messages,confideufo do begin
rowcolors[0]:= colorerror.value;
rowcolors[1]:= colorwarning.value;
rowcolors[2]:= colornote.value;
rowcolors[3]:= colorhint.value;
invalidate;
end; end else
begin
 with messages,projectoptions.o do begin
  rowcolors[0]:= colorerror;
  rowcolors[1]:= colorwarning;
  rowcolors[2]:= colornote;
  rowcolors[3]:= colorhint;
  invalidate;
 end;
end;

end;

procedure tmessagefo.copyline(const sender: TObject);
begin
copytoclipboard(messages[0][messages.focusedcell.row]);
end;

procedure tmessagefo.copyselected(const sender: TObject);
begin
messages.copyselection;
end;

procedure tmessagefo.findmessage(const sender: TObject);
begin
messages.defocuscell;
messages.datacols.clearselection;
findmessagefo.show(true);
end;

procedure tmessagefo.oncreated(const sender: TObject);
begin
tpopupmenu1.menu.submenu[0].visible := false;
tpopupmenu1.menu.submenu[1].visible := false;
tpopupmenu1.menu.submenu[2].visible := false;
tpopupmenu1.menu.submenu[3].visible := false;
tpopupmenu1.menu.submenu[4].visible := false;
end;

procedure tmessagefo.onrowcountchanged(const sender: tcustomgrid);
begin
if messages.rowcount = 0 then 
begin
tpopupmenu1.menu.submenu[0].visible := false;
tpopupmenu1.menu.submenu[1].visible := false;
tpopupmenu1.menu.submenu[2].visible := false;
tpopupmenu1.menu.submenu[3].visible := false;
tpopupmenu1.menu.submenu[4].visible := false;
end else
begin
tpopupmenu1.menu.submenu[0].visible := true;
tpopupmenu1.menu.submenu[1].visible := true;
tpopupmenu1.menu.submenu[2].visible := true;
tpopupmenu1.menu.submenu[3].visible := true;
tpopupmenu1.menu.submenu[4].visible := true;
end;
end;

end.
