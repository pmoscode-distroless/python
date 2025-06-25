# distroless

This distroless-template repository enables you to create your own 
small, specialized, hardened and ready to use Docker images for 
Docker, Kubernetes, ...

## Usage

There are two things you have to configure, when you create 
your repository based on this template:

1. edit the content of "distroless-config" file
2. create versions of your desired Docker images

Here is how:

### 1. Edit the "distroless-config" file

The content of the file looks like this:

```dotenv
ARTIFACT_NAME=
TAG=DEV
DH_ORGANIZATION=
GH_ORGANIZATION=
GH_REPOSITORY=
```

You need to set the values:

- ARTIFACT_NAME → The name of your image (ex. python, node, ...)
- DH_ORGANIZATION → The organization/username of the target Dockerhub account (is needed for the pipeline only) 
- GH_ORGANIZATION → Your GitHub organization name or just the username
- GH_REPOSITORY → Your GitHub repository name

"GH_ORGANIZATION", "TAG" and "GH_REPOSITORY": GitHub Actions will determine these for you, but if you want to run it locally, you need them set.

### 2. Create a version

To start working, you need a version (ex. node-18, node-20, ...).
When you have installed [Taskfile](https://taskfile.dev/), 
you can call `task add -- <your-version>` to add a new version.

Ans also, if you want to replace the template Readme.md with an own one, use `task init`.

Ex.: `task add -- 3.12` if you want to add version 3.12 for python.

If you don't have Taskfile installed, you need to copy the folder `.template/version` to `apko/<your-version>`, where `<your-version>` is "20" for nodejs or 3.12 for python3.

## Final configuration

Everything is configured for a good minimal base image. 
Tho only thing you have to add, is your desired package.

In your added `version` folder, you will find these files:

- apko-config.yaml
- debug.yaml
- nondebug.yaml

"debug.yaml" and "nondebug.yaml" are the starting point for the Taskfile (build and publish).
But you need to modify the file "apko-config.yaml":

Here you have to replace `<your-packages-here>` and `<your-base-command-here>`

- `<your-packages-here>`: Add the packages you need for your image. 
    You will find the packages you can use [here](https://github.com/wolfi-dev/os) (Clone it, the repo has to many folders and files)
- `<your-base-command-here>`: The entrypoint of your image (ex. /usr/bin/python3)

## Modification

Of course, you can modify every apko config. See the docs [here](https://github.com/chainguard-dev/apko/blob/main/docs/apko_file.md),
 [here](https://github.com/chainguard-dev/apko/tree/main) and [here for deeper insights](https://edu.chainguard.dev/)
