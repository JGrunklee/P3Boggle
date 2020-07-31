class Boggle_Dice {
  
  /*Creates string arrays for each side of dice
  and selected face-up letter*/
  
  String[] NahDice;
  String[] YahDice;
  
  Boggle_Dice() {
    
      NahDice = new String[16];
      YahDice = new String[16];
      NahDice[0]="AAEEGN";
      NahDice[1]="ELRTTY";
      NahDice[2]="AOOTTW";
      NahDice[3]="ABBJOO";
      NahDice[4]="EHRTVW";
      NahDice[5]="CIMOTU";   
      NahDice[6]="DISTTY";
      NahDice[7]="EIOSST";
      NahDice[8]="DELRVY";
      NahDice[9]="ACHOPS";
      NahDice[10]="HIMNQU";
      NahDice[11]="EEINSU";       
      NahDice[12]="EEGHNW";
      NahDice[13]="AFFKPS";
      NahDice[14]="HLNNRZ";
      NahDice[15]="DEILRX";
      
      Generate();     
  
    
  } 
  
  private void Generate()  {
  
      //Creates temporary string array to randomize order of dice
      
      String[] temp = new String[16];
    
      /*Randomly selects letter from string array NahDice to
      simulate rolling each dice. Information stored in the
      temp string array*/
      
      for(int i=0; i<16; i++)
      {
        
          int j = int(random(6));
          temp[i] = str(NahDice[i].charAt(j));
      
      }
      
       /*Randomly shuffles letters in temp string array.
       Information stored in YahDice*/
      
      for(int k = 0; k<16; k++)
      {
        
          int m = int(random(16));
          
          while(temp[m] == "")
          { 
            m = int(random(16));
          }
          
         
          YahDice[k] = temp[m];
          temp[m] = "";
                          
      }
      
    
  }
  
  //Returns information from YahDice to Boggle_Game when called.
  
  public String[] GetDice()
  {
      return YahDice;
  }
}
