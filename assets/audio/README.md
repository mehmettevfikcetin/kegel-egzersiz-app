# Timer cue audio

Place short sound files here, referenced by `lib/core/utils/audio_cues.dart`:

- `squeeze.mp3` — played at the start of a squeeze/contract phase
- `hold.mp3`    — played at the start of a hold phase
- `release.mp3` — played at the start of a release phase
- `rest.mp3`    — played at the start of a rest phase
- `done.mp3`    — played when a session completes

Keep them short (< 1s) and royalty-free. Until real files are added, the
`AudioCues` service silently no-ops on missing assets so the app still runs.
