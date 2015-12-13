from unittest import TestCase

from mathix import Vector3


class TestVector3(TestCase):

    def test_str(self):
        vector3 = Vector3(1, 2, 3)

        self.assertEqual(str(vector3), 'Vector3(x=1.0, y=2.0, z=3.0)')

    def test_add(self):
        result = Vector3(1, 2, 3) + Vector3(4, 5, 6)

        self.assertEqual(result.x, 5)
        self.assertEqual(result.y, 7)
        self.assertEqual(result.z, 9)

    def test_sub(self):
        result = Vector3(4, 5, 6) - Vector3(1, 2, 3)

        self.assertEqual(result.x, 3)
        self.assertEqual(result.y, 3)
        self.assertEqual(result.z, 3)

    def test_dot(self):
        a = Vector3(1, 2, 3)
        b = Vector3(4, 5, 6)

        self.assertEqual(a.dot(b), 32.0)

    def test_mul(self):
        a = Vector3(2, 3, 4)
        b = Vector3(5, 6, 7)

        c = a * b

        self.assertEqual(c.x, -3.0)
        self.assertEqual(c.y, 6.0)
        self.assertEqual(c.z, -3.0)

    def test_cunit(self):
        vector3 = Vector3(1, 2, 3)

        vector3.unit()

        self.assertEqual(vector3.x, 0.26726123690605164)
        self.assertEqual(vector3.y, 0.5345224738121033)
        self.assertEqual(vector3.z, 0.8017837405204773)

    def test_scale(self):
        vector3 = Vector3(1, 2, 3)

        vector3.scale(3.0)

        self.assertEqual(vector3.x, 3.0)
        self.assertEqual(vector3.y, 6.0)
        self.assertEqual(vector3.z, 9.0)

    def test_magnitude(self):
        self.assertEqual(Vector3(1, 2, 3).magnitude, 3.7416573867739413)
