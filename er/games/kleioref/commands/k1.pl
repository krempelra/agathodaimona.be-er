#!/usr/local/bin/perl
open (LIST,"item.txt");
#Creating the introsite
open (KLEIO,">index.htm");
open (COM,">com.htm");
open (MAIN,">main.htm");
#make a list of the commandnames
$line = <LIST>;
while ($line ne ""){
   chop $line;
   if ($line =~ /<command>/){
       $line = <LIST>; 
       chop $line;
       if ($line =~ /<name>/){
          $line =~ s/<[^>]*>//g;
          $line =~ s/\s//g;
          push (@klist,$line);
       }#endif ($line =~ /<name>
   }#end
   $line = <LIST>;
   chop $line;
}#endwhile ($line ne
close (LIST);
print KLEIO "<html>\n";
print KLEIO "<HEAD>\n";
print KLEIO "<TITLE>Kleio<\/TITLE>\n";
print KLEIO "<\/HEAD>\n";
print KLEIO "<FRAMESET COLS=\"15%, \*\" BORDER=4>\n";
print KLEIO "<BASE TARGET=\"_top\">\n";
print KLEIO "<FRAME SRC=\"com.htm\">\n";
print KLEIO "<FRAME SRC=\"main.htm\">\n";  
print KLEIO "<\/FRAMESET>\n";
print KLEIO "<body bgcolor=\"\#ffffff\">\n";
print KLEIO "<\/BODY>\n";
print KLEIO "<\/HTML>\n";
close(KLEIO);

print COM "<html><head>\n";
print COM "<title>Commands<\/title>\n";
print COM "<\/head><body bgcolor=\"\#ffffff\"><p>\n";
print COM "<p><a href=\"..\/..\/\" target=\"_top\">\n";
print COM "<img src=\"logo2.gif\" border=0><\/a><p>\n";
foreach $i(@klist){
   chop;
   print COM '<a href="',$i,'/" target ="_top">',$i,"</a><br>\n";
}#end
print COM "<\/body><\/html>\n";
close (COM);

print MAIN "<html><HEAD>\n";
print MAIN "<TITLE>Intro<\/TITLE>\n";
print MAIN "<\/HEAD>\n";
print MAIN "<body bgcolor=\"\#ffffff\">Introduction\n";
print MAIN "<\/BODY>\n";
print MAIN "<\/HTML>\n";
close (MAIN);

#I make a dir for each name and create a framepage
foreach $i(@klist){
   chop;
   $i =~ s/\s//g;
   mkdir("$i",0777);
   open (IND,">$i\/index.htm");
   open (PAR, ">$i\/parlist.htm");
   print IND "<html>\n";
   print IND "<HEAD>\n";
   print IND "<TITLE>",$i,"<\/TITLE>\n";
   print IND "<\/HEAD>\n";
   print IND "<FRAMESET COLS=\"15%, *\" BORDER=4>\n";
   print IND "<BASE TARGET=\"_top\">\n";
   print IND "<FRAME SRC=\"parlist.htm\">\n";
   print IND "<FRAMESET ROWS=\"40%, *\">\n";
   print IND "<FRAME SRC=\"disc.htm\">\n";
   #print IND "<FRAMESET COLS=\"20%, *\">\n";
   print IND "<FRAME SRC=\"partext.htm\" name=\"part\">\n";
   #print IND "<\/FRAMESET>\n";
   print IND "<\/FRAMESET>\n";
   print IND "<\/FRAMESET>\n";
   print IND "<body bgcolor=\"\#ffffff\">\n";
   print IND "<\/BODY>\n";
   print IND "<\/HTML>\n";
   close IND;
   open (PT,">$i\/partext.htm");
   print PT "<html>\n";
   print PT "<HEAD>\n";
   print PT "<TITLE>Description<\/TITLE>\n";
   print PT "<\/HEAD><body bgcolor=\"\#ffffff\">\n";
   print PT "Choose a parameter!\n";
   print PT "<\/BODY><\/HTML>\n";
   close (PT);
   open (TEXT,">$i\/disc.htm")||die("could not open $i");
   print TEXT "<html>\n";
   print TEXT "<HEAD>\n";
   print TEXT "<TITLE>Description<\/TITLE>\n";
   print TEXT "<\/HEAD><body bgcolor=\"\#ffffff\">\n";
   open (LIST,"item.txt");
   @list = <LIST>;
   $list = join("",@list);
   @list = split(/<\/command>/,$list);
   foreach $j(@list){
      $j =~ s/\n//g;
      $cont = $j;
      $cont =~ s/.*<contextlist>//;
      $cont =~ s/<\/contextlist>.*//;
      #print $cont,"\n***\n";
      if ($j !~ /<contextlist>/){
           $cont = "";
      }
      $j =~ s/<contextlist>.*<\/contextlist>//;
      #print $j;
      $navn = $j;
      $navn =~ s/<command>\s*//;
      $navn =~ s/[^<name>]*<name>//;
      $navn =~ s/<\/name>.*//;
      $navn =~ s/\s*//g;
      push (@navn,$j); 
      
      if ($navn eq $i){
        
         $type = $j;
         $type =~ s/.*<type>//;
         $type =~ s/<\/type>.*//;
         $type =~ s/\s*//;
         $type =~ s/\s*^//;
         $status = $j;
         $status =~ s/.*<status>//;
         $status =~ s/<\/status>.*//;
         $status =~ s/\s*//;
         $status =~ s/\s*^//;
         $general = $j;
         $general =~ s/.*<general>//;
         $general =~ s/<\/general>.*//;
         $general =~ s/\s*//;
         $general =~ s/\s*^//;
         print TEXT "<p>Name: ",$navn,"\n";
         print TEXT "<p>Type: ",$type,"\n";
         print TEXT "<p>Status: ",$status,"\n";
         print TEXT "<p>General: ",$general,"\n";
         if ($cont ne ""){
            print TEXT "<a href=\"cont.htm\" target=\"_blank\">\n";
            print TEXT "<p>Directives.<\/a>\n";
         }
         print TEXT "<\/BODY>\n";
         print TEXT "<\/HTML>\n";
         close (TEXT);
         open (CONT, ">$i\/dir.htm");
         print CONT "<html>\n";
         print CONT "<HEAD>\n";
         print CONT "<TITLE>Contexts<\/TITLE>\n";
         print CONT "<\/HEAD>\n";
         print CONT "<FRAMESET COLS=\"15%, \*\" BORDER=4>\n";
         print CONT "<BASE TARGET=\"_top\">\n";
         print CONT "<FRAME SRC=\"contlist.htm\">\n";
         print CONT "<FRAME SRC=\"conttext.htm\" name=\"cont\">\n";  
         print CONT "<\/FRAMESET>\n";
         print CONT "<body bgcolor=\"\#ffffff\">\n";
         print CONT "<\/BODY>\n";
         print CONT "<\/HTML>\n";
         close(CONT);
         open (CONTLIST, ">$i\/contlist.htm" );
         print CONTLIST "<html>\n";
         print CONTLIST "<HEAD>\n";
         print CONTLIST "<TITLE>Contexts<\/TITLE>\n";
         print CONTLIST "<\/HEAD>\n";
         print CONTLIST "<body bgcolor=\"\#ffffff\">\n";
         print CONTLIST "<p><a href=\"..\/\" target=\"_top\">\n";
         print CONTLIST "<img src=\"..\/logo2.gif\" border=0><\/a>\n";
         print CONTLIST "<p><b>$i, contexts:</b>\n";
         
         print PAR "<html>\n";
         print PAR "<HEAD>\n";
         print PAR "<TITLE>Parameters<\/TITLE>\n";
         print PAR "<\/HEAD><body bgcolor=\"\#ffffff\">\n";
         print PAR "<p><a href=\"..\/\" target=\"_top\">\n";
         print PAR "<img src=\"..\/logo2.gif\" border=0><\/a><p>\n";
         print PAR "<b>Parameters<\/b><p>\n";
         $par = $j;
         $par =~ s/[^<parameterlist>]*<parameterlist>//;
         $par =~ s/<\/parameterlist>[^<\/parameterlist>]*//;
         @par = split(/<\/parameter>/,$par);
         foreach $k(@par){
            $pn = $k;
            $pn =~ s/.*<name>//;
            $pn =~ s/<\/name>.*//;
            #print $pn,"\n";
            $href = $pn;
            $href = $href.".htm";
            print PAR "<a href=\"$href\" target=\"part\">\n";
            print PAR $pn,"<\/a><br>\n";
            $pd = $pn.".htm";
            $pd1 = $pn."1.htm";
            $pd2 = $pn."2.htm";
            $pd3 = $pn."3.htm";
            open (PD,">$i\/$pd");
            print PD "<html>\n";
            print PD "<HEAD>\n";
            print PD "<TITLE>$i,$pd<\/TITLE>\n";
            print PD "<\/HEAD>\n";
            print PD "<FRAMESET ROWS=\"40%, *\" BORDER=2>\n";
            print PD "<FRAME SRC=\"$pd1\"> \n";
            print PD "<FRAMESET COLS=\"20%, *\">\n";
            print PD "<FRAME SRC=\"$pd2\">\n";  
            print PD "<FRAME SRC=\"$pd3\" name=\"w3\">\n";
            print PD "<\/FRAMESET>\n";
            print PD "<\/FRAMESET>\n";
            print PD "<body bgcolor=\"\#ffffff\">\n";
            print PD "<\/BODY>\n";
            print PD "<\/HTML>\n";
            open (PD1,">$i\/$pd1");
            open (PD2,">$i\/$pd2");
            open (PD3,">$i\/$pd3");
            print PD1 "<html>\n";
            print PD1 "<HEAD>\n";
            print PD1 "<TITLE>Parameterdescription<\/TITLE>\n";
            print PD1 "<\/HEAD><body bgcolor=\"\#ffffff\">\n";
            print PD1 "<b>Parameter <br>$pn</b>\n";
            print PD1 "<p>Name: ",$pn,"\n";
            $pt = $k;
            $pt =~ s/.*<parametertype>//;
            $pt =~ s/<\/parametertype>.*//;
            print PD1 "<p>Type: ",$pt,"\n";
            print PD1 "<\/BODY>\n";
            print PD1 "<\/HTML>\n";
            $pk = $k;
            $pk =~ s/.*<keywordlist>//;
            $pk =~ s/<\/keywordlist>.*//;
            @pk = split(/<\/keyword>/,$pk);
            print PD2 "<html>\n";
            print PD2 "<HEAD>\n";
            print PD2 "<TITLE>Parameterarguments<\/TITLE>\n";
            print PD2 "<\/HEAD><body bgcolor=\"\#ffffff\">\n";
            print PD3 "<html>\n";
            print PD3 "<HEAD>\n";
            print PD3 "<TITLE>Parameterarguments<\/TITLE>\n";
            print PD3 "<\/HEAD><body bgcolor=\"\#ffffff\">\n";
            print PD2 "<b>Arguments<\/b><br>\n";
            print PD2 "<b>for $pn<\/b>\n";
            foreach $j(@pk){
               @j = split(/<\/keyword>/,$j);
               foreach $l(@j){
               #print $l,"\n\n";
                 if ($l=~ /<keyword>/){
                   $l =~ s/<keyword>\s*(\S*).*/\1/;
                   $arg = $pn.$l;
                   $arg = $arg.".html";
                   $arg =~ s/\s//g;
                   $arg =~ s/\n//g;
                   if ($arg =~ /\S/){
                     print PD2 "<a href=\"$arg\" target=\"w3\">";
                     print PD2 $l, "<\/a><br>\n";
                   }#endif ($arg =~ /\S/){
                   print PD2 "<\/BODY>\n";
                   print PD2 "<\/HTML>\n"; 
                   open (LAST, ">$i\/$arg");
                   print LAST "<html>\n";
                   print LAST "<HEAD>\n";
                   print LAST "<TITLE>Parameterarguments<\/TITLE>\n";
                   print LAST "<\/HEAD><body bgcolor=\"\#ffffff\">\n";
                   print LAST $l,"<br>\n";
                   print LAST "<\/BODY><\/HTML>\n";
                  

                  }#endif($l=~ /<keyword/
                  close(LAST);
               }#endforeach $l(@j){
             }#endforeach $j(@pk){
          }#endforeach $k(@par){
          print PAR "<\/body><\/html>\n";
             close (PAR);
             close (PD);
             close (PD1);
             close (PD2);
             close (PD3);
           if ($cont ne ""){ 
            $contdesc = $cont;
            $contdesc =~ s/.*<contextdescription>//;
            $contdesc =~ s/<\/contextdescription>.*//;
            open (CONTTEXT, ">$i\/conttext.htm" );
            print CONTTEXT "<html>\n";
            print CONTTEXT "<HEAD>\n";
            print CONTTEXT "<TITLE>Contexts<\/TITLE>\n";
            print CONTTEXT "<\/HEAD>\n";
            print CONTTEXT "<body bgcolor=\"\#ffffff\">\n";
            print CONTTEXT "<p>",$i,": <br>",$contdesc,"\n";
            print CONTTEXT "<\/BODY><\/HTML>\n";
            $cont =~ s/.*<\/contextdescription>//;
            @cont = split(/<\/context>/,$cont);
            foreach $c(@cont){
               $contnavn = $c;
               $contnavn =~ s/[^<context>]*<context>//;
               $contnavn =~ s/[^<name>]*<name>//;
               $contnavn =~ s/<\/name>.*//;
               $contnavn =~ s/\s*//g;
               push (@CONTLIST,$contnavn);
               $conthref = $contnavn.".htm";
               print CONTLIST "<br><a href=\"",$dirhref,"\" target=\"_top\">\n";
               print CONTLIST $contnavn,"<\/a>\n";
               print CONTLIST "<\/BODY><\/HTML>\n";
               $c =~ s/\n//;
               $contd = $contnavn."d.htm";
               $contt = $contnavn."p.htm";
               open (NEWC,">$i\/$contnavn.htm");
               print NEWC "<HEAD>\n";
                   print NEWC "<TITLE>$contnavn<\/TITLE>\n";
                   print NEWC "<\/HEAD>\n";
                   print NEWC "<FRAMESET COLS=\"15%, *\" BORDER=4>\n";
                   print NEWC "<BASE TARGET=\"_top\">\n";
                   print NEWC "<FRAME SRC=\"contlist.htm\">\n";
                   print NEWC "<FRAMESET ROWS=\"40%, *\">\n";
                   print NEWC "<FRAME SRC=\"$contd\">\n";
                   print NEWC "<FRAME SRC=\"$contt\">\n";  
                   print NEWC "<\/FRAMESET>\n";
                   print NEWC "<body bgcolor=\"\#ffffff\">\n";
                   print NEWC "<\/BODY>\n";
                   print NEWC "<\/HTML>\n";
                   open (CONTD,">$i\/$contd");
                   print CONTD "<TITLE>$contnavn<\/TITLE>\n";
                   print CONTD "<\/HEAD><body bgcolor=\"\#ffffff\">\n";
                   
                   print CONTD "<b>$contnavn<\/b>\n";
                   $dstatus = $d;
                   $dstatus =~ s/.*<status>//;
                   $dstatus =~ s/<\/status>.*//;
                   $dstatus =~ s/\s*//;
                   $dstatus =~ s/\s*^//;
                   #print $dstatus,"\n***\n";
                   $dgeneral = $d;
                   $dgeneral =~ s/.*<general>//;
                   $dgeneral =~ s/<\/general>.*//;
                   $dgeneral =~ s/\s*//;
                   $dgeneral =~ s/\s*^//;
                   #print $dgeneral,"\n????\n";
                   print DIRD "<p>Status: ",$dstatus,"\n";
                   print DIRD "<p>General: ",$dgeneral,"\n";
                   print DIRD "<\/BODY><\/HTML>\n";
                   close (DIRD);
                   open (DIRP,">$i\/$dirp");
                   print DIRP "<TITLE>$dirnavn<\/TITLE>\n";
                   print DIRP "<\/HEAD><body bgcolor=\"\#ffffff\">\n";
                   print DIRP "<b>Parameters<\/b>\n";
                   $dpar = $d;
                   $dpar =~ s/.*<parameterlist>//;
                   $dpar =~ s/<\/parameterlist>.*//;
                   @dpar = split(/<\/parameter>/,$dpar);
                   foreach $k(@dpar){
                      $dpn = $k;
                      $dpn =~ s/.*<name>//;
                      $dpn =~ s/<\/name>.*//;
                      $dhref = $dpn;
                      $dhref = $dhref."d.htm";
                      if ($dpn =~ /\S/){
                        print DIRP "<a href=\"$dhref\" target=\"dpart\">\n";
                        print DIRP $dpn,"<\/a><br>\n";
                      }#endif ($dpn =~ /\S/)
                      $dpd = $dpn."d.htm";
                      $dpd1 = $dpn."d1.htm";
                      $dpd2 = $dpn."d2.htm";
                      $dpd3 = $dpn."d3.htm";
                      open (DIRPT,">$i\/$dirpt");
                      print DIRPT "<html>\n";
                      print DIRPT "<HEAD>\n";
                      print DIRPT "<TITLE>Description<\/TITLE>\n";
                      print DIRPT "<\/HEAD><body bgcolor=\"\#ffffff\">\n";
                      print DIRPT "Choose a parameter!\n";
                      print DIRPT "<\/BODY><\/HTML>\n";
                      close (DIRPT);
                      open (DP,">$i\/$dhref");
                      print DP "<html>\n";
                      print DP "<HEAD>\n";
                      print DP "<TITLE>$dpn<\/TITLE>\n";
                      print DP "<\/HEAD>\n";
                      print DP "<FRAMESET ROWS=\"50%, *\" BORDER=2>\n";
                      print DP "<FRAME SRC=\"$dpd1\"> \n";
                      print DP "<FRAMESET COLS=\"20%, *\">\n";
                      print DP "<FRAME SRC=\"$dpd2\">\n";  
                      print DP "<FRAME SRC=\"$dpd3\" name=\"dw3\">\n";
                      print DP "<\/FRAMESET>\n";
                      print DP "<\/FRAMESET>\n";
                      print DP "<body bgcolor=\"\#ffffff\">\n";
                      print DP "<\/BODY>\n";
                      print DP "<\/HTML>\n";
                      close (DP);
                      #print $dpd1,"\n";
                      #print $dpd2,"\n";
                      #print $dpd3,"\n\n";
                      open (DP1,">$i\/$dpd1");
                      open (DP2,">$i\/$dpd2");
                      open (DP3,">$i\/$dpd3");
                      print DP1 "<html>\n";
                      print DP1 "<HEAD>\n";
                      print DP1 "<TITLE>Parameterdescription<\/TITLE>\n";
                      print DP1 "<\/HEAD><body bgcolor=\"\#ffffff\">\n";
                      print DP1 "<p>Name: ",$dpn,"\n";
                      $dpt = $k;
                      $dpt =~ s/.*<parametertype>//;
                      $dpt =~ s/<\/parametertype>.*//;
                      print DP1 "<p>Type: ",$dpt,"\n";
                      print DP1 "<\/BODY>\n";
                      print DP1 "<\/HTML>\n";
                      close(DP1);
                      $dpk = $k;
                      $dpk =~ s/.*<keywordlist>//;
                      $dpk =~ s/<\/keywordlist>.*//;
                      @dpk = split(/<\/keyword>/,$dpk);
                      print DP2 "<html>\n";
                      print DP2 "<HEAD>\n";
                      print DP2 "<TITLE>Parameterarguments<\/TITLE>\n";
                      print DP2 "<\/HEAD><body bgcolor=\"\#ffffff\">\n";
                      print DP3 "<html>\n";
                      print DP3 "<HEAD>\n";
                      print DP3 "<TITLE>Parameterarguments<\/TITLE>\n";
                      print DP3 "<\/HEAD><body bgcolor=\"\#ffffff\">\n";
                      print DP2 "<b>Arguments<\/b>\n";
                      foreach $j(@dpk){
                         @j = split(/<\/keyword>/,$j);
                         foreach $l(@j){
                            if ($l=~ /<keyword>/){
                              $l =~ s/<keyword>\s*(\S*).*/\1/;
                              $darg = $dpn.$l;
                              $darg = $darg.".html";
                              $darg =~ s/\s//g;
                              $darg =~ s/\n//g;
                              if ($darg =~ /\S/){
                                print DP2 "<a href=\"$darg\" target=\"dw3\">";
                                print DP2 $l, "<\/a><br>\n";
                              }#endif ($darg =~ /\S/)
                              print DP2 "<\/BODY>\n";
                              print DP2 "<\/HTML>\n"; 
                              open (DLAST, ">$i\/$darg");
                              print DLAST "<html>\n";
                              print DLAST "<HEAD>\n";
                              print DLAST "<TITLE>Parameterarguments<\/TITLE>\n";
                              print DLAST "<\/HEAD><body bgcolor=\"\#ffffff\">\n";
                              print DLAST $l,"<br>\n";
                              print DLAST "<\/BODY><\/HTML>\n";
                              close (DLAST);
                            }#endif($l=~ /<keyword/
                         }#endforeach $l(@j){
                      }#endforeach$j(@dpk
                      close(PD1);
                      close(PD2);
                      close(PD3);
                   }#endforeach $k(@dpar)
                  close (DIRP);
                }#endif ($c !~ /<identical/)
            }#endforeach $c(@cont)
           }#endif ($j =~ /<directivelist>
           print CONTLIST "<\/BODY><\/HTML>\n";
           close (CONTLIST);
         }#endif ($navn eq $i){
      
   }#endforeach $j(@list){
}#endforeach $i(@klist){
close (LIST);
exit 0;
