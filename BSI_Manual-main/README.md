# BSI Manual — Flutter Replica

This is a Flutter implementation of the "BSI Manual" hybrid app. It mirrors the structure, features, and flow:

- Home (index) with navigation cards
- Calculator (fee computation UI & logic)
- Rates reference (embedded JSON)
- Dashboard & "Lens" (filter, quick totals/insights)
- Local persistence (SharedPreferences)
- Theming and branding (BSI logo)

## Getting Started

```bash
flutter pub get
flutter run
```

## Structure

- `lib/main.dart` — App entry, theming, routes
- `lib/pages/*` — Home, Calculator, Rates, Dashboard, About
- `lib/services/*` — Rate loading, calculator rules, local DB
- `lib/widgets/*` — Reusable UI elements
- `assets/images/bsi-logo.png` — App logo
- `assets/data/rates.json` — Example rate data (replace/expand for production)

You can import actual BSI rates by replacing `assets/data/rates.json` or wiring a backend.
