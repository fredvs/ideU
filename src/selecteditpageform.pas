{ MSEide Copyright (c) 1999-2010 by Martin Schreiber
   
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
unit selecteditpageform;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

uses
  msestockobjects,
   mseconsts_ide,
  mseconsts_ide_ru,
  mseconsts_ide_pt,
  mseconsts_ide_de,
  mseconsts_ide_es,
  mseconsts_ide_fr,
  mseforms,
  mselistbrowser,
  msetypes,
  msestrings,
  msegrids,
  msegui,
  msedispwidgets,
  msestat,
  msesimplewidgets,
  mseglob,
  msegridsglob;

type
  tselecteditpagefo = class(tmseform)
    list: tlistview;
    pathdisp: tstringdisp;
    openfilebutton: TButton;
    procedure doonitemevent(const Sender: tcustomlistview; const index: integer; var info: celleventinfoty);
    //   procedure doonshowhint(const sender: TObject; var info: hintinfoty);
    procedure fooncreate(const Sender: TObject);
    procedure setlangselectedit();
    procedure openfileonexecute(const Sender: TObject);
    procedure formonchildscaled(const Sender: TObject);
  private
    fpaths, frelpaths, fnames: filenamearty;
    fsortlist: integerarty;
  public
  end;

procedure selecteditpage;
procedure updatestat(const filer: tstatfiler);

implementation

uses
  selecteditpageform_mfm,
  sourceform,
  msedatalist,
  msedatanodes,
  msegraphutils,
  main,
  msefileutils,
  mseguiglob,
  msearrayutils;

var
  colwidth: integer;
  pos: rectty;

procedure updatestat(const filer: tstatfiler);
begin
  filer.setsection('selecteditpage');
  filer.updatevalue('colwidth', colwidth);
  with pos do
  begin
    filer.updatevalue('x', x);
    filer.updatevalue('y', y);
    filer.updatevalue('cx', cx);
    filer.updatevalue('cy', cy);
  end;
end;

procedure selecteditpage;
var
  fo: tselecteditpagefo;
begin
  fo := tselecteditpagefo.Create(nil);
  try
    fo.list.cellwidth := colwidth;
    if (pos.cx > 0) and (pos.y > 0) then
      fo.widgetrect := pos;
    if fo.Show(True, sourcefo.window) = mr_ok then
    begin
      sourcefo.Show;
      sourcefo.SetFocus;
    end;
    colwidth := fo.list.cellwidth;
    pos      := fo.window.normalwindowrect;
  finally
    fo.Free;
  end;
end;

{ tselecteditpagefo }

procedure tselecteditpagefo.doonitemevent(const Sender: tcustomlistview; const index: integer; var info: celleventinfoty);
begin
  if iscellclick(info) then
  begin
    sourcefo.files_tab.activepageindex := fsortlist[index];
    window.modalresult := mr_ok;
  end
  else if info.eventkind = cek_enter then
    if findfile(frelpaths[fsortlist[index]]) then
      pathdisp.Value := tosysfilepath(filepath(frelpaths[fsortlist[index]]))
    else
      pathdisp.Value := tosysfilepath(fpaths[fsortlist[index]]);
end;

{
procedure tselecteditpagefo.doonshowhint(const sender: TObject; var info: hintinfoty);
var
 item1: tlistitem;
begin
 item1:= list.itematpos(info.posrect.pos);
 if item1 <> nil then begin
  with info do begin
   caption:= fpaths[fsortlist[item1.index]];
   include(flags,hfl_show);
   showtime:= 0;
  end;
 end;
end;
}
procedure tselecteditpagefo.fooncreate(const Sender: TObject);
var
  int1, int2: integer;
begin
  setlength(fpaths, sourcefo.Count);
  setlength(frelpaths, sourcefo.Count);
  setlength(fnames, sourcefo.Count);
  for int1 := 0 to high(fpaths) do
  begin
    fpaths[int1]    := sourcefo.items[int1].filepath;
    frelpaths[int1] := sourcefo.items[int1].relpath;
    fnames[int1]    := sourcefo.items[int1].filename;
  end;
  sortarray(fnames, sms_upi, fsortlist);
  list.itemlist.add(fnames);
  int2     := sourcefo.files_tab.activepageindex;
  for int1 := 0 to high(fsortlist) do
    if fsortlist[int1] = int2 then
    begin
      list.focusedindex := int1;
      break;
    end;
  setlangselectedit();  
end;

procedure tselecteditpagefo.openfileonexecute(const Sender: TObject);
begin
  if mainfo.opensource(fk_source, False) then
    Release;
end;

procedure tselecteditpagefo.formonchildscaled(const Sender: TObject);
begin
  placeyorder(0, [1], [list, pathdisp], 1);
  openfilebutton.Height := pathdisp.Height;
  aligny(wam_center, [pathdisp, openfilebutton]);
  list.synctofontheight;
end;

procedure tselecteditpagefo.setlangselectedit();
begin
  Caption := stockobjects.captions[sc_select_edit_Page] + '   (Ctrl+E)' ;
  openfilebutton.caption := stockobjects.captions[sc_open];
end;

initialization
  colwidth := 100;
end.

