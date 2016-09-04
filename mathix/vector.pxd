cdef class Vector2:
    cdef public float x, y

    cdef Vector2 add(self, Vector2 other)
    cdef Vector2 sub(self, Vector2 other)
    cdef Vector2 mul(self, Vector2 other)
    cdef Vector2 div(self, Vector2 other)

    # Dot product
    cdef float _dot(self, Vector2 other)
    
    # Cross product
    cdef float _cross(self, Vector2 other)


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
