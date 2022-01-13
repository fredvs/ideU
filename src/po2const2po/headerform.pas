unit headerform;

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
  mclasses,
  msedataedits,
  msedropdownlist,
  mseedit,
  mseificomp,
  mseificompglob,
  msestockobjects,
  mseifiglob,
  msememodialog,
  msestatfile,
  msestream,
  SysUtils,
  msesimplewidgets,
  mseconsts_ide,
  msefileutils,
  msebitmap,
  msedatanodes,
  msedragglob,
  msegrids,
  msegridsglob,
  LazUTF8,
  mselistbrowser,
  msesys,
  msegraphedits,
  msescrollbar,
  msetimer,
  msedispwidgets,
  mserichstring,
  msestringcontainer,
  msefiledialogx;

type
  theaderfo = class(tmseform)
    memopoheader: tmemodialogedit;
    memopotheader: tmemodialogedit;
    initunit: tmemoedit;
    endmemo: tmemoedit;
    mseconstheader: tmemodialogedit;
    tbutton3: TButton;
    tbutton2: TButton;
    alldir: tbooleanedit;
    tstatfile1: tstatfile;
    ttimer1: ttimer;
    paneldone: tgroupbox;
    labdone: tlabel;
    sc: tstringcontainer;
    impexpfiledialog: tfiledialogx;
    outputdir: tfilenameeditx;
    tbutton4: TButton;
    procedure createnew(const Sender: TObject);
    procedure createnewconst(const Sender: TObject; fn: msestring);
    procedure createnewpo(const Sender: TObject; fn: msestring);
    procedure dosearch(thearray: array of msestring; theindex: integer);
    procedure oncreateform(const Sender: TObject);
    procedure ontime(const Sender: TObject);
  end;

var
  headerfo: theaderfo;
  astro, astrt, acomp: utf8String;
  hasfound: Boolean = False;
  empty: Boolean = False;
  defaultresult, default_resulttext, default_modalresulttext, default_modalresulttextnoshortcut, default_mainformtext, default_actionsmoduletext, default_projectoptionscontext, default_settingstext,
  default_projectoptionstext, default_sourceformtext, default_stockcaption, default_langnamestext, default_extendedtext, constvaluearray: array of msestring;

implementation

uses
  headerform_mfm;

procedure theaderfo.dosearch(thearray: array of msestring; theindex: integer);
var
  str2: utf8String;
  y: integer;
begin
  y        := 0;
  hasfound := False;

  while (y < length(constvaluearray)) and (hasfound = False) do
  begin
    str2  := (constvaluearray[y]);
    acomp := UTF8Copy(str2, 1, system.pos(';', str2) - 1);
    // writeln('---acomp:' + acomp);
    str2  := (UTF8Copy(str2, system.pos(';', str2) + 1, length(str2) - system.pos(';', str2) + 1));
    astro := (UTF8Copy(str2, 1, system.pos(';', str2) - 1));
    astro := utf8StringReplace(astro, '\"', '"', [rfReplaceAll]);
    //  writeln('---astro:' + astro);
    str2  := (UTF8Copy(str2, system.pos(';', str2) + 1, length(str2) - system.pos(';', str2) + 1));
    astrt := UTF8Copy(str2, 1, length(str2));
    astrt := utf8StringReplace(astrt, '\"', '"', [rfReplaceAll]);

    if thearray[theindex] = astro then
      hasfound := True;
    //  writeln('---astrt:' + astrt);

    Inc(y);
  end;
end;

procedure theaderfo.createnewpo(const Sender: TObject; fn: msestring);
var
  x, y: integer;
  file1: ttextdatastream;
  str1, strinit, strlang, filename1: msestring;
  str2, str3, str4, strtemp: utf8String;
  int1: integer;
  isarray1: Boolean = False;
  isarray2: Boolean = False;
  isarray3: Boolean = False;
  isarray4: Boolean = False;
  isarray5: Boolean = False;
  isarray6: Boolean = False;
  isarray7: Boolean = False;
  isarray8: Boolean = False;
  isarray9: Boolean = False;
  isarray10: Boolean = False;
  isarray11: Boolean = False;
  imodalresultty: modalresultty;
  imainformty: mainformty;
  iextendedty: extendedty;
  isourceformty: sourceformty;
  iactionsmodulety: actionsmodulety;
  iprojectoptionsconty: projectoptionsconty;
  iprojectoptionsty: projectoptionsty;
  iisettingsty: isettingsty;
  itextgeneratorty: textgeneratorty;
  istockcaptionty: stockcaptionty;
  theend: Boolean = False;
begin

  str1 := fn;

  if fileexists(str1) and (empty = False) then
  begin
    //  writeln('1');
    file1          := ttextdatastream.Create(str1, fm_read);
    //  writeln('2');
    filename1      := copy(filename(str1), 1, length(filename(str1)) - 4);
    strlang        := trim(copy(filename1, system.pos('_ide_', filename1) + 5,
      length(filename1) - system.pos('_ide_', filename1)));
    // writeln('3 ' + strlang);
    file1.encoding := ce_utf8;

    setlength(constvaluearray, 0);

    file1.readln(str1);

    str3 := '';
    str2 := '';
    str4 := '';

    while (not file1.EOF) and (theend = False) do
    begin
      str1    := '';
      file1.readln(str1);
      strtemp := '';
      //    writeln('4');
      if system.pos('modalresulttext', str1) > 0 then
        isarray1 := True;
      if (isarray1 = True) and (system.pos(#039, str1) > 0) then
      begin
        setlength(constvaluearray, length(constvaluearray) + 1);
        str1 := utf8StringReplace(str1, #039, '', [rfReplaceAll]);
        str1 := utf8StringReplace(str1, #044, '', [rfReplaceAll]);
        if system.pos('//', str1) > 0 then
          str1 := trim(copy(str1, 1, system.pos('//', str1) - 1));
        if system.pos('{', str1) > 0 then
          str1 := trim(copy(str1, 1, system.pos('{', str1) - 1));
        if str1 <> '' then
          constvaluearray[length(constvaluearray) - 1] := trim(str1);
        // writeln(str1);
      end;

      if system.pos('modalresulttextnoshortcut', str1) > 0 then
        isarray2 := True;
      if (isarray2 = True) and (system.pos(#039, str1) > 0) then
      begin
        isarray1 := False;
        setlength(constvaluearray, length(constvaluearray) + 1);
        str1     := utf8StringReplace(str1, #039, '', [rfReplaceAll]);
        str1     := utf8StringReplace(str1, #044, '', [rfReplaceAll]);
        if system.pos('//', str1) > 0 then
          str1 := trim(copy(str1, 1, system.pos('//', str1) - 1));
        if system.pos('{', str1) > 0 then
          str1 := trim(copy(str1, 1, system.pos('{', str1) - 1));
        if str1 <> '' then
          constvaluearray[length(constvaluearray) - 1] := trim(str1);
      end;

      if system.pos('projectoptionscontext', str1) > 0 then
        isarray3 := True;
      if (isarray3 = True) and (system.pos(#039, str1) > 0) then
      begin
        isarray2 := False;
        setlength(constvaluearray, length(constvaluearray) + 1);
        str1     := utf8StringReplace(str1, #039, '', [rfReplaceAll]);
        str1     := utf8StringReplace(str1, #044, '', [rfReplaceAll]);
        if system.pos('//', str1) > 0 then
          str1 := trim(copy(str1, 1, system.pos('//', str1) - 1));
        if system.pos('{', str1) > 0 then
          str1 := trim(copy(str1, 1, system.pos('{', str1) - 1));
        if str1 <> '' then
          constvaluearray[length(constvaluearray) - 1] := trim(str1);
      end;

      if system.pos('actionsmoduletext', str1) > 0 then
        isarray4 := True;
      if (isarray4 = True) and (system.pos(#039, str1) > 0) then
      begin
        isarray3 := False;
        setlength(constvaluearray, length(constvaluearray) + 1);
        str1     := utf8StringReplace(str1, #039, '', [rfReplaceAll]);
        str1     := utf8StringReplace(str1, #044, '', [rfReplaceAll]);
        if system.pos('//', str1) > 0 then
          str1 := trim(copy(str1, 1, system.pos('//', str1) - 1));
        if system.pos('{', str1) > 0 then
          str1 := trim(copy(str1, 1, system.pos('{', str1) - 1));
        if str1 <> '' then
          constvaluearray[length(constvaluearray) - 1] := trim(str1);
      end;

      if system.pos('mainformtext', str1) > 0 then
        isarray5 := True;
      if (isarray5 = True) and (system.pos(#039, str1) > 0) then
      begin
        isarray4 := False;
        setlength(constvaluearray, length(constvaluearray) + 1);
        str1     := utf8StringReplace(str1, #039, '', [rfReplaceAll]);
        str1     := utf8StringReplace(str1, #044, '', [rfReplaceAll]);
        if system.pos('//', str1) > 0 then
          str1 := trim(copy(str1, 1, system.pos('//', str1) - 1));
        if system.pos('{', str1) > 0 then
          str1 := trim(copy(str1, 1, system.pos('{', str1) - 1));
        if str1 <> '' then
          constvaluearray[length(constvaluearray) - 1] := trim(str1);
      end;

      if system.pos('sourceformtext', str1) > 0 then
        isarray6 := True;
      if (isarray6 = True) and (system.pos(#039, str1) > 0) then
      begin
        isarray5 := False;
        setlength(constvaluearray, length(constvaluearray) + 1);
        str1     := utf8StringReplace(str1, #039, '', [rfReplaceAll]);
        str1     := utf8StringReplace(str1, #044, '', [rfReplaceAll]);
        if system.pos('//', str1) > 0 then
          str1 := trim(copy(str1, 1, system.pos('//', str1) - 1));
        if system.pos('{', str1) > 0 then
          str1 := trim(copy(str1, 1, system.pos('{', str1) - 1));
        if str1 <> '' then
          constvaluearray[length(constvaluearray) - 1] := trim(str1);
      end;

      if system.pos('settingstext', str1) > 0 then
        isarray7 := True;
      if (isarray7 = True) and (system.pos(#039, str1) > 0) then
      begin
        isarray6 := False;
        setlength(constvaluearray, length(constvaluearray) + 1);
        str1     := utf8StringReplace(str1, #039, '', [rfReplaceAll]);
        str1     := utf8StringReplace(str1, #044, '', [rfReplaceAll]);
        if system.pos('//', str1) > 0 then
          str1 := trim(copy(str1, 1, system.pos('//', str1) - 1));
        if str1 <> '' then
          constvaluearray[length(constvaluearray) - 1] := trim(str1);
      end;

      if system.pos('projectoptionstext', str1) > 0 then
        isarray8 := True;
      if (isarray8 = True) and (system.pos(#039, str1) > 0) then
      begin
        isarray7 := False;
        setlength(constvaluearray, length(constvaluearray) + 1);
        str1     := utf8StringReplace(str1, #039, '', [rfReplaceAll]);
        str1     := utf8StringReplace(str1, #044, '', [rfReplaceAll]);
        if system.pos('//', str1) > 0 then
          str1 := trim(copy(str1, 1, system.pos('//', str1) - 1));
        if system.pos('{', str1) > 0 then
          str1 := trim(copy(str1, 1, system.pos('{', str1) - 1));
        if str1 <> '' then
          constvaluearray[length(constvaluearray) - 1] := trim(str1);
      end;

      if system.pos('stockcaption', str1) > 0 then
        isarray9 := True;
      if (isarray9 = True) and (system.pos(#039, str1) > 0) then
      begin
        isarray8 := False;
        setlength(constvaluearray, length(constvaluearray) + 1);
        str1     := utf8StringReplace(str1, #039, '', [rfReplaceAll]);
        str1     := utf8StringReplace(str1, #044, '', [rfReplaceAll]);
        if system.pos('//', str1) > 0 then
          str1 := trim(copy(str1, 1, system.pos('//', str1) - 1));
        if system.pos('{', str1) > 0 then
          str1 := trim(copy(str1, 1, system.pos('{', str1) - 1));
        if str1 <> '' then
          constvaluearray[length(constvaluearray) - 1] := trim(str1);
      end;

      if system.pos('langnamestext', str1) > 0 then
        isarray10 := True;
      if (isarray10 = True) and (system.pos(#039, str1) > 0) then
      begin
        isarray9 := False;
        setlength(constvaluearray, length(constvaluearray) + 1);
        str1     := utf8StringReplace(str1, #039, '', [rfReplaceAll]);
        str1     := utf8StringReplace(str1, #044, '', [rfReplaceAll]);
        if system.pos('//', str1) > 0 then
          str1 := trim(copy(str1, 1, system.pos('//', str1) - 1));
        if system.pos('{', str1) > 0 then
          str1 := trim(copy(str1, 1, system.pos('{', str1) - 1));
        if str1 <> '' then
          constvaluearray[length(constvaluearray) - 1] := trim(str1);
      end;

      if system.pos('extendedtext', str1) > 0 then
        isarray11 := True;
      if (isarray11 = True) and (system.pos(#039, str1) > 0) then
      begin
        isarray10 := False;
        setlength(constvaluearray, length(constvaluearray) + 1);
        str1      := utf8StringReplace(str1, #039, '', [rfReplaceAll]);
        str1      := utf8StringReplace(str1, #044, '', [rfReplaceAll]);
        if system.pos('//', str1) > 0 then
          str1 := trim(copy(str1, 1, system.pos('//', str1) - 1));
        if system.pos('{', str1) > 0 then
          str1 := trim(copy(str1, 1, system.pos('{', str1) - 1));
        if str1 <> '' then
          constvaluearray[length(constvaluearray) - 1] := trim(str1);
      end;

      if system.pos('delete_n_selected_rows', str1) > 0 then
        theend := True;
    end;
    //writeln('5');
    file1.Free;
  end;

  setlength(default_modalresulttext, length(en_modalresulttext));
  for imodalresultty := Low(modalresultty) to High(modalresultty) do
    default_modalresulttext[Ord(imodalresultty)] := en_modalresulttext[(imodalresultty)];

  // default_modalresulttext := en_modalresulttext;
  for imodalresultty := Low(modalresultty) to High(modalresultty) do
    default_modalresulttext[Ord(imodalresultty)] := en_modalresulttext[(imodalresultty)];
  y := 0;

  setlength(defaultresult, length(default_modalresulttext) + y);
  for x := 0 to length(default_modalresulttext) - 1 do
    defaultresult[x + y] := default_modalresulttext[x];

  setlength(default_modalresulttextnoshortcut, length(en_modalresulttextnoshortcut));

  // default_modalresulttextnoshortcut := en_modalresulttextnoshortcut;
  for imodalresultty := Low(modalresultty) to High(modalresultty) do
    default_modalresulttextnoshortcut[Ord(imodalresultty)] :=
      en_modalresulttextnoshortcut[(imodalresultty)];

  y := length(defaultresult);

  setlength(defaultresult, length(default_modalresulttextnoshortcut) + y);
  for x := 0 to length(default_modalresulttextnoshortcut) - 1 do
    defaultresult[x + y] := default_modalresulttextnoshortcut[x];

  setlength(default_projectoptionscontext, length(en_projectoptionscontext));

  //default_projectoptionscontext := en_projectoptionscontext;
  for iprojectoptionsconty := Low(projectoptionsconty) to High(projectoptionsconty) do
    default_projectoptionscontext[Ord(iprojectoptionsconty)] :=
      en_projectoptionscontext[(iprojectoptionsconty)];

  y := length(defaultresult);

  setlength(defaultresult, length(default_projectoptionscontext) + y);
  for x := 0 to length(default_projectoptionscontext) - 1 do
    defaultresult[x + y] := default_projectoptionscontext[x];

  setlength(default_actionsmoduletext, length(en_actionsmoduletext));

  //default_actionsmoduletext := en_actionsmoduletext;
  for iactionsmodulety := Low(actionsmodulety) to High(actionsmodulety) do
    default_actionsmoduletext[Ord(iactionsmodulety)] :=
      en_actionsmoduletext[(iactionsmodulety)];

  y := length(defaultresult);

  setlength(defaultresult, length(default_actionsmoduletext) + y);
  for x := 0 to length(default_actionsmoduletext) - 1 do
    defaultresult[x + y] := default_actionsmoduletext[x];

  setlength(default_mainformtext, length(en_mainformtext));

  //default_mainformtext := en_mainformtext;
  for imainformty := Low(mainformty) to High(mainformty) do
    default_mainformtext[Ord(imainformty)] :=
      en_mainformtext[(imainformty)];

  y := length(defaultresult);

  setlength(defaultresult, length(default_mainformtext) + y);
  for x := 0 to length(default_mainformtext) - 1 do
    defaultresult[x + y] := default_mainformtext[x];

  setlength(default_sourceformtext, length(en_sourceformtext));

  //default_sourceformtext := en_sourceformtext;
  for isourceformty := Low(sourceformty) to High(sourceformty) do
    default_sourceformtext[Ord(isourceformty)] :=
      en_sourceformtext[(isourceformty)];

  y := length(defaultresult);

  setlength(defaultresult, length(default_sourceformtext) + y);
  for x := 0 to length(default_sourceformtext) - 1 do
    defaultresult[x + y] := default_sourceformtext[x];

  setlength(default_settingstext, length(en_settingstext));

  //default_settingstext := en_settingstext;
  for iisettingsty := Low(isettingsty) to High(isettingsty) do
    default_settingstext[Ord(iisettingsty)] :=
      en_settingstext[(iisettingsty)];

  y := length(defaultresult);

  setlength(defaultresult, length(default_settingstext) + y);
  for x := 0 to length(default_settingstext) - 1 do
    defaultresult[x + y] := default_settingstext[x];

  setlength(default_projectoptionstext, length(en_projectoptionstext));

  //default_projectoptionstext := en_projectoptionstext;
  for iprojectoptionsty := Low(projectoptionsty) to High(projectoptionsty) do
    default_projectoptionstext[Ord(iprojectoptionsty)] :=
      en_projectoptionstext[(iprojectoptionsty)];

  y := length(defaultresult);

  setlength(defaultresult, length(default_projectoptionstext) + y);
  for x := 0 to length(default_projectoptionstext) - 1 do
    defaultresult[x + y] := default_projectoptionstext[x];

  setlength(default_stockcaption, length(en_stockcaption));

  // default_stockcaption := en_stockcaption;
  for istockcaptionty := Low(stockcaptionty) to High(stockcaptionty) do
    default_stockcaption[Ord(istockcaptionty)] :=
      en_stockcaption[(istockcaptionty)];

  y := length(defaultresult);

  setlength(defaultresult, length(default_stockcaption) + y);
  for x := 0 to length(default_stockcaption) - 1 do
    defaultresult[x + y] := default_stockcaption[x];

  setlength(default_langnamestext, length(en_langnamestext));

  // default_langnamestext := en_langnamestext;
  for x := 0 to length(en_langnamestext) - 1 do
    default_langnamestext[x] := en_langnamestext[x];

  y := length(defaultresult);

  setlength(defaultresult, length(default_langnamestext) + y);
  for x := 0 to length(default_langnamestext) - 1 do
    defaultresult[x + y] := default_langnamestext[x];

  setlength(default_extendedtext, length(en_extendedtext));

  //default_extendedtext := en_extendedtext;
  for iextendedty := Low(extendedty) to High(extendedty) do
    default_extendedtext[Ord(iextendedty)] :=
      en_extendedtext[(iextendedty)];

  y := length(defaultresult);

  setlength(defaultresult, length(default_extendedtext) + y);
  for x := 0 to length(default_extendedtext) - 1 do
    defaultresult[x + y] := default_extendedtext[x];

  // writeln(length(defaultresult));
  if empty = False then
    file1 := ttextdatastream.Create(outputdir.Value +
      'mseconsts_ide_' + strlang + '.po', fm_create)
  else
    file1 := ttextdatastream.Create(outputdir.Value +
      'mseconsts_ide_empty.po', fm_create);

  file1.encoding := ce_utf8;

  file1.writeln(memopoheader.Value);
  file1.writeln();

  for x := 0 to length(defaultresult) - 1 do
    if trim(defaultresult[x]) <> '' then
    begin
      file1.writeln('msgid "' + defaultresult[x] + '"');
      if empty = False then
      begin
        if trim(constvaluearray[x]) <> '' then
          file1.writeln('msgstr "' + constvaluearray[x] + '"')
        else
          file1.writeln('msgstr "' + defaultresult[x] + '"');
      end
      else
        file1.writeln('msgstr ""');

      file1.writeln('');
    end;

  file1.Free;

end;

procedure theaderfo.createnew(const Sender: TObject);
var
  x: integer;
  filterlista: msestringarty;
  filterlistb: msestringarty;
  str1, str2: msestring;
  Info: TSearchRec;
  langall: msestring;
begin

  setlength(filterlista, 1);
  setlength(filterlistb, 1);

  if TButton(Sender).tag = 0 then
  begin
    empty          := False;
    filterlista[0] := 'mseconsts_xx.po';
    filterlistb[0] := '*.po';
    impexpfiledialog.controller.filter := '*.po';
    if alldir.Value then
      impexpfiledialog.controller.options := [fdo_directory, fdo_savelastdir]
    else
      impexpfiledialog.controller.options := [fdo_savelastdir];
  end;
  if TButton(Sender).tag = 1 then
  begin
    empty          := False;
    filterlista[0] := 'mseconsts_xx.pas';
    filterlistb[0] := '*.pas';
    impexpfiledialog.controller.filter := '*.pas';
    if alldir.Value then
      impexpfiledialog.controller.options := [fdo_directory, fdo_savelastdir]
    else
      impexpfiledialog.controller.options := [fdo_savelastdir];
  end;

  if TButton(Sender).tag = 2 then
    empty := True;

  if empty = False then
  begin
    with impexpfiledialog.controller.filterlist do
    begin
      asarraya := filterlista;
      asarrayb := filterlistb;
    end;

    impexpfiledialog.controller.filterindex := 0;
    application.ProcessMessages;

    langall := '';

    if impexpfiledialog.controller.Execute(str1, fdk_open) then
    begin
      paneldone.frame.colorclient := $FFD1A1;
      labdone.Caption   := sc[0];
      paneldone.Visible := True;
      application.ProcessMessages;

      if alldir.Value = False then
      begin
        if TButton(Sender).tag = 0 then
          createnewconst(Sender, str1)
        else
          createnewpo(Sender, str1);
      end
      else
      begin

        if TButton(Sender).tag = 0 then
          str2 := '*.po'
        else
          str2 := '*.pas';

        if FindFirst(filedir(str1) + DirectorySeparator + str2, faAnyFile, Info) = 0 then
          repeat
            if TButton(Sender).tag = 0 then
              createnewconst(Sender, filedir(str1) + Info.Name)
            else
              createnewpo(Sender, filedir(str1) + Info.Name);

          until FindNext(Info) <> 0;
        FindClose(Info);

      end;
    end;
  end;

  if empty = True then
    createnewpo(Sender, filedir(str1) + Info.Name);

  paneldone.frame.colorclient := cl_ltgreen;
  labdone.Caption   := sc[1];
  paneldone.Visible := True;
  ttimer1.Enabled   := True;

end;


///////////////

procedure theaderfo.createnewconst(const Sender: TObject; fn: msestring);
var
  x: integer;
  file1: ttextdatastream;
  str1, strinit, strlang, filename1: msestring;
  str2, str3, str4, strtemp: utf8String;
  int1: integer;
  isstring: Boolean = False;
  isid: Boolean = False;
  iscontext: Boolean = False;
  ispocontext: Boolean = False;
  imodalresultty: modalresultty;
  imainformty: mainformty;
  iextendedty: extendedty;
  isourceformty: sourceformty;
  iactionsmodulety: actionsmodulety;
  iprojectoptionsconty: projectoptionsconty;
  iprojectoptionsty: projectoptionsty;
  iisettingsty: isettingsty;
  itextgeneratorty: textgeneratorty;
  istockcaptionty: stockcaptionty;
begin
  str1    := fn;
  strlang := '';

  if fileexists(str1) then
  begin

    file1 := ttextdatastream.Create(str1, fm_read);

    filename1 := copy(filename(str1), 1, length(filename(str1)) - 3);
    strlang   := trim(copy(filename1, system.pos('_', filename1) + 5, length(filename1) - system.pos('_', filename1)));

    strlang := utf8StringReplace(strlang, '@', '_', [rfReplaceAll]);

    file1.encoding := ce_utf8;

    setlength(constvaluearray, 0);

    file1.readln(str1);

    str3 := '';
    str2 := '';
    str4 := '';

    while not file1.EOF do
    begin
      str1    := '';
      file1.readln(str1);
      strtemp := '';

      if (trim(str1) <> '') and (UTF8Copy(str1, 1, 1) <> '#') then
        if (UTF8Copy(str1, 1, 7) = 'msgctxt') then
        begin
          ispocontext := True;

          setlength(constvaluearray, length(constvaluearray) + 1);
          str2      := str4 + utf8String(';') + str2 + utf8String(';') + str3;
          str2      := utf8StringReplace(str2, '\n', '', [rfReplaceAll]);
          str2      := utf8StringReplace(str2, '\', '', [rfReplaceAll]);
          constvaluearray[length(constvaluearray) - 1] := str2;
          // writeln(str2);
          str3      := '';
          str4      := '';
          str4      := (UTF8Copy(str1, 10, length(str1) - 10));
          iscontext := True;
          isid      := False;
          isstring  := False;
        end
        else if (copy(str1, 1, 5) = 'msgid') then
        begin
          if ispocontext = False then
          begin
            setlength(constvaluearray, length(constvaluearray) + 1);
            str2 := str4 + utf8String(';') + str2 + utf8String(';') + str3;
            str2 := utf8StringReplace(str2, '\n', '', [rfReplaceAll]);
            str2 := utf8StringReplace(str2, '\', '', [rfReplaceAll]);
            constvaluearray[length(constvaluearray) - 1] := str2;
            // writeln(str2);
            str3 := '';
            str4 := '';
          end;
          str2 := UTF8Copy(str1, 8, length(str1) - 8);
          iscontext := False;
          isid      := True;
          isstring  := False;
        end
        else if (UTF8Copy(str1, 1, 6) = 'msgstr') then
        begin
          str3      := (UTF8Copy(str1, 9, length(str1) - 9));
          str3      := utf8StringReplace(str3, '\n', '', [rfReplaceAll]);
          iscontext := False;
          isid      := False;
          isstring  := True;
        end
        else if iscontext then
        begin
          strtemp := UTF8Copy(str1, 2, length(str1) - 2);
          if (system.pos('\n', strtemp) > 0) then
          begin
            strtemp := utf8StringReplace(strtemp, '\n', '', [rfReplaceAll]);
            str4    := str4 + strtemp + utf8String(sLineBreak);
          end
          else
            str4    := str4 + strtemp;
        end
        else if isid then
        begin
          strtemp := UTF8Copy(str1, 2, length(str1) - 2);
          if (system.pos('\n', strtemp) > 0) then
          begin
            strtemp := utf8StringReplace(strtemp, '\n', '', [rfReplaceAll]);
            str2    := str2 + strtemp + utf8String(sLineBreak);
          end
          else
            str2    := str2 + strtemp;
        end
        else if isstring then
        begin
          strtemp := UTF8Copy(str1, 2, length(str1) - 2);
          if (system.pos('\n', strtemp) > 0) then
          begin
            strtemp := utf8StringReplace(strtemp, '\n', '', [rfReplaceAll]);
            str3    := (str3 + strtemp + utf8String(sLineBreak));
          end
          else
            str3    := str3 + strtemp;
        end;

    end;
    setlength(constvaluearray, length(constvaluearray) + 1);
    str2 := str4 + utf8String(';') + str2 + utf8String(';') + str3;
    str2 := utf8StringReplace(str2, '\n', '', [rfReplaceAll]);
    str2 := utf8StringReplace(str2, '\', '', [rfReplaceAll]);
    constvaluearray[length(constvaluearray) - 1] := str2;
    // writeln(str2);

    file1.Free;

    setlength(default_modalresulttext, length(en_modalresulttext));
    for imodalresultty := Low(modalresultty) to High(modalresultty) do
      default_modalresulttext[Ord(imodalresultty)] := en_modalresulttext[(imodalresultty)];

    setlength(default_modalresulttextnoshortcut, length(en_modalresulttextnoshortcut));
    for imodalresultty := Low(modalresultty) to High(modalresultty) do
      default_modalresulttextnoshortcut[Ord(imodalresultty)] :=
        en_modalresulttextnoshortcut[(imodalresultty)];

    setlength(default_mainformtext, length(en_mainformtext));
    for imainformty := Low(mainformty) to High(mainformty) do
      default_mainformtext[Ord(imainformty)] :=
        en_mainformtext[(imainformty)];

    setlength(default_actionsmoduletext, length(en_actionsmoduletext));
    for iactionsmodulety := Low(actionsmodulety) to High(actionsmodulety) do
      default_actionsmoduletext[Ord(iactionsmodulety)] :=
        en_actionsmoduletext[(iactionsmodulety)];

    setlength(default_projectoptionscontext, length(en_projectoptionscontext));
    for iprojectoptionsconty := Low(projectoptionsconty) to High(projectoptionsconty) do
      default_projectoptionscontext[Ord(iprojectoptionsconty)] :=
        en_projectoptionscontext[(iprojectoptionsconty)];

    setlength(default_settingstext, length(en_settingstext));
    for iisettingsty := Low(isettingsty) to High(isettingsty) do
      default_settingstext[Ord(iisettingsty)] :=
        en_settingstext[(iisettingsty)];

    setlength(default_projectoptionstext, length(en_projectoptionstext));
    for iprojectoptionsty := Low(projectoptionsty) to High(projectoptionsty) do
      default_projectoptionstext[Ord(iprojectoptionsty)] :=
        en_projectoptionstext[(iprojectoptionsty)];

    setlength(default_sourceformtext, length(en_sourceformtext));
    for isourceformty := Low(sourceformty) to High(sourceformty) do
      default_sourceformtext[Ord(isourceformty)] :=
        en_sourceformtext[(isourceformty)];

    setlength(default_stockcaption, length(en_stockcaption));
    for istockcaptionty := Low(stockcaptionty) to High(stockcaptionty) do
      default_stockcaption[Ord(istockcaptionty)] :=
        en_stockcaption[(istockcaptionty)];

    setlength(default_langnamestext, length(en_langnamestext));
    for x := 0 to length(en_langnamestext) - 1 do
      default_langnamestext[x] := en_langnamestext[x];

    setlength(default_extendedtext, length(en_extendedtext));
    for iextendedty := Low(extendedty) to High(extendedty) do
      default_extendedtext[Ord(iextendedty)] :=
        en_extendedtext[(iextendedty)];

    file1          := ttextdatastream.Create(outputdir.Value + 'mseconsts_ide_' + strlang + '.pas', fm_create);
    file1.encoding := ce_utf8;

    file1.writeln(mseconstheader.Value);
    file1.writeln();

    file1.writeln('unit mseconsts_ide_' + strlang + #059);
    file1.writeln();
    file1.writeln(initunit.Value);

    file1.writeln();

    file1.writeln(strlang + '_modalresulttext: defaultmodalresulttextty =');
    file1.writeln(' (');

    for x := 0 to length(default_modalresulttext) - 1 do
    begin
      dosearch(default_modalresulttext, x);

      if hasfound then
      else
        astrt := default_modalresulttext[x];
      if trim(astrt) = '' then
        astrt := default_modalresulttext[x];

      astrt := utf8StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := utf8StringReplace(astrt, #039, '‘', [rfReplaceAll]);

      if (x < length(default_modalresulttext) - 1) and
        (length(default_modalresulttext) > 1) then
        file1.writeln('  ' + #039 + astrt + #039 + #044 + '   {' + default_modalresulttext[x] + '}')
      else
        file1.writeln('  ' + #039 + astrt + #039 + '   {' + default_modalresulttext[x] + '}');
    end;

    file1.writeln(' );');

    file1.writeln();

    file1.writeln(strlang + '_modalresulttextnoshortcut: defaultmodalresulttextty =');
    file1.writeln(' (');

    for x := 0 to length(default_modalresulttextnoshortcut) - 1 do
    begin
      dosearch(default_modalresulttextnoshortcut, x);

      if hasfound then
      else
        astrt := default_modalresulttextnoshortcut[x];
      if trim(astrt) = '' then
        astrt := default_modalresulttextnoshortcut[x];

      astrt := utf8StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := utf8StringReplace(astrt, #039, '‘', [rfReplaceAll]);

      if (x < length(default_modalresulttextnoshortcut) - 1) and
        (length(default_modalresulttextnoshortcut) > 1) then
        file1.writeln('  ' + #039 + astrt + #039 + #044 + '   {' + default_modalresulttextnoshortcut[x] + '}')
      else
        file1.writeln('  ' + #039 + astrt + #039 + '   {' + default_modalresulttextnoshortcut[x] + '}');
    end;

    file1.writeln(' );');

    file1.writeln();

    file1.writeln(strlang + '_projectoptionscontext: projectoptionsconaty =');

    file1.writeln(' (');
    for x := 0 to length(default_projectoptionscontext) - 1 do
    begin
      dosearch(default_projectoptionscontext, x);

      if hasfound then
      else
        astrt := default_projectoptionscontext[x];
      if trim(astrt) = '' then
        astrt := default_projectoptionscontext[x];

      astrt := utf8StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := utf8StringReplace(astrt, #039, '‘', [rfReplaceAll]);

      if (x < length(default_projectoptionscontext) - 1) and
        (length(default_projectoptionscontext) > 1) then
        file1.writeln('  ' + #039 + astrt + #039 + #044 + '   {' + default_projectoptionscontext[x] + '}')
      else
        file1.writeln('  ' + #039 + astrt + #039 + '   {' + default_projectoptionscontext[x] + '}');
    end;

    file1.writeln(' );');

    file1.writeln();

    file1.writeln(strlang + '_actionsmoduletext: actionsmoduleaty =');

    file1.writeln(' (');
    for x := 0 to length(default_actionsmoduletext) - 1 do
    begin
      dosearch(default_actionsmoduletext, x);

      if hasfound then
      else
        astrt := default_actionsmoduletext[x];
      if trim(astrt) = '' then
        astrt := default_actionsmoduletext[x];

      astrt := utf8StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := utf8StringReplace(astrt, #039, '‘', [rfReplaceAll]);

      if (x < length(default_actionsmoduletext) - 1) and
        (length(default_actionsmoduletext) > 1) then
        file1.writeln('  ' + #039 + astrt + #039 + #044 + '   {' + default_actionsmoduletext[x] + '}')
      else
        file1.writeln('  ' + #039 + astrt + #039 + '   {' + default_actionsmoduletext[x] + '}');
    end;

    file1.writeln(' );');

    file1.writeln();

    file1.writeln(strlang + '_mainformtext: mainformaty =');

    file1.writeln(' (');

    for x := 0 to length(default_mainformtext) - 1 do
    begin
      dosearch(default_mainformtext, x);

      if hasfound then
      else
        astrt := default_mainformtext[x];
      if trim(astrt) = '' then
        astrt := default_mainformtext[x];

      astrt := utf8StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := utf8StringReplace(astrt, #039, '‘', [rfReplaceAll]);

      if (x < length(default_mainformtext) - 1) and
        (length(default_mainformtext) > 1) then
        file1.writeln('  ' + #039 + astrt + #039 + #044 + '   {' + default_mainformtext[x] + '}')
      else
        file1.writeln('  ' + #039 + astrt + #039 + '   {' + default_mainformtext[x] + '}');
    end;

    file1.writeln(' );');

    file1.writeln();

    file1.writeln(strlang + '_sourceformtext: sourceformaty =');

    file1.writeln(' (');
    for x := 0 to length(default_sourceformtext) - 1 do
    begin
      dosearch(default_sourceformtext, x);

      if hasfound then
      else
        astrt := default_sourceformtext[x];
      if trim(astrt) = '' then
        astrt := default_sourceformtext[x];

      astrt := utf8StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := utf8StringReplace(astrt, #039, '‘', [rfReplaceAll]);

      if (x < length(default_sourceformtext) - 1) and
        (length(default_sourceformtext) > 1) then
        file1.writeln('  ' + #039 + astrt + #039 + #044 + '   {' + default_sourceformtext[x] + '}')
      else
        file1.writeln('  ' + #039 + astrt + #039 + '   {' + default_sourceformtext[x] + '}');
    end;

    file1.writeln(' );');

    file1.writeln();

    file1.writeln(strlang + '_settingstext: isettingsaty =');

    file1.writeln(' (');
    for x := 0 to length(default_settingstext) - 1 do
    begin
      dosearch(default_settingstext, x);

      if hasfound then
      else
        astrt := default_settingstext[x];
      if trim(astrt) = '' then
        astrt := default_settingstext[x];

      astrt := utf8StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := utf8StringReplace(astrt, #039, '‘', [rfReplaceAll]);

      if (x < length(default_settingstext) - 1) and
        (length(default_settingstext) > 1) then
        file1.writeln('  ' + #039 + astrt + #039 + #044 + '   {' + default_settingstext[x] + '}')
      else
        file1.writeln('  ' + #039 + astrt + #039 + '   {' + default_settingstext[x] + '}');
    end;

    file1.writeln(' );');

    file1.writeln();

    file1.writeln(strlang + '_projectoptionstext: projectoptionsaty =');

    file1.writeln(' (');
    for x := 0 to length(default_projectoptionstext) - 1 do
    begin
      dosearch(default_projectoptionstext, x);

      if hasfound then
      else
        astrt := default_projectoptionstext[x];
      if trim(astrt) = '' then
        astrt := default_projectoptionstext[x];

      astrt := utf8StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := utf8StringReplace(astrt, #039, '‘', [rfReplaceAll]);

      if (x < length(default_projectoptionstext) - 1) and
        (length(default_projectoptionstext) > 1) then
        file1.writeln('  ' + #039 + astrt + #039 + #044 + '   {' + default_projectoptionstext[x] + '}')
      else
        file1.writeln('  ' + #039 + astrt + #039 + '   {' + default_projectoptionstext[x] + '}');
    end;

    file1.writeln(' );');

    file1.writeln();

    file1.writeln(strlang + '_stockcaption: stockcaptionaty =');

    file1.writeln('(');
    for x := 0 to length(default_stockcaption) - 1 do
    begin
      dosearch(default_stockcaption, x);

      if hasfound then
      else
        astrt := default_stockcaption[x];
      if trim(astrt) = '' then
        astrt := default_stockcaption[x];

      astrt := utf8StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := utf8StringReplace(astrt, #039, '‘', [rfReplaceAll]);

      if (x < length(default_stockcaption) - 1) and
        (length(default_stockcaption) > 1) then
        file1.writeln('  ' + #039 + astrt + #039 + #044 + '   {' + default_stockcaption[x] + '}')
      else
        file1.writeln('  ' + #039 + astrt + #039 + '   {' + default_stockcaption[x] + '}');
    end;

    file1.writeln(' );');

    file1.writeln();

    file1.writeln(strlang + '_langnamestext: array[0..' + IntToStr(length(default_langnamestext) - 1) + '] of msestring =');

    file1.writeln('(');
    for x := 0 to length(default_langnamestext) - 1 do
    begin
      dosearch(default_langnamestext, x);

      if hasfound then
      else
        astrt := default_langnamestext[x];
      if trim(astrt) = '' then
        astrt := default_langnamestext[x];

      astrt := utf8StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := utf8StringReplace(astrt, #039, '‘', [rfReplaceAll]);

      if (x < length(default_langnamestext) - 1) and
        (length(default_langnamestext) > 1) then
        file1.writeln('  ' + #039 + astrt + #039 + #044 + '   {' + default_langnamestext[x] + '}')
      else
        file1.writeln('  ' + #039 + astrt + #039 + '   {' + default_langnamestext[x] + '}');
    end;

    file1.writeln(' );');

    file1.writeln();

    file1.writeln(strlang + '_extendedtext: extendedaty =');

    file1.writeln('(');
    for x := 0 to length(default_extendedtext) - 1 do
    begin
      dosearch(default_extendedtext, x);

      if hasfound then
      else
        astrt := default_extendedtext[x];
      if trim(astrt) = '' then
        astrt := default_extendedtext[x];

      astrt := utf8StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := utf8StringReplace(astrt, #039, '‘', [rfReplaceAll]);

      if (x < length(default_extendedtext) - 1) and
        (length(default_extendedtext) > 1) then
        file1.writeln('  ' + #039 + astrt + #039 + #044 + '   {' + default_extendedtext[x] + '}')
      else
        file1.writeln('  ' + #039 + astrt + #039 + '   {' + default_extendedtext[x] + '}');
    end;

    file1.writeln(' );');

    file1.writeln();

    file1.writeln('function delete_n_selected_rows(const params: array of const): msestring;');

    file1.writeln('begin');
    file1.writeln('  with params[0] do');
    file1.writeln('    if vinteger = 1 then');
    file1.writeln('      Result := ' + strlang + '_extendedtext[ex_del_row_selected]');
    file1.writeln('    else');
    file1.writeln('      Result := StringReplace(' + strlang + '_extendedtext[ex_del_rows_selected], #37#115, inttostrmse(vinteger), [rfReplaceAll]);');

    file1.writeln('end;');

    file1.writeln();

    file1.writeln('const');
    file1.writeln(strlang + '_textgenerator: defaultgeneratortextty = (');
    file1.writeln(' {$ifdef FPC} @{$endif}delete_n_selected_rows);');

    file1.writeln();

    file1.writeln('initialization');

    file1.writeln();

    file1.writeln('registerlangconsts' + #040 + 'langnames[la_' + strlang + ']' + #044 +
      ' @' + strlang + '_langnamestext' + #044 +
      ' @' + strlang + '_extendedtext' + #044 +
      ' @' + strlang + '_mainformtext' + #044 +
      ' @' + strlang + '_sourceformtext' + #044 + lineending + '                  ' +
      ' @' + strlang + '_projectoptionscontext' + #044 +
      ' @' + strlang + '_actionsmoduletext' + #044 +
      ' @' + strlang + '_settingstext' + #044 +
      ' @' + strlang + '_projectoptionstext' + #044 + lineending + '                  ' +
      ' @' + strlang + '_stockcaption' + #044 +
      ' @' + strlang + '_modalresulttext' + #044 +
      ' @' + strlang + '_modalresulttextnoshortcut' + #044 +
      ' @' + strlang + '_textgenerator);');

    file1.writeln();
    file1.writeln('end.');
    file1.writeln();

    file1.Free;

  end;
end;

procedure theaderfo.oncreateform(const Sender: TObject);
begin
  outputdir.Value := ExtractFilePath(ParamStr(0)) + directoryseparator + 'output' + directoryseparator;
end;

procedure theaderfo.ontime(const Sender: TObject);
begin
  paneldone.Visible := False;
end;

end.

