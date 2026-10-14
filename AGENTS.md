# Storee Project Rules & Guidelines

- **Architecture:** Clean Architecture (`core/`, `features/`, `app/`).
- **State Management:** BLoC for event-driven workflows (e.g. `OrderBloc`), Cubit for simpler CRUD / view models (e.g. `CustomerCubit`, `WalletCubit`, `HomeCubit`).
- **Money & Currencies:**
  - NEVER use `double` for money! Always use `Money` value object with minor unit integers (`amountMinor`).
  - Supported currencies: `YER` (0 decimals), `SAR` (2 decimals), `USD` (2 decimals).
  - Explicit currency conversion is strictly mandatory. Never sum amounts of different currencies directly.
- **Design System:** Soft Boutique.
  - Colors: Primary Berry Rose (`#A34863`), Secondary Blush Pink (`#F7E8EC`), Canvas Soft Ivory (`#FFF9F4`), Sage Green (`#78927B`), Charcoal (`#343039`), Gold (`#C68B43`).
  - Font: `IBM Plex Sans Arabic`.
  - Direction: RTL by default (`ar_YE` / `ar_SA`).
- **Business Rules:**
  - Customer receipt != instant profit.
  - Internal wallet transfer != income/expense.
  - Owner personal withdrawals are separated from operating expenses.
  - Group purchase extra costs allocated proportionally based on relative base price with minor unit precision.
