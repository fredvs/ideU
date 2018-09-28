unit dialogfiles;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 msegraphics,msegraphutils,mseevent,mseclasses,msewidgets,mseforms,mseact,
 msebitmap,msedataedits,msedatanodes,mseedit,msefiledialog,msegrids,mseificomp,
 mseificompglob,mseifiglob,mselistbrowser,msestatfile,msestream,msestrings,
 msesys,sysutils,msesimplewidgets, sourceform, commandorform;
type
 tdialogfilesfo = class(tmseform)
   tbutton1: tbutton;
   tbutton2: tbutton;
   list_files: tfilelistview;
   selected_file: tedit;
   procedure loaddef(const sender: tcustomlistview);
   procedure butok(const sender: TObject);
   procedure butcancel(const sender: TObject);
 end;
var
 dialogfilesfo: tdialogfilesfo;
  
 thesdef : msestring = '';
 theactivepage : msestring = '';
 han : integer = -1;
 
implementation
uses
 dialogfiles_mfm, main;
 
procedure tdialogfilesfo.loaddef(const sender: tcustomlistview);
var
 str1: ttextstream;
begin

if assigned(list_files.selectednames) and (tag = 0) then
 begin
 if han <> -1 then sourcefo.syntaxpainter.freedeffile(han); 
 selected_file.text := list_files.selectednames[0] ;
 han := sourcefo.syntaxpainter.readdeffile(list_files.directory+ 
 directoryseparator +selected_file.text);
// list_sdef.directory := expandprmacros('${SYNTAXDEFDIR}') ;
theactivepage := sourcefo.activepage.filepath + sourcefo.activepage.filename;
sourcefo.activepage.edit.setsyntaxdef(han);
sourcefo.activepage.updatestatvalues;
end;
 
if assigned(list_files.selectednames) and (tag = 1) then
 begin
 selected_file.text := list_files.selectednames[0] ;
 str1:= ttextstream.create(list_files.directory+ directoryseparator +selected_file.text);
 try
 debuggerfo.close;
 
 mainfo.loadwindowlayout(str1);
 
  if (sourcefo.files_tab.activepageindex < 0) and (sourcefo.files_tab.count > 0) then
  
    sourcefo.files_tab.activepageindex:= 0;
 
  finally
  str1.destroy();
 end;
end;
 end;


procedure tdialogfilesfo.butok(const sender: TObject);
begin
if selected_file.text <> '' then 
begin
if tag = 0 then
begin
thesdef := list_files.directory+ directoryseparator +selected_file.text ;
end;

end;
close ;
end;

procedure tdialogfilesfo.butcancel(const sender: TObject);
begin
if tag = 0 then
 begin
if fileexists(thesdef) and (list_files.directory+ directoryseparator +selected_file.text <> thesdef) then 
begin
if han <> -1 then sourcefo.syntaxpainter.freedeffile(han);
han := sourcefo.syntaxpainter.readdeffile(thesdef);
sourcefo.activepage.edit.setsyntaxdef(han);
sourcefo.activepage.updatestatvalues;
theactivepage := '';
end;
end;
close ;
end;

end.
