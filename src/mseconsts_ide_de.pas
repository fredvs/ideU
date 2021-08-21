{ MSEgui Copyright (c) 1999-2017 by Martin Schreiber

    See the file COPYING.MSE, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
}
unit mseconsts_ide_de;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  mseconsts_ide;

implementation

uses
  msetypes{msestrings},
  SysUtils,
  mseformatstr;

const
  de_modalresulttext: defaultmodalresulttextty =
    ('',            //mr_none
    '',             //mr_canclose
    '',             //mr_windowclosed
    '',             //mr_windowdestroyed
    '',             //mr_escape
    '',             //mr_f10
    '',             //mr_exception
    '&Abbrechen',   //mr_cancel
    '&Abbrechen',   //mr_abort
    '&OK',          //mr_ok
    '&Ja',          //mr_yes
    '&Nein',        //mr_no
    'A&lle',        //mr_all
    'Ja a&lle',     //mr_yesall
    'N&ein alle',   //mr_noall
    '&Ignorieren',  //mr_ignore
    #0220'bers&pringen',         //mr_skip
    'Alles '#0252'&berspringen', //mr_skipall
    '&Fortfahren'   //mr_continue
    );

  de_modalresulttextnoshortcut: defaultmodalresulttextty =
    ('',                         //mr_none
    '',                          //mr_canclose
    '',                          //mr_windowclosed
    '',                          //mr_windowdestroyed
    '',                          //mr_escape
    '',                          //mr_f10
    '',                          //mr_exception
    'Abbrechen',                 //mr_cancel
    'Abbrechen',                 //mr_abort
    'OK',                        //mr_ok
    'Ja',                        //mr_yes
    'Nein',                      //mr_no
    'Alle',                      //mr_all
    'Ja alle',                   //mr_yesall
    'Nein alle',                 //mr_noall
    'Ignorieren',                //mr_ignore
    #0220'berspringen',          //mr_skip
    'Alles '#0252'berspringen',  //mr_skipall
    'Fortfahren'                 //mr_continue
    );

  de_projectoptionstext: projectoptionsaty = (
    'Projektoptionen', //po_projectoptions
    'Herausgeber',  // po_editor
    'Rechter Rand', // po_rightmarginline
    'Klammern markieren', //  po_markbrackets
    'Linien Nummern', //  po_linenumbers
    'Paarwörter markieren', //  po_markpairwords
    'Nachgestellte'#10'Leerzeichen beim'#10'Speichern abschneiden', //  po_trimtrailing
    'Automatischer Einzug', //  po_autoindent
    'Kein Quelleneditor', //  po_nosource
    'Tab-Einzug',   //  po_tabindent
    'Registerkarte „Raum“', //  po_spacetab
    'Registerkarten anzeigen', //  po_showtabs
    'Anti-Aliasing-Schriftart', //  po_antialiasedfont
    'Codierung',    //  po_encoding
    'Farbe der Marke', //  po_markcolor 
    'Farbe der Stat', // po_statcolor
    'Bild. Y',      // po_scrollbary
    'Anz. Char.',   // po_nbchar
    'EOL-Stil',     //  po_eolstyle
    'Sicherung',    //  po_backup
    'Tabstopps',    //  po_tabstops
    'Einzug',       //  po_indent
    'Zus.Pla.',     //  po_extraspace
    'Zusätzlicher Abstand zwischen den Zeilen', //  po_extraspacehint
    'Breite',       //  po_width
    'Höhe',        //  po_height
    'Schriftart',   //  po_font
    'Schriftfarbe Hintergrunds', //  po_fontbkcolor
    'Schriftfarbe', //  po_fontcolor
    'Dateifilter',  //  po_filefilter
    'Name',         //  po_name
    'Dateimaske',   //  po_filemask
    'Syntaxdefinitionsdatei', //  po_syntaxdeffile
    'Codevorlagen', //  po_codetemplate
    'Codevorlagenverzeichnisse, Dateierweiterung = .mct', //  po_fontcodetemplatedir
 'Geräteverzeichnis auswählen', // po_selectunitdir
 '&Debugger', // po_debuggerpage
 'Projekt-Debugger', // po_projectdebugger
 '&Verzeichnisse suchen', // po_searchdirectories
 'Suchpfad um Infos zum Code zu erhalten', // po_searchdirectorieshint
 'Quellverzeichnis auswählen', // po_selectsourcedir
 'Objektbasisverzeichnis (leer = Verzeichnis erstellen)', // po_objectbasedir
 'Quellbasisverzeichnis auswählen', // po_selectsourcebasedir
 'Def&iniert', // po_defines
 '&Signale', // po_signals
 '&Ausnahme', // po_exception
 '&Ziel', // po_target
 'Starten Sie den gdb-Serverbefehl zum Anhängen des Ziels', // po_startgdbattachtarget
 'Kein Warten auf den Ausgang', // po_nogdbserverexit
 'gdb-Skript von vor der Verbindung', // po_beforeconnect
 'gdb-Skript von vor dem Laden', // po_beforeload
 'gdb-Skript von vor der Ausführung', // po_beforerun
 'gdb-Skript von after connect', // po_afterconnect
 'gdb-Skript von nach dem Laden', // po_afterload
 'Starten gdb-Serverbefehl Ziels ausführen', // gdbservercommand
 'Warten bevor Verbindung', // po_gdbserverwait
 'Einmal anfangen', // po_gdbserverstartonce
 'Befehl zum Herunterladen', // po_uploadcommand
 'Prozessor', // po_gdbprocessor
 'Simulator', // po_gdbsimulator
 'gdb herunterladen', // po_gdbdownload
 'Startup BKPT', // po_startupbkpt
 'Zielverbindung', // po_remoteconnection
 'Immer herunterladen', // po_downloadalways
'Immer vor dem Ausführen herunterladen', // po_downloadalwayshint
'Zeitüberschreitung beim Laden', // po_gdbloadtimeout
'&Externe Konsole', // po_externalconsole
'&Aus.halt.', // po_stoponexception
'Bei Ausnahme anhalten', // po_stoponexceptionhint
'&Paus.akti.', // po_activateonbreak
'Bei Pause aktivieren', // po_activateonbreakhint
'&Wert'#10'Hinweise', // po_valuehints
'Rufen GUI_DEB', // po_nodebugbeginend
'Lassen Sie den Mausgriff am Zielstopp los. gdb stürzt manchmal mit dieser Option ab.', // po_nodebugbeginendhint
'TT&Y einstellen', // po_settty
'&Paus/anhe', // po_raiseonbreak
'In der Pause anheben', // po_raiseonbreakhint
'&FPC-Fehler', // po_fpcgdbworkaround
'Verwenden Sie Problemumgehungen für FPC/gdb-Fehler', // po_fpcgdbworkaroundhint
'Debug-Ziel', // po_debugtarget
'xterm-Befehl', // po_xtermcommand
'&Führen Befehl', // po_runcommand
'&Standard-Debugger', // po_debugcommand
'Debug-Optionen', // po_debugoptions
'&Machen', // po_makepage

'Standard machen', // po_defaultmake
'Hauptdatei', // po_mainfile
'Hauptdatei auswählen', // po_selectmainfile
'Name Zieldatei', // po_targetfile
'Zieldatei auswählen', // po_selecttargetfile
'Standard-Compiler', // po_makecommand
'Wählen Befehl für Machen', // po_selectmakecommand
'Befehlszeile anzeigen', // po_showcommandline
'Nachrichten in Datei kopieren', // po_copymessages
'Nachrichten schließen', // po_closemessages
'Überprüfen Header', // po_checkmethods
'Überprüfen Sie die Methodenheader', // po_checkmethodshint
'Projekt-Compiler', // po_projectcompiler
'Befehl vorher', // po_commandbefore
'Optionen machen', // po_makeoptions
'Verzeichnisse', // po_directories
'Verzeichnis auswählen', // po_unitdirs
'Befehl nach', // po_commandafter
'Exe-Erweiterung', // po_exeextension
'Kommentare', // po_comments
'Verzeichnis Machen', // po_makedir
'Verzeichnis Machen', // po_selectmakedir
'Fehlerfarbe', // po_colorerror
'Warnungfarbe', // po_colorwarning
'Notizfarbe', // po_colornote
'Strip ESC', // po_stripmessageesc
'ESC-Sequenzen in Nachrichten und Terminal entfernen', // po_stripmessageeschint
'Konsole zeigen', // po_showconsole
'Zweck', //po_enablepurpose
'Ausgabedatei Nachrichten', // po_messageoutputfile
'Ausgabedatei Nachrichten', // po_selectmessageoutputfile
'Makros', // po_macros
'Aktive Gruppe', // po_selectactivegroupgrid
'Schriftart-Alias', // po_fontaliaspage
'Designer', // po_designers
'Benutzerfarben', // po_usercolors
'Kopieren Code "setcolormapvalue" in Zwischenablage', // po_copycolor
'Makros formatieren', // po_formatmacro
'Used by formatfloatmse() and formatdatetimemse()', // po_formatmacrohint
'Vorlagen', // po_templates
'Neues Projekt', // po_newproject
'Skript vor Kopieren', // po_scriptbeforecopy
'Skript nach Kopieren', // po_scriptaftercopy
'Neue Datei', // po_newfile
'Neue Form', // po_newform
'Werkzeuge', // po_tools
'Lagerung', // po_storage
'Infos' // po_infos

  );
  
  
  de_stockcaption: stockcaptionaty = (
    '',                        //sc_none
    'ist ung'#0252'ltig',       //sc_is_invalid
    'Format Fehler',           //sc_Format_error
    'Wert wird ben'#0246'tigt', //sc_Value_is_required
    'Fehler',                  //sc_Error
    'Min',                     //sc_Min
    'Max',                     //sc_Max
    'Bereichs Fehler',         //sc_Range_error

    '&R'#0252'ckg'#0228'ngig', //sc_Undohk       ///         ///
    '&Redo',                   //sc_Redohk        //          //
    '&Kopieren',               //sc_Copyhk        // hotkeys  //
    '&Ausschneiden',           //sc_Cuthk         //          //
    '&Einf'#0252'gen',         //sc_Pastehk       //          // hotkeys
    'Alles &markieren',        //sc_Select_allhk ///          //
    'Zeile e&inf'#0252'gen',   //sc_insert_rowhk ///          //
    'Zeile a&nf'#0252'gen',    //sc_append_rowhk  // hotkeys  //
    'Zeile &l'#0246'schen',    //sc_delete_rowhk ///         ///

    '&Dir',                 //sc_Dirhk               ///
    '&Home',                //sc_homehk               //
    '&Auf',                 //sc_Uphk                 //
    'Dir &neu',             //sc_New_dirhk            // hotkeys
    'N&ame',                //sc_Namehk               //
    '&Verst.Dat.anzeigen',  //sc_Show_hidden_fileshk  //
    '&Filter',              //sc_Filterhk            ///
    'Speichern',            //sc_save
    #0214'ffnen',            //sc_open
    'Name',                 //sc_name
    'Verzeichnis erstellen',//sc_create_new_directory
    'Zurück',               //sc_back
    'Forw'#0228'rts',        //sc_forward
    'Aufw'#0228'rts',        //sc_up
    'Datei',                //sc_file
    'existiert, wollen Sie '#0252'berschreiben?', //sc_exists_overwrite
    'wurde geändert, wollen Sie speichern?',     //sc_is_modified_save
    'WARNUNG',                                   //sc_warningupper
    'FEHLER',                                    //sc_errorupper
    'Exception',                                 //sc_exception
    'System',                                    //sc_system
    'existiert nicht',                           //sc_does_not_exist
    'PASSWORT',                 //sc_passwordupper
    'Ppassworteingabe',         //sc_enterpassword
    'Ung'#0252'ltiges Passwort!',//sc_invalidpassword
    'Verzeichnis kann nicht gelesen werden',     //sc_can_not_read_directory
    'Grafik Format nicht unterst'#0252'tzt', //sc_graphic_not_supported
    'Grafik Format Fehler', //sc_graphic_format_error
    'MS Bitmap',            //sc_MS_Icon
    'MS Icon',              //sc_MS_Icon
    'JPEG Bild',            //sc_JPEG_Image
    'PNG Bild',             //sc_PNG_Image
    'XPM Bild',             //sc_XPM_Image
    'PNM Bild',             //sc_PNM_Image
    'TARGA Bild',           //sc_TARGA_image
    'TIFF Bild',            //sc_TIFF_image
    'Alle',                 //sc_All
    'Best'#0228'tigung',     //sc_Confirmation
    'Datensatz l'#0246'schen?', //sc_Delete_record_question
    'Datensatz kopieren?',     //sc_Copy_record_question
    'Seite schliessen',        //sc_close_page
    'Erster',                  //sc_first
    'Vorheriger',              //sc_prior
    'N'#0228'chster',           //sc_next
    'Letzter',                 //sc_last
    'Anf'#0252'gen',            //sc_append
    'L'#0246'schen',            //sc_delete
    'Bearbeiten',              //sc_edit
    'Eintragen',               //sc_post
    'Verwerfen',               //sc_cancel
    'Auffrischen',             //sc_refresh
    'Filter bearbeiten',        //sc_filter_filter
    'Filter Minimum bearbeiten',//sc_edit_filter_min
    'Filter Maximum bearbeiten',//sc_filter_edit_max
    'Filter r'#0252'ckstellen',  //sc_reset_filter
    'Filter ein',               //sc_filter_on
    'Suchen',                   //sc_search
    'Automatisch bearbeiten',   //sc_auto_edit
    'Datensatz kopieren',       //sc_copy_record
    'Dialog',                   //sc_dialog
    'Einf'#0252'gen',            //sc_insert
    'Kopieren',                 //sc_copy
    'Einf'#0252'gen',            //sc_paste
    'Zeile einf'#0252'gen',      //sc_row_insert
    'Zeile anf'#0252'gen',       //sc_row_append
    'Zeile l'#0246'schen',       //sc_row_delete
    'R'#0252'ckg'#0228'ngig',     //sc_undo
    'Wiederherstellen',         //sc_redo
    'Ausschneiden',             //sc_cut
    'Alles markieren',          //sc_select_all
    'Filter aus',               //sc_filter_off
    'Hochformat',               //sc_portrait print orientation
    'Querformat',               //sc_landscape print orientation
    'Zeile l'#0246'schen?',      //sc_Delete_row_question
    'gew'#0228'hlte Zeilen',      //sc_selected_rows
    'Nur Einzeleintrag erlaubt', //sc_Single_item_only
    'Zellen kopieren',           //sc_Copy_Cells
    'Zellen einf'#0252'gen',      //sc_Paste_Cells
    'Schliessen',                //sc_close
    'Maximieren',                //sc_maximize
    'Normalisieren',             //sc_normalize
    'Minimieren',                //sc_minimize
    'Feste Gr'#0246'sse',        //sc_fix_size
    'Lösen',                     //sc_float
    'Im Fordergrund',            //sc_stay_on_top
    'Im Hintergrund',            //sc_stay_in_background
    'Blockiere Unterfenster',    //sc_lock_children
    'Kein Blockieren',           //sc_no_lock
    'Eingabe',                   //sc_input
    'Schaltfeld',                //sc_button
    'Ein',                       //sc_on
    'Aus',                       //sc_off
    'Linker Rand',               //sc_leftborder
    'Oberer Rand',               //sc_topborder
    'Rechter Rand',              //sc_rightborder
    'Unterer Rand',              //sc_bottomborder
    'Text start',                //sc_beginoftext
    'Text ende',                 //sc_endoftext
    'Eingabe Modus',             //sc_inputmode
    #$00DC'berschreiben',        //sc_overwrite
    'Gel'#$00F6'scht',           //sc_deleted
    'Kopiert',                   //sc_copied
    'Eingef'#$00FC'gt',          //sc_inserted
    'Eingef'#$00FC'gt',          //sc_pasted
    'R'#$00FC'ckg'#$00E4'ngig',  //sc_withdrawn
    'Fenster aktiviert',         //sc_windowactivated
    'Men'#$00FC,                 //sc_menu
    'Datei Beginn',              //sc_bof
    'Datei Ende',                //sc_eof
    'Sprachausgabe',             //sc_voiceoutput
    'Wiederhole Sprachausgabe',  //sc_speakagain
    'Erste Spalte',              //sc_firstcol
    'Erste Zeile',               //sc_firstrow
    'Letzte Spalte',             //sc_lastcol
    'Letzte Zeile',              //sc_lastrow
    'Auswahl',                   //sc_selection
    'Spreche Pfad',              //sc_speakpath
    'Deaktiviertes Schaltfeld',  //sc_disabledbutton
    'Erstes Feld',               //sc_firstfield
    'Letztes Feld',              //sc_lastfield
    'Erstes Element',            //sc_firstelement
    'Letztes Element',           //sc_lastelement
    'Langsamer',                 //sc_slower
    'Schneller',                 //sc_faster
    'Fenster',                   //sc_window
    'Bereich',                   //sc_area
    'Bereich aktiviert',         //sc_areaactivated
    'Leiser',                    //sc_volumedown
    'Lauter',                    //sc_volumeup
    'Ansage abbrechen',           //sc_cancelspeech
    'Ziel',                      //sc_target
    'Sicht',               //sc_view
    'Formen',               //sc_forms
    'Layout',               //sc_layout
    'Syntax',               //sc_syntax
    'Projekt',               //sc_project
    'Bearbeitet',                //sc_edited
    'Widgets',               //sc_widgets
    'Einstellungen',               //sc_settings
    'Über',               //sc_about
    'Neue',               //sc_newfile
    'Speichern als ...',               //sc_saveas
    'Rette alle',               //sc_saveall
    'Alle schließen',               //sc_closeall
    'Drucken',                 //sc_print
    'Aufhören',        //sc_quit  
    'Linie',               //sc_line
    'Erneut suchen',               //sc_search_again
    'Zurück suchen',               //sc_search_back
    'Ersatz finden',               //sc_find_replace
    'In Dateien suchen',               //sc_find_infile
    'Verfahrensliste',              //sc_proclist
    'Seite bearbeiten auswählen',               //sc_select_edit_Page
    'Wort am Cursor kopieren',               //sc_Copy_word_cursor
    'Kopieren LaTeX',               //sc_copy_latex
    'Einzug',               //sc_indent
    'Einrückung',               //sc_uindent
    'Umgebung',               //sc_environment
    'Prozess anhängen',               //sc_attachprocess
    'Ziel anhängen',               //sc_attachtarget
    'Ziel abtrennen',               //sc_detachtarget
    'Herunterladen',               //sc_download
    'Werkzeuge',              //sc_tools
    'Machen',                      // sc_make 
    'Bauen',                      // sc_build 
    'Abbrechen',                      // sc_abortmake 
    'Debuggen/Ausführen',                      // sc_debugrun 
    'Optionen',                      // sc_options 
    'Baum',                      // sc_tree 
    'Quelle',                      // sc_source 
    'Kopie öffnen',                      // sc_opencopy 
    'Kopie speichern unter...',                      // sc_saveascopy 
    'Verschönerer',                      // sc_beautifier
    'Platten',                      // sc_panels
    'Z-Reihenfolge erzwingen',                      // sc_forcezorder
    'Baumstruktur',                      // sc_treelist
    'Mitteilungen',                      // sc_messages
    'Ergebnis der Suche',                      // sc_findresult
    'Kommandant',                      // sc_commander
    'Symbole',                      // sc_symbols
    'Uhren',                      // sc_watches
    'Stapel',                      // sc_stack
    'Fäden',                      // sc_threads
    'CPU',                      // sc_cpu
    'Assembler',                      // sc_assembler
    'Haltepunkte',                      // sc_breakpoints
    'Beobachtungspunkte',                      // sc_watchpoints 
    'Speicher',                      // sc_memory
    'Zielkonsole',                      // sc_targetconsole 
    'Form/Einheit umschalten',          // sc_toggleformunit
    'MSE-Module',                      // sc_msemod 
    'Schließen Sie alle MSE-Module',          // sc_closeallmsemod
    'Allgemeine Einstellungen',          // sc_generalsettings
    'Zusätzliche Einstellungen',          // sc_extrasettings
    'Sprachen',          // sc_lang
    'Widgets konfigurieren',          // sc_configwidgets
    'Compiler konfigurieren',          // sc_configcompilers
    'Debugger konfigurieren',          // sc_configdebuggers
    'Themen'          // sc_themes
    );

function delete_n_selected_rows(const params: array of const): msestring;
begin
  with params[0] do
    if vinteger = 1 then
      Result := 'Gew'#0228'hlte Zeile l'#0246'schen?'
    else
      Result := inttostrmse(vinteger) +
        WideString(' gew'#0228'hlte Zeilen l'#0246'schen?');
end;

const
  de_textgenerator: defaultgeneratortextty = (
              {$ifdef FPC} @{$endif}delete_n_selected_rows //tg_delete_n_selected_rows
    );

initialization
  registerlangconsts(langnames[la_de], @de_projectoptionstext, @de_stockcaption, @de_modalresulttext, @de_modalresulttextnoshortcut, @de_textgenerator);
end.

