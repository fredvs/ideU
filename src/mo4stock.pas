unit mo4stock;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  msestream,
  msetypes,
  SysUtils;

CONST
  ModalresultArea =           1;
  ModalresultnoShortcutArea = 1;
  StockcaptionArea =          2;
  ExtendedArea =              3;
 
VAR
  realizeApplicationLanguages: PROCEDURE;
 
procedure createnewlangmo (alang: msestring);
procedure findmofiles ();

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
  mseconsts,
  captionideu;

TYPE
  Localisator = ARRAY OF msestringarty;

const
  langext = '.mo';  // '.po';

var
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
  
  str1 := expandprmacros('${LANGDIR}') + directoryseparator;

  // List the files
  FindFirst(str1 + '*.mo', Attribute, SearchResult);
  while (i = 0) do
  begin
    SetLength(ListOfFiles, Length(ListOfFiles) + 1);     // Increase the list
    ListOfFiles[High(ListOfFiles)] := SearchResult.Name; // Add it at the end of the list
    i := FindNext(SearchResult);
  end;
  FindClose(SearchResult);

  setlength(lang_langnames, 1);
  lang_langnames[0] :=  'English [en]';
   
   str2 := expandprmacros('${LANGDIR}') + directoryseparator;

  for i := Low(ListOfFiles) to High(ListOfFiles) do
    if system.pos('empty', ListOfFiles[i]) = 0 then
    begin
       setlength(lang_langnames, length(lang_langnames) + 1);
       str1 := ListOfFiles[i];
       MOfile:= TMOfile.Create (str2+str1);
       str1 := MOfile.Translate('English [en]');
       //writeln(str1);
       lang_langnames[length(lang_langnames) - 1] := trim(str1);
       MOfile.Destroy;
    end;
end;

procedure translate_stock (var lang_stocktext, default_stocktext: msestringarty;
                           MOfile: TMOfile);
var
  x: integer;
  astrt: mseString;
begin
    setlength (lang_stocktext, length(default_stocktext));

    for x:= 0 to length (default_stocktext) - 1 do
    begin
      astrt:= MOfile.translate (default_stocktext [x]);
      astrt:= StringReplace (astrt, ',',  '‚', [rfReplaceAll]);
      astrt:= StringReplace (astrt, #039, '‘', [rfReplaceAll]);
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
  str1, str2: msestring;
  lang_tmp: array of msestring;
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
    //lang_langnames:=             LocalisationActive [LangnameArea];

    findmofiles();
    
{           
    setlength(lang_langnames, length(lang_langnamestmp));
 
  for x := 0 to high(lang_langnames) do
    begin
     str2 := trim(copy(lang_langnamestmp[x], system.pos('[',lang_langnamestmp[x]), 10));
     lang_langnames[x] := '';
     for x2 := 0 to high(en_langnamestext) do
        begin
           if trim(copy(en_langnamestext[x2], system.pos('[',en_langnamestext[x2]), 10)) = str2 then
             lang_langnames[x] := en_langnamestext[x2];
         end;
     if lang_langnames[x] = '' then lang_langnames[x] := 'Language ' + str2;
    end;
}

  end
  else if fileexists(str1) then
  begin
  
    MOfile:= TMOfile.Create (str1);
    FOR x:= 0 TO pred (Length (LocalisationReference)) DO
      translate_stock (LocalisationActive [x], LocalisationReference{Default} [x], MOfile);

    MOfile.Destroy;
  
    findmofiles();
      
   end;
  lang_modalresult:=           LocalisationActive [0];
  lang_modalresultnoshortcut:= LocalisationActive [ModalresultnoShortcutArea];
  lang_stockcaption:=          LocalisationActive [StockcaptionArea];
  lang_extended:=              LocalisationActive [ExtendedArea];
  
  IF assigned (realizeApplicationLanguages) THEN 
  realizeApplicationLanguages;
end;

initialization
  Appname:= 'ideu_';
  
  LocalisationReference:= Localisator.Create (en_modalresulttext, en_modalresulttextnoshortcut,
                                              en_stockcaption, en_extendedtext);
  LocalisationActive:=    Localisator.Create (en_modalresulttext, en_modalresulttextnoshortcut,
                                              en_stockcaption, en_extendedtext);
end.
