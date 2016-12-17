To run ideU with voice assisted from terminal, use the -va parameter.

For Unix system: (The last character of ideU is a U majuscule)
# /directory/of/ideU/ideU -va

For Windows system:
#  C:\directory\of\ideU\ideU.exe -va

The first time you run ideU the setting form will appear focused on the path tab.
Using the arrow up/down keys, you may check the path of fpc compiler and debugger.

For navigating to other setting tab:
- Alt+P : Path tab.
- Alt+M : Macros tab.
- Alt+S : Shortcut tab.
- Alt+T : Other tab.

For beginning, check only the path tab.

Later you may configure the shortcuts: Alt+S to select the shortcut tab then with the down key, select the shortcut button. Press Enter key.
The shortcut window will be activated.
Use the up/down key to select a action and then the right key to assign a shortcut to that action. Just after that, choose a combination of Alt or Ctrl + the wanted key. Go back to a other action with Up key. Use Alt+O to close the shortcut form.

When all is ok in configuration, use Alt+O key to save and close the setting form and then Alt+F+X to close ideU.

There is a voice assisted "Hello World" demo. 

To load it on Unix system:
# /directory/of/ideU/ideU -va /directory/of/ideU/demos/voiceassist/helloworld/helloworld.prj

To load it on Windows system:
# C:\directory\of\ideU\ideU.exe -va C:\directory\of\ideU\demos\voiceassist\helloworld\helloworld.prj

You may use Alt+Tab key to navigate between forms.

For this project there will be:

- The main menu form. Each menu-item is accessible by Alt + some key. (Up/Down keys allowed for sub-menu).
- The source-code editor. (accessible too with Alt+V+U key)
- The messages from the compiler. (accessible too with Alt+V+M key)
- The target console. (accessible too with Alt+V+T key)
- The commandor with buttons. (accessible too with Alt+V+D key)

To navigate inside a form, use the Left/Right/Up/Down/Tab keys.
To navigate inside a combobox, use Alt+Down key, then Up/Down key.

You may also use the mouse.
On each new focus, the position of the cursor will be said.
 
To configure the directory of the compiler and other stuff, use Alt+I+G key.
It is the main setting form. Use the Tab key to navigate,
Alt+O key to save and close, Alt+C to cancel and close.

To read-edit the code use the source-code editor (Alt+V+U key).
 
To compile the program use the F9 key.

To listen to the comments of the compiler, use the message form (Alt+V+M key) and navigate with Up/Down keys.

To run the program use the F9 key again.

To listen to the result of the program, use the target console form (Alt+V+T key) and navigate with Up/Down keys.

Fre;D
