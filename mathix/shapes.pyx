from libc.math cimport sqrt

from .vector cimport Vector2


cdef class Circle(Vector2):

    def __cinit__(self, float x, float y, float radius):
        self.r = radius

    cdef bint line_intersect(self, Vector2 a, Vector2 b):
        """
        Solve for a line-circle intersection.

        See: http://stackoverflow.com/a/1088058
        """
        cdef Vector2 line_direction, projection_point

        cdef float t, dt, projection_length

        line_direction = (b - a)
        line_direction.unit()

        # Solve for "t".
        t = (line_direction.x * (self.x - a.x)) + (line_direction.y * (self.y - a.y))

        # Project a line from the center of the circle to the line A and B.
        projection_point = Vector2(t * line_direction.x + a.x,
                                   t * line_direction.y + a.y)

        # Get the length of the projected line.
        projection_length = (projection_point - self).length

        # Is the length of the projection lesser than the radius of the circle?
        if projection_length < self.r:
            # Solve for "dt".
            #
            # The distance from "t" to the intersection point.
            dt = sqrt(self.r * self.r - projection_length * projection_length)

            # Solve for the first intersection.
            self.intersection_a.x = (t - dt) * line_direction.x + a.x
            self.intersection_a.y = (t - dt) * line_direction.y + a.y

            # Solve for the second intersection.
            self.intersection_b.x = (t + dt) * line_direction.x + a.x
            self.intersection_b.y = (t + dt) * line_direction.y + a.y

            # There was an intersection.
            return True

        # There was no intersection.
        return False

    def line_intersection(self, Vector2 a, Vector2 b):
        return self.line_intersect(a, b)
