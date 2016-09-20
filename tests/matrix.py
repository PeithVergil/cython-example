from math import ceil
from unittest import TestCase

from mathix import Matrix22, Matrix33, Matrix44, Vector2


class TestMatrix22(TestCase):

    def test_str(self):
        string = 'Matrix22(1.0, 2.0, 3.0, 4.0)'

        matrix = Matrix22(1, 2, 3, 4)

        self.assertEqual(str(matrix), string)

    def test_mul(self):
        a = Matrix22.identity()
        b = Matrix22.scaling(0.5, 0.5)

        c = a * b

        self.assertEqual((c.m00, c.m01, c.m10, c.m11), (0.5, 0.0, 0.0, 0.5))

    def test_identity(self):
        matrix = Matrix22.identity()

        values = [matrix.m00, matrix.m01,
                  matrix.m10, matrix.m11]

        self.assertEqual(values, [1.0, 0.0,
                                  0.0, 1.0])

    def test_scaling(self):
        matrix = Matrix22.scaling(0.5, 0.5)

        vector = matrix.transform(Vector2(1.0, 1.0))

        self.assertEqual((vector.x, vector.y), (0.5, 0.5))

    def test_rotation(self):
        matrix = Matrix22.rotation(90)

        vector = matrix.transform(Vector2(1.0, 1.0))

        self.assertEqual((vector.x, vector.y), (-1.0, 1.0))

    def test_transform(self):
        matrix = Matrix22.identity()

        vector = matrix.transform(Vector2(1.0, 2.0))

        self.assertEqual((vector.x, vector.y), (1.0, 2.0))

    def test_determinant(self):
        matrix = Matrix22.identity()

        self.assertEqual(matrix.determinant, 1.0)


class TestMatrix33(TestCase):

    def test_str(self):
        string = 'Matrix33(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0)'

        matrix = Matrix33(1, 2, 3, 4, 5, 6, 7, 8, 9)

        self.assertEqual(str(matrix), string)

    def test_mul(self):
        a = Matrix33.identity()
        b = Matrix33.scaling(0.5, 0.5)

        c = a * b

        self.assertEqual((c.m00, c.m01, c.m10, c.m11), (0.5, 0.0, 0.0, 0.5))

    def test_identity(self):
        matrix = Matrix33.identity()

        values = [matrix.m00, matrix.m01,
                  matrix.m10, matrix.m11]

        self.assertEqual(values, [1.0, 0.0,
                                  0.0, 1.0])

    def test_scaling(self):
        matrix = Matrix33.scaling(0.5, 0.5)

        vector = matrix.transform(Vector2(1.0, 1.0))

        self.assertEqual((vector.x, vector.y), (0.5, 0.5))

    def test_rotation(self):
        matrix = Matrix33.rotation(90)

        vector = matrix.transform(Vector2(1.0, 1.0))

        # Fix floating point issues.
        x, y = ceil(vector.x), ceil(vector.y)

        self.assertEqual((x, y), (-1.0, 1.0))

    def test_transform(self):
        matrix = Matrix33.identity()

        vector = matrix.transform(Vector2(1.0, 2.0))

        self.assertEqual((vector.x, vector.y), (1.0, 2.0))


class TestMatrix44(TestCase):

    def test_str(self):
        values = [
            1, 2, 3, 4, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
        ]

        results = 'Matrix44([{0}])'.format(
            ', '.join('{0:0.2f}'.format(value) for value in values)
        )

        self.assertEqual(str(Matrix44(values)), results)
