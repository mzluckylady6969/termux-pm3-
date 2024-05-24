#!/bin/bash
#
#  Copyright 2019 Gerhard Klostermeier
#  Usage: bash termux-pm3.sh <install | run | update> [ignore-warnings] [PLATFORM=PM3OTHER]
#


function compile {
    if [ "$1" == "ignore-warnings" ]; then
        # Allow warnings (needed on Android 5.x, 7.x, not needed on 8.x).
        echo "[*] Removing the -Werror flag from Makefiles"
        sed -i 's/-Werror //g' client/Makefile
        sed -i 's/-Werror //g' Makefile.host
        # Make the proxmark3 client.
        echo "[*] Compiling the client"
        make client $2
    else
        # Make the proxmark3 client.
        echo "[*] Compiling the client"
        make client $1
    fi
}


# Main function.
if [ "$1" == "install" ]; then
    # Update Termux packages.
    echo "[*] Udate packages"
    apt update -y

    # Install proxmark3 client build dependencies.
    echo "[*] Install dependencies"
    apt install -y git make clang sudo apt-get install --no-install-recommends git ca-certificates build-essential pkg-config \
libreadline-dev gcc-arm-none-eabi libnewlib-dev qtbase5-dev \
libbz2-dev liblz4-dev libbluetooth-dev libpython3-dev libssl-dev libgd-dev libc++ binutils readline 

    # Get the proxmark3 RDV4 repository.
    echo "[*] Get the Proxmark3 RDV4 repository"
    git clone https://github.com/RfidResearchGroup/proxmark3.git
    got clone https://github.com/lz4/lz4
    cd lz4
    make install 
    cd ..
    cd proxmark3
    git restore *
    compile $2 $3
elif [ "$1" == "run" ]; then
    # Run Proxmark3 client (needs root for now).
    echo "[*] Run the Proxmark3 RDV4 client as root on /dev/ttyACM0"
    su -c 'cd proxmark3/client && ./proxmark3 -p /dev/ttyACM0'
elif [ "$1" == "update" ]; then
    echo "[*] Update the Proxmark3 RDV4 repository"
    cd proxmark3
    git restore *
    git pull
    compile $2 $3
else
    echo "Usage: bash termux-pm3.sh <install | run | update> [ignore-warnings] [PLATFORM=PM3OTHER]"
    echo "Running the Proxmark3 client requires root (to access /dev/ttyACM0)."
    echo "Hint: There are plans in the Termux community to support USB-OTG and Bluetooth devices." \
         "Maybe then it will be possible to do this without root."
fi

 *
 * The number of bytes regenerated into dstBuffer will be provided within *dstSizePtr (necessarily <= original value).
 *
 * The number of bytes effectively used from srcBuffer will be provided within *srcSizePtr (necessarily <= original value).
 * If the number of bytes read is < number of bytes provided, then the decompression operation is not complete.
 * This typically happens when dstBuffer is not large enough to contain all decoded data.
 * LZ4F_decompress() will have to be called again, starting from where it stopped (srcBuffer + *srcSizePtr)
 * The function will check this condition, and refuse to continue if it is not respected.
 * dstBuffer is supposed to be flushed between calls to the function, since its content will be rewritten.
 * Different dst arguments can be used between each calls.
 *
 * The function result is an hint of the better srcSize to use for next call to LZ4F_decompress.
 * Basically, it's the size of the current (or remaining) compressed block + header of next block.
 * Respecting the hint provides some boost to performance, since it allows less buffer shuffling.
 * Note that this is just a hint, you can always provide any srcSize you want.
 * When a frame is fully decoded, the function result will be 0.
 * If decompression failed, function result is an error code which can be tested using LZ4F_isError().
 */



#if defined (__cplusplus)
}
#endif
