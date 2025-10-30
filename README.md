# Silvan App - Sport Event Management

Eine Progressive Web App für die Verwaltung von Sportveranstaltungen mit Zu-/Absagen, Gästeverwaltung und Utensilienverwaltung.

## Features

- ✅ Event-Management mit Datum, Zeit und Ort
- ✅ Spieler können sich an-/abmelden (Zusage/Absage/Vielleicht)
- ✅ Gäste können mitgebracht werden
- ✅ Utensilien können angeboten werden (Ball, Pumpe, Schlüssel)
- ✅ Kommentare zu Anmeldungen
- ✅ Echtzeit-Statistiken (Total Zusagen, Gäste)
- ✅ Admin-Funktionen für Event- und Spielerverwaltung
- ✅ Progressive Web App (PWA) - installierbar auf Smartphone
- ✅ Responsive Design für Mobile und Desktop

## Tech Stack

- **Frontend:** Next.js 14, React, TypeScript, Tailwind CSS
- **Backend/Database:** Supabase (PostgreSQL)
- **Deployment:** Vercel
- **CI/CD:** GitHub Actions

## Setup-Anleitung

### 1. Supabase-Projekt erstellen

1. Gehe zu [supabase.com](https://supabase.com) und erstelle ein kostenloses Konto
2. Erstelle ein neues Projekt namens "SilvanApp"
3. Warte bis das Projekt fertig erstellt ist

### 2. Datenbank einrichten

1. Gehe in deinem Supabase-Projekt zu **SQL Editor**
2. Öffne die Datei `supabase_migration.sql` aus diesem Repo
3. Kopiere den gesamten Inhalt und füge ihn in den SQL Editor ein
4. Klicke auf **Run** um das Schema zu erstellen

### 3. Supabase Credentials holen

1. Gehe zu **Project Settings** > **API**
2. Kopiere die **Project URL** 
3. Kopiere den **anon/public** API Key

### 4. GitHub Repository erstellen

1. Erstelle ein neues Repository auf GitHub
2. Lade alle Dateien aus diesem Projekt hoch:

```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/DEIN-USERNAME/silvan-app.git
git push -u origin main
```

### 5. Vercel Deployment

1. Gehe zu [vercel.com](https://vercel.com) und melde dich an (am besten mit GitHub)
2. Klicke auf **Add New Project**
3. Importiere dein GitHub Repository
4. Bei **Environment Variables** füge hinzu:
   - `NEXT_PUBLIC_SUPABASE_URL` = Deine Project URL aus Schritt 3
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY` = Dein anon Key aus Schritt 3
5. Klicke auf **Deploy**

### 6. GitHub Secrets einrichten (für CI/CD)

1. Gehe zu deinem GitHub Repository
2. Gehe zu **Settings** > **Secrets and variables** > **Actions**
3. Füge folgende Secrets hinzu:
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`

## Nach dem Deployment

1. Öffne die Vercel URL (z.B. `silvan-app.vercel.app`)
2. Melde dich mit einer der Test-Emails an:
   - `wirchi@silvanapp.com`
   - `samuel@silvanapp.com`
   - `admin@silvanapp.com` (für Admin-Funktionen)
3. Das Passwort wird derzeit nicht validiert (kann beliebig sein)

## App auf Smartphone installieren (PWA)

### iOS (Safari):
1. Öffne die App-URL in Safari
2. Tippe auf das **Teilen**-Symbol
3. Scrolle runter und tippe auf **Zum Home-Bildschirm**
4. Bestätige mit **Hinzufügen**

### Android (Chrome):
1. Öffne die App-URL in Chrome
2. Tippe auf das **Menü** (drei Punkte oben rechts)
3. Tippe auf **App installieren** oder **Zum Startbildschirm hinzufügen**
4. Bestätige mit **Installieren**

## Lokale Entwicklung

```bash
# Dependencies installieren
npm install

# .env.local Datei erstellen
cp .env.example .env.local
# Füge deine Supabase Credentials ein

# Development Server starten
npm run dev
```

Öffne [http://localhost:3000](http://localhost:3000) im Browser.

## Projektstruktur

```
silvan-app/
├── app/                    # Next.js 14 App Router
│   ├── page.tsx           # Hauptseite
│   ├── layout.tsx         # Root Layout
│   └── globals.css        # Globale Styles
├── components/            # React Komponenten
│   ├── Login.tsx          # Login Komponente
│   └── EventManager.tsx   # Haupt-App Komponente
├── lib/                   # Utilities
│   └── supabase.ts        # Supabase Client & Types
├── public/                # Static Assets
│   └── manifest.json      # PWA Manifest
├── .github/
│   └── workflows/
│       └── ci.yml         # GitHub Actions CI/CD
├── supabase_migration.sql # Datenbank Schema
└── package.json
```

## Nächste Schritte / Verbesserungen

- [ ] Richtige Authentifizierung mit Supabase Auth implementieren
- [ ] Admin-Panel für Event-Erstellung
- [ ] Spieler aktivieren/deaktivieren (Admin)
- [ ] Events archivieren
- [ ] Push-Benachrichtigungen
- [ ] Offline-Support
- [ ] Export-Funktion (Excel/PDF)

## Support

Bei Fragen oder Problemen erstelle ein Issue auf GitHub.

## Lizenz

MIT
