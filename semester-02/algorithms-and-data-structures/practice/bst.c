#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int key;
    struct Node *left,*right;
} Node;

Node *insert(Node *root,int key) {
    if (!root) {
        root=calloc(1,sizeof(Node));
        if (!root) exit(1);
        root->key=key;
    } else if (key<root->key) root->left=insert(root->left,key);
    else if (key>root->key) root->right=insert(root->right,key);
    return root;
}

Node *find(Node *root,int key) {
    while (root && root->key!=key) root=key<root->key?root->left:root->right;
    return root;
}

Node *min_node(Node *root) {
    while (root && root->left) root=root->left;
    return root;
}

Node *delete(Node *root,int key) {
    if (!root) return NULL;
    if (key<root->key) root->left=delete(root->left,key);
    else if (key>root->key) root->right=delete(root->right,key);
    else {
        if (!root->left || !root->right) {
            Node *next=root->left?root->left:root->right;
            free(root);
            return next;
        }
        Node *next=min_node(root->right);
        root->key=next->key;
        root->right=delete(root->right,next->key);
    }
    return root;
}

void print(Node *root) {
    if (root) { print(root->left); printf("%d ",root->key); print(root->right); }
}

void clear(Node *root) {
    if (root) { clear(root->left); clear(root->right); free(root); }
}

int main(void) {
    int keys[]={7,4,9,2,6,8,12};
    Node *root=NULL;
    for (int i=0;i<7;i++) root=insert(root,keys[i]);
    print(root); puts("");
    printf("6: %s\n",find(root,6)?"found":"not found");
    root=delete(root,7);
    print(root); puts("");
    clear(root);
    return 0;
}
