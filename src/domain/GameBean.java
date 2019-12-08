package domain;

public class GameBean {
	private int id;
	private String name;
	private double price;
	private int inventory;
	private String description;
	private String imgurl;
	private int sales;
	private int views;
	
	public void setId(int id)
	{
		this.id=id;
	}
	public int getId()
	{
		return id;
	}
	public void setName(String name)
	{
		this.name=name;
	}
	public String getName()
	{
		return name;
	}
	public void setPrice(double price)
	{
		this.price=price;
	}
	public double getPrice()
	{
		return price;
	}
	public void setInventory(int inventory)
	{
		this.inventory=inventory;
	}
	public int getInventory()
	{
		return inventory;
	}
	public void setDescription(String description)
	{
		this.description=description;
	}
	public String getDescription()
	{
		return description;
	}
	public void setImgurl(String imgurl)
	{
		this.imgurl=imgurl;
	}
	public String getImgurl()
	{
		return imgurl;
	}
	public void setSales(int sales)
	{
		this.sales=sales;
	}
	public int getSales()
	{
		return sales;
	}
	public void setViews(int views)
	{
		this.views=views;
	}
	public int getViews()
	{
		return views;
	}
	
	
}	





