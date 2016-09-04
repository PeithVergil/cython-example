from libc cimport math


cdef class Vector2:

    def __cinit__(self, float x, float y):
        self.x = x
        self.y = y

    cdef Vector2 add(self, Vector2 other):
        return Vector2(self.x + other.x,
                       self.y + other.y)

    cdef Vector2 sub(self, Vector2 other):
        return Vector2(self.x - other.x,
                       self.y - other.y)

    cdef Vector2 mul(self, Vector2 other):
        return Vector2(self.x * other.x,
                       self.y * other.y)

    cdef Vector2 div(self, Vector2 other):
        return Vector2(self.x / other.x,
                       self.y / other.y)

    cdef float _dot(self, Vector2 other):
        return self.x * other.x + self.y * other.y

    cdef float _cross(self, Vector2 other):
        return self.x * other.y - self.y * other.x

    cdef float _angle(self):
        return math.atan2(self.y, self.x)

    cdef float _length(self):
        return math.sqrt(self.x * self.x + self.y * self.y)

    cdef float _length2(self):
        return self.x * self.x + self.y * self.y

    cdef void _unit(self):
        cdef float length = self._length()

        self.x /= length
        self.y /= length

    cdef void _scale(self, float value):
        self.x *= value
        self.y *= value

    def __add__(Vector2 left, Vector2 right):
        """
        Perform vector addition.
        """
        return left.add(right)

    def __sub__(Vector2 left, Vector2 right):
        """
        Perform vector subtraction.
        """
        return left.sub(right)

    def __mul__(Vector2 left, Vector2 right):
        """
        Perform vector multiplication.
        """
        return left.mul(right)

    def __truediv__(Vector2 left, Vector2 right):
        """
        Perform vector division.
        """
        return left.div(right)

    def dot(self, Vector2 other):
        return self._dot(other)

    def cross(self, Vector2 other):
        return self._cross(other)

    @property
    def angle(self):
        return self._angle()

    @property
    def length(self):
        return self._length()

    @property
    def length2(self):
        return self._length2()

    def unit(self):
        self._unit()

    def scale(self, float value):
        self._scale(value)

    def __str__(self):
        return 'Vector2(x={0}, y={1})'.format(self.x, self.y)


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

    cdef float _cmag(self):
        return math.sqrt((self.x * self.x) +
                         (self.y * self.y) +
                         (self.z * self.z))

    cdef void _cunit(self):
        cdef float magnitude = self._cmag()

        self.x /= magnitude
        self.y /= magnitude
        self.z /= magnitude

    cdef void _cscale(self, float value):
        self.x *= value
        self.y *= value
        self.z *= value

    @property
    def magnitude(self):
        """
        Calculate the magnitude.
        """
        return self._cmag()

    def scale(self, float value):
        """
        Multiply by a scalar value.
        """
        self._cscale(value)

    def unit(self):
        """
        Convert to a unit vector.
        """
        self._cunit()

    def dot(self, Vector3 other):
        """
        Perform dot product.
        """
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
