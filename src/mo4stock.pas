unit mo4stock;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  msetypes,
  SysUtils,
  LazUTF8;

CONST
  ModalresultArea =           1;
  ModalresultnoShortcutArea = 1;
  StockcaptionArea =          2;
  ExtendedArea =              3;
  LangnameArea =              4;

VAR
  realizeApplicationLanguages: PROCEDURE;
  isinit : boolean = false;


procedure createnewlangmo (alang: msestring);
procedure findpofiles ();

FUNCTION addApplicationStrings (ApplicationStrings: msestringarty; VAR ApplicationDefaults: msestringarty): integer;
FUNCTION addApplicationStrings (ApplicationStrings: msestringarty; VAR Index: integer): msestringarty;
FUNCTION addApplicationStrings (ApplicationStrings: msestringarty): integer;
FUNCTION getApplicationString (Area, Index: integer): msestring;
FUNCTION getApplicationLanguage (Index: integer): msestringarty;

implementation

uses
  gettext,
  msestockobjects,
  projectoptionsform,
  mseconsts;

TYPE
  Localisator = ARRAY OF msestringarty;

const
  langext = '.mo';  // '.po';

var
  //LangDir: string = 'lang';
  Appname: string;
  Lang_langnamestmp: msestringarty;
  LocalisationReference,
  LocalisationActive: Localisator;


FUNCTION addApplicationStrings (ApplicationStrings: msestringarty; VAR ApplicationDefaults: msestringarty): integer;
 BEGIN
   Result:= addApplicationStrings (ApplicationStrings);
   ApplicationDefaults:= LocalisationActive [Result];
 END;

FUNCTION addApplicationStrings (ApplicationStrings: msestringarty; VAR Index: integer): msestringarty;
 BEGIN
   Index:=  addApplicationStrings (ApplicationStrings);
   Result:= LocalisationActive [Index];
 END;

FUNCTION addApplicationStrings (ApplicationStrings: msestringarty): integer;
 BEGIN
   Result:= Length (LocalisationReference);
   SetLength (LocalisationReference, succ (Result));
   SetLength (LocalisationActive,    succ (Result));

   LocalisationReference [Result]:= ApplicationStrings;
   SetLength (LocalisationActive [Result], 0);
 END;

FUNCTION getApplicationString (Area, Index: integer): msestring;
 BEGIN
   Result:= LocalisationActive [Area][Index];
 END;

FUNCTION getApplicationLanguage (Index: integer): msestringarty;
 BEGIN
   Result:= LocalisationActive [Index];
 END;


procedure findpofiles ();
var
  ListOfFiles: array of string;
  SearchResult: TSearchRec;
  Attribute: word;
  i: integer = 0;
  str1: string;
begin
  Attribute := faReadOnly or faArchive;

  SetLength(ListOfFiles, 0);

  //str1 := LangDir + directoryseparator;
  
  str1 := expandprmacros('${LANGDIR}') + directoryseparator;

  // List the files
  FindFirst(str1 + '*.po', Attribute, SearchResult);
  while (i = 0) do
  begin
    SetLength(ListOfFiles, Length(ListOfFiles) + 1);     // Increase the list
    ListOfFiles[High(ListOfFiles)] := SearchResult.Name; // Add it at the end of the list
    i := FindNext(SearchResult);
  end;
  FindClose(SearchResult);

  setlength(lang_langnamestmp, 1);
  lang_langnamestmp[0] := '[en]';

  for i := Low(ListOfFiles) to High(ListOfFiles) do
    if system.pos('empty', ListOfFiles[i]) = 0 then
    begin
      setlength(lang_langnamestmp, length(lang_langnamestmp) + 1);
      str1 := ListOfFiles[i];
      str1 := utf8StringReplace(str1, appname, '', [rfReplaceAll]);
      str1 := utf8StringReplace(str1, langext, '', [rfReplaceAll]);
      lang_langnamestmp[length(lang_langnamestmp) - 1] := '[' + trim(str1) + ']';
      //writeln(lang_langnamestmp[length(lang_langnamestmp) - 1]);
    end;
end;

procedure translate_stock (var lang_stocktext, default_stocktext: msestringarty;
                           MOfile: TMOfile);
var
  x: integer;
  astrt: utf8String;
begin
    setlength (lang_stocktext, length (default_stocktext));

    for x:= 0 to length (default_stocktext) - 1 do
    begin
      astrt:= MOfile.translate (default_stocktext [x]);
      astrt:= utf8StringReplace (astrt, ',',  '‚', [rfReplaceAll]);
      astrt:= utf8StringReplace (astrt, #039, '‘', [rfReplaceAll]);
      lang_stocktext [x]:= astrt;
    end;
end;

PROCEDURE buildlangtext (VAR LocalisationArea: Localisator);
 VAR
   i, x: integer;
 BEGIN
    FOR x:= 0 TO pred (Length (LocalisationReference)) DO BEGIN
      SetLength (LocalisationArea [x], length (LocalisationReference [x]));
      FOR i:= Low (LocalisationReference [x]) to High (LocalisationReference [x]) DO
        LocalisationArea [x][i]:= LocalisationReference [x][i];
    END;
 END;

procedure createnewlangmo (alang: msestring);
var
  x, x2, x3: integer;
  str1: msestring;
  str2: utf8String;
  MOfile: TMOfile;

begin
//  str1 := ExtractFilePath(ParamStr(0)) + 'lang' + directoryseparator + appname + alang + langext;
  str1 := expandprmacros('${LANGDIR}')  + appname + alang + langext;
  
 //  writeln(str1);

  if (not fileexists(str1)) or (lowercase(alang) = 'en') or (trim(alang) = '') then
  begin
    buildlangtext (LocalisationActive);

//    SetLength (LocalisationActive [LangnameArea], x);
//    FOR x:= 0 to pred (x) DO
//      LocalisationActive [LangnameArea][x]:= en_langnamestext [x];

    lang_modalresult:=           LocalisationActive [0];
    lang_modalresultnoshortcut:= LocalisationActive [ModalresultnoShortcutArea];
    lang_stockcaption:=          LocalisationActive [StockcaptionArea];
    lang_extended:=              LocalisationActive [ExtendedArea];
    lang_langnames:=             LocalisationActive [LangnameArea];

    findpofiles();

    if length(lang_langnamestmp) > length(en_langnamestext) then
      setlength(lang_langnames, length(lang_langnamestmp))
    else
      setlength(lang_langnames, length(en_langnamestext));

    //    writeln('length(en_langnamestext) ' + inttostr(length(en_langnamestext)));
    //       writeln('lang_langnames[x] ' + inttostr(length(lang_langnames)));

    for x := 0 to length(en_langnamestext) - 1 do
      lang_langnames [x] := en_langnamestext [x];

    if length(lang_langnames) > length(en_langnamestext) then
    begin
      for x := 0 to high(lang_langnames) do
      begin
        str2   := trim(copy(lang_langnames[x], system.pos('[', lang_langnames[x]), 10));
        for x2 := 0 to high(lang_langnamestmp) do
          if trim(lang_langnamestmp[x2]) = str2 then
            lang_langnamestmp[x2] := '';
      end;
{
      x2    := length(en_langnamestext);
      for x := 0 to high(lang_langnamestmp) do
        if trim(lang_langnamestmp[x]) <> '' then
        begin
          lang_langnames[x2] := 'Language ' + trim(lang_langnamestmp[x]);
          Inc(x2);
        end;
}        
        
    end;
  end
  else if fileexists(str1) then
  begin
  
    MOfile:= TMOfile.Create (str1);
    FOR x:= 0 TO pred (Length (LocalisationReference)) DO
      translate_stock (LocalisationActive [x], LocalisationReference{Default} [x], MOfile);

    MOfile.Destroy;
  
    findpofiles();
   
    if length(lang_langnamestmp) > length(lang_langnames) then
    begin
      x3     := length(lang_langnames);
      setlength(lang_langnames, length(lang_langnamestmp));
      for x  := 0 to high(lang_langnames) do
      begin
        str2 := trim(copy(lang_langnames[x], system.pos('[', lang_langnames[x]), 10));
        for x2 := 0 to high(lang_langnamestmp) do
          if trim(lang_langnamestmp[x2]) = str2 then
            lang_langnamestmp[x2] := '';
      end;
      
     
{
      for x := 0 to high(lang_langnamestmp) do
        if trim(lang_langnamestmp[x]) <> '' then
        begin
          lang_langnames[x3] := 'Language ' + trim(lang_langnamestmp[x]);
          Inc(x3);
        end;
 }      
      
        
    end;
  end;
  lang_modalresult:=           LocalisationActive [0];
  lang_modalresultnoshortcut:= LocalisationActive [ModalresultnoShortcutArea];
  lang_stockcaption:=          LocalisationActive [StockcaptionArea];
  lang_extended:=              LocalisationActive [ExtendedArea];
  lang_langnames:=             LocalisationActive [LangnameArea];
  IF assigned (realizeApplicationLanguages) THEN 
  realizeApplicationLanguages;
end;

initialization
  Appname:= 'ideu_';
  
  LocalisationReference:= Localisator.Create (en_modalresulttext, en_modalresulttextnoshortcut,
                                              en_stockcaption, en_extendedtext, en_langnamestext);
  LocalisationActive:=    Localisator.Create (en_modalresulttext, en_modalresulttextnoshortcut,
                                              en_stockcaption, en_extendedtext, en_langnamestext);
end.
