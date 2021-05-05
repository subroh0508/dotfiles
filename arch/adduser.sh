USER_NAME=$1
USER_PASSWD=$2

# Add user
useradd -m -g ${USER_NAME}
echo "${USER_PASSWD}\n${USER_PASSWD}\n" | passwd ${USER_NAME}
echo "%wheel ALL=(ALL) ALL" | EDITOR="tee -a" visudo

