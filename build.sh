rm -r -f $PWD/out
rm -r -f $PWD/AnyKernel

# source ~/.bashrc && source ~/.profile
# export LC_ALL=C
# export USE_CCACHE=1
# ccache -M 100G
export ARCH=arm64
export KBUILD_BUILD_HOST=neolit
export KBUILD_BUILD_USER="ALEX5402-KSU"
# export CFLAGS="-fPIC"
# export CFLAGS="-Wall -O2"
#  sudo apt upgrade -y
#  sudo apt install -y bc bison build-essential ccache curl flex glibc-source g++-multilib gcc-multilib binutils-aarch64-linux-gnu git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-gtk3-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev python2 tmate ssh neofetch
        

git clone https://gitlab.com/Koushikdey2003/prebuilts_clang_host_linux-x86_clang-r510928 clang
wget https://releases.linaro.org/components/toolchain/binaries/7.5-2019.12/arm-linux-gnueabihf/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf.tar.xz
git clone https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9 compile-64

[ -d "out" ] && rm -rf out || mkdir -p out
make mrproper
make O=out ARCH=arm64 SUBARCH=arm64 sdm845-perf_defconfig


PATH="${PWD}/clang/bin:${PATH}:${PWD}/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin:${PATH}:${PWD}/compile-64/bin:${PATH}" \

make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC="clang" \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE="${PWD}/compile-64/bin/aarch64-linux-androidkernel-" \
                      CROSS_COMPILE_ARM32="${PWD}/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-" \
                      CONFIG_NO_ERROR_ON_MISMATCH=y

# function zipping()
# {
# git clone --depth=1 https://github.com/alex5402/AnyKernel3.git AnyKernel
# cp out/arch/arm64/boot/Image.gz-dtb AnyKernel
# cd AnyKernel
# zip -r9 OSS-KERNEL-sm845-NEOLIT-KSU.zip *
# }

# zipping
