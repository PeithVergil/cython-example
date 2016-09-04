from unittest import TestCase

from mathix import Vector2, Circle
from mathix.utils import line_circle_intersect


class TestUtils(TestCase):

    def test_line_0(self):
        """
        The line intersects the circle at 0 degrees.
        """
        a = Vector2(10, 10)
        b = Vector2(40, 10)

        c = Circle(25, 10, 10)

        self.assertTrue(line_circle_intersect(a, b, c))

    def test_line_45(self):
        """
        The line intersects the circle at 45 degrees.
        """
        a = Vector2(100, 100)
        b = Vector2(400, 400)

        c = Circle(250, 150, 100)

        self.assertTrue(line_circle_intersect(a, b, c))

    def test_line_90(self):
        """
        The line intersects the circle at 90 degrees.
        """
        a = Vector2(180, 100)
        b = Vector2(180, 300)

        c = Circle(250, 150, 100)

        self.assertTrue(line_circle_intersect(a, b, c))

    def test_line_out(self):
        """
        The line does not intersect with the circle.
        """
        a = Vector2(360, 100)
        b = Vector2(360, 230)

        c = Circle(250, 150, 100)

        self.assertFalse(line_circle_intersect(a, b, c))
