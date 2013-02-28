#!/bin/sh

Q2_PAK0_LOC="/Volumes/QUAKE2/Install/Data/baseq2/pak0.pak"
Q2_DEMO_URL="http://acmectf.com/downloads/q2-314-demo-x86.exe"
Q2_PATCH_URL="http://acmectf.com/downloads/q2-3.20-x86-full-ctf.exe"
Q2_FRUITZ_URL="http://acmectf.com/downloads/Quake%20II%20v1.1.dmg"
RESDIR="${HOME}/quake2"
STEPS="5"

mkdir -p $RESDIR
cd $RESDIR
mkdir baseq2
mkdir ctf
mkdir rogue
mkdir xatrix
mkdir action

cd /tmp
echo "----Fetching Q2 engine..."
curl -o fruitzq2.dmg $Q2_FRUITZ_URL

echo "----Installing Q2 engine..."
hdiutil attach -nobrowse fruitzq2.dmg
cp -r "/Volumes/Quake II v1.1/Quake II.app" /Applications/
cp -r "/Volumes/Quake II v1.1/Q2DedicatedServer" ${RESDIR}
cp -r "/Volumes/Quake II v1.1/into 'baseq2' folder"/* "${RESDIR}/baseq2"
cp -r "/Volumes/Quake II v1.1/into 'ctf' folder"/* "${RESDIR}/ctf"
cp -r "/Volumes/Quake II v1.1/into 'rogue' folder"/* "${RESDIR}/rogue"
cp -r "/Volumes/Quake II v1.1/into 'xatrix' folder"/* "${RESDIR}/xatrix"
cp -r "/Volumes/Quake II v1.1/into 'action' folder"/* "${RESDIR}/action"
hdiutil detach "/Volumes/Quake II v1.1"
rm fruitzq2.dmg

# echo "----Installing game resources from CD..."
# curl -o "${RESDIR}/baseq2/pak0.pak" "file://$Q2_PAK0_LOC"
echo "----Fetching demo..."
curl -O $Q2_DEMO_URL
echo "----Installing game resources from demo..."
unzip -d "q2demo" "q2-314-demo-x86.exe"
rm "q2-314-demo-x86.exe"
cp -r "q2demo/Install/Data"/* ${RESDIR}
rm -rf "q2demo"

echo "----Fetching latest game patch..."
curl -o "q2-3.20-x86-full-ctf.exe" $Q2_PATCH_URL

echo "----Installing the patch..."
unzip -d "q2patch" "q2-3.20-x86-full-ctf.exe"
rm "q2-3.20-x86-full-ctf.exe"
cp -r "q2patch"/* ${RESDIR}
rm -rf "q2patch"

echo "----Writing you a config file..."
echo "vid_fullscreen 0; _windowed_mouse 1; bind a +moveleft; bind d +moveright; bind w +forward; bind s +back" > "${RESDIR}/baseq2/config.cfg"

echo "---All done! Quake II launcher is now in your Applications folder. If it asks you where your baseq2 directory is, browse to ${RESDIR}"