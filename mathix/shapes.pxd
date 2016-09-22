from .vector cimport Vector2


cdef class Circle(Vector2):
    """
    The radius of the circle.
    """
    cdef public float r

    """
    The points of intersection between a line and the circle.
    """
    cdef public Vector2 intersection_a
    cdef public Vector2 intersection_b

    """
    Determine if the given line intersects with the circle.
    """
    cdef bint line_intersect(self, Vector2 a, Vector2 b)


cdef class Rectangle(Vector2):
    """
    The width and height of the rectangle.
    """
    cdef public float w, h

    cdef float _t(self)
    cdef float _r(self)
