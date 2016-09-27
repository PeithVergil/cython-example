from random import randint
from unittest import TestCase

from mathix import Node, QTree, Rectangle


class DummyObject(object):

    def __init__(self, name, bounds):
        self.name = name
        self.bounds = bounds

    def __str__(self):
        s = 'DummyObject(name={}, bounds=({}, {}, {}, {}))'

        return s.format(self.name,
                        self.bounds.x,
                        self.bounds.y,
                        self.bounds.w,
                        self.bounds.h)


class TestNode(TestCase):

    def setUp(self):
        self.node = Node(1, Rectangle(0, 0, 800, 600))

    def tearDown(self):
        self.node.clear()

    def test_str(self):
        node_str = 'Node(level=1, bounds=(0.0, 0.0, 800.0, 600.0))'

        self.assertEqual(str(self.node), node_str)

    def test_init(self):
        self.assertEqual(self.node.level, 1)

        bounds = str(self.node.bounds)

        self.assertEqual(bounds, 'Rectangle(x=0.0, y=0.0, w=800.0, h=600.0)')

    def test_split_level(self):
        self.node.split()

        self.assertEqual(self.node.child1.level, 2)
        self.assertEqual(self.node.child2.level, 2)
        self.assertEqual(self.node.child3.level, 2)
        self.assertEqual(self.node.child4.level, 2)

    def test_split_bounds(self):
        self.node.split()

        tl = str(self.node.child1.bounds)
        tr = str(self.node.child2.bounds)
        bl = str(self.node.child3.bounds)
        br = str(self.node.child4.bounds)

        self.assertEqual(tl, 'Rectangle(x=0.0, y=300.0, w=400.0, h=300.0)')
        self.assertEqual(tr, 'Rectangle(x=400.0, y=300.0, w=400.0, h=300.0)')
        self.assertEqual(bl, 'Rectangle(x=0.0, y=0.0, w=400.0, h=300.0)')
        self.assertEqual(br, 'Rectangle(x=400.0, y=0.0, w=400.0, h=300.0)')

    def test_insert_true(self):
        """
        Try inserting objects that can fit inside.
        """
        objects = [
            DummyObject('test_insert_true', Rectangle(1, 1, 10, 10)),
            DummyObject('test_insert_true', Rectangle(10, 10, 50, 50)),
            DummyObject('test_insert_true', Rectangle(450, 310, 50, 50))
        ]

        for obj in objects:
            self.assertTrue(self.node.insert(obj))

    def test_insert_false(self):
        """
        Try inserting objects that can't fit inside.
        """
        objects = [
            DummyObject('test_insert_false', Rectangle(-50, 100, 50, 50)),
            DummyObject('test_insert_false', Rectangle(700, 700, 50, 50)),
            DummyObject('test_insert_false', Rectangle(900, 900, 50, 50)),
        ]

        for obj in objects:
            self.assertFalse(self.node.insert(obj))

    def test_select(self):
        objects = [
            DummyObject('test_select', Rectangle(1, 1, 10, 10)),
            DummyObject('test_select', Rectangle(10, 10, 50, 50)),
            DummyObject('test_select', Rectangle(450, 310, 50, 50))
        ]

        for obj in objects:
            self.node.insert(obj)

        node = self.node.select(Rectangle(450, 310, 50, 50))

        node_str = 'Node(level=3, bounds=(400.0, 300.0, 200.0, 150.0))'

        self.assertEqual(str(node), node_str)

    def test_select_1000(self):
        for n in range(1000):
            name = 'test_select_{}'.format(n)

            x, y = randint(0, 750), randint(0, 550)

            self.node.insert(DummyObject(name, Rectangle(x, y, 50, 50)))

        node = self.node.select(Rectangle(450, 310, 50, 50))

        node_str = 'Node(level=3, bounds=(400.0, 300.0, 200.0, 150.0))'

        self.assertEqual(str(node), node_str)


class TestQTree(TestCase):

    def setUp(self):
        self.qtree = QTree(Rectangle(0, 0, 800, 600))

    def tearDown(self):
        self.qtree.clear()

    def test_insert_true(self):
        """
        Try inserting objects that can fit inside.
        """
        objects = [
            DummyObject('test_insert_true', Rectangle(1, 1, 10, 10)),
            DummyObject('test_insert_true', Rectangle(10, 10, 50, 50)),
            DummyObject('test_insert_true', Rectangle(450, 310, 50, 50))
        ]

        for obj in objects:
            self.assertTrue(self.qtree.insert(obj))

    def test_insert_false(self):
        """
        Try inserting objects that can't fit inside.
        """
        objects = [
            DummyObject('test_insert_false', Rectangle(-50, 100, 50, 50)),
            DummyObject('test_insert_false', Rectangle(700, 700, 50, 50)),
            DummyObject('test_insert_false', Rectangle(900, 900, 50, 50)),
        ]

        for obj in objects:
            self.assertFalse(self.qtree.insert(obj))

    def test_select(self):
        objects = [
            DummyObject('test_select', Rectangle(1, 1, 10, 10)),
            DummyObject('test_select', Rectangle(10, 10, 50, 50)),
            DummyObject('test_select', Rectangle(450, 310, 50, 50))
        ]

        for obj in objects:
            self.qtree.insert(obj)

        node = self.qtree.select(Rectangle(450, 310, 50, 50))

        node_str = 'Node(level=3, bounds=(400.0, 300.0, 200.0, 150.0))'

        self.assertEqual(str(node), node_str)
