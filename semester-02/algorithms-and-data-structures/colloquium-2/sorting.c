#define _POSIX_C_SOURCE 200809L
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <time.h>

static unsigned long long comparisons, swaps, writes;

static int less(int a, int b) {
    comparisons++;
    return a < b;
}

static void put(int *a, int i, int value) {
    a[i] = value;
    writes++;
}

static void swap(int *a, int i, int j) {
    if (i == j) return;
    int temp = a[i];
    put(a, i, a[j]);
    put(a, j, temp);
    swaps++;
}

static void bubble(int *a, int n) {
    for (int end=n-1; end>0; end--) {
        int changed=0;
        for (int j=0; j<end; j++) {
            if (less(a[j+1], a[j])) {
                swap(a,j,j+1);
                changed=1;
            }
        }
        if (!changed) break;
    }
}

static void selection(int *a, int n) {
    for (int i=0; i<n-1; i++) {
        int min=i;
        for (int j=i+1; j<n; j++)
            if (less(a[j],a[min])) min=j;
        swap(a,i,min);
    }
}

static void insertion(int *a, int n) {
    for (int i=1; i<n; i++) {
        int value=a[i], j=i;
        while (j>0 && less(value,a[j-1])) {
            put(a,j,a[j-1]);
            j--;
        }
        put(a,j,value);
    }
}

static void binary_insertion(int *a, int n) {
    for (int i=1; i<n; i++) {
        int value=a[i], left=0, right=i;
        while (left<right) {
            int mid=(left+right)/2;
            if (less(value,a[mid])) right=mid;
            else left=mid+1;
        }
        for (int j=i; j>left; j--) put(a,j,a[j-1]);
        put(a,left,value);
    }
}

static void shell(int *a, int n) {
    for (int gap=n/2; gap>0; gap/=2) {
        for (int i=gap; i<n; i++) {
            int value=a[i], j=i;
            while (j>=gap && less(value,a[j-gap])) {
                put(a,j,a[j-gap]);
                j-=gap;
            }
            put(a,j,value);
        }
    }
}

static void merge_part(int *a, int *tmp, int l, int r) {
    if (r-l<2) return;
    int mid=(l+r)/2, i=l, j=mid, k=l;
    merge_part(a,tmp,l,mid);
    merge_part(a,tmp,mid,r);
    while (i<mid && j<r) {
        if (less(a[j],a[i])) put(tmp,k++,a[j++]);
        else put(tmp,k++,a[i++]);
    }
    while (i<mid) put(tmp,k++,a[i++]);
    while (j<r) put(tmp,k++,a[j++]);
    for (k=l;k<r;k++) put(a,k,tmp[k]);
}

static void merge(int *a, int n) {
    int *tmp=malloc((size_t)n*sizeof(int));
    if (!tmp) exit(2);
    merge_part(a,tmp,0,n);
    free(tmp);
}

static void quick_part(int *a, int l, int r) {
    while (l<r) {
        int i=l,j=r,pivot=a[l+(r-l)/2];
        while (i<=j) {
            while (less(a[i],pivot)) i++;
            while (less(pivot,a[j])) j--;
            if (i<=j) {
                swap(a,i,j);
                i++; j--;
            }
        }
        if (j-l<r-i) {
            if (l<j) quick_part(a,l,j);
            l=i;
        } else {
            if (i<r) quick_part(a,i,r);
            r=j;
        }
    }
}

static void quick(int *a, int n) {
    quick_part(a,0,n-1);
}

static void sift(int *a, int root, int size) {
    while (root*2+1<size) {
        int child=root*2+1;
        if (child+1<size && less(a[child],a[child+1])) child++;
        if (!less(a[root],a[child])) break;
        swap(a,root,child);
        root=child;
    }
}

static void heap(int *a, int n) {
    for (int i=n/2-1;i>=0;i--) sift(a,i,n);
    for (int end=n-1;end>0;end--) {
        swap(a,0,end);
        sift(a,0,end);
    }
}

/* Генератор использует целые числа 0..65535. */
static void counting(int *a, int n) {
    int *count=calloc(65536,sizeof(int));
    int *out=malloc((size_t)n*sizeof(int));
    if (!count || !out) exit(2);
    for (int i=0;i<n;i++) count[a[i]]++;
    for (int i=1;i<65536;i++) count[i]+=count[i-1];
    for (int i=n-1;i>=0;i--) put(out,--count[a[i]],a[i]);
    for (int i=0;i<n;i++) put(a,i,out[i]);
    free(count); free(out);
}

static void radix(int *a, int n) {
    int *out=malloc((size_t)n*sizeof(int));
    if (!out) exit(2);
    for (int shift=0;shift<16;shift+=8) {
        int count[256]={0};
        for (int i=0;i<n;i++) count[(a[i]>>shift)&255]++;
        for (int i=1;i<256;i++) count[i]+=count[i-1];
        for (int i=n-1;i>=0;i--) put(out,--count[(a[i]>>shift)&255],a[i]);
        for (int i=0;i<n;i++) put(a,i,out[i]);
    }
    free(out);
}

static void msd_part(int *a,int l,int r,int bit) {
    if (r-l<2 || bit<0) return;
    int i=l,j=r-1;
    while (i<=j) {
        while (i<=j && ((a[i]>>bit)&1)==0) i++;
        while (i<=j && ((a[j]>>bit)&1)==1) j--;
        if (i<j) { swap(a,i,j); i++; j--; }
    }
    msd_part(a,l,i,bit-1);
    msd_part(a,i,r,bit-1);
}

static void msd(int *a,int n) {
    msd_part(a,0,n,15);
}

static int compare(const void *a,const void *b) {
    int x=*(const int*)a,y=*(const int*)b;
    return (x>y)-(x<y);
}

int main(int argc,char **argv) {
    if (argc!=3) {
        fprintf(stderr,"Usage: sorting algorithm size\n");
        return 1;
    }
    const char *name=argv[1];
    int n=atoi(argv[2]);
    if (n<1 || n>1000000) return 1;
    void (*sort)(int*,int)=NULL;
    if (!strcmp(name,"bubble")) sort=bubble;
    else if (!strcmp(name,"selection")) sort=selection;
    else if (!strcmp(name,"insertion")) sort=insertion;
    else if (!strcmp(name,"binary_insertion")) sort=binary_insertion;
    else if (!strcmp(name,"shell")) sort=shell;
    else if (!strcmp(name,"merge")) sort=merge;
    else if (!strcmp(name,"heap")) sort=heap;
    else if (!strcmp(name,"quick")) sort=quick;
    else if (!strcmp(name,"counting")) sort=counting;
    else if (!strcmp(name,"radix")) sort=radix;
    else if (!strcmp(name,"msd")) sort=msd;
    if (sort==NULL) return 1;

    int *a=malloc((size_t)n*sizeof(int));
    int *reference=malloc((size_t)n*sizeof(int));
    if (!a || !reference) return 2;
    uint32_t state=123456789;
    for (int i=0;i<n;i++) {
        state=state*1664525u+1013904223u;
        a[i]=(int)((state>>8)&65535);
        reference[i]=a[i];
    }
    struct timespec start,end;
    clock_gettime(CLOCK_MONOTONIC,&start);
    sort(a,n);
    clock_gettime(CLOCK_MONOTONIC,&end);
    double seconds=end.tv_sec-start.tv_sec+(end.tv_nsec-start.tv_nsec)/1e9;
    qsort(reference,n,sizeof(int),compare);
    if (memcmp(a,reference,(size_t)n*sizeof(int))) {
        fprintf(stderr,"incorrect sorting\n");
        return 3;
    }
    printf("%.9f,%llu,%llu,%llu\n",seconds,comparisons,swaps,writes);
    free(a); free(reference);
    return 0;
}
