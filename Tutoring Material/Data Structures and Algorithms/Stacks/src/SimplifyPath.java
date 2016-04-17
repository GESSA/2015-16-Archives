import java.util.LinkedList;
import java.util.Stack;

class SimplifyPath{
	
	
public static void main(String args[]){

	System.out.println(simplifyPath("/a/./b/../../c/d/../"));
}
	
public static String simplifyPath(String path) {
    if(path == null||path.length()==0)
        return path;
    
    Stack<String> stack = new Stack<String>();
    String[] list = path.split("/");
    
    for(int i=0; i<list.length; i++){
        if(list[i].equals(".")||list[i].length()==0)
            continue;
        else if(!list[i].equals(".."))
            stack.push(list[i]);
        else{
            if(!stack.isEmpty())
                stack.pop();
        }
    }
    
    StringBuilder res = new StringBuilder();
    
    Stack<String> temp = new Stack<String>();
    while(!stack.isEmpty())  
        temp.push(stack.pop());
    
    while(!temp.isEmpty())
        res.append("/"+temp.pop());
    
    if(res.length()==0)
        res.append("/");
    
    return res.toString();
}
}