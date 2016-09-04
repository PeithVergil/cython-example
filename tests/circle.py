from unittest import TestCase

from mathix import Circle


class TestCircle(TestCase):

    def test_xyr(self):
        c = Circle(1.0, 2.0, 3.0)

        self.assertEqual(c.x, 1.0)
        self.assertEqual(c.y, 2.0)
        self.assertEqual(c.r, 3.0)
