

rsconnect::deployApp(".")


GIT SETUP
=========
https://atornblad.se/use-a-different-user-account-for-each-git-repo#:~:text=When%20you%20find%20yourself%20in,and%20for%20your%20personal%20projects.

git remote add origin git@github.com:andrewcharles/etna.git
git config --local user.name 'ac'
git config --local user.email 'ac1201@gmail.com'
cat ~/.ssh/id_rsa_gitbash.pub
git config --local core.sshcommand 'ssh -i ~/.ssh/id_rsa_gitbash -F /dev/null'
git push --set-upstream origin master
