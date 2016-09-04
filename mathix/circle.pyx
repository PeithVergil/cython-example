cdef class Circle:

    def __cinit__(self, center, float radius):
        cdef float cx, cy
        
        cx, cy = center
        
        self.x = cx
        self.y = cy
        self.r = radius

    @property
    def x(self):
        return self.c.x

    @x.setter
    def x(self, value):
        self.c.x = value

    @property
    def y(self):
        return self.c.y

    @y.setter
    def y(self, value):
        self.c.y = value
