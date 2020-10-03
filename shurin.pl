sex(X,m) :- father(X,_).
sex(X,f) :- mother(X,_).

shurin(X,Y) :- sex(X,m), father(Y,A), mother(B,A), father(C,B), father(C,X).
shurin(X,Y) :- sex(X,m), father(Y,A), mother(B,A), mother(C,B), mother(C,X).

father('Christoph Bach','Johann Ambrosius Bach').
father('Christoph Bach','Johann Christoph II Bach').
father('Heinrich Bach','Johann Christoph Bach').
father('Heinrich Bach','Johann Michael Bach').
father('Jacob Bach','Johann Ludwig Bach').
father('Johann Ambrosius Bach','Johann Sebastian Bach').
father('Johann Christoph Altnickol','Johann Sebastian Altnickol').
father('Johann Christoph Bach','Johann Nicolaus Bach').
father('Johann Christoph Friedrich Bach','Anna Philippiana Friederica Bach').
father('Johann Christoph Friedrich Bach','Christina Luise Bach').
father('Johann Christoph Friedrich Bach','Wilhelm Friedrich Ernst Bach').
father('Johann Michael Bach','Maria Barbara Bach').
father('Johann Sebastian Bach','Carl Philipp Emanuel Bach').
father('Johann Sebastian Bach','Elisabeth Juliane Friederica Bach').
father('Johann Sebastian Bach','Gottfried Heinrich Bach').
father('Johann Sebastian Bach','Johann Christian Bach').
father('Johann Sebastian Bach','Johann Christoph Friedrich Bach').
father('Johann Sebastian Bach','Johanna Carolina Bach').
father('Johann Sebastian Bach','Regina Susanna Bach').
father('Johann Sebastian Bach','Wilhelm Friedemann Bach').
father('Johannes Bach','Christoph Bach').
father('Johannes Bach','Heinrich Bach').
father('Philippus Bach','Wendel Bach').
father('Veit Bach','Johannes Bach').
father('Veit Bach','Philippus Bach').
father('Wendel Bach','Jacob Bach').
father('Wilhelm Ernst Colson','Lucia Elisabeth Colson').
father('Wilhelm Friedrich Ernst Bach','Auguste Wilhelmine Bach').
father('Wilhelm Friedrich Ernst Bach','Carolina Augusta Wilhelmine Bach').
father('Wilhelm Friedrich Ernst Bach','Friedrich Wilhelm Ludwig Bach').
father('Wilhelm Friedrich Ernst Bach','Juliane Friederica Bach').
mother('Anna Magdalena Wilcke','Elisabeth Juliane Friederica Bach').
mother('Anna Magdalena Wilcke','Gottfried Heinrich Bach').
mother('Anna Magdalena Wilcke','Johann Christian Bach').
mother('Anna Magdalena Wilcke','Johann Christoph Friedrich Bach').
mother('Anna Magdalena Wilcke','Johanna Carolina Bach').
mother('Anna Magdalena Wilcke','Regina Susanna Bach').
mother('Anna Martha Schneider','Johann Ludwig Bach').
mother('Anna Philippiana Friederica Bach','Lucia Elisabeth Colson').
mother('Charlotte Philippina Elerdt','Carolina Augusta Wilhelmine Bach').
mother('Charlotte Philippina Elerdt','Juliane Friederica Bach').
mother('Elisabeth Juliane Friederica Bach','Johann Sebastian Altnickol').
mother('Lucia Elisabeth Münchhausen','Anna Philippiana Friederica Bach').
mother('Lucia Elisabeth Münchhausen','Christina Luise Bach').
mother('Lucia Elisabeth Münchhausen','Wilhelm Friedrich Ernst Bach').
mother('Maria Barbara Bach','Carl Philipp Emanuel Bach').
mother('Maria Barbara Bach','Wilhelm Friedemann Bach').
mother('Maria Elisabeth Lämmerhirt','Johann Sebastian Bach').
mother('Wilhelmine Susanne Albrecht','Auguste Wilhelmine Bach').
mother('Wilhelmine Susanne Albrecht','Friedrich Wilhelm Ludwig Bach').