
# Simple script to manually build an installer for exe
# Make sure to adjust version and location of the Inno Setup exe
$Version = "1.0.2"
$InnoExe = "D:\Programme\Inno Setup 6\ISCC.exe"

& $InnoExe "/DAppVersion=$Version" "setup.iss"
