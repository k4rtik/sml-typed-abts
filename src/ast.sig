signature AST =
sig
  type 'i operator
  type 'a spine

  type symbol = string
  type variable = string
  type metavariable

  datatype ast =
      ` of variable
    | $ of symbol operator * btm spine
    | $# of metavariable * (symbol spine * ast spine)
  and btm = \ of (symbol spine * variable spine) * ast
end

signature AST_ABT =
sig
  structure Abt : ABT
  structure Ast : AST

  sharing type Ast.operator = Abt.Operator.t
  sharing type Ast.metavariable = Abt.Metavariable.t
  sharing type Ast.spine = Abt.Operator.Arity.Valence.Spine.t
end

signature AST_TO_ABT =
sig
  include AST_ABT

  val convert : Abt.metacontext -> Ast.ast * Abt.sort -> Abt.abt
end
