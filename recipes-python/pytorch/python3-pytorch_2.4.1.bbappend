
CUDA_TOOLKIT_ROOT_DIR = "${RECIPE_SYSROOT}/usr/local/cuda-11.4"
CUDA_NVCC_EXECUTABLE = "${CUDA_TOOLKIT_ROOT_DIR}/bin/nvcc"
CUDA_INCLUDE_DIRS = "${CUDA_TOOLKIT_ROOT_DIR}/include"

CUDA_TOOLKIT_ROOT_DIR_NATIVE = "${RECIPE_SYSROOT_NATIVE}/usr/local/cuda-11.4"
CUDA_NVCC_EXECUTABLE_NATIVE = "${CUDA_TOOLKIT_ROOT_DIR_NATIVE}/bin/nvcc"
CUDA_INCLUDE_DIRS_NATIVE = "${CUDA_TOOLKIT_ROOT_DIR}/include"

# Enable CUDA in target build

#-DCUDA_NVCC_EXECUTABLE=${CUDA_NVCC_EXECUTABLE_NATIVE}
#-DCUDA_TOOLKIT_ROOT_DIR=${CUDA_TOOLKIT_ROOT_DIR} 
#-DCUDA_INCLUDE_DIRS=${CUDA_INCLUDE_DIRS} 
EXTRA_OECMAKE:remove = "-DUSE_CUDA=OFF"
EXTRA_OECMAKE:append = " \
    -DUSE_CUDA=ON \
    -DUSE_CUDNN=ON \
"
#EXTRA_OECMAKE:remove:class-native = "-DUSE_CUDA=OFF"
#EXTRA_OECMAKE:append:class-native = " \
#    -DUSE_CUDA=ON \
#    -DUSE_CUDNN=ON \
#    -DCUDA_TOOLKIT_ROOT_DIR=${CUDA_TOOLKIT_ROOT_DIR_NATIVE} \
#    -DCUDA_NVCC_EXECUTABLE=${CUDA_NVCC_EXECUTABLE_NATIVE} \
#    -DCUDA_INCLUDE_DIRS=${CUDA_INCLUDE_DIRS_NATIVE} \ 
#    "

DEPENDS:append:class-target = " cuda-cudart cuda-nvcc cuda-nvcc-native cudnn libcublas"
#DEPENDS:append:class-native = " cuda-cudart libcublas cuda-nvcc-native"

# Runtime libs needed on target
RDEPENDS:${PN}:append:class-target = " cuda-cudart cudnn libcublas"
RDEPENDS:${PN} += " libyaml python3-pyyaml python3-sympy"
#RDEPENDS:${PN}:append = " cuda-cudart libcublas"