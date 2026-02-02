---
name: ralph-verify
description: "Comprehensive verification of Ralph's work. Runs tests, checks coverage, validates against prd.json, uses btca for best practices, and oracle for final review. Use after Ralph finishes. Triggers on: verify ralph, ralph review, check ralph's work."
---

# Ralph Verification Skill

Comprehensive, multi-layer verification to ensure Ralph's branch is 100% ready to merge.

---

## The Job

After Ralph completes, perform exhaustive verification:

1. **Automated checks** — typecheck, lint, build, tests
2. **Test coverage audit** — ensure new code is tested, flag gaps
3. **Best practices check** — use btca to verify patterns match latest docs
4. **Browser verification** — test all new routes and UI
5. **Oracle comprehensive review** — validate against prd.json and progress.txt
6. **Fix all issues** — iterate until everything passes

**Goal:** After this skill completes, the branch is 100% ready to merge with zero worry.

---

## Step 1: Gather Context

Read and understand what Ralph built:

1. Read `scripts/ralph/prd.json` — extract:
   - Branch name
   - All user stories and their acceptance criteria
   - Which stories involve routes, UI, backend, database
2. Read `scripts/ralph/progress.txt` — check for:
   - Any stories marked as failed or with issues
   - Notes about problems encountered
3. Get list of files changed: `git diff --name-only main..{branch}`

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

## Step 6: Oracle Comprehensive Review

Ask the oracle for a thorough review with full context:

**Prompt:**
```
Perform a comprehensive review of Ralph's implementation.

## Context
- Branch: {branch-name}
- PRD: [attach scripts/ralph/prd.json]
- Progress: [attach scripts/ralph/progress.txt]
- Changed files: [list from git diff --name-only]

## Review Tasks

1. **PRD Compliance:** For each user story in prd.json:
   - Verify ALL acceptance criteria are actually met
   - Flag any criteria that appear unimplemented or incomplete
   - Check that implementation matches the described behavior

2. **Progress.txt Issues:** Review any notes or issues logged:
   - Are all noted problems resolved?
   - Any workarounds that need proper fixes?

3. **Security Audit:**
   - All user input escaped with escapeHtml()?
   - All user-facing strings using t() for i18n?
   - Rate limiting where needed?
   - No secrets or sensitive data exposed?
   - CSRF protection on forms?
   - Proper authorization checks?

4. **Code Quality:**
   - Follows existing codebase patterns?
   - No dead code, console.logs, or TODOs?
   - Error handling complete?
   - Edge cases covered?

5. **Performance:**
   - No obvious N+1 queries?
   - Images optimized and lazy-loaded?
   - No blocking operations in request handlers?

6. **Missing Pieces:**
   - Anything in the PRD that was skipped?
   - Any implicit requirements not addressed?

Provide a detailed report with specific file:line references for any issues.
```

**Action:** Fix every issue the oracle identifies.

---

## Step 7: Final Verification Loop

After fixing issues from Steps 2-6:

1. Re-run all automated checks:
   ```bash
   bun run typecheck && bun run lint && bun run test
   ```

2. If new tests were written, ensure they pass

3. Quick browser smoke test of critical paths

4. If any step fails, fix and repeat Step 7

---

## Step 8: Generate Final Report

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

### Oracle Review
- [x] All PRD acceptance criteria met
- [x] No security issues
- [x] Code quality approved
- [x] No missing pieces

### Issues Fixed During Verification
1. {issue} → {fix}
2. ...

### Confidence Level: ✅ 100% READY TO MERGE
```

---

## Completion Criteria

The skill is complete when:

- [ ] All automated checks pass (typecheck, lint, build, tests)
- [ ] Test coverage is adequate (no critical gaps)
- [ ] btca confirms patterns are current
- [ ] Browser verification passes for all new features
- [ ] Oracle review passes with no unresolved issues
- [ ] Final report generated with "100% READY TO MERGE"

**Only then:** Tell the user the branch is ready and suggest:
```
Ready to merge. Options:
1. git checkout main && git merge {branch-name}
2. Create PR for team review
3. git push origin {branch-name} for CI
```

---

## If Issues Cannot Be Resolved

If you encounter issues that cannot be fixed:

1. Document them clearly in the report
2. Mark confidence as "BLOCKED" with reason
3. Suggest: manual intervention needed, or handoff to new thread with specific problem statement
