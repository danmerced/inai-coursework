#include <stdio.h>

void linear_search(const int *a, int size, int key) {
    for (int i=0;i<size;i++)
        if (a[i]==key) printf("%d ",i);
    puts("");
}

/* Для отсортированного массива: найдём первое вхождение. */
void binary_search_all(const int *a,int size,int key) {
    int left=0,right=size;
    while (left<right) {
        int mid=(left+right)/2;
        if (a[mid]<key) left=mid+1;
        else right=mid;
    }
    while (left<size && a[left]==key) printf("%d ",left++);
    puts("");
}

int main(void) {
    int a[]={1,2,2,3,5,5,5,7};
    int n=sizeof(a)/sizeof(a[0]);
    linear_search(a,n,5);
    binary_search_all(a,n,5);
    return 0;
}
