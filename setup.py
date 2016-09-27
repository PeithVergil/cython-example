from setuptools import Extension, setup

try:
    from Cython.Build import cythonize
except ImportError:
    use_cython = False
else:
    use_cython = True


if use_cython:
    extensions = cythonize([
        Extension('mathix.matrix', ['mathix/matrix.pyx']),
        Extension('mathix.vector', ['mathix/vector.pyx']),
        Extension('mathix.shapes', ['mathix/shapes.pyx']),
        Extension('mathix.qtree', ['mathix/qtree.pyx']),
        Extension('mathix.utils', ['mathix/utils.pyx']),
    ])
else:
    extensions = [
        Extension('mathix.matrix', ['mathix/matrix.c']),
        Extension('mathix.vector', ['mathix/vector.c']),
        Extension('mathix.shapes', ['mathix/shapes.c']),
        Extension('mathix.qtree', ['mathix/qtree.c']),
        Extension('mathix.utils', ['mathix/utils.c']),
    ]


setup(
    name='mathix',

    author='Peith Vergil',

    version='0.1',

    license='MIT',

    packages=[
        'mathix',
    ],

    zip_safe=False,

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
