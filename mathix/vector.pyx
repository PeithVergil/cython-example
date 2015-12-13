cdef class Vector3:
    def __cinit__(self, float x, float y, float z):
        self.x = x
        self.y = y
        self.z = z

    cdef Vector3 _ccross(self, Vector3 other):
        cdef Vector3 result

        result = Vector3((self.y * other.z) - (self.z * other.y),
                         (self.z * other.x) - (self.x * other.z),
                         (self.x * other.y) - (self.y * other.x))

        return result

    cdef float _cdot(self, Vector3 other):
        return (self.x * other.x) + \
               (self.y * other.y) + \
               (self.z * other.z)

    cdef Vector3 _cadd(self, Vector3 other):
        cdef Vector3 result

        result = Vector3(self.x + other.x,
                         self.y + other.y,
                         self.z + other.z)

        return result

    cdef Vector3 _csub(self, Vector3 other):
        cdef Vector3 result

        result = Vector3(self.x - other.x,
                         self.y - other.y,
                         self.z - other.z)

        return result

    def dot(self, Vector3 other):
        return self._cdot(other)

    def __add__(Vector3 left, Vector3 right):
        """
        Perform vector addition.
        """
        return left._cadd(right)

    def __sub__(Vector3 left, Vector3 right):
        """
        Perform vector subtraction.
        """
        return left._csub(right)

    def __mul__(Vector3 left, Vector3 right):
        """
        Perform the cross product operation.

        x = (Ay * Bz) - (Az * By)
        y = (Az * Bx) - (Ax * Bz)
        z = (Ax * By) - (Ay * Bx)
        """
        return left._ccross(right)

    def __str__(self):
        return 'Vector3(x={0}, y={1}, z={2})'.format(self.x, self.y, self.z)
