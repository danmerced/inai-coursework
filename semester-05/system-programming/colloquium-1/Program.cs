using System.Globalization;

static int ReadInt(string prompt)
{
    while (true)
    {
        Console.Write(prompt);
        if (int.TryParse(Console.ReadLine(), out int value)) return value;
        Console.WriteLine("Enter an integer.");
    }
}

var values = new List<int>();
while (true)
{
    Console.WriteLine("\n1. Fill array   2. Show   3. Min/max/average   4. Search");
    Console.WriteLine("5. Insert      6. Delete 7. Binary search      8. Check ascending   0. Exit");
    int option = ReadInt("> ");
    if (option == 0) break;
    switch (option)
    {
        case 1:
            int length = ReadInt("Length: ");
            if (length < 0 || length > 10000) { Console.WriteLine("Length must be 0..10000."); break; }
            values.Clear();
            for (int i = 0; i < length; i++) values.Add(ReadInt($"a[{i}]: "));
            break;
        case 2:
            Console.WriteLine(string.Join(" ", values)); break;
        case 3:
            if (values.Count == 0) { Console.WriteLine("Empty array"); break; }
            Console.WriteLine($"Min: {values.Min()}, Max: {values.Max()}, Average: {values.Average():F2}");
            break;
        case 4:
            int target = ReadInt("Number: ");
            Console.WriteLine("Indices: " + string.Join(" ", values.Select((v,i)=>(v,i)).Where(x=>x.v==target).Select(x=>x.i)));
            break;
        case 5:
            int at = ReadInt("Index: ");
            if (at < 0 || at > values.Count) { Console.WriteLine("Invalid index"); break; }
            values.Insert(at, ReadInt("Value: "));
            break;
        case 6:
            int index = ReadInt("Index: ");
            if (index < 0 || index >= values.Count) { Console.WriteLine("Invalid index"); break; }
            values.RemoveAt(index);
            break;
        case 7:
            if (!IsAscending(values)) { Console.WriteLine("Array must be sorted first."); break; }
            Console.WriteLine("Index: " + BinarySearch(values, ReadInt("Number: ")));
            break;
        case 8: Console.WriteLine(IsAscending(values) ? "Ascending" : "Not ascending"); break;
        default: Console.WriteLine("Unknown option."); break;
    }
}

static bool IsAscending(List<int> data)
{
    for(int i=1;i<data.Count;i++) if(data[i]<data[i-1]) return false;
    return true;
}

static int BinarySearch(List<int> data, int target)
{
    int left=0, right=data.Count-1;
    while(left<=right)
    {
        int mid=left+(right-left)/2;
        if(data[mid]==target)return mid;
        if(data[mid]<target)left=mid+1;
        else right=mid-1;
    }
    return -1;
}
