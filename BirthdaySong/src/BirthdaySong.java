
public class BirthdaySong {
	
	public static String BirthdaySong(String place, String noun, String verb){
		
		String songstring = "Happy birthday to you, \n";
		songstring = songstring + "you live in a " + place + ", \n";
		songstring = songstring + "you look like a " + noun + ", \n";
		songstring = songstring + "and you " + verb + " like one too!";
		return songstring;
		}
	
	public static void main(String[] args){
		
		String place = "hospital";
		String noun = "cactus";
		String verb = "eat";
		
		System.out.println(BirthdaySong(place, noun, verb));
		
	}
	
	//System.out.println(
	
	

}
