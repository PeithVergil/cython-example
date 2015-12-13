cdef class Vector3:
    def __cinit__(self, float x, float y, float z):
        self.x = x
        self.y = y
        self.z = z

    cdef float _cdot(self, Vector3 other):
        return (self.x * other.x) + \
               (self.y * other.y) + \
               (self.z * other.z)

    def dot(self, Vector3 other):
        return self._cdot(other)

    def __add__(Vector3 left, Vector3 right):
        cdef Vector3 result

        result = Vector3(
            left.x + right.x,
            left.y + right.y,
            left.z + right.z,
        )

        return result

    def __sub__(Vector3 left, Vector3 right):
        cdef Vector3 result

        result = Vector3(
            left.x - right.x,
            left.y - right.y,
            left.z - right.z,
        )

        return result

    def __str__(self):
        return 'Vector3(x={0}, y={1}, z={2})'.format(self.x, self.y, self.z)
