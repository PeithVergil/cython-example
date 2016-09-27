from .shapes cimport Rectangle
from .utils cimport _rectangle_in_rectangle


cdef class Node:

    def __cinit__(self, int level, Rectangle bounds):
        self.level = level
        self.bounds = bounds
        self.objects = []

    cdef void _clear(self):
        self.objects = []

        # Clear the child nodes.
        if self.child1 is not None or \
           self.child2 is not None or \
           self.child3 is not None or \
           self.child4 is not None:
            self.child1._clear()
            self.child2._clear()
            self.child3._clear()
            self.child4._clear()

    cdef void _split(self):
        cdef int node_lvl

        cdef float node_w, node_h, l, b, r, t

        # Check if there are no child nodes.
        if self.child1 is None or \
           self.child2 is None or \
           self.child3 is None or \
           self.child4 is None:
            node_lvl = self.level + 1

            node_w = self.bounds.w / 2
            node_h = self.bounds.h / 2

            l = self.bounds.x
            b = self.bounds.y
            r = self.bounds.x + node_w
            t = self.bounds.y + node_h

            self.child1 = Node(node_lvl, Rectangle(l, t, node_w, node_h))
            self.child2 = Node(node_lvl, Rectangle(r, t, node_w, node_h))
            self.child3 = Node(node_lvl, Rectangle(l, b, node_w, node_h))
            self.child4 = Node(node_lvl, Rectangle(r, b, node_w, node_h))

    cdef bint _insert(self, object obj):
        if not _rectangle_in_rectangle(obj.bounds, self.bounds):
            return False

        if self.level < MAX_LEVEL:
            self._split()

            # Try inserting the object to one of its
            # children, else insert to current node.
            if self.child1._insert(obj) or \
               self.child2._insert(obj) or \
               self.child3._insert(obj) or \
               self.child4._insert(obj):
                return True

        self.objects.append(obj)

        # print('')
        # print('--------------------------------------')
        # print('insert {} in {}'.format(obj, str(self)))
        # print('--------------------------------------')

        return True

    cdef Node _select(self, Rectangle bounds):
        cdef Node node

        if not _rectangle_in_rectangle(bounds, self.bounds):
            return None

        # Check if there are child nodes.
        if self.child1 is not None or \
           self.child2 is not None or \
           self.child3 is not None or \
           self.child4 is not None:
            node = self.child1._select(bounds)
            if node is not None:
                return node

            node = self.child2._select(bounds)
            if node is not None:
                return node

            node = self.child3._select(bounds)
            if node is not None:
                return node

            node = self.child4._select(bounds)
            if node is not None:
                return node

        return self

    def split(self):
        """
        Split the bounds into four equal quadrants.
        """
        self._split()

    def clear(self):
        """
        Clear the objects recursively.
        """
        self._clear()

    def insert(self, object obj):
        """
        Insert the object to the child nodes or the parent node.
        """
        return self._insert(obj)

    def select(self, Rectangle bounds):
        """
        Return the node that contains the given bounds.
        """
        return self._select(bounds)

    def print_tree(self):
        """
        Print the tree for debugging purposes.
        """
        padding = '....' * (self.level - 1)

        print('')
        print('{}{} >> '.format(padding, str(self)))

        padding = '    ' * (self.level - 1)

        objects = [str(o) for o in self.objects]

        print('')
        print('{}     objects: {} '.format(padding, objects))
        print('{}      child1: {} '.format(padding, str(self.child1)))
        print('{}      child2: {} '.format(padding, str(self.child2)))
        print('{}      child3: {} '.format(padding, str(self.child3)))
        print('{}      child4: {} '.format(padding, str(self.child4)))

        # Check if there are child nodes.
        if self.child1 is not None or \
           self.child2 is not None or \
           self.child3 is not None or \
           self.child4 is not None:
            self.child1.print_tree()
            self.child2.print_tree()
            self.child3.print_tree()
            self.child4.print_tree()

    def __str__(self):
        s = 'Node(level={}, bounds=({}, {}, {}, {}))'

        return s.format(self.level,
                        self.bounds.x,
                        self.bounds.y,
                        self.bounds.w,
                        self.bounds.h)


class QTree(object):

    def __init__(self, bounds):
        self.root = Node(1, bounds)

    def insert(self, obj):
        return self.root.insert(obj)

    def select(self, bounds):
        return self.root.select(bounds)

    def clear(self):
        self.root.clear()
