Package["SetReplace`"]

PackageImport["GeneralUtilities`"]

PackageExport["SetReplaceFixedPointList"]

(* Same as SetReplaceFixedPoint, but returns all intermediate steps. *)

SetReplaceFixedPointList::usage = usageString[
  "SetReplaceFixedPointList[`s`, {\!\(\*SubscriptBox[\(`i`\), \(`1`\)]\) \[Rule] ",
  "\!\(\*SubscriptBox[\(`o`\), \(`1`\)]\), ",
  "\!\(\*SubscriptBox[\(`i`\), \(`2`\)]\) \[Rule] ",
  "\!\(\*SubscriptBox[\(`o`\), \(`2`\)]\), \[Ellipsis]}] performs SetReplace repeatedly ",
  "until no further events can be matched, ",
  "and returns the list of all intermediate sets."];

SyntaxInformation[SetReplaceFixedPointList] =
  {"ArgumentsPattern" -> {_, _, OptionsPattern[]}};

SetReplaceFixedPointList[args___] := 0 /;
  !Developer`CheckArgumentCount[SetReplaceFixedPointList[args], 2, 2] && False

Options[SetReplaceFixedPointList] = {
  Method -> Automatic,
  TimeConstraint -> Infinity,
  "EventOrderingFunction" -> Automatic};

SetReplaceFixedPointList[set_, rules_, o : OptionsPattern[]] /;
    recognizedOptionsQ[expr, SetReplaceFixedPointList, {o}] := ModuleScope[
  result = Check[
    setSubstitutionSystem[
      rules, set, <||>, SetReplaceFixedPointList, False, o],
    $Failed];
  If[result === $Aborted, result, result["SetAfterEvent", #] & /@ Range[0, result["EventsCount"]]] /;
    result =!= $Failed
]
