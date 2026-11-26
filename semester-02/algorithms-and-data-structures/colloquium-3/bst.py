import sys

VARIANTS = [
    ([41,71,25,24,60,68,26,4,77,12,52,62,21,31,30],[68,12,30],[41,25,60]),
    ([47,40,22,61,95,9,93,39,43,38,59,25,60,71,32],[38,60,32],[47,22,61]),
    ([46,26,2,79,76,99,41,37,51,6,97,35,93,10,21],[97,10,35],[46,99,26]),
    ([48,52,15,54,79,56,46,73,65,94,9,85,7,33,8],[73,85,8],[48,79,15]),
    ([41,27,44,13,17,37,65,33,40,84,59,69,7,60,67],[69,33,60],[41,65,27]),
    ([53,13,66,55,63,24,77,82,44,40,18,86,15,68,30],[82,40,30],[53,66,13]),
    ([81,42,57,87,25,52,6,32,91],[42,91,25],[42,91,25,81]),
    ([44,50,11,49,23,15,87,1,27],[11,44,49],[11,44,49,50]),
    ([58,78,23,47,4,80,44,56,93],[58,23,80],[58,23,80,4]),
    ([54,29,97,37,55,4,34,96,98],[29,54,37],[29,54,37,98]),
    ([62,81,34,4,82,41,79,96,84],[81,34,62],[81,34,62,96]),
    ([56,23,36,22,87,44,25,73,11],[23,56,36],[23,56,36]),
]


class Node:
    def __init__(self, key, value):
        self.key=key
        self.value=value
        self.left=None
        self.right=None


def bstree_create():
    return None


def bstree_add(root,key,value):
    if root is None:
        return Node(key,value)
    if key<root.key:
        root.left=bstree_add(root.left,key,value)
    elif key>root.key:
        root.right=bstree_add(root.right,key,value)
    else:
        root.value=value
    return root


def bstree_lookup(root,key):
    while root:
        if key==root.key:
            return root
        root=root.left if key<root.key else root.right
    return None


def bstree_min(root):
    if root:
        while root.left:
            root=root.left
    return root


def bstree_max(root):
    if root:
        while root.right:
            root=root.right
    return root


def bstree_delete(root,key):
    if root is None:
        return None
    if key<root.key:
        root.left=bstree_delete(root.left,key)
    elif key>root.key:
        root.right=bstree_delete(root.right,key)
    else:
        if root.left is None:
            return root.right
        if root.right is None:
            return root.left
        successor=bstree_min(root.right)
        root.key,root.value=successor.key,successor.value
        root.right=bstree_delete(root.right,successor.key)
    return root


def inorder(root):
    if root:
        yield from inorder(root.left)
        yield root.key
        yield from inorder(root.right)


def demo(n):
    variant=n%12+1
    keys,search,delete=VARIANTS[variant-1]
    root=bstree_create()
    for key in keys:
        root=bstree_add(root,key,f"value {key}")
    print("Вариант",variant)
    print("Ключи:",list(inorder(root)))
    for key in search:
        node=bstree_lookup(root,key)
        print(key,node.value if node else "Нет")
    extreme=bstree_min(root) if variant%2 else bstree_max(root)
    print("Min/max:",extreme.key)
    for key in delete:
        root=bstree_delete(root,key)
    print("После удаления:", list(inorder(root)))


if __name__=="__main__":
    demo(int(sys.argv[1]))
