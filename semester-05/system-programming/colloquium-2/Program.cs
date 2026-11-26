using System.ComponentModel;
using System.Drawing;
using System.Windows.Forms;

namespace SortingTrainer;

internal static class Program
{
    [STAThread]
    static void Main()
    {
        ApplicationConfiguration.Initialize();
        Application.Run(new MainWindow());
    }
}

class MainWindow : Form
{
    readonly TextBox input = new(){Width=360, Text="7 2 9 1 5 4 8"};
    readonly ComboBox algorithm = new(){DropDownStyle=ComboBoxStyle.DropDownList,Width=125};
    readonly NumericUpDown count = new(){Minimum=2,Maximum=30,Value=12,Width=55};
    readonly Label info = new(){AutoSize=true, Text="Готово к запуску"};
    readonly Panel canvas = new(){Dock=DockStyle.Fill,BackColor=Color.White};
    readonly System.Windows.Forms.Timer timer = new(){Interval=150};
    readonly BackgroundWorker generator = new();
    readonly BackgroundWorker sorter = new();
    List<Step> steps = new();
    int frame;
    Step? current;

    public MainWindow()
    {
        Text="Тренажёр сортировок"; ClientSize=new Size(940,570);
        MinimumSize=new Size(790,440); StartPosition=FormStartPosition.CenterScreen;
        Font=new Font("Segoe UI",10);
        var menu=new MenuStrip();
        var file=new ToolStripMenuItem("Файл");
        file.DropDownItems.Add("Открыть массив",null,(_,_)=>Open());
        file.DropDownItems.Add("Закрыть",null,(_,_)=>Close());
        var commands=new ToolStripMenuItem("Практика");
        commands.DropDownItems.Add("Сгенерировать",null,(_,_)=>Generate());
        commands.DropDownItems.Add("Запустить",null,(_,_)=>Start());
        commands.DropDownItems.Add("Следующий шаг",null,(_,_)=>Next());
        commands.DropDownItems.Add("Описание",null,(_,_)=>Explain());
        commands.DropDownItems.Add("Сравнение",null,(_,_)=>Compare());
        menu.Items.AddRange(new ToolStripItem[]{file,commands});
        MainMenuStrip=menu;
        algorithm.Items.AddRange(Enum.GetNames<Algorithm>());
        algorithm.SelectedIndex=0;
        var strip=new FlowLayoutPanel{Dock=DockStyle.Top,Padding=new Padding(12),Height=110,AutoScroll=true};
        strip.Controls.AddRange(new Control[]{new Label{Text="Массив:",AutoSize=true},input,algorithm,count,
            Button("Случайный",Generate),Button("Запуск",Start),Button("Шаг",Next),
            Button("Описание",Explain),Button("Сравнить",Compare),info});
        Controls.Add(canvas); Controls.Add(strip); Controls.Add(menu);
        canvas.Paint+=Draw;
        timer.Tick+=(_,_)=>Next();
        generator.DoWork+=(_,e)=>e.Result=Enumerable.Range(0,(int)e.Argument!).Select(_=>Random.Shared.Next(-30,100)).ToArray();
        generator.RunWorkerCompleted+=(_,e)=>{
            if(IsDisposed)return;
            if(e.Error!=null){MessageBox.Show(e.Error.Message);return;}
            input.Text=string.Join(" ",(int[])e.Result!);
            info.Text="Массив сгенерирован";
        };
        sorter.DoWork+=(_,e)=>{
            var task=((int[] Data, Algorithm Kind))e.Argument!;
            e.Result=Sorting.Run(task.Data,task.Kind,true);
        };
        sorter.RunWorkerCompleted+=(_,e)=>{
            if(IsDisposed)return;
            if(e.Error!=null){MessageBox.Show(e.Error.Message);return;}
            var result=(SortResult)e.Result!;
            steps=result.Steps;frame=0;
            if(steps.Count>0){ShowStep(steps[frame]);timer.Start();}
        };
    }

    Button Button(string text,Action action)
    {
        var button=new Button{Text=text,AutoSize=true};
        button.Click+=(_,_)=>action();return button;
    }

    int[] Parse()
    {
        var parts=input.Text.Split(new[]{' ', ',', ';','\n','\r','\t'},StringSplitOptions.RemoveEmptyEntries);
        if(parts.Length<2 || parts.Length>30)throw new FormatException("Введите от 2 до 30 целых чисел.");
        return parts.Select(int.Parse).ToArray();
    }

    void Open()
    {
        using var dialog=new OpenFileDialog{Filter="Text|*.txt;*.csv|All files|*.*"};
        if(dialog.ShowDialog()!=DialogResult.OK)return;
        try{input.Text=File.ReadAllText(dialog.FileName);Parse();}
        catch(Exception e){MessageBox.Show(e.Message);}
    }

    void Generate()
    {
        if(generator.IsBusy)return;
        timer.Stop();generator.RunWorkerAsync((int)count.Value);
    }

    void Start()
    {
        if(sorter.IsBusy)return;
        try{timer.Stop();sorter.RunWorkerAsync((Parse(),(Algorithm)algorithm.SelectedIndex));info.Text="Сортировка...";}
        catch(Exception e){MessageBox.Show(e.Message);}
    }

    void ShowStep(Step step)
    {
        current=step;
        info.Text=$"Шаг {frame+1}/{steps.Count}: {step.Action} — {string.Join(", ",step.Values)}";
        canvas.Invalidate();
    }

    void Next()
    {
        if(frame+1>=steps.Count){timer.Stop();return;}
        ShowStep(steps[++frame]);
    }

    void Draw(object? sender,PaintEventArgs e)
    {
        if(current==null || canvas.Width<100 || canvas.Height<100)return;
        var data=current.Values;
        double min=Math.Min(0,(double)data.Min()),max=Math.Max(0,(double)data.Max());
        double span=Math.Max(1,max-min);
        float bottom=canvas.Height-38,top=25,scale=(float)((bottom-top)/span);
        float zero=bottom+(float)min*scale;
        float width=(canvas.Width-24f)/data.Length;
        e.Graphics.DrawLine(Pens.Gray,12,zero,canvas.Width-12,zero);
        using var normal=new SolidBrush(Color.SteelBlue);
        using var marked=new SolidBrush(Color.DarkOrange);
        for(int i=0;i<data.Length;i++)
        {
            float y=zero-(float)data[i]*scale;
            e.Graphics.FillRectangle(i==current.A||i==current.B?marked:normal,12+i*width,Math.Min(zero,y),
                Math.Max(1,width-6),Math.Max(2,Math.Abs(y-zero)));
            e.Graphics.DrawString(data[i].ToString(),Font,Brushes.Black,12+i*width,bottom+8);
        }
    }

    void Explain()
    {
        var text=(Algorithm)algorithm.SelectedIndex switch
        {
            Algorithm.Bubble=>"Пузырёк\n\nСравниваем соседей. Если левый больше правого — меняем местами. После прохода максимум в конце.\n\nНачало → проход → сравнение → обмен при необходимости → следующий проход → конец.\n\nЛучший O(n), средний и худший O(n²), стабильная.",
            Algorithm.Selection=>"Прямой выбор\n\nИщем минимум в неотсортированном хвосте и переносим на первую свободную позицию.\n\nНачало → выбрать i → поиск min → обмен → i+1 → конец.\n\nВсе случаи O(n²), обычно нестабильная.",
            _=>"Вставки\n\nБерём очередной элемент и перемещаем влево соседними обменами до правильного места.\n\nНачало → выбрать элемент → сравнить с предыдущим → обмен → повтор → конец.\n\nЛучший O(n), средний и худший O(n²), стабильная."
        };
        ShowText("Описание алгоритма",text);
    }

    void Compare()
    {
        try
        {
            var data=Parse();
            var lines=new List<string>{"Один и тот же исходный массив: "+string.Join(", ",data),"\nАлгоритм | сравнения | записи | мс"};
            foreach(var kind in Enum.GetValues<Algorithm>())
            {
                // Warm-up once, measure without visualization snapshots.
                Sorting.Run(data,kind);
                var result=Sorting.Run(data,kind);
                lines.Add($"{kind} | {result.Comparisons} | {result.Writes} | {result.Ms:F4}");
                lines.Add("Результат: "+string.Join(", ", result.Values));
            }
            lines.Add("\nНа маленьких массивах время нестабильно. Сравнения и записи лучше показывают работу алгоритма. Пузырёк и вставки стабильны, выбор обычно нет.");
            ShowText("Сравнительный анализ",string.Join("\n",lines));
        }
        catch(Exception e){MessageBox.Show(e.Message);}
    }

    void ShowText(string title,string text)
    {
        var form=new Form{Text=title,Size=new Size(660,460),StartPosition=FormStartPosition.CenterParent,Font=Font};
        form.Controls.Add(new TextBox{Text=text,Multiline=true,ReadOnly=true,ScrollBars=ScrollBars.Vertical,Dock=DockStyle.Fill});
        form.Show(this);
    }

    protected override void OnFormClosed(FormClosedEventArgs e){timer.Dispose();base.OnFormClosed(e);}
}
