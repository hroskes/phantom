#!/usr/bin/perl
#
# Script to create directories, input files and BATCH-run files for all
# processes in PHANTOM
# USES:
# array process_input which contains in each element a string with the set of
# particles, all outgoing, separated by spaces.
# Particles are          d  u  s  c  b  e   ve  mu  vm  g
# Antiparticles are      d_ u_ s_ c_ b_ e_  ve_ mu_ vm_ g
# The leptons now DO APPEAR in directory names.
#
# Help is available entering:
# perl setupdir.pl -h
#


# DEFAULT DIRECTORIES AND FILES
$dirtreeroot_def = "mh0";
$basedir_def = "./";
$input_template_def = "r.in";
$executefile_def = "phantom.exe";
$inputstring_def="";
$quark_def="0";
$Top_def="-1";
$batch_def="slow";
$VVscatt_def="false";
$Hsig_def="false";
$mail_def="$ENV{'USER'}";

#INITIALIZATION TO GET RID OF WARNING MESSAGES
$basedir="";
$dirtreeroot="";
$executefile="";
$input_template="";
$inputstring="";
$quark="";
$Top="";
$system="";
$batch="";
$queue="";
$VVscatt="";
$Hsig="";
$mail="";

# PARSE COMMAND OPTIONS

while ( $_ = $ARGV[0]) {
	shift;
	last if (/^--$/);
	if    (/^-b/)		{ $basedir = &get_option("-basedir");	} 
	elsif (/^-d/)		{ $dirtreeroot = &get_option("-dirtreeroot");	}
        elsif (/^-e/)           { $executefile = &get_option("-executable");   }
        elsif (/^-t/)           { $input_template = &get_option("-template");   }
        elsif (/^-i/)           { $inputstring = &get_option("-inputstring");   }
        elsif (/^-q/)           { $quark = &get_option("-nquark");   }
        elsif (/^-T/)           { $Top = &get_option("-Top");   }
        elsif (/^-s/)           { $system = &get_option("-system");   }
        elsif (/^-n/)           { $queue = &get_option("-name");   }
        elsif (/^-m/)           { $mail = &get_option("-mail");   }
        elsif (/^-S/)           { $VVscatt="true"}
        elsif (/^-Hs/)          { $Hsig="true"}
	elsif (/^-h/)		{ &usage("help")	} 
	elsif (/^[a-zA-Z]*/)    { 
	  print "can't specify more then one target!" if ($dirtreeroot ne "");
	}
	else 		        { print "unknown argument";          }
	
}

if ($basedir eq ""){ $basedir=$basedir_def;}
if ($dirtreeroot eq ""){ $dirtreeroot=$dirtreeroot_def;}
if ($executefile eq ""){ $executefile=$executefile_def;}
if ($input_template eq ""){ $input_template=$input_template_def;}
if ($inputstring eq ""){ $inputstring=$inputstring_def;}
if ($quark eq ""){$quark=$quark_def;}
if ($Top eq ""){$Top=$Top_def;}
if ($system eq ""){die "\nERROR: The target batch system MUST be specified.
Allowed values are:\nSGE: Torino\nLSF: Cern\nCONDOR: Condor\n\nSLURM: MARCC";}
if ($VVscatt eq "") {$VVscatt=$VVscatt_def}
if($Hsig eq "") {$Hsig=$Hsig_def}

# check that $quark is an even integer
if ( $quark !~ /\d+/  || $quark>10 || $quark !~/2|4|6|8|10/ ) {
die "nquark = $quark: must be an even integer > 0 and <= 10:\n"
    }
    
$npart=$quark/2;
#print "npart ,$npart,\n";

$range="no";
if ( $Top =~ /\+$/ ){
    chop($Top);
    $range="yes";
    }

#print "Top $Top**\n";
#print "range $range\n";

# STANDARD FILES
$inputfilename = "r.in";
if($system eq "SGE"){
  $BATCHfilename = "SGEfile";
  $runfilename = "run";}
elsif($system eq "LSF"){
  $BATCHfilename = "LSFfile";
  $runfilename = "run";}
elsif($system eq "CONDOR"){
  $BATCHfilename = "CONDORfile";
  $runfilename = "condor.sub";}
elsif($system eq "SLURM"){
  $BATCHfilename = "SLURMfile";
  $runfilename = "run";}
else{die "ERROR:Unallowed batch system. Valid entries are SGE LSF CONDOR SLURM"}

# BASIC DEFINITIONS

%pdgnumber = (  
     "d" => 1, "u" => 2, "s" => 3, "c" => 4, "b" => 5,
     "d_" => -1, "u_" => -2, "s_" => -3, "c_" => -4, "b_" => -5, 
     "e" => 11, "ve" => 12 , "mu" => 13, "vm" => 14, "tau" => 15, "vt" => 16,
     "e_" => -11, "ve_" => -12 , "mu_" => -13, "vm_" => -14,
     "tau_" => -15, "vt_" => -16, "g" => 21
     );
                 
                 
%antiparticle = ( 
     "d" => "d_", "u" => "u_", "s" => "s_", "c" => "c_", "b" => "b_",              
     "d_" => "d", "u_" => "u", "s_" => "s", "c_" => "c", "b_" => "b", 
     "e" => "e_", "ve" => "ve_" , "mu" => "mu_", "vm" => "vm_",
     "tau" => "tau_", "vt" => "vt_",
     "e_" => "e", "ve_" => "ve" , "mu_" => "mu", "vm_" => "vm",
     "tau_" => "tau", "vt_" => "vt",
     "g" => "g" );


%famconjg = (  
     "d" => "s", "u" => "c", "s" => "d", "c" => "u", "b" => "b",
     "d_" => "s_", "u_" => "c_", "s_" => "d_", "c_" => "u_" , "b_" => "b_",
     "e" => "e", "ve" => "ve" , "mu" => "mu", "vm" => "vm",
     "tau" => "tau", "vt" => "vt",
     "e_" => "e_", "ve_" => "ve_" , "mu_" => "mu_", "vm_" => "vm_",
     "tau_" => "tau_", "vt_" => "vt_",
     "g" => "g",
     );
     

%charge = (  
     "d" => -1, "u" => 2, "s" => -1, "c" => 2, "b" => -1,
     "d_" => 1, "u_" => -2, "s_" => 1, "c_" => -2, "b_" => 1, 
     "e" => -3, "ve" => 0, "mu" => -3, "vm" => 0, "tau" => -3, "vt" => 0,
     "e_" => 3, "ve_" => 0, "mu_" => 3, "vm_" => 0,
     "tau_" =>  3, "vt_" => 0, "g" => 0
     );

%e_number = (                 
     "e" => 1, "ve" => 1, "e_" => -1, "ve_" => -1
         );
%mu_number = (                 
     "mu" => 1, "vm" => 1, "mu_" => -1, "vm_" => -1
         );
%tau_number = (                 
     "tau" => 1, "vt" => 1, "tau_" => -1, "vt_" => -1
         );
%u_number = (                 
     "d" => 1, "u" => 1, "d_" => -1, "u_" => -1
         );
%c_number = (                 
     "s" => 1, "c" => 1, "s_" => -1, "c_" => -1
         );

%Wpartner = ( 
     "d" => "u_", "u" => "d_", "s" => "c_", "c" => "s_",              
     "e" => "ve_", "ve" => "e_" , "mu" => "vm_", "vm" => "mu_",
     "tau" => "vt_", "vt" => "tau_",
     "d_" => "u", "u_" => "d", "s_" => "c", "c_" => "s",              
     "e_" => "ve", "ve_" => "e" , "mu_" => "vm", "vm_" => "mu",
     "tau_" => "vt", "vt_" => "tau"
            );


# Clean input string from extra whitespace
#print " original:||$inputstring","||\n";
$inputstring =~ s/^\s+//;      # whitespace at the beginning
$inputstring =~ s/\s+$//;      # whitespace at the end
$inputstring =~ s/\s+/ /g;     # collapse internal whitespace 
#print " cleaned:||$inputstring","||\n";

# Parse input string
@partinput = split(/ /,$inputstring);

# check that only leptons and gluons appear in the input string
foreach (@partinput){
   if ( $_ !~ /^e$|e_|mu|mu_|^g$|tau|tau_|ve|ve_|vm|vm_|vt|vt_/) {
      die "symbol $_ in input:  only leptons and gluons allowed\n";
      }
    }


# Initialize group array
$groups_key = "0";
# Add input particles
foreach (@partinput){
           $pdgcontent{$_}++;
	           }

foreach $ib (reverse 0 .. $npart){
  foreach $ic (reverse 0 .. $npart-$ib){
    foreach $is (reverse 0 .. $npart-$ib-$ic){
      foreach $iu (reverse 0 .. $npart-$ib-$ic-$is){
# Generate antiparticle content
#        print "ib_,$ib_,\n";
        foreach $ic_ (reverse 0 .. $npart-$ib_){
          foreach $is_ (reverse 0 .. $npart-$ib_-$ic_){
            foreach $iu_ (reverse 0 .. $npart-$ib_-$ic_-$is_){
#  print "ib,$ib\n";
  $pdgcontent{b}=$ib;
  $ib_=$ib;                       # Must have same number of b and b_
  $pdgcontent{b_}=$ib_;
    $pdgcontent{c}=$ic;
      $pdgcontent{s}=$is;
        $pdgcontent{u}=$iu;
	$id=$npart-$ib-$ic-$is-$iu;
        $pdgcontent{d}=$id;

          $pdgcontent{c_}=$ic_;
            $pdgcontent{s_}=$is_;
              $pdgcontent{u_}=$iu_;
              $id_=$npart-$ib_-$ic_-$is_-$iu_;
              $pdgcontent{d_}=$id_;

# Check if group is kosher
     $totcharge="0";
     $tot_e_number="0";
     $tot_mu_number="0";
     $tot_tau_number="0";
     $tot_u_number="0";
     $tot_c_number="0";
     foreach (keys %pdgcontent){
        $totcharge += $charge{$_}*$pdgcontent{$_};
        $tot_e_number += $e_number{$_}*$pdgcontent{$_};
        $tot_mu_number += $mu_number{$_}*$pdgcontent{$_};
        $tot_tau_number += $tau_number{$_}*$pdgcontent{$_};
        $tot_u_number += $u_number{$_}*$pdgcontent{$_};
        $tot_c_number += $c_number{$_}*$pdgcontent{$_};
     }
# If kosher and not equivalent to an already accepted one, record group
     if ($totcharge == 0 &&
         $tot_e_number == 0 &&
	 $tot_mu_number == 0 &&
	 $tot_tau_number == 0 &&
	 $tot_u_number == 0 &&
	 $tot_c_number == 0
	 ){
# check if equivalent to one of the accepted groups	 
my (%pdgcontent_cc,%pdgcontent_fam,%pdgcontent_cc_fam);
     foreach (keys %pdgcontent){
          $pdgcontent_cc{$antiparticle{$_}} = $pdgcontent{$_};	 
          $pdgcontent_fam{$famconjg{$_}} = $pdgcontent{$_};	 
          $pdgcontent_cc_fam{$antiparticle{$famconjg{$_}}} = $pdgcontent{$_};
	                       }	 

       $found="false";

GROUP:       foreach $key (keys %groups){

          $equal="true";
KEY_CC:	    foreach (keys %pdgcontent_cc){
	          if ( $pdgcontent_cc{$_} ne $groups{$key}{$_} ){
		       $equal="false";
		       last KEY_CC;
		       }
		    }
	    if ( $equal eq "true" ){
	      $found="true";
	      last GROUP;
	      }
          $equal="true";
KEY_FAM:    foreach (keys %pdgcontent_fam){
	          if ( $pdgcontent_fam{$_} ne $groups{$key}{$_} ){
		       $equal="false";
		       last KEY_FAM;
		       }
		    }
	    if ( $equal eq "true" ){
	      $found="true";
	      last GROUP;
	      }
          $equal="true";
KEY_CC_FAM: foreach (keys %pdgcontent_cc_fam){
	          if ( $pdgcontent_cc_fam{$_} ne $groups{$key}{$_} ){
		       $equal="false";
		       last KEY_CC_FAM;
		       }
		    }
	  if ( $equal eq "true" ){
	      $found="true";
	      last GROUP;
	      }
                        }    # end of foreach (@groups)

# if not record group
       if ($found eq "false"){
#             print "accepted:\n";
	     $groups_key++;
	     if ($groups_key < 10) {
	        $groups_label="00".$groups_key;}
	     elsif ($groups_key < 100) {
	        $groups_label="0".$groups_key;}
	     else {
	        $groups_label=$groups_key;}
		
	     
             foreach (sort keys %pdgcontent){
	        $groups{$groups_label}{$_} = $pdgcontent{$_};
		    }
                  }  
		  
		}            # end of check on kosherness

            }                      # end of $iu_ loop
          }                      # end of $is_ loop
        }                      # end of $ic_ loop

      }                      # end of $iu loop
    }                      # end of $is loop
  }                      # end of $ic loop
}                       # end of $ib loop

#print "++++++++++++++++++++++++++++++++++++++++++++++++++++++\n";
#     foreach $groups_key (sort keys %groups){
#        print "$groups_key =  ";
#          foreach $key (sort keys %{ $groups{$groups_key} } ){
#	    print "$key:$groups{$groups_key}{$key} ";
#	    } print "\n";
#        }
	
# PrettyPrint to @processes_input

     foreach $groups_key (sort keys %groups){
          $totpart="0";
#
          foreach $key ( keys %{ $groups{$groups_key} } ){
	    $totpart += $groups{$groups_key}{$key} ;
	    };
	  @list=();
#
	  while ($totpart){
# gluons first
	     while ( $groups{$groups_key}{g} ){
	       push @list,"g";
	       $groups{$groups_key}{g}--;
	       $totpart--;
	       }
# Z hadronic pairs
             $nz1=$nz2="0";
             foreach ("d","u","s","c","b"){
	       while ( $groups{$groups_key}{$_} && 
	               $groups{$groups_key}{$antiparticle{$_}} ){
	         push @list,($_,$antiparticle{$_});
	         $groups{$groups_key}{$_}--;
		 $groups{$groups_key}{$antiparticle{$_}}--;
	         $totpart-=2;
		 if ($_ eq "u" || $_ eq "d"){
		    $nz1++;}
		 else{
		    $nz2++;}
	         }
	      }
# W hadronic pairs
             $nw1=$nw2="0";
             foreach ("d","u","s","c"){
	       while ( $groups{$groups_key}{$_} && 
	               $groups{$groups_key}{$Wpartner{$_}} ){
	         push @list,($_,$Wpartner{$_});
	         $groups{$groups_key}{$_}--;
		 $groups{$groups_key}{$Wpartner{$_}}--;
	         $totpart-=2;
		 if ($_ eq "u" || $_ eq "d"){
		    $nw1++;}
		 else{
		    $nw2++;}
	         }
	      }
# Z leptonic pairs
             foreach ("e","mu","tau","ve","vm","vt"){
	       while ( $groups{$groups_key}{$_} && 
	               $groups{$groups_key}{$antiparticle{$_}} ){
	         push @list,($_,$antiparticle{$_});
	         $groups{$groups_key}{$_}--;
		 $groups{$groups_key}{$antiparticle{$_}}--;
	         $totpart-=2;
	         }
	      }
# W leptonic pairs
             foreach ("e","mu","tau","ve","vm","vt"){
	       while ( $groups{$groups_key}{$_} && 
	               $groups{$groups_key}{$Wpartner{$_}} ){
	         push @list,($_,$Wpartner{$_});
	         $groups{$groups_key}{$_}--;
		 $groups{$groups_key}{$Wpartner{$_}}--;
	         $totpart-=2;
	         }
	      }
#
            }       # $key

# try to improve consistency checking how many 1st and 2nd generation W's
# and Z's appears and possibly family conjugating
        if ( $nw1 > $nw2 ) {
#	print "list1w: @list \n";
	@list1=();
	foreach (@list) {
	    push @list1, $famconjg{$_};
	    }
	@list = @list1;
#	print "list2w: @list \n";
	    }

	else{
           if ($nw2 == 0 && $nz1 > $nz2 ) {
#	   print "list1z: @list \n";
	   @list1=();
	   foreach (@list) {
	       push @list1, $famconjg{$_};
	       }
	   @list = @list1;
#	   print "list2z: @list \n";
	       }
	  }
	   
	$string= join " ",@list;
#	print "$string\n";
	push @processes_input,$string ;
#
     }              # $groups_key
	



# FIND PROCESSES

@process_list = ();
@process_idplist = ();
                   
foreach $proc (@processes_input){
@part = split(/ /,$proc);
$length = $#part;
#print "+++++++++++++++++++++++++++++++++++++++++++\n";
#print "string= $proc\n";
#print "+++++++++++++++++++++++++++++++++++++++++++\n";
#print "$proc becomes_$part[0]_x_$part[1]_xxx_$part[5]\n";
#print "last element of array has label $length\n";


my %pdgcontent;

  foreach (@part){$pdgcontent{$_}++}

# CHECK IF PROCESS IS FAMILY SELF CONJUGATED

     $if_famconjg="false";
     if( $pdgcontent{u} == $pdgcontent{c} &&  
         $pdgcontent{u_} ==  $pdgcontent{c_}  &&       
         $pdgcontent{d} ==  $pdgcontent{s}  &&       
         $pdgcontent{d_} ==  $pdgcontent{s_}        
        ) {$if_famconjg="true"}
#     print "proc $proc\n";
#     print "pdgcont $pdgcontent{d} $pdgcontent{s}\n";
#     print "pdgcont $pdgcontent{u} $pdgcontent{c}\n";
#     print "pdgcont $pdgcontent{d_} $pdgcontent{s_}\n";
#     print "pdgcont $pdgcontent{u_} $pdgcontent{c_}\n";
#     print " if_famconjg $if_famconjg \n";
     
# CHECK IF PROCESS IS CHARGE SELF CONJUGATED
                 
     $if_cc_conjg="false";
     if( $pdgcontent{d} == $pdgcontent{d_} &&
         $pdgcontent{u} == $pdgcontent{u_} &&  
         $pdgcontent{s} == $pdgcontent{s_} &&        
         $pdgcontent{c} == $pdgcontent{c_} &&       
         $pdgcontent{b} == $pdgcontent{b_} &&       
         $pdgcontent{e} == $pdgcontent{e_} &&       
         $pdgcontent{ve} == $pdgcontent{ve_} &&       
         $pdgcontent{mu} == $pdgcontent{mu_} &&       
         $pdgcontent{vm} == $pdgcontent{vm_} &&       
         $pdgcontent{tau} == $pdgcontent{tau_} &&       
         $pdgcontent{vt} == $pdgcontent{vt_}        
        ) {$if_cc_conjg="true"}

# CHECK IF PROCESS IS CHARGE+FAMILY SELF CONJUGATED

     $if_cc_fam_conjg="false";
     if( $pdgcontent{d} == $pdgcontent{s_} &&
         $pdgcontent{u} == $pdgcontent{c_} &&  
         $pdgcontent{s} == $pdgcontent{d_} &&        
         $pdgcontent{c} == $pdgcontent{u_} &&       
         $pdgcontent{b} == $pdgcontent{b_} &&       
         $pdgcontent{e} == $pdgcontent{e_} &&       
         $pdgcontent{ve} == $pdgcontent{ve_} &&       
         $pdgcontent{mu} == $pdgcontent{mu_} &&       
         $pdgcontent{vm} == $pdgcontent{vm_} &&       
         $pdgcontent{tau} == $pdgcontent{tau_} &&       
         $pdgcontent{vt} == $pdgcontent{vt_}        
        ) {$if_cc_fam_conjg="true"}

@in_state=();
for(my $i1=0;$i1 < $length;$i1++){
#print "string= $proc\n";
  @partlocal = @part;
  $first = $antiparticle{splice(@partlocal,$i1,1)};
                                # @partlocal shortened by one element
#print "first = $first\n";
#print "$partlocal['$i1'] is now in position $i1\n";
  for(my $i2=$i1;$i2 < $length;$i2++){
    @partlocal2 = @partlocal;
    $second = $antiparticle{splice(@partlocal2,$i2,1)};
                                         # @partlocal2 now contains
                                         # the final state in split form
#print "second = $second\n";
 
    unless( abs($pdgnumber{$first}) > 6 && abs($pdgnumber{$first}) < 18)
    {
      unless( abs($pdgnumber{$second}) > 6 && abs($pdgnumber{$second}) <18)
      { 
 
    $state1 = $first.$second;
    $state2 = $second.$first;
# CHECK FOR CHARGE CONJUGATION 
    if($if_cc_conjg eq "true"){
      $state3 = $antiparticle{$second}.$antiparticle{$first};
      $state4 = $antiparticle{$first}.$antiparticle{$second};
      }
     else{
       $state3 = " "; 
       $state4 = " ";
          } 
# CHECK FOR FAMILY CONJUGATION 
    if($if_famconjg eq "true"){
       $state5 = $famconjg{$second}.$famconjg{$first}; 
       $state6 = $famconjg{$first}.$famconjg{$second};
       }
     else{
       $state5 = " "; 
       $state6 = " ";
          } 
# CHECK FOR FAMILY CONJUGATION AND CHARGE+FAMILY
###    if($if_famconjg eq "true" && $if_cc_conjg eq "true"){
    if($if_cc_fam_conjg eq "true"){
       $state7 = 
         $famconjg{$antiparticle{$second}}.$famconjg{$antiparticle{$first}};
       $state8 = 
         $famconjg{$antiparticle{$first}}.$famconjg{$antiparticle{$second}};
       }
     else{
       $state7 = " "; 
       $state8 = " ";
          } 

#print "first initial state : $state1\n";
#print "second initial state: $state2\n";
    $found = "false";
OLDPROC:    foreach $state (@in_state){
#print "check if found: $state\n";
      if(       $state eq $state1 || $state eq $state2
             || $state eq $state3 || $state eq $state4
             || $state eq $state5 || $state eq $state6
             || $state eq $state7 || $state eq $state8
             ){
           $found = "true";
	   last OLDPROC;
	       }
           }

# Top filter on final state
     if($Top > -1 && $found eq "false"){
            my %pdgcontent;
            foreach (@partlocal2){$pdgcontent{$_}++}
            if($pdgcontent{b}+$pdgcontent{b_} < $Top){
                 $found = "true";
#                 print "partlocal @partlocal2\n";
#                 print "discarded\n";
#                 print "=============================================================\n";
                 }
            else{
# Count W+
              $nwp="0";
              foreach("u","c","ve","vm","vt"){
                if($pdgcontent{$_}>$pdgcontent{$Wpartner{$_}}){
                  $nwp+=$pdgcontent{$Wpartner{$_}}}
                else{
                  $nwp+=$pdgcontent{$_}
                  }
                 }
# min(nW+,nb)=nt
               if($pdgcontent{b}>$nwp){
                  $ntop=$nwp}
               else{
                  $ntop=$pdgcontent{b}
                   }
# Count W-            
              $nwm="0";
              foreach("d","s","e","mu","tau"){
                if($pdgcontent{$_}>$pdgcontent{$Wpartner{$_}}){
                  $nwm+=$pdgcontent{$Wpartner{$_}}}
                else{
                  $nwm+=$pdgcontent{$_}
                  }
                 }
# min(nW-,nb_)=nt_
               if($pdgcontent{b_}>$nwm){
                  $ntop_=$nwm}
               else{
                  $ntop_=$pdgcontent{b_}
                   }
# if(ntop+ntop_ != $ntop fail
            if($range eq "no" && $ntop+$ntop_ != $Top){$found = "true"}
            if($range eq "yes" && $ntop+$ntop_ < $Top){$found = "true"}
            
#            print "partlocal @partlocal2\n";
#            print "nwp $nwp\n";
#            print "nwm $nwm\n";
#            print "ntop $ntop\n";
#            print "ntop_ $ntop_\n";
#            print "found $found\n";
#            print "=============================================================\n";
            }
       }  # End of top filter

# VV scattering filter
     if($VVscatt eq "true" && $found eq "false"){
       my %pdgcontent;
       foreach (@partlocal2){$pdgcontent{$_}++}
       if($first eq "g" || $second eq "g" || $pdgcontent{g}>0){$found = "true"}
       if($Wpartner{$first} eq $second || $antiparticle{$first} eq $second){
          # Only if the initial state corresponds to a W or a Z it is possible to NOT have VV scattering
          unless($pdgcontent{$first}+$pdgcontent{$antiparticle{$Wpartner{$first}}}>0 
            && $pdgcontent{$second}+$pdgcontent{$antiparticle{$Wpartner{$second}}}>0){$found = "true"}
        }
      } # end of VV scattering filter

# Higgs signal filter
     if($Hsig eq "true" && $found eq "false"){
       my %pdgcontent;
       foreach (@partlocal2){$pdgcontent{$_}++}
       if($first eq "g" || $second eq "g" || $pdgcontent{g}>0){$found = "true"}
  # Check if initial particles can be connected to final ones by lines which can emit a ZZ or W+W- pair
       $ZZtag="false";
       if($first eq $second){
        if($pdgcontent{$first}>1){$ZZtag="true";}
       }
       else{
        if($pdgcontent{$first}>0 && $pdgcontent{$second}>0){$ZZtag="true";}
       }
       $WWtag="false";
       if($charge{$first}*$charge{$second}<0){
        if($pdgcontent{$antiparticle{$Wpartner{$first}}}>0 && 
                $pdgcontent{$antiparticle{$Wpartner{$second}}}>0){$WWtag="true";}
       }
        if($ZZtag eq "false" && $WWtag eq "false" ){
          $found = "true"
        }
      } # end of Higgs signal filter

    if($found eq "false"){
       push @in_state,$state1;
       $string = $state1."-";
       $string .= join "",@partlocal2;
#print "reaction:  $string\n";
# I want the reactions with b's to appear first in the list
       if($string =~ /b/)
       {unshift @process_list,$string;}
       else
       {push @process_list,$string;}
#print "initial partlocal2 @partlocal2\n";
       unshift  @partlocal2, $first,$second;
       @process_idp=();
       foreach (@partlocal2) {
       push @process_idp, $pdgnumber{$_};
                             }
       $idp = "  ";
       $idp .=  join " ",@process_idp;
       $process_idplist{$string} = $idp;
#print "process: @partlocal2\n";
#print "idp: $idp\n";
        }
       }  # end of unless
      }  # end of unless
     }    # end of loop on $i2
   }      # end of loop on $i1
}        # end of loop on group list


# CREATE ROOT DIRECTORY OF THE TREE (If necessary)

system("mkdir $dirtreeroot") unless -d $dirtreeroot;

# CREATE BATCH SUBMISSION FILE

$submitfile = $dirtreeroot."/".$BATCHfilename;
open(BATCHFILE,"> $submitfile");

print BATCHFILE "\#!/bin/bash\n\n";

# CREATE SUBDIRECTORIES AND INPUT/RUN FILES

foreach $dirname (@process_list){
# Add basedir and dirtreeroot
#    $name = $basedir."/".$dirtreeroot."/".$dirname;
    $name = $dirtreeroot."/".$dirname;
#print "attemping creation of $name\n";
    system("mkdir $name");
# Write process idp's in real input file
    open(WRITEFILE,"> $name/$inputfilename");
    print WRITEFILE "****** IF (IONESH.EQ.0) THEN\n";
    print WRITEFILE "*  CALL iread('iproc',iproc,8)    ! process\n";
#    $idp_string = shift @process_idp;
    $idp_string = $process_idplist{$dirname};
#print "idpstring: $idp_string\n";
    print WRITEFILE "iproc  $idp_string\n";
    print WRITEFILE "****** ENDIF\n\n";
# copy input template into real input file
    $remember = $/;                       # Note current record separator
    $/ = undef;                           # Ignore newline characters
    open(FILE,"$input_template") || die "Can't open file: $!\n";
                                        # open file if possible
    $_ = <FILE>;                          # Load entire file into matchspace
    close(FILE);
    print WRITEFILE $_;
    $/ = $remember;                       # Recognise separator again
    close(WRITEFILE);

if($system eq "SGE" || $system eq "LSF"){
# create run file
    open(WRITEFILE,"> $name/$runfilename");
    print WRITEFILE "\#!/bin/csh\n\n";
    print WRITEFILE "cd $dirtreeroot/$dirname\n";
    print WRITEFILE "rm *.dat\n";
    print WRITEFILE "echo \$HOSTNAME\n";
    print WRITEFILE "touch running\n";
    print WRITEFILE "date\n";
    print WRITEFILE "unbuffer $basedir/$executefile\n";
    print WRITEFILE "mv running finished\n";
    print WRITEFILE "date\n";
    close(WRITEFILE);
    }
if($system eq "SLURM"){
# create run file
    open(WRITEFILE,"> $name/$runfilename");
    print WRITEFILE "\#!/bin/csh\n\n";
    print WRITEFILE "#SBATCH --job-name=$dirname\n";
    print WRITEFILE "#SBATCH --time=48:0:0\n";
    print WRITEFILE "#SBATCH --nodes=1\n";
    print WRITEFILE "#SBATCH --ntasks-per-node=1\n";
    print WRITEFILE "#SBATCH --partition=$queue\n";
    print WRITEFILE "#SBATCH --mem=24000\n";
    print WRITEFILE "#SBATCH --mail-type=end\n";
    print WRITEFILE "#SBATCH --mail-user=$mail\n";
    print WRITEFILE "\n";

    print WRITEFILE "cd $dirtreeroot/$dirname\n";
    print WRITEFILE "rm *.dat\n";
    print WRITEFILE "echo \$HOSTNAME\n";
    print WRITEFILE "touch running\n";
    print WRITEFILE "date\n";
    print WRITEFILE "unbuffer $basedir/$executefile\n";
    print WRITEFILE "mv running finished\n";
    print WRITEFILE "date\n";
    close(WRITEFILE);
    }
elsif($system eq "CONDOR"){
# create condor.sub file
    open(WRITEFILE,"> $name/$runfilename");
    print WRITEFILE "Executable = $basedir/$executefile\n\n";
    print WRITEFILE "should_transfer_files = YES\n";
    print WRITEFILE "when_to_transfer_output = ON_EXIT_OR_EVICT\n";
    print WRITEFILE "initialdir = $name\n";
    print WRITEFILE 
    "transfer_input_files = $basedir/../lhapdf-5.2.2/PDFsets/cteq5l.LHgrid,";
    print WRITEFILE  "$name/r.in\n\n";
    print WRITEFILE "Universe = vanilla\n";
    print WRITEFILE "Requirements = (Arch == \"INTEL\") && (OpSys == \"LINUX\")\n";
    print WRITEFILE "output =$name/run.out\n";
    print WRITEFILE "log    =$name/log\n";
    print WRITEFILE "err    =$name/err\n";
    print WRITEFILE "Queue 1\n";
    close(WRITEFILE);
    }
    
# add submission lines into BATCH  file
if($system eq "SGE"){
     print BATCHFILE "subcheck  $dirtreeroot/$dirname    $runfilename   $queue\n";}
elsif($system eq "LSF"){
    print BATCHFILE "bsub -q $queue -u pippopluto -o $dirtreeroot/$dirname/$runfilename.out";
    print BATCHFILE " -J $dirname";
    print BATCHFILE " < $dirtreeroot/$dirname/$runfilename\n";
    }
elsif($system eq "SLURM"){
    print BATCHFILE "sbatch -o $dirtreeroot/$dirname/$runfilename.out -e $dirtreeroot/$dirname/$runfilename.out";
    print BATCHFILE " -J $dirname";
    print BATCHFILE " $dirtreeroot/$dirname/$runfilename\n";
    }
else{
    print BATCHFILE "condor_submit  $name/$runfilename\n";}
   
   }   # End of: foreach $dirname (@process_list){

# close BATCH submission file
close(BATCHFILE);

# SET PERMISSIONS
    system " chmod +x $submitfile";


exit 0;



# SUBROUTINES

sub get_option {
	&usage("missing argument for $_[0]") if ($#ARGV==-1) ;
	$result = $ARGV[0];
	shift @ARGV;	 
	return $result;
}


sub usage {
  local($mess) = @_;

  print "setupdir.pl: $mess\n\n";

  print <<"_EOF_";
usage:  perl setupdir.pl [-options ...] 

where options include:                                    Defaults -
    -basedir      directory which contains the exe file   
                    (full pathname).                       
    -dirtreeroot  root of new tree (full pathname).        
    -template     input template file.                     r.in
    -executable   executable file.                         phantom.exe
    -inputstring  must contain only leptons and gluons     ""
                  must be enclosed in double quotes: "e e_ mu vm_".
    -quarks       number of quarks to be inserted
                  (even integer > 0 to get a total of 8 particles with
                   the ones given in inputstring).
    -Top          number of top/antitop quarks required in the
                  final state. If the option is not set any number of
                  tops is accepted. If the option is of the form
                  n+ with n an integer any reaction with at least
                  n tops are accepted.
    -system       batch system. Allowed values are:
                  SGE: Torino
                  LSF: Cern
                  CONDOR: condor
                  SLURM: MARCC
    -name        name of the batch queue:
                  SGE: slow
                  LSF: 8nm, 8nh, 1nd, 2nd, 1nw, 2nw
                  SLURM: shared
    -mail        for SLURM, email address to send to when finished
                  (default: $USER)
    -S            if this flag is present only processes which include
                  VV scattering diagrams are generated.
    -Hs           if this flag is present only processes which include
                  diagrams with an s-channel Higgs produced in VV fusion
                  are generated.
    -help         prints usage details.                      -
long options can be abbreviated up to one letter.

Possible exit codes:
           0 - normal, success           1 - bad arguments (usage)
           2 - interrupted               
_EOF_

 exit 1;
}

# end  
