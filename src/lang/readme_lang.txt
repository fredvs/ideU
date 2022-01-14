To add a new language, use a copy of ideu_empty.po and fill it with the translation.

When done, rename it with the code of your language after the "_" , like ideu_xz.po.

You may also add the translation of the new language name at end of each .po file (not obligatory).

Example add this at end of ideu_xz.po:

msgid "Mytranslatedlanguage [xz]"
msgstr "Mylanguage [xz]"

When your po file is ready, just add it into /ideu/lang/folder.
It will be available via the menu Settings-Language.

The .po file is loaded after each menu Settings-Language so you may change the content of the .po when you want.