% RANKCOR    Rangkorrelation nach Spearman
%
%    [p,rankx,ranky] = rankcor(x,y) berechnet den Rangkorrelationskoeffizienten p
%    der Vektoren x und y nach Spearman.
%    rankx,ranky sind die Rangzahlvektoren. 

function [p, rankx,ranky] = rankcor(x,y);


if nargin ~= 2,
	error('falsche Zahl an Eingabeargumenten!');
end
len = length(x);
if length(y) ~= len,
    error('Eingabevektoren haben ungleiche Längen!');
end

% Elemente nach aufsteigender Größe sortieren 
[xs,xIndex] = sort(x);
[ys,yIndex] = sort(y);

for n=1:len,
	rankx(xIndex(n)) = n;
	ranky(yIndex(n)) = n;
end

% Rangkorrelationskoeffizienten berechnen
c = corrcoef(rankx,ranky);
p = c(1,2);

% Alternative Brechnung des Rangkorrelationskoeffizienten
% rd = rankx(:)-ranky(:);
% p = 1 - 6/(n^3-n) * (rd'*rd); 	% Spearman-Formel

% Rainer Huber (rainer.huber@uni-oldenburg.de)
