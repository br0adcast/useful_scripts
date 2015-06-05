#!/bin/bash

all_git_files=($(git ls-files))

for f in "${all_git_files[@]}"; do
    if [ -f ${f} ]; then
        if [ ${f: -4} == ".cpp" -o ${f: -2} == ".h" ]; then
            file_author=$(git log --reverse --pretty=format:"%an <%ae>" ${f} | head -n1)
            echo "${file_author} : ${f}"
            sed -i -e "1i/**\n * @author ${file_author}\n */\n" ${f}
        fi
    fi
done

echo "done"
