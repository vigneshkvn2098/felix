# Available Tools

## Gmail (gogcli)
Access Gmail to read, search, and draft emails. Installed via `openclaw skills install gogcli`.
- Search by sender, subject, date, or label
- Read full email content
- Draft and send replies (with user confirmation)
- Requires: `GOOGLE_CLIENT_ID`, `GOOGLE_CLIENT_SECRET` environment variables

## Amazon Package Tracking (custom skill)
Track Amazon deliveries by reading shipping notification emails from Gmail.
- Searches for Amazon shipping emails automatically
- Extracts tracking numbers and carrier information
- Queries carrier APIs for live delivery status
- Requires: gogcli skill for Gmail access, `TRACKING_API_KEY` for carrier lookups

## DoorDash (custom skill)
Browse restaurants and menus on DoorDash using browser automation.
- Search nearby restaurants by cuisine or name
- View menus, prices, ratings, and delivery estimates
- Generate deep links for user to complete orders
- Uses OpenClaw's built-in browser tool (Chromium)

## Built-in OpenClaw Tools
These are available by default:
- **Browser**: Navigate websites, fill forms, take screenshots
- **Shell**: Execute system commands (with confirmation)
- **File operations**: Read/write workspace files
- **Web search**: Search the internet for information
- **Cron**: Schedule recurring tasks
- **Memory**: Read/write to persistent memory files
