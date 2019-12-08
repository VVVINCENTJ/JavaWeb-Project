package domain;

import java.util.HashMap;
import java.util.Map;

public class LoginFormBean {
	private String name;
	private String password;
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
	public boolean validate() 
	{
 		boolean flag = true;
 		if (name == null || name.trim().equals("")) {
 			errors.put("name", "请输入用户名.");
 			//System.out.println("请输入姓名");
 			flag = false;
 		}
 		if (password == null || password.trim().equals("")) {
 			errors.put("password", "请输入密码.");
 			//System.out.println("请输入密码");
 			flag = false;
 		} 
 		return flag;
 	}
		// 向Map集合errors中添加错误信息
 	public void setErrorMsg(String err, String errMsg) 
 	{
 		if ((err != null) && (errMsg != null)) {
 			errors.put(err, errMsg);
 		}
 	}
	     // 获取errors集合
    public Map<String, String> getErrors() 
    {
 		return errors;
 	}


}
