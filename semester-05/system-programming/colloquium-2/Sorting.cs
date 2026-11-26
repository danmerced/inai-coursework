using System.Diagnostics;

namespace SortingTrainer;

public enum Algorithm { Bubble, Selection, Insertion }
public record Step(int[] Values, int A, int B, string Action);
public record SortResult(int[] Values, long Comparisons, long Writes, double Ms, List<Step> Steps);

public static class Sorting
{
    public static SortResult Run(int[] source, Algorithm kind, bool capture=false)
    {
        var data=(int[])source.Clone();
        var steps=new List<Step>();
        long comparisons=0, writes=0;
        void Frame(int a, int b,string action)
        {
            if(capture)steps.Add(new((int[])data.Clone(),a,b,action));
        }
        bool Less(int a,int b)
        {
            comparisons++;
            Frame(a,b,"Сравнение");
            return data[a]<data[b];
        }
        void Swap(int a,int b)
        {
            if(a==b)return;
            (data[a],data[b])=(data[b],data[a]);
            writes+=2;
            Frame(a,b,"Обмен");
        }

        var watch=Stopwatch.StartNew();
        Frame(-1,-1,"Исходный массив");
        switch(kind)
        {
            case Algorithm.Bubble:
                for(int end=data.Length-1;end>0;end--)
                {
                    bool changed=false;
                    for(int j=0;j<end;j++)
                    {
                        if(Less(j+1,j)){Swap(j,j+1);changed=true;}
                    }
                    if(!changed)break;
                }
                break;
            case Algorithm.Selection:
                for(int i=0;i<data.Length-1;i++)
                {
                    int min=i;
                    for(int j=i+1;j<data.Length;j++) if(Less(j,min))min=j;
                    Swap(i,min);
                }
                break;
            case Algorithm.Insertion:
                for(int i=1;i<data.Length;i++)
                {
                    // Adjacent exchanges implement stable insertion.
                    for(int j=i;j>0 && Less(j,j-1);j--) Swap(j,j-1);
                }
                break;
        }
        Frame(-1,-1,"Готово");
        watch.Stop();
        return new(data,comparisons,writes,watch.Elapsed.TotalMilliseconds,steps);
    }
}
