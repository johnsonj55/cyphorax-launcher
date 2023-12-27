[Setup]
AppName=X Launcher
AppPublisher=X
UninstallDisplayName=X
AppVersion=${project.version}
AppSupportURL=https://www.xrsps.com/
DefaultDirName={localappdata}\X

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x64
PrivilegesRequired=lowest

WizardSmallImageFile=${basedir}/app_small.bmp
WizardImageFile=${basedir}/left.bmp
SetupIconFile=${basedir}/app.ico
UninstallDisplayIcon={app}\X.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${basedir}
OutputBaseFilename=XSetup64

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${basedir}\app.ico"; DestDir: "{app}"
Source: "${basedir}\left.bmp"; DestDir: "{app}"
Source: "${basedir}\app_small.bmp"; DestDir: "{app}"
Source: "${basedir}\native-win64\X.exe"; DestDir: "{app}"
Source: "${basedir}\native-win64\X.jar"; DestDir: "{app}"
Source: "${basedir}\native\build64\Release\launcher_amd64.dll"; DestDir: "{app}"
Source: "${basedir}\native-win64\config.json"; DestDir: "{app}"
Source: "${basedir}\native-win64\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\X"; Filename: "{app}\X.exe"
Name: "{userdesktop}\X"; Filename: "{app}\X.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\X.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\X.exe"; Description: "&Open X"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.XNew\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Code]
#include "upgrade.pas"