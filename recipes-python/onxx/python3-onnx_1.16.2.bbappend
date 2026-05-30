### Remove host python include from flags to prevent cross-compile errors
CXXFLAGS := "${@' '.join([f for f in d.getVar('CXXFLAGS').split() if f != '-I/usr/include/python3.12'])}"
CPPFLAGS := "${@' '.join([f for f in d.getVar('CPPFLAGS').split() if f != '-I/usr/include/python3.12'])}"
DEPENDS += "abseil-cpp"
RDEPENDS:${PN} += "abseil-cpp"
EXTRA_OECMAKE += " \
	-DABSL_ROOT_DIR=${STAGING_DIR_TARGET}/usr \
	-DCMAKE_SKIP_RPATH=ON \
	"
export CMAKE_ARGS:append = " \
	-DProtobuf_LIBRARY=${STAGING_LIBDIR}/libprotobuf.so \
	-DProtobuf_LIBRARIES=${STAGING_LIBDIR}/libprotobuf.so \
	-DProtobuf_PROTOC_EXECUTABLE=${STAGING_BINDIR_NATIVE}/protoc \
	-DPYTHON_INCLUDE_DIR=${STAGING_INCDIR}/${PYTHON_DIR} \
	-DPYTHON_INCLUDE_DIRS=${STAGING_INCDIR}/${PYTHON_DIR} \
	-DPYTHON_LIBRARY=${STAGING_LIBDIR}/libpython3.12.so \
"

do_configure:prepend() {
	# Avoid host include leakage from PYTHON_INCLUDE_DIRS during cross-build.
	sed -i 's|"${PYTHON_INCLUDE_DIRS}"|"${PYTHON_INCLUDE_DIR}"|g' ${S}/CMakeLists.txt
}