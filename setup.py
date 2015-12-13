from distutils.core import Extension, setup

from Cython.Build import cythonize


extensions = [
    Extension('*', ['mathix/*.pyx']),
]


setup(
    name='mathix',

    author='Peith Vergil',

    version='0.1',

    ext_modules=cythonize(extensions)
)
