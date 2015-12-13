cdef class Matrix4:

    def __cinit__(self, list values):
        for i, n in enumerate(values):
            self.m[i] = n

    def __str__(self):
        values = ', '.join('{0:0.2f}'.format(value) for value in self.m)

        return 'Matrix4([{0}])'.format(values)
