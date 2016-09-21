from .shapes cimport Circle
from .vector cimport Vector2


cdef bint _line_circle_intersect(Vector2 a, Vector2 b, Circle c, Vector2 e, Vector2 f)
cdef bint _line_circle_intersect2(Vector2 a, Vector2 b, Circle c, Vector2 intersect_a, Vector2 intersect_b)