#!/bin/bash

BUILD_DIR=`pwd`
OUT_DIR=$BUILD_DIR/.build
RUN_DIR=~/.pcgeos
RESPONSE_FILE=$OUT_DIR/geoworks.resp

export WATCOM=~/.watcom

# Get OpenWatcom
if [ ! -d $WATCOM ]
then
  echo "Downloading watcom compiler for linux..."
  mkdir $WATCOM
  mkdir _out
  pushd $WATCOM
  wget https://github.com/open-watcom/open-watcom-v2/releases/download/Current-build/ow-snapshot.tar.gz
  tar -zxf ow-snapshot.tar.gz
  rm ow-snapshot.tar.gz
  popd
fi

mkdir -p $OUT_DIR

# Compile FreeGEOS
export PATH=$PATH:$WATCOM/binl64:$BUILD_DIR/bin
export ROOT_DIR=$BUILD_DIR
export LOCAL_ROOT=$OUT_DIR
cd $BUILD_DIR/Tools/pmake/pmake
wmake install
cd $BUILD_DIR/Installed/Tools
pmake install
cd $BUILD_DIR/Installed
pmake | tee $OUT_DIR/_build.log | grep -i -v "esp \|goc \|wcc \|wcc32 \|warning\|watcom"
cd $BUILD_DIR/Tools/build/product/bbxensem/Scripts
echo pc >$RESPONSE_FILE
echo y >>$RESPONSE_FILE
echo n >>$RESPONSE_FILE
echo y >>$RESPONSE_FILE
echo n >>$RESPONSE_FILE
echo $OUT_DIR >> $RESPONSE_FILE
perl -I. buildbbx.pl  <$RESPONSE_FILE

# Move ensamble directory with the compiled "distribution" into current directory
cd "$BUILD_DIR"
mkdir -p $RUN_DIR/ensemble
rsync -a $OUT_DIR/localpc/ensemble/ $RUN_DIR/ensemble
 
# Patch geosec.ini to make FreeGEOS use the os2ec.geo filesystem driver that works under DOSBox
sed -i 's/fs = .*geo/primaryfsd = os2ec.geo/' $RUN_DIR/ensemble/geosec.ini

# Search for the PC/GEOS serial number in the repository
serial="$(find | egrep geos.*\.ini | xargs -n1 grep serialNumber | uniq | sort | tail -1)"

# Patch geosec.ini to make the setup not ask for a serial
if [ $(grep -c serialNumber $RUN_DIR/ensemble/geosec.ini) -eq 0 ]
then
  sed -i "/\[system\]/a $serial" $RUN_DIR/ensemble/geosec.ini
fi
