# Silvan App - Schritt-für-Schritt Installationsanleitung

## Übersicht
Diese Anleitung führt dich durch die komplette Installation der Silvan App - von der Datenbank bis zum fertigen Deployment auf deinem Smartphone.

**Geschätzte Dauer:** 20-30 Minuten

---

## Schritt 1: Supabase Datenbank einrichten (5 Min)

### 1.1 Konto erstellen
1. Gehe zu https://supabase.com
2. Klicke auf **Start your project**
3. Registriere dich mit deiner Email oder GitHub

### 1.2 Neues Projekt erstellen
1. Klicke auf **New Project**
2. Wähle eine Organisation (oder erstelle eine neue)
3. Projekt-Einstellungen:
   - **Name:** SilvanApp
   - **Database Password:** Wähle ein sicheres Passwort (speichere es!)
   - **Region:** Europe West (Frankfurt)
4. Klicke auf **Create new project**
5. Warte ca. 2 Minuten bis das Projekt bereit ist

### 1.3 Datenbank-Schema erstellen
1. Gehe im Menü zu **SQL Editor**
2. Öffne die Datei `supabase_migration.sql` aus dem Projekt
3. Kopiere den KOMPLETTEN Inhalt (Strg+A, Strg+C)
4. Füge ihn in den SQL Editor ein (Strg+V)
5. Klicke auf **Run** (grüner Pfeil oben rechts)
6. Du solltest "Success" sehen

### 1.4 API-Credentials notieren
1. Gehe zu **Project Settings** (Zahnrad unten links)
2. Klicke auf **API**
3. Notiere diese beiden Werte:
   - **Project URL** (z.B. https://abc123xyz.supabase.co)
   - **anon public** API Key (langer String)

✅ **Checkpoint:** Du hast jetzt eine funktionsfähige Datenbank mit allen Tabellen und Testdaten!

---

## Schritt 2: Code auf GitHub hochladen (5 Min)

### 2.1 GitHub Repository erstellen
1. Gehe zu https://github.com
2. Melde dich an (oder erstelle ein Konto)
3. Klicke auf das **+** oben rechts → **New repository**
4. Repository-Einstellungen:
   - **Name:** silvan-app
   - **Visibility:** Private (empfohlen)
   - **DO NOT** initialize with README
5. Klicke auf **Create repository**

### 2.2 Code hochladen
Du hast zwei Optionen:

**Option A: Mit GitHub Desktop (einfacher)**
1. Lade dir alle Dateien aus `/mnt/user-data/outputs/silvan-app/` herunter
2. Installiere GitHub Desktop: https://desktop.github.com
3. In GitHub Desktop:
   - File → Add Local Repository
   - Wähle den heruntergeladenen Ordner
   - Commit to main
   - Push to origin

**Option B: Mit Git Kommandozeile**
```bash
# Im silvan-app Ordner
git init
git add .
git commit -m "Initial commit - Silvan App"
git branch -M main
git remote add origin https://github.com/DEIN-USERNAME/silvan-app.git
git push -u origin main
```

✅ **Checkpoint:** Dein Code ist jetzt auf GitHub!

---

## Schritt 3: Auf Vercel deployen (10 Min)

### 3.1 Vercel Konto erstellen
1. Gehe zu https://vercel.com
2. Klicke auf **Sign Up**
3. Wähle **Continue with GitHub** (am einfachsten)
4. Autorisiere Vercel den Zugriff auf deine GitHub Repos

### 3.2 Projekt deployen
1. Klicke auf **Add New...** → **Project**
2. Finde dein `silvan-app` Repository
3. Klicke auf **Import**

### 3.3 Environment Variables konfigurieren
1. Scrolle zu **Environment Variables**
2. Füge hinzu:
   
   **Variable 1:**
   - Key: `NEXT_PUBLIC_SUPABASE_URL`
   - Value: [Deine Project URL aus Schritt 1.4]
   
   **Variable 2:**
   - Key: `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - Value: [Dein anon Key aus Schritt 1.4]

3. Klicke auf **Deploy**

### 3.4 Deployment abwarten
- Das erste Deployment dauert ca. 2-3 Minuten
- Du siehst eine Animation während des Builds
- Wenn fertig, siehst du Konfetti 🎉

### 3.5 Deine App-URL notieren
- Nach dem Deployment siehst du deine URL (z.B. `silvan-app-xyz123.vercel.app`)
- Kopiere diese URL!

✅ **Checkpoint:** Deine App ist jetzt live im Internet!

---

## Schritt 4: App auf Smartphone installieren (5 Min)

### 4.1 App auf dem Handy öffnen
1. Öffne auf deinem Smartphone den Browser (Safari auf iOS, Chrome auf Android)
2. Gehe zu deiner Vercel-URL (z.B. `silvan-app-xyz123.vercel.app`)
3. Die App sollte laden!

### 4.2 Als PWA installieren

**Auf iPhone (iOS):**
1. Tippe auf das **Teilen**-Symbol (Viereck mit Pfeil nach oben)
2. Scrolle runter zu **Zum Home-Bildschirm**
3. Tippe darauf
4. Gib einen Namen ein: "Silvan App"
5. Tippe auf **Hinzufügen**
6. Die App ist jetzt auf deinem Homescreen! 🎉

**Auf Android:**
1. Tippe auf die drei Punkte (⋮) oben rechts
2. Tippe auf **App installieren** oder **Zum Startbildschirm hinzufügen**
3. Bestätige mit **Installieren**
4. Die App ist jetzt auf deinem Homescreen! 🎉

### 4.3 Erste Anmeldung
1. Öffne die App
2. Melde dich an mit einer der Test-Emails:
   - `wirchi@silvanapp.com`
   - `samuel@silvanapp.com`
   - `admin@silvanapp.com` (für Admin-Funktionen)
3. Passwort: Beliebig (wird aktuell nicht validiert)

✅ **Checkpoint:** Du kannst jetzt die App auf deinem Smartphone nutzen!

---

## Schritt 5: GitHub Actions einrichten (Optional, 3 Min)

Damit bei jedem Code-Update automatisch getestet wird:

1. Gehe zu deinem GitHub Repository
2. Klicke auf **Settings**
3. Gehe zu **Secrets and variables** → **Actions**
4. Klicke auf **New repository secret**
5. Füge hinzu:
   - Name: `NEXT_PUBLIC_SUPABASE_URL`
   - Secret: [Deine Supabase URL]
6. Wiederhole für:
   - Name: `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - Secret: [Dein Supabase Key]

Jetzt wird bei jedem `git push` automatisch getestet und gebaut!

---

## Fertig! 🎉

Du hast jetzt:
- ✅ Eine funktionierende Datenbank auf Supabase
- ✅ Code auf GitHub
- ✅ Live-App auf Vercel
- ✅ PWA auf deinem Smartphone
- ✅ Automatisches CI/CD mit GitHub Actions

## Nächste Schritte

### Eigene Daten einfügen
1. Gehe zu Supabase → **Table Editor**
2. Bearbeite die Tabellen:
   - `users`: Füge echte Spieler hinzu
   - `events`: Erstelle echte Events
   - `utensils`: Passe die Utensilien an

### App anpassen
1. Clone das Repository auf deinen Computer
2. Ändere Farben, Texte, etc.
3. Pushe die Änderungen zu GitHub
4. Vercel deployed automatisch!

## Häufige Probleme

**Problem:** App zeigt "Lädt..." aber nichts passiert
- **Lösung:** Überprüfe in den Browser DevTools (F12) die Console auf Fehler
- Stelle sicher, dass die Supabase Environment Variables richtig sind

**Problem:** "Failed to fetch" Fehler
- **Lösung:** Überprüfe deine Supabase URL und API Key
- Stelle sicher, dass Row Level Security (RLS) Policies aktiv sind

**Problem:** Kann mich nicht anmelden
- **Lösung:** Überprüfe, dass deine Email in der `users` Tabelle existiert
- Stelle sicher, dass `is_active = true`

## Support

Bei weiteren Fragen:
- Öffne ein Issue auf GitHub
- Schau in die Supabase Docs: https://supabase.com/docs
- Schau in die Next.js Docs: https://nextjs.org/docs

Viel Erfolg mit der Silvan App! 🚀⚽
