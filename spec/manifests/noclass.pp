        nrpe_command{'check_mysqldump':
          command    => 'check_file_age',
          parameters => '-f /srv/backup/mysql/mysql.dump -w 86400 -c 90000 -W 8000 -C 8000'
        }
