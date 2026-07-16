# SplitEven – Användbara kommandon

En samlad referens över kommandon som är bra att kunna för det här projektet, sorterat efter kategori.

## Maven (backend)

```bash
# Kör applikationen
./mvnw spring-boot:run

# Kör alla tester
./mvnw test

# Rensa bort gamla byggfiler (target/)
./mvnw clean

# Rensa och kör tester i ett svep
./mvnw clean test

# Bygga en körbar .jar-fil
./mvnw package

# Se hela beroendeträdet (bra för att felsöka saknade libs)
./mvnw dependency:tree

# Se bara en specifik dependency, t.ex. postgresql
./mvnw dependency:tree | grep -i postgresql

# Pushar om alla tester är godkända
cd backend && ./mvnw test && cd .. && git push
```

## PostgreSQL / psql

```bash
# Ansluta till databasen interaktivt
psql -h localhost -U minanvandare -d spliteven

# Köra en hel SQL-fil mot databasen
psql -h localhost -U minanvandare -d spliteven -f sql/schema.sql

# Köra ett enstaka kommando utan att gå in i psql-prompten
psql -h localhost -U minanvandare -d spliteven -c "\dt"
```

**Inne i psql-prompten:**
```sql
\dt              -- lista alla tabeller
\d tablename      -- visa en tabells kolumner och typer
\du               -- lista alla databasanvändare/roller
\l                -- lista alla databaser
\q                -- avsluta psql
```

**Kontrollera att PostgreSQL-tjänsten kör:**
```bash
sudo systemctl status postgresql
sudo systemctl start postgresql
sudo systemctl enable postgresql   # starta automatiskt vid omstart av datorn
```

## Git

```bash
# Se status (vilka filer är ändrade/ospårade)
git status

# Lägga till alla ändringar och committa
git add .
git commit -m "Beskrivande commit-meddelande"

# Pusha till GitHub
git push

# Flytta/döpa om en fil (git fattar att det är samma fil, inte ny+borttagen)
git mv gammalt-namn.sql nytt-namn.sql

# Byta remote-URL (t.ex. från https till ssh)
git remote set-url origin git@github.com:Leo-Haker/spliteven.git

# Se vilken remote som är kopplad
git remote -v

# Testa att SSH-anslutningen till GitHub fungerar
ssh -T git@github.com
```

## Node / npm (frontend)

```bash
# Skapa ett nytt React-projekt med Vite
npm create vite@latest frontend -- --template react

# Installera alla dependencies (körs i projektmappen, där package.json finns)
npm install

# Starta utvecklingsservern
npm run dev

# Köra tester
npm test
```

## Linux / bash – allmänt nyttiga

```bash
# Hitta en fil oavsett var den ligger i hemkatalogen
find ~ -iname "filnamn*"

# Hitta i hela filsystemet
find / -iname "filnamn*" 2>/dev/null

# Skapa en mapp (och alla saknade mappar på vägen dit)
mkdir -p sokvag/till/mapp

# Gå till en mapp med mellanslag i namnet
cd ~/"Mapp med mellanslag"
cd ~/Mapp\ med\ mellanslag

# Se vilken version av ett verktyg som är installerat
java -version
node -v
npm -v
git --version
which psql        # visar sökvägen, tomt svar = inte installerat
```

## Bra att komma ihåg

- **`ddl-auto=validate`** i `application.properties` gör att Hibernate *kontrollerar* att databasen matchar entiteterna, men ändrar inget själv – bra när du vill skriva SQL manuellt
- Kör alltid **`./mvnw test`** innan push, för att fånga fel innan de hamnar på GitHub
