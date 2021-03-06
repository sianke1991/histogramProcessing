final int NUM_DATA=50000;
int numBars=20;
float[] data=new float[NUM_DATA];
float[] classLeft=new float[numBars];
int[] freq=new int[numBars];
float minData,maxData;
float classWidth;
float topSpacing=100;
float bottomSpacing=100;
float leftSpacing=100;
float rightSpacing=100;


void setup(){
  size(1600,900);
  for(int i=0;i<data.length;i++){
    data[i]=randomGaussian();
  }
  minData=min(data);
  maxData=max(data);
  classWidth=(maxData-minData)/numBars;
  for(int i=0;i<classLeft.length;i++){
    classLeft[i]=minData+i*classWidth;
  }
  for(int j=0;j<data.length;j++){
    int i;
    for(i=0;i<classLeft.length-1;i++){
      if(data[j]>=classLeft[i] && data[j]<classLeft[i+1]){
        freq[i]++;
        break;
      }
    } //i loop (class loop)
    if(i==classLeft.length-1) freq[i]++;
  } //j loop (data loop)
}

void draw(){
  background(191);
  for(int i=0;i<numBars;i++){
    float leftLimit=leftSpacing+(width-leftSpacing-rightSpacing)/numBars*i;
    float rightLimit=leftSpacing+(width-leftSpacing-rightSpacing)/numBars*(i+1);
    float boxHeight=map(freq[i],min(freq),max(freq),50,height-topSpacing-bottomSpacing);
    fill(127,127);
    if(freq[i]==max(freq)) fill(255,0,0,127);
    else if(freq[i]==min(freq)) fill(0,0,255,127);
    stroke(0);
    strokeWeight(2);
    rect(leftLimit,height-bottomSpacing,rightLimit-leftLimit,-boxHeight);
    textAlign(CENTER,TOP);
    textSize(18);
    text(classLeft[i]+classWidth/2,(leftLimit+rightLimit)/2,height-bottomSpacing+10);
  } //i loop (bar)
}

void keyPressed(){
  if(key=='c'){
    String fileName=str(year())+"_"+str(month())+"_"+str(day())+"_"+str(hour())+"_"+str(minute())+"_"+str(second())+".png";
    saveFrame(fileName);
  }
}
