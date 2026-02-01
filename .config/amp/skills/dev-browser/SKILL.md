---
name: dev-browser
description: "Navigate and interact with the local dev server for UI verification. Use when a story requires browser verification of UI changes. Triggers on: verify in browser, check the UI, test in browser, browser verification."
user-invocable: true
---

# Dev Browser Skill

Navigate, interact with, and verify UI changes on the local development server.

---

## Prerequisites

### 1. Install Chromium (Required for Playwright)

Chromium is configured globally via `~/.config/amp/settings.json`.

**Ubuntu/Debian/Pop!_OS:**
```bash
sudo apt install chromium-browser
```

**Via Snap:**
```bash
sudo snap install chromium
```

**macOS:**
```bash
brew install --cask chromium
```

**Verify installation:**
```bash
chromium-browser --version   # Linux
chromium --version           # macOS
```

Playwright MCP is configured globally in `~/.config/amp/settings.json` to use `/usr/bin/chromium-browser` with `--isolated` mode.

### 2. Dev server must be running

```bash
bun run dev
```
Default URL: http://localhost:3000

### 3. Browser automation tools available

Playwright MCP configured via `~/.config/amp/settings.json`

---

## Common Actions

### Navigate to a Page

```
Navigate to http://localhost:3000/dashboard
```

### Take a Snapshot (Accessibility Tree)

Better than screenshots for verification - shows actual DOM structure:

```
Take a browser snapshot of the current page
```

### Click Elements

```
Click the "Submit" button
Click the link with text "Settings"
```

### Fill Forms

```
Type "test@example.com" in the email field
Fill the form: email="test@example.com", password="secret123"
```

### Take Screenshot

For visual evidence in progress logs:

```
Take a screenshot and save as "dashboard-verified.png"
```

---

## Verification Checklist

For UI stories, verify:

- [ ] Page loads without errors (check console messages)
- [ ] Expected elements are visible
- [ ] Forms submit correctly
- [ ] Navigation links work
- [ ] Data displays correctly
- [ ] Error states show appropriate messages
- [ ] Success states show confirmation

---

## WarrantyCert-Specific Pages

| Route | Purpose | Key Elements |
|-------|---------|--------------|
| `/` | Landing page | Hero, features, CTA buttons |
| `/login` | Login form | Email, password, submit |
| `/signup` | Registration | Company name, email, password |
| `/dashboard` | Main dashboard | Stats cards, recent certificates |
| `/certificates` | Certificate list | Table, "New" button, filters |
| `/certificates/new` | Create certificate | Form with template select |
| `/certificates/:id` | Certificate detail | Info, PDF download, void button |
| `/templates` | Template list | Table, "New" button |
| `/templates/new` | Create template | Form with terms, exclusions |
| `/claims` | Claims list | Table with status filters |
| `/claims/:id` | Claim detail | Approve/deny buttons |
| `/settings` | Company settings | Profile form, logo upload |
| `/verify/:id` | Public verification | Certificate status, claim form |

---

## Example Verification Flow

```markdown
## Verifying Certificate Creation Flow

1. Navigate to http://localhost:3000/login
2. Fill login form with test credentials
3. Click "Log In" button
4. Navigate to http://localhost:3000/certificates/new
5. Verify form has:
   - Template dropdown
   - Product name field
   - Serial number field
   - Customer fields
   - Purchase date picker
6. Fill form with test data
7. Click "Generate Certificate"
8. Verify redirect to certificate detail page
9. Verify certificate info displays correctly
10. Take screenshot for evidence
```

---

## Troubleshooting

### Page not loading
- Check dev server is running: `bun run dev`
- Check correct port (default 3000)
- Check for server errors in terminal

### Element not found
- Take a snapshot to see actual DOM structure
- Check element has correct text/role
- Wait for page to fully load

### Form submission fails
- Check browser console for errors
- Verify all required fields filled
- Check network requests for API errors

---

## Progress Log Entry

After verification, add to `scripts/ralph/progress.txt`:

```markdown
## Browser Verification - [Story ID]
- Navigated to: [URL]
- Verified: [what was checked]
- Screenshot: [filename if taken]
- Issues found: [any problems, or "None"]
```

---

## Tools Reference

Playwright MCP tools:

```
mcp__playwright__browser_navigate - Navigate to URL
mcp__playwright__browser_snapshot - Get page structure
mcp__playwright__browser_click - Click element
mcp__playwright__browser_type - Type text
mcp__playwright__browser_take_screenshot - Capture image
mcp__playwright__browser_console_messages - Check for errors
```
