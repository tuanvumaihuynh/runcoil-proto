# runcoil-proto

The protobuf schema of the [Runcoil](https://github.com/tuanvumaihuynh/runcoil)
protocol, with its generated Go code. It describes the calls between a worker
SDK and the server, and between a caller and the server. Managed with
[Buf](https://buf.build).

**Status: pre-release.** Field names and numbers may change before version 1.0.

- `proto/runcoil/v1/` — the schema: `common`, `worker` (`WorkerService`), `runs` (`RunService`).
- `gen/runcoil/v1/` — generated messages, package `runcoilv1`, committed.
- `gen/runcoil/v1/runcoilv1connect/` — generated [ConnectRPC](https://connectrpc.com) clients and handlers.

| Service | Calls | Used by |
| --- | --- | --- |
| `runcoil.v1.RunService` | `Invoke`, `GetRun`, `WaitRun`, `ListRuns`, `Rerun`, `ListTasks` | Callers |
| `runcoil.v1.WorkerService` | `Register`, `Listen`, `Heartbeat`, `AckDispatch`, `RecordStep`, `FinishRun` | Worker SDKs |

Import paths:

```go
import (
	runcoilv1 "github.com/tuanvumaihuynh/runcoil-proto/gen/runcoil/v1"
	"github.com/tuanvumaihuynh/runcoil-proto/gen/runcoil/v1/runcoilv1connect"
)
```

## Make targets

- `make lint` — `buf lint` (STANDARD rules).
- `make format` — `buf format -w` rewrites the `.proto` files.
- `make generate` — `buf generate` rewrites `gen/`. Run it after every schema change.
- `make check` — lint, format check, generate, `go build ./...`, `go vet ./...`.
- `make actionlint` — actionlint on `.github/workflows/`.

Buf and the protoc plugins run through `go run` at the versions pinned in the
`Makefile` (`BUF_VERSION`) and `buf.gen.yaml`; nothing is installed globally.
Keep the plugin versions equal to the `google.golang.org/protobuf` and
`connectrpc.com/connect` requirements in `go.mod`.
