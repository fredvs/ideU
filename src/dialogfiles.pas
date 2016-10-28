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
   list_sdef: tfilelistview;
   selected_sdef: tedit;
   procedure loaddef(const sender: tcustomlistview);
   procedure butok(const sender: TObject);
   procedure butcancel(const sender: TObject);
 end;
var
 dialogfilesfo: tdialogfilesfo;
 thesdef : msestring = '';
 
implementation
uses
 dialogfiles_mfm;
 
procedure tdialogfilesfo.loaddef(const sender: tcustomlistview);
begin
if list_sdef.selectednames[0] <> '' then
begin
// list_sdef.directory := expandprmacros('${SYNTAXDEFDIR}') ;
selected_sdef.text := list_sdef.selectednames[0] ;
sourcefo.activepage.edit.setsyntaxdef(sourcefo.syntaxpainter.readdeffile(list_sdef.directory+ directoryseparator +selected_sdef.text));
sourcefo.activepage.updatestatvalues;
end;
end; 

procedure tdialogfilesfo.butok(const sender: TObject);
begin
if selected_sdef.text <> '' then 
begin
thesdef := list_sdef.directory+ directoryseparator +selected_sdef.text ;
end;
close ;
end;

procedure tdialogfilesfo.butcancel(const sender: TObject);
begin
if (list_sdef.directory+ directoryseparator +selected_sdef.text <> thesdef) and (thesdef <> '') then 
begin
sourcefo.activepage.edit.setsyntaxdef(sourcefo.syntaxpainter.readdeffile(thesdef));
sourcefo.activepage.updatestatvalues;
end;
close ;
end;

end.
