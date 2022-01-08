{ MSEgui Copyright (c) 1999-2018 by Martin Schreiber

    See the file COPYING.MSE, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
} 

unit mseconsts_ide_fr;

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

fr_modalresulttext: defaultmodalresulttextty =
 (
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '&Annuler',   {&Cancel}
  '&Arrèter',   {&Abort}
  '&Valider',   {&OK}
  '&Oui',   {&Yes}
  '&Non',   {&No}
  'Oui &tout',   {Yes &all}
  'Oui &tout',   {Yes &all}
  'A&ucun',   {N&o all}
  '&Ignorer',   {&Ignore}
  '&Passer',   {&Skip}
  'Passer &tout',   {Skip a&ll}
  'Co&ntinuer'   {Co&ntinue}
 );

fr_modalresulttextnoshortcut: defaultmodalresulttextty =
 (
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  'Annuler',   {Cancel}
  'Arrèter',   {Abort}
  'Valider',   {OK}
  'Oui',   {Yes}
  'Non',   {No}
  'Oui tout',   {Yes all}
  'Oui tout',   {Yes all}
  'Aucun',   {No all}
  'Ignorer',   {Ignore}
  'Passer',   {Skip}
  'Passer tout',   {Skip all}
  'Continuer'   {Continue}
 );

fr_projectoptionscontext: projectoptionsconaty =
 (
  'Un encodage incorrect peut endommager vos fichiers sources.',   {Wrong encoding can damage your source files.}
  'Voulez-vous définir lencodage sur',   {Do you wish to set encoding to}
  '*** ATTENTION ***',   {*** WARNING ***}
  'Raccrocher',   {Hangup}
  'Interrompre',   {Interrupt}
  'Quitter',   {Quit}
  'Instruction illégale',   {Illegal instruction}
  'Trace piège',   {Trace trap}
  'Arrèter',   {Abort}
  'Erreur BUS',   {BUS error}
  'Exception à virgule flottante',   {Floating-point exception}
  'Tuer',   {Kill}
  'Signal défini par lutilisateur 1',   {User-defined signal 1}
  'Violation de segmentation',   {Segmentation violation}
  'Signal défini par lutilisateur 2',   {User-defined signal 2}
  'Tuyau cassé',   {Broken pipe}
  'Réveil',   {Alarm clock}
  'Résiliation',   {Termination}
  'Faute de pile',   {Stack fault}
  'Le statut de lenfant a changé',   {Child status has changed}
  'Continuer',   {Continue}
  'Stop imblocable',   {Stop, unblockable}
  'Arrêt du clavier',   {Keyboard stop}
  'Contexte lu à partir du tty',   {Background read from tty}
  'Écrire en arrière-plan sur tty',   {Background write to tty}
  'État urgent sur la prise',   {Urgent condition on socket}
  'Limite du processeur dépassée',   {CPU limit exceeded}
  'Limite de taille de fichier dépassée',   {File size limit exceeded}
  'Réveil virtuel',   {Virtual alarm clock}
  'Profilage réveil',   {Profiling alarm clock}
  'Changement de taille de fenêtre',   {Window size change}
  'E/S maintenant possible',   {I/O now possible}
  'Redémarrage panne de courant'   {Power failure restart}
 );

fr_actionsmoduletext: actionsmoduleaty =
 (
  'Configurer ideU',   {Configure ideU}
  'Identifiant de processus',   {Process ID}
  'Joindre au processus',   {Attach to process}
  'Classe de module inconnue pour "',   {Unknown moduleclass for "}
  'Composant hérité "',   {Inherited component "}
  '" ne peut pas être supprimé.',   {" can not be deleted.}
  'ERREUR',   {ERROR}
  'Annulation création.',   {Make aborted.}
  'Téléchargement interrompu.',   {Download aborted.}
  'Erreur dexécution avec "',   {Runerror with "}
  'Erreur : délai dattente.',   {Error: Timeout.}
  'Fabrication de',   {Making.}
  'Ne pas lancer.',   {Make not running.}
  'Téléchargement.',   {Downloading.}
  'Le téléchargement ne fonctionne pas.',   {Download not running.}
  '" fonctionnement.',   {" running.}
  'Scénario',   {Script}
  'Héritage de forme récursive de "',   {Recursive form inheritance of "}
  'Composant "',   {Component "}
  '" existe.',   {" exists.}
  'Ancêtre de "',   {Ancestor for "}
  '" pas trouvé.',   {" not found.}
  'Module "',   {Module "}
  'Nom incorrect "',   {Invalid name "}
  'Nom de méthode invalide',   {Invalid methodname}
  'Module non trouvé',   {Module not found}
  'Méthode non trouvée',   {Method not found}
  'Méthode publiée (gérée)',   {Published (managed) method}
  'nexiste pas.',   {does not exist.}
  'Voulez-vous supprimer lévénement ?',   {Do you wish to delete the event?}
  'ATTENTION',   {WARNING}
  'Méthode',   {Method}
  'a des paramètres différents.',   {has different parameters.}
  'Un module "',   {A module "}
  '" est déjà ouvert.',   {" is already open.}
  'Référence(s) non résolue(s) à',   {Unresolved reference(s) to}
  'Modules):',   {Module(s):}
  'Impossible de lire le fichier de formulaire "',   {Can not read formfile "}
  'Nom de composant non valide.',   {Invalid component name.}
  'Exception non valide',   {Invalid exception}
  'Outils',   {T&ools}
  'Formes',   {Forms}
  'La source',   {Source}
  'Tous les fichiers',   {All Files}
  'Programme MSE',   {MSE Program}
  'Unité MSE',   {MSE Unit}
  'Fichier texte MSE',   {MSE Textfile}
  'Mainform',   {Mainform}
  'Forme simple',   {Simple Form}
  'Formulaire damarrage',   {Docking Form}
  'Module de données',   {Datamodule}
  'Sous-formulaire',   {Subform}
  'Scrollboxform',   {Scrollboxform}
  'Tabform',   {Tabform}
  'Panneau de quai',   {Dockpanel}
  'Signaler',   {Report}
  'Forme de script',   {Scriptform}
  'Forme héritée',   {Inherited Form}
  'Voulez-vous remplacer les paramètres par',   {Do you want to replace the settings by}
  'Déposer "',   {File "}
  'Voulez-vous écraser ?',   {Do you want to overwrite?}
  'Inconnu',   {Unknown}
  'Erreur',   {Error}
  'Commencez',   {Startup}
  'Exception',   {Exception}
  'GDB est stoppé',   {GDB died}
  'Point darrêt atteint',   {Breakpoint hit}
  'Point de surveillance déclenché',   {Watchpoint triggered}
  'Lire le point de surveillance déclenché',   {Read Watchpoint triggered}
  'Access Watchpoint déclenché',   {Access Watchpoint triggered}
  'Fin de plage de pas',   {End stepping range}
  'Fonction terminée',   {Function finished}
  'Sortie normalement',   {Exited normally}
  'Sortie',   {Exited}
  'Détaché',   {Detached}
  'Signal reçu',   {Signal received}
  'Erreur darrêt',   {Stop error}
  'Impossible de lire le projet',   {Can not read project}
  'A propos de',   {About}
  'Inspecteur dobjets',   {Object Inspector}
  'Magasin de composants',   {Store Component}
  'Processus de rattachement',   {Attaching Process}
  'Chargement'   {Loading}
 );

fr_mainformtext: mainformaty =
 (
  'Références non résolues dans',   {Unresolved references in}
  'à',   {to}
  'Voulez-vous rechercher le fichier de formulaire ?',   {Do you wish to search the formfile?}
  'ATTENTION',   {WARNING}
  'Fichier de formulaire pour',   {Formfile for}
  'Fichiers de formulaire',   {Formfiles}
  'Hiérarchie de forme récursive pour "',   {Recursive form hierarchy for "}
  'ERREUR',   {ERROR}
  'Type de classe',   {Classtype}
  'pas trouvé.',   {not found.}
  'Projet',   {Project}
  'est modifié. Sauvegarder?',   {is modified. Save?}
  'Confirmation',   {Confirmation}
  'Impossible douvrir le fichier "',   {Unable to open file "}
  '*** Fonctionnement ***',   {*** Running ***}
  'Téléchargement',   {Downloading}
  'Téléchargé',   {Downloaded}
  'Démarrer la commande du serveur gdb "',   {Start gdb server command "}
  '" fonctionnement.',   {" running.}
  'Démarrer le serveur gdb',   {Start gdb Server}
  'erreur de démarrage du serveur gdb',   {gdb server start error}
  'démarrage du serveur gdb annulé.',   {gdb server start canceled.}
  'Impossible dexécuter la commande start gdb.',   {Can not run start gdb command.}
  'Télécharger la commande "',   {Uploadcommand "}
  'Erreur de téléchargement***',   {Download ***ERROR***}
  'Téléchargement terminé.',   {Download finished.}
  'Téléchargement annulé.',   {Download canceled.}
  'Déposer "',   {File "}
  '" pas trouvé.',   {" not found.}
  '" existe.',   {" exists.}
  'Nouveau',   {New}
  'Sélectionner lancêtre',   {Select ancestor}
  'Nouvelle forme',   {New form}
  'Pascal Fichiers',   {Pascal Files}
  'nouveau',   {new}
  'Impossible de charger le projet "',   {Can not load Project "}
  'Sélectionner un modèle de projet',   {Select project template}
  'Fichiers de projet',   {Project files}
  'Tous les fichiers',   {All files}
  'Sélectionner le fichier programme',   {Select program file}
  'Fichiers programmes Pascal',   {Pascal program files}
  'Fichiers programme C',   {C program files}
  'Nouveau projet',   {New Project}
  'Impossible de démarrer le processus',   {Can not start process}
  'Traiter',   {Process}
  'fonctionnement.',   {running.}
  'Processus terminé',   {Process terminated}
  'Le processus sest terminé normalement.',   {Process terminated normally.}
  'Compilation ***ERREUR***',   {Make ***ERROR***}
  'Compilation OK.',   {Make OK.}
  'La source a changé voulez-vous recréer le projet ?',   {Source has changed, do you wish to remake project?}
  'Charger la disposition de fenêtres',   {Load Window Layout}
  'Zone damarrage'   {Docking area}
 );

fr_sourceformtext: sourceformaty =
 (
  'Déposer "',   {File "}
  '" a changé.',   {" has changed.}
  'Il y a aussi des modifications dans le tampon dédition.',   {There are modifications in edit buffer also.}
  'Voulez-vous recharger à partir du disque ?',   {Do you wish to reload from disk?}
  'Confirmation',   {Confirmation}
  '<aucun>',   {<none>}
  'Voulez-vous remplacer :',   {Do you wish to replace:}
  'avec:',   {with:}
  '<nouveau>',   {<new>}
  'Syntaxdeffile :',   {Syntaxdeffile:}
  'Texte',   {Text}
  'pas trouvé.',   {not found.}
  'Redémarrer depuis le début du fichier ?',   {Restart from begin of file?}
  'Annuler?',   {Cancel?}
  'Voulez-vous remplacer cette occurrence ?',   {Do you wish to to replace this occurence?}
  'Aller au numéro de ligne :',   {Go to line number:}
  'Chercher la ligne',   {Find line}
  'Il y a aussi des modifications dans le tampon dédition.'   {There are modifications in edit buffer also.}
 );

fr_settingstext: isettingsaty =
 (
  'Appliquer',   {Apply}
  'Configuration assistance-vocale sak',   {sak voice assistive config}
  'Répertoire parent de sakit',   {Parent directory of sakit}
  'Activer sak au chargement',   {Enable sak assistive at loading}
  'Disposition du système',   {System layout}
  'Répertoires universels',   {Universal path layout}
  'Pas de traitement ordres Z',   {No Z order handling}
  'Shift sélectionne le mot',   {Use shift key to select a word}
  'Autofocus dans menu principal',   {Auto focus in main-menu}
  'Chemin complet dans titre-projet',   {Full path of project in window title}
  'Définir forme-dialogue comme modal',   {Set dialog-forms as modal vs as tool}
  'Hauteur police',   {Font height}
  'Nom police',   {Font name}
  'Sans confirmation suppression ligne',   {No confirmation to delete row}
  'Caret clignotant',   {Blinking caret}
  'Repeindre canvas',   {Repaint canvas}
  'Éditeur de source',   {Source Editor}
  'Utilisez ces options',   {Use those options instead of project options}
  'Espace après virgule -> auto-parsing',   {Add space after comma -> auto-parsing}
  'Quand un fichier a changé :',   {When a file has changed}
  'Sans dialogue => recharger le nouveau',   {No dialog box => reload the new one}
  'Sans dialogue => garder lancien',   {No dialog box => keep the old one}
  'Un dialogue demande quoi faire...',   {A dialog box ask what to do...}
  'Rectangle autour de sélection multiple'   {Rectangle around multi-select}
 );

fr_projectoptionstext: projectoptionsaty =
 (
  'Options du projet',   {Project options}
  'Editeur',   {Editor}
  'Marge à droite',   {Right margin line}
  'Marquer les crochets',   {Mark Brackets}
  'Numéros de ligne',   {Line Numbers}
  'Marquer mots paires',   {Mark Pairwords}
  'Enlever les espaces de fin lors de lenregistrement',   {Trim trailing whitespace on save}
  'Retrait automatique',   {Auto Indent}
  'Pas déditeur-source',   {No Source Editor}
  'Retrait de tabulation',   {Tab indent}
  'Onglet Espace',   {Space tab}
  'Afficher les onglets',   {Show tabs}
  'Police anticrénelée',   {Anti aliased font}
  'Codage',   {Encoding}
  'Couleur de marque',   {Mark Color}
  'Couleur de stat',   {Stat Color}
  'Déf. Y',   {Scr Y}
  'Nb char',   {Nb char}
  'Style EOL',   {EOL Style}
  'Sauver copie',   {Backup}
  'Taquets',   {Tabstops}
  'Retrait',   {Indent}
  'Esp.X',   {ExtS}
  'Espace supplémentaire entre lignes',   {Extra space between lines}
  'Largeur',   {Width}
  'Hauteur',   {Height}
  'Police',   {Font}
  'Couleur fond police',   {Font Bk. color}
  'Couleur police',   {Font color}
  'Filtre fichiers',   {File filter}
  'Nom',   {Name}
  'Masque fichier',   {File mask}
  'Fichier définition syntaxe',   {Syntax definition file}
  'Modèles de code',   {Code Templates}
  'Répertoires modèles de code extension fichier = .mct',   {Code template directories, file extension = .mct}
  'Sélectionnez le répertoire',   {Select unit directory}
  '&Débogueur',   {&Debugger}
  'Débogueur du projet',   {Project Debugger}
  'Rechercher dans &répertoires',   {Search &Directories}
  'Chemin de recherche pour obtenir des informations sur le code',   {Search path to get infos about code}
  'Sélectionnez répertoire source',   {Select source directory}
  'Répertoire-base objets (vide = Créer répertoire)',   {Object &Base Directory (empty = Make Directory)}
  'Sélectionnez répertoire source',   {Select source base directory}
  'Déf&init',   {Defi&nes}
  '&Signaux',   {&Signals}
  '&Exception',   {&Exception}
  '&Cible',   {&Target}
  'Démarrer commande serveur gdb - attacher cible',   {Start gdb server command attach target}
  'Pas attendre à la sortie',   {No wait for exit}
  'Script gdb avant connexion',   {Before connect gdb script}
  'Script gdb avant chargement',   {Before load gdb script}
  'Script gdb avant exécution',   {Before run gdb script}
  'Script gdb après connexion',   {After connect gdb script}
  'Script gdb après chargement',   {After load gdb script}
  'Démarrer commande serveur gdb - cible-exécution',   {Start gdb server command run target}
  'Attendre avant de connecter',   {Wait before connect}
  'Commencer une fois',   {Start once}
  'Commande de téléchargement',   {Download command}
  'Processeur',   {Processor}
  'Simulateur',   {Simulator}
  'gdb-téléchargement',   {gdb download}
  'Démarrage BKPT',   {Startup BKPT}
  'Connexion cible',   {Target connection}
  'Toujours télécharger',   {Always download}
  'Toujours télécharger avant exécuter',   {Always download before run}
  'Délai de chargement',   {Load Timeout}
  '&Console externe',   {&Extern Console}
  '&Arrêt.Exc.',   {&Stop on Exc}
  'Arrêter sur exception',   {Stop on exceptions}
  '&Acti-pause',   {&Acti-Break}
  'Activer en pause',   {Activate on Break}
  '&Valeur indices',   {&Value Hints}
  'Appeler GUI_DEB',   {Call GUI_DEB}
  'Relâchez le boutron de la souris pour arrêt de la cible. gdb plante parfois avec cette option.',   {Release mouse grab by target stop. gdb sometimes crashes with this option.}
  'Définir TT&Y',   {Set TT&Y}
  '&Rel/pause',   {&Raise-Break}
  'Relever sur pause',   {Raise on break}
  '&Bogues FPC',   {&FPC bugs}
  'Utiliser des solutions de contournement pour les bogues FPC/gdb',   {Use workarounds for FPC/gdb bugs}
  'Cible débogage',   {Debug &target}
  'Commande xterm',   {xterm command}
  '&Exécuter commande',   {Run command}
  '&Débogueur par défaut',   {Default Debugger}
  'Options débogage',   {Debug &options}
  '&Créer',   {&Make}
  'Créer-défaut',   {Default make col}
  'Fichier principal',   {Mainfile}
  'Sélection du fichier principal',   {Select mainfile}
  'Nom cible',   {Targetfile name}
  'Selectionner cible',   {Select target file}
  'Compilateur-défaut',   {Default Compiler}
  'Selectionner compilateur',   {Select make command}
  'Voir ligne de commande',   {Show Command Line}
  'Copier Messages vers fichier',   {Copy messages to file}
  'Fermer Message',   {Close message}
  'Check en-têtes',   {Check head}
  'Vérifier les en-têtes de méthode',   {Check method headers}
  'Compilateur projet',   {Project Compiler}
  'Commande avant',   {Command before}
  'Options Créer',   {Make options}
  'Répertoires',   {Directories}
  'Sélectionnez le répertoire',   {Select unit directory}
  'Commande après',   {Command after}
  'Extension exe',   {Exe Extension}
  'Commentaires',   {Comments}
  'Répertoire-Créer',   {Make Directory}
  'Choisir Répertoire-Créer',   {Select make directory}
  'Couleur Erreur',   {Error Color}
  'Couleur Alerte',   {Warning Color}
  'Couleur Note',   {Note Color}
  'Supprimer ESC',   {Strip ESC}
  'Supprimer les séquences ESC dans Messages et Terminal',   {Strip ESC sequences in Messages and Terminal form}
  'Voir Console',   {Show Console}
  'Usage',   {Purpose}
  'Fichier sortie Messages',   {Message output file}
  'Selectionner cible',   {Select target file}
  'Macros',   {Macros}
  'Groupe actif',   {Active group}
  'Alias-police',   {&Font Alias}
  'Designers',   {Designers}
  'Couleurs utilisateur',   {User &Colors}
  'Copiez le code "setcolormapvalue" dans le presse-papiers',   {Copy "setcolormapvalue" code to clipboard}
  'Formatter Macros',   {F&ormat Macros}
  'Utilisé par formatfloatmse() et formatdatetimemse()',   {Used by formatfloatmse() and formatdatetimemse()}
  'Modèles',   {Templates}
  'Nouveau projet',   {New project}
  'Script avant copie',   {Script before copy}
  'Script après copie',   {Script after copy}
  'Nouveau Fichier',   {New File}
  'Nouvelle Forme',   {New Form}
  'Outils',   {Tools}
  'Rangement',   {Storage}
  'Infos',   {Infos}
  'Nom complet du projet',   {Full name of project}
  'Créateur',   {Creator}
  'Licence',   {License}
  'Date de création'   {Date of creation}
 );

fr_stockcaption: stockcaptionaty =
(
  '',   {}
  'est invalide',   {is invalid}
  'Erreur de format',   {Format error}
  'Valeur requise',   {Value is required}
  'Erreur',   {Error}
  'Min.',   {Min}
  'Max.',   {Max}
  'Erreur de rang',   {Range error}
  '&Défaire',   {&Undo}
  '&Refaire',   {&Redo}
  '&Copier',   {&Copy}
  'C&ouper',   {Cu&t}
  'Co&ller',   {&Paste}
  '&Sélectionner tout',   {Select &all}
  '&Insérer ligne',   {&Insert Row}
  '&Ajouter ligne',   {&Append Row}
  '&Supprimer ligne',   {&Delete Row}
  'Ré&p',   {&Dir}
  '&Racine',   {&Home}
  'Remonter',   {&Up}
  'Nouveau rép.',   {&New}
  'Nom',   {&Name}
  'Afficher fichiers cachés',   {&Show hidden files}
  'Filtre',   {&Filter}
  'Sauver',   {Save}
  'Ouvrir',   {Open}
  'Nom',   {Name}
  'Créer un nouveau répertoire',   {Create new directory}
  'Arrière',   {Back}
  'Avant',   {Forward}
  'Dessus',   {Up}
  'Fichier',   {File}
  'existe Remplacer ?',   {exists, do you want to overwrite?}
  'est modifié. Sauvegarder?',   {is modified. Save?}
  'ATTENTION',   {WARNING}
  'ERREUR',   {ERROR}
  'Exception',   {Exception}
  'Système',   {System}
  'nexiste pas',   {does not exist}
  'MOT DE PASSE',   {PASSWORD}
  'Entrer le mot de passe',   {Enter password}
  'Mot de passe invalide!',   {Invalid password!}
  'Impossible de lire le répertoire',   {Can not read directory}
  'Format graphique non supporté',   {Graphic format not supported}
  'Erreur de format graphique',   {Graphic format error}
  'Bitmap MS',   {MS Bitmap}
  'Icone MS',   {MS Icon}
  'Image JPEG',   {JPEG Image}
  'Image PNG',   {PNG Image}
  'Image XPM',   {XPM Image}
  'Image PNM',   {PNM Image}
  'Image TARGA',   {TARGA Image}
  'Image TIFF',   {TIFF Image}
  'Tous',   {All}
  'Confirmation',   {Confirmation}
  'Effacer lenregistrement ?',   {Delete record?}
  'Copier lenregistrement ?',   {Copy record?}
  'Fermer page',   {Close page}
  'Premier',   {First}
  'Précédent',   {Prior}
  'Suivant',   {Next}
  'Dernier',   {Last}
  'Ajouter',   {Append}
  'Supprimer',   {Delete}
  'Editer',   {Edit}
  'Poster',   {Post}
  'Annuler',   {Cancel}
  'Rafraîchir',   {Refresh}
  'Edition Filtre',   {Edit filter}
  'Edition Filtre Minimum',   {Edit filter minimum}
  'Edition Filtre Maximum',   {Edit filter maximum}
  'Réinitialiser le filtre',   {Reset filter}
  'Filtre actif',   {Filter on}
  'Chercher',   {Search}
  'Edition automatique',   {Auto edit}
  'Copier lenregistrement',   {Copy record}
  'Dialogue',   {Dialog}
  'Insérer',   {Insert}
  'Copier',   {Copy}
  'Coller',   {Paste}
  'Insérer ligne',   {Row insert}
  'Ajouter ligne',   {Row append}
  'Supprimer ligne',   {Row delete}
  'Défaire',   {Undo}
  'Refaire',   {Redo}
  'Couper',   {Cut}
  'Sélectionner tout',   {Select all}
  'Filtre inactif',   {Filter off}
  'Portrait',   {Portrait}
  'Paysage',   {Landscape}
  'Supprimer ligne ?',   {Delete row?}
  'Lignes sélectionnées',   {selected rows?}
  'seulement un élément',   {Single item only}
  'Copier cellules',   {Copy Cells}
  'Coller cellules',   {Paste Cells}
  'Fermer',   {Close}
  'Maximiser',   {Maximize}
  'Normaliser',   {Normalize}
  'Minimiser',   {Minimize}
  'Taille fixe',   {Fix size}
  'Flottant',   {Float}
  'Rester en avant',   {Stay on top}
  'Rester en arrière',   {Stay in background}
  'Bloquer les descendants',   {Lock children}
  'Ne pas bloquer',   {No lock}
  'Entrée',   {Input}
  'Boutton',   {Button}
  'Allumé',   {On}
  'Eteint',   {Off}
  'Bord gauche',   {Left border}
  'Bord haut',   {Top border}
  'Bord droit',   {Right border}
  'Bord bas',   {Bottom border}
  'Début du texte',   {Begin of text}
  'Fin du texte',   {End of text}
  'Mode entrée',   {Inputmode}
  'Ecraser',   {Overwrite}
  'Détruit',   {Deleted}
  'Copié',   {Copied}
  'Inseré',   {Inserted}
  'Collé',   {Pasted}
  'Retiré',   {Withdrawn}
  'Fenêtre activée',   {Window activated}
  'Menu',   {Menu}
  'Début du fichier',   {Beginning of file}
  'Fin du fichier',   {End of file}
  'Sortie voix',   {Voice output}
  'Répéter',   {Speak again}
  'Première colonne',   {First column}
  'Première ligne',   {First row}
  'Dèrnière colonne',   {Last column}
  'Dèrnière ligne',   {Last row}
  'Sélection',   {Selection}
  'Chemin de speak',   {Speak path}
  'Désactiver le boutton',   {Disabled button}
  'Premier champ',   {First field}
  'Dèrnier champ',   {Last field}
  'Premier élement',   {First element}
  'Dèrnier élement',   {Last element}
  'Plus lent',   {Slower}
  'Plus rapide',   {Faster}
  'Fenêtre',   {Window}
  'Aire',   {Area}
  'Aire activée',   {Area activated}
  'Volume moins',   {Volume down}
  'Volume plus',   {Volume up}
  'Annuler speech',   {Cancel speech}
  'Cible',   {Target}
  'Voir',   {View}
  'Formes',   {Forms}
  'Disposition',   {Layout}
  'Syntaxe',   {Syntax}
  'Projet',   {Project}
  'Edité',   {Edited}
  'Widgets',   {Widgets}
  'Réglages',   {Settings}
  'A propos de',   {About}
  'Nouveau',   {New}
  'Sauver sous ...',   {Save as...}
  'Sauver tout',   {Save all}
  'Fermer tout',   {Close all}
  'Imprimer',   {Print}
  'Quitter',   {Quit}
  'Ligne',   {Line}
  'Chercher à nouveau',   {Search again}
  'Chercher en amont',   {Search back}
  'Chercher et remplacer',   {Find & replace}
  'Chercher dans les fichiers',   {Find in files}
  'Liste de procédures',   {Procedures list}
  'Sélectionnez la page à éditer',   {Select edit page}
  'Copier le mot au curseur',   {Copy word at cursor}
  'Copier LaTeX',   {Copy LaTeX}
  'Retrait',   {Indent}
  'Supprimer le retrait',   {Unindent}
  'Environnement',   {Environment}
  'Attacher le processus',   {Attach process}
  'Attacher la cible',   {Attach target}
  'Détacher la cible',   {Detach target}
  'Télécharger',   {Download}
  'Outils',   {Tools}
  'Créer',   {Make}
  'Construire',   {Build}
  'Annuler créer',   {Abort make}
  'Déboguer/Exécuter',   {Debug-Run}
  'Options',   {Options}
  'Arbre',   {Tree}
  'La source',   {Source}
  'Ouvrir une copie',   {Open copy}
  'Sauver la copie sous ...',   {Save copy as}
  'Embellisseur',   {Beautifier}
  'Panneaux',   {Panels}
  'Forcer ordre Z',   {Force Z order}
  'Liste arborescente',   {Tree list}
  'Messages',   {Messages}
  'Résultat de la recherche',   {Find result}
  'Commandant',   {Commander}
  'Symboles',   {Symbols}
  'Vigie',   {Watches}
  'Empilage',   {Stack}
  'Fils',   {Threads}
  'CPU',   {CPU}
  'Assembler',   {Assembler}
  'Points darrêt',   {Breakpoints}
  'Points dobservation',   {Watchpoints}
  'Mémoire',   {Memory}
  'Console cible',   {Target console}
  'Basculer forme/unité',   {Toggle form/unit}
  'Modules MSE',   {MSE modules}
  'Fermer tous les modules MSE',   {Close all MSE modules}
  'Réglages généraux',   {General settings}
  'Paramètres supplémentaires',   {Extra settings}
  'Langues',   {Languages}
  'Configurer les widgets',   {Configure widgets}
  'Configurer les compilateurs',   {Configure compilers}
  'Configurer les débogueurs',   {Configure debuggers}
  'Thèmes',   {Themes}
  'Répertoire',   {Directory}
  'Sans icones',   {No icons}
  'Sans lateral',   {No lateral}
  'Compact',   {Compact}
  'Ouvrir le projet',   {Open project}
  'Ouvrir le fichier',   {Open file}
  'Chemin',   {Path}
  'Autres',   {Other}
  'Commande dimpression',   {Print command}
  'Raccourcis',   {Shortcut}
  'Valeur',   {Value}
  'Sensible à la casse',   {Case sensitive}
  'Sélectionné uniquement',   {Selected only}
  'Mot entier',   {Whole word}
  'Texte à trouver',   {Text to find}
  'Chercher dans le fichier courant',   {Search in current file}
  'Chercher dans les fichiers ouverts',   {Search in open files}
  'Chercher dans le répertoire du projet',   {Search in project directory}
  'Chercher dans les répertoires',   {Search in directories}
  'Inclure les sous-répertoires',   {Include subdirectories}
  'Remplacer',   {Replace}
  'Remplacer tout',   {Replace all}
  'Remplacer par',   {Replace with}
  'Invite à remplacer',   {Prompt on replace}
  'Palette de composants',   {Components palette}
  'Chercher des composants',   {Find components}
  'Réinitialiser',   {Reset}
  'Pas à pas',   {Step}
  'Instruction pas à pas',   {Step instruction}
  'Instruction suivante',   {Next instruction}
  'Redémarrer le débogueur',   {Restart debugger}
  'Basculer le point darrêt',   {Toggle breakpoint}
  'Basculer le point darrêt activé',   {Toggle breakpoint enabled}
  'Indicateur de lignes exécutées activé/désactivé',   {Executed lines hint on/off}
  'Sil vous plaît compilez-le dabord.',   {Please compile it first.}
  'Fin',   {Finish}
  'Définir par défaut',   {Set as default}
  'Hôte',   {Host}
  'Droits dauteur'   {Copyright}
 );

fr_langnamestext: array[0..5] of msestring =
(
  'Anglais',   {English}
  'Russe',   {Russian}
  'Français',   {French}
  'Allemand',   {German}
  'Espagnol',   {Spanish}
  'Portugais'   {Portuguese}
 );

fr_extendedtext: extendedaty =
(
  'Effacer le fichier sélectionné ?',   {Delete selected row?}
  'Effacer les %s fichiers sélectionnés ?'   {Delete %s selected rows?}
 );

function delete_n_selected_rows(const params: array of const): msestring;
begin
  with params[0] do
    if vinteger = 1 then
      Result := fr_extendedtext[ex_del_row_selected]
    else
      Result := StringReplace(fr_extendedtext[ex_del_rows_selected], #37#115, inttostrmse(vinteger), [rfReplaceAll]);
end;

const
fr_textgenerator: defaultgeneratortextty = (
 {$ifdef FPC} @{$endif}delete_n_selected_rows);

initialization

registerlangconsts(langnames[la_fr], @fr_langnamestext, @fr_extendedtext, @fr_mainformtext, @fr_sourceformtext,
                   @fr_projectoptionscontext, @fr_actionsmoduletext, @fr_settingstext, @fr_projectoptionstext,
                   @fr_stockcaption, @fr_modalresulttext, @fr_modalresulttextnoshortcut, @fr_textgenerator);

end.

