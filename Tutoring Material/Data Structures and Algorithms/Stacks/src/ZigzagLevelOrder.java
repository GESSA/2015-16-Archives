import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

import javax.swing.tree.TreeNode;

public class ZigzagLevelOrder {
	
	public static void main(String args[]){
	int index = 1;
    
    List<List<Integer>> list = new ArrayList<List<Integer>>();
    ArrayList<Integer> nodeValues = new ArrayList<Integer>();
    if(root==null)
        return list;
    Stack<TreeNode> curr = new Stack<TreeNode>();
    Stack<TreeNode> next = new Stack<TreeNode>();
    curr.push(root);
    while(!curr.isEmpty()){
        TreeNode node = curr.pop();
        if(index%2!=0){
            if(node.left!=null)
                next.push(node.left);
            if(node.right!=null)
                next.push(node.right);
        }
        else {
            if(node.right!=null)
                next.push(node.right);
        
            if(node.left!=null)
                next.push(node.left);
            }
        nodeValues.add(node.val);
        if(curr.isEmpty()){
            curr = next;
            list.add(nodeValues);
            nodeValues = new ArrayList<Integer>();
            next = new Stack<TreeNode>();
            index++;
        }
        
    }
    return list;
}
}