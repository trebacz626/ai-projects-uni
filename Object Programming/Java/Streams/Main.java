/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.streams;

import java.io.*;
import java.util.Date;

/**
 *
 * @author kacper
 */
public class Main {
    public static void main(String args[]){
        BufferedReader br = null;
        BufferedWriter bw = null;
        
        try{
            Date date = new Date();
            br = new BufferedReader(new InputStreamReader(System.in));
            bw = new BufferedWriter(new FileWriter(String.valueOf(date)+".txt"));
            String line = null;
            while(!(line = br.readLine()).equals("start"));
            bw.write("Captain’s log             Stardate <"+String.valueOf(date)+">\n\n");
            while(!(line = br.readLine()).equals("stop")){
                bw.write(line+"\n");
            }
            bw.write("\nJean-Luc Picard");
        }catch(Exception e){
            System.out.println(e);
        }finally{
            try{
                bw.close();
            }catch(Exception e){
                System.err.println(e);
            }finally{
                try{
                    br.close();
                }catch(Exception e){
                    System.err.println(e);
                }
            }
        }
    }
}
