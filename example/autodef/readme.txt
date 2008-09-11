Automatic Defination
Almost all singls(reg and wire) can be automatic declaration by this plugin if your code follow such rules:

1. You must indicate the data width of a signal at least one statement.
2. The valid data width indicator on the left hand is the one of the four below:
	[<constant>:X]; [<parameter or expression>:X]; [<constant>]; [<parameter or expression>], where X is do not care
3. The valid data width indicator on the right hand is only decimal constant like that:
	10'd, 16'h or 32'b
4. let a statement in one line as possible, conditional statement is an exception:
	a = expression1? b :
	    expression2? c : d;
5. You can declare a signal by yourself in any where, and the plugin will collect them and move to the declaration region.
6. If you declare the signal type in the port declaration, the plugin will ignore.
7. The ouput wires of instances can also be declared, and you must indicate its file in the comment line.
