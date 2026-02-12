# 🧪 Senior iOS Engineer Assessment

## Overview

This project contains a working Data layer that fetches weather data from a remote API.

Your task is to design and implement a **Domain layer** and integrate it into the app.

The goal is to demonstrate how you approach domain modeling, boundaries, and integration.

⏱ **Time limit: maximum 2 hours**  

---

## Functional Requirements

The app should:

- Fetch weather by **city name**
    - Hardcoded a city (e.g. Konstanz) is enough
- Display:
  - City
  - Temperature
  - Apparent temperature
- Support:
  - Loading state
  - Error state
  - Retry action

The API returns **hourly forecast data**.

---

## Business Rules

1. The API returns arrays of hourly values.  
   You must decide which entry represents the “current” weather.

2. If the apparent temperature differs from the actual temperature:
   - ≥ +3°C → “Feels warmer”
   - ≤ -3°C → “Feels colder”
   - Otherwise → “Feels normal”

3. If the API response does not allow determining valid weather data, treat it as an error.

---

## Expectations

- Model the Domain layer.
- Integrate it into the app.
- Keep the solution minimal but production-minded.
- Unit tests are highly encouraged (focus on meaningful coverage rather than quantity).
- Introduce explicit mapping between Data and Domain models. Define protocols for DataModel and DomainModel, and ensure transformation from API models to Domain models is handled through this mapping abstraction.

You are free to structure the solution as you see fit.

---

## Required: NOTES.md

Please briefly describe:

- Your domain modeling decisions
- Where and how mapping happens
- What you would improve with more time
