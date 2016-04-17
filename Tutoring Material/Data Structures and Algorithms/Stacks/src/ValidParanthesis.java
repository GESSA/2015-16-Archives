import java.util.Stack;

public class ValidParanthesis {
	public static void main(String args[]){
	System.out.println(isValid("([]){}}"));
	}
	
	
	public static boolean isValid(String s) {
	        if(s.length()==1)
	            return false;
	        Stack<String> stack = new Stack<String>();
	        
	        for(int i=0;i<s.length();i++){
	            if(s.charAt(i)=='(' || s.charAt(i)=='{' || s.charAt(i)=='[')
	                stack.push(s.charAt(i)+"");
	            else{
	                 if(!stack.isEmpty()){
	                    String top = stack.peek();
	                    if(top.equals("{") && s.charAt(i)=='}')
	                        stack.pop();
	                    else if(top.equals("(") && s.charAt(i)==')')
	                        stack.pop();
	                    else if(top.equals("[") && s.charAt(i)==']')
	                        stack.pop();
	                    else
	                        return false;
	                 }else
	                    return false;
	                
	            }
	            
	            
	        }
	        if(stack.isEmpty())
	            return true;
	        else
	            return false;
	    }
	}

