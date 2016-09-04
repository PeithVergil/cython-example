from .vector cimport Vector2


cdef class Circle(Vector2):
    """
    The radius of the circle.
    """
    cdef public float r
