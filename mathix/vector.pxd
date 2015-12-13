cdef class Vector3:
    cdef public float x, y, z

    # Cross product
    cdef Vector3 _ccross(self, Vector3 other)

    # Dot product
    cdef float _cdot(self, Vector3 other)

    cdef Vector3 _cadd(self, Vector3 other)
    cdef Vector3 _csub(self, Vector3 other)

    cdef float _cmag(self)

    cdef void _cunit(self)

    cdef void _cscale(self, float value)
