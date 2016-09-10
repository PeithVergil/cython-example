from libc.math cimport cos, sin

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
        return cls(cos(angle), -sin(angle),
                   sin(angle), cos(angle))

    cdef float _determinant(self):
        return self.m00 * self.m11 - self.m01 * self.m10

    cdef Vector2 _transform(self, Vector2 vector):
        return Vector2(self.m00 * vector.x + self.m01 * vector.y,
                       self.m10 * vector.x + self.m11 * vector.y)

    @property
    def determinant(self):
        return self._determinant()

    def transform(self, Vector2 vector):
        return self._transform(vector)

    def __str__(self):
        return 'Matrix22({}, {}, {}, {})'.format(self.m00, self.m01,
                                                 self.m10, self.m11)


cdef class Matrix44:

    def __cinit__(self, list values):
        for i, n in enumerate(values):
            self.m[i] = n

    def __str__(self):
        values = ', '.join('{0:0.2f}'.format(value) for value in self.m)

        return 'Matrix44([{0}])'.format(values)
