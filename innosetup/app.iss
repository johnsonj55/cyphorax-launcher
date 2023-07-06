[Setup]
AppName=Cyphorax Launcher
AppPublisher=Cyphorax
UninstallDisplayName=Cyphorax
AppVersion=${project.version}
AppSupportURL=https://www.cyphorax.com/
DefaultDirName={localappdata}\Cyphorax

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x64
PrivilegesRequired=lowest

WizardSmallImageFile=${basedir}/app_small.bmp
WizardImageFile=${basedir}/left.bmp
SetupIconFile=${basedir}/app.ico
UninstallDisplayIcon={app}\Cyphorax.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${basedir}
OutputBaseFilename=CyphoraxSetup64

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${basedir}\app.ico"; DestDir: "{app}"
Source: "${basedir}\left.bmp"; DestDir: "{app}"
Source: "${basedir}\app_small.bmp"; DestDir: "{app}"
Source: "${basedir}\native-win64\Cyphorax.exe"; DestDir: "{app}"
Source: "${basedir}\native-win64\Cyphorax.jar"; DestDir: "{app}"
Source: "${basedir}\native\build64\Release\launcher_amd64.dll"; DestDir: "{app}"
Source: "${basedir}\native-win64\config.json"; DestDir: "{app}"
Source: "${basedir}\native-win64\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\Cyphorax"; Filename: "{app}\Cyphorax.exe"
Name: "{userdesktop}\Cyphorax"; Filename: "{app}\Cyphorax.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Cyphorax.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Cyphorax.exe"; Description: "&Open Cyphorax"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.cyphorax\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Code]
#include "upgrade.pas"