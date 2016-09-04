from .circle cimport Circle
from .vector cimport Vector2


cdef bint _line_circle_intersect(Vector2 a, Vector2 b, Circle c)