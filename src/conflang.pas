
unit conflang;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

uses 
{$ifdef windows}
windows,
{$endif}
process, classes, msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, 
msemenus, 
msegui, 
msegraphics, msegraphutils, mseevent, mseclasses, msewidgets, mseforms, 
msesimplewidgets, msegraphedits, mseificomp, mseificompglob, mseifiglob, 
msescrollbar, msestatfile, mseact, msedataedits, msedragglob, msedropdownlist, 
mseedit, msegrids, msegridsglob, msestream, msewidgetgrid, SysUtils, msedispwidgets, 
mserichstring;

type 
  tconflangfo = class(tmseform)
    ok: TButton;
    setasdefault: tbooleanedit;
    gridlang: twidgetgrid;
    gridlangcaption: tstringedit;
    gridlangbool: tbooleaneditradio;
    gridlangcode: tstringedit;
    bpotools: tbutton;
    lsetasdefault: tlabel;
    bousemo: tbooleanedit;
    fontsize: tintegeredit;
    lfontselected: tlabel;
    gridlistfont: tstringgrid;
    procedure oncok(Const Sender: TObject);
    procedure oncreat(Const Sender: TObject);
    procedure oncellev(Const Sender: TObject; Var info: celleventinfoty);
    procedure ontools(Const sender: TObject);
    procedure listlangfont(lang : String);
    procedure onchange(Const sender: TObject);
    procedure ongridfontcellev(Const sender: TObject; Var info: celleventinfoty);
    procedure onchangefontsize(Const sender: TObject);
    procedure updatefontcap();
 end;

var 
  conflangloaded: shortint = 0;
  conflangfo: tconflangfo;

implementation

uses 
main, 
msestockobjects, 
confideu, 
potools, 
confcompiler, 
confdebugger, 
conflang_mfm, 
captionideu;

{$ifdef windows}
function EnumFontsNoDups(
  var LogFont: TEnumLogFontEx;
  var Metric: TNewTextMetricEx;
  FontType: Longint;
  Data: LParam):LongInt; stdcall;
var
  L: TStringList;
  S: String;
begin
  L := TStringList(ptrint(Data));
  S := LogFont.elfLogFont.lfFaceName;
  if L.IndexOf(S)<0 then
    L.Add(S);
  result := 1;
end;
  
procedure tconflangfo.listlangfont(lang : String);
var
  DC: HDC;
  lf: TLogFont;
  L: TStringList;
  i, x: Integer;
begin
 
  {
  DEFAULT_PITCH  = 0;
  FIXED_PITCH    = 1;
  VARIABLE_PITCH = 2;
  MONO_FONT      = 8;

  // font character sets
  ANSI_CHARSET        = 0;
  DEFAULT_CHARSET     = 1;
  SYMBOL_CHARSET      = 2;
  // added for ISO_8859_2 under gtk
  FCS_ISO_10646_1     = 4;  // Unicode;
  FCS_ISO_8859_1      = 5;  //  ISO Latin-1 (Western Europe);
  FCS_ISO_8859_2      = 6;  //  ISO Latin-2 (Eastern Europe);
  FCS_ISO_8859_3      = 7;  //  ISO Latin-3 (Southern Europe);
  FCS_ISO_8859_4      = 8;  //  ISO Latin-4 (Northern Europe);
  FCS_ISO_8859_5      = 9;  //  ISO Cyrillic;
  FCS_ISO_8859_6      = 10; //  ISO Arabic;
  FCS_ISO_8859_7      = 11; //  ISO Greek;
  FCS_ISO_8859_8      = 12; //  ISO Hebrew;
  FCS_ISO_8859_9      = 13; //  ISO Latin-5 (Turkish);
  FCS_ISO_8859_10     = 14; //  ISO Latin-6 (Nordic);
  FCS_ISO_8859_15     = 15; //  ISO Latin-9, or Latin-0 (Revised Western-European);
  //FCS_koi8_r          = 16; //  KOI8 Russian;
  //FCS_koi8_u          = 17; //  KOI8 Ukrainian (see RFC 2319);
  //FCS_koi8_ru         = 18; //  KOI8 Russian/Ukrainian
  //FCS_koi8_uni        = 19; //  KOI8 ``Unified'' (Russian, Ukrainian, and Byelorussian);
  //FCS_koi8_e          = 20; //  KOI8 ``European,'' ISO-IR-111, or ECMA-Cyrillic;
  // end of our own additions
  MAC_CHARSET         = 77;
  SHIFTJIS_CHARSET    = 128;
  HANGEUL_CHARSET     = 129;
  JOHAB_CHARSET       = 130;
  GB2312_CHARSET      = 134;
  CHINESEBIG5_CHARSET = 136;
  GREEK_CHARSET       = 161;
  TURKISH_CHARSET     = 162;
  VIETNAMESE_CHARSET  = 163;
  HEBREW_CHARSET      = 177;
  ARABIC_CHARSET      = 178;
  BALTIC_CHARSET      = 186;
  RUSSIAN_CHARSET     = 204;
  THAI_CHARSET        = 222;
  EASTEUROPE_CHARSET  = 238;
  OEM_CHARSET         = 255;
  // additional charsets
  }
  
  lf.lfPitchAndFamily := 0;
  lf.lfCharSet := 0;
  lf.lfFaceName := '';
  
  L := TStringList.create;
  L.Sorted := True;
  L.Duplicates := dupIgnore;
  
  x := 0;
  
  DC := GetDC(0);
  try
    EnumFontFamiliesEX(DC, @lf, @EnumFontsNoDups, ptrint(L), 0);
    // L.Sort;
    caption := inttostr(L.count);
    
          gridlistfont.rowcount := 5;
          gridlistfont[0][0] := 'stf_default';
          gridlistfont[0][1] := 'stf_courier';
          gridlistfont[0][2] := 'stf_helvetica';
          gridlistfont[0][3] := 'stf_roman';
          gridlistfont[0][4] := 'stf_proportional';
   
      while x < L.count do
        begin
          gridlistfont.rowcount :=  gridlistfont.rowcount + 1;
          gridlistfont[0][gridlistfont.rowcount - 1] := L[x];
          inc(x);
        end;
  
    finally
    ReleaseDC(0, DC);
    L.Free;
  end;
end;
{$endif}


{$ifdef unix}
procedure tconflangfo.listlangfont(lang : String);
var 
  x, y: integer;
  s, S2, s3 : string;
  comstr : string;
  sl: TStringList;
 begin

  comstr := '';

  if fileexists('/usr/bin/fc-list') then
    comstr := '/usr/bin/fc-list'
  else
    if fileexists('/usr/local/bin/fc-list') then
      comstr := '/usr/local/bin/fc-list';

  if comstr <> '' then
    begin

      sl := TStringList.create;
      sl.Sorted := True;
      sl.Duplicates := dupIgnore;

      x := 0;

      RunCommand(comstr, [':lang='+ lang, '--format=%{family[0]}\n'], s);

      while (system.pos(lineend,s) > 0) do
        begin
          y := system.pos(lineend,s);
          s2 := system.Copy(s, 1, y - 1);
          //writeln(s2);
          sl.Add(s2);
          s := system.Copy(s, (y + 1) , length(s));
          inc(x);
        end;

      //writeln('String lines ' + inttostr(x));
      //writeln('TStringList ' + inttostr(sl.count));

      if (lang = 'zh') or (lang = 'ar') or  (lang = 'he') then
        gridlistfont.rowcount := 0
      else
        begin
          gridlistfont.rowcount := 5;
          gridlistfont[0][0] := 'stf_default';
          gridlistfont[0][1] := 'stf_courier';
          gridlistfont[0][2] := 'stf_helvetica';
          gridlistfont[0][3] := 'stf_roman';
          gridlistfont[0][4] := 'stf_proportional';
        end;

     x :=  gridlistfont.rowcount;

      while x < sl.count do
        begin
          gridlistfont.rowcount :=  gridlistfont.rowcount + 1;
          gridlistfont[0][x] := sl[x];
          inc(x);
        end;
        
      sl.free;
      
      end else
       begin
          gridlistfont.rowcount := 5;
          gridlistfont[0][0] := 'stf_default';
          gridlistfont[0][1] := 'stf_courier';
          gridlistfont[0][2] := 'stf_helvetica';
          gridlistfont[0][3] := 'stf_roman';
          gridlistfont[0][4] := 'stf_proportional';
        end;
 
end;
{$endif}

procedure tconflangfo.oncok(Const Sender: TObject);
begin
  Close;
end;

procedure tconflangfo.oncreat(Const Sender: TObject);
begin
  Visible := False;
end;

procedure tconflangfo.updatefontcap();
var 
  strz : string = '';
begin
 if MSEFallbackLang = 'zh' then strz := '             ';
              fontsize.frame.caption := lang_settings[Ord(se_fontsize)] + strz ;
              gridlistfont.fixrows[-1].captions[0].caption :=
              inttostr(gridlistfont.rowcount) + ' ' +
              lang_settings[Ord(se_fontname)]  + strz ;
 end;             


procedure tconflangfo.oncellev(Const Sender: TObject; Var info: celleventinfoty);
var 
  x: integer;

begin

  if conflangloaded > 0 then
    if info.eventkind = cek_buttonrelease then
      begin
        MSEFallbackLang := '';
        for x           := 0 to gridlang.rowcount - 1 do
          if x = info.cell.row then
            begin
              gridlangbool[x] := True;
              MSEFallbackLang := gridlangcode[x];
              lfontselected.caption := '';
              mainfo.setlangideu(MSEFallbackLang);
               {$ifndef windows}
                listlangfont(MSEFallbackLang);
               {$endif}
               updatefontcap();
                          
             end
          else
            gridlangbool[x] := False;
      end;
end;

procedure tconflangfo.ontools(Const sender: TObject);
begin
  headerfo.show(true);
end;

procedure tconflangfo.onchange(Const sender: TObject);
begin
  if conflangloaded > 0 then
    mainfo.setlangideu(MSEFallbackLang);
end;

procedure tconflangfo.ongridfontcellev(Const sender: TObject;
                                       Var info: celleventinfoty);
var 
  cellpos: gridcoordty;
  x: integer;
begin
  cellpos := info.cell;

  if (info.eventkind = cek_buttonrelease) then
    begin
      gridlistfont.defocuscell;
      gridlistfont.datacols.clearselection;
      if (cellpos.col > -1) then
        begin
          cellpos.col := 0;
          gridlistfont.selectcell(cellpos, csm_select, False);
          lfontselected.caption :=  gridlistfont[0][cellpos.row] ;

          if (confideufo.fontname.value <> gridlistfont[0][cellpos.row])
             or (confideufo.fontsize.value <> fontsize.value) then
            begin
              confideufo.fontname.value := gridlistfont[0][cellpos.row];
              confideufo.fontsize.value := fontsize.value;
              confideufo.onchangefont;
            end;
        end;
    end;
end;

procedure tconflangfo.onchangefontsize(Const sender: TObject);
begin
  if conflangloaded > 0 then
    if (confideufo.fontsize.value <> fontsize.value) then
      begin
       // confideufo.fontsize.value := fontsize.value;
       // confideufo.onchangefont;
      end;
end;

end.
