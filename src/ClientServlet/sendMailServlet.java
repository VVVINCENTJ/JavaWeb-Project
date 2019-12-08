package ClientServlet;

import com.sun.mail.util.MailSSLSocketFactory;

import domain.UserBean;

import java.io.IOException;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.ws.http.HTTPException;
import java.io.*;
import javax.activation.*;



@WebServlet(name = "SendMailServlet",urlPatterns = "/SendMailServlet")
public class sendMailServlet extends HttpServlet{
	public void doGet(HttpServletRequest request,HttpServletResponse response) 
			throws HTTPException,IOException, ServletException
			{
				doPost(request, response);
			}

	public void doPost(HttpServletRequest request,HttpServletResponse response) 
			throws HTTPException,IOException, ServletException
    { 
		UserBean user=(UserBean)request.getSession().getAttribute("user");
		String mailString=user.getEmail();
		String nameString=user.getName();
		System.out.println("收件人邮箱："+mailString);
		
		Properties prop = new Properties();
        prop.setProperty("mail.host", "smtp.163.com"); //// 设置163邮件服务器
        prop.setProperty("mail.transport.protocol", "smtp"); // 邮件发送协议
        prop.setProperty("mail.smtp.auth", "true"); // 需要验证用户名密码

        // 设置SSL加密，加上以下代码即可
        MailSSLSocketFactory sf=null;
        try 
        {
        	sf = new MailSSLSocketFactory();
		} 
        catch (Exception e) 
        {
			e.printStackTrace();
		}
        sf.setTrustAllHosts(true);
        prop.put("mail.smtp.ssl.enable", "true");
        prop.put("mail.smtp.ssl.socketFactory", sf);

        //使用JavaMail发送邮件的5个步骤

        //创建定义整个应用程序所需的环境信息的 Session 对象

        Session session = Session.getDefaultInstance(prop, new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                //发件人邮件用户名、授权码
                return new PasswordAuthentication("vvvincentj@163.com", "a123456");
            }
        });


        //开启Session的debug模式，这样就可以查看到程序发送Email的运行状态
        session.setDebug(true);

        //2、通过session得到transport对象
        try 
        {
        	Transport ts = session.getTransport();

            //3、使用邮箱的用户名和授权码连上邮件服务器，最后一个参数是授权码
            ts.connect("smtp.163.com", "vvvincentj@163.com", "a123456");

            //4、创建邮件

            //创建邮件对象
            MimeMessage message = new MimeMessage(session);

            //指明邮件的发件人
            message.setFrom(new InternetAddress("vvvincentj@163.com"));

            //指明邮件的收件人，现在发件人和收件人是一样的，那就是自己给自己发
            
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(mailString)); //对方的邮箱

            //邮件的标题
            message.setSubject("发货通知");

            //邮件的文本内容
            message.setContent("尊敬的客户:"+nameString+"<br> 您的商品已发货！感谢您对网站的大力资瓷!<br>", "text/html;charset=UTF-8");

            //5、发送邮件
            ts.sendMessage(message, message.getAllRecipients());

            ts.close();
		} 
        catch (Exception e) 
        {
			e.printStackTrace();
		}
		/*String mess=(String)request.getAttribute("PayMessage");
		System.out.println(mess);
		request.setAttribute("PayMessage", mess);*/
        request.getRequestDispatcher("paySuccess.jsp").forward(request, response);
        //response.setHeader("refresh", "0.5;url=paySuccess.jsp");
        

	   }

}
