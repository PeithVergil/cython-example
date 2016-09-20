Mathix
======

Mathix is a simple math library. It is a sample project that uses Cython to
create C extensions in Python. It is only for demonstration purposes. It is
not intended for practical use.


Build
----------------------------------------

Build package for development.

```sh
python setup.py build_ext --inplace
```

Build package for distribution.

```sh
python setup.py bdist_wheel
```


Installation
----------------------------------------

Install the package for testing during development.

```sh
python setup.py develop
```


Uninstall
----------------------------------------

Uninstall the package used in development.

```sh
python setup.py develop --uninstall
```