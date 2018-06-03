# zip.pl
# Author: Wraithnix
use Archive::Zip qw( :ERROR_CODES :CONSTANTS );
 
if (scalar(@ARGV) < 2){die "Zip.pl\nAuthor:Wraithnix\nUsage: zip.pl <c=create, x=extract> <filename> <files>\n";};
 
my $opt = shift(@ARGV);
my $ofile = shift(@ARGV);
 
# extract a zip file
if($opt=~/x/i){
print "Zip.pl\nAuthor:Wraithnix\n";
print "Extracting $ofile...\n";
$zip = Archive::Zip->new();
die 'Error reading zip file.' if $zip->read( $ofile ) != AZ_OK;
my @members = $zip->members();
foreach $element(@members)
{
  print "$element\n";
  $zip->extractMember($element);
}
print "Done!\n";
}
 
# create a zip file
if($opt=~/c/i){
print "Zip.pl\nAuthor:Wraithnix\n";
print "Creating $ofile...\n";
my $zip = Archive::Zip->new();
foreach my $memberName (map { glob } @ARGV)
{
     if (-d $memberName )
     {
    print "Adding $memberName\n";
          warn "Error adding directory $memberName\n"
               if $zip->addTree( $memberName, $memberName ) != AZ_OK;
     }
     else
     {
    print "Adding $memberName\n";
          $zip->addFile( $memberName )
               or warn "Error adding file $memberName\n";
     }
}
die 'Write error.' if $zip->writeToFileNamed( $ofile ) != AZ_OK;
print "Done!\n";
}