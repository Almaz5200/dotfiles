#!/bin/bash
for file in $(ls playbooks); do
	echo "Hash for $file is $(sha256sum playbooks/$file)"
done
