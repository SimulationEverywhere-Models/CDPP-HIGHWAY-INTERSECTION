[top]
components : transito
components : genCarril1-ruta9@generator genCarril2-ruta9@generator genCarril3-ruta9@generator
components : genCarril1-ruta8@generator genCarril2-ruta8@generator genCarril3-ruta8@generator

link : out@genCarril1-ruta9 inCarril1-ruta9@transito
link : out@genCarril2-ruta9 inCarril2-ruta9@transito
link : out@genCarril3-ruta9 inCarril3-ruta9@transito

link : out@genCarril1-ruta8 inCarril1-ruta8@transito
link : out@genCarril2-ruta8 inCarril2-ruta8@transito
link : out@genCarril3-ruta8 inCarril3-ruta8@transito

[transito]
type : cell
dim : (8,20)
delay : transport
defaultDelayTime : 100
border : nonwrapped
neighbors :	transito(-2,-1) transito(-2,0)
neighbors : transito(-1,-1) transito(-1,0) transito(-1,1)
neighbors : transito(0,-1) transito(0,0) transito(0,1)
neighbors : transito(1,-1) transito(1,0) transito(1,1)
initialValue : 0
%initialCellsValue : Autopista.val
localtransition : reglas 
initialrow : 0     80 80 80 80 80 80 80 80 80 80 80 80 80 80 80 80 80 80 80 80
initialrow : 1     0 0 0 0 0 0 0 0 0 0 40 40 40 40 40 40 40 40 40 50
initialrow : 2     0 0 0 0 0 0 0 0 0 0 40 40 40 40 40 40 40 40 40 50
initialrow : 3     0 0 0 0 0 0 0 0 0 0 40 40 40 40 40 40 40 40 40 50
initialrow : 4     20 20 20 20 20 20 20 20 20 20 40 40 40 40 40 40 40 40 40 50
initialrow : 5     20 20 20 20 20 20 20 20 24 20 40 40 40 40 40 40 40 40 40 50
initialrow : 6     20 20 20 20 20 20 20 20 22 80 80 80 80 80 80 80 80 80 80 80
initialrow : 7     80 80 80 80 80 80 80 80 80 80 80 80 80 80 80 80 80 80 80 80
in : inCarril1-ruta9 inCarril2-ruta9 inCarril3-ruta9
in : inCarril1-ruta8 inCarril2-ruta8 inCarril3-ruta8
link : inCarril1-ruta9 inCarril1-ruta9@transito(1,0)
link : inCarril2-ruta9 inCarril2-ruta9@transito(2,0)
link : inCarril3-ruta9 inCarril3-ruta9@transito(3,0)
link : inCarril3-ruta8 inCarril3-ruta8@transito(4,0)
link : inCarril2-ruta8 inCarril2-ruta8@transito(5,0)
link : inCarril1-ruta8 inCarril1-ruta8@transito(6,0)

portInTransition : inCarril1-ruta9@transito(1,0) llegaAuto-rule
portInTransition : inCarril2-ruta9@transito(2,0) llegaAuto-rule
portInTransition : inCarril3-ruta9@transito(3,0) llegaAuto-rule
portInTransition : inCarril3-ruta8@transito(4,0) llegaAuto-rule
portInTransition : inCarril2-ruta8@transito(5,0) llegaAuto-rule
portInTransition : inCarril1-ruta8@transito(6,0) llegaAuto-rule

[reglas]
%---------- Las ultimas dos celdas de la ruta 8 se convierten en una unica ------------------------
%las dos estan ocupadas
rule : 21 100 {(0,0)=20 and ( (0,-1)=25 OR (1,-1)=23 )}
rule : 24 100 {(0,0)=25 and (0,1)=20  and ( ((1,0)=22) OR ((1,0)=23   and (remainder(time,3)!=0)) ) }
rule : 22 100 {(0,0)=23 and (-1,1)=20 and ( ((-1,0)=24) OR ((-1,0)=25 and (remainder(time,3)=0)) ) }

%transicion a la anteultima celda del carril 1
rule : 20 100 {(0,0)=21 and not(isUndefined((0,1))) and (0,1)=22 }
rule : 23 100 {(0,0)=22 and not(isUndefined((0,-1))) and (0,-1)=21 }

%transicion a la anteultima celada del carril 2
rule : 20 100 {(0,0)=21 and not(isUndefined((0,1))) and (0,1)=24 }
rule : 25 100 {(0,0)=24 and not(isUndefined((0,-1))) and (0,-1)=21 }

% cruzando por la derecha en el ultimo carril de la R8 ocupado pero el carril 2 no (justo antes de juntarse)
rule : 20 100 {(0,0)=21 and not(isUndefined((0,1))) and not(isUndefined((-1,0))) and not(isUndefined((-1,1))) and (0,1)=23 and (-1,0)=20 and (-1,1)=24}
rule : 25 100 {(0,0)=24 and not(isUndefined((1,-1))) and (1,-1)=21 and not(isUndefined((0,-1))) and (0,-1)=20 and not(isUndefined((1,0))) and (1,0)=23 }

% cruzando por la izquierda en el carril del medio (el que fue compartido)
rule : 24 100 {(0,0)=25 and (0,1)=21 and (-1,0)=20 and (-1,1)=20}
rule : 21 100 {(0,0)=20 and (0,-1)=20 and (1,-1)=25 and (1,0)=21}

% cruzando por la izquierda cuando esta en el carril 2
rule : 20 100 {(0,0)=21 and (0,1)=25 and (-1,0)=20 and (-1,1)=20}
rule : 21 100 {(0,0)=20 and (0,-1)=20 and (1,-1)=21 and (1,0)=25}

%---------- Movimientos Normales Ruta 9 ------------------------
% Movimiento normal hacia adelante, cruzando por la izquierda y cruzando por la derecha
rule : 0 100 {not(isUndefined((0,1))) and (0,0)=1 and (0,1)=0}
rule : 0 100 {not(isUndefined((0,1))) and not(isUndefined((-1,1))) and not(isUndefined((-1,0))) and (0,0)=1 and (0,1)=1 and (-1,1)=0 and (-1,0)=0}
rule : 0 100 {not(isUndefined((0,1))) and not(isUndefined((1,1))) and not(isUndefined((1,0))) and (0,0)=1 and (0,1)=1 and (1,0)=0 and (1,1)=0 and (  (not(isUndefined((-1,1))) and (-1,1)=1) OR (not(isUndefined((-1,0))) and (-1,0)=1) )} 

rule : 1 100 {not(isUndefined((0,-1))) and (0,0)=0 and (0,-1)=1}
rule : 1 100 {not(isUndefined((1,0))) and not(isUndefined((1,-1))) and not(isUndefined((0,-1))) and (0,0)=0 and (1,0)=1 and (1,-1)=1 and (0,-1)=0}
% el vecino (-2,0) tiene auto, sino no intenta pasar por la derecha. Lo ultimo corresponde a las dos posibles situaciones por las cuales se decediria a pasar por la derecha.
rule : 1 100 {not(isUndefined((-1,0))) and not(isUndefined((-1,-1))) and not(isUndefined((0,-1))) and (0,0)=0 and (-1,0)=1 and (-1,-1)=1 and (0,-1)=0 and ( (not(isUndefined((-2,0))) AND (-2,0)=1) OR (not(isUndefined((-2,-1))) AND (-2,-1)=1) )}

% cruzando por la derecha cuando estamos en el primer carril
rule : 0 100 {isUndefined((-1,0)) and not(isUndefined((0,1))) and (0,1)=1 and not(isUndefined((1,1))) and (1,1)=0 and not(isUndefined((1,0))) and (1,0)=0 and (0,0)=1}
rule : 1 100 {isUndefined((-2,0)) and not(isUndefined((0,-1))) and (0,-1)=0 and not(isUndefined((-1,-1))) and (-1,-1)=1 and not(isUndefined((-1,0))) and (-1,0)=1 and (0,0)=0}

%---------- Movimientos Normales Ruta 8 ------------------------
% Movimientos hacia adelante, cruzando por la izquierdo y cruzando por la derecha
rule : 20 100 {not(isUndefined((0,1))) and (0,0)=21 and (0,1)=20}
rule : 20 100 {not(isUndefined((0,1))) and not(isUndefined((-1,1))) and not(isUndefined((-1,0))) and (0,0)=21 and (0,1)=21 and (-1,1)=20 and (-1,0)=20}
rule : 20 100 {not(isUndefined((0,1))) and not(isUndefined((1,1))) and not(isUndefined((1,0))) and (0,0)=21 and (0,1)=21 and (1,0)=20 and (1,1)=20 and (  (not(isUndefined((-1,1))) and (-1,1)=21) OR (not(isUndefined((-1,0))) and (-1,0)=21) )} 

rule : 21 100 {not(isUndefined((0,-1))) and (0,0)=20 and (0,-1)=21}
rule : 21 100 {not(isUndefined((1,0))) and not(isUndefined((1,-1))) and not(isUndefined((0,-1))) and (0,0)=20 and (1,0)=21 and (1,-1)=21 and (0,-1)=20}
rule : 21 100 {not(isUndefined((-1,0))) and not(isUndefined((-1,-1))) and not(isUndefined((0,-1))) and (0,0)=20 and (-1,0)=21 and (-1,-1)=21 and (0,-1)=20 and ( (not(isUndefined((-2,0))) AND (-2,0)=21) OR (not(isUndefined((-2,-1))) AND (-2,-1)=21) )}

rule : 20 100 { ( (-1,0)!=21 and (-1,0)!=20 ) and not(isUndefined((0,1))) and not(isUndefined((1,1))) and not(isUndefined((1,0))) and (0,0)=21 and (0,1)=21 and (1,1)=20 and (1,0)=20}
rule : 21 100 { ( (-2,0)!=21 and (-2,0)!=20 ) and not(isUndefined((0,-1))) and not(isUndefined((-1,-1))) and not(isUndefined((-1,0))) and (0,0)=20 and (0,-1)=20 and (-1,-1)=21 and (-1,0)=21}

%---------- Movimientos Normales Panamericana ------------------------
% Movimiento normal hacia adelante, cruzando por la izquierda y cruzando por la derecha
rule : 40 100 {not(isUndefined((0,1))) and (0,0)=41 and (0,1)=40}
rule : 40 100 {not(isUndefined((0,1))) and not(isUndefined((-1,1))) and not(isUndefined((-1,0))) and (0,0)=41 and (0,1)=41 and (-1,1)=40 and (-1,0)=40}
rule : 40 100 {not(isUndefined((0,1))) and not(isUndefined((1,1))) and not(isUndefined((1,0))) and (0,0)=41 and (0,1)=41 and (1,0)=40 and (1,1)=40 and ( (not(isUndefined((-1,1))) and (-1,1)=41) OR (not(isUndefined((-1,0))) and (-1,0)=41) )} 

rule : 41 100 {not(isUndefined((0,-1))) and (0,0)=40 and (0,-1)=41}
rule : 41 100 {not(isUndefined((1,0))) and not(isUndefined((1,-1))) and not(isUndefined((0,-1))) and (0,0)=40 and (1,0)=41 and (1,-1)=41 and (0,-1)=40}
rule : 41 100 {not(isUndefined((-1,0))) and not(isUndefined((-1,-1))) and not(isUndefined((0,-1))) and (0,0)=40 and (-1,0)=41 and (-1,-1)=41 and (0,-1)=0 and ( (not(isUndefined((-2,0))) AND (-2,0)=41) OR (not(isUndefined((-2,-1))) AND (-2,-1)=41) )}

% cruzamondo por la derecha cuando estamos en el primer carril
rule : 40 100 {isUndefined((-1,0)) and not(isUndefined((0,1))) and not(isUndefined((1,1))) and not(isUndefined((1,0))) and (0,0)=41 and (0,1)=41 and (1,1)=40 and (1,0)=40}
rule : 41 100 {isUndefined((-2,0)) and not(isUndefined((0,-1))) and not(isUndefined((-1,-1))) and not(isUndefined((-1,0))) and (0,0)=40 and (0,-1)=40 and (-1,-1)=41 and (-1,0)=41}

%---------- Union Rurta 9 con Panamericana ------------------------
rule : 0 100 {not(isUndefined((0,1))) and (0,0)=1 and (0,1)=40}
rule : 0 100 {not(isUndefined((0,1))) and not(isUndefined((-1,1))) and not(isUndefined((-1,0))) and (0,0)=1 and (0,1)=41 and (-1,1)=40 and (-1,0)=0}
rule : 0 100 {not(isUndefined((0,1))) and not(isUndefined((1,1))) and not(isUndefined((1,0))) and (0,0)=1 and (0,1)=41 and (1,0)=0 and (1,1)=40 and ( (not(isUndefined((-1,1))) and (-1,1)=41) OR (not(isUndefined((-1,0))) and (-1,0)=1) )} 

rule : 41 100 {not(isUndefined((0,-1))) and (0,0)=40 and (0,-1)=1}
rule : 41 100 {not(isUndefined((1,0))) and not(isUndefined((1,-1))) and not(isUndefined((0,-1))) and (0,0)=40 and (1,0)=41 and (1,-1)=1 and (0,-1)=0}
rule : 41 100 {not(isUndefined((-1,0))) and not(isUndefined((-1,-1))) and not(isUndefined((0,-1))) and (0,0)=40 and (-1,0)=41 and (-1,-1)=1 and (0,-1)=0 and ( (not(isUndefined((-2,0))) AND (-2,0)=41) OR (not(isUndefined((-2,-1))) AND (-2,-1)=1) )}

rule : 0 100 {isUndefined((-1,0)) and not(isUndefined((0,1))) and not(isUndefined((1,1))) and not(isUndefined((1,0))) and (0,0)=1 and (0,1)=41 and (1,1)=40 and (1,0)=0}
rule : 41 100 {isUndefined((-2,0)) and not(isUndefined((0,-1))) and not(isUndefined((-1,-1))) and not(isUndefined((-1,0))) and (0,0)=40 and (0,-1)=0 and (-1,-1)=1 and (-1,0)=41}

%---------- Union Rurta 8 con Panamericana ------------------------
rule : 20 100 {not(isUndefined((0,1))) and (0,0)=21 and (0,1)=40}
rule : 20 100 {not(isUndefined((0,1))) and not(isUndefined((-1,1))) and not(isUndefined((-1,0))) and (0,0)=21 and (0,1)=41 and (-1,1)=40 and (-1,0)=20}
rule : 20 100 {not(isUndefined((0,1))) and not(isUndefined((1,1))) and not(isUndefined((1,0))) and (0,0)=21 and (0,1)=41 and (1,0)=20 and (1,1)=40 and ( (not(isUndefined((-1,1))) and (-1,1)=41) OR (not(isUndefined((-1,0))) and (-1,0)=21) )} 

rule : 41 100 {not(isUndefined((0,-1))) and (0,0)=40 and (0,-1)=21}
rule : 41 100 {not(isUndefined((1,0))) and not(isUndefined((1,-1))) and not(isUndefined((0,-1))) and (0,0)=40 and (1,0)=41 and (1,-1)=21 and (0,-1)=20}
rule : 41 100 {not(isUndefined((-1,0))) and not(isUndefined((-1,-1))) and not(isUndefined((0,-1))) and (0,0)=40 and (-1,0)=41 and (-1,-1)=21 and (0,-1)=20 and ( (not(isUndefined((-2,0))) AND (-2,0)=41) OR (not(isUndefined((-2,-1))) AND (-2,-1)=21) )}

rule : 20 100 { ( (-1,0)!=21 and (-1,0)!=20 ) and not(isUndefined((0,1))) and not(isUndefined((1,1))) and not(isUndefined((1,0))) and (0,0)=21 and (0,1)=41 and (1,1)=40 and (1,0)=20}
rule : 41 100 { ( (-2,-1)!=21 and (-2,-1)!=20 ) and not(isUndefined((0,-1))) and not(isUndefined((-1,-1))) and not(isUndefined((-1,0))) and (0,0)=40 and (0,-1)=20 and (-1,-1)=21 and (-1,0)=41}

%--------Movimientos en la ultima columna de la panamericana--------------
%Hago que salga el auto de la ultima columna
rule : 50 100 {(0,0)=51}

rule : 40 100 {not(isUndefined((0,1))) and (0,0)=41 and (0,1)=50}
rule : 40 100 {not(isUndefined((0,1))) and not(isUndefined((-1,1))) and not(isUndefined((-1,0))) and (0,0)=41 and (0,1)=51 and (-1,1)=50 and (-1,0)=40}
rule : 40 100 {not(isUndefined((0,1))) and not(isUndefined((1,1))) and not(isUndefined((1,0))) and (0,0)=41 and (0,1)=51 and (1,0)=40 and (1,1)=50 and ( (not(isUndefined((-1,1))) and (-1,1)=51) OR (not(isUndefined((-1,0))) and (-1,0)=41) )} 

rule : 51 100 {not(isUndefined((0,-1))) and (0,0)=50 and (0,-1)=41}
rule : 51 100 {not(isUndefined((1,0))) and not(isUndefined((1,-1))) and not(isUndefined((0,-1))) and (0,0)=50 and (1,0)=51 and (1,-1)=41 and (0,-1)=40}
rule : 51 100 {not(isUndefined((-1,0))) and not(isUndefined((-1,-1))) and not(isUndefined((0,-1))) and (0,0)=50 and (-1,0)=51 and (-1,-1)=41 and (0,-1)=40 and ( (not(isUndefined((-2,0))) AND (-2,0)=51) OR (not(isUndefined((-2,-1))) AND (-2,-1)=41) )}

% Default
rule : {(0,0)} 100  { t }

[llegaAuto-rule]
%llega un nuevo auto. (0,0)=0 en ruta 9 e =20 en ruta8 => 1 y 21 son ocupados en cada una
rule : {(0,0)+1} 100 {portvalue(ThisPort)> 0 and ( (0,0)=0 or (0,0)=20 )}
rule : {(0,0)} 100 {t}


%----------Generador de autos para las rutas 8 y 9 -----------
[genCarril1-ruta9]
distribution : constant
value : 0.1
initial : 1
increment : 0

[genCarril2-ruta9]
distribution : poisson
mean : 2
initial : 1
increment : 1

[genCarril3-ruta9]
distribution : constant
value : 0.3
initial : 1
increment : 1

[genCarril1-ruta8]
distribution : constant
value : 0.2
initial : 1
increment : 0

[genCarril2-ruta8]
distribution : constant
value : 0.2
initial : -2
increment : 1

[genCarril3-ruta8]
distribution : poisson
mean : 2
initial : 1
increment : 1
