
unit conflang;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

uses 
process, classes, msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus, 
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

procedure tconflangfo.listlangfont(lang : String);
var 
  x, y: integer;
  s, S2, s3 : string;
  comstr : string;
  sl: TStringList;
begin

{$ifdef unix}
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
{$endif}

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

 {$ifdef unix}
      x :=  gridlistfont.rowcount;

      while x < sl.count do
        begin
          gridlistfont.rowcount :=  gridlistfont.rowcount + 1;
          gridlistfont[0][x] := sl[x];
          inc(x);
        end;

      // gridlistfont.fixrows[0].captions[0].caption :=
      // inttostr(gridlistfont.rowcount) + ' Compatible Fonts';

      sl.free;
{$endif}

    end;

end;

procedure tconflangfo.oncok(Const Sender: TObject);
begin
  Close;
end;

procedure tconflangfo.oncreat(Const Sender: TObject);
begin
  Visible := False;
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
              listlangfont(MSEFallbackLang);
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
