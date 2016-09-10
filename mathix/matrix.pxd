from .vector cimport Vector2


cdef class Matrix22:

    cdef public float m00, m01
    cdef public float m10, m11

    cdef float _determinant(self)

    cdef Vector2 _transform(self, Vector2 vector)


cdef class Matrix44:
    cdef public float m[16]
