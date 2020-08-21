/*
Class BoggleDice

Represents the letter dice in boggle. Supports variable grid sizes and random dice rolling.
Creates string arrays for each side of dice and selected face-up letter
*/

enum BoggleDiceType{
  NORMAL,
  BIG
}

class BoggleDice {
  
  private String[] NahDice; // All the letters. Internal use only
  private String[] YahDice; // Randomly selected letters from NahDice. Access using GetDice()
  
  BoggleDice() {
    this(BoggleDiceType.NORMAL);        
  }
  
  BoggleDice(BoggleDiceType type) {
    switch(type) {
      case NORMAL:
      default:
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
        break;
        
      case BIG:
        NahDice = new String[25];
        YahDice = new String[25];
        
        NahDice[0]="QBZJXK";
        NahDice[1]="TOUOTO";
        NahDice[2]="OVWRGR";
        NahDice[3]="AAAFSR";
        NahDice[4]="AUMEEG";
        NahDice[5]="HHLRDO";   
        NahDice[6]="NHDTHO";
        NahDice[7]="LHNROD";
        NahDice[8]="AFAISR";
        NahDice[9]="YFIASR";
        NahDice[10]="TELPCI";
        NahDice[11]="SSNSEU";       
        NahDice[12]="RIYPRH";
        NahDice[13]="DORDLN";
        NahDice[14]="CCWNST";
        NahDice[15]="TTOTEM";
        NahDice[16]="SCTIEP";
        NahDice[17]="EANDNN";
        NahDice[18]="MNNEAG";
        NahDice[19]="UOTOWN";
        NahDice[20]="AEAEEE";
        NahDice[21]="YIFPSR";
        NahDice[22]="EEEEMA";
        NahDice[23]="ITATIE";
        NahDice[24]="ETILAC";
        break;
    }
    Generate();
  }
  
  private void Generate()  {
      int numDice = NahDice.length;
      //Creates temporary string array to randomize order of dice
      String[] temp = new String[numDice];
    
      /*Randomly selects letter from string array NahDice to
      simulate rolling each dice. Information stored in the
      temp string array*/
      
      for(int i=0; i<numDice; i++) 
      {
          int j = int(random(6)); // Pick a random letter (roll each die)
          temp[i] = str(NahDice[i].charAt(j));
      }
      
       /*Randomly shuffles letters in temp string array.
       Information stored in YahDice. This could be a lot 
       more efficient - maybe come back to this.*/
      
      for(int k = 0; k<numDice; k++)
      {
          int m = int(random(numDice)); // Choose a random letter to add to YahDice   
          
          while(temp[m] == "") // If we've already chosen this letter...
          { 
            m = int(random(numDice)); // ... choose a different one.
          }
          
          YahDice[k] = temp[m]; // Select the letter by adding it to YahDice
          temp[m] = ""; // and mark it so we don't re-add the same one again.
      }
  }
  
  //Returns information from YahDice to Boggle_Game when called.
  public String[] GetDice()
  {
      return YahDice;
  }
}
