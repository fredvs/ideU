unit dialogfiles;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  msetypes,
  mseglob,
  mseguiglob,
  msegridsglob,
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
    procedure onitem(const sender: tcustomlistview; const index: Integer;
                   var info: celleventinfoty);
  end;

var
  dialogfilesfo: tdialogfilesfo;
  tabind: integer = -1;
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
var
  ratio: double;
begin
  try
    ratio := confideufo.fontsize.Value / 12;
    application.createform(tdialogfilesfo, dialogfilesfo);
    
    dialogfilesfo.icon  := mainfo.icon;
    dialogfilesfo.selected_file.font.Height := confideufo.fontsize.Value;
    dialogfilesfo.selected_file.font.Name   := ansistring(confideufo.fontname.Value);

    dialogfilesfo.list_files.cellwidth := round((ratio) * 262);

    dialogfilesfo.selected_file.frame.font.Height := confideufo.fontsize.Value;

    dialogfilesfo.selected_file.frame.font.Name := ansistring(confideufo.fontname.Value);

    dialogfilesfo.list_files.cellheight  := round((ratio) * 19);
    dialogfilesfo.list_files.font.Height := confideufo.fontsize.Value;
    dialogfilesfo.list_files.font.Name   := ansistring(confideufo.fontname.Value);

    dialogfilesfo.Height := round((ratio) * 400);
    dialogfilesfo.Width  := round((ratio) * 336);
    dialogfilesfo.list_files.cellwidth := dialogfilesfo.list_files.Width - 6;

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

   if ((system.copy(selected_file.Text, 1, 5) = 'Menu_') or
      (system.copy(selected_file.Text, 1, 5) = 'Dock_') or
      (system.copy(selected_file.Text, 1, 4) = 'All_') or
      (system.copy(selected_file.Text, 1, 6) = 'Float_') or
      (system.copy(selected_file.Text, 1, 7) = 'Editor_')) and
      (fontheightused <> 12) 
    then
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

     // if lowercase(system.copy(selected_file.Text, 1, 4)) = 'full' then
     //   mainfo.Window.RecreateWindow;

      if (tabind < 0) and (sourcefo.files_tab.Count > 0) then
        sourcefo.files_tab.activepageindex := 0;

      if (tabind > -1) and (sourcefo.files_tab.Count > 0) then
        sourcefo.files_tab.activepageindex := tabind;

    finally
      str1.Destroy();
     // application.ProcessMessages;
     // SetFocus;
    end;
  end;
 
  invalidatewidget;
  
  bringtofront;

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

procedure tdialogfilesfo.onitem(const sender: tcustomlistview;
               const index: Integer; var info: celleventinfoty);
begin
if info.eventkind = cek_select then
begin
invalidatewidget;
end;

end;

end.

