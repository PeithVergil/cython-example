from libc.math cimport abs, sqrt

from .circle cimport Circle
from .vector cimport Vector2


cdef bint _line_circle_intersect(Vector2 a, Vector2 b, Circle c, Vector2 e, Vector2 f):
    cdef float t, dt, area, length, height

    cdef Vector2 d

    # Calculate the area of the triangle between
    # points A, B, and C (center of circle).
    area = abs((b.x - a.x) * (c.y - a.y) - (c.x - a.x) * (b.y - a.y))

    # Calculate the length of the line A and B.
    length = (b - a).length

    # Calculate the height of the triangle.
    height = area / length

    # Does the line intersect the circle?
    if height < c.r:
        # Get the direction of the line from A to B.
        d = (b - a)
        d.unit()

        t = d.x * (c.x - a.x) + d.y * (c.y - a.y)

        dt = sqrt(c.r * c.r - height * height)

        # Calculate the first intersection.
        e.x = a.x + (t - dt) * d.x
        e.y = a.y + (t - dt) * d.y

        # Calculate the second intersection.
        f.x = a.x + (t + dt) * d.x
        f.y = a.y + (t + dt) * d.y

        return True

    return False

def line_circle_intersect(Vector2 a, Vector2 b, Circle c):
    """
    Solve for circle-line intersection: http://stackoverflow.com/a/1090772
    """
    cdef Vector2 e, f

    e = Vector2(0, 0)
    f = Vector2(0, 0)

    if _line_circle_intersect(a, b, c, e, f):
        return e, f
    return False
