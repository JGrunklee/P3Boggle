class Boggle_Timer {
  
    int startTime;
    int interval;
    
    //Creates a countdown interval for the timer  
    Boggle_Timer(int timeInterval) {
        interval = timeInterval;
    }
    
    void start() {
        startTime = millis();
    }
    
    //Returns the current time of the countdown
    boolean complete() {
        int elapsedTime = millis() - startTime;
        if (elapsedTime > interval) 
        {
             return true;
        }
        else 
        {
             return false;
        }
    }
}
