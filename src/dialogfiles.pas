unit dialogfiles;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  msetypes,
  mseglob,
  mseguiglob,
  mseguiintf,
  mseapplication,
  msestat,
  msemenus,
  msegui,
  msegraphics,
  msegraphutils,
  mseevent,
  mseclasses,
  msewidgets,
  mseforms,
  mseact,
  msebitmap,
  msedataedits,
  msedatanodes,
  mseedit,
  msegrids,
  mseificomp,
  mseificompglob,
  mseifiglob,
  mselistbrowser,
  msestatfile,
  msestream,
  msestrings,
  msesys,
  SysUtils,
  msesimplewidgets,
  msedispwidgets,
  mserichstring,
  msefiledialog;

type
  tdialogfilesfo = class(tmseform)
    tbutton1: TButton;
    tbutton2: TButton;
    selected_file: tedit;
    tstringdisp1: tstringdisp;
    list_files: tfilelistview;
    procedure loaddef(const Sender: tcustomlistview);
    procedure butok(const Sender: TObject);
    procedure butcancel(const Sender: TObject);
    procedure oncloseev(const Sender: TObject);
  end;

var
  dialogfilesfo: tdialogfilesfo;
  tabind: integer = -1;
  dialogfilesformcreated: Boolean = True;

  thesdef: msestring = '';
  theactivepage: msestring = '';
  han: integer = -1;

procedure dodialogfiles;

implementation

uses
  dialogfiles_mfm,
  main,
  commandorform,
  sourceform,
  confideu,
  messageform;

procedure dodialogfiles;
begin
  try
    application.createform(tdialogfilesfo, dialogfilesfo);
    dialogfilesfo.Show;
    dialogfilesfo.bringtofront;
    dialogfilesformcreated := True;
  finally
  end;
end;

procedure tdialogfilesfo.loaddef(const Sender: tcustomlistview);
var
  str1: ttextstream;
  fontheightused: integer;
begin
  layoutbusy := True;
  if Assigned(list_files.selectednames) and (tag = 0) then
  begin
    if han <> -1 then
      sourcefo.syntaxpainter.freedeffile(han);
    selected_file.Text := list_files.selectednames[0];
    han           := sourcefo.syntaxpainter.readdeffile(list_files.directory +
      directoryseparator + selected_file.Text);
    // list_sdef.directory := expandprmacros('${SYNTAXDEFDIR}') ;
    theactivepage := sourcefo.ActivePage.filepath + sourcefo.ActivePage.filename;
    sourcefo.ActivePage.edit.setsyntaxdef(han);
    sourcefo.ActivePage.updatestatvalues;
  end;

  if Assigned(list_files.selectednames) and (tag = 1) then
  begin
    selected_file.Text := list_files.selectednames[0];
    str1 := ttextstream.Create(list_files.directory + directoryseparator + selected_file.Text);
    try
      debuggerfo.Close;

      mainfo.loadwindowlayout(str1);

      fontheightused := confideufo.fontsize.Value;

      if fontheightused <> 12 then
      begin
        mainfo.Width  := round(mainfo.Width * fontheightused / 12);
        mainfo.Height := round(mainfo.Height * fontheightused / 12);

        if (debuggerfo.Visible) and (debuggerfo.parentwidget = nil) then
        begin
          debuggerfo.Width  := round(debuggerfo.Width * fontheightused / 12);
          debuggerfo.Height := round(debuggerfo.Height * fontheightused / 12);
        end;

        if (sourcefo.Visible) and (sourcefo.parentwidget = nil) then
        begin
          sourcefo.Width  := round(sourcefo.Width * fontheightused / 12);
          sourcefo.Height := round(sourcefo.Height * fontheightused / 12);
        end;

        if (messagefo.Visible) and (debuggerfo.parentwidget = nil) then
        begin
          debuggerfo.Width  := round(debuggerfo.Width * fontheightused / 12);
          debuggerfo.Height := round(debuggerfo.Height * fontheightused / 12);
        end;
      end;

      if lowercase(system.copy(selected_file.Text, 1, 4)) = 'full' then
        mainfo.Window.RecreateWindow;

      if (tabind < 0) and (sourcefo.files_tab.Count > 0) then
        sourcefo.files_tab.activepageindex := 0;

      if (tabind > -1) and (sourcefo.files_tab.Count > 0) then
        sourcefo.files_tab.activepageindex := tabind;

    finally
      str1.Destroy();
      application.ProcessMessages;
      SetFocus;
    end;
  end;

  layoutbusy := False;
end;


procedure tdialogfilesfo.butok(const Sender: TObject);
begin
  layoutbusy := True;
  if selected_file.Text <> '' then
    if tag = 0 then
      thesdef := list_files.directory + directoryseparator + selected_file.Text;
  layoutbusy  := False;
  Close;
end;

procedure tdialogfilesfo.butcancel(const Sender: TObject);
begin
  layoutbusy := True;
  if tag = 0 then
    if fileexists(thesdef) and (list_files.directory + directoryseparator + selected_file.Text <> thesdef) then
    begin
      if han <> -1 then
        sourcefo.syntaxpainter.freedeffile(han);
      han           := sourcefo.syntaxpainter.readdeffile(thesdef);
      sourcefo.ActivePage.edit.setsyntaxdef(han);
      sourcefo.ActivePage.updatestatvalues;
      theactivepage := '';
    end;
  layoutbusy := False;
end;

procedure tdialogfilesfo.oncloseev(const Sender: TObject);
begin
  //dialogfilesformcreated:= false;
end;

end.

