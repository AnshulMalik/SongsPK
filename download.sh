name="name.tmp"
album="album.tmp"

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
      cp Songs/$i.mp3 "Pretty/$alb/$nam".mp3
   else
      cp Songs/$i.mp3 "Pretty/$alb/$i".mp3
   fi
done


