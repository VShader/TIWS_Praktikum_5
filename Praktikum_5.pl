% Autor:
% Datum: 12.12.2013

%Aufgabe 1

%Sei M ein NEA M=(z, sigma, d, startZ, endZ)
%Z={z0, z1, zEnd}
sigma(a).
sigma(b).

z(z0).
z(z1).
z(zEnd).

startZ(z0).
endZ(zEnd).

d(z0, a, z1).
d(z0, b, z1).
d(z1, a, zEnd).
d(z1, b, zEnd).
d(zEnd, a, z1).
d(zEnd, b, z1).


dStern(Z,[],Z).
dStern(Z,[A|Ws],Zout) :- sigma_stern([A|Ws]), z(Z), d(Z,A,Zh), dStern(Zh,Ws,Zout).

nea(Ws) :- startZ(START), endZ(END), dStern(START,Ws,END).


%Aufgabe 2:

%Sei MP ein PDA mit MP=(Z, sigma, gamma, delta, startZ, groundSym)
%Und gamma sigma vereinigt groundSym.
gamma(W) :- sigma(W).
gamma(W) :- groundSym(W).

groundSym(s).

delta(z0, [a], [a], z0, []).
delta(z0, [nix], [s], z0, []).
delta(z0, [b], [b], z0, []).
delta(z0, [nix], [s], z0, [a,s,b]).

m(Z,[],[]).
%m(Z,_,[]).
m(Z, Ss, [GA|GWs]) :- delta(Z,[nix],[GA],HZ,HGAs), append(HGAs,GWs,HGWs), m(HZ,Ss,HGWs).
m(Z, [SA|SWs], [GA|GWs]) :- delta(Z,[SA],[GA],HZ,HGAs), append(HGAs,GWs,HGWs), m(HZ,SWs,HGWs).

pda(W) :- startZ(Z), groundSym(GS), m(Z, W, [GS]).

sigma_stern([]).
sigma_stern([X|Ys]) :- sigma(X), sigma_stern(Ys).