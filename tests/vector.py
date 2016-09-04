from unittest import TestCase

from mathix import Vector2, Vector3


class TestVector2(TestCase):

    def test_xy(self):
        vector = Vector2(1, 2)

        self.assertEqual(vector.x, 1)
        self.assertEqual(vector.y, 2)

    def test_str(self):
        vector = Vector2(1, 2)

        self.assertEqual(str(vector), 'Vector2(x=1.0, y=2.0)')

    def test_add(self):
        result = Vector2(1, 2) + Vector2(3, 4)

        self.assertEqual(result.x, 4)
        self.assertEqual(result.y, 6)

    def test_sub(self):
        result = Vector2(3, 4) - Vector2(1, 2)

        self.assertEqual(result.x, 2)
        self.assertEqual(result.y, 2)

    def test_mul(self):
        result = Vector2(1, 2) * Vector2(3, 4)

        self.assertEqual(result.x, 3)
        self.assertEqual(result.y, 8)

    def test_div(self):
        result = Vector2(8, 8) / Vector2(2, 4)

        self.assertEqual(result.x, 4)
        self.assertEqual(result.y, 2)

    def test_dot(self):
        result = Vector2(1, 2).dot(Vector2(3, 4))

        self.assertEqual(result, 11)

    def test_cross(self):
        result = Vector2(1, 2).cross(Vector2(3, 4))

        self.assertEqual(result, -2)

    def test_angle(self):
        result = Vector2(1, 2).angle

        self.assertEqual(result, 1.1071487665176392)

    def test_length(self):
        result = Vector2(1, 2).length

        self.assertEqual(result, 2.23606797749979)

    def test_length2(self):
        result = Vector2(1, 2).length2

        self.assertEqual(result, 5.0)

    def test_unit(self):
        vector = Vector2(1, 2)
        vector.unit()

        self.assertEqual(vector.x, 0.4472135901451111)
        self.assertEqual(vector.y, 0.8944271802902222)

    def test_scale(self):
        vector = Vector2(1, 2)
        vector.scale(0.5)

        self.assertEqual(vector.x, 0.5)
        self.assertEqual(vector.y, 1.0)


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
