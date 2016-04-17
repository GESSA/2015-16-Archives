import java.util.Stack;

public class NumberOfBracketReversals {
	public static void main(String args[]) {
		String expr = "{}{}{{{{";
		int len = expr.length();

		if (len % 2 == 1) {
			System.out.println("No balance possible");
			return;
		}
		// After this loop, stack contains unbalanced
		// part of expression, i.e., expression of the
		// form "}}..}{{..{"
		Stack<Character> s = new Stack<>();
		for (int i = 0; i < len; i++) {
			if (expr.charAt(i) == '}' && !s.empty()) {
				if (s.peek() == '{')
					s.pop();
				else
					s.push(expr.charAt(i));
			} else
				s.push(expr.charAt(i));
		}

		// Length of the reduced expression
		// red_len = (m+n)
		int red_len = s.size();
		System.out.println("new length " + red_len);
		// count opening brackets at the end of
		// stack
		int n = 0;
		while (!s.empty() && s.peek() == '{') {
			s.pop();
			n++;
		}

		// return ceil(m/2) + ceil(n/2) which is
		// actually equal to (m+n)/2 + n%2 when
		// m+n is even.
		System.out.println("Reversals required: " + (red_len / 2 + n % 2));

	}

}
