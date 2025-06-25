# distroless-python

## Usage

```dockerfile
FROM python:3.12-slim-bookworm as requirements-stage

WORKDIR app

COPY requirements.txt /
RUN pip install --disable-pip-version-check -r /requirements.txt


FROM pmoscode/python-3.12-nondebug:dev

COPY --from=requirements-stage /usr/local/lib/python3.12/site-packages /usr/lib/python3.12/

COPY --chown=nonroot:nonroot app/ .

CMD [ "-m", "<module-name>" ]
```

# Configuration

## Default

| property             | value             |
|----------------------|-------------------|
| default user / group | nonroot / nonroot |
| working dir          | /app              |
| arch                 | amd64 / arm64     |

## Additional

| property   | value            |
|------------|------------------|
| entrypoint | /usr/bin/python3 |

## Used packages

- wolfi-base (for debug variant)
- wolfi-baselayout (for nondebug variant)
- python-[3.11|3.12|3.13]

## Image versioning

| name     | description                     | purpose                           |
|----------|---------------------------------|-----------------------------------|
| "dev"    | Triggered by push or manual run | current development version       |
| "nighly" | Triggered by scheduled run      | Always the latest libs (Wolfi OS) |
| semver   | Triggered by Git tag            | Fixed version (may be outdated)   |
