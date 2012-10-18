package Stra;
public class Node{
    public int win;
    public int loss;
    public int matches;
    public Node(int win, int loss, int matches){
	this.win = win;
	this.loss = loss;
	this.matches = matches;
    }
    
    public int game(int c){
	return (c * 4);
    }



}