(* ::Package:: *)

(* ::Title:: *)
(*Catch-Throw*)


(* ::Subtitle:: *)
(*\[CapitalRho]\[CurlyEpsilon]\[Tau]\[Sigma]\:03ad\[Lambda]\[Eta]\[FinalSigma] \[CapitalAlpha]\[Nu]\[Alpha]\[Sigma]\[Tau]\:03ac\[Sigma]\[Iota]\[Omicron]\[FinalSigma]-\[CapitalPhi]\[Alpha]\:03af\[Delta]\[Omega]\[Nu]*)


(* ::Subtitle:: *)
(*\[CapitalAlpha]\[CapitalEpsilon]\[CapitalMu]: 4394*)


(* ::Subtitle:: *)
(**)


(* ::Subtitle:: *)
(*\[CapitalEpsilon]\[Rho]\[Gamma]\[Alpha]\[Sigma]\:03af\[Alpha] \[Gamma]\[Iota]\[Alpha] \[Tau]\[Omicron] \[Mu]\:03ac\[Theta]\[Eta]\[Mu]\[Alpha] "\[CapitalPi]\[Rho]\[Omicron]\[Gamma]\[Rho]\[Alpha]\[Mu]\[Mu]\[Alpha]\[Tau]\[Iota]\[Sigma]\[Tau]\[Iota]\[Kappa]\:03ac \[CapitalEpsilon]\[Rho]\[Gamma]\[Alpha]\[Lambda]\[CurlyEpsilon]\:03af\[Alpha]"*)
(*\[CapitalPi]\[CapitalMu]\[CapitalSigma] \[CapitalUpsilon]\[Pi]\[Omicron]\[Lambda]\[Omicron]\[Gamma]\[Iota]\[Sigma]\[Tau]\[Iota]\[Kappa]\:03ae\[FinalSigma] \[CapitalPhi]\[Upsilon]\[Sigma]\[Iota]\[Kappa]\:03ae\[FinalSigma]*)


(* ::Section:: *)
(*\[CapitalEpsilon]\[Iota]\[Sigma]\[Alpha]\[Gamma]\[Omega]\[Gamma]\:03ae - \[CapitalOmicron]\[Rho]\[Iota]\[Sigma]\[Mu]\:03cc\[FinalSigma] \[CurlyEpsilon]\[Nu]\[Tau]\[Omicron]\[Lambda]\:03ce\[Nu]*)


(* ::Section:: *)
(**)


(* ::Section:: *)
(*Throw*)


(* ::Item1Numbered:: *)
(*Throw[value]: \[CapitalSigma]\[Tau]\[Alpha]\[Mu]\[Alpha]\[Tau]\:03ac\[CurlyEpsilon]\[Iota] \[Tau]\[Omicron]\[Nu] \[Upsilon]\[Pi]\[Omicron]\[Lambda]\[Omicron]\[Gamma]\[Iota]\[Sigma]\[Mu]\:03cc \[Kappa]\[Alpha]\[Iota] \[CurlyEpsilon]\[Pi]\[Iota]\[Sigma]\[Tau]\[Rho]\:03ad\[CurlyPhi]\[CurlyEpsilon]\[Iota] value \[Sigma]\[Tau]\[Eta]\[Nu] \[Kappa]\[Omicron]\[Nu]\[Tau]\[Iota]\[Nu]\:03cc\[Tau]\[CurlyEpsilon]\[Rho]\[Eta] Catch \[Pi]\[Omicron]\[Upsilon] \[Pi]\[CurlyEpsilon]\[Rho]\[Iota]\[Kappa]\[Lambda]\[CurlyEpsilon]\:03af\[CurlyEpsilon]\[Iota] \[Tau]\[Eta]\[Nu] Throw*)


(* ::Item1Numbered:: *)
(*Throw[value, tag]: \[CapitalPi]\[Iota]\:03ac\[Nu]\[CurlyEpsilon]\[Tau]\[Alpha]\[Iota] \[Mu]\:03cc\[Nu]\[Omicron] \[Alpha]\[Pi]\:03cc \[Tau]\[Eta]\[Nu] Catch[expr, form], \:03cc\[Pi]\[Omicron]\[Upsilon] \[Tau]\[Omicron] tag \[Tau]\[Alpha]\[Upsilon]\[Tau]\:03af\[Zeta]\[CurlyEpsilon]\[Tau]\[Alpha]\[Iota] \[Mu]\[CurlyEpsilon] \[Tau]\[Omicron] form*)


(* ::Item1Numbered:: *)
(*Throw[value, tag, f ]: \[CapitalEpsilon]\[Pi]\[Iota]\[Sigma]\[Tau]\[Rho]\:03ad\[CurlyPhi]\[CurlyEpsilon]\[Iota] f[value, tag] \[Omega]\[FinalSigma] top-level \[Tau]\[Iota]\[Mu]\:03ae \[CurlyEpsilon]\:03ac\[Nu] \[Delta]\[CurlyEpsilon]\[Nu] \[Beta]\[Rho]\[CurlyEpsilon]\[Theta]\[CurlyEpsilon]\:03af \[Eta] \[Kappa]\[Alpha]\[Tau]\:03ac\[Lambda]\[Lambda]\[Eta]\[Lambda]\[Eta] Catch*)


(* ::Text:: *)
(**)


(* ::Text:: *)
(*Catch*)


(* ::Item1Numbered:: *)
(*Catch[expr]: \[CurlyEpsilon]\[Pi]\[Iota]\[Sigma]\[Tau]\[Rho]\:03ad\[CurlyPhi]\[CurlyEpsilon]\[Iota] \[Tau]\[Omicron] \:03cc\[Rho]\[Iota]\[Sigma]\[Mu]\[Alpha] \[Tau]\[Eta]\[FinalSigma] \[Pi]\[Rho]\:03ce\[Tau]\[Eta]\[FinalSigma] Throw \[Pi]\[Omicron]\[Upsilon] \[Delta]\[Eta]\[Mu]\[Iota]\[Omicron]\[Upsilon]\[Rho]\[Gamma]\:03ae\[Theta]\[Eta]\[Kappa]\[CurlyEpsilon] \[Kappa]\[Alpha]\[Tau]\:03ac \[Tau]\[Omicron]\[Nu] \[Upsilon]\[Pi]\[Omicron]\[Lambda]\[Omicron]\[Gamma]\[Iota]\[Sigma]\[Mu]\:03cc \[Tau]\[Eta]\[FinalSigma] expr*)


(* ::Item1Numbered:: *)
(*Catch[expr, form]: \[CurlyEpsilon]\[Pi]\[Iota]\[Sigma]\[Tau]\[Rho]\:03ad\[CurlyPhi]\[CurlyEpsilon]\[Iota] \[Tau]\[Eta]\[Nu] value \[Alpha]\[Pi]\:03cc \[Tau]\[Eta]\[Nu] \[Pi]\[Rho]\:03ce\[Tau]\[Eta] Throw[value, tag] \[Gamma]\[Iota]\[Alpha] \[Tau]\[Eta]\[Nu] \[Omicron]\[Pi]\[Omicron]\:03af\[Alpha] \[Tau]\[Omicron] form \[Tau]\[Alpha]\[Upsilon]\[Tau]\:03af\[Zeta]\[CurlyEpsilon]\[Tau]\[Alpha]\[Iota] \[Mu]\[CurlyEpsilon] \[Tau]\[Omicron] tag*)


(* ::Item1Numbered:: *)
(*Catch[expr, form, f]: \[CurlyEpsilon]\[Pi]\[Iota]\[Sigma]\[Tau]\[Rho]\:03ad\[CurlyPhi]\[CurlyEpsilon]\[Iota] f[value, tag]*)


(* ::Section:: *)
(*\[CapitalEpsilon]\[Pi]\[CurlyEpsilon]\[Xi]\:03ae\[Gamma]\[Eta]\[Sigma]\[Eta] - \[CapitalPi]\[Alpha]\[Rho]\[Alpha]\[Delta]\[CurlyEpsilon]\:03af\[Gamma]\[Mu]\[Alpha]\[Tau]\[Alpha]*)


(* ::Subsection:: *)
(*\[CapitalOmicron]\[Iota] \[Delta]\:03cd\[Omicron] \[Pi]\[Alpha]\[Rho]\[Alpha]\[Pi]\:03ac\[Nu]\[Omega] \[CurlyEpsilon]\[Nu]\[Tau]\[Omicron]\[Lambda]\:03ad\[FinalSigma] \[CurlyEpsilon]\:03af\[Nu]\[Alpha]\[Iota] \[Chi]\[Rho]\:03ae\[Sigma]\[Iota]\[Mu]\[CurlyEpsilon]\[FinalSigma] \[Gamma]\[Iota]\[Alpha] \[Tau]\[Omicron]\[Nu] \:03ad\[Lambda]\[CurlyEpsilon]\[Gamma]\[Chi]\[Omicron] \[CurlyEpsilon]\[Nu]\:03cc\[FinalSigma] \[Pi]\[Rho]\[Omicron]\[Gamma]\[Rho]\:03ac\[Mu]\[Mu]\[Alpha]\[Tau]\[Omicron]\[FinalSigma], \[Gamma]\[Iota]\[Alpha] \[Nu]\[Alpha] \[Sigma]\[Tau]\[Alpha]\[Mu]\[Alpha]\[Tau]\:03ae\[Sigma]\[Omicron]\[Upsilon]\[Mu]\[CurlyEpsilon] \[Tau]\[Omicron]\[Nu] \[Upsilon]\[Pi]\[Omicron]\[Lambda]\[Omicron]\[Gamma]\[Iota]\[Sigma]\[Mu]\:03cc \[Kappa]\[Alpha]\[Iota] \[Nu]\[Alpha] \[CurlyEpsilon]\[Pi]\[Iota]\[Sigma]\[Tau]\[Rho]\:03ad\[Psi]\[Omicron]\[Upsilon]\[Mu]\[CurlyEpsilon] \[Tau]\[Eta]\[Nu] \[Kappa]\[Omicron]\[Nu]\[Tau]\[Iota]\[Nu]\:03cc\[Tau]\[CurlyEpsilon]\[Rho]\[Eta] \[Tau]\[Iota]\[Mu]\:03ae \[Tau]\[Omicron]\[Upsilon] \[Upsilon]\[Pi]\[Omicron]\[Lambda]\[Omicron]\[Gamma]\[Iota]\[Sigma]\[Mu]\[Omicron]\:03cd. \[CapitalPi]\[Alpha]\[Rho]\[Alpha]\[Tau]\[Eta]\[Rho]\[Omicron]\:03cd\[Mu]\[CurlyEpsilon] \[Pi]\[Omega]\[FinalSigma] \[Omicron]\[Iota] \[Delta]\[Upsilon]\[Omicron] \[CurlyEpsilon]\[Nu]\[Tau]\[Omicron]\[Lambda]\:03ad\[FinalSigma] \[Sigma]\[Chi]\[CurlyEpsilon]\[Tau]\:03af\[Zeta]\[Omicron]\[Nu]\[Tau]\[Alpha]\[Iota] \:03ac\[Mu]\[CurlyEpsilon]\[Sigma]\[Alpha] \[Mu]\[CurlyEpsilon]\[Tau]\[Alpha]\[Xi]\:03cd \[Tau]\[Omicron]\[Upsilon]\[FinalSigma], \:03cc\[Pi]\[Omicron]\[Upsilon] \[Pi]\[Rho]\[Alpha]\[Kappa]\[Tau]\[Iota]\[Kappa]\:03ac \[Sigma]\[Tau]\[Eta]\[Nu] \[Pi]\[Iota]\[Omicron] \[Alpha]\[Pi]\[Lambda]\:03ae \[Mu]\[Omicron]\[Rho]\[CurlyPhi]\:03ae \[Eta] Throw \[Sigma]\[Tau]\[Alpha]\[Mu]\[Alpha]\[Tau]\:03ac\[CurlyEpsilon]\[Iota] \[Tau]\[Omicron]\[Nu] \[Upsilon]\[Pi]\[Omicron]\[Lambda]\[Omicron]\[Gamma]\[Iota]\[Sigma]\[Mu]\:03cc \[Sigma]\[Tau]\[Eta] Mathematica \[Kappa]\[Alpha]\[Iota] \[Sigma]\[Upsilon]\[Nu]\[CurlyEpsilon]\[Chi]\:03af\[Zeta]\[CurlyEpsilon]\[Iota] \[Sigma]\[Tau]\[Eta]\[Nu] \[Kappa]\[Omicron]\[Nu]\[Tau]\[Iota]\[Nu]\:03cc\[Tau]\[CurlyEpsilon]\[Rho]\[Eta] \[Delta]\[Upsilon]\[Nu]\[Alpha]\[Tau]\:03ae \[CurlyEpsilon]\[Nu]\[Tau]\[Omicron]\[Lambda]\:03ae Catch. \[CapitalEpsilon]\:03af\[Nu]\[Alpha]\[Iota] \[Sigma]\[Eta]\[Mu]\[Alpha]\[Nu]\[Tau]\[Iota]\[Kappa]\:03cc \[Nu]\[Alpha] \[Alpha]\[Nu]\[Alpha]\[CurlyPhi]\:03ad\[Rho]\[Theta]\[CurlyEpsilon]\[Iota] \[Pi]\[Omega]\[FinalSigma] \[Omicron]\[Iota] \[Delta]\:03cd\[Omicron] \[Alpha]\[Upsilon]\[Tau]\:03ad\[FinalSigma] \[CurlyEpsilon]\[Nu]\[Tau]\[Omicron]\[Lambda]\:03ad\[FinalSigma] \[Alpha]\[Nu]\[Tau]\[Iota]\[Mu]\[CurlyEpsilon]\[Tau]\[Omega]\[Pi]\:03af\[Zeta]\[Omicron]\[Nu]\[Tau]\[Alpha]\[Iota] \[Sigma]\[Alpha]\[Nu] global \[Delta]\[Eta]\[Lambda]\[Alpha]\[Delta]\:03ae \[Mu]\:03cc\[Lambda]\[Iota]\[FinalSigma] \[Eta] Mathematica \[Delta]\[Iota]\[Alpha]\[Beta]\:03ac\[Sigma]\[CurlyEpsilon]\[Iota] \[Tau]\[Eta]\[Nu] Throw \[Sigma]\[Tau]\[Alpha]\[Mu]\[Alpha]\[Tau]\:03ac\[CurlyEpsilon]\[Iota] \[Omicron] \[Upsilon]\[Pi]\[Omicron]\[Lambda]\[Omicron]\[Gamma]\[Iota]\[Sigma]\[Mu]\:03cc\[FinalSigma] \[Pi]\:03ac\[Nu]\[Tau]\[Alpha] \[Kappa]\[Alpha]\[Iota] \[Pi]\[Eta]\[Gamma]\[Alpha]\:03af\[Nu]\[CurlyEpsilon]\[Iota] \[Sigma]\[Tau]\[Eta]\[Nu] Catch. \[CapitalChi]\[Rho]\[Eta]\[Sigma]\[Iota]\[Mu]\[Omicron]\[Pi]\[Omicron]\[Iota]\[Omicron]\:03cd\[Nu]\[Tau]\[Alpha]\[Iota] \[Kappa]\[Upsilon]\[Rho]\:03af\[Omega]\[FinalSigma] \[Gamma]\[Iota]\[Alpha] \[Nu]\[Alpha] \[Delta]\[Iota]\[Alpha]\[Kappa]\:03cc\[Psi]\[Omicron]\[Upsilon]\[Nu] \:03ae \[Nu]\[Alpha] \[Pi]\[Alpha]\[Rho]\[Alpha]\[Kappa]\:03ac\[Mu]\[Psi]\[Omicron]\[Upsilon]\[Nu] \[Delta]\[Iota]\:03ac\[CurlyPhi]\[Omicron]\[Rho]\[CurlyEpsilon]\[FinalSigma] \[Delta]\[Iota]\[Alpha]\[Delta]\[Iota]\[Kappa]\[Alpha]\[Sigma]\:03af\[CurlyEpsilon]\[FinalSigma] \[Pi]\[Rho]\[Omicron]\[Gamma]\[Rho]\[Alpha]\[Mu]\[Mu]\[Alpha]\[Tau]\[Iota]\[Sigma]\[Mu]\[Omicron]\:03cd \[Sigma]\[Tau]\[Eta] Mathematica, \:03cc\[Pi]\[Omega]\[FinalSigma] \[Gamma]\[Iota]\[Alpha] \[Pi]\[Alpha]\[Rho]\:03ac\[Delta]\[CurlyEpsilon]\[Iota]\[Gamma]\[Mu]\[Alpha] \[Omicron]\[Iota] \[CurlyEpsilon]\[Pi]\[Alpha]\[Nu]\[Alpha]\[Lambda]\:03ae\[Psi]\[CurlyEpsilon]\[Iota]\[FinalSigma] \:03ae \[Eta] \[Delta]\[Eta]\[Mu]\[Iota]\[Omicron]\[Upsilon]\[Rho]\[Gamma]\:03af\[Alpha] \[Mu]\[Iota]\[Alpha]\[FinalSigma] \[Lambda]\:03af\[Sigma]\[Tau]\[Alpha]\[FinalSigma]. \[CapitalMu]\[Pi]\[Omicron]\[Rho]\[CurlyEpsilon]\:03af \[CurlyEpsilon]\[Pi]\:03af\[Sigma]\[Eta]\[FinalSigma] \[Nu]\[Alpha] \[Chi]\[Rho]\[Eta]\[Sigma]\[Iota]\[Mu]\[Omicron]\[Pi]\[Omicron]\[Iota]\[Eta]\[Theta]\[CurlyEpsilon]\:03af \[Gamma]\[Iota]\[Alpha] \[Tau]\[Omicron]\[Nu] \:03ad\[Lambda]\[CurlyEpsilon]\[Gamma]\[Chi]\[Omicron] \[Tau]\[Omicron]\[Upsilon] \[Pi]\[Rho]\[Omicron]\[Gamma]\[Rho]\:03ac\[Mu]\[Mu]\[Alpha]\[Tau]\[Omicron]\[FinalSigma], \[Kappa]\[Alpha]\[Iota] \[Nu]\[Alpha] \[Delta]\[Omicron]\[Theta]\[Omicron]\:03cd\[Nu] \[CurlyEpsilon]\[Xi]\[Alpha]\[Tau]\[Omicron]\[Mu]\[Iota]\[Kappa]\[CurlyEpsilon]\[Upsilon]\[Mu]\:03ad\[Nu]\[Alpha] \[Mu]\[Eta]\[Nu]\:03cd\[Mu]\[Alpha]\[Tau]\[Alpha] \[Sigma]\[CurlyPhi]\:03ac\[Lambda]\[Mu]\[Alpha]\[Tau]\[Omicron]\[FinalSigma] \[Sigma]\[Tau]\[Omicron]\[Nu] \[Chi]\[Rho]\:03ae\[Sigma]\[Tau]\[Eta]. *)


(* ::Section:: *)
(*\[CapitalPi]\[Alpha]\[Rho]\:03ac\[Delta]\[CurlyEpsilon]\[Iota]\[Gamma]\[Mu]\[Alpha] #1*)


(* ::Subsection:: *)
(*\[CapitalNu]\[Alpha] \[Beta]\[Rho]\[CurlyEpsilon]\[Theta]\[CurlyEpsilon]\:03af \[Omicron] \[Pi]\[Rho]\:03ce\[Tau]\[Omicron]\[FinalSigma] \[Kappa]\[Alpha]\[Tau]\:03ac \[Sigma]\[CurlyEpsilon]\[Iota]\[Rho]\:03ac 8-\[Psi]\:03ae\[CurlyPhi]\[Iota]\[Omicron]\[FinalSigma] \[Alpha]\[Kappa]\:03ad\[Rho]\[Alpha]\[Iota]\[Omicron]\[FinalSigma] \[Alpha]\[Rho]\[Iota]\[Theta]\[Mu]\:03cc\[FinalSigma] x \[Pi]\[Omicron]\[Upsilon] \[CurlyEpsilon]\:03af\[Nu]\[Alpha]\[Iota] \[Alpha]\[Pi]\[Omicron]\[Tau]\:03ad\[Lambda]\[CurlyEpsilon]\[Sigma]\[Mu]\[Alpha] \[Tau]\[Eta]\[FinalSigma] \[Pi]\[Rho]\:03ac\[Xi]\[Eta]\[FinalSigma] 2^y=x, \:03cc\[Pi]\[Omicron]\[Upsilon] y \[Alpha]\[Kappa]\:03ad\[Rho]\[Alpha]\[Iota]\[Omicron]\[FinalSigma].*)


(* ::Input:: *)
(*k=8;*)
(*Catch[Do[If[IntegerLength[2^y]==k, Throw[2^y]],{y,0,1000}]]*)


(* ::Subsection:: *)
(*\[CapitalSigma]\[Tau]\[Omicron] \[Pi]\[Alpha]\[Rho]\[Alpha]\[Pi]\:03ac\[Nu]\[Omega] \[Pi]\[Alpha]\[Rho]\:03ac\[Delta]\[CurlyEpsilon]\[Iota]\[Gamma]\[Mu]\[Alpha], \[CurlyEpsilon]\:03ac\[Nu] \[Alpha]\[Lambda]\[Lambda]\:03ac\[Xi]\[Omicron]\[Upsilon]\[Mu]\[CurlyEpsilon] \[Tau]\[Eta] \[Tau]\[Iota]\[Mu]\:03ae \[Tau]\[Omicron]\[Upsilon] k, \[Eta] Throw \[Kappa]\[Alpha]\[Iota] \[Eta] Catch \[Theta]\[Alpha] \[Mu]\[Alpha]\[FinalSigma] \[CurlyEpsilon]\[Pi]\[Iota]\[Sigma]\[Tau]\[Rho]\:03ad\[Psi]\[Omicron]\[Upsilon]\[Nu] \[Tau]\[Omicron]\[Nu] \[Alpha]\[Nu]\[Tau]\:03af\[Sigma]\[Tau]\[Omicron]\[Iota]\[Chi]\[Omicron] \[Pi]\[Rho]\:03ce\[Tau]\[Omicron] \[Kappa]\[Alpha]\[Tau]\:03ac \[Sigma]\[CurlyEpsilon]\[Iota]\[Rho]\:03ac k-\[Psi]\:03ae\[CurlyPhi]\[Iota]\[Omicron] \[Alpha]\[Rho]\[Iota]\[Theta]\[Mu]\:03cc \[Pi]\[Omicron]\[Upsilon] \[CurlyEpsilon]\:03af\[Nu]\[Alpha]\[Iota] \[Alpha]\[Pi]\[Omicron]\[Tau]\:03ad\[Lambda]\[CurlyEpsilon]\[Sigma]\[Mu]\[Alpha] \[Tau]\[Eta]\[FinalSigma] \[Pi]\[Alpha]\[Rho]\[Alpha]\[Pi]\:03ac\[Nu]\[Omega] \[Pi]\[Rho]\:03ac\[Xi]\[Eta]\[FinalSigma].*)


(* ::Section:: *)
(*\[CapitalPi]\[Alpha]\[Rho]\:03ac\[Delta]\[CurlyEpsilon]\[Iota]\[Gamma]\[Mu]\[Alpha] #2*)


(* ::Subsection:: *)
(*\[CapitalNu]\[Alpha] \[Delta]\[Omicron]\[Theta]\[CurlyEpsilon]\:03af \[CurlyEpsilon]\[Xi]\[Alpha]\[Tau]\[Omicron]\[Mu]\[Iota]\[Kappa]\[CurlyEpsilon]\[Upsilon]\[Mu]\:03ad\[Nu]\[Omicron] \[Mu]\:03ae\[Nu]\[Upsilon]\[Mu]\[Alpha] \[Lambda]\:03ac\[Theta]\[Omicron]\[Upsilon]\[FinalSigma] \[CurlyEpsilon]\:03ac\[Nu] \[Omicron] \[Chi]\[Rho]\:03ae\[Sigma]\[Tau]\[Eta]\[FinalSigma] \[Zeta]\[Eta]\[Tau]\:03ae\[Sigma]\[CurlyEpsilon]\[Iota] \[Tau]\[Iota]\[Mu]\:03ae \[CurlyEpsilon]\[Kappa]\[Tau]\:03cc\[FinalSigma] \[Tau]\[Omicron]\[Upsilon] \[Pi]\[CurlyEpsilon]\[Delta]\:03af\[Omicron]\[Upsilon] \[Omicron]\[Rho]\[Iota]\[Sigma]\[Mu]\[Omicron]\:03cd \[Tau]\[Eta]\[FinalSigma] \[Sigma]\[Upsilon]\[Nu]\:03ac\[Rho]\[Tau]\[Eta]\[Sigma]\[Eta]\[FinalSigma] 1/(x(x-2))*)


(* ::Input:: *)
(*f[x_]:=If[x==0||x==2,Throw["Chosen value outside of function domain for f(x)! Pick another value, or Mathematica will be mad!"],1/(x*(x-2))]*)


(* ::Input:: *)
(*f[1]*)


(* ::Input:: *)
(*Catch[f[1]]*)


(* ::Input:: *)
(*Catch[f[2]]*)


(* ::Section:: *)
(*\[CapitalPi]\[Alpha]\[Rho]\:03ac\[Delta]\[CurlyEpsilon]\[Iota]\[Gamma]\[Mu]\[Alpha] #3*)


(* ::Subsection:: *)
(*\[CapitalNu]\[Alpha] \[Delta]\[Eta]\[Mu]\[Iota]\[Omicron]\[Upsilon]\[Rho]\[Gamma]\[Eta]\[Theta]\[Omicron]\:03cd\[Nu] 20 \[Psi]\[CurlyEpsilon]\[Upsilon]\[Delta]\[Omicron]\[Tau]\[Upsilon]\[Chi]\[Alpha]\:03af\[Omicron]\[Iota] \[Alpha]\[Kappa]\:03ad\[Rho]\[Alpha]\[Iota]\[Omicron]\[Iota] \[Alpha]\[Rho]\[Iota]\[Theta]\[Mu]\[Omicron]\:03af \[Alpha]\[Pi]\:03cc \[Tau]\[Omicron] \[Delta]\[Iota]\:03ac\[Sigma]\[Tau]\[Eta]\[Mu]\[Alpha] [-10,10] \[Kappa]\[Alpha]\[Iota] \[CurlyEpsilon]\[Alpha]\[Nu] \[Tau]\[Omicron] \:03ac\[Theta]\[Rho]\[Omicron]\[Iota]\[Sigma]\[Mu]\[Alpha] \[Tau]\[Omega]\[Nu] \[Alpha]\[Rho]\[Iota]\[Theta]\[Mu]\:03ce\[Nu] \[CurlyEpsilon]\:03af\[Nu]\[Alpha]\[Iota] \[Alpha]\[Rho]\[Nu]\[Eta]\[Tau]\[Iota]\[Kappa]\:03cc\[FinalSigma] \:03ae \[Mu]\[Eta]\[Delta]\:03ad\[Nu] \[Nu]\[Alpha] \[CurlyEpsilon]\[Pi]\[Iota]\[Sigma]\[Tau]\[Rho]\[Alpha]\[CurlyPhi]\[CurlyEpsilon]\:03af \[Mu]\:03ae\[Nu]\[Upsilon]\[Mu]\[Alpha] \[Sigma]\[Tau]\[Omicron] \[Chi]\[Rho]\:03ae\[Sigma]\[Tau]\[Eta], \[Alpha]\[Lambda]\[Lambda]\[Iota]\:03ce\[FinalSigma] \[Nu]\[Alpha] \[Tau]\[Upsilon]\[Pi]\[Omega]\[Theta]\[CurlyEpsilon]\:03af \[Tau]\[Omicron] \:03ac\[Theta]\[Rho]\[Omicron]\[Iota]\[Sigma]\[Mu]\[Alpha].*)


(* ::Input:: *)
(*list=RandomInteger[{-10,10},20]*)
(*Catch[If[Total[list]<=0,Throw["You are unlucky, sum is negative or zero!"],Total[list]]]*)


(* ::Section:: *)
(*\[CapitalPi]\[Alpha]\[Rho]\:03ac\[Delta]\[CurlyEpsilon]\[Iota]\[Gamma]\[Mu]\[Alpha] #4*)


(* ::Subsection:: *)
(*\:0388\[Sigma]\[Tau]\[Omega] \[Mu]\[Pi]\:03ac\[Lambda]\[Alpha] \[Eta] \[Omicron]\[Pi]\[Omicron]\:03af\[Alpha] \[CurlyEpsilon]\[Kappa]\[Tau]\[Omicron]\[Xi]\[CurlyEpsilon]\:03cd\[CurlyEpsilon]\[Tau]\[Alpha]\[Iota] \[Kappa]\[Alpha]\[Tau]\[Alpha]\[Kappa]\:03cc\[Rho]\[Upsilon]\[CurlyPhi]\[Alpha] \[Alpha]\[Pi]\:03cc \:03cd\[Psi]\[Omicron]\[FinalSigma] h=5 m \[Mu]\[CurlyEpsilon] \[Tau]\[Alpha]\[Chi]\:03cd\[Tau]\[Eta]\[Tau]\[Alpha] v = 6 m/s. \[CapitalNu]\[Alpha] \[Sigma]\[Chi]\[CurlyEpsilon]\[Delta]\[Iota]\[Alpha]\[Sigma]\[Tau]\[CurlyEpsilon]\:03af \[Tau]\[Omicron] \[Delta]\[Iota]\:03ac\[Gamma]\[Rho]\[Alpha]\[Mu]\[Mu]\[Alpha] \:03cd\[Psi]\[Omicron]\[Upsilon]\[FinalSigma]-\[Chi]\[Rho]\:03cc\[Nu]\[Omicron]\[Upsilon] \[Mu]\:03ad\[Chi]\[Rho]\[Iota] \[Eta] \[Mu]\[Pi]\:03ac\[Lambda]\[Alpha] \[Nu]\[Alpha] \[CurlyPhi]\[Tau]\:03ac\[Sigma]\[CurlyEpsilon]\[Iota] \[Sigma]\[Tau]\[Omicron] \:03ad\[Delta]\[Alpha]\[CurlyPhi]\[Omicron]\[FinalSigma].*)


(* ::Input:: *)
(*h0=5;*)
(*v0 =6 ;*)
(*g=9.8;*)
(*h[t_]=h0+(v0*t)-(g*t^2)/2;*)
(*Plot[h[t],{t,0,4},AxesLabel->{Time,Height}]*)


(* ::Input:: *)
(*(* \[CapitalTau]\:03ce\[Rho]\[Alpha] \[Theta]\[Alpha] \[Chi]\[Rho]\[Eta]\[Sigma]\[Iota]\[Mu]\[Omicron]\[Pi]\[Omicron]\[Iota]\:03ae\[Sigma]\[Omicron]\[Upsilon]\[Mu]\[CurlyEpsilon] Catch-Throw \[Gamma]\[Iota]\[Alpha] \[Nu]\[Alpha] \[Kappa]\:03ac\[Nu]\[Omicron]\[Upsilon]\[Mu]\[CurlyEpsilon] \[Tau]\[Omicron] \[Sigma]\[Omega]\[Sigma]\[Tau]\:03cc \[Gamma]\[Rho]\:03ac\[CurlyPhi]\[Eta]\[Mu]\[Alpha] *)*)
(*step=0.0001;*)
(*res = Catch[Do[If[h[t]<0,Throw[t-step]],{t,1,10000,step}]];*)
(*Plot[h[t],{t,0,res},AxesLabel->{Time,Height}]*)
