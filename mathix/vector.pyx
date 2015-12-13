cdef class Vector3:
    cdef public float x, y, z

    def __cinit__(self, float x, float y, float z):
        self.x = x
        self.y = y
        self.z = z

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
