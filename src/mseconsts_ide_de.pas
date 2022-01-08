{ MSEgui Copyright (c) 1999-2018 by Martin Schreiber

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
  msestockobjects,
  mseformatstr;

const

de_modalresulttext: defaultmodalresulttextty =
 (
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '&Abbrechen',   {&Cancel}
  '&Abbrechen',   {&Abort}
  '&OK',   {&OK}
  '&Ja',   {&Yes}
  '&Nein',   {&No}
  'A&lle',   {Yes &all}
  'A&lle',   {Yes &all}
  'N&ein alle',   {N&o all}
  '&Ignorieren',   {&Ignore}
  '#0220bers&pringen',   {&Skip}
  'Alles #0252&berspringen',   {Skip a&ll}
  '&Fortfahren'   {Co&ntinue}
 );

de_modalresulttextnoshortcut: defaultmodalresulttextty =
 (
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  'Abbrechen',   {Cancel}
  'Abbrechen',   {Abort}
  'OK',   {OK}
  'Ja',   {Yes}
  'Nein',   {No}
  'Alle',   {Yes all}
  'Alle',   {Yes all}
  'Nein alle',   {No all}
  'Ignorieren',   {Ignore}
  '#0220berspringen',   {Skip}
  'Alles #0252berspringen',   {Skip all}
  'Fortfahren'   {Continue}
 );

de_projectoptionscontext: projectoptionsconaty =
 (
  'Eine falsche Kodierung kann Ihre Quelldateien beschädigen.',   {Wrong encoding can damage your source files.}
  'Möchten Sie die Kodierung auf setzen',   {Do you wish to set encoding to}
  '*** WARNUNG ***',   {*** WARNING ***}
  'Auflegen',   {Hangup}
  'Unterbrechen',   {Interrupt}
  'Aufhören',   {Quit}
  'Illegaler Unterricht',   {Illegal instruction}
  'Spurenfalle',   {Trace trap}
  'Abbrechen',   {Abort}
  'BUS-Fehler',   {BUS error}
  'Gleitkomma-Ausnahme',   {Floating-point exception}
  'Töten',   {Kill}
  'Benutzerdefiniertes Signal 1',   {User-defined signal 1}
  'Segmentierungsverletzung',   {Segmentation violation}
  'Benutzerdefiniertes Signal 2',   {User-defined signal 2}
  'Rohrbruch',   {Broken pipe}
  'Wecker',   {Alarm clock}
  'Beendigung',   {Termination}
  'Stack-Fehler',   {Stack fault}
  'Kinderstatus hat sich geändert',   {Child status has changed}
  'Fortfahren',   {Continue}
  'Stopp nicht blockierbar',   {Stop, unblockable}
  'Tastaturstopp',   {Keyboard stop}
  'Hintergrund von tty gelesen',   {Background read from tty}
  'Hintergrund an tty schreiben',   {Background write to tty}
  'Dringender Zustand an Steckdose',   {Urgent condition on socket}
  'CPU Limit überschritten',   {CPU limit exceeded}
  'Dateigrößenbeschränkung überschritten',   {File size limit exceeded}
  'Virtueller Wecker',   {Virtual alarm clock}
  'Profiling-Wecker',   {Profiling alarm clock}
  'Fenstergröße ändern',   {Window size change}
  'I/O jetzt möglich',   {I/O now possible}
  'Neustart bei Stromausfall'   {Power failure restart}
 );

de_actionsmoduletext: actionsmoduleaty =
 (
  'ideU konfigurieren',   {Configure ideU}
  'Prozess ID',   {Process ID}
  'An Prozess anhängen',   {Attach to process}
  'Unbekannte Modulklasse für "',   {Unknown moduleclass for "}
  'Geerbte Komponente',   {Inherited component "}
  '" kann nicht gelöscht werden.',   {" can not be deleted.}
  'ERROR',   {ERROR}
  'Abbruch machen.',   {Make aborted.}
  'Download abgebrochen.',   {Download aborted.}
  'Ausführungsfehler mit "',   {Runerror with "}
  'Fehler: Zeitüberschreitung.',   {Error: Timeout.}
  'Herstellung.',   {Making.}
  'Nicht laufen lassen.',   {Make not running.}
  'Wird heruntergeladen.',   {Downloading.}
  'Download läuft nicht.',   {Download not running.}
  '" Laufen.',   {" running.}
  'Skript',   {Script}
  'Rekursive Formvererbung von "',   {Recursive form inheritance of "}
  'Komponente',   {Component "}
  '" existiert.',   {" exists.}
  'Vorfahr für "',   {Ancestor for "}
  '" nicht gefunden.',   {" not found.}
  'Modul',   {Module "}
  'Ungültiger Name "',   {Invalid name "}
  'Ungültiger Methodenname',   {Invalid methodname}
  'Modul nicht gefunden',   {Module not found}
  'Methode nicht gefunden',   {Method not found}
  'Veröffentlichte (verwaltete) Methode',   {Published (managed) method}
  'ist nicht vorhanden.',   {does not exist.}
  'Möchten Sie die Veranstaltung löschen?',   {Do you wish to delete the event?}
  'WARNUNG',   {WARNING}
  'Methode',   {Method}
  'hat verschiedene Parameter.',   {has different parameters.}
  'Ein Modul',   {A module "}
  '" ist bereits geöffnet.',   {" is already open.}
  'Ungelöste Referenz(en) auf',   {Unresolved reference(s) to}
  'Modul(e):',   {Module(s):}
  'Formdatei kann nicht gelesen werden "',   {Can not read formfile "}
  'Ungültiger Komponentenname.',   {Invalid component name.}
  'Ungültige Ausnahme',   {Invalid exception}
  'Werkzeuge',   {T&ools}
  'Formen',   {Forms}
  'Quelle',   {Source}
  'Alle Dateien',   {All Files}
  'MSE-Programm',   {MSE Program}
  'MSE-Einheit',   {MSE Unit}
  'MSE-Textdatei',   {MSE Textfile}
  'Hauptform',   {Mainform}
  'Einfache Form',   {Simple Form}
  'Andockformular',   {Docking Form}
  'Datenmodul',   {Datamodule}
  'Unterformular',   {Subform}
  'Scrollboxform',   {Scrollboxform}
  'Tabsform',   {Tabform}
  'Dockpanel',   {Dockpanel}
  'Prüfbericht',   {Report}
  'Schriftform',   {Scriptform}
  'Geerbte Form',   {Inherited Form}
  'Möchten Sie die Einstellungen ersetzen durch',   {Do you want to replace the settings by}
  'Die Datei "',   {File "}
  'Möchtest du überschreiben?',   {Do you want to overwrite?}
  'Unbekannt',   {Unknown}
  'Fehler',   {Error}
  'Anlaufen',   {Startup}
  'Ausnahme',   {Exception}
  'GDB gestorben',   {GDB died}
  'Breakpoint-Treffer',   {Breakpoint hit}
  'Watchpoint ausgelöst',   {Watchpoint triggered}
  'Watchpoint lesen ausgelöst',   {Read Watchpoint triggered}
  'Zugriff auf Watchpoint ausgelöst',   {Access Watchpoint triggered}
  'Endschaltbereich',   {End stepping range}
  'Funktion beendet',   {Function finished}
  'Normalerweise beendet',   {Exited normally}
  'beendet',   {Exited}
  'Löste sich',   {Detached}
  'Signal empfangen',   {Signal received}
  'Stopp-Fehler',   {Stop error}
  'Projekt kann nicht gelesen werden',   {Can not read project}
  'Über',   {About}
  'Objektinspektor',   {Object Inspector}
  'Komponentenlager',   {Store Component}
  'Anhängeprozess',   {Attaching Process}
  'Wird geladen'   {Loading}
 );

de_mainformtext: mainformaty =
 (
  'Unaufgelöste Referenzen in',   {Unresolved references in}
  'zu',   {to}
  'Möchten Sie die Formulardatei durchsuchen?',   {Do you wish to search the formfile?}
  'WARNUNG',   {WARNING}
  'Formular für',   {Formfile for}
  'Formdateien',   {Formfiles}
  'Rekursive Formularhierarchie für "',   {Recursive form hierarchy for "}
  'ERROR',   {ERROR}
  'Klassenart',   {Classtype}
  'nicht gefunden.',   {not found.}
  'Projekt',   {Project}
  'wird modifiziert. Speichern?',   {is modified. Save?}
  'Bestätigung',   {Confirmation}
  'Datei kann nicht geöffnet werden "',   {Unable to open file "}
  '*** Laufen ***',   {*** Running ***}
  'Wird heruntergeladen',   {Downloading}
  'Heruntergeladen',   {Downloaded}
  'Gdb-Server-Befehl starten "',   {Start gdb server command "}
  '" Laufen.',   {" running.}
  'gdb-Server starten',   {Start gdb Server}
  'gdb-Server-Startfehler',   {gdb server start error}
  'gdb-Serverstart abgebrochen.',   {gdb server start canceled.}
  'Der Befehl start gdb kann nicht ausgeführt werden.',   {Can not run start gdb command.}
  'Hochladenbefehl',   {Uploadcommand "}
  'Download Fehler***',   {Download ***ERROR***}
  'Download abgeschlossen.',   {Download finished.}
  'Download abgebrochen.',   {Download canceled.}
  'Die Datei "',   {File "}
  '" nicht gefunden.',   {" not found.}
  '" existiert.',   {" exists.}
  'Neu',   {New}
  'Vorfahren auswählen',   {Select ancestor}
  'Neue Form',   {New form}
  'Pascal-Dateien',   {Pascal Files}
  'Neu',   {new}
  'Projekt kann nicht geladen werden "',   {Can not load Project "}
  'Projektvorlage auswählen',   {Select project template}
  'Projektdateien',   {Project files}
  'Alle Dateien',   {All files}
  'Programmdatei auswählen',   {Select program file}
  'Pascal-Programmdateien',   {Pascal program files}
  'C-Programmdateien',   {C program files}
  'Neues Projekt',   {New Project}
  'Prozess kann nicht gestartet werden',   {Can not start process}
  'Verfahren',   {Process}
  'Laufen.',   {running.}
  'Prozess beendet',   {Process terminated}
  'Prozess wurde normal beendet.',   {Process terminated normally.}
  'Make ***FEHLER***',   {Make ***ERROR***}
  'Gut machen.',   {Make OK.}
  'Quelle hat sich geändert möchten Sie das Projekt neu erstellen?',   {Source has changed, do you wish to remake project?}
  'Fensterlayout laden',   {Load Window Layout}
  'Andockbereich'   {Docking area}
 );

de_sourceformtext: sourceformaty =
 (
  'Die Datei "',   {File "}
  '" has changed.',   {" has changed.}
  'There are modifications in edit buffer also.',   {There are modifications in edit buffer also.}
  'Do you wish to reload from disk?',   {Do you wish to reload from disk?}
  'Bestätigung',   {Confirmation}
  '<none>',   {<none>}
  'Do you wish to replace:',   {Do you wish to replace:}
  'with:',   {with:}
  '<new>',   {<new>}
  'Syntaxdeffile:',   {Syntaxdeffile:}
  'Text',   {Text}
  'nicht gefunden.',   {not found.}
  'Restart from begin of file?',   {Restart from begin of file?}
  'Cancel?',   {Cancel?}
  'Do you wish to to replace this occurence?',   {Do you wish to to replace this occurence?}
  'Go to line number:',   {Go to line number:}
  'Find line',   {Find line}
  'There are modifications in edit buffer also.'   {There are modifications in edit buffer also.}
 );

de_settingstext: isettingsaty =
 (
  'Anwenden',   {Apply}
  'sak Sprachassistenz-Konfiguration',   {sak voice assistive config}
  'Übergeordnetes Verzeichnis von sakit',   {Parent directory of sakit}
  'Sak-Assistent beim Laden aktivieren',   {Enable sak assistive at loading}
  'Disposition du système',   {System layout}
  'Disposición universal de directorios',   {Universal path layout}
  'Keine Z-Auftragsabwicklung',   {No Z order handling}
  'Umschalttaste um Wort auszuwählen',   {Use shift key to select a word}
  'Autofokus im Hauptmenü',   {Auto focus in main-menu}
  'Vollständiger Projektpfad im Titel',   {Full path of project in window title}
  'Dialog als modal festlegen',   {Set dialog-forms as modal vs as tool}
  'Schrifthöhe',   {Font height}
  'Schriftname',   {Font name}
  'Keine Bestätigung zum Löschen Zeile',   {No confirmation to delete row}
  'Blinkendes Caret-Symbol',   {Blinking caret}
  'Canvas neu lackieren',   {Repaint canvas}
  'Quelleneditor',   {Source Editor}
  'Verwenden Sie diese Optionen',   {Use those options instead of project options}
  'Leerzeichen nach Komma beim Auto-Parsing',   {Add space after comma -> auto-parsing}
  'Wenn sich eine Datei geändert hat:',   {When a file has changed}
  'Kein Dialog => Neu laden',   {No dialog box => reload the new one}
  'Kein Dialog => das Alte behalten',   {No dialog box => keep the old one}
  'Ein Dialog fragt was zu tun ist...',   {A dialog box ask what to do...}
  'Rechteck um Mehrfachauswahl'   {Rectangle around multi-select}
 );

de_projectoptionstext: projectoptionsaty =
 (
  'Projektoptionen',   {Project options}
  'Herausgeber',   {Editor}
  'Rechter Rand',   {Right margin line}
  'Klammern markieren',   {Mark Brackets}
  'Linien Nummern',   {Line Numbers}
  'Paarwörter markieren',   {Mark Pairwords}
  'Nachgestellte Leerzeichen#10beim Speichern abschneiden',   {Trim trailing whitespace on save}
  'Automatischer Einzug',   {Auto Indent}
  'Kein Quelleneditor',   {No Source Editor}
  'Tab-Einzug',   {Tab indent}
  'Registerkarte#10„Raum“',   {Space tab}
  'Registerkarten anzeigen',   {Show tabs}
  'Anti-Aliasing-Schriftart',   {Anti aliased font}
  'Codierung',   {Encoding}
  'Farbe der Marke',   {Mark Color}
  'Farbe der Stat',   {Stat Color}
  'Bild. Y',   {Scr Y}
  'Anz. Char.',   {Nb char}
  'EOL-Stil',   {EOL Style}
  'Sicherung',   {Backup}
  'Tabstopps',   {Tabstops}
  'Einzug',   {Indent}
  'Zus.Pla.',   {ExtS}
  'Zusätzlicher Abstand zwischen den Zeilen',   {Extra space between lines}
  'Breite',   {Width}
  'Höhe',   {Height}
  'Schriftart',   {Font}
  'Schriftfarbe Hintergrunds',   {Font Bk. color}
  'Schriftfarbe',   {Font color}
  'Dateifilter',   {File filter}
  'Name',   {Name}
  'Dateimaske',   {File mask}
  'Syntaxdefinitionsdatei',   {Syntax definition file}
  'Codevorlagen',   {Code Templates}
  'Codevorlagenverzeichnisse Dateierweiterung = .mct',   {Code template directories, file extension = .mct}
  'Geräteverzeichnis auswählen',   {Select unit directory}
  '&Debugger',   {&Debugger}
  'Projekt-Debugger',   {Project Debugger}
  '&Verzeichnisse suchen',   {Search &Directories}
  'Suchpfad um Infos zum Code zu erhalten',   {Search path to get infos about code}
  'Quellverzeichnis auswählen',   {Select source directory}
  'Objektbasisverzeichnis (leer = Verzeichnis erstellen)',   {Object &Base Directory (empty = Make Directory)}
  'Quellbasisverzeichnis auswählen',   {Select source base directory}
  'Def&iniert',   {Defi&nes}
  '&Signale',   {&Signals}
  '&Ausnahme',   {&Exception}
  '&Ziel',   {&Target}
  'Starten Sie den gdb-Serverbefehl zum Anhängen des Ziels',   {Start gdb server command attach target}
  'Kein Warten auf den Ausgang',   {No wait for exit}
  'gdb-Skript von vor der Verbindung',   {Before connect gdb script}
  'gdb-Skript von vor dem Laden',   {Before load gdb script}
  'gdb-Skript von vor der Ausführung',   {Before run gdb script}
  'gdb-Skript von after connect',   {After connect gdb script}
  'gdb-Skript von nach dem Laden',   {After load gdb script}
  'Starten gdb-Serverbefehl Ziels ausführen',   {Start gdb server command run target}
  'Warten bevor Verbindung',   {Wait before connect}
  'Einmal anfangen',   {Start once}
  'Befehl zum Herunterladen',   {Download command}
  'Prozessor',   {Processor}
  'Simulator',   {Simulator}
  'gdb herunterladen',   {gdb download}
  'Startup BKPT',   {Startup BKPT}
  'Zielverbindung',   {Target connection}
  'Immer herunterladen',   {Always download}
  'Immer vor dem Ausführen herunterladen',   {Always download before run}
  'Zeitüberschreitung beim Laden',   {Load Timeout}
  '&Externe Konsole',   {&Extern Console}
  '&Aus.halt.',   {&Stop on Exc}
  'Bei Ausnahme anhalten',   {Stop on exceptions}
  '&Paus.akti.',   {&Acti-Break}
  'Bei Pause aktivieren',   {Activate on Break}
  '&Wert#10Hinweise',   {&Value Hints}
  'Rufen GUI_DEB',   {Call GUI_DEB}
  'Lassen Sie den Mausgriff am Zielstopp los. gdb stürzt manchmal mit dieser Option ab.',   {Release mouse grab by target stop. gdb sometimes crashes with this option.}
  'TT&Y einstellen',   {Set TT&Y}
  '&Paus/anhe',   {&Raise-Break}
  'In der Pause anheben',   {Raise on break}
  '&FPC-Fehler',   {&FPC bugs}
  'Verwenden Sie Problemumgehungen für FPC/gdb-Fehler',   {Use workarounds for FPC/gdb bugs}
  'Debug-Ziel',   {Debug &target}
  'xterm-Befehl',   {xterm command}
  '&Führen Befehl',   {Run command}
  '&Standard-Debugger',   {Default Debugger}
  'Debug-Optionen',   {Debug &options}
  '&Machen',   {&Make}
  'Standard machen',   {Default make col}
  'Hauptdatei',   {Mainfile}
  'Hauptdatei auswählen',   {Select mainfile}
  'Name Zieldatei',   {Targetfile name}
  'Zieldatei auswählen',   {Select target file}
  'Standard-Compiler',   {Default Compiler}
  'Wählen Befehl für Machen',   {Select make command}
  'Befehlszeile anzeigen',   {Show Command Line}
  'Nachrichten in Datei kopieren',   {Copy messages to file}
  'Nachrichten schließen',   {Close message}
  'Überprüfen Header',   {Check head}
  'Überprüfen Sie die Methodenheader',   {Check method headers}
  'Projekt-Compiler',   {Project Compiler}
  'Befehl vorher',   {Command before}
  'Optionen machen',   {Make options}
  'Verzeichnisse',   {Directories}
  'Geräteverzeichnis auswählen',   {Select unit directory}
  'Befehl nach',   {Command after}
  'Exe-Erweiterung',   {Exe Extension}
  'Kommentare',   {Comments}
  'Verzeichnis Machen',   {Make Directory}
  'Verzeichnis Machen',   {Select make directory}
  'Fehlerfarbe',   {Error Color}
  'Warnungfarbe',   {Warning Color}
  'Notizfarbe',   {Note Color}
  'Strip ESC',   {Strip ESC}
  'ESC-Sequenzen in Nachrichten und Terminal entfernen',   {Strip ESC sequences in Messages and Terminal form}
  'Konsole zeigen',   {Show Console}
  'Zweck',   {Purpose}
  'Ausgabedatei Nachrichten',   {Message output file}
  'Zieldatei auswählen',   {Select target file}
  'Makros',   {Macros}
  'Aktive Gruppe',   {Active group}
  'Schriftart-Alias',   {&Font Alias}
  'Designer',   {Designers}
  'Benutzerfarben',   {User &Colors}
  'Kopieren Code "setcolormapvalue" in Zwischenablage',   {Copy "setcolormapvalue" code to clipboard}
  'Makros formatieren',   {F&ormat Macros}
  'Used by formatfloatmse() and formatdatetimemse()',   {Used by formatfloatmse() and formatdatetimemse()}
  'Vorlagen',   {Templates}
  'Neues Projekt',   {New project}
  'Skript vor Kopieren',   {Script before copy}
  'Skript nach Kopieren',   {Script after copy}
  'Neue Datei',   {New File}
  'Neue Form',   {New Form}
  'Werkzeuge',   {Tools}
  'Lagerung',   {Storage}
  'Infos',   {Infos}
  'Vollständiger Projektname',   {Full name of project}
  'Schöpfer',   {Creator}
  'Lizenz',   {License}
  'Erstellungsdatum'   {Date of creation}
 );

de_stockcaption: stockcaptionaty =
(
  '',   {}
  'ist ung#0252ltig',   {is invalid}
  'Format Fehler',   {Format error}
  'Wert wird ben#0246tigt',   {Value is required}
  'Fehler',   {Error}
  'Min',   {Min}
  'Max',   {Max}
  'Bereichs Fehler',   {Range error}
  '&R#0252ckg#0228ngig',   {&Undo}
  '&Redo',   {&Redo}
  '&Kopieren',   {&Copy}
  '&Ausschneiden',   {Cu&t}
  '&Einf#0252gen',   {&Paste}
  'Alles &markieren',   {Select &all}
  'Zeile e&inf#0252gen',   {&Insert Row}
  'Zeile a&nf#0252gen',   {&Append Row}
  'Zeile &l#0246schen',   {&Delete Row}
  '&Dir',   {&Dir}
  '&Home',   {&Home}
  '&Auf',   {&Up}
  'Dir &neu',   {&New}
  'N&ame',   {&Name}
  '&Verst.Dat.anzeigen',   {&Show hidden files}
  '&Filter',   {&Filter}
  'Speichern',   {Save}
  '#0214ffnen',   {Open}
  'Name',   {Name}
  'Verzeichnis erstellen',   {Create new directory}
  'Zurück',   {Back}
  'Forw#0228rts',   {Forward}
  'Aufw#0228rts',   {Up}
  'Datei',   {File}
  'existiert wollen Sie #0252berschreiben?',   {exists, do you want to overwrite?}
  'wird modifiziert. Speichern?',   {is modified. Save?}
  'WARNUNG',   {WARNING}
  'ERROR',   {ERROR}
  'Ausnahme',   {Exception}
  'System',   {System}
  'existiert nicht',   {does not exist}
  'PASSWORT',   {PASSWORD}
  'Ppassworteingabe',   {Enter password}
  'Ung#0252ltiges Passwort!',   {Invalid password!}
  'Verzeichnis kann nicht gelesen werden',   {Can not read directory}
  'Grafik Format nicht unterst#0252tzt',   {Graphic format not supported}
  'Grafik Format Fehler',   {Graphic format error}
  'MS Bitmap',   {MS Bitmap}
  'MS Icon',   {MS Icon}
  'JPEG Bild',   {JPEG Image}
  'PNG Bild',   {PNG Image}
  'XPM Bild',   {XPM Image}
  'PNM Bild',   {PNM Image}
  'TARGA Bild',   {TARGA Image}
  'TIFF Bild',   {TIFF Image}
  'Alle',   {All}
  'Bestätigung',   {Confirmation}
  'Datensatz l#0246schen?',   {Delete record?}
  'Datensatz kopieren?',   {Copy record?}
  'Seite schliessen',   {Close page}
  'Erster',   {First}
  'Vorheriger',   {Prior}
  'N#0228chster',   {Next}
  'Letzter',   {Last}
  'Anf#0252gen',   {Append}
  'L#0246schen',   {Delete}
  'Bearbeiten',   {Edit}
  'Eintragen',   {Post}
  'Abbrechen',   {Cancel}
  'Auffrischen',   {Refresh}
  'Filter bearbeiten',   {Edit filter}
  'Filter Minimum bearbeiten',   {Edit filter minimum}
  'Filter Maximum bearbeiten',   {Edit filter maximum}
  'Filter r#0252ckstellen',   {Reset filter}
  'Filter ein',   {Filter on}
  'Suchen',   {Search}
  'Automatisch bearbeiten',   {Auto edit}
  'Datensatz kopieren',   {Copy record}
  'Dialog',   {Dialog}
  'Einf#0252gen',   {Insert}
  'Kopieren',   {Copy}
  'Einf#0252gen',   {Paste}
  'Zeile einf#0252gen',   {Row insert}
  'Zeile anf#0252gen',   {Row append}
  'Zeile l#0246schen',   {Row delete}
  'R#0252ckg#0228ngig',   {Undo}
  'Wiederherstellen',   {Redo}
  'Ausschneiden',   {Cut}
  'Alles markieren',   {Select all}
  'Filter aus',   {Filter off}
  'Hochformat',   {Portrait}
  'Querformat',   {Landscape}
  'Zeile l#0246schen?',   {Delete row?}
  'gew#0228hlte Zeilen',   {selected rows?}
  'Nur Einzeleintrag erlaubt',   {Single item only}
  'Zellen kopieren',   {Copy Cells}
  'Zellen einf#0252gen',   {Paste Cells}
  'Schliessen',   {Close}
  'Maximieren',   {Maximize}
  'Normalisieren',   {Normalize}
  'Minimieren',   {Minimize}
  'Feste Gr#0246sse',   {Fix size}
  'Lösen',   {Float}
  'Im Fordergrund',   {Stay on top}
  'Im Hintergrund',   {Stay in background}
  'Blockiere Unterfenster',   {Lock children}
  'Kein Blockieren',   {No lock}
  'Eingabe',   {Input}
  'Schaltfeld',   {Button}
  'Ein',   {On}
  'Aus',   {Off}
  'Linker Rand',   {Left border}
  'Oberer Rand',   {Top border}
  'Rechter Rand',   {Right border}
  'Unterer Rand',   {Bottom border}
  'Text start',   {Begin of text}
  'Text ende',   {End of text}
  'Eingabe Modus',   {Inputmode}
  '#$00DCberschreiben',   {Overwrite}
  'Gel#$00F6scht',   {Deleted}
  'Kopiert',   {Copied}
  'Eingef#$00FCgt',   {Inserted}
  'Eingef#$00FCgt',   {Pasted}
  'R#$00FCckg#$00E4ngig',   {Withdrawn}
  'Fenster aktiviert',   {Window activated}
  'Men#$00FC',   {Menu}
  'Datei Beginn',   {Beginning of file}
  'Datei Ende',   {End of file}
  'Sprachausgabe',   {Voice output}
  'Wiederhole Sprachausgabe',   {Speak again}
  'Erste Spalte',   {First column}
  'Erste Zeile',   {First row}
  'Letzte Spalte',   {Last column}
  'Letzte Zeile',   {Last row}
  'Auswahl',   {Selection}
  'Spreche Pfad',   {Speak path}
  'Deaktiviertes Schaltfeld',   {Disabled button}
  'Erstes Feld',   {First field}
  'Letztes Feld',   {Last field}
  'Erstes Element',   {First element}
  'Letztes Element',   {Last element}
  'Langsamer',   {Slower}
  'Schneller',   {Faster}
  'Fenster',   {Window}
  'Bereich',   {Area}
  'Bereich aktiviert',   {Area activated}
  'Leiser',   {Volume down}
  'Lauter',   {Volume up}
  'Ansage abbrechen',   {Cancel speech}
  'Ziel',   {Target}
  'Sicht',   {View}
  'Formen',   {Forms}
  'Layout',   {Layout}
  'Syntax',   {Syntax}
  'Projekt',   {Project}
  'Bearbeitet',   {Edited}
  'Widgets',   {Widgets}
  'Einstellungen',   {Settings}
  'Über',   {About}
  'Neu',   {New}
  'Speichern als ...',   {Save as...}
  'Rette alle',   {Save all}
  'Alle schließen',   {Close all}
  'Drucken',   {Print}
  'Aufhören',   {Quit}
  'Linie',   {Line}
  'Erneut suchen',   {Search again}
  'Zurück suchen',   {Search back}
  'Ersatz finden',   {Find & replace}
  'In Dateien suchen',   {Find in files}
  'Verfahrensliste',   {Procedures list}
  'Seite bearbeiten auswählen',   {Select edit page}
  'Wort am Cursor kopieren',   {Copy word at cursor}
  'Kopieren LaTeX',   {Copy LaTeX}
  'Einzug',   {Indent}
  'Einrückung',   {Unindent}
  'Umgebung',   {Environment}
  'Prozess anhängen',   {Attach process}
  'Ziel anhängen',   {Attach target}
  'Ziel abtrennen',   {Detach target}
  'Herunterladen',   {Download}
  'Werkzeuge',   {Tools}
  'Machen',   {Make}
  'Bauen',   {Build}
  'Abbrechen',   {Abort make}
  'Debuggen/Ausführen',   {Debug-Run}
  'Optionen',   {Options}
  'Baum',   {Tree}
  'Quelle',   {Source}
  'Kopie öffnen',   {Open copy}
  'Kopie speichern unter...',   {Save copy as}
  'Verschönerer',   {Beautifier}
  'Platten',   {Panels}
  'Z-Reihenfolge erzwingen',   {Force Z order}
  'Baumstruktur',   {Tree list}
  'Mitteilungen',   {Messages}
  'Ergebnis der Suche',   {Find result}
  'Kommandant',   {Commander}
  'Symbole',   {Symbols}
  'Uhren',   {Watches}
  'Stapel',   {Stack}
  'Fäden',   {Threads}
  'CPU',   {CPU}
  'Assembler',   {Assembler}
  'Haltepunkte',   {Breakpoints}
  'Beobachtungspunkte',   {Watchpoints}
  'Speicher',   {Memory}
  'Zielkonsole',   {Target console}
  'Form/Einheit umschalten',   {Toggle form/unit}
  'MSE-Module',   {MSE modules}
  'Schließen Sie alle MSE-Module',   {Close all MSE modules}
  'Allgemeine Einstellungen',   {General settings}
  'Zusätzliche Einstellungen',   {Extra settings}
  'Sprachen',   {Languages}
  'Widgets konfigurieren',   {Configure widgets}
  'Compiler konfigurieren',   {Configure compilers}
  'Debugger konfigurieren',   {Configure debuggers}
  'Themen',   {Themes}
  'Verzeichnis',   {Directory}
  'Ohne Symbole',   {No icons}
  'Ohne seitliche',   {No lateral}
  'Kompakt',   {Compact}
  'Öffnen das Projekt',   {Open project}
  'Öffne die Datei',   {Open file}
  'Pfad',   {Path}
  'Sonstiges',   {Other}
  'Druckbefehl',   {Print command}
  'Abkürzung',   {Shortcut}
  'Wert',   {Value}
  'Case sensitive',   {Case sensitive}
  'Nur ausgewählt',   {Selected only}
  'Ganze Welt',   {Whole word}
  'Text zu finden',   {Text to find}
  'In aktuellen Datei suchen',   {Search in current file}
  'In geöffneten Dateien suchen',   {Search in open files}
  'Suche im Projektverzeichnis',   {Search in project directory}
  'Suche in Verzeichnissen',   {Search in directories}
  'Unterverzeichnisse einschließen',   {Include subdirectories}
  'Ersetzen',   {Replace}
  'Alles ersetzen',   {Replace all}
  'Ersetzen mit',   {Replace with}
  'Nach Ersetzen fragen',   {Prompt on replace}
  'Komponentenpalette',   {Components palette}
  'Komponenten finden',   {Find components}
  'Zurücksetzen',   {Reset}
  'Schritt',   {Step}
  'Schrittanweisung',   {Step instruction}
  'Nächste Anweisung',   {Next instruction}
  'Debugger neu starten',   {Restart debugger}
  'Haltepunkt umschalten',   {Toggle breakpoint}
  'Haltepunkt umschalten aktiviert',   {Toggle breakpoint enabled}
  'Ausgeführter Zeilenhinweis ein/aus',   {Executed lines hint on/off}
  'Bitte zuerst kompilieren.',   {Please compile it first.}
  'Finish',   {Finish}
  'Als Standard eingestellt',   {Set as default}
  'Host',   {Host}
  'Urheberrecht'   {Copyright}
 );

de_langnamestext: array[0..6] of msestring =
(
  'Englisch',   {English}
  'Russisch',   {Russian}
  'Französisch',   {French}
  'Deutsch',   {German}
  'Spanisch',   {Spanish}
  'Portugiesisch',   {Portuguese}
  'Chinese (not complete)' //6_chinese
 );

de_extendedtext: extendedaty =
(
  'Gew#0228hlte Zeile l#0246schen?',   {Delete selected row?}
  '%s gew#0228hlte Zeilen l#0246schen?'   {Delete %s selected rows?}
 );

function delete_n_selected_rows(const params: array of const): msestring;
begin
  with params[0] do
    if vinteger = 1 then
      Result := de_extendedtext[ex_del_row_selected]
    else
      Result := StringReplace(de_extendedtext[ex_del_rows_selected], #37#115, inttostrmse(vinteger), [rfReplaceAll]);
end;

const
de_textgenerator: defaultgeneratortextty = (
 {$ifdef FPC} @{$endif}delete_n_selected_rows);

initialization

registerlangconsts(langnames[la_de], @de_langnamestext, @de_extendedtext, @de_mainformtext, @de_sourceformtext,
                   @de_projectoptionscontext, @de_actionsmoduletext, @de_settingstext, @de_projectoptionstext,
                   @de_stockcaption, @de_modalresulttext, @de_modalresulttextnoshortcut, @de_textgenerator);

end.

