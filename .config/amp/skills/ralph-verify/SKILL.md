---
name: ralph-verify
description: "Comprehensive verification of Ralph's work. Runs tests, checks coverage, validates against prd.json, uses btca for best practices, and oracle for final review. Use after Ralph finishes. Triggers on: verify ralph, ralph review, check ralph's work."
---

# Ralph Verification Skill

Comprehensive, multi-layer verification to ensure Ralph's branch is 100% ready to merge.

---

## PRD Location

**Always use this exact path:** `scripts/ralph/prd.json`

---

## The Job

After Ralph completes, perform exhaustive verification:

1. **Automated checks** — typecheck, lint, build, tests
2. **Test coverage audit** — ensure new code is tested, flag gaps
3. **Best practices check** — use btca to verify patterns match latest docs
4. **Browser verification** — test all new routes and UI
5. **Oracle comprehensive review** — validate against prd.json
6. **Learnings preservation check** — verify patterns saved to AGENTS.md
7. **Reset failed stories** — edit prd.json to mark stories for retry
8. **Re-run ralph** — user runs `bun run ralph` to fix issues

**Goal:** After this skill completes, the branch is 100% ready to merge with zero worry.

---

## Step 1: Gather Context

Read and understand what Ralph built:

1. Read `scripts/ralph/prd.json` — extract:
   - Branch name
   - All user stories and their acceptance criteria
   - `run.learnings[]` — patterns discovered
   - Which stories involve routes, UI, backend, database
2. Check `lastResult` for each story — any with incomplete summaries?
3. Get list of files changed: `git diff --name-only main..HEAD`

---

## Step 2: Automated Checks (All Must Pass)

Run all standard checks:

```bash
bun run typecheck    # Type safety
bun run lint         # Code style
bun run build        # Production build works
bun run test         # All tests pass
```

**If any fail:** Fix issues before proceeding. Do not skip.

---

## Step 3: Test Coverage Audit

For each file changed in the branch:

1. **Check if test file exists:**
   - `src/modules/foo/bar.ts` → should have `tests/modules/foo/bar.test.ts`
   - `src/templates/pages/X.ts` → UI tests in `tests/e2e/` or template tests

2. **For new service functions:** Verify unit tests exist covering:
   - Happy path
   - Error cases
   - Edge cases (empty input, limits, etc.)

3. **For new routes:** Verify e2e tests exist covering:
   - Route responds correctly
   - Form submissions work
   - Error states handled

4. **For existing code touched:** Check if existing tests still cover the changes

5. **Flag gaps:** List any code without adequate test coverage

**Action:** Write missing tests for critical paths. At minimum:
- All service functions must have unit tests
- All new routes must have basic e2e smoke tests

---

## Step 4: Best Practices Check with btca

For new code, verify patterns match latest dependency documentation:

```bash
# Check patterns against current library versions
btca ask -r bun -r zod -q "Review this pattern for current best practices: [paste code snippet]"
```

**Check these specifically:**

1. **Zod schemas:** Are validation patterns current?
2. **Bun APIs:** Are we using recommended patterns?
3. **Database queries:** Following SQLite/Bun best practices?
4. **Template patterns:** HTML generation following security best practices?

**For any outdated patterns:** Update to match current recommendations.

---

## Step 5: Browser Verification

Load the `dev-browser` skill:

1. Start dev server: `bun run dev`
2. For each new route from prd.json:
   - Navigate and verify page loads
   - Test all interactive elements
   - Submit forms, check responses
   - Verify error states
3. For UI changes:
   - Check desktop layout
   - Check mobile layout (resize to 375px width)
   - Verify accessibility (focus states, contrast)
4. For user flows spanning multiple pages:
   - Test complete journey end-to-end

**Screenshot and document any issues.**

---

## Step 6: Learnings Preservation Check

Verify that important discoveries from this run are saved:

1. **Check `prd.json → run.learnings[]`:**
   - Are patterns discovered during this run documented?
   - If empty but stories were complex, something may be missing

2. **Check relevant AGENTS.md files:**
   - Did any stories involve patterns that should be permanent?
   - Cross-reference `run.learnings[]` with module AGENTS.md files
   - If a pattern in `run.learnings[]` is general, ensure it's in AGENTS.md

3. **Ask oracle to review:**
   - Are there patterns in the code changes that should be documented?
   - Is any AGENTS.md file missing context that would help future agents?

**Action:** If important patterns are missing from AGENTS.md, add them before marking complete.

---

## Step 7: Oracle Comprehensive Review

Ask the oracle for a thorough review with full context:

**Prompt:**
```
Perform a comprehensive review of Ralph's implementation.

## Context
- Branch: {branch-name}
- PRD: [attach scripts/ralph/prd.json]
- Changed files: [list from git diff --name-only]

## Review Tasks

1. **PRD Compliance:** For each user story in prd.json:
   - Verify ALL acceptance criteria are actually met
   - Flag any criteria that appear unimplemented or incomplete
   - Check that implementation matches the described behavior

2. **Security Audit:**
   - All user input escaped with escapeHtml()?
   - All user-facing strings using t() for i18n?
   - Rate limiting where needed?
   - No secrets or sensitive data exposed?
   - CSRF protection on forms?
   - Proper authorization checks?

3. **Code Quality:**
   - Follows existing codebase patterns?
   - No dead code, console.logs, or TODOs?
   - Error handling complete?
   - Edge cases covered?

4. **Performance:**
   - No obvious N+1 queries?
   - Images optimized and lazy-loaded?
   - No blocking operations in request handlers?

5. **Missing Pieces:**
   - Anything in the PRD that was skipped?
   - Any implicit requirements not addressed?

Provide a detailed report with specific file:line references for any issues.
```

**Action:** Fix every issue the oracle identifies.

---

## Step 8: Final Verification Loop

After fixing issues from Steps 2-7:

1. Re-run all automated checks:
   ```bash
   bun run typecheck && bun run lint && bun run test
   ```

2. If new tests were written, ensure they pass

3. Quick browser smoke test of critical paths

4. If any step fails, fix and repeat Step 8

---

## Step 9: Reset Failed Stories

When issues are found that require story reimplementation:

1. **Identify affected stories** — which stories have issues that need fixes
2. **For each affected story, update `scripts/ralph/prd.json`:**
   ```json
   {
     "passes": false,
     "retries": <current_retries + 1>,
     "lastResult": null,
     "notes": "<brief description of what needs fixing>"
   }
   ```
3. **Use jq or edit_file** to make the changes atomically
4. **Report to user:**
   ```
   Reset for retry:
   - US-005: Missing test coverage for edge case
   - US-012: Security issue with unescaped input
   
   Run `bun run ralph` to fix these stories.
   ```

**Important:** Only reset stories that genuinely need reimplementation. Minor issues can be fixed directly without resetting.

---

## Step 10: Generate Final Report

Create comprehensive verification report:

```markdown
## Ralph Verification Report

**Branch:** {branch-name}
**PRD:** {prd-description}
**Date:** {date}

### Automated Checks
- [x] Typecheck: PASS
- [x] Lint: PASS
- [x] Build: PASS
- [x] Tests: PASS ({count} tests)

### Test Coverage
- [x] All new services have unit tests
- [x] All new routes have e2e tests
- [x] No critical gaps identified
- Tests added: {list new test files}

### Best Practices (btca)
- [x] Zod patterns current
- [x] Bun APIs current
- [x] No deprecated patterns found

### Browser Verification
- [x] All new routes load correctly
- [x] Forms submit and respond correctly
- [x] Mobile responsive verified
- [x] No visual issues found

### Learnings Preserved
- [x] run.learnings[] populated: {count} patterns
- [x] AGENTS.md files updated where needed
- [x] No undocumented patterns found

### Oracle Review
- [x] All PRD acceptance criteria met
- [x] No security issues
- [x] Code quality approved
- [x] No missing pieces

### Issues Fixed During Verification
1. {issue} → {fix}
2. ...

### Stories Reset for Retry
- None (or list stories reset in prd.json)

### Confidence Level: ✅ 100% READY TO MERGE
```

---

## Completion Criteria

The skill is complete when **either**:

**A) All checks pass:**
- [ ] All automated checks pass (typecheck, lint, build, tests)
- [ ] Test coverage is adequate (no critical gaps)
- [ ] btca confirms patterns are current
- [ ] Browser verification passes for all new features
- [ ] Learnings preserved (run.learnings populated, AGENTS.md updated)
- [ ] Oracle review passes with no unresolved issues
- [ ] Final report generated with "100% READY TO MERGE"

**Then:** Tell the user the branch is ready:
```
Ready to merge. Options:
1. git checkout main && git merge {branch-name}
2. Create PR for team review
3. git push origin {branch-name} for CI
```

**B) Issues found requiring reimplementation:**
- [ ] Issues documented with specific story IDs
- [ ] Affected stories reset in `scripts/ralph/prd.json` (passes: false, retries++, lastResult: null)
- [ ] Notes field populated with what needs fixing
- [ ] User instructed to run `bun run ralph` to fix

**Then:** Tell the user to re-run Ralph:
```
Stories reset for retry in scripts/ralph/prd.json:
- US-005: Missing input validation
- US-012: Test coverage gap

Run `bun run ralph` to fix these stories, then run ralph-verify again.
```

---

## If Issues Cannot Be Resolved

If you encounter issues that cannot be fixed by Ralph:

1. Document them clearly in the report
2. Mark confidence as "BLOCKED" with reason
3. Do NOT reset the story (manual fix required)
4. Suggest: manual intervention needed, or handoff to new thread with specific problem statement
