---
name: amazon-tracker
description: Track Amazon package deliveries by reading shipping emails from Gmail and querying carrier tracking APIs
homepage: https://github.com/your-repo/felix
user-invocable: true
disable-model-invocation: false
---

# Amazon Package Tracker

Track your Amazon deliveries by searching your Gmail for shipping notification emails and checking live carrier status.

## How It Works

1. Search Gmail for Amazon shipping/tracking emails
2. Extract tracking numbers and carrier information from email content
3. Query carrier tracking APIs for real-time delivery status
4. Present a clean summary of all active deliveries

## Workflow

### Step 1: Find Amazon Shipping Emails

Use the gogcli Gmail tool to search for recent Amazon shipping emails:

```bash
gog gmail messages list --query "from:(ship-confirm@amazon.com OR auto-confirm@amazon.com OR shipment-tracking@amazon.com) newer_than:30d" --format json
```

### Step 2: Extract Tracking Info

From each shipping email, extract:
- **Item name(s)**: Found in the email subject or body
- **Tracking number**: Usually in a link like `https://www.amazon.com/gp/css/shipment-tracking/`
- **Carrier**: UPS, USPS, FedEx, Amazon Logistics, OnTrac, etc.
- **Order date**: From the email date

Common carrier tracking URL patterns in Amazon emails:
- UPS: Contains `ups.com` or carrier listed as "UPS"
- USPS: Contains `usps.com` or carrier listed as "USPS"
- FedEx: Contains `fedex.com` or carrier listed as "FedEx"
- Amazon Logistics: Contains `amazon.com/progress-tracker`

### Step 3: Check Carrier Status

Use the browser tool to check tracking status on carrier websites:
- **UPS**: Navigate to `https://www.ups.com/track?tracknum={TRACKING_NUMBER}`
- **USPS**: Navigate to `https://tools.usps.com/go/TrackConfirmAction?tLabels={TRACKING_NUMBER}`
- **FedEx**: Navigate to `https://www.fedex.com/fedextrack/?trknbr={TRACKING_NUMBER}`
- **Amazon Logistics**: Navigate to `https://track.amazon.com/tracking/{TRACKING_NUMBER}`

Alternatively, if `TRACKING_API_KEY` is set, use the 17track API:
```bash
curl -X POST "https://api.17track.net/track/v2.2/register" \
  -H "17token: $TRACKING_API_KEY" \
  -H "Content-Type: application/json" \
  -d '[{"number": "{TRACKING_NUMBER}", "carrier": 0}]'
```

### Step 4: Present Results

Format the response as:

```
📦 Your Amazon Packages:

1. **{Item Name}**
   Carrier: {Carrier} | Tracking: {Number}
   Status: {Current Status}
   ETA: {Estimated Delivery Date}

2. **{Item Name}**
   ...
```

If no active shipments are found, say: "No active Amazon shipments found in the last 30 days."

## Commands

- **"Check my packages"** / **"Where are my Amazon orders?"** — List all active deliveries
- **"Track {tracking number}"** — Look up a specific tracking number
- **"Any deliveries today?"** — Filter for packages arriving today

## Notes

- Only searches the last 30 days of emails by default
- Amazon Logistics packages may have limited tracking detail compared to UPS/FedEx/USPS
- If a tracking number isn't found in emails, ask the user to provide it manually
