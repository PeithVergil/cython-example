from .shapes cimport Rectangle


cdef enum:
    MAX_LEVEL = 3


cdef class Node:
    """
    The tree level.
    """
    cdef public int level

    """
    The child nodes.
    """
    cdef public Node child1
    cdef public Node child2
    cdef public Node child3
    cdef public Node child4

    """
    The area contained by the node.
    """
    cdef public Rectangle bounds

    """
    The objects contained by the node.
    """
    cdef public list objects

    cdef void _split(self)

    cdef bint _insert(self, object obj)

    cdef Node _select(self, Rectangle bounds)
