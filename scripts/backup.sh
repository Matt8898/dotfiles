#!/bin/bash
rm /home/matt/lb1
sshfs root@192.168.0.126:/backup/matt ~matt/backup
sudo mount /dev/sdb1 ~matt/backup
rsync -aAX --verbose /home/matt/wp ~matt/backup/wp
rsync -aAX --verbose /home/matt/Immagini ~matt/backup/Immagini
rsync -aAX --verbose /home/matt/projects/ ~matt/backup/Musica/
rsync -aAX --verbose /home/matt/projects/ ~matt/backup/projects/
rsync -aAX --verbose /home/matt/scripts/ ~matt/backup/scripts/
rsync -aAX --verbose /home/matt/Documenti/ ~matt/backup/Documenti
rsync -aAX --verbose /home/matt/video/ ~matt/backup/video
rsync -aAX --verbose /home/matt/ROMs/ ~matt/backup/ROMs/
rsync -aAX --verbose /home/matt/.pcsxr/memcards ~matt/backup/PS1
rsync -aAX --verbose /home/matt/.config/pcsx2/memcards ~matt/backup/PS2
rsync -aAX --verbose /home/matt/.snes9x/ ~matt/backup/snes/
rsync -aAX --verbose /home/matt/.dolphin-emu/Wii/ ~matt/backup/WII/
bell
