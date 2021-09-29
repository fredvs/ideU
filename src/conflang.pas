unit conflang;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus,
 msegui,msegraphics, msegraphutils, mseevent, mseclasses, msewidgets, mseforms,
 msesimplewidgets, msegraphedits, mseificomp, mseificompglob, mseifiglob,
 msescrollbar, msestatfile, mseact, msedataedits, msedragglob, msedropdownlist,
 mseedit, msegrids, msegridsglob, msestream, msewidgetgrid, sysutils,
 msedispwidgets, mserichstring;
type
 tconflangfo = class(tmseform)
   ok: tbutton;
   setasdefault: tbooleanedit;
   
   gridlang: twidgetgrid;
   gridlangcaption: tstringedit;
   gridlangbool: tbooleaneditradio;
   gridlangcode: tstringedit;
   procedure onchangelang(const sender: TObject);
   procedure oncok(const sender: TObject);
   procedure oncreat(const sender: TObject);
   procedure oncellev(const sender: TObject; var info: celleventinfoty);
 end;
var
 conflangloaded : shortint = 0 ;
 conflangfo: tconflangfo;
implementation
uses
 main, confideu, confcompiler, confdebugger,conflang_mfm;

procedure tconflangfo.onchangelang(const sender: TObject);
begin
if conflangloaded > 0 then
begin
  mainfo.setlang(MSEFallbackLang);
  confideufo.setlangextrasettings();
  confcompilerfo.setlangcompilers();
  confdebuggerfo.setlangdebuggers();
end;

end;

procedure tconflangfo.oncok(const sender: TObject);
begin
 mainfo.setlang(MSEFallbackLang);
 confideufo.setlangextrasettings();
 confcompilerfo.setlangcompilers();
 confdebuggerfo.setlangdebuggers();
 
//onchangelang(Sender);
close;
end;

procedure tconflangfo.oncreat(const sender: TObject);
begin
visible := false;
end;

procedure tconflangfo.oncellev(const sender: TObject;
               var info: celleventinfoty);
var
x : integer;

begin
if conflangloaded > 0 then
begin
if info.eventkind = cek_buttonpress then
begin
 MSEFallbackLang := '';
 for x := 0 to gridlang.rowcount - 1 do
if x = info.cell.row then 
begin
gridlangbool[x] := true;

MSEFallbackLang := gridlangcode[x] ;

 mainfo.setlang(MSEFallbackLang);
 
  confideufo.setlangextrasettings();
  confcompilerfo.setlangcompilers();
  confdebuggerfo.setlangdebuggers();
 

end
else gridlangbool[x] := false;
end;

end;
end;

end.
