from unittest import TestCase

from mathix import Circle


class TestCircle(TestCase):

    def test_xyr(self):
        c = Circle((1, 2), 10.0)

        self.assertEqual(c.x, 1)
        self.assertEqual(c.y, 2)
        self.assertEqual(c.r, 10.0)
