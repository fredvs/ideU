{ MSEgui Copyright (c) 1999-2018 by Martin Schreiber

    See the file COPYING.MSE, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

    French translation by Fabrice Michel Bouillerot.
    UTF-8 Accented french characters

    &#0192;  A grave
    &#0194;  A circumflex
    &#0196;  A diaresis
    &#0198;  AE Aesh Ash
    &#0200;  E grave
    &#0203;  E diaresis
    &#0201;  E acute
    &#0202;  E circumflex
    &#0203;  E diaresis
    &#0206;  I circumflex
    &#0207;  I diaresis
    &#0212;  O circumflex
    &#0214;  O diaresis
    &#0217;  U grave
    &#0219;  U circumflex
    &#0220;  U diaresis
    &#0224;  a grave
    &#0226;  a circumflex
    &#0228;  a diaresis
    &#0230;  aesc ash
    &#0232;  e grave
    &#0233;  e acute
    &#0234;  e circumflex
    &#0235;  e diaresis
    &#0238;  i circumflex
    &#0239;  i diaresis
    &#0244;  o circumflex
    &#0246;  o diaresis
    &#0249;  u grave
    &#0251;  u circumflex
    &#0252;  u diaresis
    &#0255;  y diaresis
    &#0338;  OE ethel
    &#0339;  oe ethel
    &#0376;  Y diaresis

    &#8217; apostrophe
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
  mseformatstr;

const
  fr_modalresulttext: defaultmodalresulttextty =
    ('',               //mr_none
    '',                //mr_canclose
    '',                //mr_windowclosed
    '',                //mr_windowdestroyed
    '',                //mr_escape
    '',                //mr_f10
    '',                //mr_exception
    '&Annuler',        //mr_cancel
    '&Arr'#0234'ter',  //mr_abort
    '&Valider',        //mr_ok
    '&Oui',            //mr_yes
    '&Non',            //mr_no
    '&Tout',           //mr_all
    'Oui &tout',       //mr_yesall
    'A&ucun',          //mr_noall
    '&Ignorer',        //mr_ignore
    '&Passer',         //mr_skip
    'Passer &tout',    //mr_skipall
    'Co&ntinuer'       //mr_continue
    );

  fr_modalresulttextnoshortcut: defaultmodalresulttextty =
    ('',             //mr_none
    '',              //mr_canclose
    '',              //mr_windowclosed
    '',              //mr_windowdestroyed
    '',              //mr_escape
    '',              //mr_f10
    '',              //mr_exception
    'Annuler',       //mr_cancel
    'Arr'#0234'ter', //mr_abort
    'Valider',       //mr_ok
    'Oui',           //mr_yes
    'Non',           //mr_no
    'Tout',          //mr_all
    'Oui tout',      //mr_yesall
    'Aucun',         //mr_noall
    'Ignorer',       //mr_ignore
    'Passer',        //mr_skip
    'Passer tout',   //mr_skipall
    'Continuer'      //mr_continue
    );

  fr_projectoptionscontext: projectoptionsconaty = (
     'Un encodage incorrect peut endommager vos fichiers sources.',
     'Voulez-vous définir l'#08217'encodage sur ',
     '*** ATTENTION ***',
     'Raccrocher',
     'Interrompre',
     'Quitter',
     'Instruction illégale',
     'Trace piège',
     'Annuler',
     'Erreur BUS',
     'Exception à virgule flottante',
     'Tuer',
     'Signal défini par l'#08217'utilisateur 1',
     'Violation de segmentation',
     'Signal défini par l'#08217'utilisateur 2',
     'Tuyau cassé',
     'Réveil',
     'Résiliation',
     'Faute de pile',
     'Le statut de l'#08217'enfant a changé',
     'Continuer',
     'Stop, imblocable',
     'Arrêt du clavier',
     'Contexte lu à partir du tty',
     'Écrire en arrière-plan sur tty',
     'État urgent sur la prise',
     'Limite du processeur dépassée',
     'Limite de taille de fichier dépassée',
     'Réveil virtuel',
     'Profilage réveil',
     'Changement de taille de fenêtre',
     'E/S maintenant possible',
     'Redémarrage panne de courant'    );

  fr_actionsmoduletext: actionsmoduleaty = (
    'Configurer ideU',
    'Identifiant de processus',
    'Joindre au processus',
    'Classe de module inconnue pour "',
    'Composant hérité "',
    '" ne peut pas être supprimé.',
    'ERREUR',
    'Faire avorter.',
    'Téléchargement interrompu.',
    'Erreur d'#08217'exécution avec "',
    'Erreur : délai d'#08217'attente.',
    'Fabrication de ',
    'Ne pas courir.',
    'Téléchargement.',
    'Le téléchargement ne fonctionne pas.',
    '" fonctionnement.',
    'Scénario',
    'Héritage de forme récursive de "',
    'Composant "',
    '" existe.',
    'Ancêtre de "',
    '" pas trouvé.',
    'Module "',
    'Nom incorrect "',
    'Nom de méthode invalide',
    'Module non trouvé',
    'Méthode non trouvée',
    'Méthode publiée (gérée)',
    'n'#08217'existe pas.',
    'Voulez-vous supprimer l'#08217'événement ?',
    'ATTENTION',
    'Méthode',
    'a des paramètres différents.',
    'Un module "',
    '" est déjà ouvert.',
    'Référence(s) non résolue(s) à',
    'Modules):',
    'Impossible de lire le fichier de formulaire "',
    'Nom de composant non valide.',
    'Exception non valide',
    'Outils',
    'Formes',
    'La source',
    'Tous les fichiers',
    'Programme MSE',
    'Unité MSE',
    'Fichier texte MSE',
    'Mainform',
    'Forme simple',
    'Formulaire d'#08217'amarrage',
    'Module de données',
    'Sous-formulaire',
    'Scrollboxform',
    'Tabform',
    'Panneau de quai',
    'Signaler',
    'Forme de script',
    'Forme héritée',
    'Voulez-vous remplacer les paramètres par',
    'Le fichier "',
    'Voulez-vous écraser ?',
    'Inconnu',
    'Erreur',
    'Commencez',
    'Exception',
    'GDB est mort',
    'Point d'#08217'arrêt atteint',
    'Point de surveillance déclenché',
    'Lire le point de surveillance déclenché',
    'Access Watchpoint déclenché',
    'Fin de plage de pas',
    'Fonction terminée',
    'Sortie normalement',
    'Sortie',
    'Détaché',
    'Signal reçu',
    'Erreur d'#08217'arrêt',
    'Impossible de lire le projet',
    'Sur',
    'Inspecteur d'#08217'objets',
    'Magasin de composants',
    'Processus de rattachement',
    'Chargement'
    );
      
  fr_mainformtext: mainformaty = (
      'Références non résolues dans',
      'à',
      'Voulez-vous rechercher le fichier de formulaire ?',
      'ATTENTION',
      'Fichier de formulaire pour',
      'Fichiers de formulaire',
      'Hiérarchie de forme récursive pour "',
      'ERREUR',
      'Type de classe',
      'pas trouvé.',
      'Projet',
      'est modifié. Sauvegarder?',
      'Confirmation',
      'Impossible d'#08217'ouvrir le fichier "',
      '*** Fonctionnement ***',
      'Téléchargement',
      'Téléchargé',
      'Démarrer la commande du serveur gdb "',
      '" fonctionnement.',
      'Démarrer le serveur gdb',
      'erreur de démarrage du serveur gdb',
      'démarrage du serveur gdb annulé.',
      'Impossible d'#08217'exécuter la commande start gdb.',
      'Télécharger la commande "',
      'Erreur de téléchargement***',
      'Téléchargement terminé.',
      'Téléchargement annulé.',
      'Déposer "',
      '" pas trouvé.',
      '" existe.',
      'Nouveau',  
      'Sélectionner l'#08217'ancêtre',
      'Nouvelle forme',
      'Pascal Fichiers',
      'nouveau', 
      'Impossible de charger le projet "',
      'Sélectionner un modèle de projet',
      'Fichiers de projet',
      'Tous les fichiers',
      'Sélectionner le fichier programme',
      'Fichiers programmes Pascal',
      'Fichiers programme C',
      'Nouveau projet',
      'Impossible de démarrer le processus',
      'Traiter',
      'fonctionnement.',
      'Processus terminé',
      'Le processus s'#08217'est terminé normalement.',
      'Compilation ***ERREUR***',
      'Compilation OK.',
      'La source a changé, voulez-vous recréer le projet ?',
      'Charger la disposition de fenêtres',
      'Zone d'#08217'amarrage'
    ); 
    
   fr_sourceformtext: sourceformaty = (
       'Le fichier "',
       '" a changé.',
       'Il y a aussi des modifications dans le tampon d'#08217'édition.',
       'Voulez-vous recharger à partir du disque ?',
       'Confirmation',
       '<aucun>',
       'Voulez-vous remplacer :',
       'avec:',
       '<nouveau>',
       'Syntaxdeffile :',
       'Texte',
       'pas trouvé.',
       'Redémarrer depuis le début du fichier ?',
       'Annuler?',
       'Voulez-vous remplacer cette occurrence ?',
       'Aller au numéro de ligne :',
       'Chercher la ligne',
       'Il y a aussi des modifications dans le tampon d'#08217'édition.' 
       
        );     

  fr_settingstext: isettingsaty          = (
    'Appliquer',          //se_apply
    'Configuration assistance-vocale sak', //se_groupassistive
    'Répertoire parent de sakit', //se_sakitdir
    'Activer sak au chargement', //se_enableassistive
    'Disposition du système', //se_groupsystemlayout
    'Répertoires universels', //se_universalpath
    'Pas de traitement ordres Z', //se_nozorder
    'Shift sélectionne le mot', //se_doubleclic
    'Autofocus dans menu principal', //se_autofocusmenu
    'Chemin complet dans titre-projet', //se_fullpath
    'Définir forme-dialogue comme modal', //se_modaldial
    'Hauteur police',     //se_fontsize
    'Nom police',         //se_fontname
    'Sans confirmation suppression ligne', //se_confirmdel
    'Caret clignotant',   //se_blinkcaret
    'Repeindre canvas',   //se_repaintcanvas
    'Éditeur de source', //se_groupsourceeditor
    'Utilisez ces options', //se_usedefaulteditoroptions
    'Espace après virgule -> auto-parsing', //se_addwhiteaftercomma
    'Quand un fichier a changé :', //se_groupfilechange
    'Sans dialogue => recharger le nouveau', //se_filereload
    'Sans dialogue => garder l'#08217'ancien', //se_filenoload
    'Un dialogue demande quoi faire...' //se_fileaskload
    );

  fr_projectoptionstext: projectoptionsaty = (
    'Options du projet',                              // po_projectoptions
    'Editeur',                                         // po_editor
    'Marge à droite',                                 // po_rightmarginline
    'Marquer les crochets',                            //  po_markbrackets
    'Numéros de ligne',                               //  po_linenumbers
    'Marquer mots paires',                             //  po_markpairwords
    'Enlever les espaces de fin'#10'lors de l'#08217'enregistrement', //  po_trimtrailing
    'Retrait automatique',                             //  po_autoindent
    'Pas d'#08217'éditeur-source',                    //  po_nosource
    'Retrait de tabulation',                           //  po_tabindent
    'Onglet Espace',                                   //  po_spacetab
    'Afficher les onglets',                            //  po_showtabs
    'Police anticrénelée',                           //  po_antialiasedfont
    'Codage',                                          //  po_encoding
    'Couleur de marque',                               //  po_markcolor 
    'Couleur de stat',                                 // po_statcolor
    'Déf. Y',                                         // po_scrollbary
    'Nb char',                                         // po_nbchar
    'Style EOL',                                       //  po_eolstyle
    'Sauver copie',                                    //  po_backup
    'Taquets',                                         //  po_tabstops
    'Retrait',                                         //  po_indent
    'Esp.X',                                           //  po_extraspace
    'Espace supplémentaire entre lignes',             //  po_extraspacehint
    'Largeur',                                         //  po_width
    'Hauteur',                                         //  po_height
    'Police',                                          //  po_font
    'Couleur fond police',                             //  po_fontbkcolor
    'Couleur police',                                  //  po_fontcolor
    'Filtre fichiers',                                 //  po_filefilter
    'Nom',                                             //  po_name
    'Masque fichier',                                  //  po_filemask
    'Fichier définition syntaxe',                     //  po_syntaxdeffile
    'Modèles de code',                                //  po_codetemplate
    'Répertoires modèles de code, extension fichier = .mct', //  po_fontcodetemplatedir
    'Sélectionnez le répertoire',                    // po_selectunitdir
    '&Débogueur',                                     // po_debuggerpage
    'Débogueur du projet',                            // po_projectdebugger
    'Rechercher dans &répertoires',                   // po_searchdirectories
    'Chemin de recherche pour obtenir des informations sur le code', // po_searchdirectorieshint
    'Sélectionnez répertoire source',                // po_selectsourcedir
    'Répertoire-base objets (vide = Créer répertoire)', // po_objectbasedir
    'Sélectionnez répertoire source',                // po_selectsourcebasedir
    'Déf&init',                                       // po_defines
    '&Signaux',                                        // po_signals
    '&Exception',                                      // po_exception
    '&Cible',                                          // po_target
    'Démarrer commande serveur gdb - attacher cible', // po_startgdbattachtarget
    'Pas attendre à la sortie',                       // po_nogdbserverexit
    'Script gdb avant connexion',                      // po_beforeconnect
    'Script gdb avant chargement',                     // po_beforeload
    'Script gdb avant exécution',                     // po_beforerun
    'Script gdb après connexion',                     // po_afterconnect
    'Script gdb après chargement',                    // po_afterload
    'Démarrer commande serveur gdb - cible-exécution', // gdbservercommand
    'Attendre avant de connecter',                     // po_gdbserverwait
    'Commencer une fois',                              // po_gdbserverstartonce
    'Commande de téléchargement',                    // po_uploadcommand
    'Processeur',                                      // po_gdbprocessor
    'Simulateur',                                      // po_gdbsimulator
    'gdb-téléchargement',                            // po_gdbdownload
    'Démarrage BKPT',                                 // po_startupbkpt
    'Connexion cible',                                 // po_remoteconnection
    'Toujours télécharger',                          // po_downloadalways
    'Toujours télécharger avant exécuter',          // po_downloadalwayshint
    'Délai de chargement',                            // po_gdbloadtimeout
    '&Console externe',                                // po_externalconsole
    '&Arrêt.Exc.',                                    // po_stoponexception
    'Arrêter sur exception',                          // po_stoponexceptionhint
    '&Acti-pause',                                     // po_activateonbreak
    'Activer en pause',                                // po_activateonbreakhint
    '&Valeur'#10'indices',                             // po_valuehints
    'Appeler GUI_DEB',                                 // po_nodebugbeginend
    'Relâchez le boutron de la souris pour arrêt de la cible. gdb plante parfois avec cette option.', // po_nodebugbeginendhint
    'Définir TT&Y',                                   // po_settty
    '&Rel/pause',                                      // po_raiseonbreak
    'Relever sur pause',                               // po_raiseonbreakhint
    '&Bogues FPC',                                     // po_fpcgdbworkaround
    'Utiliser des solutions de contournement pour les bogues FPC/gdb', // po_fpcgdbworkaroundhint
    'Cible débogage',                                 // po_debugtarget
    'Commande xterm',                                  // po_xtermcommand
    '&Exécuter commande',                             // po_runcommand
    '&Débogueur par défaut',                         // po_debugcommand
    'Options débogage',                               // po_debugoptions
    '&Créer',                                         // po_makepage

    'Créer-défaut',                                  // po_defaultmake
    'Fichier principal',                               // po_mainfile
    'Sélection du fichier principal',                 // po_selectmainfile
    'Nom cible',                                       // po_targetfile
    'Selectionner cible',                              // po_selecttargetfile
    'Compilateur-défaut',                             // po_makecommand
    'Selectionner compilateur',                        // po_selectmakecommand
    'Voir ligne de commande',                          // po_showcommandline
    'Copier Messages vers fichier',                    // po_copymessages
    'Fermer Message',                                  // po_closemessages
    'Check en-têtes',                                 // po_checkmethods
    'Vérifier les en-têtes de méthode',             // po_checkmethodshint
    'Compilateur projet',                              // po_projectcompiler
    'Commande avant',                                  // po_commandbefore
    'Options Créer',                                  // po_makeoptions
    'Répertoires',                                    // po_directories
    'Selectionner répertoires',                       // po_unitdirs
    'Commande après',                                 // po_commandafter
    'Extension exe',                                   // po_exeextension
    'Commentaires',                                    // po_comments
    'Répertoire-Créer',                              // po_makedir
    'Choisir Répertoire-Créer',                      // po_selectmakedir
    'Couleur Erreur',                                  // po_colorerror
    'Couleur Alerte',                                  // po_colorwarning
    'Couleur Note',                                    // po_colornote
    'Supprimer ESC',                                   // po_stripmessageesc
    'Supprimer les séquences ESC dans Messages et Terminal', // po_stripmessageeschint
    'Voir Console',                                    // po_showconsole
    'Usage',                                           //po_enablepurpose
    'Fichier sortie Messages',                         // po_messageoutputfile
    'Choisir fichier cible',                           // po_selectmessageoutputfile
    'Macros',                                          // po_macros
    'Groupe actif',                                    // po_selectactivegroupgrid
    'Alias-police',                                    // po_fontaliaspage
    'Designers',                                       // po_designers
    'Couleurs utilisateur',                            // po_usercolors
    'Copiez le code "setcolormapvalue" dans le presse-papiers', // po_copycolor
    'Formatter Macros',                                // po_formatmacro
    'Utilisé par formatfloatmse() et formatdatetimemse()', // po_formatmacrohint
    'Modèles',                                        // po_templates
    'Nouveau projet',                                 // po_newproject
    'Script avant copie',                              // po_scriptbeforecopy
    'Script après copie',                             // po_scriptaftercopy
    'Nouveau Fichier',                                 // po_newfile
    'Nouvelle Forme',                                  // po_newform
    'Outils',                                          // po_tools
    'Rangement',                                       // po_storage
    'Infos',                                            // po_infos
     'Nom complet du projet', // po_projectfullname
     'Créateur', // po_creator
     'Licence', // po_license
     'Date de création' // po_projectdate
     
    );

  fr_stockcaption: stockcaptionaty = (
    '',                                            //sc_none
    'est invalide',                                //sc_is_invalid
    'Erreur de format',                            //sc_Format_error
    'Valeur requise',                              //sc_Value_is_required
    'Erreur',                                      //sc_Error
    'Min.',                                        //sc_Min
    'Max.',                                        //sc_Max
    'Erreur de rang',                              //sc_Range_error

    '&D'#0233'faire',                              //sc_Undo        ///         ///
    '&Refaire',                                    //sc_Redo          //          //
    '&Copier',                                     //sc_Copy          // hotkeys  //
    'C&ouper',                                     //sc_Cut           //          //
    'Co&ller',                                     //sc_Paste         //          // hotkeys
    '&S'#0233'lectionner tout',                          //sc_Select_allhk ///          //
    '&Ins'#0233'rer ligne',                        //sc_insert_row ///           //
    '&Ajouter ligne',                              //sc_append_row   // hotkeys   //
    '&Supprimer ligne',                            //sc_delete_row  ///          ///

    'R'#0233'&p',                                  //sc_Dir               ///
    '&Racine',                                     //sc_home              //
    'Remonter',                                   //sc_Up                //
    'Nouveau rép.',                              //sc_New_dir           // hotkeys
    'Nom',                                         //sc_Name              //
    'Afficher fichiers cach'#0233's',             //sc_Show_hidden_files //
    'Filtre',                                     //sc_Filter            ///
    'Sauver',                                     //sc_save
    'Ouvrir',                                     //sc_open
    'Nom',                                         //sc_name1
    'Cr'#0233'er un nouveau r'#0233'pertoire',     //sc_create_new_directory
    'Arri'#0232're',                               //sc_back
    'Avant',                                       //sc_forward
    'Dessus',                                      //sc_up
    'Fichier',                                     //sc_file
    'existe, Remplacer ?',                         //sc_exists_overwrite
    'modifi'#0233'. Enregistrer ?',                //sc_is_modified_save
    'AVERTISSEMENT',                               //sc_warningupper
    'ERREUR',                                      //sc_errorupper
    'Exception',                                   //sc_exception
    'Syst'#0232'me',                               //sc_system
    'n'#8217'existe pas',                          //sc_does_not_exist
    'MOT DE PASSE',                                //sc_passwordupper
    'Entrer le mot de passe',                      //sc_enterpassword
    'Mot de passe invalide!',                      //sc_invalidpassword
    'Impossible de lire le r'#0233'pertoire',      //sc_can_not_read_directory
    'Format graphique non support'#0233'',         //sc_graphic_not_supported
    'Erreur de format graphique',                  //sc_graphic_format_error
    'Bitmap MS',                                   //sc_MS_Icon
    'Icone MS',                                    //sc_MS_Icon
    'Image JPEG',                                  //sc_JPEG_Image
    'Image PNG',                                   //sc_PNG_Image
    'Image XPM',                                   //sc_XPM_Image
    'Image PNM',                                   //sc_PNM_Image
    'Image TARGA',                                 //sc_TARGA_image
    'Image TIFF',                                  //sc_TIFF_image
    'Tous',                                        //sc_All
    'Confirmer',                                   //sc_Confirmation
    'Effacer l'#8217'enregistrement ?',            //sc_Delete_record_question
    'Copier l'#8217'enregistrement ?',             //sc_Copy_record_question
    'Fermer page',                                 //sc_close_page
    'Premier',                                     //sc_first
    'Pr'#0233'c'#0233'dent',                       //sc_prior
    'Suivant',                                     //sc_next
    'Dernier',                                     //sc_last
    'Ajouter',                                     //sc_append
    'Supprimer',                                   //sc_delete
    #0201'diter',                                  //sc_edit
    'Poster',                                      //sc_post
    'Annuler',                                     //sc_cancel
    'Rafra'#0238'chir',                            //sc_refresh
    #0201'dition Filtre',                          //sc_filter_filter
    #0201'dition Filtre Minimum',                  //sc_edit_filter_min
    #0201'dition Filtre Maximum',                  //sc_filter_edit_max
    'R'#0233'initialiser le filtre',               //sc_reset_filter
    'Filtre actif',                                //sc_filter_on
    'Chercher',                                    //sc_search
    #0201'dition automatique',                     //sc_autoedit
    'Copier l'#08217'enregistrement',              //sc_copy_record
    'Dialogue',                                    //sc_dialog
    'Ins'#0233'rer',                               //sc_insert
    'Copier',                                      //sc_copy
    'Coller',                                      //sc_paste
    'Ins'#0233'rer ligne',                         //sc_row_insert
    'Ajouter ligne',                               //sc_row_append
    'Supprimer ligne',                             //sc_row_delete
    'D'#0233'faire',                               //sc_undo
    'Refaire',                                     //sc_redo
    'Couper',                                      //sc_cut
    'S'#0233'lectionner tout',                     //sc_select_all
    'Filtre inactif',                              //sc_filter_off
    'Portrait',                                    //sc_portrait print orientation
    'Paysage',                                     //sc_landscape print orientation
    'Supprimer ligne ?',                           //sc_Delete_row_question
    'Lignes s'#0233'lectionn'#0233'es',            //sc_selected_rows
    'seulement un '#0233'l'#0233'ment',            //sc_Single_item_only
    'Copier cellules',                             //sc_Copy_Cells
    'Coller cellules',                             //sc_Paste_Cells
    'Fermer',                                      //sc_close
    'Maximiser',                                   //sc_maximize
    'Normaliser',                                  //sc_normalize
    'Minimiser',                                   //sc_minimize
    'Taille fixe',                                 //sc_fix_size
    'Flottant',                                    //sc_float
    'Rester en avant',                             //sc_stay_on_top
    'Rester en arri'#0232're',                     //sc_stay_in_background
    'Bloquer les descendants',                     //sc_lock_children
    'Ne pas bloquer',                              //sc_no_lock
    'Entr'#0233'e',                                //sc_input
    'Boutton',                                     //sc_button
    'Allum'#0233'',                                //sc_on
    #0201'teint',                                  //sc_off
    'Bord gauche',                                 //sc_leftborder
    'Bord haut',                                   //sc_topborder
    'Bord droit',                                  //sc_rightborder
    'Bord bas',                                    //sc_bottomborder
    'D'#0233'but du texte',                        //sc_beginoftext
    'Fin du texte',                                //sc_endoftext
    'Mode entr'#0233'e',                           //sc_inputmode
    #0201'craser',                                 //sc_overwrite
    'D'#0233'truit',                               //sc_deleted
    'Copie'#0233,                                  //sc_copied
    'Inser'#0233,                                  //sc_inserted
    'Coll'#0233,                                   //sc_pasted
    'Retir'#0233,                                  //sc_withdrawn
    'Fen'#0232'tre activ'#0233'e',                 //sc_windowactivated
    'Menu',                                        //sc_menu
    'D'#0233'but du fichier',                      //sc_bof
    'Fin du fichier',                              //sc_eof
    'Sortie voix',                                 //sc_voiceoutput
    'R'#0233'p'#0233'ter',                         //sc_speakagain
    'Premi'#0232're colonne',                      //sc_firstcol
    'Premi'#0232're ligne',                        //sc_firstrow
    'D'#0232'rni'#0232're colonne',                //sc_lastcol
    'D'#0232'rni'#0232're ligne',                  //sc_lastrow
    'S'#0233'lection',                             //sc_selection
    'Chemin de speak',                             //sc_speakpath
    'D'#0233'sactiver le boutton',                 //sc_disabledbutton
    'Premier champ',                               //sc_firstfield
    'D'#0232'rnier champ',                         //sc_lastfield
    'Premier '#0233'lement',                       //sc_firstelement
    'D'#0232'rnier '#0233'lement',                 //sc_lastelement
    'Plus lent',                                   //sc_slower
    'Plus rapide',                                 //sc_faster
    'Fen'#0232'tre',                               //sc_window
    'Aire',                                        //sc_area
    'Aire activ'#0233'e',                          //sc_areaactivated
    'Volume moins',                                //sc_volumedown
    'Volume plus',                                 //sc_volumeup
    'Annuler speech',                              //sc_cancelspeech
    'Cible',                                       //sc_target
    'Voir',                                        //sc_view
    'Formes',                                      //sc_forms
    'Disposition',                                 //sc_layout
    'Syntaxe',                                     //sc_syntax
    'Projet',                                      //sc_project
    'Edité',                                      //sc_edited
    'Widgets',                                     //sc_widgets
    'Réglages',                                   //sc_settings
    'A propos de',                                 //sc_about
    'Nouveau',                                    //sc_newfile
    'Sauver sous ...',                             //sc_saveas
    'Sauver tout',                                 //sc_saveall
    'Fermer tout',                                 //sc_closeall
    'Imprimer',                                    //sc_print
    'Quitter',                                     //sc_quit  
    'Ligne',                                       //sc_line
    'Chercher à nouveau ',                        //sc_search_again
    'Chercher en amont',                           //sc_search_back
    'Chercher et remplacer',                       //sc_find_replace
    'Chercher dans les fichiers',                  //sc_find_infile
    'Liste de procédures',                         //sc_proclist
    'Sélectionnez la page à éditer',               //sc_select_edit_Page
    'Copier le mot au curseur',                    //sc_Copy_word_cursor
    'Copier LaTeX',                                //sc_copy_latex
    'Ajouter un retrait',                          //sc_indent
    'Supprimer le retrait',                        //sc_unindent
    'Environnement',                               //sc_environment
    'Attacher le processus',                       //sc_attachprocess
    'Attacher la cible',                           //sc_attachtarget
    'Détacher la cible',                          //sc_detachtarget
    'Télécharger',                               //sc_download
    'Outils',                                      //sc_tools
    'Créer',                                      // sc_make 
    'Construire',                                  // sc_build 
    'Annuler créer',                              // sc_abortmake 
    'Déboguer/Exécuter',                         // sc_debugrun 
    'Options',                                     // sc_options 
    'Arbre',                                       // sc_tree 
    'Source',                                      // sc_source 
    'Ouvrir une copie',                            // sc_opencopy 
    'Sauver la copie sous ...',                      // sc_saveascopy 
    'Embellisseur',                                // sc_beautifier
    'Panneaux',                                    // sc_panels
    'Forcer ordre Z',                              // sc_forcezorder
    'Liste arborescente',                          // sc_treelist
    'Messages',                                    // sc_messages
    'Résultat de la recherche',                      // sc_findresult
    'Commandant',                                  // sc_commander
    'Symboles',                                    // sc_symbols
    'Vigie',                                       // sc_watches
    'Empiler',                                     // sc_stack
    'Fils',                                        // sc_threads
    'CPU',                                         // sc_cpu
    'Assembler',                                   // sc_assembler
    'Points d'#8217'arrêt',                       // sc_breakpoints
    'Points d'#8217'observation',                      // sc_watchpoints 
    'Mémoire',                                    // sc_memory
    'Console cible',                               // targetconsole 
    'Basculer forme/unité',                       // sc_toggleformunit
    'Modules MSE',                                 // sc_msemod 
    'Fermer tous les modules MSE',                 // sc_closeallmsemod
    'Réglages généraux',                        // sc_generalsettings
    'Paramètres supplémentaires',                // sc_extrasettings
    'Langues',                                     // sc_lang
    'Configurer les widgets',                      // sc_configwidgets
    'Configurer les compilateurs',                 // sc_configcompilers
    'Configurer les débogueurs',                  // sc_configdebuggers
    'Thèmes',                                     // sc_themes
    'Répertoire',                                 // sc_directory
    'Sans icones',                                 // sc_noicons
    'Sans lateral',                                // sc_themes
    'Compact',                                     // sc_compact 
    'Ouvrir le projet',                            // sc_openproject
    'Ouvrir le fichier',                           // sc_openfile
    'Chemin',                                      // sc_path
    'Autres',                                      // sc_other
    'Commande d'#8217'impression',                      // sc_printcommand
    'Raccourcis',                                  // sc_shortcut
    'Valeur',                                      // sc_value
    'Sensible à la casse',                        // sc_casesensitive
    'Sélectionné uniquement',                     // sc_selectedonly
    'Mot entier',                                  // sc_wholeword
    'Texte à trouver',                            // sc_texttofind
    'Chercher dans le fichier courant',            // sc_searchincurrentfile
    'Chercher dans les fichiers ouverts',            // sc_searchininopenfiles 
    'Chercher dans le répertoire du projet',            // sc_searchinprojectdir
    'Chercher dans les répertoires',              // sc_searchindirectories
    'Inclure les sous-répertoires',                // sc_includesubdir
    'Remplacer',                              // sc_replace
    'Remplacer tout',                          // sc_replace all
    'Remplacer par',                         // sc_replacewith
    'Invite à remplacer',                    // sc_promptonreplace
    'Palette de composants',                    // sc_componentspalette
    'Chercher des composants',                       // sc_findcomponent
     'Réinitialiser', // sc_reset
     'Pas à pas', // sc_cstep
     'Instruction pas à pas', // sc_stepinstruction
     'Instruction suivante', // sc_nextinstruction
     'Redémarrer le débogueur', // sc_restartdebugger
     'Basculer le point d'#8217'arrêt', // sc_togglebreakpoint
     'Basculer le point d'#8217'arrêt activé', // sc_tooglebreakpointenable
     'Indicateur de lignes exécutées activé/désactivé', // sc_execlinehinton
     'S'#8217'il vous plaît, compilez-le d'#8217'abord.',               // sc_compileitfirst
     'Fin',                                // sc_finish
     'Définir par défaut',                          // sc_setasdefault
     'Hôte',                                   // sc_host
     'Droits d'#8217'auteur'                          // sc_copyright
    );
    
  const
   fr_langnamestext: array of msestring = (
     'Anglais', // 0_english
     'Russe', // 1_russian
     'Français', // 2_french
     'Allemand', // 3_german
     'Espagnol',                                // 4_spanish
     'Portugais'                             //5_portuguese
     );  

function delete_n_selected_rows(const params: array of const): msestring;
begin
  with params[0] do
    if vinteger = 1 then
      Result := 'Effacer le fichier s'#0233'lectionn'#0233' ?'
    else
      Result := 'Effacer les ' + inttostrmse(vinteger) +
        ' fichiers s'#0233'lectionn'#0233's ?';
end;

const
  fr_textgenerator: defaultgeneratortextty = (
              {$ifdef FPC} @{$endif}delete_n_selected_rows //tg_delete_n_selected_rows
    );

initialization
  registerlangconsts(langnames[la_fr], @fr_langnamestext, @fr_mainformtext, @fr_sourceformtext, @fr_projectoptionscontext, @fr_actionsmoduletext,
   @fr_settingstext, @fr_projectoptionstext, @fr_stockcaption, @fr_modalresulttext,
    @fr_modalresulttextnoshortcut, @fr_textgenerator);
end.

