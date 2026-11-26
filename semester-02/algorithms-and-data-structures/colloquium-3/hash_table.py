import sys

DELETED = object()


def hashtab_hash(key, size, family=1):
    value=0
    for char in str(key):
        value=(value*31+ord(char)) if family==1 else (value*37+ord(char))
    return value%size


def hashtab_init(variant, size=53):
    if not 1<=variant<=10:
        raise ValueError("Вариант 1..10")
    return HashTable(size,(variant-1)%5,1 if variant<=5 else 2)


class HashTable:
    def __init__(self,size,method,family):
        self.size=size
        self.method=method
        self.family=family
        self.cells=[[] for _ in range(size)] if method<2 else [None]*size

    def positions(self,key):
        start=hashtab_hash(key,self.size,self.family)
        step=1+hashtab_hash(key,self.size-1,3-self.family)
        for i in range(self.size):
            if self.method==2:
                offset=i
            elif self.method==3:
                offset=i*i
            else:
                offset=i*step
            yield (start+offset)%self.size


def hashtab_add(table,key,value):
    if table.method<2:
        bucket=table.cells[hashtab_hash(key,table.size,table.family)]
        for i,(old,_) in enumerate(bucket):
            if old==key:
                bucket[i]=(key,value)
                return
        bucket.append((key,value))
        if table.method==1:
            bucket.sort(key=lambda pair:str(pair[0]))
        return
    first_deleted=None
    for position in table.positions(key):
        cell=table.cells[position]
        if cell is DELETED:
            if first_deleted is None:
                first_deleted=position
        elif cell is None:
            position=position if first_deleted is None else first_deleted
            table.cells[position]=(key,value)
            return
        elif cell[0]==key:
            table.cells[position]=(key,value)
            return
    if first_deleted is not None:
        table.cells[first_deleted]=(key,value)
        return
    raise OverflowError("Нет свободной позиции")


def hashtab_lookup(table,key):
    if table.method<2:
        for old,value in table.cells[hashtab_hash(key,table.size,table.family)]:
            if old==key:
                return value
        return None
    for position in table.positions(key):
        cell=table.cells[position]
        if cell is None:
            break
        if cell is not DELETED and cell[0]==key:
            return cell[1]
    return None


def hashtab_delete(table,key):
    if table.method<2:
        bucket=table.cells[hashtab_hash(key,table.size,table.family)]
        for i,(old,_) in enumerate(bucket):
            if key==old:
                del bucket[i]
                return True
        return False
    for position in table.positions(key):
        cell=table.cells[position]
        if cell is None:
            break
        if cell is not DELETED and cell[0]==key:
            table.cells[position]=DELETED
            return True
    return False


if __name__=="__main__":
    variant=int(sys.argv[1])%10+1
    table=hashtab_init(variant)
    for i in range(10):
        hashtab_add(table,"key"+str(i),i*10)
    print("Вариант",variant)
    print("key5:",hashtab_lookup(table,"key5"))
    hashtab_delete(table,"key5")
    print("После удаления:",hashtab_lookup(table,"key5"))
