#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void direct(const char *text,const char *p) {
    int n=strlen(text),m=strlen(p);
    for (int i=0;i<=n-m;i++) {
        int j=0;
        while (j<m && text[i+j]==p[j]) j++;
        if (j==m) printf("%d ",i);
    }
    puts("");
}

void kmp(const char *text,const char *p) {
    int n=strlen(text),m=strlen(p);
    if (m==0) { direct(text,p); return; }
    int *prefix=calloc(m,sizeof(int));
    if (!prefix) exit(1);
    int j=0;
    for (int i=1;i<m;i++) {
        while (j && p[i]!=p[j]) j=prefix[j-1];
        if (p[i]==p[j]) j++;
        prefix[i]=j;
    }
    j=0;
    for (int i=0;i<n;i++) {
        while (j && text[i]!=p[j]) j=prefix[j-1];
        if (text[i]==p[j]) j++;
        if (j==m) {
            printf("%d ",i-j+1);
            j=prefix[j-1];
        }
    }
    free(prefix);
    puts("");
}

void boyer_moore(const char *text,const char *p) {
    int n=strlen(text),m=strlen(p),last[256];
    if (m==0) { direct(text,p); return; }
    for (int i=0;i<256;i++) last[i]=-1;
    for (int i=0;i<m;i++) last[(unsigned char)p[i]]=i;
    for (int i=0;i<=n-m;) {
        int j=m-1;
        while (j>=0 && text[i+j]==p[j]) j--;
        if (j<0) {
            printf("%d ",i);
            i++;
        } else {
            int shift=j-last[(unsigned char)text[i+j]];
            i+=shift>0?shift:1;
        }
    }
    puts("");
}

int main(void) {
    const char *s="ABABABACABABA",*p="ABA";
    direct(s,p);
    kmp(s,p);
    boyer_moore(s,p);
    return 0;
}
