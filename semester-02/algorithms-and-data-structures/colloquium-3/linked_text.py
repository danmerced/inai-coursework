import argparse
from pathlib import Path


class linkable:
    def __init__(self, word):
        self.word = word
        self.next = None


class linkableTwo(linkable):
    def __init__(self, word):
        super().__init__(word)
        self.prev = None


class ListWithCursor:
    circular = False
    double = False

    def __init__(self):
        self.head = None
        self.tail = None
        self.cursor = None
        self.size = 0

    def append(self, word):
        node = linkableTwo(word) if self.double else linkable(word)
        if self.head is None:
            self.head = node
        else:
            self.tail.next = node
            if self.double:
                node.prev = self.tail
        self.tail = node
        if self.circular:
            self.tail.next = self.head
            if self.double:
                self.head.prev = self.tail
        self.size += 1

    def reset(self):
        self.cursor = self.head

    def __iter__(self):
        self.reset()
        for _ in range(self.size):
            word = self.cursor.word
            self.cursor = self.cursor.next
            yield word

    def replace(self, words):
        self.head = self.tail = self.cursor = None
        self.size = 0
        for word in words:
            self.append(word)


class linkedList(ListWithCursor):
    pass


class linkedListCircular(ListWithCursor):
    circular = True


class linkedListTwo(ListWithCursor):
    double = True


class linkedListTwoCircular(ListWithCursor):
    circular = True
    double = True


def repeated_letters(word):
    return len(set(word.lower())) < len(word)


def transform(words, rule):
    if rule == 1:
        target = next((w for w in words if repeated_letters(w)), None)
        found = False
        result=[]
        for w in words:
            if w == target:
                if found:
                    continue
                found = True
            result.append(w)
        return result
    if rule == 2:
        result=[]
        for w in words:
            if w == "or":
                continue
            if result:
                result.append("or")
            result.append(w)
        return result
    if rule == 3:
        return [w for w in words if not repeated_letters(w)]
    if rule == 4:
        result=[]
        for i in range(0,len(words),2):
            if i+1 < len(words):
                result.extend([words[i+1][::-1],words[i]])
            else:
                result.append(words[i])
        return result
    if rule == 5:
        return [w[:-4]+w[-1] if len(w)>4 else w for w in words if len(w)>=4]
    if rule == 6:
        target=next((w for w in words if len(w)==1),None)
        return ["yes" if w==target else w for w in words if len(w)!=1 or w==target]
    if rule == 7:
        index=next((i for i in range(len(words)-1,-1,-1) if len(words[i])==2),None)
        if index is None:
            return words
        return [w for i,w in enumerate(words) if w!=words[index] or i==index]
    if rule == 8:
        result=[]
        for i in range(0,len(words),3):
            result.extend(words[i:i+3])
            if i+2<len(words):
                result.append(words[i])
        return result
    if rule == 9:
        target=next((w for w in words if len(w)==1),None)
        positions=[i for i,w in enumerate(words) if w==target]
        if len(positions)<3:
            return words
        return words[:positions[1]+1]+words[positions[2]:]
    if rule == 10:
        seen=set()
        result=[]
        for w in words:
            first=w[0].lower()
            if first not in seen:
                seen.add(first)
                result.append(w)
        return result
    if rule == 11:
        return ["".join(words[i:i+2]) for i in range(0,len(words),2)]
    if rule == 12:
        result=[]
        for w in words:
            if w.lower()!=w.lower()[::-1]:
                result.extend([w,w[::-1]])
        return result
    raise ValueError("Правило 1..12")


class Text:
    def __init__(self, list_type):
        self.words = list_type()

    def read(self, path):
        self.words.replace(Path(path).read_text(encoding="utf-8").split())

    def process(self, rule):
        self.words.replace(transform(list(self.words), rule))

    def format(self, width, alignment):
        if width <= 0:
            raise ValueError("Ширина должна быть положительной")
        lines=[]
        line=""
        for word in self.words:
            if len(word)>width:
                raise ValueError("Слово длиннее заданной ширины")
            if line and len(line)+1+len(word)>width:
                lines.append(line)
                line=word
            else:
                line=(line+" "+word).strip()
        if line:
            lines.append(line)
        if alignment==1:
            return [line.ljust(width) for line in lines]
        if alignment==2:
            return [line.rjust(width) for line in lines]
        if alignment==3:
            return [line.center(width) for line in lines]
        raise ValueError("Выравнивание 1..3")


if __name__ == "__main__":
    parser=argparse.ArgumentParser()
    parser.add_argument("file")
    parser.add_argument("number",type=int)
    parser.add_argument("--width",type=int,default=40)
    args=parser.parse_args()
    n=args.number
    if n<1:
        parser.error("Номер должен быть положительным")
    # Для нулевого остатка принят последний вариант соответствующего списка.
    lists=[linkedList,linkedListCircular,linkedListTwo,linkedListTwoCircular]
    text=Text(lists[(n%4 or 4)-1])
    text.read(args.file)
    text.process(n%12 or 12)
    print("\n".join(text.format(args.width,n%3 or 3)))
