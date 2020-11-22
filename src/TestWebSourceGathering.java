import java.io.BufferedInputStream;
import java.io.IOException;
import java.net.URL;
import java.net.URLConnection;

public class TestWebSourceGathering {
   public static void main(String[] args) {
      BufferedInputStream in = null;
      String strUrl = "https://www.google.co.kr/maps/dir/논타부리+10540+Samut+Prakan,+Bang+Phli+District,+Nong+Prue,+Soi+Mu+Ban+Nakhon+Thong+1/%EB%8F%88%EB%AF%80%EC%95%99+%EA%B5%AD%EC%A0%9C%EA%B3%B5%ED%95%AD+%ED%83%9C%EA%B5%AD+10210+Krung+Thep+Maha+Nakhon,+Bangkok,+Vibhavadi+Rangsit+Rd/@13.7827799,100.6608268,12z/data=!4m13!4m12!1m5!1m1!1s0x311d67771542274f:0x120d19554f157a07!2m2!1d100.7501124!2d13.6899991!1m5!1m1!1s0x30e282881daca62d:0xf0100b33d0bffa0!2m2!1d100.6041987!2d13.9132602?hl=ko";
      StringBuffer sb = new StringBuffer();
      
      try {
         URL url = new URL(strUrl);
         URLConnection urlConnection = url.openConnection();
         in = new BufferedInputStream(urlConnection.getInputStream());
         
         byte[] bufRead = new byte[4096];
         int lenRead = 0;
         while ((lenRead = in.read(bufRead)) > 0)
            sb.append(new String(bufRead, 0, lenRead));

      } catch (IOException ioe) {
         ioe.printStackTrace();
      }
      
      System.out.println(sb.toString());      
   }
}