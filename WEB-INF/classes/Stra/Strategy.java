package Stra;
public class Strategy{
    int a;
    public Strategy(int b, int c){
	a = b;
    }

    public int game(int c){
	return (c * 2);
    }

}