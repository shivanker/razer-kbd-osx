from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

razer_extension = Extension(
    name="pyrazer",
    sources=["src/pyrazer.pyx"],
    libraries=["razer"],
    library_dirs=["build"],
    include_dirs=["src"],
    extra_link_args = ['-framework', 'CoreFoundation', '-framework', 'IOKit']
)
setup(
    name="pyrazer",
    ext_modules=cythonize([razer_extension])
)
