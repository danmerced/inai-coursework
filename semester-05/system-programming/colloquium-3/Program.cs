using System.Data;
using System.Drawing;
using System.Windows.Forms;

namespace OrderDesk;

static class Program
{
    [STAThread]
    static void Main()
    {
        ApplicationConfiguration.Initialize();
        Application.Run(new MainForm());
    }
}

class MainForm : Form
{
    readonly Store store=new();
    readonly DataGridView grid=new(){Dock=DockStyle.Fill,ReadOnly=true,AutoSizeColumnsMode=DataGridViewAutoSizeColumnsMode.Fill,AllowUserToAddRows=false};
    public MainForm()
    {
        Text="OrderDesk — заказы";Size=new Size(1000,600);
        StartPosition=FormStartPosition.CenterScreen;Font=new Font("Segoe UI",10);
        var menu=new MenuStrip();
        var orders=new ToolStripMenuItem("Заказы");
        orders.DropDownItems.Add("Новый заказ",null,(_,_)=>NewOrder());
        orders.DropDownItems.Add("Обновить",null,(_,_)=>RefreshOrders());
        orders.DropDownItems.Add("Выход",null,(_,_)=>Close());
        var products=new ToolStripMenuItem("Товары",null,(_,_)=>Products());
        menu.Items.AddRange(new ToolStripItem[]{orders,products});
        var bar=new FlowLayoutPanel{Height=55,Dock=DockStyle.Top,Padding=new Padding(12)};
        var add=new Button{Text="Новый заказ",AutoSize=true};
        add.Click+=(_,_)=>NewOrder();
        bar.Controls.Add(add);
        Controls.Add(grid);Controls.Add(bar);Controls.Add(menu);
        MainMenuStrip=menu;RefreshOrders();
    }
    void RefreshOrders()=>grid.DataSource=store.Orders();
    void Products()
    {
        using var window=new Form{Text="Каталог товаров",Size=new Size(680,420),StartPosition=FormStartPosition.CenterParent};
        window.Controls.Add(new DataGridView{DataSource=store.Products(),Dock=DockStyle.Fill,ReadOnly=true,AutoSizeColumnsMode=DataGridViewAutoSizeColumnsMode.Fill});
        window.ShowDialog(this);
    }
    void NewOrder()
    {
        using var window=new OrderForm(store);
        if(window.ShowDialog(this)==DialogResult.OK)RefreshOrders();
    }
}

class OrderForm:Form
{
    readonly TextBox customer=new(){Width=230};
    readonly ComboBox product=new(){Width=230,DropDownStyle=ComboBoxStyle.DropDownList};
    readonly NumericUpDown quantity=new(){Minimum=1,Maximum=999,Value=1};
    readonly Label total=new(){AutoSize=true};
    public OrderForm(Store store)
    {
        Text="Новый заказ";ClientSize=new Size(460,260);StartPosition=FormStartPosition.CenterParent;
        Font=new Font("Segoe UI",10);
        var layout=new TableLayoutPanel{Dock=DockStyle.Fill,ColumnCount=2,Padding=new Padding(18),AutoSize=true};
        layout.ColumnStyles.Add(new ColumnStyle(SizeType.Percent,35));layout.ColumnStyles.Add(new ColumnStyle(SizeType.Percent,65));
        void Add(string label,Control control){layout.Controls.Add(new Label{Text=label,AutoSize=true});layout.Controls.Add(control);}
        product.DataSource=store.Products();product.DisplayMember="name";product.ValueMember="id";
        Add("Покупатель",customer);Add("Товар",product);Add("Количество",quantity);Add("Сумма",total);
        void Calculate()
        {
            if(product.SelectedItem is DataRowView row)
                total.Text=(Convert.ToDecimal(row["price"])*quantity.Value).ToString("0.00")+" сом";
        }
        product.SelectedIndexChanged+=(_,_)=>Calculate();quantity.ValueChanged+=(_,_)=>Calculate();Calculate();
        var save=new Button{Text="Сохранить",AutoSize=true};
        save.Click+=(_,_)=>{
            try
            {
                store.AddOrder(customer.Text,Convert.ToInt32(product.SelectedValue),(int)quantity.Value);
                DialogResult=DialogResult.OK;Close();
            }
            catch(Exception e){MessageBox.Show(e.Message,"Ошибка");}
        };
        Add("",save);Controls.Add(layout);
    }
}
