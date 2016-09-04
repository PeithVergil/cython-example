from .vector cimport Vector2


cdef class Circle:
    """
    The "x" and "y" location of the circle's center.
    """
    cdef public Vector2 c

    """
    The radius of the circle.
    """
    cdef public float r
