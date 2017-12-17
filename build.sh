# Basic build script

# Export some vars $ stuff

KERNEL_DIR=$PWD
AK_DIR=$KERNEL_DIR/../AnyKernel2
TC_DIR=$KERNEL_DIR/../TC/aarch64-linux-android-4.9
DATE=$(date +"%Y%m%d")
VERSION="0.1A"
KERNELFINAL="Placeholderkernelname_capricorn-"$VERSION"-"$DATE

export ARCH=arm64
export CROSS_COMPILE=$TC_DIR/bin/aarch64-linux-android-
export LD_LIBRARY_PATH=$TC_DIR/lib/

echo "zip: "$KERNELFINAL", AK: "$AK_DIR", TC: "$TC_DIR, ARCH: $ARCH, CC: $CROSS_COMPILE
sleep 1

# Fun starts here

make clean
make mrproper
make capricorn_defconfig
make -j$( nproc --all )

mv $KERNEL_DIR/arch/arm64/boot/Image.gz $AK_DIR/zImage
cd $AK_DIR/capricorn

zip -r9 $KERNELFINAL * -x *.zip $KERNELFINAL
