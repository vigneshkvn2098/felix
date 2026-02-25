---
name: doordash
description: Search DoorDash restaurants and menus, suggest food orders, and provide ordering links
homepage: https://github.com/your-repo/felix
user-invocable: true
disable-model-invocation: false
---

# DoorDash Food Ordering Assistant

Help the user discover restaurants, browse menus, and place food orders through DoorDash.

## How It Works

Uses OpenClaw's built-in browser tool to interact with DoorDash's website for restaurant discovery and menu browsing. **Never places orders automatically** — always provides a link for the user to complete checkout.

## Workflow

### Step 1: Search for Restaurants

When the user asks about food, use the browser tool to search DoorDash:

1. Navigate to `https://www.doordash.com/search/store/{query}/`
2. Or navigate to `https://www.doordash.com/food-delivery/` and search from there
3. Extract restaurant results: name, rating, delivery time, delivery fee, cuisine type

**If the user's address is stored in USER.md**, include it in the search for accurate delivery estimates.

### Step 2: Browse Menu

When the user picks a restaurant or asks for menu details:

1. Navigate to the restaurant's DoorDash page
2. Extract menu categories and popular items
3. Show: item name, description, price
4. Highlight highly-rated or popular items

### Step 3: Suggest Orders

Based on:
- User's stated preferences (from USER.md or conversation)
- Past orders (stored in memory files)
- Budget constraints if mentioned

Provide 2-3 specific item recommendations with prices.

### Step 4: Provide Ordering Link

Generate a DoorDash deep link for the user to complete the order:

```
https://www.doordash.com/store/{restaurant-slug}/
```

Message format:
```
🍕 Here's what I found:

**{Restaurant Name}** ⭐ {Rating} | {Delivery Time} | ${Fee} delivery

Top picks:
1. {Item 1} — ${Price} — {Short description}
2. {Item 2} — ${Price} — {Short description}
3. {Item 3} — ${Price} — {Short description}

Order here: {DoorDash link}
```

## Commands

- **"I'm hungry"** / **"Find food"** — Search popular restaurants nearby
- **"Find {cuisine} near me"** — Search by cuisine type (pizza, Thai, Mexican, etc.)
- **"Show me the menu for {restaurant}"** — Browse a specific restaurant's menu
- **"What should I order from {restaurant}?"** — Get personalized suggestions
- **"Reorder from last time"** — Check memory for past orders and suggest the same

## Safety

- **NEVER place an order on behalf of the user.** Always provide a link.
- **NEVER store or transmit payment information.**
- **NEVER enter the user's address on DoorDash** — let the user handle checkout.

## Memory

After each food interaction, optionally save to memory:
- Restaurant name and what was ordered
- User feedback ("loved it", "too spicy", etc.)
- This helps improve future recommendations

## Notes

- DoorDash availability varies by location
- Delivery fees and times are estimates and may change at checkout
- If DoorDash is down or blocked, suggest alternatives (Uber Eats, Grubhub)
- Browser automation may need Chromium — ensure it's available in the container
