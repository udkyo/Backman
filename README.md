# Backup Manifest

Downloads and zips projects listed in a source gerrit manifest.

### Prerequisites

This project uses Python 3, there are no additional dependencies.

### Usage

Make the script executable, then trigger `backup-manifest [src] [dest]` where src is a manifest uri, and dest is the target archive name

```
chmod +x backup-manifest
./backup-manifest https://example.com/default.xml ./output.zip
```

### Information/Notes

I initially considered using a shell script before starting with Python, but from past experience parsing xml fromt the shell is a headache and I didn't want to just blindly sed/awk/etc my way through the text as that would put me in a position where I'd either be manually tracking comments as they open and close, or risk accidentally cloning repositories which were commented out. Better to use a real XML parser in Python.

The instructions specified that the **repos** should be added to the zip, so I didn't isolate the specified revisions (with e.g. `git archive`) or paths, and instead simply clone the repo and check out the specified revision (or master if no revision is present)

The dockerfile isn't very fancy, for production code I'd be creating a user within the image and mapping the PID/GID of the executing user so the output zip could be created into a mounted volume with correct user/group attributes, however docker was only used here for basic testing on Alpine/CentOS/Ubuntu.

Speaking of which, this script has been tested on:

- Alpine
- CentOS
- Pop!OS
- Ubuntu
- Mac OS.

I'm sure with more time I'd iterate on this and change it in a number of ways, notably:

- Unit tests: Conspicuous in their absence. I intended to add tests before sending, but I'm at the high end of the time range allocated already, que cera.

- Logging: I worked on the assumption that both streaming and writing unstructured log data was fine for the purpose of a small script which is only going to be running in a jenkins job, but clearly if this were part of a more complex system it would be good to make the logs easier to ingest and analyze.

Anyway, thank you for the opportunity, this was fun! I hope to speak with you again soon.
