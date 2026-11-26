using Microsoft.Data.Sqlite;
using System.Data;

namespace OrderDesk;

public sealed class Store
{
    readonly string connectionString;
    public Store()
    {
        var directory=Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData),"INAIOrderDesk");
        Directory.CreateDirectory(directory);
        connectionString=new SqliteConnectionStringBuilder{DataSource=Path.Combine(directory,"orders.db"),ForeignKeys=true}.ToString();
        using var db=Open();
        using var cmd=db.CreateCommand();
        cmd.CommandText="""
          CREATE TABLE IF NOT EXISTS products(id INTEGER PRIMARY KEY,name TEXT NOT NULL,price_cents INTEGER NOT NULL CHECK(price_cents>=0),stock INTEGER NOT NULL CHECK(stock>=0));
          CREATE TABLE IF NOT EXISTS orders(id INTEGER PRIMARY KEY,customer TEXT NOT NULL,product_id INTEGER NOT NULL REFERENCES products(id),quantity INTEGER NOT NULL CHECK(quantity>0),unit_price_cents INTEGER NOT NULL,created_at TEXT NOT NULL);
          INSERT OR IGNORE INTO products VALUES(1,'Notebook',12000,30),(2,'Pen',3500,80),(3,'Folder',8000,40);
          """;
        cmd.ExecuteNonQuery();
    }
    SqliteConnection Open(){var db=new SqliteConnection(connectionString);db.Open();return db;}
    public DataTable Products()=>Read("SELECT id,name,price_cents/100.0 AS price,stock FROM products ORDER BY id");
    public DataTable Orders()=>Read("""
      SELECT o.id,o.customer,p.name,o.quantity,o.unit_price_cents/100.0 AS unit_price,
      o.quantity*o.unit_price_cents/100.0 AS total,o.created_at
      FROM orders o JOIN products p ON p.id=o.product_id ORDER BY o.id DESC
      """);
    DataTable Read(string sql)
    {
        using var db=Open();using var cmd=db.CreateCommand();cmd.CommandText=sql;
        using var reader=cmd.ExecuteReader();var table=new DataTable();table.Load(reader);return table;
    }
    public void AddOrder(string customer,int id,int quantity)
    {
        if(string.IsNullOrWhiteSpace(customer)||quantity<=0)throw new ArgumentException("Customer and quantity are required.");
        using var db=Open();using var tx=db.BeginTransaction();
        using var reserve=db.CreateCommand();reserve.Transaction=tx;
        reserve.CommandText="UPDATE products SET stock=stock-@qty WHERE id=@id AND stock>=@qty";
        reserve.Parameters.AddWithValue("@qty",quantity);reserve.Parameters.AddWithValue("@id",id);
        if(reserve.ExecuteNonQuery()!=1)throw new InvalidOperationException("Not enough stock.");
        using var insert=db.CreateCommand();insert.Transaction=tx;
        insert.CommandText="""
          INSERT INTO orders(customer,product_id,quantity,unit_price_cents,created_at)
          SELECT @customer,id,@qty,price_cents,@date FROM products WHERE id=@id
          """;
        insert.Parameters.AddWithValue("@customer",customer.Trim());insert.Parameters.AddWithValue("@id",id);
        insert.Parameters.AddWithValue("@qty",quantity);insert.Parameters.AddWithValue("@date",DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
        if(insert.ExecuteNonQuery()!=1)throw new InvalidOperationException("Product not found.");
        tx.Commit();
    }
}
