from distutils.core import Extension, setup

try:
    from Cython.Build import cythonize
except ImportError:
    use_cython = False
else:
    use_cython = True


if use_cython:
    extensions = cythonize([
        Extension('mathix.vector', ['mathix/vector.pyx']),
    ])
else:
    extensions = [
        Extension('mathix.vector', ['mathix/vector.c']),
    ]


setup(
    name='mathix',

    author='Peith Vergil',

    version='0.1',

    license='MIT',

    packages=[
        'mathix',
    ],

    keywords='useless simple math library',

    description='A useless simple math library.',

    classifiers=[
        'Development Status :: 4 - Beta',
        'Intended Audience :: Developers',
        'Programming Language :: Cython',
        'Programming Language :: Python',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.4',
        'Programming Language :: Python :: 3.5',
    ],

    ext_modules=extensions
)
