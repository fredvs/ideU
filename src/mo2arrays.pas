UNIT mo2arrays;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
INTERFACE

VAR
  IndexMainform,
  IndexAction,
  IndexProjectcontext,
  IndexSettings,
  IndexProjectoptions,
  IndexSourceform,
  IndexXstockcaption 
//  IndexLangnames
  : integer;


IMPLEMENTATION

USES
  mo4stock,
  captionideu;

///////////////

PROCEDURE setApplicationLanguages;
 BEGIN
   lang_mainform:=          getApplicationLanguage (IndexMainform);
   lang_actionsmodule:=     getApplicationLanguage (IndexAction);
   lang_projectoptionscon:= getApplicationLanguage (IndexProjectcontext);
   lang_settings:=          getApplicationLanguage (IndexSettings);
   lang_projectoptions:=    getApplicationLanguage (IndexProjectoptions);
   lang_sourceform:=        getApplicationLanguage (IndexSourceform);
   lang_xstockcaption:=     getApplicationLanguage (IndexXstockcaption);
  // lang_langnames:=         getApplicationLanguage (IndexLangnames);
 END;

INITIALIZATION
{$ifdef I_need_a_proprietary_array_type}
  lang_mainform:=          addApplicationStrings (en_mainformtext,          IndexMainform);
  lang_actionsmodule:=     addApplicationStrings (en_actionsmoduletext,     IndexAction);
  lang_projectoptionscon:= addApplicationStrings (en_projectoptionscontext, IndexProjectcontext);
  lang_settings:=          addApplicationStrings (en_settingstext,          IndexSettings);
  lang_projectoptions:=    addApplicationStrings (en_projectoptionstext,    IndexProjectoptions);
  lang_sourceform:=        addApplicationStrings (en_sourceformtext,        IndexSourceform);
  lang_xstockcaption:=     addApplicationStrings (en_xstockcaption,         IndexXstockcaption);
 // lang_langnames:=         addApplicationStrings (en_langnamestext,         IndexLangnames);
{$else}
  IndexMainform:=       addApplicationStrings (en_mainformtext,          lang_mainform);
  IndexAction:=         addApplicationStrings (en_actionsmoduletext,     lang_actionsmodule);
  IndexProjectcontext:= addApplicationStrings (en_projectoptionscontext, lang_projectoptionscon);
  IndexSettings:=       addApplicationStrings (en_settingstext,          lang_settings);
  IndexProjectoptions:= addApplicationStrings (en_projectoptionstext,    lang_projectoptions);
  IndexSourceform:=     addApplicationStrings (en_sourceformtext,        lang_sourceform);
  IndexXstockcaption:=  addApplicationStrings (en_xstockcaption,         lang_xstockcaption);
 // IndexLangnames:=      addApplicationStrings (en_langnamestext,         lang_langnames);
{$endif}
  realizeApplicationLanguages:= @setApplicationLanguages;
END.
