cdef class Vector3:
    cdef public float x, y, z

    cdef float _cdot(self, Vector3 other)
