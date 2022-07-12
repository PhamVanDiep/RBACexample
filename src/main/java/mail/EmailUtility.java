package mail;

import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author dieppv
 */
public class EmailUtility {
public static void sendEmail(String host, String port,
            final String userName, final String password, String toAddress,
            String subject, String message) throws AddressException,
            MessagingException {
 
        // sets SMTP server properties
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        
        Session session = Session.getDefaultInstance(properties,new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication(){
                 return new PasswordAuthentication(userName, password);
            }
        });

        MimeMessage mimeMessage = new MimeMessage(session);
        mimeMessage.setFrom(new InternetAddress(userName));
        mimeMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(toAddress));
        mimeMessage.setSubject(subject, "UTF-8");
        mimeMessage.setText(message);
        Transport.send(mimeMessage);
        // creates a new session with an authenticator
//        Authenticator auth = new Authenticator() {
//            public PasswordAuthentication getPasswordAuthentication() {
//                return new PasswordAuthentication(userName, password);
//            }
//        };
// 
//        Session session = Session.getInstance(properties, auth);
// 
//        // creates a new e-mail message
//        Message msg = new MimeMessage(session);
// 
//        msg.setFrom(new InternetAddress(userName));
//        InternetAddress[] toAddresses = { new InternetAddress(toAddress) };
//        msg.setRecipients(Message.RecipientType.TO, toAddresses);
//        msg.setSubject(subject);
//        msg.setSentDate(new Date());
//        msg.setText(message);
// 
//        // sends the e-mail
//        Transport.send(msg);
 
    }
}
