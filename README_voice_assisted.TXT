To run ideU with voice assisted from terminal, use the -va parameter.

For Unix system: (The last character of ideU is a U majuscule)
# /directory/of/ideU/ideU -va

For Windows system:
#  C:\directory\of\ideU\ideU.exe -va

The first time you run ideU, a welcome project will be loaded and the setting form will appear.
Using the arrow up/down keys, you may check the path of fpc compiler.
When all is ok, use Alt+O key to save and close the form and then Alt+F+X to close ideU.

There is a voice assisted "Hello World" demo.

To load it on Unix system:
# /directory/of/ideU/ideU -va /directory/of/ideU/demos/voiceassist/helloworld/helloworld.prj

To load it on Windows system:
# C:\directory\of\ideU\ideU.exe -va C:\directory\of\ideU\demos\voiceassist\helloworld\helloworld.prj

You may use Alt+Tab key to navigate between forms.

For this project there will be:

- The main menu form. Each menu-item is accessible by Alt + some key. (up/down keys allowed for sub-menu).
- The source-code editor. (accessible too with Alt+V+U key)
- The messages from the compiler. (accessible too with Alt+V+M key)
- The target console. (accessible too with Alt+V+T key)
- The commandor with buttons. (accessible too with Alt+V+D key)

To navigate inside a form, use the Left/Right/Up/Down/Tab keys.
To navigate inside a combobox, use Alt+Down key, then Up/Down key.

You may use also the mouse.
On each new focus, the position of the cursor will be said.
 
To configure the directory of the compiler and other stuff, use Alt+I+G.
It is the main setting form. (Alt+O key to save and close the form.)

To compile-run the program use the F9 key.

To listen to the comments of the compiler, use the message form and navigate with Up/Down keys.

To listen to the result of the program, use the target console form and navigate with Up/Down keys.

PS: For Windows users: to reset the config to default, delete the folders:

C:\Users\You_User\AppData\Local\ideU
and
C:\Users\Fred\AppData\Roaming\.ideu

Fre;D

Fre;D








