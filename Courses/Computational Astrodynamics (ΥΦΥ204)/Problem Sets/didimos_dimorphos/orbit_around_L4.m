(* ::Package:: *)

(* ::Input:: *)
(*Clear["Global`*"]*)
(*mdidimos = 5.32*10^11;*)
(*mdimorphos= 4.94*10^9;*)
(*Rdidimos = 325;*)
(*Rdimorphos = 80;*)
(*rorbit = 1180;*)
(*G = 6.67408*10^-11;*)
(*m = mdimorphos/(mdidimos+mdimorphos)*)
(*a=(m/3)^(1/3);*)
(*period = Sqrt[(4*Pi^2)/(G*(mdidimos+mdimorphos))*rorbit^3]/(60*60)*)
(*Body1=Disk[{-m,0}, Rdidimos];*)
(*Body2=Disk[{rorbit-m,0},Rdimorphos];*)


(* ::Input:: *)
(*r1=Sqrt[(x[t]+m)^2+y[t]^2]; r2=Sqrt[(x[t]-1+m)^2+y[t]^2];*)
(*deq1=x''[t]-2 y'[t]-x[t]==-(1-m)(x[t]+m)/r1^3-m*(x[t]-1+m)/r2^3;*)
(*deq2=y''[t]+2x'[t]-y[t]==-y[t]((1-m)/r1^3+m/r2^3);*)
(*ivp={deq1,deq2,x[0]==x0, y[0]==y0,x'[0]==vx0, y'[0]==vy0}*)
(*tmax=100;*)
(*h=-1.4953998*)
(*x0=0.4907997169; *)
(*y0=0.8745; *)
(*vx0=0; *)
(*R1=r1/.{x[t]->x0,y[t]->y0};*)
(*R2=r2/.{x[t]->x0,y[t]->y0};*)
(*vy02=2*(h+(1-m)/R1+m/R2+1/2 (x0^2+y0^2))-vx0^2*)
(*If[vy02>0, vy0=Sqrt[vy02]; Print["Vy0=",vy0], "ERROR in Initial Conditions"]*)
(*Body3start=ListPlot[{{x0*rorbit,y0*rorbit}},PlotStyle->{Red,PointSize[0.01]}];*)


(* ::Input:: *)
(*sol=NDSolve[ivp,{x,y},{t,0,tmax}, MaxSteps->100000];*)
(*xx=x[t]/.sol[[1]]*)
(*yy=y[t]/.sol[[1]]*)
(*Body3end=ListPlot[{{(xx/.t->tmax)*rorbit,(yy/.t->tmax)*rorbit}},PlotStyle->{Gray,PointSize[0.01]}];*)


(* ::Input:: *)
(*orbit=ParametricPlot[{xx*rorbit,yy*rorbit},{t,0,tmax}]*)
(*Show[{orbit,Graphics[{Blue,Body1}], Graphics[{Red, Body2}],Body3start, Body3end}, PlotRange->All, AxesOrigin->Automatic,AxesLabel->{"x [meters]","y [meters]"}]*)


(* ::Input:: *)
(*distance1 = Sqrt[(xx+m)^2+yy^2]*rorbit*)
(*distance2 = Sqrt [(xx-1+m)^2+yy^2]*rorbit*)


(* ::Input:: *)
(*time[x_]:=x*period/(2*Pi);*)
(*Plot[{distance1, distance2}, {t,0,tmax},Ticks->{Table[{i,i*period/(2*Pi)},{i,0,100,20}],Automatic},PlotLegends->{"r1(t)","r2(t)"}, AxesLabel->{"Time [hours]","Distance [meters]"}]*)
(**)
