from libc.math cimport cos, sin, M_PI

from .vector cimport Vector2


cdef class Matrix22:

    def __cinit__(self, float m00, float m01, float m10, float m11):
        self.m00, self.m01 = m00, m01
        self.m10, self.m11 = m10, m11

    @classmethod
    def identity(cls):
        """
        Create an identity matrix.
        """
        return cls(1.0, 0.0,
                   0.0, 1.0)

    @classmethod
    def scaling(cls, scale_x, scale_y):
        """
        Create a scaling matrix.
        """
        return cls(scale_x, 0.0,
                   0.0, scale_y)

    @classmethod
    def rotation(cls, angle):
        """
        Create a rotation matrix around the z-axis.
        """
        angle = angle * (M_PI / 180)

        return cls(cos(angle), -sin(angle),
                   sin(angle), cos(angle))

    cdef float _determinant(self):
        return self.m00 * self.m11 - self.m01 * self.m10

    cdef Matrix22 mul(self, Matrix22 other):
        return Matrix22(self.m00 * other.m00 + self.m01 * other.m10,
                        self.m00 * other.m01 + self.m01 * other.m11,
                        self.m10 * other.m00 + self.m11 * other.m10,
                        self.m10 * other.m01 + self.m11 * other.m11)

    cdef Vector2 _transform(self, Vector2 vector):
        return Vector2(self.m00 * vector.x + self.m01 * vector.y,
                       self.m10 * vector.x + self.m11 * vector.y)

    @property
    def determinant(self):
        return self._determinant()

    def transform(self, Vector2 vector):
        return self._transform(vector)

    def __mul__(Matrix22 left, Matrix22 right):
        """
        Perform matrix-matrix multiplication.

        |a b| |e f| = |ae+bg af+bh|
        |c d| |g h|   |ce+dg cf+dh|
        """
        return left.mul(right)

    def __str__(self):
        return 'Matrix22({}, {}, {}, {})'.format(self.m00, self.m01,
                                                 self.m10, self.m11)


cdef class Matrix33:

    def __cinit__(self, float m00, float m01, float m02,
                        float m10, float m11, float m12,
                        float m20, float m21, float m22):
        self.m00, self.m01, self.m02 = m00, m01, m02
        self.m10, self.m11, self.m12 = m10, m11, m12
        self.m20, self.m21, self.m22 = m20, m21, m22

    @classmethod
    def identity(cls):
        """
        Create an identity matrix.
        """
        return cls(1.0, 0.0, 0.0,
                   0.0, 1.0, 0.0,
                   0.0, 0.0, 1.0)

    @classmethod
    def scaling(cls, scale_x, scale_y):
        """
        Create a scaling matrix.
        """
        cdef float _sx, _sy

        _sx = scale_x
        _sy = scale_y

        return cls(_sx, 0.0, 0.0,
                   0.0, _sy, 0.0,
                   0.0, 0.0, 1.0)

    @classmethod
    def rotation(cls, angle):
        """
        Create a rotation matrix around the z-axis.
        """
        cdef float rad, _cs, _sn

        rad = angle * (M_PI / 180)

        _cs = cos(rad)
        _sn = sin(rad)

        return cls(_cs, -_sn, 0.0,
                   _sn,  _cs, 0.0,
                   0.0,  0.0, 1.0)

    cdef Matrix33 _multiply(self, Matrix33 other):
        return Matrix33(self.m00 * other.m00 + self.m01 * other.m10 + self.m02 * other.m20,
                        self.m00 * other.m01 + self.m01 * other.m11 + self.m02 * other.m21,
                        self.m00 * other.m02 + self.m01 * other.m12 + self.m02 * other.m22,
                        self.m10 * other.m00 + self.m11 * other.m10 + self.m12 * other.m20,
                        self.m10 * other.m01 + self.m11 * other.m11 + self.m12 * other.m21,
                        self.m10 * other.m02 + self.m11 * other.m12 + self.m12 * other.m22,
                        self.m20 * other.m00 + self.m21 * other.m10 + self.m22 * other.m20,
                        self.m20 * other.m01 + self.m21 * other.m11 + self.m22 * other.m21,
                        self.m20 * other.m02 + self.m21 * other.m12 + self.m22 * other.m22)

    cdef Vector2 _transform(self, Vector2 vector):
        cdef float x, y, z

        x = vector.x
        y = vector.y
        z = 1.0

        return Vector2(self.m00 * x + self.m01 * y + self.m02 * z,
                       self.m10 * x + self.m11 * y + self.m12 * z,
                       self.m20 * x + self.m21 * y + self.m22 * z)

    def transform(self, Vector2 vector):
        return self._transform(vector)

    def __mul__(Matrix33 left, Matrix33 right):
        """
        Perform matrix-matrix multiplication.
        """
        return left._multiply(right)

    def __str__(self):
        m = (self.m00, self.m01, self.m02,
             self.m10, self.m11, self.m12,
             self.m20, self.m21, self.m22)

        return 'Matrix33({}, {}, {}, {}, {}, {}, {}, {}, {})'.format(*m)


cdef class Matrix44:

    def __cinit__(self, list values):
        for i, n in enumerate(values):
            self.m[i] = n

    def __str__(self):
        values = ', '.join('{0:0.2f}'.format(value) for value in self.m)

        return 'Matrix44([{0}])'.format(values)
