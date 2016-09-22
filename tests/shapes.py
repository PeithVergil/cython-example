from unittest import TestCase

from mathix import Circle, Rectangle, Vector2


class TestCircle(TestCase):

    def test_xyr(self):
        c = Circle(1.0, 2.0, 3.0)

        self.assertEqual(c.x, 1.0)
        self.assertEqual(c.y, 2.0)
        self.assertEqual(c.r, 3.0)

    def test_line_0(self):
        """
        The line intersects with the circle at 0 degrees.
        """
        a = Vector2(10, 10)
        b = Vector2(40, 10)

        c = Circle(25, 10, 10)

        self.assertTrue(c.line_intersection(a, b))

    def test_line_45(self):
        """
        The line intersects with the circle at 45 degrees.
        """
        a = Vector2(100, 100)
        b = Vector2(400, 400)

        c = Circle(250, 150, 100)

        self.assertTrue(c.line_intersection(a, b))

    def test_line_90(self):
        """
        The line intersects with the circle at 90 degrees.
        """
        a = Vector2(180, 100)
        b = Vector2(180, 300)

        c = Circle(250, 150, 100)

        self.assertTrue(c.line_intersection(a, b))

    def test_line_in(self):
        """
        The line is inside the circle.
        """
        a = Vector2(200, 85)
        b = Vector2(200, 128)

        c = Circle(250, 150, 100)

        self.assertTrue(c.line_intersection(a, b))

    def test_line_out(self):
        """
        The line is outside the circle.
        """
        a = Vector2(360, 100)
        b = Vector2(360, 230)

        c = Circle(250, 150, 100)

        self.assertFalse(c.line_intersection(a, b))


class TestRectangle(TestCase):

    def test_xywh(self):
        rect = Rectangle(1.0, 1.0, 5.0, 5.0)

        self.assertEqual(rect.x, 1.0)
        self.assertEqual(rect.y, 1.0)
        self.assertEqual(rect.w, 5.0)
        self.assertEqual(rect.h, 5.0)

    def test_trbl(self):
        rect = Rectangle(1.0, 1.0, 5.0, 5.0)

        self.assertEqual(rect.t, 6.0)
        self.assertEqual(rect.r, 6.0)
        self.assertEqual(rect.b, 1.0)
        self.assertEqual(rect.l, 1.0)
