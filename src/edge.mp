mdp
const double p2 = 0.9;
const double p3_1 = 0.9;
const double p3_2 = 0.9;
const double p4_1 = 1.000;
const double p4_2 = 1.000;
const double p5 = 1.000;
const double p6_1 = 0.9;
const double p6_2 = 0.9;
const double p9_1 = 1.000;
const double p9_2 = 1.000;
const double p8_1 = 1.000;
const double p8_2 = 1.000;
const double p1_0 = 0.9;
const double p10_1 = 1.000;
const double p10_2 = 1.000;
const double p12_1 = 1.000;
const double p12_2 = 1.000;

const double skip_p = 0.5;
const bool service_type_a = true;


global G4a_achievable: bool init true;
global G4b_achievable: bool init true;
global G4a_achieved: bool init false;
global G4b_achieved: bool init false;
global G5_achievable: bool init true;
global G5_achieved: bool init false;
global G9a_achievable: bool init true;
global G9b_achievable: bool init true;
global G9a_achieved: bool init false;
global G9b_achieved: bool init false;
global G10a_achievable: bool init true;
global G10a_achieved: bool init false;
global G10b_achievable: bool init true;
global G10b_achieved: bool init false;
global G8b_achievable: bool init true;
global G8a_achievable: bool init true;
global G8b_achieved: bool init false;
global G8a_achieved: bool init false;
global G12_achieved: bool init false;
global G12_achievable: bool init true;

module GoalController
  G4_pursued : [0..2] init 0; // goal G4 is: 0 - not pursued, 1 - pursued as variant 1,2 - pursued as variant 2
  G5_pursued : [0..1] init 0; // goal G5 is: 0 - not pursued, 1 - pursued
  G9_pursued : [0..2] init 0; // goal G9 is: 0 - not pursued, 1 - pursued as variant 1,2 - pursued as variant 2
  G10_pursued : [0..1] init 0; // goal G10 is: 0 - not pursued, 1 - pursued as variant 1
  G8_pursued : [0..2] init 0; // goal G8 is: 0 - not pursued, 1 - pursued as variant 1,2 - pursued as variant 2
  G12_pursued : [0..1] init 0; // goal G12 is: 0 - not pursued, 1 - pursued as variant 1
  
  n : [0..6] init 0; // goal counter

  // block of commands for the selecting the way in which goal g2 is pursued
  // - If the goal was achieved _or_ is unachievable in any of the potential variants, then don't pursue it
  [G4_skip] t & (n=0) & (G4a_achieved | G4b_achieved | (!G4a_achievable & !G4b_achievable)) -> 1:(G4_pursued'=0)&(n'=1);
  // - We have a choice of pursuing/not pursuing the goal in any of the available variants
  [G4_pursue0] t & (n=0) & !(G4a_achieved | G4b_achieved) & (G4a_achievable | G4b_achievable) -> 1:(G4_pursued'=0)&(n'=1);
  [G4a_pursue] t & (n=0) & !(G4a_achieved | G4b_achieved) & G4a_achievable -> 1:(G4_pursued'=1)&(n'=1);
  [G4b_pursue] t & (n=0) & !(G4a_achieved | G4b_achieved) & G4b_achievable -> 1:(G4_pursued'=2)&(n'=1);
  

  // block of commands for the selecting the way in which goal g2 is pursued
  // - If the goal was achieved _or_ is unachievable in any of the potential variants, then don't pursue it
  [G5_skip] t & (n=1) & (G5_achieved | !G5_achievable) -> 1:(G5_pursued'=0)&(n'=2);
  // - We have a choice of pursuing/not pursuing the goal in any of the available variants
  [G5_pursue0] t & (n=1) & !G5_achieved & G5_achievable -> 1:(G5_pursued'=0)&(n'=2);
  [G5_pursue] t & (n=1) & !G5_achieved & G5_achievable -> 1:(G5_pursued'=1)&(n'=2);
  

  // block of commands for the selecting the way in which goal g2 is pursued
  // - If the goal was achieved _or_ is unachievable in any of the potential variants, then don't pursue it
  [G9_skip] t & (n=2) & (G9a_achieved | G9b_achieved | (!G9a_achievable & !G9b_achievable)) -> 1:(G9_pursued'=0)&(n'=3);
  // - We have a choice of pursuing/not pursuing the goal in any of the available variants
  [G9_pursue0] t & (n=2) & !(G9a_achieved | G9b_achieved) & (G9a_achievable | G9b_achievable) -> 1:(G9_pursued'=0)&(n'=3);
  [G9a_pursue] t & (n=2) & !(G9a_achieved | G9b_achieved) & G9a_achievable -> 1:(G9_pursued'=1)&(n'=3);
  [G9b_pursue] t & (n=2) & !(G9a_achieved | G9b_achieved) & G9b_achievable -> 1:(G9_pursued'=2)&(n'=3);
  

  // block of commands for the selecting the way in which goal g2 is pursued
  // - If the goal was achieved _or_ is unachievable in any of the potential variants, then don't pursue it
  [G10_skip] t & (n=3) & (G10a_achieved | G10b_achieved | (!G10a_achievable & !G10b_achievable)) -> 1:(G10_pursued'=0)&(n'=4);
  // - We have a choice of pursuing/not pursuing the goal in any of the available variants
  [G10_pursue0] t & (n=3) & !(G10a_achieved | G10b_achieved) & (G10a_achievable | G10b_achievable) -> 1:(G10_pursued'=0)&(n'=4);
  [G10a_pursue] t & (n=3) & !(G10a_achieved | G10b_achieved) & G10a_achievable -> 1:(G10_pursued'=1)&(n'=4);
  [G10b_pursue] t & (n=3) & !(G10a_achieved | G10b_achieved) & G10b_achievable -> 1:(G10_pursued'=2)&(n'=4);
  

  // block of commands for the selecting the way in which goal g2 is pursued
  // - If the goal was achieved _or_ is unachievable in any of the potential variants, then don't pursue it
  [G8_skip] t & (n=4) & (G8b_achieved | G8a_achieved | (!G8b_achievable & !G8a_achievable)) -> 1:(G8_pursued'=0)&(n'=5);
  // - We have a choice of pursuing/not pursuing the goal in any of the available variants
  [G8_pursue0] t & (n=4) & !(G8b_achieved | G8a_achieved) & (G8b_achievable | G8a_achievable) -> 1:(G8_pursued'=0)&(n'=5);
  [G8b_pursue] t & (n=4) & !(G8b_achieved | G8a_achieved) & G8b_achievable -> 1:(G8_pursued'=1)&(n'=5);
  [G8a_pursue] t & (n=4) & !(G8b_achieved | G8a_achieved) & G8a_achievable -> 1:(G8_pursued'=2)&(n'=5);
  

  // block of commands for the selecting the way in which goal g2 is pursued
  // - If the goal was achieved _or_ is unachievable in any of the potential variants, then don't pursue it
  [G12_skip] t & (n=5) & (G12_achieved | !G12_achievable) -> 1:(G12_pursued'=0)&(n'=6);
  // - We have a choice of pursuing/not pursuing the goal in any of the available variants
  [G12_pursue0] t & (n=5) & !G12_achieved & G12_achievable -> 1:(G12_pursued'=0)&(n'=6);
  [G12_pursue] t & (n=5) & !G12_achieved & G12_achievable -> 1:(G12_pursued'=1)&(n'=6);
  
  // Controller done
  [controller_done] t & (n=6) -> 1:(n'=0);
endmodule



module ChangeMgmt
  // variables required for each goal g1, g2, ... with its variants 1, 2, 3, ...ble::

  step : [0..8] init 0; 
  fail : bool init false;

  // outcomes of pursuing goal G4
  [] !t & !fail & step=0 & G4_pursued=0 -> 1:(step'=1);
  [] !t & !fail & step=0 & G4_pursued=1 -> p4_1:(G4a_achieved'=true)&(step'=1) + (1-p4_1):(G4a_achievable'=false)&(fail'=true)&(step'=1);
  [] !t & !fail & step=0 & G4_pursued=2 -> p4_2:(G4b_achieved'=true)&(step'=1) + (1-p4_2):(G4b_achievable'=false)&(fail'=true)&(step'=1);

  // outcomes of pursuing goal G5
  [] !t & !fail & step=1 & G5_pursued=0 -> 1:(step'=2);
  [] !t & !fail & step=1 & G5_pursued>0 -> p5:(G5_achieved'=true)&(step'=2) + (1-p5):(G5_achievable'=false)&(fail'=true)&(step'=2);

  // outcomes of pursuing goal G9
  [] !t & !fail & step=2 & G9_pursued=0 -> 1:(step'=3);
  [] !t & !fail & step=2 & G9_pursued=1 -> p9_1:(G9a_achieved'=true)&(step'=3) + (1-p9_1):(G9a_achievable'=false)&(fail'=true)&(step'=3);
  [] !t & !fail & step=2 & G9_pursued=2 -> p9_2:(G9b_achieved'=true)&(step'=3) + (1-p9_2):(G9b_achievable'=false)&(fail'=true)&(step'=3);

  // outcomes of pursuing goal G10
  [] !t & !fail & step=3 & G10_pursued=0 -> 1:(step'=4);
  [] !t & !fail & step=3 & G10_pursued=1 -> p1_0:(G10a_achieved'=true)&(step'=4) + (1-p1_0):(G10a_achievable'=false)&(fail'=true)&(step'=4);
  [] !t & !fail & step=3 & G10_pursued=1 -> p1_0:(G10b_achieved'=true)&(step'=4) + (1-p1_0):(G10b_achievable'=false)&(fail'=true)&(step'=4);

  // outcomes of pursuing goal G8
  [] !t & !fail & step=4 & G8_pursued=0 -> 1:(step'=5);
  [] !t & !fail & step=4 & G8_pursued=1 -> p8_2:(G8b_achieved'=true)&(step'=5) + (1-p8_2):(G8b_achievable'=false)&(fail'=true)&(step'=5);
  [] !t & !fail & step=4 & G8_pursued=2 -> p8_1:(G8a_achieved'=true)&(step'=5) + (1-p8_1):(G8a_achievable'=false)&(fail'=true)&(step'=5);

  // outcomes of pursuing goal G12
  [] !t & !fail & step=5 & G12_pursued=0 -> 1:(step'=6);
  [] !t & !fail & step=5 & G12_pursued=1 -> p1_0:(G12_achieved'=true)&(step'=6) + (1-p1_0):(G12_achievable'=false)&(fail'=true)&(step'=6);

  // Plan failure: inform Turn module and reset counter
  [changeMgmt_done] !t & fail -> 1:(fail'=false) & (step'=0); 

  // done
  [success] !t & !fail & step=6 -> (step'=step+1);
  [end] !t & step=7 -> (step'=7);

  // return to step 0
  //[controller_done] true -> 1:(step'=0);
endmodule

module Retry
  max_tries: int init 3;

  [] !t & fail->  (1 - pow((1-p1_0), max_tries)): (G10a_achieved'=true) + pow((1-p1_0), max_tries): (G10a_achievable'=false);
endmodule

module Skip
  [] !t & fail-> (skip_p*p4_1): (G4a_achieved'=true) + (1-skip_p)*p4_2: (G4b_achieved'=true);
endmodule

module ServiceQuality
  [] !t & fail & service_type_a-> p9_1: (G9a_achieved'=true);
  [] !t & fail & !service_type_a-> p9_2: (G9b_achieved'=true);
endmodule

module Turn
  t : bool init true; // true - controller has the turn, false - goal model updating has the turn

  [controller_done] true -> 1:(t'=false);
  [changeMgmt_done] true -> 1:(t'=true);
endmodule


formula G1_achieved = G2_achieved | G3_achieved;
formula G2_achieved = (G4a_achieved | G4b_achieved) & G5_achieved & G6_achieved;
formula G6_achieved = (G8b_achieved | G8a_achieved) & G7_achieved;
formula G7_achieved = (G9a_achieved | G9b_achieved) & (G10a_achieved | G10b_achieved);
formula G3_achieved = (G12_achieved | G12_achieved); 

rewards "utility"
  [success] G1_achieved: 20;
  [success] G2_achieved: 12;
  [success] G4a_achieved: 5;
  [success] G4b_achieved: 2;
  [success] G5_achieved: 10;
  [success] G6_achieved: 12;
  [success] G7_achieved: 12;
  [success] G9a_achieved: 10;
  [success] G9b_achieved: 5;
  [success] G10a_achieved: 2;
  [success] G10b_achieved: 12;
  [success] G8b_achieved: 2;
  [success] G8a_achieved: 6;
  [success] G3_achieved: 10;
  [success] G12_achieved: 10;
  [success] G12_achieved: 6;
  [success] G12_achieved: 2;
endrewards

rewards "cost"
  [success] G1_achieved: 0;
  [success] G2_achieved: 0;
  [success] G4a_achieved: 12;
  [success] G4b_achieved: 5;
  [success] G5_achieved: 0;
  [success] G6_achieved: 6;
  [success] G7_achieved: 0;
  [success] G9a_achieved: 5;
  [success] G9b_achieved: 12;
  [success] G10a_achieved: 10;
  [success] G10b_achieved: 6;
  [success] G8b_achieved: 6;
  [success] G8a_achieved: 2;
  [success] G3_achieved: 3;
  [success] G12_achieved: 3;
  [success] G12_achieved: 2;
  [success] G12_achieved: 6;
endrewards
