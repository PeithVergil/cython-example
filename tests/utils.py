from unittest import TestCase

from mathix import Rectangle, Vector2, Circle
from mathix.utils import (line_circle_intersect, line_circle_intersect2,
                          rectangle_in_rectangle)


class LineCircleIntersectMixin:

    def test_line_0(self):
        """
        The line intersects with the circle at 0 degrees.
        """
        a = Vector2(10, 10)
        b = Vector2(40, 10)

        c = Circle(25, 10, 10)

        self.assertTrue(self.check_intersection(a, b, c))

    def test_line_45(self):
        """
        The line intersects with the circle at 45 degrees.
        """
        a = Vector2(100, 100)
        b = Vector2(400, 400)

        c = Circle(250, 150, 100)

        self.assertTrue(self.check_intersection(a, b, c))

    def test_line_90(self):
        """
        The line intersects with the circle at 90 degrees.
        """
        a = Vector2(180, 100)
        b = Vector2(180, 300)

        c = Circle(250, 150, 100)

        self.assertTrue(self.check_intersection(a, b, c))

    def test_line_in(self):
        """
        The line is inside the circle.
        """
        a = Vector2(200, 85)
        b = Vector2(200, 128)

        c = Circle(250, 150, 100)

        self.assertTrue(self.check_intersection(a, b, c))

    def test_line_out(self):
        """
        The line is outside the circle.
        """
        a = Vector2(360, 100)
        b = Vector2(360, 230)

        c = Circle(250, 150, 100)

        self.assertFalse(self.check_intersection(a, b, c))


class TestLineCircleIntersect(LineCircleIntersectMixin, TestCase):

    def check_intersection(self, a, b, c):
        return line_circle_intersect(a, b, c)


class TestLineCircleIntersect2(LineCircleIntersectMixin, TestCase):

    def check_intersection(self, a, b, c):
        return line_circle_intersect2(a, b, c)


class TestRectangleInRectangle(TestCase):

    def test_in(self):
        a = Rectangle(20, 20, 100, 100)
        b = Rectangle(10, 10, 400, 300)

        self.assertTrue(rectangle_in_rectangle(a, b))

    def test_out(self):
        a = Rectangle(10, 10, 100, 100)
        b = Rectangle(20, 20, 400, 300)

        self.assertFalse(rectangle_in_rectangle(a, b))
