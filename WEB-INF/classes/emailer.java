import java.rmi.*; 
import java.io.*; 
import java.rmi.server.*; 
import webp_rmi.*; 
import java.sql.*; 
import java.util.*; 
import java.lang.*; 
import javax.mail.*; 
import javax.mail.internet.*; 
import javax.activation.*; 
 
public class emailer
{ 
    public static String to = "test@gmail.com";
    public static String subject = "Test mail";
    public static String msgText = "This is a test mail. Ignore it.";
    public static int sendmail() 
    //public static void main(String[] args) 
    { 
        String from = "08cs3012@iitkgp.ac.in"; 
        //String host = "cse.iitkgp.ernet.in"; 
        String host = "10.3.100.244"; 
        // Get system properties 
	Properties properties = System.getProperties();
	//properties.put("mail.smtp.host", "cse.iitkgp.ernet.in"); 
	properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.auth", "false"); 
        properties.put("mail.smtp.port", "25"); 
        int x=0; 
         
        Session session = Session.getDefaultInstance(properties); 
        try{ 
         // Create a default MimeMessage object. 
         MimeMessage message = new MimeMessage(session); 
 
	 //message.setHeader("Content-Type", "text/html");

         // Set From: header field of the header. 
         message.setFrom(new InternetAddress(from)); 
 
         // Set To: header field of the header. 
	 InternetAddress[] address = InternetAddress.parse(to);
	 message.setRecipients(Message.RecipientType.TO, address);
 
         // Set Subject: header field 
         message.setSubject(subject); 
 
         // Now set the actual message 
         message.setText(msgText);
 
         // Send message 
         Transport.send(message); 
         x=1;
      }catch (MessagingException mex) { 
         mex.printStackTrace(); 
      }
	return x;
    } 
}