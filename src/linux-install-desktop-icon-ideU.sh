## Linux: Script to install icon on desktop and in menu Programming.
## Thanks to Roland Chastain.

BASENAME="ideU"
## Application full name
APP="ideU"
## Script directory
SCRDIR="$(dirname "$(readlink -f "$0")")"
## Desktop directory
DDIR="$HOME/Desktop"
## Applications menu directory
ADIR="$HOME/.local/share/applications"

echo "INFO Create desktop and menu icon"

if [ ! -d $DDIR ] ;
then
  echo "WARNING Cannot find $DDIR"
  DDIR="$HOME/Bureau"
fi

if [ -d $DDIR ] ;
then
  FILE=$DDIR/$BASENAME.desktop
  echo "INFO Create $FILE"
  cat > $FILE << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=$APP
Comment=Pascal IDE
Exec=$SCRDIR/ideU %F
Icon=$SCRDIR/ideu64.png
Path=$SCRDIR/
Terminal=false
StartupNotify=true
Categories=Application;IDE;Development;GUIDesigner;Programming;
Keywords=editor;Pascal;IDE;FreePascal;fpc;Design;Designer;
EOF
  echo "INFO Set permission"
  sudo chmod -R 777 $FILE
  echo "INFO Done"
else
  echo "ERROR Cannot find $DDIR"
  exit 0
fi

echo "INFO Copy .desktop to applications menu directory"

if [ -d $ADIR ] ;
then
  FILE1=$DDIR/$BASENAME.desktop
  FILE2=$ADIR/$BASENAME.desktop
  echo "INFO Create $FILE2"
  cp -f $FILE1 $FILE2
  echo "INFO Set permission"
  sudo chmod -R 777 $FILE2
  echo "INFO Done"
else
  echo "ERROR Cannot find $ADIR"
  exit 0
fi
