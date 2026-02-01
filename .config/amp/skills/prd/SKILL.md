---
name: prd
description: "Generate a Product Requirements Document (PRD) for a new feature. Use when planning a feature, starting a new project, or when asked to create a PRD. Triggers on: create a prd, write prd for, plan this feature, requirements for, spec out."
user-invocable: true
---

# PRD Generator

Create detailed Product Requirements Documents that are clear, actionable, and suitable for implementation.

---

## The Job

1. Receive a feature description from the user
2. Ask 3-5 essential clarifying questions (with lettered options)
3. Generate a structured PRD based on answers
4. Save to `tasks/prd-[feature-name].md`

**Important:** Do NOT start implementing. Just create the PRD.

---

## Step 1: Clarifying Questions

Ask only critical questions where the initial prompt is ambiguous. Focus on:

- **Problem/Goal:** What problem does this solve?
- **Core Functionality:** What are the key actions?
- **Scope/Boundaries:** What should it NOT do?
- **Success Criteria:** How do we know it's done?

### Format Questions Like This:

```
1. What is the primary goal of this feature?
   A. Improve user onboarding experience
   B. Increase user retention
   C. Reduce support burden
   D. Other: [please specify]

2. Who is the target user?
   A. New users only
   B. Existing users only
   C. All users
   D. Admin users only

3. What is the scope?
   A. Minimal viable version
   B. Full-featured implementation
   C. Just the backend/API
   D. Just the UI
```

This lets users respond with "1A, 2C, 3B" for quick iteration.

---

## Step 2: PRD Structure

Generate the PRD with these sections:

### 1. Introduction/Overview

Brief description of the feature and the problem it solves.

### 2. Goals

Specific, measurable objectives (bullet list).

### 3. User Stories

Each story needs:

- **Title:** Short descriptive name
- **Description:** "As a [user], I want [feature] so that [benefit]"
- **Acceptance Criteria:** Verifiable checklist of what "done" means

Each story should be small enough to implement in one focused session.

**Format:**

```markdown
### US-001: [Title]
**Description:** As a [user], I want [feature] so that [benefit].

**Acceptance Criteria:**
- [ ] Specific verifiable criterion
- [ ] Another criterion
- [ ] Typecheck passes (`bun run typecheck`)
- [ ] **[UI stories only]** Verify in browser
```

**Important:**

- Acceptance criteria must be verifiable, not vague. "Works correctly" is bad. "Button shows confirmation dialog before deleting" is good.
- **For any story with UI changes:** Always include browser verification as acceptance criteria.

### 4. Functional Requirements

Numbered list of specific functionalities:

- "FR-1: The system must allow users to..."
- "FR-2: When a user clicks X, the system must..."

Be explicit and unambiguous.

### 5. Non-Goals (Out of Scope)

What this feature will NOT include. Critical for managing scope.

### 6. Design Considerations (Optional)

- UI/UX requirements
- Link to mockups if available
- Relevant existing components to reuse

### 7. Technical Considerations (Optional)

- Known constraints or dependencies
- Integration points with existing systems
- Performance requirements

### 8. Success Metrics

How will success be measured?

- "Reduce time to complete X by 50%"
- "Increase conversion rate by 10%"

### 9. Open Questions

Remaining questions or areas needing clarification.

---

## Writing for Junior Developers

The PRD reader may be a junior developer or AI agent. Therefore:

- Be explicit and unambiguous
- Avoid jargon or explain it
- Provide enough detail to understand purpose and core logic
- Number requirements for easy reference
- Use concrete examples where helpful

---

## Output

- **Format:** Markdown (`.md`)
- **Location:** `tasks/`
- **Filename:** `prd-[feature-name].md` (kebab-case)

---

## Example PRD

```markdown
# PRD: Bulk Certificate Generation

## Introduction

Add ability to generate multiple warranty certificates at once by uploading a CSV file. This helps companies that issue many certificates (e.g., after a sales event) save time.

## Goals

- Allow uploading CSV with certificate data
- Validate all rows before processing
- Generate certificates in batch
- Send emails to all customers

## User Stories

### US-001: Add CSV upload UI to certificates page
**Description:** As a company admin, I want to upload a CSV file so I can bulk issue certificates.

**Acceptance Criteria:**
- [ ] Certificates page has 'Upload CSV' button
- [ ] Button opens file picker filtered to .csv files
- [ ] Selected file name shown after selection
- [ ] Typecheck passes
- [ ] Verify in browser

### US-002: Parse and validate CSV data
**Description:** As a company admin, I want to see validation errors before processing so I can fix issues.

**Acceptance Criteria:**
- [ ] Parse CSV with headers: product_name, serial_number, customer_name, customer_email, purchase_date
- [ ] Show preview table with validation status per row
- [ ] Highlight rows with errors (missing required fields, invalid email, invalid date)
- [ ] Typecheck passes

### US-003: Process valid certificates in batch
**Description:** As a company admin, I want to generate all valid certificates at once.

**Acceptance Criteria:**
- [ ] 'Process' button generates certificates for valid rows only
- [ ] Progress indicator shows current/total
- [ ] Summary shows success/failure counts
- [ ] Typecheck passes
- [ ] Verify in browser

## Functional Requirements

- FR-1: Accept CSV files up to 100 rows
- FR-2: Required columns: product_name, serial_number, customer_name, customer_email, purchase_date
- FR-3: Optional columns: customer_phone, template_id
- FR-4: Default to company's default template if template_id not specified
- FR-5: Skip rows with validation errors, process valid rows

## Non-Goals

- Excel file support (CSV only for MVP)
- Editing data in the preview (must fix in CSV and re-upload)
- Scheduling batch processing for later

## Technical Considerations

- Reuse existing certificate creation logic
- Process in chunks to avoid timeout (10 at a time)
- Store batch job status for progress tracking

## Success Metrics

- Companies can issue 50+ certificates in under 2 minutes
- Error rate < 5% (validation catches issues upfront)

## Open Questions

- Should we limit batch size? (Proposed: 100 max)
- Should failed rows be downloadable as CSV for retry?
```

---

## Checklist

Before saving the PRD:

- [ ] Asked clarifying questions with lettered options
- [ ] Incorporated user's answers
- [ ] User stories are small and specific
- [ ] Functional requirements are numbered and unambiguous
- [ ] Non-goals section defines clear boundaries
- [ ] Saved to `tasks/prd-[feature-name].md`

---

## After PRD Creation

Once PRD is complete:

1. Save to `tasks/prd-[feature-name].md`
2. Use the **ralph skill** to convert to `prd.json`
3. Run Ralph to implement: `bun run ralph:amp`
