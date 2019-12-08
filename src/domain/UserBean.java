package domain;

import java.util.HashMap;
import java.util.Map;

public class UserBean {
	private String name;
	private String password;
	private String email;
	private String intro;
	private Map<String, String> errors = new HashMap<String, String>(); //记录错误信息
	public void setName(String name)
	{
		this.name=name;
	}
	public String getName()
	{
		return name;	
	}
	public void setPassword(String password)
	{
		this.password=password;
	}
	public String getPassword()
	{
		return password;
	}
	public void setEmail(String email)
	{
		this.email=email;
	}
	public String getEmail()
	{
		return email;
	}
	public void setIntro(String intro)
	{
		this.intro=intro;
	}
	public String getIntro()
	{
		return intro;
	}
	public boolean loginCheck()
	{
		boolean flag = true;
 		if (name == null || name.trim().equals("")) 
 		{
 			errors.put("name", "请输入姓名.");
 			flag = false;
 		}
 		if (password == null || password.trim().equals("")) 
 		{
 			errors.put("password", "请输入密码.");
 			flag = false;
 		}
 		return flag;
	}
	

}
