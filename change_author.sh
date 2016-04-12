git filter-branch -f --commit-filter '
        if [ "$GIT_COMMITTER_NAME" = "devtype-blogspot-com" ];
        then
                GIT_COMMITTER_NAME="DEVTYPE";
                GIT_AUTHOR_NAME="DEVTYPE";
                GIT_COMMITTER_EMAIL="Informatik.on.GitHub@gmail.com";
                GIT_AUTHOR_EMAIL="Informatik.on.GitHub@gmail.com";
                git commit-tree "$@";
        else
                git commit-tree "$@";
        fi' HEAD
