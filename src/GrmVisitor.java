// Generated from E:/Documents/My Files/languages & machins/Antler/Antler_Project/src\Grm.g4 by ANTLR 4.8
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link GrmParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface GrmVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link GrmParser#main}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMain(GrmParser.MainContext ctx);
	/**
	 * Visit a parse tree produced by {@link GrmParser#name}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitName(GrmParser.NameContext ctx);
}