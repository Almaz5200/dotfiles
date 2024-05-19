function build_nvim
    cd ~/neovim
    make CMAKE_BUILD_TYPE=Release MACOSX_DEPLOYMENT_TARGET=10.13 DEPS_CMAKE_FLAGS="-DCMAKE_CXX_COMPILER=$(xcrun -find c++)"
    sudo make install
end
