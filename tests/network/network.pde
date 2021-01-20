PVector pos = new PVector(0, 0);


float[] box = {30, 30, 20, 20};
float[] circ = {0, 0, 20};




void setup() {
}
void draw() {
  fill(0);
  background(255);
  rect(box[0]-pos.x + width/2, box[1]- pos.y + height/2, box[2], box[3]);
  circle(circ[0]-pos.x + width/2, circ[1]- pos.y + height/2, circ[2]);
  fill(#ff00f0);
  circle(width/2, height/2, 20);
  
  
  switch(key) {
    case('w'):
    pos.y= pos.y-1;
    break;

    case('a'):
    pos.x= pos.x-1;
    break;

    case('s'):
    pos.y= pos.y+1;
    break;

    case('d'):
    pos.x= pos.x+1;
  }
}
void keyPressed() {
  
}
