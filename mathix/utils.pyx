from libc.math cimport abs, sqrt


cdef bint _line_circle_intersect(Vector2 a, Vector2 b, Circle c):
    cdef float t, dt, area, length, height

    cdef Vector2 d, e, f

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
        e = Vector2(a.x + (t - dt) * d.x,
                    a.y + (t - dt) * d.y)

        # Calculate the second intersection.
        f = Vector2(a.x + (t + dt) * d.x,
                    a.y + (t + dt) * d.y)

        return True

    return False

def line_circle_intersect(Vector2 a, Vector2 b, Circle c):
    """
    Solve for circle-line intersection: http://stackoverflow.com/a/1090772
    """
    return _line_circle_intersect(a, b, c)
