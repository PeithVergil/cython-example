from libc.math cimport abs, sqrt

from .shapes cimport Circle
from .vector cimport Vector2


cdef bint _line_circle_intersect(Vector2 a, Vector2 b, Circle c, Vector2 e, Vector2 f):
    """
    Solve for circle-line intersection.

    See: http://stackoverflow.com/a/1090772
    """
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


cdef bint _line_circle_intersect2(Vector2 a,
                                  Vector2 b,
                                  Circle c,
                                  Vector2 intersect_a,
                                  Vector2 intersect_b):
    """
    Another solution for line-circle intersection.

    See: http://stackoverflow.com/a/1088058
    """
    cdef Vector2 line_direction, projection_point

    cdef float t, dt, projection_length

    line_direction = (b - a)
    line_direction.unit()

    # Solve for "t".
    t = (line_direction.x * (c.x - a.x)) + (line_direction.y * (c.y - a.y))

    # Project a line from the center of the circle to the line A and B.
    projection_point = Vector2(t * line_direction.x + a.x,
                               t * line_direction.y + a.y)

    # Get the length of the projected line.
    projection_length = (projection_point - c).length

    # Is the length of the projection lesser than the radius of the circle?
    if projection_length < c.r:
        # Solve for "dt".
        #
        # The distance from "t" to the intersection point.
        dt = sqrt(c.r * c.r - projection_length * projection_length)

        # Solve for the first intersection.
        intersect_a.x = (t - dt) * line_direction.x + a.x
        intersect_a.y = (t - dt) * line_direction.y + a.y

        # Solve for the second intersection.
        intersect_b.x = (t + dt) * line_direction.x + a.x
        intersect_b.y = (t + dt) * line_direction.y + a.y

        # There was an intersection.
        return True

    # There was no intersection.
    return False


def line_circle_intersect(Vector2 a, Vector2 b, Circle c):
    """
    Solve for circle-line intersection.

    See: http://stackoverflow.com/a/1090772
    """
    cdef Vector2 e, f

    e = Vector2(0, 0)
    f = Vector2(0, 0)

    if _line_circle_intersect(a, b, c, e, f):
        return e, f
    return False


def line_circle_intersect2(Vector2 a, Vector2 b, Circle c):
    """
    Another solution for line-circle intersection.

    See: http://stackoverflow.com/a/1088058
    """

    cdef Vector2 intersect_a, intersect_b

    intersect_a = Vector2(0, 0)
    intersect_b = Vector2(0, 0)

    if _line_circle_intersect2(a, b, c, intersect_a, intersect_b):
        return True
    return False
