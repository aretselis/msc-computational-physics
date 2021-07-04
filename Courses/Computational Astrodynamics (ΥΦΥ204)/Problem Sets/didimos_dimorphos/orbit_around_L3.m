(* ::Package:: *)

(* ::Input:: *)
(*Clear["Global`*"]*)
(*mdidimos = 5.32*10^11;*)
(*mdimorphos= 4.94*10^9;*)
(*Rdidimos = 325;*)
(*Rdimorphos = 80;*)
(*rorbit = 1180;*)
(*m = mdimorphos/(mdidimos+mdimorphos)*)
(*a=(m/3)^(1/3);*)
(*Body1=Circle[{-m,0}, Rdidimos/rorbit];*)
(*Body2=Circle[{1-m,0},Rdimorphos/rorbit];*)


(* ::Input:: *)
(*xin=-1.003833403;*)
(*yin=0;*)
(*r1t=Sqrt[(xin+m)^2+yin^2]; r2t=Sqrt[(xin-1+m)^2+yin^2];*)


(* ::Input:: *)
(*Uxx = 1+2*(((1-m)/(r1t)^3)+m/(r2t)^3);*)
(*Uyy = 1-(((1-m)/(r1t)^3)+m/(r2t)^3);*)
(*Uxy = 0;*)
(*A = ({*)
(* {0, 0, 1, 0},*)
(* {0, 0, 0, 1},*)
(* {Uxx, Uxy, 0, 2},*)
(* {Uxy, Uyy, -2, 0}*)
(*});*)
(*Eigenvalues[A]*)


(* ::Input:: *)
(*eigenresult = Eigenvectors[A]*)
(*positiveeigenvector = Re[Last[eigenresult]]         *)


(* ::Input:: *)
(*r1=Sqrt[(x[t]+m)^2+y[t]^2]; r2=Sqrt[(x[t]-1+m)^2+y[t]^2];*)
(*deq1=x''[t]-2 y'[t]-x[t]==-(1-m)(x[t]+m)/r1^3-m*(x[t]-1+m)/r2^3;*)
(*deq2=y''[t]+2x'[t]-y[t]==-y[t]((1-m)/r1^3+m/r2^3);*)
(*ivp={deq1,deq2,x[0]==x0, y[0]==y0,x'[0]==vx0, y'[0]==vy0}*)
(*tmax=100;*)
(*h=-1.5*)
(*x0=-1.003833403473104+0.01*positiveeigenvector[[1]]; *)
(*y0=0+0.01*positiveeigenvector[[2]]; *)
(*vx0=+positiveeigenvector[[3]]; *)
(*R1=r1/.{x[t]->x0,y[t]->y0};*)
(*R2=r2/.{x[t]->x0,y[t]->y0};*)
(*vy02=2*(h+(1-m)/R1+m/R2+1/2 (x0^2+y0^2))-vx0^2*)
(*If[vy02>0, vy0=positiveeigenvector[[4]]; Print["Vy0=",vy0], "ERROR in Initial Conditions"]*)
(*Body3start=ListPlot[{{x0,y0}},PlotStyle->{Red,PointSize[0.01]}];*)


(* ::Input:: *)
(*sol=NDSolve[ivp,{x,y},{t,0,tmax}, MaxSteps->100000];*)
(*xx=x[t]/.sol[[1]]*)
(*yy=y[t]/.sol[[1]]*)
(*Body3end=ListPlot[{{xx/.t->tmax,yy/.t->tmax}},PlotStyle->{Gray,PointSize[0.01]}];*)


(* ::Input:: *)
(*orbit=ParametricPlot[{xx,yy},{t,0,tmax}]*)
(*Show[{orbit,Graphics[ Body2], Graphics[ Body1],Body3start, Body3end}, PlotRange->All]*)


(* ::Input:: *)
(*XX=xx*Cos[t]-yy*Sin[t];*)
(*YY=xx*Sin[t]+yy*Cos[t];*)
(*ParametricPlot[{XX,YY},{t,0,tmax}, PlotRange->{{-2.5, 2.5},{-2.5,2.5}}]*)
