unit dialogfiles;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 msegraphics,msegraphutils,mseevent,mseclasses,msewidgets,mseforms,mseact,
 msebitmap,msedataedits,msedatanodes,mseedit,msefiledialog,msegrids,mseificomp,
 mseificompglob,mseifiglob,mselistbrowser,msestatfile,msestream,msestrings,
 msesys,sysutils,msesimplewidgets, sourceform;
type
 tdialogfilesfo = class(tmseform)
   tbutton1: tbutton;
   tbutton2: tbutton;
   selected_file: tedit;
   list_layout: tfilelistview;
   list_sdef: tfilelistview;
   procedure loaddef(const sender: tcustomlistview);
   procedure butok(const sender: TObject);
   procedure butcancel(const sender: TObject);
 end;
var
 dialogfilesfo: tdialogfilesfo;
 thesdef : msestring = '';
 
implementation
uses
 dialogfiles_mfm, main;
 
procedure tdialogfilesfo.loaddef(const sender: tcustomlistview);
var
 str1: ttextstream;
 
begin

if (tag = 0) and (list_sdef.selectednames[0] <> '') then
 begin
selected_file.text := list_sdef.selectednames[0] ;
// list_sdef.directory := expandprmacros('${SYNTAXDEFDIR}') ;
sourcefo.activepage.edit.setsyntaxdef(sourcefo.syntaxpainter.readdeffile(list_sdef.directory+ directoryseparator +selected_file.text));
sourcefo.activepage.updatestatvalues;
end;
 
 if (tag = 1) and (list_layout.selectednames[0] <> '') then
 begin
 selected_file.text := list_layout.selectednames[0] ;
 str1:= ttextstream.create(list_layout.directory+ directoryseparator +selected_file.text);
 try
  mainfo.loadwindowlayout(str1);
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
thesdef := list_sdef.directory+ directoryseparator +selected_file.text ;
end;

end;
close ;
end;

procedure tdialogfilesfo.butcancel(const sender: TObject);
begin
if tag = 0 then
 begin
if (list_sdef.directory+ directoryseparator +selected_file.text <> thesdef) and (thesdef <> '') then 
begin
sourcefo.activepage.edit.setsyntaxdef(sourcefo.syntaxpainter.readdeffile(thesdef));
sourcefo.activepage.updatestatvalues;
end;
end;

close ;
end;

end.
