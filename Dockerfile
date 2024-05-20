FROM ghcr.io/makedeb/makedeb-beta:ubuntu-noble as builder

WORKDIR /tmp/notion
COPY . .
RUN makedeb --sync-deps --no-confirm

# ---------------------------------------------------------------------
FROM scratch as export
COPY --from=builder /tmp/notion/*.deb .