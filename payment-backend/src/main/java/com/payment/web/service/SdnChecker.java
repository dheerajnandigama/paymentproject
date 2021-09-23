package com.payment.web.service;
import java.io.File;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.*;
import java.io.IOException;
public class SdnChecker{
public boolean checker(String phrase) throws IOException{
      Scanner fileScanner = new Scanner(new File("C:\\Users\\Administrator\\Downloads\\sdnlist.txt"));
      int lineID= 0;
      boolean f=true;
//      String phrase="GRUPO MBS LIMITADA";
      Pattern pattern =  Pattern.compile(phrase);
      Matcher matcher = null;
      while(fileScanner.hasNextLine()){
            String line = fileScanner.nextLine();
            lineID++;
            matcher = pattern.matcher(line);
            if(matcher.find()){
                f=false;
             
            }
           
        }
        return f;
    }
}