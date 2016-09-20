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

    def __cinit__(self, float m00=0.0, float m01=0.0, float m02=0.0,
                        float m10=0.0, float m11=0.0, float m12=0.0,
                        float m20=0.0, float m21=0.0, float m22=0.0):
        self.m00 = m00
        self.m01 = m01
        self.m02 = m02
        self.m10 = m10
        self.m11 = m11
        self.m12 = m12
        self.m20 = m20
        self.m21 = m21
        self.m22 = m22

    @classmethod
    def identity(Matrix33 cls):
        """
        Create an identity matrix.
        """
        cdef Matrix33 m = Matrix33()

        m.m00 = 1.0
        m.m11 = 1.0
        m.m22 = 1.0

        return m

    @classmethod
    def scaling(Matrix33 cls, float scale_x, float scale_y):
        """
        Create a scaling matrix.
        """
        cdef Matrix33 m = Matrix33()

        m.m00 = scale_x
        m.m11 = scale_y

        return m

    @classmethod
    def rotation(cls, float angle):
        """
        Create a rotation matrix around the z-axis.
        """
        cdef Matrix33 m = Matrix33()

        cdef float a = angle * (M_PI / 180.0)

        cdef float c = cos(a)
        cdef float s = sin(a)

        m.m00 =  c
        m.m01 = -s
        m.m10 =  s
        m.m11 =  c

        return m

    cdef Matrix33 _multiply(self, Matrix33 other):
        cdef Matrix33 m = Matrix33()

        m.m00 = self.m00 * other.m00 + self.m01 * other.m10 + self.m02 * other.m20
        m.m01 = self.m00 * other.m01 + self.m01 * other.m11 + self.m02 * other.m21
        m.m02 = self.m00 * other.m02 + self.m01 * other.m12 + self.m02 * other.m22
        m.m10 = self.m10 * other.m00 + self.m11 * other.m10 + self.m12 * other.m20
        m.m11 = self.m10 * other.m01 + self.m11 * other.m11 + self.m12 * other.m21
        m.m12 = self.m10 * other.m02 + self.m11 * other.m12 + self.m12 * other.m22
        m.m20 = self.m20 * other.m00 + self.m21 * other.m10 + self.m22 * other.m20
        m.m21 = self.m20 * other.m01 + self.m21 * other.m11 + self.m22 * other.m21
        m.m22 = self.m20 * other.m02 + self.m21 * other.m12 + self.m22 * other.m22

        return m

    cdef Vector2 _transform(self, Vector2 vector):
        cdef Vector2 v = Vector2()

        v.x = self.m00 * vector.x + self.m01 * vector.y + self.m02 * 1.0
        v.y = self.m10 * vector.x + self.m11 * vector.y + self.m12 * 1.0

        return v

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
