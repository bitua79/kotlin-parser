// Generated from E:/Documents/My Files/languages & machins/Antler/Antler_Project/src\Grm.g4 by ANTLR 4.8
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link GrmParser}.
 */
public interface GrmListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link GrmParser#main}.
	 * @param ctx the parse tree
	 */
	void enterMain(GrmParser.MainContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrmParser#main}.
	 * @param ctx the parse tree
	 */
	void exitMain(GrmParser.MainContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrmParser#name}.
	 * @param ctx the parse tree
	 */
	void enterName(GrmParser.NameContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrmParser#name}.
	 * @param ctx the parse tree
	 */
	void exitName(GrmParser.NameContext ctx);
}