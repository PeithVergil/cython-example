from unittest import TestCase

from mathix import Matrix4


class TestMatrix4(TestCase):

    def test_str(self):
        values = [
            1, 2, 3, 4, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
        ]

        results = 'Matrix4([{0}])'.format(
            ', '.join('{0:0.2f}'.format(value) for value in values)
        )

        self.assertEqual(str(Matrix4(values)), results)
