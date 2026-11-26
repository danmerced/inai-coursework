#include <stdio.h>
#include <stdlib.h>
#define MAX_DEGREE 32

typedef struct Tree {
    int value;
    int degree;
    struct Tree *child,*sibling;
} Tree;

typedef struct Queue {
    Tree *roots[MAX_DEGREE];
} Queue;

Tree *join(Tree *a,Tree *b) {
    if (a->value<b->value) {
        Tree *t=a; a=b; b=t;
    }
    b->sibling=a->child;
    a->child=b;
    a->degree++;
    return a;
}

void add_tree(Queue *q,Tree *t) {
    t->sibling=NULL;
    while (t->degree<MAX_DEGREE && q->roots[t->degree]) {
        int degree=t->degree;
        t=join(q->roots[degree],t);
        q->roots[degree]=NULL;
    }
    if (t->degree>=MAX_DEGREE) exit(1);
    q->roots[t->degree]=t;
}

void push(Queue *q,int value) {
    Tree *node=calloc(1,sizeof(Tree));
    if (!node) exit(1);
    node->value=value;
    add_tree(q,node);
}

void merge(Queue *q,Queue *other) {
    if (q==other) return;
    for (int i=0;i<MAX_DEGREE;i++) {
        if (other->roots[i]) {
            add_tree(q,other->roots[i]);
            other->roots[i]=NULL;
        }
    }
}

int pop(Queue *q,int *value) {
    int best=-1;
    for (int i=0;i<MAX_DEGREE;i++)
        if (q->roots[i] && (best<0 || q->roots[i]->value>q->roots[best]->value)) best=i;
    if (best<0) return 0;
    Tree *root=q->roots[best];
    q->roots[best]=NULL;
    *value=root->value;
    Tree *child=root->child;
    while (child) {
        Tree *next=child->sibling;
        add_tree(q,child);
        child=next;
    }
    free(root);
    return 1;
}

int main(void) {
    Queue q={0},other={0};
    push(&q,7); push(&q,1); push(&q,9);
    push(&other,5); push(&other,3); push(&other,8);
    merge(&q,&other);
    int value;
    while (pop(&q,&value)) printf("%d ", value);
    puts("");
    return 0;
}
