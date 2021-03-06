  int CHECKBOX_X = 450;
  int CHECKBOX_Y = 10;
  int CHECKBOX_W = 300;
  
class SettingsView extends View {
  HSlider yearSlider;
  HSlider monthSlider;
  HSlider timeSlider;
  Checkbox yearCheckbox, monthCheckbox, timeCheckbox;
  Checkbox showAirportCB;
  Checkbox showMilitaryBasesCB;
  Checkbox showWeatherStationCB;
  Checkbox showByStatesCB;
  PlayButton play;
  PlayBar playBar;
  Animator playBarAnimator;

  boolean showView;
  float heightView ;
  String title;
  
  SettingsView(float x_, float y_, float w_, float h_)
  {
    super(x_, y_, w_, h_);
    heightView = h;
    textFont(font,normalFontSize);
    
    monthCheckbox = new Checkbox(10,40,12,12,"Month:");
    this.subviews.add(monthCheckbox);
    
    timeCheckbox = new Checkbox(10,70,12,12,"Time:");
    this.subviews.add(timeCheckbox);
    
    yearSlider = new HSlider(80,10,0,0,yearLabels,"",3);
    this.subviews.add(yearSlider);

    monthSlider = new HSlider(80,40,0,0,monthLabels,"",2);
    this.subviews.add(monthSlider);

    timeSlider = new HSlider(80,70,0,0,timeLabels,"",2);
    this.subviews.add(timeSlider);
    
    int i = 0;
    typeCheckboxMap = new HashMap<SightingType, Checkbox>();
    for (SightingType st : sightingTypeMap.values()) {
      int x_delta = (i / 4) * 160;
      int y_delta = (i % 4) * 20;
      Checkbox cb = new Checkbox(CHECKBOX_X + 10 + x_delta ,CHECKBOX_Y + 9 + y_delta, 12, 12, st.name, st.icon,st.colr);
      cb.value = true;
      typeCheckboxMap.put(st, cb);
      subviews.add(cb);
      i++;
    }
    
    showAirportCB = new Checkbox(780,10,12,12,"Show airports",airplaneImage,-1);
    showAirportCB.value = showAirports;
    this.subviews.add(showAirportCB);
    
    showMilitaryBasesCB = new Checkbox(780,30,12,12,"Show military bases",militaryBaseImage,-1);
    showMilitaryBasesCB.value = showMilitaryBases;
    this.subviews.add(showMilitaryBasesCB);
    
    showWeatherStationCB = new Checkbox(780,50,12,12,"Show weather stations",weatherStationImage,-1);
    showWeatherStationCB.value = showWeatherStation;
    this.subviews.add(showWeatherStationCB);
    
    showByStatesCB = new Checkbox(780,70,12,12,"Sightings by State");
    showByStatesCB.value = showByStates;
    this.subviews.add(showByStatesCB);
    
    play =  new PlayButton(100,h-25,25,25);
    this.subviews.add(play);
    
    playBar =  new PlayBar(125,h-25,0,25);
    playBarAnimator = new Animator(0);
    this.subviews.add(playBar);

    showView = false;
  }
  
   void drawContent()
  {
    textSize(normalFontSize);
    fill(viewBackgroundColor,220);
//    stroke(viewBackgroundColor,220);
    noStroke();
    rect(0,0, w, h-25);
    textFont(font,normalFontSize);
    rect(0,h-25,textWidth("Show Settings")+10,25);
    textAlign(LEFT,TOP);
    fill(textColor);
    text((showView)?"Hide Settings":"Show Settings",5,h-20);
  
    text("Year: ",10,10);
    textAlign(LEFT,CENTER);
    title = " Type of UFO ";
    text(title,CHECKBOX_X,CHECKBOX_Y);
    stroke(textColor);
    line(CHECKBOX_X + textWidth(title)+5,CHECKBOX_Y,CHECKBOX_X+CHECKBOX_W,CHECKBOX_Y);
    line(CHECKBOX_X,CHECKBOX_Y,CHECKBOX_X,h-30);
    line(CHECKBOX_X,h-30,CHECKBOX_X+CHECKBOX_W,h-30);
    line(CHECKBOX_X+CHECKBOX_W,CHECKBOX_Y,CHECKBOX_X+CHECKBOX_W,h-30);
    
    textSize(largeFontSize);
    fill(titleTextColor);
    textAlign(LEFT,TOP);
    title = "< MAP " + ((yearSlider.minIndex()!=yearSlider.maxIndex())?("From: "+yearLabelsToPrint[yearSlider.minIndex()] + " To: " + yearLabelsToPrint[yearSlider.maxIndex()]):("Year: "+yearLabelsToPrint[yearSlider.minIndex()]));
    title = title + ((monthCheckbox.value)?((monthSlider.minIndex()!=monthSlider.maxIndex())?(" - " + monthLabelsToPrint[monthSlider.minIndex()] + " to " + monthLabelsToPrint[monthSlider.maxIndex()]):(" - " +  monthLabelsToPrint[monthSlider.minIndex()])):(""));
    title = title +  ((timeCheckbox.value)?(" - " + timeLabels[timeSlider.minIndex()] + ":00 to " + timeLabels[timeSlider.maxIndex()] +":59"):(""));   
    title = title + " >";
    title = title + ((playing)?(" Showing: " + dbDateFormat.format(player.now.getTime())):"");
    text(title,(w-textWidth(title))/2,h-20);   
    title = "Total # of Sightings = " + nfc(totalCountSightings);
    text(title,(w-textWidth(title))/2,h);
    
   
  }
  
  boolean contentPressed(float lx, float ly)
  {
    if(lx > 0 && lx < textWidth("Show Settings")+10 && ly>h-25 && ly < h){
        settingsAnimator.target((showView)?(-heightView+45):20);
        showView = !showView;    
    }
    return true;
  }
 
}

