unit conflang;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus,
 msegui,msegraphics, msegraphutils, mseevent, mseclasses, msewidgets, mseforms,
 msesimplewidgets, msegraphedits, mseificomp, mseificompglob, mseifiglob,
 msescrollbar;
type
 tconflangfo = class(tmseform)
   grouplang: tgroupbox;
   ok: tbutton;
   english: tbooleaneditradio;
   russian: tbooleaneditradio;
   french: tbooleaneditradio;
   german: tbooleaneditradio;
   spanish: tbooleaneditradio;
   setasdefault: tbooleanedit;
   procedure onchangelang(const sender: TObject);
   procedure onsetval(const sender: TObject; var avalue: Boolean;
                   var accept: Boolean);
   procedure oncok(const sender: TObject);
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

  MSEFallbackLang := '';
  
  if english.value = true then MSEFallbackLang := 'en' else
  if russian.value = true then MSEFallbackLang := 'ru' else
  if french.value = true then MSEFallbackLang := 'fr' else
  if german.value = true then MSEFallbackLang := 'de' else
  if spanish.value = true then MSEFallbackLang := 'es';
 
  mainfo.setlang(MSEFallbackLang);
  confideufo.setlangextrasettings();
  confcompilerfo.setlangcompilers();
  confdebuggerfo.setlangdebuggers();
end;

end;

procedure tconflangfo.onsetval(const sender: TObject; var avalue: Boolean;
               var accept: Boolean);
begin
onchangelang(Sender);
end;

procedure tconflangfo.oncok(const sender: TObject);
begin
onchangelang(Sender);
close;
end;

end.
