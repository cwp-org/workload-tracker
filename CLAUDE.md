# PM Workload Tracker

GitHub repo: Jackalope178/workload-tracker — push all changes directly to this repo using git push. Develop on main branch unless otherwise specified.

Live site: https://jackalope178.github.io/workload-tracker/
Supabase project: fkgmgpfbfoadgjllttjd (config baked into the app)

## Setup

No build step, no package manager, no dependencies to install. The `package.json` exists only to satisfy the Claude Code on the web environment setup script — do not add dependencies to it.

**Environment setup script** (claude.ai/code environment settings): should be empty or `exit 0`. This project needs no setup.

## Architecture

Single-file app: everything lives in `index.html` (~9800 lines of inline HTML, CSS, and vanilla JS). No frameworks, no build step, no package manager.

### External CDN dependencies
- `@supabase/supabase-js@2` — cloud sync
- `xlsx@0.18.5` — Excel import
- Google Fonts (Inter, Syne)

### Storage
- **localStorage** with `wt_` prefix for all keys
- **Supabase** `user_data` table (key-value store syncing serialized JSON blobs)
- `load(key, fallback)` / `save(key, data)` wrappers handle localStorage + trigger `cloudSave()`

## App Tabs
1. **My Tasks** — personal tasks with recurrence, timers, priority
2. **Projects** — browse/manage project codes and metadata
3. **Team Deliverables** — cross-team task assignments with ownership and status
4. **Timesheet** — time entries per project, actual vs estimated hours
5. **Allocations** — monthly workload allocation per person/project

## Key Data Structures

### localStorage keys
- `wt_tasks` — personal task array
- `wt_team` — team deliverables array
- `wt_bigprojs` — big projects (multi-session/subtask structures)
- `wt_completed` — archive of completed items
- `wt_projects_meta` — project definitions (label, color, billingCode, subCodes, tags)
- `wt_persons` — team member list
- `wt_allocations` — monthly capacity allocations

### Task object
`{ id, name, project, subCode, priority, due, est, category, waiting, notes, recurrence, timer, timerStart, completed }`

### Team item object
`{ id, name, owner, owners[], project, subCode, due, status, waiting, notes }`

### Project metadata
`{ label, color, billingCode, subCodes[], tags[] }`

## Conventions
- **IDs**: `uid()` = `'_' + Math.random().toString(36).slice(2, 11)`
- **Statuses**: `need-delegate`, `in-progress`, `ready-review`, `in-review`, `blocked`, `complete`
- **Priorities**: `urgent`, `high`, `med`, `low`
- **Billing codes**: format like `T-21-010`, `W-24-022`
- **Themes**: dark/light via `data-theme` attribute, CSS variables in `:root`
- **Render pattern**: `render*()` functions rebuild UI from state
- **Internal composite objects**: `_type` prefix (`task`, `session`, `team`) with `_date`, `_src`, `_delegated` fields
