unit po2const;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  msetypes,
  msesys,
  mseguiintf,
  SysUtils,
  LazUTF8,
  msefileutils,
  msegraphics,
  mseglob,
  msestream,
  msegui,
  msegraphutils,
  mseclasses,
  mclasses,
  msestrings,
  msedatamodules,
  mseguiglob;

var
  lang_stockcaption, lang_modalresult, lang_modalresultnoshortcut, lang_mainform, lang_settings, lang_actionsmodule, lang_projectoptionscon, lang_projectoptions, lang_sourceform, lang_extended, lang_langnames: array of msestring;

procedure createnewlang(alang: msestring);
procedure dosearch(thearray: array of msestring; theindex: integer);

implementation

uses
  msestockobjects,
  mseconsts_ide;

var
  constvaluearray: array of msestring;
  astro, astrt, acomp: utf8String;
  hasfound: Boolean = False;
  empty: Boolean = False;


///////////////

procedure dosearch(thearray: array of msestring; theindex: integer);
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
    // writeln('---astrt:' + astrt);

    Inc(y);
  end;
end;

procedure createnewlang(alang: msestring);
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
  defaultresult, default_resulttext, default_modalresulttext, default_modalresulttextnoshortcut, default_mainformtext, default_actionsmoduletext, default_projectoptionscontext, default_settingstext,
  default_projectoptionstext, default_sourceformtext, default_stockcaption, default_langnamestext, default_extendedtext: array of msestring;
begin
  strlang := '';

  str1 := ExtractFilePath(ParamStr(0)) + 'lang' + directoryseparator + 'mseconsts_ide_' + alang + '.po';

  // writeln(str1); 

  if (not fileexists(str1)) or (lowercase(alang) = 'en') or (trim(alang) = '') then
  begin

    // writeln(' not exist' ); 

    setlength(lang_modalresult, length(en_modalresulttext));
    for imodalresultty := Low(modalresultty) to High(modalresultty) do
      lang_modalresult[Ord(imodalresultty)] := en_modalresulttext[(imodalresultty)];

    setlength(lang_modalresultnoshortcut, length(en_modalresulttextnoshortcut));
    for imodalresultty := Low(modalresultty) to High(modalresultty) do
      lang_modalresultnoshortcut[Ord(imodalresultty)] :=
        en_modalresulttextnoshortcut[(imodalresultty)];

    setlength(lang_mainform, length(en_mainformtext));
    for imainformty := Low(mainformty) to High(mainformty) do
      lang_mainform[Ord(imainformty)] :=
        en_mainformtext[(imainformty)];

    setlength(lang_actionsmodule, length(en_actionsmoduletext));
    for iactionsmodulety := Low(actionsmodulety) to High(actionsmodulety) do
      lang_actionsmodule[Ord(iactionsmodulety)] :=
        en_actionsmoduletext[(iactionsmodulety)];

    setlength(lang_projectoptionscon, length(en_projectoptionscontext));
    for iprojectoptionsconty := Low(projectoptionsconty) to High(projectoptionsconty) do
      lang_projectoptionscon[Ord(iprojectoptionsconty)] :=
        en_projectoptionscontext[(iprojectoptionsconty)];

    setlength(lang_settings, length(en_settingstext));
    for iisettingsty := Low(isettingsty) to High(isettingsty) do
      lang_settings[Ord(iisettingsty)] :=
        en_settingstext[(iisettingsty)];

    setlength(lang_projectoptions, length(en_projectoptionstext));
    for iprojectoptionsty := Low(projectoptionsty) to High(projectoptionsty) do
      lang_projectoptions[Ord(iprojectoptionsty)] :=
        en_projectoptionstext[(iprojectoptionsty)];

    setlength(lang_sourceform, length(en_sourceformtext));
    for isourceformty := Low(sourceformty) to High(sourceformty) do
      lang_sourceform[Ord(isourceformty)] :=
        en_sourceformtext[(isourceformty)];

    setlength(lang_stockcaption, length(en_stockcaption));
    for istockcaptionty := Low(stockcaptionty) to High(stockcaptionty) do
      lang_stockcaption[Ord(istockcaptionty)] :=
        en_stockcaption[(istockcaptionty)];

    setlength(lang_langnames, length(en_langnamestext));
    for x := 0 to length(en_langnamestext) - 1 do
      lang_langnames[x] := en_langnamestext[x];

    setlength(lang_extended, length(en_extendedtext));
    for iextendedty := Low(extendedty) to High(extendedty) do
      lang_extended[Ord(iextendedty)] :=
        en_extendedtext[(iextendedty)];

  end
  else if fileexists(str1) then
  begin

    // writeln(str1 + ' exist' ); 

    file1 := ttextdatastream.Create(str1, fm_read);

    file1.encoding := ce_utf8;

    setlength(constvaluearray, 0);

    file1.readln(str1);

    str3 := '';
    str2 := '';
    str4 := '';

    // writeln(' 1' ); 

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
    // writeln(' 2' ); 
    setlength(constvaluearray, length(constvaluearray) + 1);
    str2 := str4 + utf8String(';') + str2 + utf8String(';') + str3;
    str2 := utf8StringReplace(str2, '\n', '', [rfReplaceAll]);
    str2 := utf8StringReplace(str2, '\', '', [rfReplaceAll]);
    constvaluearray[length(constvaluearray) - 1] := str2;
    // writeln(str2);

    file1.Free;

    //   writeln(' 3' ); 

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

    // writeln(' 4' ); 

    setlength(lang_modalresult, length(default_modalresulttext));

    for x := 0 to length(default_modalresulttext) - 1 do
    begin
      // writeln('length(default_modalresulttext) ' +
      // inttostr(length(default_modalresulttext))); 

      dosearch(default_modalresulttext, x);
      // writeln(' 4.2' ); 
      if hasfound then
      else
        astrt := default_modalresulttext[x];
      if trim(astrt) = '' then
        astrt := default_modalresulttext[x];

      astrt := utf8StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := utf8StringReplace(astrt, #039, '‘', [rfReplaceAll]);

      //   writeln('length(lang_modalresult) ' +
      // inttostr(length(lang_modalresult))); 


      lang_modalresult[x] := astrt;

    end;

    //writeln(' 5' );

    setlength(lang_modalresultnoshortcut, length(default_modalresulttextnoshortcut));

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

      lang_modalresultnoshortcut[x] := astrt;

    end;

    setlength(lang_projectoptionscon, length(default_projectoptionscontext));

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

      lang_projectoptionscon[x] := astrt;

    end;

    setlength(lang_actionsmodule, length(default_actionsmoduletext));


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

      lang_actionsmodule[x] := astrt;

    end;

    setlength(lang_mainform, length(default_mainformtext));

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

      lang_mainform[x] := astrt;
    end;

    setlength(lang_sourceform, length(default_sourceformtext));

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

      lang_sourceform[x] := astrt;

    end;

    setlength(lang_settings, length(default_settingstext));


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

      lang_settings[x] := astrt;

    end;

    setlength(lang_projectoptions, length(default_projectoptionstext));

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

      lang_projectoptions[x] := astrt;

    end;

    setlength(lang_stockcaption, length(default_stockcaption));

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

      lang_stockcaption[x] := astrt;

    end;

    setlength(lang_extended, length(default_extendedtext));

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

      lang_extended[x] := astrt;

    end;

    setlength(lang_langnames, length(default_langnamestext));

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

      lang_langnames[x] := astrt;

    end;

  end;

end;

end.

