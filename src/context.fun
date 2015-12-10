functor Metacontext
  (structure Metavariable : SYMBOL
   structure Valence : EQ) :> METACONTEXT where type metavariable = Metavariable.t and type valence = Valence.t =
struct
  type metavariable = Metavariable.t
  type valence = Valence.t

  structure Ctx = SplayDict (structure Key = struct open Metavariable Metavariable.Eq end)
  type t = valence Ctx.dict

  exception MetavariableNotFound
  exception MergeFailure

  val empty = Ctx.empty
  val isEmpty = Ctx.isEmpty
  val toList = Ctx.toList

  fun merge (v, v') =
    if Valence.eq (v, v') then
      v'
    else
      raise MergeFailure

  fun extend Th (m, v) =
    Ctx.insertMerge Th m v
      (fn v' => merge (v, v'))

  fun union (Th, Th') =
    Ctx.union Th Th'
      (fn (_, v, v') => merge (v, v'))

  fun lookup Th m =
    Ctx.lookup Th m
      handle _ => raise MetavariableNotFound

  val find = Ctx.find

end
