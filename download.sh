name="name.tmp"
album="album.tmp"
echo "Installing id3v2, need permission."
sudo apt-get install id3v2

for i in $(seq 12555)
do
   wget -nc -O Songs/$i.mp3 http://link.songspk.name/song.php?songid=$i

   id3v2 -R Songs/$i.mp3 | grep "TALB" | sed -r 's/^.{6}//' >$album
   id3v2 -R Songs/$i.mp3 | grep "TIT2" | sed -r 's/^.{6}//' > $name
   alb=$(cat $album)
   
   if ["$alb" == ""];then
      alb="Uncategorized"           
   fi
   
   nam=$(cat $name)
   mkdir -p "Pretty/$alb"

   if [ ! -f "Pretty/$alb/$nam.mp3" ]; then
      mv Songs/$i.mp3 "Pretty/$alb/$nam".mp3
   else
      mv Songs/$i.mp3 "Pretty/$alb/$i".mp3
   fi
done


