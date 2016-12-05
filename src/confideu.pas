unit confideu;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 ideusettings,msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msegui,
 msegraphics,msegraphutils,mseclasses,mseforms,msegraphedits,msesimplewidgets,
 mseificomp,mseificompglob,mseifiglob,msemenus,msescrollbar,msedataedits,
 mseedit,msestat,msestatfile,msestream,msestrings,sysutils,msewidgets,msebitmap,
 msedatanodes,msefiledialog,msegrids,mselistbrowser,msesys,mseact;
type
 tconfideufo = class(tmseform)
   ok: tbutton;
   nozorderenable: tbooleanedit;
   group_file_chaned: tgroupbox;
   tbfileaskload: tbooleaneditradio;
   tbfilenoload: tbooleaneditradio;
   tbfilereload: tbooleaneditradio;
   group_assistive: tgroupbox;
   tbassistive: tbooleanedit;
   tesakitdir: tfilenameedit;
   procedure zorderhandle(const sender: TObject);
   procedure epandfilenamemacro(const sender: TObject; var avalue: msestring;
                     var accept: Boolean);
   
   procedure setvalue(const sender: TObject; var avalue: msestring;
           var accept: Boolean);

 end;
var
 confideufo: tconfideufo;
implementation
uses
 confideu_mfm;
procedure tconfideufo.zorderhandle(const sender: TObject);
begin
if nozorderenable.value = true then  nozorderhandling:= true else
 nozorderhandling:= false;
end;

procedure tconfideufo.epandfilenamemacro(const sender: TObject;
               var avalue: msestring; var accept: Boolean);

begin
settingsfo.epandfilenamemacro(sender,avalue,accept);
end;

procedure tconfideufo.setvalue(const sender: TObject; var avalue: msestring;
           var accept: Boolean);
begin
settingsfo.setvalue(sender,avalue,accept);
end;

end.
