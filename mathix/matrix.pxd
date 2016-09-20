from .vector cimport Vector2


cdef class Matrix22:

    cdef public float m00, m01
    cdef public float m10, m11

    # cdef Matrix22 add(self, Matrix22 other)
    # cdef Matrix22 sub(self, Matrix22 other)
    cdef Matrix22 mul(self, Matrix22 other)
    # cdef Matrix22 div(self, Matrix22 other)

    cdef float _determinant(self)

    cdef Vector2 _transform(self, Vector2 vector)


cdef class Matrix33:

    cdef public float m00, m01, m02
    cdef public float m10, m11, m12
    cdef public float m20, m21, m22

    cdef Matrix33 _multiply(self, Matrix33 other)

    cdef Vector2 _transform(self, Vector2 vector)


cdef class Matrix44:
    cdef public float m[16]
