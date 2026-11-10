---
name: FrameIQ
description: Super-flat minimalism with functional glassmorphism for a visual photography coach
colors:
  primary: "#0F172A"
  secondary: "#2563EB"
  tertiary: "#10B981"
  background-light: "#F8FAFC"
  background-dark: "#090D16"
  surface-light: "#FFFFFF"
  surface-dark: "#0F172A"
  border-light: "#E2E8F0"
  border-dark: "rgba(255, 255, 255, 0.12)"
  glass-light: "rgba(255, 255, 255, 0.78)"
  glass-dark: "rgba(15, 23, 42, 0.70)"
  text-primary-light: "#0F172A"
  text-secondary-light: "#64748B"
  text-primary-dark: "#F8FAFC"
  text-secondary-dark: "#94A3B8"
typography:
  display:
    fontFamily: "Inter, -apple-system, Roboto, sans-serif"
    fontSize: "26px"
    fontWeight: 700
    lineHeight: 1.2
    letterSpacing: "-0.6px"
  headline:
    fontFamily: "Inter, -apple-system, Roboto, sans-serif"
    fontSize: "20px"
    fontWeight: 700
    lineHeight: 1.3
    letterSpacing: "-0.4px"
  title:
    fontFamily: "Inter, -apple-system, Roboto, sans-serif"
    fontSize: "16px"
    fontWeight: 600
    lineHeight: 1.4
    letterSpacing: "-0.2px"
  body:
    fontFamily: "Inter, -apple-system, Roboto, sans-serif"
    fontSize: "14px"
    fontWeight: 400
    lineHeight: 1.5
    letterSpacing: "0px"
  label:
    fontFamily: "Inter, -apple-system, Roboto, sans-serif"
    fontSize: "11px"
    fontWeight: 600
    lineHeight: 1.2
    letterSpacing: "0.2px"
rounded:
  xs: "4px"
  sm: "8px"
  md: "12px"
  lg: "14px"
  pill: "9999px"
spacing:
  xs: "4px"
  sm: "8px"
  md: "16px"
  lg: "24px"
  xl: "32px"
components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "#FFFFFF"
    rounded: "{rounded.md}"
    padding: "14px 20px"
  card-flat:
    backgroundColor: "{colors.surface-light}"
    rounded: "{rounded.lg}"
    padding: "12px"
---

# Design System: FrameIQ

## Overview

**Creative North Star: "The Precision Viewfinder"**

FrameIQ fuses super-flat minimalism with purposeful, selective glassmorphism. The aesthetic treats the mobile device as a high-precision optical instrument: content and subjects take absolute precedence, while chrome recedes into crisp, flat geometry and restrained neutrals.

Elevated layers—such as the floating navigation dock, camera viewfinder status pills, and HUD controls—utilize frosted glassmorphism (`BackdropFilter` with 14–16px blur, subtle 70–78% translucent tint, and a 0.8px hairline border). Glass is applied strictly to elevated functional layers, never as wallpaper or ambient background decoration. All standard screen cards, list items, and containers remain super-flat with zero drop shadows, relying on generous whitespace and 0.8px hairline boundaries for contrast and hierarchy.

**Key Characteristics:**
- **Zero Heavy Shadows:** Shadows are completely eliminated in favor of hairline borders (`0.8px`) and tonal clarity.
- **Selective Glassmorphic Depth:** Frosted glass is reserved exclusively for floating HUD elements, navigation bars, and overlays.
- **Restrained Monochromatic Core:** Obsidian Slate (`#0F172A`), Pure White, and Deep Obsidian (`#090D16`) with targeted lens-blue (`#2563EB`) and level-emerald (`#10B981`) accents.
- **Generous Whitespace:** Ample breathing room between sections, clear type scale steps, and uncluttered content grids.

## Colors

The palette is strictly restrained, anchored by deep obsidian slate in light mode and near-black canvas in dark mode, allowing viewfinder photography to lead without visual competition.

### Primary
- **Obsidian Slate** (`#0F172A` in light, `#F8FAFC` in dark): Used for primary headings, high-contrast actions, and brand marks.

### Secondary
- **Camera Lens Blue** (`#2563EB` light / `#3B82F6` dark): Functional accent for active selection, active navigation state, and lens zoom indicators.

### Tertiary
- **Level Emerald** (`#10B981` light / `#34D399` dark): Sensor level indicator state when horizontal/vertical alignment is within tolerance.

### Neutral
- **Canvas Ground:** `#F8FAFC` (Light) / `#090D16` (Dark)
- **Surface:** `#FFFFFF` (Light) / `#0F172A` (Dark)
- **Muted Surface:** `#F1F5F9` (Light) / `#1E293B` (Dark)
- **Hairline Border:** `#E2E8F0` (Light) / `rgba(255, 255, 255, 0.12)` (Dark)
- **Secondary Text:** `#64748B` (Light) / `#94A3B8` (Dark)

### Named Rules
**The Functional Glass Rule.** Glassmorphism and backdrop blur are permitted only on floating, elevated layers that hover over dynamic content (floating navigation bar, camera HUD controls, category chips, modal action sheets). A static card or page background must never be rendered as glass.

**The Zero Shadow Rule.** No cards, headers, or buttons may use drop shadows or blur halos. Depth is articulated solely through 0.8px hairline outlines and tonal contrast.

## Typography

**Primary Font:** Inter / System Sans (-apple-system, Roboto)

**Character:** Technical, crisp, modern, and highly legible across camera viewfinders under direct sunlight and dark environments alike.

### Hierarchy
- **Display** (Bold 700, 26px, -0.6px tracking): Brand splash and hero titles.
- **Headline** (Bold 700, 20px, -0.4px tracking): Top-level screen headers.
- **Title** (Semi-bold 600, 16px, -0.2px tracking): Section headers and primary card titles.
- **Body** (Regular 400, 14px, 0px tracking): Descriptive text and user instructions.
- **Label / Caption** (Medium 500/600, 11px, 0.2px tracking): HUD badges, level indicators, and difficulty chips.

## Layout

- **Generous Margins:** 16px screen padding, 24–28px vertical spacing between content modules.
- **Safe Area Insets:** Full compliance with iOS home indicator/notch and Android display cutouts.
- **Extend Body Architecture:** `extendBody: true` on main scaffolds allows scrolling content to softly blur beneath floating glass navigation capsules.

## Elevation & Depth

- **Level 0 (Canvas):** Flat base background (`#F8FAFC` / `#090D16`).
- **Level 1 (Cards & Lists):** Flat surface with 0.8px hairline border, `elevation: 0`, zero drop shadows.
- **Level 2 (Floating Glass Layers):** `BackdropFilter` (14–16px blur), 70–78% translucent fill, 0.8px translucent border.

## Shapes

- **Base Cards & Containers:** 14px border radius with 0.8px hairline outline.
- **Image Thumbnails:** 10–12px border radius.
- **Floating Controls & Navigation:** Stadium / Pill shape (radius 9999px).
- **HUD Buttons:** Pure geometric circle (`BoxShape.circle`).

## Components

### GlassSurface (`lib/core/widgets/glass_surface.dart`)
A reusable glass widget that provides `BackdropFilter` blur (14–16px), theme-aware translucent background, and a 0.8px hairline border. Offers `.pill()` and `.circle()` constructors for floating HUD widgets.

### GlassFloatingNavBar (`lib/core/widgets/glass_nav_bar.dart`)
Floating pill dock anchored 12px above bottom safe area. Blurs underlying content as user scrolls. Active items feature an animated flat pill container with primary tint.

### Camera HUD Controls (`lib/features/camera/presentation/widgets/camera_controls.dart`)
Floating glass pill for quick zoom/opacity adjustments, circular glass toggles for flash and grid modes, and a double geometric ring shutter button.

### LevelIndicator (`lib/features/camera/presentation/widgets/level_indicator.dart`)
Minimalist center reticle with rotating horizontal horizon wings; transitions from neutral white to vibrant emerald (`#10B981`) upon reaching level balance.

## Do's and Don'ts

### Do:
- **Do** keep cards and containers completely flat with a 0.8px hairline border.
- **Do** restrict glassmorphic effects to floating HUD capsules, pills, and the floating navigation dock.
- **Do** ensure all touch targets meet or exceed 48×48 dp.
- **Do** maintain high typographic contrast (≥ 4.5:1) in both light and dark themes.
- **Do** extend scaffold bodies behind floating glass navigation to allow background blur to function naturally.

### Don't:
- **Don't** add drop shadows, colored glow halos, or skeuomorphic gradients to cards or buttons.
- **Don't** use glassmorphism on main screen backgrounds or nested content cards.
- **Don't** clutter the camera viewfinder with heavy opaque containers or unnecessary decorative chrome.
- **Don't** use rainbow accent colors; adhere strictly to Obsidian Slate, Lens Blue, and Level Emerald.
