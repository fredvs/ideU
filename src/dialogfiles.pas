unit dialogfiles;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 msegraphics,msegraphutils,mseevent,mseclasses,msewidgets,mseforms,mseact,
 msebitmap,msedataedits,msedatanodes,mseedit,msegrids,mseificomp,
 mseificompglob,mseifiglob,mselistbrowser,msestatfile,msestream,msestrings,
 msesys,sysutils,msesimplewidgets, sourceform, commandorform, msedispwidgets,
 mserichstring, msefiledialog;
type
 tdialogfilesfo = class(tmseform)
   tbutton1: tbutton;
   tbutton2: tbutton;
   selected_file: tedit;
   tstringdisp1: tstringdisp;
   list_files: tfilelistview;
   procedure loaddef(const sender: tcustomlistview);
   procedure butok(const sender: TObject);
   procedure butcancel(const sender: TObject);
   procedure oncloseev(const sender: TObject);
 end;

var
 dialogfilesfo: tdialogfilesfo;
 tabind : integer = -1;
 dialogfilesformcreated: boolean = true;

 thesdef : msestring = '';
 theactivepage : msestring = '';
 han : integer = -1;

 procedure dodialogfiles;

implementation
uses
 dialogfiles_mfm, main;

procedure dodialogfiles;
begin
try
application.createform(tdialogfilesfo, dialogfilesfo);
  dialogfilesfo.show;
    dialogfilesfo.bringtofront;
    dialogfilesformcreated := true;
   finally
   end;
end;


procedure tdialogfilesfo.loaddef(const sender: tcustomlistview);
var
 str1: ttextstream;
begin
layoutbusy := true;
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
 
  mainfo.Window.RecreateWindow;

  if (tabind < 0) and (sourcefo.files_tab.count > 0) then
      sourcefo.files_tab.activepageindex:= 0;

if (tabind > -1) and (sourcefo.files_tab.count > 0) then
      sourcefo.files_tab.activepageindex:= tabind;

  finally
  str1.destroy();
  application.processmessages;
  setfocus;
 end;
end;

layoutbusy := false;
 end;


procedure tdialogfilesfo.butok(const sender: TObject);
begin
layoutbusy := true;
if selected_file.text <> '' then
begin
if tag = 0 then
begin
thesdef := list_files.directory+ directoryseparator +selected_file.text ;
end;

end;
layoutbusy := false;
close;
end;

procedure tdialogfilesfo.butcancel(const sender: TObject);
begin
layoutbusy := true;
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
layoutbusy := false;
end;

procedure tdialogfilesfo.oncloseev(const sender: TObject);
begin
//dialogfilesformcreated:= false;
end;

end.
