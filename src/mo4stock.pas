UNIT mo4stock;

// Sieghard 2022

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

INTERFACE

USES
  msetypes,
  SysUtils;

CONST
  ModalresultArea =           0;
  ModalresultnoShortcutArea = 1;
  StockcaptionArea =          2;
  ExtendedArea =              3;
  LangFlag =                '*';

VAR
  customsetLangFilePattern: FUNCTION: string;
  realizeApplicationLanguages: PROCEDURE;
  LangDir: string = 'lang';
  Appname: string;

PROCEDURE createnewlang (alang: msestring);
FUNCTION findmofiles: msestringarty;

FUNCTION addApplicationStrings (ApplicationStrings: msestringarty; VAR ApplicationDefaults: msestringarty): integer;
FUNCTION addApplicationStrings (ApplicationStrings: msestringarty; VAR Index: integer): msestringarty;
FUNCTION addApplicationStrings (ApplicationStrings: msestringarty): integer;
FUNCTION getApplicationString (Area, Index: integer): msestring;
FUNCTION getApplicationLanguage (Index: integer): msestringarty;
FUNCTION ApplicationStringCount (Area: integer): integer;

IMPLEMENTATION

USES
  Classes,
  StrUtils,
  gettext,
  mseconsts,
  main,
  msestockobjects;

TYPE
  Localisator = ARRAY OF msestringarty;
  Strar = array of string;

CONST
  LangExt =   '.mo';
  BaseLang =  'English [en]';
  LinuxFlag = '/LC_MESSAGES/';

VAR
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

FUNCTION ApplicationStringCount (Area: integer): integer;
 BEGIN
   Result:= Length (LocalisationActive [Area]);
 END;


FUNCTION findMOfiles: msestringarty;
 VAR
   i, l:         integer;
    {$ifdef unix}
   ListOfFiles:  TStringList;
    {$else}
   ListOfFiles: array of string;
     {$endif}
   Langname:     string;
   MOfile: TMOfile;

  FUNCTION findMOfilesLangdir: 
   {$ifdef unix} TStringList; {$else} strar;  {$endif}
  VAR
    SearchResult: TSearchRec;
    Attribute:    word;
  BEGIN
    Attribute:= faReadOnly OR faArchive;
     i:= 0;
    // List the files, LangDir:= expandprmacros('${LANGDIR}');
      
    {$ifdef unix}
      Result:= TStringList.Create;
  
     FindFirst (LangDir+ Appname+ LangFlag+ LangExt, Attribute, SearchResult);
      WHILE i = 0 DO BEGIN
      Result.Add (SearchResult.Name);       // Add it to the the list
      i:= FindNext (SearchResult);
    END;
   {$else} 
      LangDir := system.copy(LangDir,1,system.pos('\lang\ideu_',LangDir)) +
       '\lang\';
     //mainfo.caption := LangDir+  '*.mo' ;
     FindFirst (LangDir+  '*.mo' , Attribute, SearchResult);
      while (i = 0) do
     begin
     SetLength(ListOfFiles, Length(ListOfFiles) + 1);
    // Increase the list
     ListOfFiles[High(ListOfFiles)] := SearchResult.Name;
    // Add it at the of the list
     i := FindNext(SearchResult);
    end;
     result := ListOfFiles;
   //  mainfo.caption := 'Length(ListOfFiles ' + inttostr(Length(ListOfFiles));
    {$endif}
       
    FindClose (SearchResult);
  END;

{$ifdef Linux}
 FUNCTION findMOfilesLinuxSys: TStringList;  // !!!!!!!!!!!!!!!!!!!!!
  VAR
    SearchResult: TSearchRec;
    Attribute:    word;
  BEGIN
    Attribute:= faReadOnly OR faArchive OR faDirectory;
    Result:= TStringList.Create; i:= 0;

    // List the files, Linux: LangDir = /usr/share/locale/<language>/LC_MESSAGES
    FindFirst (LangDir+ LangFlag{+ Appname+ LangExt}, Attribute, SearchResult);
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

 BEGIN
{$ifdef Linux}
   IF System.Pos (LinuxFlag, LangDir+ Appname) <> 0  // Linux System
     THEN ListOfFiles:= findMOfilesLinuxSys
     ELSE
     {$endif} 
     
     ListOfFiles:= findMOfilesLangdir;

{$ifdef Linux}
   IF ListOfFiles.Count = 0 THEN BEGIN               // NO files?
     SetLength (Result, 1); Result [0]:= BaseLang;   // 'English'
     Exit;
   END;
   ListOfFiles.Sort;
   SetLength (Result, ListOfFiles.Count); Result [0]:= BaseLang;  // 'English'
   l:= 0;
   FOR i:= 0 TO pred (ListOfFiles.Count) DO BEGIN
     Langname:= ListOfFiles [i];
    // mainfo.caption := LangDir+ Langname ;

     IF System.Pos ('empty', Langname) = 0 THEN BEGIN
       MOfile:= TMOfile.Create (LangDir+ Langname);
       Langname:= MOfile.Translate (BaseLang); Inc (l);
       //writeln (Lang);
       MOfile.Destroy;
       IF l >= Length (Result)
         THEN setLength (Result, succ (Length (Result)));  // maybe no 'empty' lang file?
       Result [l]:= Trim (Langname);
     END;
   END;
   {$else}
   
   setlength(lang_langnames, 1);
   lang_langnames[0] :=  'English [en]';
 
  for i := 0 to High(ListOfFiles) do
    if system.pos('empty', ListOfFiles[i]) = 0 then
    begin
      setlength(lang_langnames, length(lang_langnames) + 1);
      Langname := ListOfFiles[i];
        MOfile:= TMOfile.Create (LangDir+ Langname);
       Langname:= MOfile.Translate (BaseLang);
       lang_langnames[length(lang_langnames) - 1] := Langname;
        //writeln (Lang);
       MOfile.Destroy;
    end;
    result := lang_langnames;
   
   {$endif}
   
 END;

PROCEDURE translate_stock (VAR lang_stocktext, default_stocktext: msestringarty;
                           MOfile: TMOfile);
VAR
  x: integer;
  astrt: mseString;
BEGIN
   SetLength (lang_stocktext, Length (default_stocktext));

   FOR x:= 0 TO High (default_stocktext) DO BEGIN
      astrt:= MOfile.translate (default_stocktext [x]);
      IF astrt <> '' THEN BEGIN
        astrt:= StringReplace (astrt, ',',  '‚', [rfReplaceAll]);
        astrt:= StringReplace (astrt, #039, '‘', [rfReplaceAll]);
        lang_stocktext [x]:= astrt;
      END
      ELSE lang_stocktext [x]:= default_stocktext [x];
   END;
END;

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

PROCEDURE createnewlang (alang: msestring);
 VAR
   x:               integer;
   currentLangFile, str1: msestring;
   MOfile:          TMOfile;
 BEGIN
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
   // - Variable "Language"; Conuains current "alang"
   // Variables can be replaced by fpc's StrUtils function "StringReplace"
   // Pattern of "LangPath" can determine search function required,
   //   decided e.g. by occurrence of substring "LC_MESSAGES"

 
// expandprmacros('${LANGDIR}') + 'ideu_' + alang + '.po';
 
 IF assigned (customsetLangFilePattern) THEN
 {$ifdef unix}
   LangDir:= customsetLangFilePattern ();
 {$else}
   begin
   LangDir:= customsetLangFilePattern ();
   LangDir:= StringReplace(LangDir, '*', '', [rfReplaceAll]);
   //LangDir:= LangDir + alang + '.mo';
   LangDir:= StringReplace(LangDir, '\\', '\', [rfReplaceAll]);
   //LangDir := system.copy(LangDir,1,system.pos('\lang\ideu_',LangDir)) +
    
   currentLangFile := LangDir + alang + '.mo';
   end;
 {$endif}

  {$ifdef unix}
   x:= System.Pos (LangFlag, LangDir);

   IF x > 0 THEN BEGIN
     Appname:= Copy (LangDir, succ (x), Length (LangDir));
     System.Delete (LangDir, x, Length (LangDir));
     x:= High (LangDir);

     WHILE (x > 0) AND (LangDir [x] <> directoryseparator) DO Dec (x);
     IF x < High (LangDir) THEN BEGIN
       Appname:= Copy (LangDir, succ (x), Length (LangDir));
       System.Delete (LangDir, succ (x), Length (LangDir));
     END;
   END;
   IF System.Pos (LinuxFlag, LangDir+ Appname) <> 0  // Linux System
     THEN currentLangFile := LangDir+ alang+ Appname+ LangExt
     ELSE currentLangFile := LangDir+ Appname+ alang+ LangExt;
 {$endif}

   IF (NOT FileExists (currentLangFile)) OR (lowercase (alang) = 'en') OR (Trim (alang) = '')
   THEN BEGIN
   
      mainfo.caption := 'Yeppp NO exist' + (currentLangFile);

   
    // mainfo.caption := 'NO file';
     buildlangtext (LocalisationActive);
    
     lang_modalresult:=           getApplicationLanguage (ModalresultArea);
     lang_modalresultnoshortcut:= getApplicationLanguage (ModalresultnoShortcutArea);
     lang_stockcaption:=          getApplicationLanguage (StockcaptionArea);
     lang_extended:=              getApplicationLanguage (ExtendedArea);
     
    // mainfo.caption := 'Before find';
     lang_langnames:= findmofiles;
     // mainfo.caption := 'after find';
   
   END
   ELSE IF FileExists (currentLangFile) THEN BEGIN
   
     mainfo.caption := 'Yeppp exist' + (currentLangFile);

     MOfile:= TMOfile.Create (currentLangFile);
   
     if assigned(mofile) then
     FOR x:= 0 TO pred (Length (LocalisationReference)) DO
       translate_stock (LocalisationActive [x], LocalisationReference [x], MOfile);

     MOfile.Destroy;
    
     lang_langnames:=  findmofiles;
   END;

   lang_modalresult:=           getApplicationLanguage (ModalresultArea);
   lang_modalresultnoshortcut:= getApplicationLanguage (ModalresultnoShortcutArea);
   lang_stockcaption:=          getApplicationLanguage (StockcaptionArea);
   lang_extended:=              getApplicationLanguage (ExtendedArea);

   IF assigned (realizeApplicationLanguages) THEN realizeApplicationLanguages;
 END;

INITIALIZATION
  Appname:= lowercase (ChangeFileExt (ExtractFileName (ParamStr (0)), '_'));
  LangDir:= ExtractFilePath (ParamStr (0))+ LangDir+ directoryseparator;

  LocalisationReference:= Localisator.Create (en_modalresulttext, en_modalresulttextnoshortcut,
                                              en_stockcaption, en_extendedtext);
  LocalisationActive:=    Localisator.Create (en_modalresulttext, en_modalresulttextnoshortcut,
                                              en_stockcaption, en_extendedtext);
END.
