unit mo4stock;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

uses
  msetypes,
  SysUtils;

const
  ModalresultArea = 0;
  ModalresultnoShortcutArea = 1;
  StockcaptionArea = 2;
  ExtendedArea = 3;
  LangFlag     = '*';

var
  customsetLangFilePattern: function: string;
  realizeApplicationLanguages: procedure = nil;
  LangDir: string = 'lang';
  Appname: string;

procedure createnewlang(alang: msestring);
function findmofiles: msestringarty;
 // procedure createnewlangmo (alang: msestring);
 // procedure findmofiles ();
 // FUNCTION findpofiles (LinuxSystem: boolean = false): msestringarty;

 // FUNCTION addApplicationStrings (ApplicationStrings: msestringarty; VAR ApplicationDefaults: msestringarty): integer;
 // FUNCTION addApplicationStrings (ApplicationStrings: msestringarty; VAR Area: integer): msestringarty;
 // FUNCTION addApplicationStrings (ApplicationStrings: msestringarty): integer;
function addApplicationStrings(ApplicationStrings: array of msestring; var ApplicationDefaults: msestringarty): integer;
function addApplicationStrings(ApplicationStrings: array of msestring; var Area: integer): msestringarty;
function addApplicationStrings(ApplicationStrings: array of msestring): integer;
function getApplicationString(Area, Index: integer): msestring;
function getApplicationLanguage(Area: integer): msestringarty;
function ApplicationStringCount(Area: integer): integer;

implementation

uses
  Classes,
  StrUtils,
  gettext,
  mseconsts,
  msestockobjects;

type
  Localisator = array of msestringarty;

const
  LangExt   = '.mo';
  BaseLang  = 'English [en]';
  LinuxFlag = '/LC_MESSAGES/';

var
  LocalisationReference, LocalisationActive: Localisator;


// FUNCTION addApplicationStrings (ApplicationStrings: msestringarty; VAR ApplicationDefaults: msestringarty): integer;
function addApplicationStrings(ApplicationStrings: array of msestring; var ApplicationDefaults: msestringarty): integer;
begin
  Result := addApplicationStrings(ApplicationStrings);
  ApplicationDefaults := LocalisationActive[Result];
end;

// FUNCTION addApplicationStrings (ApplicationStrings: msestringarty; VAR Area: integer): msestringarty;
function addApplicationStrings(ApplicationStrings: array of msestring; var Area: integer): msestringarty;
begin
  Area   := addApplicationStrings(ApplicationStrings);
  Result := LocalisationActive[Area];
end;

// FUNCTION addApplicationStrings (ApplicationStrings: msestringarty): integer;
function addApplicationStrings(ApplicationStrings: array of msestring): integer;
var
  i: integer;
begin
  Result := Length(LocalisationReference);
  SetLength(LocalisationReference, succ(Result));
  SetLength(LocalisationActive, succ(Result));

  SetLength(LocalisationReference[Result], Length(ApplicationStrings));
  for i := 0 to High(ApplicationStrings) do
    LocalisationReference[Result][i] := ApplicationStrings[i];

  SetLength(LocalisationActive[Result], 0);
end;

function getApplicationString(Area, Index: integer): msestring;
begin
  Result := LocalisationActive[Area][Index];
end;

function getApplicationLanguage(Area: integer): msestringarty;
begin
  Result := LocalisationActive[Area];
end;

function ApplicationStringCount(Area: integer): integer;
begin
  Result := Length(LocalisationActive[Area]);
end;


function findMOfiles: msestringarty;
var
  i, l: integer;
  ListOfFiles: TStringList;
  Langname: string;
  MOfile: TMOfile;

  function findMOfilesLangdir: TStringList;
  var
    SearchResult: TSearchRec;
    Attribute: word;
  begin
    Attribute := faReadOnly or faArchive;
    Result    := TStringList.Create;
    i         := 0;

    // List the files, LangDir:= expandprmacros('${LANGDIR}');
    FindFirst(LangDir + Appname + LangFlag + LangExt, Attribute, SearchResult);
    while i = 0 do
    begin
      Result.Add(SearchResult.Name);       // Add it to the the list
      i := FindNext(SearchResult);
    end;
    FindClose(SearchResult);
  end;

{$ifdef unix}
 FUNCTION findMOfilesLinuxSys: TStringList;  // !!!!!!!!!!!!!!!!!!!!!
  VAR
    SearchResult: TSearchRec;
    Attribute:    word;
  BEGIN
    Attribute:= faReadOnly OR faArchive OR faDirectory;
    Result:= TStringList.Create; i:= 0;

    // List the files, Linux: LangDir = /usr/share/locale/<language>/LC_MESSAGES
    FindFirst (LangDir + LangFlag{+ Appname+ LangExt}, Attribute, SearchResult);
    WHILE i = 0 DO BEGIN
      IF (SearchResult.Name <> '.') AND
         DirectoryExists (LangDir+ SearchResult.Name) AND
         FileExists (LangDir+ SearchResult.Name+ Appname+ LangExt)
      THEN
      Result.Add (SearchResult.Name+ Appname+ LangExt);       // Add it to the list
      i:= FindNext (SearchResult);
    END;
    FindClose (SearchResult);
  END;
{$endif}
begin
{$ifdef unix}
   IF System.Pos (LinuxFlag, LangDir+ Appname) <> 0  // Linux System
     THEN ListOfFiles:= findMOfilesLinuxSys
     ELSE
     {$endif}
  ListOfFiles := findMOfilesLangdir;

  if ListOfFiles.Count = 0 then
  begin                      // NO files?
    SetLength(Result, 1);
    Result[0] := BaseLang;   // 'English'
    Exit;
  end;
  ListOfFiles.Sort;
  SetLength(Result, ListOfFiles.Count);
  Result[0] := BaseLang;  // 'English'
  l         := 0;
  for i := 0 to pred(ListOfFiles.Count) do
  begin
    Langname := ListOfFiles[i];

    if System.Pos('empty', Langname) = 0 then
    begin
      MOfile   := TMOfile.Create(LangDir + Langname);
      Langname := MOfile.Translate(BaseLang);
      Inc(l);
      //writeln (Lang);
      MOfile.Destroy;
      if l >= Length(Result) then
        setLength(Result, succ(Length(Result)));  // maybe no 'empty' lang file?
      Result[l] := Trim(Langname);
    end;
  end;
end;

(*
procedure findmofiles ();
var
  ListOfFiles: array of string;
  MOfile: TMOfile;
  SearchResult: TSearchRec;
  file1: ttextdatastream;
  Attribute: word;
  i: integer = 0;
  str1, str2, str3: msestring;
begin
  Attribute := faReadOnly or faArchive;

  SetLength(ListOfFiles, 0);

  //str1 := LangDir + directoryseparator;

//  str1 := expandprmacros('${LANGDIR}') + directoryseparator;

  // List the files
  FindFirst(LangDir{str1} + '*'+ LangExt, Attribute, SearchResult);
   WHILE i = 0 DO BEGIN
     SetLength (ListOfFiles, succ (Length (ListOfFiles)));      // Increase the list
     ListOfFiles [High (ListOfFiles)]:= SearchResult.Name;      // Add it at the end of the list
     i:= FindNext (SearchResult);
   END;
  FindClose(SearchResult);

  setlength(lang_langnames, 1);
  lang_langnames[0] :=  BaseLang;

//   str2 := expandprmacros('${LANGDIR}') + directoryseparator;

  for i := Low(ListOfFiles) to High(ListOfFiles) do
    if system.pos('empty', ListOfFiles[i]) = 0 then
    begin
       setlength(lang_langnames, length(lang_langnames) + 1);
       str1 := ListOfFiles[i];
       MOfile:= TMOfile.Create (LangDir{str2}+str1);
       str1 := MOfile.Translate (BaseLang);
       //writeln(str1);
       lang_langnames[length(lang_langnames) - 1] := trim(str1);
       MOfile.Destroy;
    end;
end;
*)

procedure translate_stock(var lang_stocktext, default_stocktext: msestringarty; MOfile: TMOfile);
var
  x: integer;
  astrt: mseString;
begin
  SetLength(lang_stocktext, Length(default_stocktext));

  for x := 0 to High(default_stocktext) do
  begin
    astrt   := MOfile.translate(default_stocktext[x]);
{$ifndef no_remove_hot_chars}
    // if no translation, but original contains '&', try w/ '&' characters removed
    if (astrt = '') and (Pos('&', default_stocktext[x]) <> 0) then
      astrt := MOfile.translate(StringReplace(default_stocktext[x], '&', '', [rfReplaceAll]));

    // if no translation still, try w/ default upper cased
    if (astrt = '') and (Pos('&', default_stocktext[x]) <> 0) then
      astrt := MOfile.translate(uppercase(StringReplace(default_stocktext[x], '&', '', [rfReplaceAll])));

    // if translated but original doesn't contain '&', remove from translation too
    if (astrt <> '') and (Pos('&', default_stocktext[x]) = 0) then
      astrt := {Unicode}StringReplace(astrt, '&', '', [rfReplaceAll]);
{$endif}
    if astrt = '' then
      astrt := default_stocktext[x]
    else
    begin
      astrt := {Unicode}StringReplace(astrt, ',', '‚', [rfReplaceAll]);
      astrt := {Unicode}StringReplace(astrt, #039, '‘', [rfReplaceAll]);
    end;
    lang_stocktext[x] := astrt;
  end;
end;

procedure buildlangtext(var LocalisationArea: Localisator);
var
  i, x: integer;
begin
  for x := 0 to pred(Length(LocalisationReference)) do
  begin
    SetLength(LocalisationArea[x], length(LocalisationReference[x]));
    for i := Low(LocalisationReference[x]) to High(LocalisationReference[x]) do
      LocalisationArea[x][i] := LocalisationReference[x][i];
  end;
end;

procedure createnewlang(alang: msestring);
var
  x: integer;
  currentLangFile: msestring;
  MOfile: TMOfile;
begin
  // Patterns of language file names are:
  // - for "standard" location (below applications directory):
  //   LangDir = ExtractFilePath (ParamStr (0))+ LangDir+ directoryseparator+ Appname+ alang+ LangExt;
  // - for files residing in Linux' system locale repository:
  //   LangDir = "/usr/share/locale/"+ alang+ "/LC_MESSAGES"+ directoryseparator+ Appname+ LangExt;
  // Different formats handled through "variable replacement"
  // - Variable "LangPath"; Contains complete path of language file w/ place holders for variables,
  //                        "Standard":   <applcation dirextory>/$Appname_$Language.<LangExt>
  //                        Linux system: /usr/share/locale/$Language/LC_MESSAGES/$Appname.<LangExt>
  // - Variable "Appname";  Content like currently
  // - Variable "Language"; Contains current "alang"
  // Variables can be replaced by fpc's StrUtils function "StringReplace"
  // Pattern of "LangPath" can determine search function required,
  //   decided e.g. by occurrence of substring "LC_MESSAGES"
  if directoryexists(LangDir) then
  begin

    if Assigned(customsetLangFilePattern) then
      LangDir := customsetLangFilePattern();
    x         := System.Pos(LangFlag, LangDir);

    if x > 0 then
    begin
      Appname := Copy(LangDir, succ(x), Length(LangDir));
      System.Delete(LangDir, x, Length(LangDir));
      x       := High(LangDir);

      while (x > 0) and (LangDir[x] <> directoryseparator) do
        Dec(x);
      if x < High(LangDir) then
      begin
        Appname := Copy(LangDir, succ(x), Length(LangDir));
        System.Delete(LangDir, succ(x), Length(LangDir));
      end;
    end;
{$ifdef unix}
   IF System.Pos (LinuxFlag, LangDir+ Appname) <> 0  // Linux System
     THEN currentLangFile := LangDir+ alang+ Appname+ LangExt
     ELSE currentLangFile := LangDir+ Appname+ alang+ LangExt;
{$endif}

    //  writeln(currentLangFile);

    if (Trim(alang) = '') or {(lowercase (alang) = BaseLang) OR} (not FileExists(currentLangFile)) then
      buildlangtext(LocalisationActive)
    else if FileExists(currentLangFile) then
    begin
      MOfile := TMOfile.Create(currentLangFile);

      for x := 0 to pred(Length(LocalisationReference)) do
        translate_stock(LocalisationActive[x], LocalisationReference[x], MOfile);

      MOfile.Destroy;
    end;
    lang_langnames := findmofiles;

    lang_modalresult := getApplicationLanguage(ModalresultArea);
    lang_modalresultnoshortcut := getApplicationLanguage(ModalresultnoShortcutArea);
    lang_stockcaption := getApplicationLanguage(StockcaptionArea);
    lang_extended := getApplicationLanguage(ExtendedArea);

    if Assigned(realizeApplicationLanguages) then
      realizeApplicationLanguages;

  end;
end;

initialization
  Appname := lowercase(ChangeFileExt(ExtractFileName(ParamStr(0)), '_'));
  LangDir := ExtractFilePath(ParamStr(0)) + LangDir + directoryseparator;

  LocalisationReference := Localisator.Create(en_modalresulttext, en_modalresulttextnoshortcut,
    en_stockcaption, en_extendedtext);
  LocalisationActive    := Localisator.Create(en_modalresulttext, en_modalresulttextnoshortcut,
    en_stockcaption, en_extendedtext);
end.

