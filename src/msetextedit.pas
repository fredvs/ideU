{ MSEgui Copyright (c) 1999-2014 by Martin Schreiber

    See the file COPYING.MSE, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
}
unit msetextedit;

{$ifdef FPC}
 {$mode objfpc}{$h+}{$interfaces corba}
{$endif}
{$ifndef mse_no_ifi}
 {$define mse_with_ifi}
{$endif}

interface

uses
  mseeditglob,
  mseedit,
  msewidgetgrid,
  Classes,
  mclasses,
  msedatalist,
  msegraphics,
  msestream,
  msedragglob,
  msesys,
  mseassistiveclient,
  msetypes,
  mserichstring,
  msestat,
  msestatfile,
  mseclasses,
  mseinplaceedit,
  msegrids,
  mseevent,
  mseguiglob,
  msegui,
  msegraphutils,
  msestrings,
  msedrawtext,
  msearrayprops,
  msemenus,
  msepointer,
  msegridsglob{$ifdef mse_with_ifi},
  mseificomp{$endif},
  mseglob;

const

  defaulttexteditoptions        = (defaultoptionsedit +
    [oe_linebreak, oe_nofirstarrownavig]) -
    [oe_autoselect, oe_autoselectonfirstclick, oe_endonenter,
    oe_resetselectonexit, oe_undoonesc, oe_shiftreturn,
    oe_trimleft, oe_trimright, oe_uppercase, oe_lowercase];

  texteditminimalframe: framety = (left: 1; top: 0; right: 1; bottom: 0);
  defaulttexteditwidgetoptions  =
    (defaulteditwidgetoptions
    { - [ow_fontglyphheight]}){ + [ow_fontlineheight]};
  defaulttexteditwidgetoptions1 =
    (defaulteditwidgetoptions1 - [ow1_fontglyphheight]) +
    [ow1_fontlineheight];

type

  textmouseeventinfoty = record
    eventkind: celleventkindty;
    mouseeventinfopo: pmouseeventinfoty;
    pos: gridcoordty;
  end;

  tcustomtextedit  = class;
  textmouseeventty = procedure(const Sender: TObject; var info: textmouseeventinfoty) of object;
  textdraweventty  = procedure(const Sender: tcustomtextedit; const Canvas: tcanvas; const atext: richstringty; const cellinfo: pcellinfoty; var handled: Boolean) of object;
  //cellinfo = nil for focused widget
  setupeditoreventty = procedure(const Sender: tcustomtextedit) of object;

  texteditstatety  = (tes_selectinvalid, tes_cellentering, tes_xposinvalid);
  texteditstatesty = set of texteditstatety;

  tgridrichstringdatalist = class(trichstringdatalist)
  private
    fowner: twidgetcol;
  protected
    function getdefault: Pointer; override;
  public
    constructor Create(owner: twidgetcol); reintroduce;
  end;

  texteditoptionty  = (teeo_bom, teeo_nobom); //[] -> use loaded
  texteditoptionsty = set of texteditoptionty;

  tcustomtextedit = class(tcustomedit, igridwidget, istatfile,
    iassistiveclientgridwidget)
  private
    fstatfile: tstatfile;
    fstatvarname: msestring;
    fselectstart, fselectend: gridcoordty;
    fmodified: Boolean;
    fonmodifiedchanged: booleanchangedeventty;
    fontextmouseevent: textmouseeventty;
    fmousetextpos: gridcoordty;
    foneditnotification: editnotificationeventty;
    foncellevent: celleventty;
    fonfontchanged: notifyeventty;
    fmarginlinecolor: colorty;
    fmarginlinepos: integer;
    ftabulators: ttabulators;
    fencoding: charencodingty;
    fxpos: integer;
    fstatpriority: integer;
    fhasbom: Boolean;
    foptions: texteditoptionsty;
    feolstyle: eolstylety;
    fondrawtext: textdraweventty;
    fonsetupeditor: setupeditoreventty;
    procedure setstatfile(const Value: tstatfile);
    function geteditpos: gridcoordty;
    procedure seteditpos1(const Value: gridcoordty);
    function getgridvalue(const index: integer): msestring;
    procedure setgridvalue(const index: integer; const Value: msestring);
    function getgridvalues: msestringarty;
    procedure setgridvalues(const Value: msestringarty);
    function getrichlines(const index: integer): richstringty;
    procedure setrichlines(const index: integer; const Value: richstringty);
    function getrichformats(const index: integer): formatinfoarty;
    procedure setrichformats(const index: integer; const avalue: formatinfoarty);
    procedure setmodified(const avalue: Boolean);
    procedure setdatalist(const avalue: tgridrichstringdatalist);

    procedure mousepostotextpos1(const row: integer; const mousepos: pointty; var textpos: gridcoordty; var Result: Boolean);
    procedure setmarginlinecolor(avalue: colorty);
    procedure setmarginlinepos(const avalue: integer);
    procedure colchanged;
    function gettabulators: ttabulators;
    procedure settabulators(const Value: ttabulators);
    //   procedure setreadonly(const avalue: boolean);
    function getrow: integer;
    procedure setrow(const avalue: integer);
    function getcol: integer;
    procedure setcol(const avalue: integer);
    procedure setoptions(const avalue: texteditoptionsty);
  protected
    ftextstate: texteditstatesty;
    fgridintf: iwidgetgrid;
    fupdating: integer;
    fnotificationchangelock: integer;
    ffilename: filenamety;
    ffilerights: filerightsty;
    flines: tgridrichstringdatalist;
    ffoundeolstyle: eolstylety;
    procedure setoptionsedit(const avalue: optionseditty); override;
    procedure setoptionsedit1(const avalue: optionsedit1ty); override;

    function beforechange: Boolean; //true if not aborted
    procedure fontchanged; override;
    procedure tabulatorschanged(const Sender: tarrayprop; const index: integer);
    procedure painttext(const Canvas: tcanvas); override;
    procedure dobeforepaintforeground(const Canvas: tcanvas); override;
    procedure dokeydown(var info: keyeventinfoty); override;
    procedure getstate(out state: texteditstatety); virtual;
    procedure setstate(const state: texteditstatety); virtual;
    procedure setfilename(Value: filenamety); //no const!
    procedure insertlinebreak; virtual;
    procedure editnotification(var info: editnotificationinfoty); override;
    procedure updateindex(select: Boolean);
    procedure textinserted(const apos: gridcoordty; const atext: msestring; const selected: Boolean; const endpos: gridcoordty; const backwards: Boolean); virtual;
    procedure textdeleted(const apos: gridcoordty; const atext: msestring; const selected: Boolean; const endpos: gridcoordty; const backwards: Boolean); virtual;

    procedure dotextmouseevent(var info: textmouseeventinfoty);
    procedure dosetupeditor();
    procedure setupeditor; override;
    procedure dofontheightdelta(var delta: integer); override;
    procedure sizechanged; override;
    function getinnerframe: framety; override;
    function textclipped(const arow: integer; out acellrect: rectty): Boolean; virtual;
    function textclipped(const arow: integer): Boolean;

    function getiassistiveclient(): iassistiveclient override;
    //iassistiveclientgridwidget
    function getassistivecolumncaption(): msestring virtual;
    //igridwidget
    procedure setfirstclick(var ainfo: mouseeventinfoty);
    function createdatalist(const Sender: twidgetcol): tdatalist; virtual;
    procedure datalistdestroyed;
    function getdatalistclass: datalistclassty; virtual;
    function getinitvalue: Pointer;
    function getdefaultvalue: Pointer;
    function getrowdatapo(const arow: integer): Pointer; virtual;
    procedure setgridintf(const intf: iwidgetgrid);
    function getgridintf: iwidgetgrid;
    function needscellfocuspaint(): Boolean;
    function getcellcursor(const arow: integer; const acellzone: cellzonety; const apos: pointty): cursorshapety; virtual;
    procedure updatecellzone(const row: integer; const apos: pointty; var Result: cellzonety); virtual;
    function getnulltext: msestring;
    procedure drawcell(const Canvas: tcanvas);
    procedure updateautocellsize(const Canvas: tcanvas); virtual;
    procedure beforecelldragevent(var ainfo: draginfoty; const arow: integer; var handled: Boolean); virtual;
    procedure aftercelldragevent(var ainfo: draginfoty; const arow: integer; var handled: Boolean); virtual;
    procedure initgridwidget;
    procedure valuetogrid(row: integer);
    procedure gridtovalue(row: integer);
    procedure setvaluedata(const Source); virtual;
    procedure getvaluedata(out dest); virtual;
    procedure docellevent(const ownedcol: Boolean; var info: celleventinfoty); virtual;
    function sortfunc(const l, r): integer;
    procedure gridvaluechanged(const index: integer); virtual;
    procedure updatecoloptions(const aoptions: coloptionsty);
    procedure updatecoloptions1(const aoptions: coloptions1ty);
    procedure statdataread; virtual;
    procedure griddatasourcechanged;
   {$ifdef mse_with_ifi}
    function getifilink: tifilinkcomp;
    procedure dochange; override;
   {$endif}
    procedure setparentgridwidget(const intf: igridwidget);
    procedure childdataentered(const Sender: igridwidget); virtual;
    procedure childfocused(const Sender: igridwidget); virtual;

    //istatfile
    procedure dostatread(const reader: tstatreader);
    procedure dostatwrite(const writer: tstatwriter);
    procedure statreading;
    procedure statread;
    function getstatvarname: msestring;
    function getstatpriority: integer;
    procedure checkgrid;

    procedure setedpos(const Value: gridcoordty; const select: Boolean; const donotify: Boolean; const ashowcell: cellpositionty);
    procedure internalclearselection;
    procedure internaldeletetext(const start, stop: gridcoordty; const userinput: Boolean);
    //iassistiveclient
    function getassistivetext(): msestring; override;
    function getassistiveflags: assistiveflagsty; override;
    //iassistiveclientgrid
    function getassistivecelltext(const arow: int32): msestring;
  public
    constructor Create(aowner: TComponent); override;
    destructor Destroy; override;
    procedure createtabulators;
    function actualcolor: colorty; override;
    procedure synctofontheight; override;
    procedure reloadfile(restorestate: Boolean = True);
    procedure loadfromstream(const stream: ttextstream; restorestate: Boolean = False);
    procedure loadfromfile(afilename: filenamety; //no const!
      restorestate: Boolean = False); virtual;
    procedure savetostream(const stream: ttextstream; const resetmodified: Boolean);
    procedure savetofile(const afilename: filenamety = '');
    //afilename = '' -> current filename
    property filename: filenamety read ffilename;
    property filerights: filerightsty read ffilerights write ffilerights;

    procedure beginupdate; virtual;
    procedure endupdate; virtual;
    procedure Clear; virtual;
    //   function filename: filenamety;

    procedure seteditpos(const Value: gridcoordty; const select: Boolean = False; const ashowcell: cellpositionty = cep_nearest);
    procedure inserttext(const apos: gridcoordty; const atext: msestring; out aendpos: gridcoordty; selected: Boolean = False; insertbackwards: Boolean = False); overload;
    procedure inserttext(const apos: gridcoordty; const atext: msestring; selected: Boolean = False; insertbackwards: Boolean = False); overload;
    procedure inserttext(const atext: msestring; selected: Boolean = False); overload;
    procedure deletetext(const start, stop: gridcoordty);
    function appendrow(const atext: msestring): integer; overload;
    function appendrow(const atext: richstringty): integer; overload;

    function hasselection: Boolean; override;
    function selectedtext: msestring;
    function selectedrichtext: richstringty;
    procedure getselectedrows(out start, stop: integer);

    property optionsedit default defaulttexteditoptions;
    procedure setfontstyle(const start, stop: gridcoordty; const astyle: fontstylety; const aset: Boolean; const afontcolor: colorty = cl_default; const acolorbackground: colorty = cl_default);
    //astyle = fs_force -> set colors only
    property selectstart: gridcoordty read fselectstart;
    property selectend: gridcoordty read fselectend;
    procedure setselection(const start, stop: gridcoordty; const aseteditpos: Boolean = False; const ashowcell: cellpositionty = cep_nearest);
    procedure clearselection;
    procedure copyselection;
    procedure cutselection;
    function canpaste: Boolean;
    procedure paste;
    procedure deleteselection;
    procedure selectall;

    function find(const atext: msestring; options: searchoptionsty; var textpos: gridcoordty; const endpos: gridcoordty; selectfound: Boolean = False; const ashowcell: cellpositionty = cep_nearest): Boolean;

    function gettext(const start, stop: gridcoordty): msestring
      overload reintroduce;
    function gettext: msestring overload reintroduce;
    procedure settext(const atext: msestring) reintroduce;
    function getrichtext(const start, stop: gridcoordty): richstringty;

    function getcellframe: framety; virtual;

    function linecount: integer;
    property gridvalue[const index: integer]: msestring read getgridvalue write setgridvalue; default;
    property gridvalues: msestringarty read getgridvalues write setgridvalues;
    property richlines[const index: integer]: richstringty read getrichlines write setrichlines;
    property richformats[const index: integer]: formatinfoarty read getrichformats write setrichformats;
    property datalist: tgridrichstringdatalist read flines write setdatalist;

    function mousepostotextpos(const mousepos: pointty; out textpos: gridcoordty; widgetorg: Boolean = False): Boolean;
    //if widgetorg = false -> org mousepos = topleft of col
    // org mousepos = clientpos otherwise
    //false if out of text, textpos clamped to textrange
    function textpostomousepos(const textpos: gridcoordty; const screenorg: Boolean = False): pointty;
    function textpostomouserect(const textpos: gridcoordty; const screenorg: Boolean = False): rectty;
    //y:= top of character cell cx = 0 cy = linespacing
    property editpos: gridcoordty read geteditpos write seteditpos1;
    property row: integer read getrow write setrow;
    property col: integer read getcol write setcol;
    property modified: Boolean read fmodified write setmodified;

    property encoding: charencodingty read fencoding write fencoding default ce_locale;
    property eolstyle: eolstylety read feolstyle write feolstyle default eol_default;
    //applied to write stream if stream.eolstyle = ce_default
    //ce_default -> use foundeolstyle of last read stream
    //ce_default -> system eol
    property options: texteditoptionsty read foptions write setoptions default [];
    property textflags default defaulttextflags - [tf_noselect];
    property statfile: tstatfile read fstatfile write setstatfile;
    property statvarname: msestring read getstatvarname write fstatvarname;
    property statpriority: integer read fstatpriority write fstatpriority default 0;
    property tabulators: ttabulators read gettabulators write settabulators;
    property marginlinepos: integer read fmarginlinepos write setmarginlinepos default 0;
    //offset to innerclientrect.x
    property marginlinecolor: colorty read fmarginlinecolor write setmarginlinecolor default cl_none;
    property onfontchanged: notifyeventty read fonfontchanged write fonfontchanged;
    property onmodifiedchanged: booleanchangedeventty read fonmodifiedchanged write fonmodifiedchanged;
    property ontextmouseevent: textmouseeventty read fontextmouseevent write fontextmouseevent;
    property oneditnotifcation: editnotificationeventty read foneditnotification write foneditnotification;
    property ondrawtext: textdraweventty read fondrawtext write fondrawtext;
    property onsetupeditor: setupeditoreventty read fonsetupeditor write fonsetupeditor;
    property oncellevent: celleventty read foncellevent write foncellevent;
  published
    property optionswidget default defaulttexteditwidgetoptions;
    property optionswidget1 default defaulttexteditwidgetoptions1;
  end;

  ttextedit = class(tcustomtextedit)
  published
    property font;
    property caretwidth;
    property cursorreadonly;
    property optionsedit1; //before optionsedit!
    property optionsedit;
    property textflags;
    property textflagsactive;

    property statfile;
    property statvarname;
    property statpriority;
    property encoding;
    property options;
    property marginlinepos;
    //offset to innerclientrect.x
    property marginlinecolor;
    property tabulators;

    property onchange;
    property ontextedited;
    property onkeydown;
    property onkeyup;
    property oncopytoclipboard;
    property onpastefromclipboard;

    property onfontchanged;
    property onmodifiedchanged;
    property ontextmouseevent;
    property oneditnotifcation;
    property oncellevent;
    property ondrawtext;
    property onsetupeditor;
  end;

  tundotextedit = class(ttextedit, iundo)
  private
    function getmaxundocount: integer;
    procedure setmaxundocount(const Value: integer);
    function getmaxundosize: integer;
    procedure setmaxundosize(const Value: integer);
  protected
    procedure textinserted(const apos: gridcoordty; const atext: msestring; const selected: Boolean; const endpos: gridcoordty; const backwards: Boolean); override;
    procedure textdeleted(const apos: gridcoordty; const atext: msestring; const selected: Boolean; const endpos: gridcoordty; const backwards: Boolean); override;
    procedure getselectstart(var selectstartpos: gridcoordty);
    procedure setselectstart(const selectstartpos: gridcoordty);
  protected
  public
    constructor Create(aowner: TComponent); override;
    procedure Clear; override;
    procedure undo;
    procedure redo;
    function canundo: Boolean;
    function canredo: Boolean;
    procedure lowercase;  //selection -> lowercase;
    procedure uppercase;  //selection -> uppercase
    procedure tabtospace; //selection tab -> space
  published
    property maxundocount: integer read getmaxundocount write setmaxundocount default defaultundomaxcount;
    property maxundosize: integer read getmaxundosize write setmaxundosize default defaultundobuffermaxsize;
  end;

procedure normalizetextrect(const po1, po2: gridcoordty; out start, stop: gridcoordty);
function istextdblclick(const ainfo: textmouseeventinfoty): Boolean;

implementation

uses
  confideu,
  sourceform,
  msefileutils,
  SysUtils,
  msesysutils,
  msewidgets,
  msebits,
  msekeyboard,
  mseactions;

const
  valuevarname = 'value';

type
  tcustomwidgetgrid1 = class(tcustomwidgetgrid);
  tinplaceedit1 = class(tinplaceedit);
  twidgetcol1 = class(twidgetcol);
  tcustomrowstatelist1 = class(tcustomrowstatelist);
  twidget1 = class(twidget);

procedure normalizetextrect(const po1, po2: gridcoordty; out start, stop: gridcoordty);
begin
  if po1.row > po2.row then
  begin
    start := po2;
    stop  := po1;
  end
  else if po1.row < po2.row then
  begin
    start := po1;
    stop  := po2;
  end
  else if po1.col > po2.col then
  begin
    start := po2;
    stop  := po1;
  end
  else
  begin
    start := po1;
    stop  := po2;
  end;
end;

function istextdblclick(const ainfo: textmouseeventinfoty): Boolean;
begin
  Result := (ainfo.eventkind = cek_buttonpress) and
    (ss_double in ainfo.mouseeventinfopo^.shiftstate);
end;

function createtgridrichstringdatalist(const aowner: twidgetcol): tdatalist;
begin
  Result := tgridrichstringdatalist.Create(aowner);
end;

{ tgridrichstringdatalist }

constructor tgridrichstringdatalist.Create(owner: twidgetcol);
begin
  fowner := owner;
  inherited Create;
  include(fstate, dls_nostreaming);
end;

function tgridrichstringdatalist.getdefault: Pointer;
begin
  if twidgetcol1(fowner).fintf <> nil then
    Result := twidgetcol1(fowner).fintf.getdefaultvalue
  else
    Result := inherited getdefault;
end;

{ tcustomtextedit }

constructor tcustomtextedit.Create(aowner: TComponent);
begin
  feolstyle        := eol_default;
  ffilerights      := defaultfilerights;
  fmousetextpos    := invalidcell;
  fmarginlinecolor := cl_none;
  if feditor = nil then
    feditor := tinplaceedit.Create(self, iedit(self), True);
  inherited;
  foptionswidget  := defaulttexteditwidgetoptions;
  foptionswidget1 := defaulttexteditwidgetoptions1;
  optionsedit     := defaulttexteditoptions;
  textflags       := defaulttextflags - [tf_noselect];
end;

destructor tcustomtextedit.Destroy;
begin
  inherited;
  ftabulators.Free;
end;

function tcustomtextedit.actualcolor: colorty;
begin
  if (fgridintf <> nil) and (fcolor = cl_default) then
    Result := fgridintf.getcol.rowcolor(fgridintf.getrow)
  else
    Result := inherited actualcolor;
end;

procedure tcustomtextedit.synctofontheight;
begin
  inherited;
  if (fgridintf <> nil) and not (tf_rotate90 in textflags) then
    fgridintf.getcol.grid.datarowheight := bounds_cy - font.glyphheight + font.lineheight;
end;

procedure tcustomtextedit.dofontheightdelta(var delta: integer);
begin
  inherited;
  gridwidgetfontheightdelta(self, fgridintf, delta);
{
 inherited;
 if fgridintf <> nil then begin
  with fgridintf.getcol.grid do begin
   datarowheight:= datarowheight + delta;
  end;
 end;
}
end;

procedure tcustomtextedit.sizechanged;
begin
  inherited;
  gridwidgetsized(self, fgridintf);
end;

procedure tcustomtextedit.setgridintf(const intf: iwidgetgrid);
begin
  fgridintf := intf;
  if (intf <> nil) then
  begin
    flines := tgridrichstringdatalist(fgridintf.getcol.datalist);
    if (ow1_autoscale in foptionswidget1) and
      (foptionswidget1 * [ow1_fontglyphheight, ow1_fontlineheight] <> []) then
      fgridintf.getcol.grid.datarowheight := bounds_cy;
  end;
end;

function tcustomtextedit.getcellframe: framety;
begin
  if fframe <> nil then
    Result := frame.cellframe
  else if fgridintf <> nil then
    Result := tgridarrayprop(fgridintf.getcol.prop).innerframe
  else
    Result := getinnerframe;
end;

function tcustomtextedit.needscellfocuspaint(): Boolean;
begin
  Result := inherited needsfocuspaint();
end;

function tcustomtextedit.getcellcursor(const arow: integer; const acellzone: cellzonety; const apos: pointty): cursorshapety;
begin
  Result := actualcursor(nullpoint);
end;

procedure tcustomtextedit.updatecellzone(const row: integer; const apos: pointty; var Result: cellzonety);
begin
  //dummy
end;

function tcustomtextedit.getnulltext: msestring;
begin
  Result := '';
end;

function tcustomtextedit.createdatalist(const Sender: twidgetcol): tdatalist;
begin
  flines := tgridrichstringdatalist.Create(Sender);
  Result := flines;
end;

function tcustomtextedit.getdatalistclass: datalistclassty;
begin
  Result := tgridrichstringdatalist;
end;

procedure tcustomtextedit.dobeforepaintforeground(const Canvas: tcanvas);
var
  int1: integer;
begin
  if fmarginlinecolor <> cl_none then
  begin
    int1 := innerclientpos.x + fmarginlinepos;
    if fframe = nil then
      Inc(int1, texteditminimalframe.left);
    Canvas.drawline(makepoint(int1, 0), makepoint(int1, clientsize.cy),
      fmarginlinecolor);
  end;
end;

procedure tcustomtextedit.painttext(const Canvas: tcanvas);
var
  b1: Boolean;
begin
  if Assigned(fondrawtext) then
  begin
    b1 := False;
    fondrawtext(self, Canvas, feditor.richtext, nil, b1);
    if b1 then
      Exit;
  end;
  inherited;
end;

procedure tcustomtextedit.drawcell(const Canvas: tcanvas);
var
  rect1: rectty;
  int1: integer;
  b1: Boolean;
begin
  with cellinfoty(Canvas.drawinfopo^) do
  begin
    if Assigned(fondrawtext) then
    begin
      b1 := False;
      fondrawtext(self, Canvas, prichstringty(datapo)^, Canvas.drawinfopo, b1);
      if b1 then
        Exit;
    end;
    if calcautocellsize then
    begin
      rect1 := textrect(Canvas, prichstringty(datapo)^, innerrect,
        feditor.textflags, nil, ftabulators);
      int1  := rect.cx + rect1.cx - innerrect.cx;
      if int1 > autocellsize.cx then
        autocellsize.cx := rect1.cx;
      int1 := rect.cy + rect1.cy - innerrect.cy;
      if int1 > autocellsize.cy then
        autocellsize.cy := int1;
    end
    else
    begin
      if fmarginlinecolor <> cl_none then
      begin
        int1 := innerrect.x + fmarginlinepos;
        Canvas.drawline(makepoint(int1, 0), makepoint(int1, rect.cy), fmarginlinecolor);
      end;
      drawtext(Canvas, prichstringty(datapo)^, innerrect, feditor.textflags, nil,
        ftabulators);
    end;
  end;
end;

procedure tcustomtextedit.updateautocellsize(const Canvas: tcanvas);
begin
  drawcell(Canvas);
end;

function tcustomtextedit.beforechange: Boolean; //true if not aborted
begin
  Result := feditor.beforechange;
end;

procedure tcustomtextedit.fontchanged;
begin
  inherited;
  if fgridintf <> nil then
    fgridintf.getcol.changed;
  if canevent(tmethod(fonfontchanged)) then
    fonfontchanged(self);
end;

{
procedure tcustomtextedit.updatecellzone(const pos: pointty; var result: cellzonety);
begin
 //dummy
end;
}
function tcustomtextedit.getdefaultvalue: Pointer;
begin
  Result := nil;
end;

function tcustomtextedit.getrowdatapo(const arow: integer): Pointer;
begin
  Result := nil;
end;

procedure tcustomtextedit.setfirstclick(var ainfo: mouseeventinfoty);
begin
  //dummy
end;

function tcustomtextedit.getinitvalue: Pointer;
begin
  Result := nil;
end;

procedure tcustomtextedit.valuetogrid(row: integer);
begin
  fgridintf.setdata(row, feditor.richtext);
end;

procedure tcustomtextedit.gridtovalue(row: integer);
var
  text1: richstringty;
begin
  if fupdating = 0 then
  begin
    fgridintf.getdata(row, text1);
    Inc(fupdating);
    try
      feditor.richtext := text1;
    finally
      Dec(fupdating);
    end;
  end;
end;

procedure tcustomtextedit.initgridwidget;
begin
  optionswidget1 := optionswidget1 - [ow1_autoscale];
  frame          := nil;
  with fgridintf.grid do
    optionsgrid := optionsgrid + [og_autofirstrow];
  optionsskin := optionsskin + defaultgridskinoptions;
end;

function tcustomtextedit.sortfunc(const l, r): integer;
begin
  Result := 0;
end;

procedure tcustomtextedit.gridvaluechanged(const index: integer);
begin
  modified := True;
end;

procedure tcustomtextedit.updatecoloptions(const aoptions: coloptionsty);
var
  opt1: optionsedit1ty;
begin
  opt1 := feditor.optionsedit1;
  fgridintf.coloptionstoeditoptions(foptionsedit, opt1);
  feditor.optionsedit1 := opt1;
end;

procedure tcustomtextedit.updatecoloptions1(const aoptions: coloptions1ty);
begin
  //dummy
end;

procedure tcustomtextedit.statdataread;
begin
  modified := False;
end;

procedure tcustomtextedit.griddatasourcechanged;
begin
  //dummy
end;

{$ifdef mse_with_ifi}
function tcustomtextedit.getifilink: tifilinkcomp;
begin
  Result := nil;
end;

procedure tcustomtextedit.dochange;
begin
  inherited;
 {
 if not (ws_loadedproc in fwidgetstate) then begin
  if fifiserverintf <> nil then begin
   fifiserverintf.valuechanged(iificlient(self));
  end;
 end;
 }
end;

{$endif mse_with_ifi}

procedure tcustomtextedit.setoptionsedit(const avalue: optionseditty);
var
  opt1: optionseditty;
begin
  opt1 := avalue - [oe_trimleft, oe_trimright, oe_uppercase, oe_lowercase];
  if foptionsedit <> opt1 then
  begin
    inherited setoptionsedit(opt1);
    if fgridintf <> nil then
      fgridintf.updateeditoptions(foptionsedit, feditor.optionsedit1);
  end;
end;

procedure tcustomtextedit.setoptionsedit1(const avalue: optionsedit1ty);
begin
  inherited;
  if fgridintf <> nil then
    fgridintf.updateeditoptions(foptionsedit, feditor.optionsedit1);
end;

procedure tcustomtextedit.dokeydown(var info: keyeventinfoty);
var
  shiftstate1: shiftstatesty;
  int1, int2: integer;
  indexbefore: integer;
  rect1: rectty;
  bo1, bo2: Boolean;
begin
  with info do
  begin
    shiftstate1 := shiftstate * shiftstatesmask;
    if (tf_wordbreak in textflagsactive) and
      (shiftstate1 - [ss_shift] = []) then
    begin
      include(info.eventstate, es_processed);
      with feditor do
      begin
        int2 := fxpos;
        int1 := 0;
        case key of
          key_up: int1 := -self.font.lineheight;
          key_down: int1 := self.font.lineheight;
          else exclude(info.eventstate, es_processed);
        end;
        if int1 <> 0 then
        begin
          int1  := caretpos.y + int1;
          rect1 := textrect;
          if int1 < rect1.y then
            int1 := rect1.y;
          if int1 >= rect1.y + rect1.cy then
            int1      := rect1.y + rect1.cy - 1;
          indexbefore := curindex;
          moveindex(mousepostotextindex(makepoint(fxpos, int1)),
            ss_shift in info.shiftstate);
          if ss_shift in info.shiftstate then
            invalidate;
            //     if fxpos < int2 then begin
          fxpos := int2; //restore
            //     end;
          if {(oe_exitoncursor in foptionsedit) and} (indexbefore = curindex) and
            {(info.shiftstate = []) and}
            ((info.key = key_down) or (info.key = key_up)) then
            exclude(info.eventstate, es_processed);
        end;
      end;
    end;
    if not (es_processed in eventstate) and (fgridintf <> nil) then
    begin
      if ((shiftstate1 = [ss_shift, ss_ctrl]) or (shiftstate1 = [ss_ctrl])) then
        if key = key_home then
        begin
          seteditpos(makegridcoord(0, 0), ss_shift in shiftstate1);
          include(eventstate, es_processed);
        end
        else if key = key_end then
        begin
          seteditpos(makegridcoord(bigint, bigint), ss_shift in shiftstate1);
          include(eventstate, es_processed);
        end;
      if isenterkey(self, info.key) and (shiftstate1 - [ss_shift] = []) and
        (foptionsedit * [oe_readonly, oe_linebreak] = [oe_linebreak]) and
        ((ss_shift in shiftstate1) xor not (oe_shiftreturn in foptionsedit)) then
      begin
        insertlinebreak;
        include(eventstate, es_processed);
      end;
    end;
    if flines <> nil then
    begin
      if not (es_processed in eventstate) and
        issysshortcut(sho_rowdelete, info) then
      begin
        int1 := col;
        feditor.begingroup;
        try
          if (fgridintf <> nil) and
            tcustomwidgetgrid1(fgridintf.getcol.grid).
            deleterowconfirmation() then
          begin

            internaldeletetext(mgc(0, row), mgc(0, row + 1), True);
            col := int1;
          end;
        finally
          feditor.endgroup;
        end;
        include(eventstate, es_processed);
      end;
      if not (es_processed in eventstate) then
      begin
        bo1 := issysshortcut(sho_rowappend, info);
        if bo1 or issysshortcut(sho_rowinsert, info) then
        begin
          feditor.begingroup;
          try
            bo2  := False;
            int1 := col;
            clearselection;
            if bo1 then
              col := length(flines[row])//append

            else if row = 0 then
            begin
              bo2     := True;
              col     := 0;
            end
            else
              editpos := mgc(length(flines[row - 1]), row - 1);
            insertlinebreak;
            if not bo1 then
            begin //insert
              int2 := row;
              if not bo2 then
                Inc(int2);
              editpos := mgc(int1, int2);
            end;
          finally
            feditor.endgroup;
          end;
          include(eventstate, es_processed);
        end;
      end;
    end;
    if not (es_processed in eventstate) then
      inherited;
  end;
end;

procedure tcustomtextedit.reloadfile(restorestate: Boolean = True);
begin
  Inc(fnotificationchangelock);
  try
    loadfromfile(ffilename, restorestate);
  finally
    Dec(fnotificationchangelock);
  end;
end;

procedure tcustomtextedit.loadfromstream(const stream: ttextstream; restorestate: Boolean = False);
var
  statsave: texteditstatety;
  po1: pmsestring;
begin
  checkgrid;
  if restorestate then
    getstate(statsave);
  beginupdate;
  try
    Clear();
    ffilerights    := stream.filerights;
    flines.loadfromstream(stream);
    ffoundeolstyle := stream.foundeolstyle();
    fhasbom        := False;
    if stream.encoding = ce_utf8 then
      if (flines.Count > 0) then
      begin
        po1 := flines.datapo;
        if (po1^ <> '') and (card16(po1^[1]) = $feff) then
        begin
          fhasbom := True;
          po1^    := copy(po1^, 2, bigint);
        end;
      end;
    fgridintf.getcol.grid.rowcount := flines.Count;
    if restorestate then
      setstate(statsave);
  finally
    endupdate;
  end;
  modified := False;
end;

procedure tcustomtextedit.loadfromfile(afilename: filenamety; restorestate: Boolean = False);
var
  stream: ttextstream;
begin
  checkgrid;
  stream := ttextstream.Create(afilename, fm_read);
  try
    stream.encoding := fencoding;
    loadfromstream(stream, restorestate);
    setfilename(afilename);
  finally
    stream.Free;
  end;
end;

procedure tcustomtextedit.savetostream(const stream: ttextstream; const resetmodified: Boolean);
const
  bom: array[0..2] of byte = ($ef, $bb, $bf);
begin
  stream.encoding := fencoding;
  if stream.eolstyle = eol_default then
    if feolstyle = eol_default then
      stream.eolstyle := ffoundeolstyle
    else
      stream.eolstyle := feolstyle;
  // stream.filerights:= ffilerights;
  if (fencoding = ce_utf8) and (fhasbom or (teeo_bom in foptions)) and not (teeo_nobom in foptions) then
    stream.writebuffer(bom, length(bom));
  flines.savetostream(stream);
  if resetmodified then
    modified := False;
end;

procedure tcustomtextedit.savetofile(const afilename: filenamety = '');
//afilename = '' -> current filename
var
  stream: ttextstream;
  str1: filenamety;
begin
  if afilename = '' then
    str1 := ffilename
  else
    str1 := afilename;
  stream := ttextstream.createtransaction(str1, ffilerights);
  try
    savetostream(stream, True);
    setfilename(str1);
  finally
    stream.Free;
  end;
end;

procedure tcustomtextedit.getstate(out state: texteditstatety);
begin
  //dummy
end;

procedure tcustomtextedit.setstate(const state: texteditstatety);
begin
  //dummy
end;

procedure tcustomtextedit.beginupdate;
begin
  feditor.beginupdate;
  if flines <> nil then
    flines.beginupdate;
end;

procedure tcustomtextedit.endupdate;
begin
  if flines <> nil then
    flines.endupdate;
  feditor.endupdate;
  if not feditor.updating and (tes_xposinvalid in ftextstate) then
  begin
    fxpos := feditor.caretpos.x;
    exclude(ftextstate, tes_xposinvalid);
  end;
end;

procedure tcustomtextedit.Clear;
begin
  beforechange;
  fselectstart := nullcoord;
  fselectend   := nullcoord;
  ffilename    := '';
  ffilerights  := defaultfilerights;
  if flines <> nil then
    flines.Clear//  fgridintf.getcol.grid.rowcount:= 0;
  ;
  ffoundeolstyle := eol_default;
  modified       := False;
end;

procedure tcustomtextedit.setfilename(Value: filenamety);
begin
  ffilename := filepath(Value);
{
 removefilechangenotification;
 ffilepath:= expanduncfilename(value);
 addfilechangenotification;
 if (seo_autosyntax in foptions) and (fsyntaxpainter <> nil) then begin
  try
   syntaxhandle:= fsyntaxpainter.linkdeffile(fileext(value));
  except
   on e: exception do begin
    writeexceptionmessage(e);
    syntaxhandle:= -1;
   end;
  end;
 end;
 }
end;

{
function tcustomtextedit.filename: filenamety;
begin
 result:= ffilename;
end;
}
procedure tcustomtextedit.dostatread(const reader: tstatreader);
begin
  if (fgridintf = nil) and canstatvalue(feditor.optionsedit1, reader) then //   value:= reader.readmsestring(valuevarname,value);
  ;
  if canstatstate(feditor.optionsedit1, reader) then   //  readstatstate(reader);
  ;
  if canstatoptions(feditor.optionsedit1, reader) then //  readstatoptions(reader);
  ;
end;

procedure tcustomtextedit.dostatwrite(const writer: tstatwriter);
begin
  if (fgridintf = nil) and canstatvalue(feditor.optionsedit1, writer) then //   writestatvalue(writer);
  ;
  if canstatstate(feditor.optionsedit1, writer) then   //  writestatstate(writer);
  ;
  if canstatoptions(feditor.optionsedit1, writer) then //  writestatoptions(writer);
  ;
end;

function tcustomtextedit.getstatvarname: msestring;
begin
  Result := fstatvarname;
end;

procedure tcustomtextedit.setstatfile(const Value: tstatfile);
begin
  setstatfilevar(istatfile(self), Value, fstatfile);
end;

procedure tcustomtextedit.statreading;
begin
  //dummy
end;

procedure tcustomtextedit.statread;
begin
  //dummy
end;

procedure tcustomtextedit.inserttext(const apos: gridcoordty; const atext: msestring; out aendpos: gridcoordty; selected: Boolean = False; insertbackwards: Boolean = False);
var
  ar1: msestringarty;
  int1: integer;
begin
  beforechange;
  beginupdate;
  feditor.begingroup;
  try
    clearselection;
    ar1 := breaklines(atext);
    with fgridintf.getcol do
    begin
      if ar1 = nil then
      begin
        aendpos.col := 0;
        aendpos.row := apos.row;
      end
      else
      begin
        aendpos.col := length(ar1[high(ar1)]);
        aendpos.row := apos.row + high(ar1);
      end;
      if length(ar1) > 1 then
      begin
        ar1[high(ar1)] := ar1[high(ar1)] + copy(flines[apos.row], apos.col + 1, bigint);
        if apos.col = 0 then
          grid.insertrow(apos.row, high(ar1))
        else
        begin
          grid.insertrow(apos.row + 1, high(ar1));
        end;
        for int1 := 1 to high(ar1) do
          flines.items[apos.row + int1] := ar1[int1];
        flines[apos.row] := copy(flines[apos.row], 1, apos.col) + ar1[0];
      end
      else
      begin
        richinsert(atext, prichstringty(flines.getitempo(apos.row))^, apos.col + 1);
        aendpos.col := aendpos.col + apos.col;
      end;
    end;
    int1 := fgridintf.getrow;
    if (int1 >= 0) and (int1 < flines.Count) then
      feditor.richtext := flines.richitems[int1];
    if insertbackwards then
    begin
      seteditpos(aendpos, False);
      textinserted(aendpos, atext, selected, apos, True);
      seteditpos(apos, False);
      if selected then
      begin
        fselectstart := aendpos;
        fselectend   := aendpos;
      end;
    end
    else
    begin
      seteditpos(apos, False);
      textinserted(apos, atext, selected, aendpos, False);
      seteditpos(aendpos, False);
      if selected then
      begin
        fselectstart := apos;
        fselectend   := apos;
      end;
    end;
    updateindex(selected);
  finally
    feditor.endgroup;
    endupdate;
  end;
end;

procedure tcustomtextedit.inserttext(const apos: gridcoordty; const atext: msestring; selected: Boolean = False; insertbackwards: Boolean = False);
var
  po1: gridcoordty;
begin
  inserttext(apos, atext, po1, selected, insertbackwards);
end;

procedure tcustomtextedit.internaldeletetext(const start, stop: gridcoordty; const userinput: Boolean);
var
  po1, po2: gridcoordty;
  bo1: Boolean;
  grid: tcustomwidgetgrid1;
begin
  if (start.col <> stop.col) or (start.row <> stop.row) then
  begin
    beforechange;
    normalizetextrect(start, stop, po1, po2);
    beginupdate;
    feditor.begingroup;
    application.caret.remove;
    grid := tcustomwidgetgrid1(fgridintf.getcol.grid);
    bo1  := og_appendempty in grid.optionsgrid;
    try
      include(grid.foptionsgrid, og_appendempty);
      clearselection;
      seteditpos(stop, False);
      textdeleted(stop, gettext(po1, po2), False, po1,
        isequalgridcoord(po2, stop));
      seteditpos(po1, False);
      //   feditor.updatecaret; //locked by beginupdate
      if po1.row = po2.row then
        richdelete(prichstringty(flines.getitempo(po1.row))^, po1.col + 1,
          po2.col - po1.col)
      else
      begin
        if po1.col > 0 then
          richdelete(prichstringty(flines.getitempo(po1.row))^, po1.col + 1, bigint);
        if po2.col > 0 then
          richdelete(prichstringty(flines.getitempo(po2.row))^, 1, po2.col);
        if po1.col > 0 then
        begin
          if po2.row < flines.Count then
            prichstringty(flines.getitempo(po1.row))^ :=
              richconcat(prichstringty(flines.getitempo(po1.row))^,
              prichstringty(flines.getitempo(po2.row))^);
          Inc(po1.row);
          if po1.row < flines.Count then
            grid.deleterow(po1.row, po2.row - po1.row + 1, userinput);
        end
        else
          grid.deleterow(po1.row, po2.row - po1.row, userinput);
{
    if po2.row < flines.count then begin
     prichstringty(flines.getitempo(po1.row))^:=
          richconcat(prichstringty(flines.getitempo(po1.row))^,
          prichstringty(flines.getitempo(po2.row))^);
    end;
    if (po1.row+1 < flines.count) then begin
     grid.deleterow(po1.row+1,po2.row-po1.row);
    end
    else begin
     if po1.col = 0 then begin
      grid.deleterow(po1.row,po2.row-po1.row);
     end;
    end;
}
      end;
      if grid.updating then
        gridtovalue(-1);
    finally
      application.caret.restore;
      feditor.endgroup;
      if not bo1 then
        exclude(grid.foptionsgrid, og_appendempty);
      endupdate;
    end;
  end;
end;

procedure tcustomtextedit.deletetext(const start, stop: gridcoordty);
begin
  internaldeletetext(start, stop, False);
end;

function tcustomtextedit.appendrow(const atext: richstringty): integer;
begin
  checkgrid;
  Result := fgridintf.getcol.grid.appendrow;
  richlines[Result] := atext;
end;

function tcustomtextedit.appendrow(const atext: msestring): integer;
var
  richstring: richstringty;
begin
  richstring.Text := atext;
  richstring.format := nil;
  Result := appendrow(richstring);
end;

function intersecttextrect(const a1, a2, b1, b2: gridcoordty; out i1, i2: gridcoordty): Boolean;
  //i = a * b, true if intersection exist, values have to be ordered
begin
  if b1.row > a1.row then
    i1 := b1
  else
  begin
    i1 := a1;
    if (b1.row = a1.row) and (b1.col > a1.col) then
      i1.col := b1.col;
  end;
  if b2.row < a2.row then
    i2 := b2
  else
  begin
    i2 := a2;
    if (b2.row = a2.row) and (b2.col < a2.col) then
      i2.col := b2.col;
  end;
  Result := (i1.row < i2.row) or (i1.row = i2.row) and (i1.col < i2.col);
end;

function compgridcoord(const a, b: gridcoordty): integer;
begin
  Result   := a.row - b.row;
  if Result = 0 then
    Result := a.col - b.col;
end;

procedure tcustomtextedit.setselection(const start, stop: gridcoordty; const aseteditpos: Boolean = False; const ashowcell: cellpositionty = cep_nearest);
var
  astart, astop: gridcoordty;

  function checkoverlap(const a1, a2, b1, b2: gridcoordty): Boolean;
    //true if a <> (a ^ b)
  var
    int1: integer;
    i1, i2: gridcoordty;
  begin
    if not intersecttextrect(a1, a2, b1, b2, i1, i2) then
    begin
      Result := True;
      astart := a1;
      astop  := a2;
      Exit;    //no intersection
    end;
    Result := (a1.row <> i1.row) or (a1.col <> i1.col) or
      (a2.row <> i2.row) or (a2.col <> i2.col);
    if Result then
    begin
      int1 := compgridcoord(a1, i1);
      if int1 < 0 then
      begin
        astart := a1;
        astop  := i1;
      end
      else
      begin
        astart := i2;
        astop  := a2;
      end;
    end;
  end;

var
  col1: twidgetcol;
  grid: twidgetgrid;
  cell: gridcoordty;

  procedure updatestyle(Value: Boolean);
  var
    int1, int2: integer;
    po1: prichstringty;
  begin
    po1      := prichstringty(flines.getitempo(astart.row));
    for int1 := astart.row to astop.row do
    begin //deselect old
      if int1 = astop.row then
        int2 := astop.col - astart.col
      else
        int2 := length(po1^.Text) - astart.col;
      if int2 > 0 then
      begin
        updatefontstyle1(po1^.format,
          astart.col, int2, fs_selected, Value);
        cell.row := int1;
        grid.invalidatecell(cell);
      end;
      astart.col := 0;
      Inc(po1);
    end;
  end;

var
  new1, new2, old1, old2: gridcoordty;
  int1, rangerow: longint;
begin
  if (start.col < 0) or (start.row < 0) or (stop.col < 0) or
    (stop.row < 0) then
    Exit;

  if (sourcefo.ActivePage <> nil) then sourcefo.ActivePage.source_editor.datacols.clearselection;

  if (sourcefo.ActivePage <> nil) and (confideufo.rectanglearea.Value = True) then
  begin

    if start.row <> stop.row then
    begin
      new2.col := 1;

      if start.row < stop.row then
      begin
        new2.row := start.row;
        rangerow := stop.row;
      end
      else
      begin
        new2.row := stop.row;
        rangerow := start.row;
      end;

      while new2.row <= rangerow do
      begin
        sourcefo.ActivePage.source_editor.selectcell(new2, csm_select, False);
        Inc(new2.row);
      end;

    end;

  end;

  if aseteditpos then
  begin
    if ashowcell <> cep_none then
      seteditpos(start, False);
    seteditpos(stop, True, ashowcell);
  end
  else
  begin
    col1     := fgridintf.getcol;
    grid     := twidgetgrid(col1.grid);
    cell.col := col1.colindex;

    normalizetextrect(start, stop, new1, new2);
    int1 := grid.row;
    if int1 > new1.row then
    begin
      if int1 < new2.row then
      begin
        feditor.selstart  := 0;
        feditor.sellength := bigint;
      end
      else
      begin
        if int1 = new2.row then
        begin
          if new1.row < int1 then
            feditor.selstart := 0
          else
          begin
            feditor.selstart := new1.col;
          end;
          feditor.sellength := new2.col - feditor.selstart;
        end
        else
          feditor.sellength := 0;
      end;
    end
    else if int1 = new1.row then
    begin
      feditor.selstart    := new1.col;
      if new2.row > int1 then
        feditor.sellength := bigint
      else
      begin
        feditor.sellength := new2.col - new1.col;
      end;
    end
    else
      feditor.sellength := 0;
    normalizetextrect(fselectstart, fselectend, old1, old2);
    fselectstart := start;
    fselectend := stop;
    int1 := fgridintf.getcol.grid.rowcount;
    if old1.row >= int1 then
    begin
      old1.row := int1 - 1;
      old1.col := 0;
      old2     := old1;
    end
    else if old2.row >= int1 then
    begin
      old2.row := int1 - 1;
      old2.col := bigint;
    end;
    if tes_selectinvalid in ftextstate then
    begin
      astart := new1;
      astop  := new2;
      updatestyle(True);
      exclude(ftextstate, tes_selectinvalid);
    end
    else
    begin
      if checkoverlap(old1, old2, new1, new2) then
        updatestyle(False);
      if checkoverlap(new1, new2, old1, old2) then
        updatestyle(True);
    end;
  end;
end;

procedure tcustomtextedit.selectall;
begin
  setselection(makegridcoord(0, 0),
    makegridcoord(bigint, fgridintf.grid.rowhigh), True);
end;

procedure tcustomtextedit.setfontstyle(const start, stop: gridcoordty; const astyle: fontstylety; const aset: Boolean; const afontcolor: colorty = cl_default; const acolorbackground: colorty = cl_default);
var
  a, b: gridcoordty;
  int1, int2: integer;
  po1: prichstringty;
  bo1: Boolean;
begin
  normalizetextrect(start, stop, a, b);
  int2     := bigint;
  for int1 := a.row to b.row do
  begin
    po1    := flines.richitemspo[int1];
    if int1 = b.row then
      int2 := b.col - a.col;
    bo1   := (astyle <> fs_force) and
      updatefontstyle1(po1^.format, a.col, int2, astyle, aset);
    if afontcolor <> cl_default then
      bo1 := setfontcolor1(po1^.format, a.col, int2, afontcolor) or bo1;
    if acolorbackground <> cl_default then
      bo1 := setcolorbackground1(po1^.format, a.col, int2, acolorbackground) or bo1;
    if bo1 then
      with fgridintf.getcol do
      begin
        invalidatecell(int1);
        if int1 = grid.row then
          tinplaceedit1(feditor).format := po1^.format;
      end;
    a.col := 0;
  end;
end;

procedure tcustomtextedit.updateindex(select: Boolean);
var
  selectstart1, selectend1: gridcoordty;
begin
  selectstart1 := fselectstart;
  selectend1   := fselectend;
  if select then
  begin
    selectend1.col := feditor.curindex;
    selectend1.row := tcustomwidgetgrid1(fgridintf.getcol.grid).row;
  end
  else
  begin
    selectstart1.col := feditor.curindex;
    selectstart1.row := tcustomwidgetgrid1(fgridintf.getcol.grid).row;
    selectend1       := selectstart1;
  end;
  setselection(selectstart1, selectend1);
end;

procedure tcustomtextedit.insertlinebreak;
begin
  feditor.begingroup;
  try
    deleteselection;
    inserttext(fselectstart, lineend);
  finally
    feditor.endgroup;
  end;
end;

procedure tcustomtextedit.editnotification(var info: editnotificationinfoty);
var
  int1: integer;
  str1: msestring;
  po1, po2: gridcoordty;
  grid: tcustomgrid;
begin
  if canevent(tmethod(foneditnotification)) then
    foneditnotification(self, info);
  if fgridintf <> nil then
  begin
    grid := fgridintf.getcol.grid;
    with info do
      case action of
        ea_clearselection: internalclearselection;
        ea_textedited: if not (csdesigning in componentstate) then
            if fupdating = 0 then
            begin
              Inc(fupdating);
              try
                fgridintf.edited();
                int1 := fgridintf.getrow;
                fgridintf.setdata(int1, feditor.richtext, True);
                gridvaluechanged(int1);
              finally
                Dec(fupdating);
              end;
              inherited;
            end;
        ea_indexmoved:
        begin
          fxpos := feditor.caretpos.x;
          updateindex(eas_shift in state);
        end;
        ea_textsizechanged: if not (tes_cellentering in ftextstate) then
            with fgridintf.getcol do
            begin
              if info.sizebefore.cy <> info.newsize.cy then
                autocellheightchanged(grid.row);
              if info.sizebefore.cx <> info.newsize.cx then
                autocellwidthchanged(grid.row);
            end;
        ea_delchar: if dir <> gd_left then
            if (fselectstart.col = fselectend.col) and (fselectstart.row = fselectend.row) then
            begin
              if (feditor.curindex = length(feditor.Text)) then
                if fselectstart.row < grid.rowcount - 1 then
                begin
                  fselectstart.row := fselectend.row + 1;
                  fselectstart.col := 0;
                  deleteselection;             //remove linebreak
                  action           := ea_none;
                end;
            end
            else
            begin
              deleteselection;
              action := ea_none;
            end//no backspace
          ;
        ea_selectall:
        begin
          selectall;
          action := ea_none;
        end;
        ea_deleteselection:
        begin
          deleteselection;
          action := ea_none;
        end;
        ea_copyselection:
        begin
          //     copyselection;
          if hasselection then
            msewidgets.copytoclipboard(selectedtext, bufferkind);
          action := ea_none;
        end;
        ea_pasteselection:
        begin
          if msewidgets.pastefromclipboard(str1, bufferkind) then
          begin
            beginupdate;
            feditor.begingroup;
            try
              deleteselection;
              po2 := editpos;
              inserttext(po2, str1, po1, False);
            finally
              feditor.endgroup;
              endupdate;
            end;
          end;
          action := ea_none;
        end;
        ea_exit:
        begin
          action := ea_none;
          if dir = gd_left then
          begin
            if editpos.row > 0 then
            begin
              int1 := length(flines[editpos.row - 1]);
              if (eas_delete in state) then
              begin
                if hasselection then
                  deleteselection
                else
                begin
                  deletetext(makegridcoord(0, editpos.row), makegridcoord(int1, editpos.row - 1));
                end;
              end
              else
              begin
                seteditpos(makegridcoord(int1, editpos.row - 1), state = [eas_shift]);
              end;
            end
            else
            begin
              if not (eas_shift in state) then
                internalclearselection;
            end;
          end
          else if dir = gd_right then
            if editpos.row < linecount - 1 then
              seteditpos(makegridcoord(0, editpos.row + 1), state = [eas_shift])
            else if not (eas_shift in state) then
              internalclearselection;
        end;
        ea_caretupdating: if focused and not grid.updating then
            fgridintf.showcaretrect(info.caretrect, fframe);
        else; // Added to make compiler happy
      end;
  end;
  inherited;
end;

procedure tcustomtextedit.mousepostotextpos1(const row: integer; const mousepos: pointty; var textpos: gridcoordty; var Result: Boolean);
var
  textinfo: drawtextinfoty;
  col1: twidgetcol;
begin
  col1           := fgridintf.getcol;
  textinfo.Text  := flines.richitems[row];
  textinfo.font  := col1.rowfont(row);
  textinfo.flags := feditor.textflags;
  if row = col1.grid.row then
    textinfo.dest := innerclientrect
  else
    textinfo.dest := col1.grid.cellrect(mgc(col1.index, row), cil_inner, False, True);
  textinfo.tabulators := ftabulators;
  Result      := postotextindex(getcanvas, textinfo, mousepos, textpos.col);
  textpos.row := row;
end;

function tcustomtextedit.mousepostotextpos(const mousepos: pointty; out textpos: gridcoordty; widgetorg: Boolean = False): Boolean;
  //false if out of text, textpos clamped to textrange
var
  grid: tcustomwidgetgrid1;
  arow: integer;
  {po1,}pt2: pointty;
  // int1: integer;
begin
  Result := True;
  grid   := tcustomwidgetgrid1(fgridintf.getcol.grid);
  pt2    := mousepos;
  if widgetorg then
    pt2.y := pt2.y + grid.rowpos(grid.row)//grid client data origin

  else
    subpoint1(pt2, fgridintf.getcol.cellorigin);
  arow := grid.rowatpos(pt2.y);
 {
 if widgetorg then begin
  int1:= fgridintf.getrow * grid.ystep;
 end
 else begin
  int1:= 0;
 end;
 int1:= (mousepos.y + int1);
 arow:= int1 div grid.ystep;
 int1:= int1 - arow * grid.ystep;
 }
  if arow < 0 then
  begin
    Result := False;
    arow   := 0;
  end
  else if arow >= grid.frowcount then
  begin
    Result := False;
    arow   := grid.frowcount - 1;
  end;
  pt2.y := pt2.y - grid.rowpos(arow);
  mousepostotextpos1(arow, pt2, textpos, Result);
 {
 if widgetorg then begin
  mousepostotextpos1(arow,makepoint(mousepos.x,int1),textpos,result);
 end
 else begin
  po1:= fgridintf.getcol.cellorigin;
  mousepostotextpos1(arow,makepoint(mousepos.x - po1.x,
     mousepos.y - arow*grid.ystep - po1.y),textpos,result);
 end;
 }
end;

function tcustomtextedit.textpostomousepos(const textpos: gridcoordty; const screenorg: Boolean = False): pointty;
var
  po1, po2: pointty;
  textinfo: drawtextinfoty;
begin
  textinfo.Text := flines.richitems[textpos.row];
  textinfo.font := fgridintf.getcol.rowfont(textpos.row);
  textinfo.flags := feditor.textflags;
  textinfo.dest := innerclientrect;
  textinfo.tabulators := ftabulators;
  po1      := textindextopos(getcanvas, textinfo, textpos.col);
  po2      := fgridintf.getcol.cellorigin;
  Result.y := po1.y + {po2.y +}
    tcustomwidgetgrid1(fgridintf.getcol.grid).cellrect(mgc(0, textpos.row)).y;
  //              textpos.row * tcustomwidgetgrid1(fgridintf.getcol.grid).ystep;
  Result.x := po1.x + po2.x;
  if screenorg then
    translateclientpoint1(Result, fgridintf.getcol.grid, nil);
end;

function tcustomtextedit.textpostomouserect(const textpos: gridcoordty; const screenorg: Boolean = False): rectty;
  //y:= top of character cell cx = 0 cy = linespacing
begin
  Result.pos := textpostomousepos(textpos, screenorg);
  Result.cx  := 0;
  Result.cy  := font.lineheight;
  Dec(Result.y, font.ascent);
end;

procedure tcustomtextedit.dotextmouseevent(var info: textmouseeventinfoty);
begin
  if canevent(tmethod(fontextmouseevent)) then
    fontextmouseevent(self, info);
end;

function tcustomtextedit.textclipped(const arow: integer; out acellrect: rectty): Boolean;
var
  rect2: rectty;
  canvas1: tcanvas;
  cell1: gridcoordty;
  grid1: tcustomgrid;
begin
  checkgrid;
  with twidgetcol1(fgridintf.getcol) do
  begin
    grid1     := grid;
    cell1.row := arow;
    cell1.col := colindex;
    Result    := grid1.isdatacell(cell1);
    if Result then
    begin
      acellrect := grid1.clippedcellrect(cell1, cil_inner);
      canvas1   := getcanvas;
      rect2     := textrect(canvas1, richstringty(getdatapo(arow)^),
        acellrect, feditor.textflags, font);
      Result    := not rectinrect(rect2, acellrect);
    end
    else
      acellrect := nullrect;
  end;
end;

function tcustomtextedit.textclipped(const arow: integer): Boolean;
var
  rect1: rectty;
begin
  Result := textclipped(arow, rect1);
end;

function tcustomtextedit.getiassistiveclient(): iassistiveclient;
begin
  Result := iassistiveclientgridwidget(self);
end;

function tcustomtextedit.getassistivecolumncaption(): msestring;
begin
  Result   := '';
  if fgridintf <> nil then
    Result := fgridintf.getcol.defaultcaption();
end;

procedure tcustomtextedit.docellevent(const ownedcol: Boolean; var info: celleventinfoty);
var
  textinfo: textmouseeventinfoty;
  bo1: Boolean;
  po1: pointty;
  int1, int2: integer;
  rect1: rectty;
  hintinfo: hintinfoty;
begin
  if ownedcol then
    with info do
    begin
      textinfo.eventkind := eventkind;
      if eventkind = cek_enter then
        tinplaceedit1(feditor).frow := newcell.row;
      if canevent(tmethod(foncellevent)) then
        foncellevent(self, info);
      case eventkind of
        cek_enter:
        begin
          bo1 := tes_cellentering in ftextstate;
          include(ftextstate, tes_cellentering);
          try
            with fgridintf.getcol.grid do
              if fselectstart.row >= rowcount then
              begin
                fselectstart.row := rowcount - 1;
                fselectstart.col := length(flines[fselectstart.row]);
                //check for removed empty row
              end;
            if cellbefore.row <> newcell.row then
              with tinplaceedit1(feditor) do
              begin
                rect1  := textrect;
                if cellbefore.row < newcell.row then
                  int1 := mousepostotextindex(makepoint(fxpos, rect1.x))
                else
                  int1 := mousepostotextindex(makepoint(fxpos, rect1.y + rect1.cy - 1));
                int2 := fxpos;
                moveindex(int1,
                  selectaction in [fca_focusinshift, fca_focusinrepeater], True{false});
                exclude(self.ftextstate, tes_xposinvalid);
                fxpos := int2; //restore
              end;
            if selectaction = fca_focusinrepeater then
              fgridintf.getcol.grid.setcellclientclick(self);
            dosetupeditor();
          finally
            if not bo1 then
              exclude(ftextstate, tes_cellentering);
          end;
        end;
        cek_mousemove, cek_mousepark, cek_buttonpress, cek_buttonrelease:
        begin
          if cell.row >= 0 then
          begin
            mousepostotextpos1(cell.row, mouseeventinfopo^.pos, textinfo.pos, bo1);
            if (eventkind = cek_mousemove) and
              (cell.row <> fgridintf.getcol.grid.row) and
              (info.mouseeventinfopo^.shiftstate = [ss_left]) and
              grid.cellclicked then
            begin
              fxpos := textpostomousepos(textinfo.pos).x;

              with fgridintf.getcol.grid do
              begin
                focuscell(cell, fca_focusinshift);
                setcellclientclick(self);
                //        setclientclick;
                Exit;
              end;
            end;
            if not bo1 then
              textinfo.pos := invalidcell;
          end
          else
            textinfo.pos   := invalidcell;
          if not (eventkind in [cek_mousemove]) or (textinfo.pos.col <> fmousetextpos.col) or
            (textinfo.pos.row <> fmousetextpos.row) then
          begin
            fmousetextpos := textinfo.pos;
            po1           := subpoint(gridmousepos, mouseeventinfopo^.pos);
            mouseeventinfopo^.pos := gridmousepos;
            textinfo.mouseeventinfopo := mouseeventinfopo;
            try
              dotextmouseevent(textinfo);
            finally
              subpoint1(mouseeventinfopo^.pos, po1);
            end;
          end;
        end;
        cek_firstmousepark: if (oe_hintclippedtext in foptionsedit) and application.active and
            textclipped(info.cell.row) and
            ((info.grid.row <> info.cell.row) or
            (info.grid.col <> info.cell.col)) and
     {$warnings off}
      {$push}
    {$objectChecks off}
            twidget1(info.grid).getshowhint then
          begin
  {$pop}
     {$warnings on}
            application.inithintinfo(hintinfo, info.grid);
     {$warnings off}
      {$push}
    {$objectChecks off}
            hintinfo.Caption :=
              richstringty(
              twidgetcol1(fgridintf.getcol).getdatapo(info.cell.row)^).Text;
   {$pop}
     {$warnings on}
            application.showhint(info.grid, hintinfo);
          end;
        cek_mouseleave:
        begin
          fmousetextpos := invalidcell;
          textinfo.pos  := invalidcell;
          textinfo.mouseeventinfopo := mouseeventinfopo;
          dotextmouseevent(textinfo);
        end;
        else; // Added to make compiler happy
      end;
    end;
  inherited;
end;

procedure tcustomtextedit.internalclearselection;
begin
  setselection(editpos, editpos);
end;

function tcustomtextedit.getassistivetext(): msestring;
begin
  Result := feditor.Text;
end;

function tcustomtextedit.getassistiveflags: assistiveflagsty;
begin
  Result := inherited getassistiveflags;
  if fgridintf <> nil then
    include(Result, asf_gridwidget);
end;

function tcustomtextedit.getassistivecelltext(const arow: int32): msestring;
begin
  if flines <> nil then
    Result := flines[arow]
  else
    Result := '';
end;

procedure tcustomtextedit.clearselection;
begin
  seteditpos(editpos, False);
end;

procedure tcustomtextedit.setedpos(const Value: gridcoordty; const select: Boolean; const donotify: Boolean; const ashowcell: cellpositionty);
var
  po1: gridcoordty;
begin
  tinplaceedit1(feditor).frow := Value.row;
  po1.row := Value.row;
  po1.col := fgridintf.getcol.colindex;
  if select then
    fgridintf.getcol.grid.focuscell(po1, fca_focusinshift, scm_cell, ashowcell)
  else
    fgridintf.getcol.grid.focuscell(po1, fca_focusin, scm_cell, ashowcell);
  feditor.moveindex(Value.col, select, donotify);
  if donotify then
    if feditor.updating then
    begin
      include(ftextstate, tes_xposinvalid);
      ;
    end
    else
      fxpos := feditor.caretpos.x;
  updateindex(select);
end;

procedure tcustomtextedit.seteditpos(const Value: gridcoordty; const select: Boolean = False; const ashowcell: cellpositionty = cep_nearest);
begin
  setedpos(Value, select, True, ashowcell);
end;

procedure tcustomtextedit.seteditpos1(const Value: gridcoordty);
begin
  seteditpos(Value, False, cep_nearest);
end;

function tcustomtextedit.geteditpos: gridcoordty;
begin
  Result := makegridcoord(feditor.curindex, fgridintf.getrow);
end;

function tcustomtextedit.getrow: integer;
begin
  Result := fgridintf.getrow;
end;

procedure tcustomtextedit.setrow(const avalue: integer);
begin
  editpos := makegridcoord(col, avalue);
end;

function tcustomtextedit.getcol: integer;
begin
  Result := feditor.curindex;
end;

procedure tcustomtextedit.setcol(const avalue: integer);
begin
  editpos := makegridcoord(avalue, row);
end;

procedure tcustomtextedit.getselectedrows(out start, stop: integer);
var
  int1: integer;
begin
  int1 := fselectend.row - fselectstart.row;
  if int1 > 0 then
  begin
    start := fselectstart.row;
    stop  := fselectend.row;
    if fselectend.col = 0 then
      Dec(stop);
  end
  else if int1 <> 0 then
  begin
    start := fselectend.row;
    stop  := fselectstart.row;
    if fselectstart.col = 0 then
      Dec(stop);
  end
  else
  begin
    start := editpos.row;
    stop  := start;
  end;
end;

procedure tcustomtextedit.deleteselection;
begin
  if hasselection then
    deletetext(fselectstart, fselectend);
end;

procedure tcustomtextedit.copyselection;
begin
  if hasselection then
    msewidgets.copytoclipboard(selectedtext);
end;

procedure tcustomtextedit.cutselection;
begin
  copyselection;
  deleteselection;
end;

function tcustomtextedit.canpaste: Boolean;
begin
  Result := canpastefromclipboard;
end;

procedure tcustomtextedit.paste;
var
  str1: msestring;
begin
  if msewidgets.pastefromclipboard(str1) then
  begin
    feditor.begingroup;
    try
      deleteselection;
      inserttext(editpos, str1, True);
    finally
      feditor.endgroup;
    end;
  end;
end;

function tcustomtextedit.gettext(const start, stop: gridcoordty): msestring;
var
  po1, po2: gridcoordty;
  int1: integer;
begin
  normalizetextrect(start, stop, po1, po2);
  if po1.row = po2.row then
    Result := copy(flines[po1.row], po1.col + 1, po2.col - po1.col)
  else
  begin
    Result := copy(flines[po1.row], po1.col + 1, bigint);
    for int1 := po1.row + 1 to po2.row - 1 do
      if flines.noparagraphs[int1] then
        Result := Result + flines[int1]
      else
        Result := Result + lineend + flines[int1];
    if po2.row < flines.Count then
    begin
      if not flines.noparagraphs[po2.row] then
        Result := Result + lineend//paragraph
      ;
      Result   := Result + copy(flines[po2.row], 1, po2.col);
    end;
  end;
end;

function tcustomtextedit.getrichtext(const start, stop: gridcoordty): richstringty;
var
  po1, po2: gridcoordty;
  int1: integer;
begin
  normalizetextrect(start, stop, po1, po2);
  if po1.row = po2.row then
    Result := richcopy(flines.richitems[po1.row], po1.col + 1, po2.col - po1.col)
  else
  begin
    Result := richcopy(flines.richitems[po1.row], po1.col + 1, bigint);
    for int1 := po1.row + 1 to po2.row - 1 do
      if flines.noparagraphs[int1] then
        Result := richconcat(Result, flines.richitems[int1])
      else
      begin
        Result := richconcat(Result, richlineend);
        Result := richconcat(Result, flines.richitems[int1]);
      end;
    if po2.row < flines.Count then
    begin
      if not flines.noparagraphs[po2.row] then
        Result := richconcat(Result, richlineend)//paragraph
      ;
      Result   := richconcat(Result, richcopy(flines.richitems[po2.row], 1, po2.col));
    end;
  end;
end;

function tcustomtextedit.gettext: msestring;
begin
  Result := flines.gettext;
end;

procedure tcustomtextedit.settext(const atext: msestring);
begin
  flines.settext(atext);
end;

function tcustomtextedit.hasselection: Boolean;
begin
  Result := (fselectstart.row <> fselectend.row) or
    (fselectstart.col <> fselectend.col);
end;

function tcustomtextedit.selectedtext: msestring;
begin
  if hasselection then
    Result := gettext(fselectstart, fselectend)
  else
    Result := '';
end;

function tcustomtextedit.selectedrichtext: richstringty;
begin
  if hasselection then
    Result := getrichtext(fselectstart, fselectend)
  else
    Result := emptyrichstring;
end;

function tcustomtextedit.find(const atext: msestring; options: searchoptionsty; var textpos: gridcoordty; const endpos: gridcoordty; selectfound: Boolean = False; const ashowcell: cellpositionty = cep_nearest): Boolean;
var
  int1, int2: integer;
  endrow: integer;


  function checkresult: Boolean;
  begin
    if (int1 > 0) and ((int2 < endrow) or
      (int2 = endrow) and (int1 - 1 + length(atext) <= endpos.col)) then
    begin
      textpos.row := int2;
      textpos.col := int1 - 1;
      Result      := True;
      if selectfound then
        setselection(textpos, makegridcoord(textpos.col + length(atext), textpos.row),
          True, ashowcell);
    end
    else
      Result := False;
  end;

  function checkresultback: Boolean;
  begin
    if (int1 > 0) and ((int2 > endpos.row) or
      (int2 = textpos.row) and (int1 <= textpos.col)) then
    begin
      textpos.row := int2;
      textpos.col := int1 - length(atext);
      Result      := True;
      if selectfound then
        setselection(makegridcoord(textpos.col + length(atext), textpos.row), textpos,
          True, ashowcell);
    end
    else
      Result := False;
  end;

var
  po1: prichstringty;
  pos1: gridcoordty;
  str1, str2: msestring;
  isback: Boolean;
begin
  Result := False;
  if flines.Count > 0 then
  begin
    if so_caseinsensitive in options then
    begin
      str1 := mselowercase(atext);
      str2 := mseuppercase(atext);
    end
    else
    begin
      str1 := atext;
      str2 := '';
    end;
    isback := so_backward in options;
    pos1   := textpos;
    endrow := endpos.row;
    if endrow >= flines.Count then
      endrow := flines.Count - 1;
    if isback and (endrow < 0) then
      endrow := 0;
    po1      := flines.datapo;
    if pos1.row < 0 then
    begin
      if isback then
        Exit;
      pos1.row := 0;
      pos1.col := 1;
    end
    else if isback then
    begin
      if pos1.row >= flines.Count then
        pos1.row := flines.Count - 1;
    end
    else if pos1.row <= endrow then
    begin
      Inc(pos1.col);
      if pos1.col < 1 then
        pos1.col := 1;
    end;
    Inc(po1, pos1.row);
    int1 := msestringsearch(str1, po1^.Text, pos1.col, options, str2);
    int2 := pos1.row;
    if isback then
    begin
      while True do
      begin
        if checkresultback then
        begin
          Result := True;
          Exit;
        end;
        Dec(int2);
        if int2 < endrow then
          Exit;
        Dec(po1);
        int1 := msestringsearch(str1, po1^.Text, bigint, options, str2);
      end;
    end
    else
      while True do
      begin
        if checkresult then
        begin
          Result := True;
          Exit;
        end;
        Inc(int2);
        if int2 > endrow then
          Exit;
        Inc(po1);
        int1 := msestringsearch(str1, po1^.Text, 1, options, str2);
      end;
  end;
end;

function tcustomtextedit.getgridvalue(const index: integer): msestring;
begin
  Result := flines[index];
end;

procedure tcustomtextedit.setgridvalue(const index: integer; const Value: msestring);
begin
  flines[index] := Value;
end;

function tcustomtextedit.linecount: integer;
begin
  if flines = nil then
    Result := 0
  else
    Result := flines.Count;
end;

function tcustomtextedit.getgridvalues: msestringarty;
begin
  Result := flines.asmsestringarray;
end;

procedure tcustomtextedit.setgridvalues(const Value: msestringarty);
begin
  flines.asmsestringarray := Value;
end;

function tcustomtextedit.getrichlines(const index: integer): richstringty;
begin
  Result := flines.richitems[index];
end;

procedure tcustomtextedit.setrichlines(const index: integer; const Value: richstringty);
begin
  flines.richitems[index] := Value;
end;

function tcustomtextedit.getrichformats(const index: integer): formatinfoarty;
begin
  Result := flines.formats[index];
end;

procedure tcustomtextedit.setrichformats(const index: integer; const avalue: formatinfoarty);
begin
  flines.formats[index] := avalue;
end;

procedure tcustomtextedit.setmodified(const avalue: Boolean);
begin
  if fmodified <> avalue then
  begin
    fmodified := avalue;
    if canevent(tmethod(fonmodifiedchanged)) then
      fonmodifiedchanged(self, avalue);
  end;
end;

procedure tcustomtextedit.setdatalist(const avalue: tgridrichstringdatalist);
begin
  flines.Assign(avalue);
end;

procedure tcustomtextedit.textinserted(const apos: gridcoordty; const atext: msestring; const selected: Boolean; const endpos: gridcoordty; const backwards: Boolean);
begin
  //dummy
end;

procedure tcustomtextedit.textdeleted(const apos: gridcoordty; const atext: msestring; const selected: Boolean; const endpos: gridcoordty; const backwards: Boolean);
begin
  //dummy
end;

procedure tcustomtextedit.dosetupeditor();
begin
  if canevent(tmethod(fonsetupeditor)) then
    fonsetupeditor(self);
end;

procedure tcustomtextedit.setupeditor;
var
  rect1: rectty;
begin
  if not (csloading in componentstate) then
  begin
    with feditor do
    begin
      //feditor text already set
      rect1 := innerclientrect;
      if fframe = nil then
        deflaterect1(rect1, texteditminimalframe);
      setup(Text, curindex, False, rect1, clientrect, richtext.format, ftabulators, font);
    end;
    dosetupeditor();
  end;
end;

procedure tcustomtextedit.checkgrid;
begin
  if fgridintf = nil then
    raise Exception.Create('No grid.');
end;

procedure tcustomtextedit.colchanged;
begin
  invalidate;
  if fgridintf <> nil then
    fgridintf.getcol.invalidate;
end;

procedure tcustomtextedit.setmarginlinecolor(avalue: colorty);
begin
  if avalue = cl_invalid then
    avalue := cl_none;
  if fmarginlinecolor <> avalue then
  begin
    fmarginlinecolor := avalue;
    colchanged;
  end;
end;

procedure tcustomtextedit.setmarginlinepos(const avalue: integer);
begin
  if fmarginlinepos <> avalue then
  begin
    fmarginlinepos := avalue;
    colchanged;
  end;
end;

procedure tcustomtextedit.createtabulators;
begin
  ftabulators          := ttabulators.Create;
  ftabulators.onchange :=
{$ifdef FPC}
    @
{$endif}
    tabulatorschanged;
  tabulatorschanged(nil, -1);
end;

function tcustomtextedit.gettabulators: ttabulators;
begin
  getoptionalobject(ftabulators,
{$ifdef FPC}
    @
{$endif}
    createtabulators);
  Result := ftabulators;
end;

procedure tcustomtextedit.settabulators(const Value: ttabulators);
begin
  setoptionalobject(Value, ftabulators,
{$ifdef FPC}
    @
{$endif}
    createtabulators);
end;

procedure tcustomtextedit.tabulatorschanged(const Sender: tarrayprop; const index: integer);
begin
  if not (csloading in componentstate) then
    colchanged;
end;

procedure tcustomtextedit.inserttext(const atext: msestring; selected: Boolean = False);
begin
  inserttext(editpos, atext, selected);
end;

procedure tcustomtextedit.beforecelldragevent(var ainfo: draginfoty; const arow: integer; var handled: Boolean);
begin
  //dummy
end;

procedure tcustomtextedit.aftercelldragevent(var ainfo: draginfoty; const arow: integer; var handled: Boolean);
begin
  //dummy
end;

{
procedure tcustomtextedit.setreadonly(const avalue: boolean);
begin
 if avalue then begin
  optionsedit:= optionsedit + [oe_readonly];
 end
 else begin
  optionsedit:= optionsedit - [oe_readonly];
 end;
end;
}
function tcustomtextedit.getinnerframe: framety;
begin
  Result := minimaltextframe;
end;

function tcustomtextedit.getgridintf: iwidgetgrid;
begin
  Result := fgridintf;
end;

procedure tcustomtextedit.datalistdestroyed;
begin
  flines := nil;
end;

function tcustomtextedit.getstatpriority: integer;
begin
  Result := fstatpriority;
end;

procedure tcustomtextedit.setvaluedata(const Source);
begin
  Text := msestring(Source);
end;

procedure tcustomtextedit.setparentgridwidget(const intf: igridwidget);
begin
  //dummy
end;

procedure tcustomtextedit.childdataentered(const Sender: igridwidget);
begin
  //dummy
end;

procedure tcustomtextedit.childfocused(const Sender: igridwidget);
begin
  //dummy
end;

procedure tcustomtextedit.getvaluedata(out dest);
begin
  msestring(dest) := Text;
end;

procedure tcustomtextedit.setoptions(const avalue: texteditoptionsty);
begin
  if foptions <> avalue then
    foptions := texteditoptionsty(setsinglebit(card32(avalue), card32(foptions),
      card32([teeo_bom, teeo_nobom])));
end;

{ tundotextedit }

constructor tundotextedit.Create(aowner: TComponent);
begin
  feditor := tundoinplaceedit.Create(self, iedit(self), iundo(self), True);
  inherited;
end;

function tundotextedit.canredo: Boolean;
begin
  Result := tundoinplaceedit(feditor).undolist.canredo;
end;

function tundotextedit.canundo: Boolean;
begin
  Result := tundoinplaceedit(feditor).undolist.canundo;
end;

function tundotextedit.getmaxundocount: integer;
begin
  Result := tundoinplaceedit(feditor).undolist.maxcount;
end;

procedure tundotextedit.setmaxundocount(const Value: integer);
begin
  tundoinplaceedit(feditor).undolist.maxcount := Value;
end;

function tundotextedit.getmaxundosize: integer;
begin
  Result := tundoinplaceedit(feditor).undolist.maxsize;
end;

procedure tundotextedit.setmaxundosize(const Value: integer);
begin
  tundoinplaceedit(feditor).undolist.maxsize := Value;
end;

procedure tundotextedit.undo;
begin
  tundoinplaceedit(feditor).undolist.undo;
end;

procedure tundotextedit.redo;
begin
  tundoinplaceedit(feditor).undolist.redo;
end;

procedure tundotextedit.textinserted(const apos: gridcoordty; const atext: msestring; const selected: Boolean; const endpos: gridcoordty; const backwards: Boolean);
begin
  tundoinplaceedit(feditor).undolist.inserttext(apos, endpos, atext, selected, backwards);
end;

procedure tundotextedit.textdeleted(const apos: gridcoordty; const atext: msestring; const selected: Boolean; const endpos: gridcoordty; const backwards: Boolean);
begin
  tundoinplaceedit(feditor).undolist.deletetext(apos, endpos, atext, selected, backwards);
end;

procedure tundotextedit.getselectstart(var selectstartpos: gridcoordty);
begin
  selectstartpos := fselectstart;
end;

procedure tundotextedit.setselectstart(const selectstartpos: gridcoordty);
begin
  internalclearselection;
  include(ftextstate, tes_selectinvalid);
  fselectstart := selectstartpos;
end;

procedure tundotextedit.lowercase;
var
  mstr1: msestring;
begin
  if hasselection then
  begin
    tundoinplaceedit(feditor).begingroup;
    try
      mstr1 := selectedtext;
      deleteselection;
      inserttext(mselowercase(mstr1), True);
    finally
      tundoinplaceedit(feditor).endgroup;
    end;
  end;
end;

procedure tundotextedit.uppercase;
var
  mstr1: msestring;
begin
  if hasselection then
  begin
    tundoinplaceedit(feditor).begingroup;
    try
      mstr1 := selectedtext;
      deleteselection;
      inserttext(mseuppercase(mstr1), True);
    finally
      tundoinplaceedit(feditor).endgroup;
    end;
  end;
end;

procedure tundotextedit.tabtospace;
var
  mstr1: msestring;
begin
  if hasselection then
  begin
    tundoinplaceedit(feditor).begingroup;
    try
      mstr1 := selectedtext;
      replacechar1(mstr1, msechar(c_tab), msechar(' '));
      deleteselection;
      inserttext(mstr1, True);
    finally
      tundoinplaceedit(feditor).endgroup;
    end;
  end;
end;

procedure tundotextedit.Clear;
begin
  tundoinplaceedit(feditor).undolist.Clear;
  inherited;
end;

initialization
  registergriddatalistclass(tgridrichstringdatalist.ClassName,
                     {$ifdef FPC}
    @
{$endif}
    createtgridrichstringdatalist);
end.

