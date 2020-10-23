(* ::Package:: *)

(* ::Input:: *)
(*q=Normal[Series[Exp[x],{x,0,4}]]*)
(*Exp[2]//N*)
(*q/.x -> 2 //N*)


(* ::Input:: *)
(*q=Normal[Series[Exp[x],{x,0,8}]] (* Adding more terms theoretically improves accuracy *)*)
(*Exp[2]//N*)
(*q/.x -> 2 //N*)


(* ::Input:: *)
(*1/(1+x^2)/.x->2//N*)


(* ::Input:: *)
(*p=Normal[Series[1/(1+x^2),{x,0,100}]]*)
(*p/.x->2*)


(* ::Input:: *)
(*(* Power series converge until the closest irregular singular point! In the case of 1/1-x^2, since x=1 is an irregular singular point, we have to choose a different center to expand our series. The example above 1/(1+x^2) has an irregular singular point in complex numbers (and it is i). Therefore, we can only use the Taylor series only up to a radius of 1! For everything else, we need to pick a different center to expand our series! It is important to remember that irregular points can appear in the complex plane, and not only in the plane of the real numbers!*)*)
(**)


(* ::Input:: *)
(**)
